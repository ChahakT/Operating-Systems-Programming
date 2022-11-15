A readers–writer is a synchronization primitive that solves one of the readers–writers problems. An RW lock allows concurrent access for read-only operations, write operations require exclusive access. 
Multiple threads can read the data in parallel but an exclusive lock is needed for writing or modifying data. 
When a writer is writing the data, all other writers or readers will be blocked until the writer is finished writing. 
A common use might be to control access to a data structure in memory that cannot be updated atomically and is invalid (and should not be read by another thread) until the update is complete.

**Priority Policies:**
RW locks can be designed with different priority policies for reader vs. writer access. The lock can either be designed to always give priority to readers (read-preferring), to always give priority to writers (write-preferring). These policies lead to different tradeoffs with regards to concurrency and starvation.

Read-preferring RW locks allow for maximum concurrency, but can lead to write-starvation if contention is high. Writer threads will starve while new reader threads will be able to acquire the lock as long as atleast one reader thread is holding the lock.

Implementation:
Initialization :
b = number of blocking readers
r = mutex used by readers
g = ensures mutual exclusion of writers. 

![Screen Shot 2022-11-15 at 13 22 39](https://user-images.githubusercontent.com/20151037/202007815-d4a38eaa-29b0-4553-8c61-e3bfb1d41ba0.png)

![Screen Shot 2022-11-15 at 13 22 49](https://user-images.githubusercontent.com/20151037/202007846-0758b1ff-3b77-4d2b-a696-cdf4c3de26f5.png)


Write-preferring RW locks avoid the problem of writer starvation by preventing any new readers from acquiring the lock if there is a writer queued and waiting for the lock. Write-preferring locks allows for less concurrency in the presence of writer threads, compared to read-preferring RW locks. 

![Screen Shot 2022-11-15 at 13 22 59](https://user-images.githubusercontent.com/20151037/202007868-dbd9b7b9-a0c4-4b92-b688-4fd4e4acc197.png)

![Screen Shot 2022-11-15 at 13 23 08](https://user-images.githubusercontent.com/20151037/202007882-491797a9-1bf9-4b66-9179-f168cfc2b828.png)
