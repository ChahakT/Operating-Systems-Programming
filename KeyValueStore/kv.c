#define _GNU_SOURCE
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<errno.h>
#define INITIAL_CAPACITY 10000

// Structure for database item.
typedef struct {
    int key;
    char* value;
} data;

// Structure for the key value store which stores all data.
typedef struct {
    int size;
    int capacity;
    data* arr;
} KeyValueStore;

// Function to print the key value store values.
void printAllStore(KeyValueStore* db){
    for(int i = 0; i < db->size; i++){
        printf("%d,%s\n", db->arr[i].key, db->arr[i].value);
    }
}

// Function for copying an array from one to another.
void copyArray(data* initial, data* final, int size){
    for(int i=0; i<size; i++){
        final[i].key = initial[i].key;
        final[i].value = initial[i].value;
    }
}

// Function to put a key in a key value store.
void putinStore(KeyValueStore* db, int key, char* value){
    if (db == NULL) {
        return;
    }
    if (db->size !=0 && db->size==db->capacity) {
        printf("Increasing size");
        db->capacity*=2;
        data* arrNew = malloc(db->capacity*sizeof(data));
        copyArray(db->arr, arrNew, db->capacity/2);
        free(db->arr);
        db->arr= arrNew;
    }
    // check if key is already present
    for (int i=0;i<db->size;i++) {
        if (db->arr[i].key == key) {
            db->arr[i].value = (char*)malloc(strlen(value) * sizeof(char));
            memcpy(db->arr[i].value, value, strlen(value)*sizeof(char));
            return;
        }
    }
    // else put a new key, value in the store.
    db->arr[db->size].key = key;
    db->arr[db->size].value = (char*)malloc(strlen(value) * sizeof(char));
    memcpy(db->arr[db->size].value, value, strlen(value)* sizeof(char));
    db->size++;
}

// Function to get a value from the store.
char* getFromStore(KeyValueStore* db, int key){
    for (int i=0; i<db->size; i++){
        if(db->arr[i].key == key){
            printf("%d,%s\n", db->arr[i].key, db->arr[i].value);
            return db->arr[i].value;
        }
    }
    return NULL;
}

// Function to delete a key value pair from the store.
int deleteKey(KeyValueStore* db, int key){
    for (int i=0; i<db->size; i++){
        if(db->arr[i].key == key){
            // shift all items ahead and reduce the size by 1.
            while(i < db->size -1){
                db->arr[i].key = db->arr[i+1].key;
                db->arr[i].value = db->arr[i+1].value;
                i++;
            }
            free(db->arr[db->size -1].value);
            db->size--;
            return 1;
        }
    }
    return 0;
}

// Function to clear the store.
void clearStore(KeyValueStore* db){
    if (db == NULL)return;
    for (int i=0; i<db->size; i++){
        db->arr[i].value = NULL;
    }
    db->size = 0;
}

// Function to initialize the store.
KeyValueStore* initializeStore() {
    KeyValueStore* db = malloc(sizeof(KeyValueStore));
    if(db == NULL) return NULL;
    db->size = 0;
    db->capacity = INITIAL_CAPACITY;
    db->arr = calloc(INITIAL_CAPACITY, sizeof(data));
    if (db->arr == NULL){
        free(db);
        return NULL;
    }
    return db;
}

// Main program
int main(int argc, char* argv[]) {
    if (argc < 2) return 0;
    FILE *fp;
    char *saveptr, *last, *k, *v, *testptr;
    char buff[255];
    KeyValueStore* db;
    db = initializeStore();
    fp = fopen("database.txt", "r");
    // read file and add to internal key value store data structure
    while(fp != NULL && fgets(buff, 255, fp) != NULL && db != NULL){
        if ((k = strtok_r(buff, ",", &saveptr)) != NULL && (v = strtok_r(NULL, ",", &saveptr)) != NULL) {
            v[strcspn(v, "\n")] = 0;
            db->arr[db->size].key = atoi(k);
            db->arr[db->size].value = calloc(strlen(v), sizeof(char));
            memcpy(db->arr[db->size].value, v, strlen(v)*sizeof(char));
            db->size++;
        }
    }
    int key;
    for (int i=1; i<argc; i++) {
        char* token = strtok_r(argv[i], ",", &saveptr);
        if (strcmp(token, "p") == 0){
            if((token = strtok_r(NULL, ",", &saveptr)) != NULL && 
            (v = strtok_r(NULL, ",", &saveptr)) != NULL &&
            (last = strtok_r(NULL, ",", &saveptr)) == NULL) {
                errno = 0;
                key = (int)strtol(token, &testptr, 10);
                if (errno != 0 || testptr == token){
                    printf("bad command\n");
                } else {
                    putinStore(db, key, v);
                }
            } else {
                printf("bad command\n");
            }
        } else if (strcmp(token, "g")==0){
            if ((token = strtok_r(NULL, ",", &saveptr)) != NULL &&
            (last = strtok_r(NULL, ",", &saveptr)) == NULL){
                errno = 0;
                int key = strtol(token, &testptr, 10);
                if (errno != 0 || testptr == token){
                    printf("bad command\n");
                } else {
                    char* value = getFromStore(db, key);
                    if (value == NULL) {
                        printf("%d not found\n", key);
                    }
                }
            } else {
                printf("bad command\n");
            }
        } else if(strcmp(token,"c")==0 && 
        (last = strtok_r(NULL, ",", &saveptr)) == NULL){
            clearStore(db);
        } else if (strcmp(token, "d") ==0) {
            if ((token = strtok_r(NULL, ",", &saveptr)) != NULL &&
            (last = strtok_r(NULL, ",", &saveptr)) == NULL){
                errno =0;
                int key = strtol(token, &testptr, 10);
                if (errno != 0 || testptr == token){
                    printf("bad command\n");
                } else {
                    int success = deleteKey(db, key);
                    if (success == 0) printf("%d not found", key);
                }
            } else{
                printf("bad command\n");
            }
        } else if(strcmp(token, "a")==0 && 
        (last = strtok_r(NULL, ",", &saveptr)) == NULL){
            // printf("Matcha\n");
            printAllStore(db);
        } else{
            printf("bad command\n");
        }
    }

    if (fp != NULL) {
        fclose(fp);
    }
    fp = fopen("database.txt", "w+");
    for(int i=0;i<db->size;i++){
        char num[100];
        sprintf(num, "%d", db->arr[i].key);
        strcat(num, ",");
        strcat(num, db->arr[i].value);
        strcat(num, "\n");
        fputs(num, fp);
    }
    if (fp != NULL) fclose(fp);
    return 0;
}
