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
#include <math.h>
#include <string.h>

typedef struct qitems {
    unsigned char *address;
    int pageNum;
    int chunkSize;
} qitem;

typedef struct outitems {
    char *compressedChunk;
    int len;
} oitem;
int globalPage = 0;
int totalPages = 0;
int qLen = 9;
int isComplete;
int numFull = 0, fillPtr = 0, usePtr = 0;
qitem *q;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t fill = PTHREAD_COND_INITIALIZER;
pthread_cond_t empty = PTHREAD_COND_INITIALIZER;
int numfiles;
oitem *output;
int pageSz;

void put(qitem* qObj) {
    q[fillPtr] = *qObj;
    fillPtr = (fillPtr + 1) % qLen;
    numFull++;
}

qitem get() {
    qitem qObj = q[usePtr];
    usePtr = (usePtr + 1) % qLen;
    numFull--;
    // printf("numFull now %d\n", numFull);
    return qObj;
}

void* producer(void *argv){
    // printf("Starting producer %d\n", gettid());
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
        int numPages = ceil((fSize * 1.0) / pageSz);
        if (fSize == 0)continue;
        // printf("%ld\n", fSize);

        unsigned char* ptr = mmap(NULL, sbuf.st_size, PROT_READ , MAP_SHARED, fileDescrp, 0);
        if (ptr == MAP_FAILED){
            // printf("Mapping Failed\n");
            // printf("%d", errno);
            close(fileDescrp);
            // return 1;
            exit(1);
        }

        close(fileDescrp);
        
        unsigned char* s = ptr;
        int loops = numPages;
        for(int i = 0; i < loops; i++) {
            qitem* obj = (qitem*) malloc(sizeof(qitem));
            obj->address = s;//malloc(sizeof(char*));
            // memcpy(obj->address, s, sizeof(char*));
            //test above
            // printf("memory mapped address of %d page is %p\n",i,obj->address);
            obj->pageNum = globalPage;
            obj->chunkSize = (i==loops-1)? sbuf.st_size % pageSz:pageSz;
            // printf("%ld", sbuf.st_size);
            // printf("%d\n", obj->chunkSize);
            globalPage++;
            pthread_mutex_lock(&mutex);
            while (numFull == qLen){
                pthread_cond_wait(&empty, &mutex);
            }
            put(obj);
            pthread_cond_signal(&fill);
            pthread_mutex_unlock(&mutex);
            s += pageSz;
        }
    }

    
    pthread_mutex_lock(&mutex);
    isComplete = 1;
    pthread_cond_broadcast(&fill);
    pthread_mutex_unlock(&mutex);
    // printf("end of prod\n");
    return NULL;
}

void* consumer(){
    pthread_mutex_lock(&mutex);
    int flag = (numFull !=0 || !isComplete );
    // int done = 
    pthread_mutex_unlock(&mutex);
    // if(flag)printf("start consumer %d\n", gettid());
    while (flag) {
        // printf("**%d\n", gettid());
        pthread_mutex_lock(&mutex);
        while (numFull == 0 && !isComplete){
            // printf("waiting now %d\n", gettid());
            pthread_cond_wait(&fill, &mutex);
        }
        if(numFull != 0) {
            qitem obj = get();
            pthread_cond_signal(&empty);
            pthread_mutex_unlock(&mutex);

            // int itemn = 0;
            unsigned char* inbuf = obj.address;//malloc(sizeof());
            // printf("working on %d with address %p\n", obj.pageNum, obj.address);
            // update allocate size depending on input
            char* outbuf = malloc(obj.chunkSize*(sizeof(char)+sizeof(int)));
            char* outptr = outbuf;
            // Update loop variables later
            // printf("Before consumer loop\n");
            //TODO: CHECK THIS TODAY
            int items = 0;
            for(int i = 0; i < obj.chunkSize; i++) {
                char c = inbuf[i];
                if(c == '\0')
                    continue;
                // putcharm m(c);
                int count  = 1;
                while(i+1< obj.chunkSize && inbuf[i+1] == c){
                    count++;
                    i++;
                }
                if(i==obj.chunkSize)count++;
                *((int*)outptr) = count;
                outptr += sizeof(int);
                *((char*)outptr) = c;
                outptr += sizeof(char);
                items++;
                // printf("Printing   %d%c\n", count, c);
            }

            oitem* oObj = (oitem*)malloc(sizeof(oitem));
            oObj->len = (outptr-outbuf);//outbuf;
            oObj->compressedChunk = 
            (char*) malloc((outptr-outbuf)*sizeof(char));
            // (char*)malloc(sizeof(outbuf));
            // fwrite(outbuf, items, 5, stdout);
            // printf("\n");
            
            memcpy(oObj->compressedChunk, outbuf, (outptr-outbuf)*sizeof(char));//, strlen(outbuf));
            output[obj.pageNum] = *oObj;
            // fwrite(output[obj.pageNum], items, 5, stdout);
            // printf("\n");
            // Check when to unmap if needed
            int unmap_result = munmap(inbuf, obj.chunkSize);
            if(unmap_result != 0){
                printf("UnMapping Failed\n");
                exit(1);
            }
        }else{
            pthread_mutex_unlock(&mutex);
        }
        // printf("Done processing with consumer %d\n", gettid());
        pthread_mutex_lock(&mutex);
        flag = (numFull !=0 || !isComplete);
        pthread_mutex_unlock(&mutex);
    }
    // printf("end of consumer %d\n", gettid());
    return NULL;
}

