#define _GNU_SOURCE
#include <stdio.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <sys/sysinfo.h>
#include <pthread.h>
#include <string.h>

// Object structure for Producer Comsumer Queue .
typedef struct qitems {
    // start address of chunk to be read.
    unsigned char *address;
    // global index of this chunk.
    int chunkNum;
    //size of the chunk
    int chunkSize;
} qitem;

// Structure for compressed output array.
// Each chunk will create 1 compressed array which is stored here.
typedef struct outitems {
    char *compressedChunk;
    int len;
} oitem;

int globalPage = 0;
int totalChunks = 0;
int qLen = 9;
// flag to denote if producer is done.
int isComplete;
int numFull = 0, fillPtr = 0, usePtr = 0;
qitem *q;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t fill = PTHREAD_COND_INITIALIZER;
pthread_cond_t empty = PTHREAD_COND_INITIALIZER;
int numfiles;
oitem *output;
int chunkSz;

int ceiling(int num1, int num2) {
    return (num1/num2) + ((num1 % num2) != 0);
}

void put(qitem* qObj) {
    q[fillPtr] = *qObj;
    fillPtr = (fillPtr + 1) % qLen;
    numFull++;
}

qitem get() {
    qitem qObj = q[usePtr];
    usePtr = (usePtr + 1) % qLen;
    numFull--;
    return qObj;
}

// Method for producer thread which will read the memory map 
// of each file and distribute it into chunks to be compressed by consumer.
void* producer(void *argv){
    char ** filenames = (char **)argv;
    for(int i = 0;i<numfiles;i++){
        const char* file = filenames[i];
        // check for invalid files
        int fileDescrp = open(file, O_RDONLY);
        if (fileDescrp == -1){
            // printf("\n\"%s \" could not open\n",file);
            continue;
        }

        struct stat sbuf;
        int err = fstat(fileDescrp, &sbuf);
        if(err < 0){
            // printf("\n\"%s \" could not open\n",file);
            close(fileDescrp);
            exit(1);
        }
        size_t fSize = sbuf.st_size;
        int numChunks = ceiling(fSize, chunkSz);
        if (fSize == 0)continue;

        unsigned char* ptr = mmap(NULL, sbuf.st_size, PROT_READ , MAP_SHARED, fileDescrp, 0);
        if (ptr == MAP_FAILED){
            close(fileDescrp);
            exit(1);
        }

        close(fileDescrp);
        
        // Start from file start and create queue objects for each chunk.
        unsigned char* s = ptr;
        int loops = numChunks;
        for(int i = 0; i < loops; i++) {
            qitem* obj = (qitem*) malloc(sizeof(qitem));
            obj->address = s;
            // assign the index in output array to put result to.
            obj->chunkNum = globalPage;
            // assign the chunkSize
            // if file size is not a multiple of chunkSize, 
            //set last chunk size carefully.
            if(sbuf.st_size % chunkSz ==0){
                obj->chunkSize = chunkSz;
            }else{
                obj->chunkSize = (i==loops-1)? sbuf.st_size % chunkSz : chunkSz;
            }
            globalPage++;
            pthread_mutex_lock(&mutex);
            while (numFull == qLen){
                pthread_cond_wait(&empty, &mutex);
            }
            put(obj);
            pthread_cond_signal(&fill);
            pthread_mutex_unlock(&mutex);
            s += chunkSz;
        }
    }
    // wake all sleeping threads when done.
    pthread_mutex_lock(&mutex);
    isComplete = 1;
    pthread_cond_broadcast(&fill);
    pthread_mutex_unlock(&mutex);
    return NULL;
}

