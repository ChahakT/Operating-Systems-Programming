#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>
#define BUF_SIZE 1024

// Give this error when anything fails.
void printError() {
    char error_message[30] = "An error has occurred\n";
    write(STDERR_FILENO, error_message, strlen(error_message));
}

// Array for storing built-in cmd strings.
char* built_in_cmds[] = {"exit", "cd", "path"};

// Pointer to array of paths.
char** src_path;

// Marks end position in input tokens array.
int position = 0;

// Initialize path for first time with /bin.
void initialize_path() {
    src_path = (char**)calloc(BUF_SIZE,sizeof(char*));
    src_path[0] = "/bin";
    src_path[1] = NULL;
}

// Function declaration for builtin functions.
int my_exit(int argc, char** args);
int my_cd(int argc, char** args);
int my_path(int argc, char** args);

// Built in exit function.
int my_exit(int argc, char ** args){
    if (args[1] != NULL){
        printError();
    } else {
        exit(EXIT_SUCCESS);
    }
    return 1;
}

// Built in cd function
int my_cd(int argc, char** args) {
    if (args[1] == NULL){
        printError();
        return 1;
    }
    if (chdir(args[1]) != 0){
        printError();
    }
    return 1;
}

// Built in path function.
int my_path(int argc, char** args) {
    // Set new paths after taking from input array
    for(int i = 1; i < argc;i++) {
        src_path[i-1] = NULL;
        src_path[i-1] = calloc(100, sizeof(char));
        strcpy(src_path[i-1], args[i]);
    }
    src_path[argc-1] = NULL;
    return 1;
}

// Array of function pointers.
int (*built_in_func[])(int, char**) = {
    &my_exit, &my_cd, &my_path 
};

// Method to parse input line.
char** readLine(char* line, char** parsedInput) {
    position = 0;
    char* token, *tokenB;
    parsedInput[0] = NULL;
    
    // Tokenize on '>' and then on " "
    while((tokenB = strsep(&line, ">")) != NULL) {
        while((token = strsep(&tokenB, " ")) != NULL){
            // skip empty and new line tokens
            if( *token == '\0' ) {
                continue;
            }
            if(strcmp(token,"\n") == 0){
                continue;
            }
            token[strcspn(token, "\n")] = 0;
            parsedInput[position] = token;
            position++;
        }
        // Delimit on ">" and add this to input array
        parsedInput[position++] = ">";
    }
    parsedInput[--position] = NULL;
    return parsedInput;
}

// Method to fork and create new process.
void run_fork(char** input) {
    int redirect = 0;
    char* outputFile;
    pid_t c_pid;
    // Check for redirection, if present populate output file.
    for (int i = 0; input[i] != NULL;i++){
        if (strcmp(input[i], ">") == 0 ){
            redirect = 1;
            // Check if only 1 output file is mentioned in input.
            if (i >0 && input[i+1] != NULL && input[i+2] == NULL){
                outputFile = input[i+1];
                input[i] = NULL;
                input[i+1] = NULL;
                break;
            } else {
                printError();
                exit(EXIT_SUCCESS);
            }
        }
    }
    // create a new process
    c_pid = fork();
    if (c_pid == 0) {
        //child process
        if (redirect) {
            close(STDOUT_FILENO);
            open(outputFile, O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU);
        }
        // create a path to check shell commands
        char* curr_src_path = (char*)calloc(100, sizeof(char));
        char* slash = "/";
        if(src_path[0] == NULL){
            printError();
            exit(EXIT_SUCCESS);
        }
        for(int i = 0; src_path[i] != NULL; i++){
            strcat(strcat(strcat(curr_src_path, src_path[i]), slash), input[0]);
            char* arr = (char*)calloc(100, sizeof(char*));
            strcat(strcpy(arr, curr_src_path), "\n");
            if(access(arr, X_OK)) {
                c_pid = execv(curr_src_path, input);
                if (c_pid == -1)
                    printError();
            }else{
                printf("not found in %s \n", curr_src_path);
            }
        }
        free(curr_src_path);
    }
    else if (c_pid < 0) {
        printError();
        exit(EXIT_SUCCESS);
    } else {
        wait(NULL);
    }
}

// Method to handle loop shell command.
void run_loop(char** input) {
    int pos = 0,errno = 0 ;
    char* testptr;
    int loop_max = strtol(input[1], &testptr, 10);
    if (errno != 0 || testptr == input[1] || loop_max < 0){
        printError();
        return;
    }
    for (int i=2; input[i]!=NULL; i++){
        if (strcmp(input[i], "$loop") == 0 ) {
            pos = i;
        }
    }
    for (int loop = 1;loop <= loop_max;loop++){
        // Replace with loop values
        if (pos != 0) {
            input[pos] = NULL;
            input[pos] = calloc(10, sizeof(char));
            sprintf(input[pos], "%d", loop);
        }
        run_fork(&input[2]);
    }
}

// Process the commands on shell CLI.
void process(FILE* stream, char* line, char** input) {
    int flag = 0;
    input = readLine(line, input);
    int n = position;
    if(input[0] == NULL){
        return;
    }
    // Check for built in commands
    for (int i = 0; i< 3; i++) {
        if(strcmp(input[0], built_in_cmds[i]) == 0){
            flag = 1;
            (*built_in_func[i])(n, input);
        }
    }
    if (strcmp(input[0], "loop") == 0 ) {
        flag = 1;
        if(input[1] != NULL)run_loop(input);
        else printError();
    }
    if (!flag) {
        run_fork(input);
    }
}

int main(int argc, char* argy[]) {
    FILE* stream;
    char* line = NULL;
    size_t len = 0;
    ssize_t nread;
    char** input = (char**)calloc(BUF_SIZE, sizeof(char*));
    initialize_path();
    if (argc > 1) {
        if(argc > 2){
            printError();
            exit(EXIT_FAILURE);
        }
        char* file = argy[1];
        stream = fopen(file, "r");
        if(stream == NULL){
            printError();
            exit(EXIT_FAILURE);
        }
        while ((nread = getline(&line, &len, stream)) != -1) {
            process(stream, line, input);
        }
    } else {
        stream = stdin;
        while(1) {
            if ((nread = getline(&line, &len, stream)) != -1) {
                process(stream, line, input);
            }
        }
    }
    free(input);
    free(src_path);
    fclose(stream);
    return 0;
}