void compressOutput(oitem* output){   
    // printf("Compressing \n");
    // char* finalptr;
    int prevval = 0;
    char prevch = '\0';
    char* oldptr;
    for(int i = 0;i<totalPages;i++){
        oitem oObj = output[i];
        char* j = oObj.compressedChunk;
        // printf("%d\n",*((int*)j));
        // printf("1 Mid Compressing i = %d\n", i);
        // check below condition
        while(j< oObj.compressedChunk + oObj.len ){
            int val = *((int*)j);
            j+=sizeof(int);
            // printf("val = %d\n", val);
            char ch = *((char*)j);
            // printf("ch = %c\n", ch);
            j+=sizeof(char);
            if(ch == prevch){
                val+=prevval;
                // printf("val now %d\n", val);
                j-=5;
                *((int*)j) = val;
                j+=5;
            }else{
                if(prevch !='\0'){
                    // printf("***************\n");
                    fwrite(oldptr-5, 5, 1, stdout);
                    // printf("\n");
                    // printf("***************\n");
                }
            }
            prevch = ch;
            prevval = val;
            oldptr = j;
            // printf("prev = %c  prevval = %d\n", prevch, prevval);
        }
        // printf("***************\n");
        
        // printf("\n");
        // printf("***************\n");
        // printf("\n");
    }
    fwrite(oldptr-5, 5, 1, stdout);
    // printf("End of Compressing \n");
}

int main(int argc, char* argv[]){
    // printf("hello\n" );
    //Check if less than two arguments
	if(argc<2){
		printf("pzip: file1 [file2 ...]\n");
		exit(1);
	}
    numfiles = argc -1;
    pageSz = 50*getpagesize();
    // printf("page size is %d\n",pageSz);
    totalPages = 0;
    for(int i = 1;i<=numfiles;i++){
        const char* file = argv[i];
        int fileDescrp = open(file, O_RDONLY);
        if (fileDescrp == -1){
            // printf("\n\"%s \" could not open\n",file);
            continue;
        }
        struct stat st; 
        fstat(fileDescrp, &st);
        totalPages += ceil((st.st_size * 1.0 )/pageSz);
        close(fileDescrp);
        // printf("total pages in %d is %d\n", i, totalPages);
    }
    q = (qitem *) malloc(qLen * sizeof(qitem)); 
    output = (oitem *) malloc(totalPages * sizeof(oitem));  
    int numThreads = get_nprocs(); 
    pthread_t p, c[numThreads];
    pthread_create(&p, NULL, producer, argv + 1);
    for(int i = 0;i<numThreads;i++) {
        pthread_create(&c[i], NULL, consumer, argv + 1);
    }
    pthread_join(p, NULL);
    for(int i = 0;i<numThreads;i++){
        pthread_join(c[i], NULL);
    }
    compressOutput(output);
    
    return 0;
}