// Method for consumer thread to perform run length encoding for each chunk.
void* consumer(){
    pthread_mutex_lock(&mutex);
    int flag = (numFull !=0 || !isComplete );
    pthread_mutex_unlock(&mutex);
    while (flag) {
        pthread_mutex_lock(&mutex);
        while (numFull == 0 && !isComplete){
            pthread_cond_wait(&fill, &mutex);
        }
        if(numFull != 0) {
            qitem obj = get();
            pthread_cond_signal(&empty);
            pthread_mutex_unlock(&mutex);
            unsigned char* inbuf = obj.address;
            char* outbuf = malloc(obj.chunkSize*(sizeof(char) + sizeof(int)));
            char* outptr = outbuf;
            // perform RLE
            for(int i = 0; i < obj.chunkSize; i++) {
                char c = inbuf[i];
                if(c == '\0')
                    continue;
                int count  = 1;
                while(i+1 < obj.chunkSize && inbuf[i+1] == c){
                    count++;
                    i++;
                }
                *((int*)outptr) = count;
                outptr += sizeof(int);
                *((char*)outptr) = c;
                outptr += sizeof(char);
            }

            // Write the compressed output for this chunk.
            oitem* oObj = (oitem*)malloc(sizeof(oitem));
            oObj->len = (outptr-outbuf);
            oObj->compressedChunk =
            (char*) malloc((outptr-outbuf)*sizeof(char));
            
            memcpy(oObj->compressedChunk, outbuf, (outptr-outbuf)*sizeof(char));//, strlen(outbuf));
            output[obj.chunkNum] = *oObj;
            int unmap_result = munmap(inbuf, obj.chunkSize);

            // Unmap memory
            if(unmap_result != 0){
                printf("UnMapping Failed = %d\n", unmap_result);
                exit(1);
            }
        }else{
            pthread_mutex_unlock(&mutex);
        }
        pthread_mutex_lock(&mutex);
        flag = (numFull !=0 || !isComplete);
        pthread_mutex_unlock(&mutex);
    }
    return NULL;
}

// Method to compress run length encodings across chunk boundaries.
void compressOutput(oitem* output){
    int prevval = 0;
    char prevch = '\0';
    char* oldptr = output[0].compressedChunk;
    for(int i = 0;i<totalChunks;i++){
        oitem oObj = output[i];
        char* j = oObj.compressedChunk;
        while(j < oObj.compressedChunk + oObj.len ){
            int val = *((int*)j);
            j += sizeof(int);
            char ch = *((char*)j);
            j += sizeof(char);
            
            if(ch == prevch){
                val +=prevval;
                j-=5;
                // update the final compressed value
                *((int*)j) = val;
                j+=5;
            }else{
                if(prevch !='\0'){
                    fwrite(oldptr-5, 5, 1, stdout);
                }
            }
            prevch = ch;
            prevval = val;
            oldptr = j;
        }
    }
    fwrite(oldptr-5, 5, 1, stdout);
}

int main(int argc, char* argv[]){
    //Check if less than two arguments
    if (argc < 2){
        printf("pzip: file1 [file2 ...]\n");
        exit(1);
    }
    numfiles = argc -1;
    chunkSz = 10 * getpagesize();
    totalChunks = 0;
    // Find the total no. of chunks to get an estimate of output size.
    for(int i = 1;i <= numfiles; i++){
        const char* file = argv[i];
        int fileDescrp = open(file, O_RDONLY);
        if (fileDescrp == -1){
            // printf("\n\"%s \" could not open\n",file);
            continue;
        }
        struct stat st;
        fstat(fileDescrp, &st);
        totalChunks += ceiling(st.st_size, chunkSz);
        close(fileDescrp);
    }
    q = (qitem *) malloc(qLen * sizeof(qitem));
    output = (oitem *) malloc(totalChunks * sizeof(oitem));
    // create threads for producer and consumer.
    int numThreads = get_nprocs();
    pthread_t p, c[numThreads];
    pthread_create(&p, NULL, producer, argv + 1);
    for(int i = 0;i < numThreads; i++) {
        pthread_create(&c[i], NULL, consumer, argv + 1);
    }
    pthread_join(p, NULL);
    for(int i = 0;i < numThreads; i++){
        pthread_join(c[i], NULL);
    }
    //Compress final output
    compressOutput(output);
    return 0;
}