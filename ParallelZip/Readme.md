Parallel Zip
In an earlier project, you implemented a simple compression tool based on run-length encoding, known simply as zip. Here, you'll implement something similar, except you'll use threads to make a parallel version of zip. We'll call this version ... wait for it ... pzip.

There are three specific objectives to this assignment:

To familiarize yourself with the Linux pthreads.
To learn how to parallelize a program.
To learn how to program for high performance.
Background
To understand how to make progress on this project, you should first understand the basics of thread creation, and perhaps locking and signaling via mutex locks and condition variables. These are described in the following book chapters:

Intro to Threads
Threads API
Locks
Using Locks
Condition Variables
Read these chapters carefully in order to prepare yourself for this project.

Overview
First, recall how zip works by reading the description here. You'll use the same basic specification, with run-length encoding as the basic technique.

Your parallel zip (pzip) will externally look the same; the general usage from the command line will be as follows:

prompt> ./pzip file > file.z
As before, there may be many input files (not just one, as above). However, internally, the program will use POSIX threads to parallelize the compression process.

Considerations
Doing so effectively and with high performance will require you to address (at least) the following issues:

How to parallelize the compression. Of course, the central challenge of this project is to parallelize the compression process. Think about what can be done in parallel, and what must be done serially by a single thread, and design your parallel zip as appropriate.

One interesting issue that the "best" implementations will handle is this: what happens if one thread runs more slowly than another? Does the compression give more work to faster threads?

How to determine how many threads to create. On Linux, this means using interfaces like get_nprocs() and get_nprocs_conf(); read the man pages for more details. Then, create threads to match the number of CPU resources available.

How to efficiently perform each piece of work. While parallelization will yield speed up, each thread's efficiency in performing the compression is also of critical importance. Thus, making the core compression loop as CPU efficient as possible is needed for high performance.

How to access the input file efficiently. On Linux, there are many ways to read from a file, including C standard library calls like fread() and raw system calls like read(). One particularly efficient way is to use memory-mapped files, available via mmap(). By mapping the input file into the address space, you can then access bytes of the input file via pointers and do so quite efficiently.
For performing pzip, we have used multithreading to compress parts of a file and finally compressed at the respective part boundaries. 

We have read the input files and mapped them to memory. Then we start a producer thread to read the files and create chunks so that multiple consumer threads can work on compressing a single file if file size if huge. Then we start both producers and consumers threads. 

The producer broadcasts to wake all consumer threads waiting for signal after it finishes processing all files. 

Consumers read the chunks and do run length encoding and add the output array at this chunk's index. This allows threads to process later chunks even if earlier chunks are not yet processed. 

Finally, we compress output array (required for compression at chunk boundaries) and output in binary.
