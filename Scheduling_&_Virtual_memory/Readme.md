An xv6 Scheduler
In this project, you'll be putting a new scheduler into xv6. It is called a lottery scheduler, and the full version is described in this chapter of the online book; you'll be building a simpler one. The basic idea is simple: assign each running process a slice of the processor based in proportion to the number of tickets it has; the more tickets a process has, the more it runs. Each time slice, a randomized lottery determines the winner of the lottery; that winning process is the one that runs for that time slice.

The objectives for this project:

To gain further knowledge of a real kernel, xv6.
To familiarize yourself with a scheduler.
To change that scheduler to a new algorithm.
To make a graph to show your project behaves appropriately.
Details
You'll need two new system calls to implement this scheduler. The first is int settickets(int number), which sets the number of tickets of the calling process. By default, each process should get one ticket; calling this routine makes it such that a process can raise the number of tickets it receives, and thus receive a higher proportion of CPU cycles. This routine should return 0 if successful, and -1 otherwise (if, for example, the caller passes in a number less than one).

The second is int getpinfo(struct pstat *). This routine returns some information about all running processes, including how many times each has been chosen to run and the process ID of each. You can use this system call to build a variant of the command line program ps, which can then be called to see what is going on. The structure pstat is defined below; note, you cannot change this structure, and must use it exactly as is. This routine should return 0 if successful, and -1 otherwise (if, for example, a bad or NULL pointer is passed into the kernel).

Most of the code for the scheduler is quite localized and can be found in proc.c; the associated header file, proc.h is also quite useful to examine. To change the scheduler, not much needs to be done; study its control flow and then try some small changes.

You'll need to assign tickets to a process when it is created. Specfically, you'll need to make sure a child process inherits the same number of tickets as its parents. Thus, if the parent has 10 tickets, and calls fork() to create a child process, the child should also get 10 tickets.

You'll also need to figure out how to generate random numbers in the kernel; some searching should lead you to a simple pseudo-random number generator, which you can then include in the kernel and use as appropriate.

Finally, you'll need to understand how to fill in the structure pstat in the kernel and pass the results to user space. The structure should look like what you see here, in a file you'll have to include called pstat.h:

#ifndef _PSTAT_H_
#define _PSTAT_H_

#include "param.h"

struct pstat {
  int inuse[NPROC];   // whether this slot of the process table is in use (1 or 0)
  int tickets[NPROC]; // the number of tickets this process has
  int pid[NPROC];     // the PID of each process 
  int ticks[NPROC];   // the number of ticks each process has accumulated 
};

#endif // _PSTAT_H_
Good examples of how to pass arguments into the kernel are found in existing system calls. In particular, follow the path of read(), which will lead you to sys_read(), which will show you how to use argptr() (and related calls) to obtain a pointer that has been passed into the kernel. Note how careful the kernel is with pointers passed from user space -- they are a security threat(!), and thus must be checked very carefully before usage.

Graph
Beyond the usual code, you'll have to make a graph for this assignment. The graph should show the number of time slices a set of three processes receives over time, where the processes have a 3:2:1 ratio of tickets (e.g., process A might have 30 tickets, process B 20, and process C 10). The graph is likely to be pretty boring, but should clearly show that your lottery scheduler works as desired.
There are some differences in this project versus the descriptions above. Notably:

Your scheduler will not be a lottery scheduler; it will instead be a simpler deterministic proportional-share 
scheduler. Specifically, if a process has N tickets, instead of running one time slice and then switching to 
another process, it will run N time slices in a row before switching. The number of time slices in a row a 
process runs is set by the same call to settickets(). Thus, if there are two RUNNABLE processes (A and B, say) 
in the system, one that has 3 tickets (A) and one that has 1 (B), the running pattern will be AAABAAAB ... etc. 
Everything else about the project remains the same (there are two system calls to implement, you need to make a 
graph, etc.)

Intro To xv6 Virtual Memory
In this project, you'll be changing xv6 to support a feature virtually every modern OS does: causing an exception to occur when your program dereferences a null pointer, and adding the ability to change the protection levels of some pages in a process's address space.

Null-pointer Dereference
In xv6, the VM system uses a simple two-level page table as discussed in class. As it currently is structured, user code is loaded into the very first part of the address space. Thus, if you dereference a null pointer, you will not see an exception (as you might expect); rather, you will see whatever code is the first bit of code in the program that is running. Try it and see!

Thus, the first thing you might do is create a program that dereferences a null pointer. It is simple! See if you can do it. Then run it on Linux as well as xv6, to see the difference.

Your job here will be to figure out how xv6 sets up a page table. Thus, once again, this project is mostly about understanding the code, and not writing very much. Look at how exec() works to better understand how address spaces get filled with code and in general initialized.

You should also look at fork(), in particular the part where the address space of the child is created by copying the address space of the parent. What needs to change in there?

The rest of your task will be completed by looking through the code to figure out where there are checks or assumptions made about the address space. Think about what happens when you pass a parameter into the kernel, for example; if passing a pointer, the kernel needs to be very careful with it, to ensure you haven't passed it a bad pointer. How does it do this now? Does this code need to change in order to work in your new version of xv6?

One last hint: you'll have to look at the xv6 makefile as well. In there user programs are compiled so as to set their entry point (where the first instruction is) to 0. If you change xv6 to make the first page invalid, clearly the entry point will have to be somewhere else (e.g., the next page, or 0x1000). Thus, something in the makefile will need to change to reflect this as well.

Read-only Code
In most operating systems, code is marked read-only instead of read-write. However, in xv6 this is not the case, so a buggy program could accidentally overwrite its own text. Try it and see!

In this portion of the xv6 project, you'll change the protection bits of parts of the page table to be read-only, thus preventing such over-writes, and also be able to change them back.

To do this, you'll be adding two system calls: int mprotect(void *addr, int len) and int munprotect(void *addr, int len).

Calling mprotect() should change the protection bits of the page range starting at addr and of len pages to be read only. Thus, the program could still read the pages in this range after mprotect() finishes, but a write to this region should cause a trap (and thus kill the process). The munprotect() call does the opposite: sets the region back to both readable and writeable.

Also required: the page protections should be inherited on fork(). Thus, if a process has mprotected some of its pages, when the process calls fork, the OS should copy those protections to the child process.

There are some failure cases to consider: if addr is not page aligned, or addr points to a region that is not currently a part of the address space, or len is less than or equal to zero, return -1 and do not change anything. Otherwise, return 0 upon success.

Hint: after changing a page-table entry, you need to make sure the hardware knows of the change. On 32-bit x86, this is readily accomplished by updating the CR3 register (what we generically call the page-table base register in class). When the hardware sees that you overwrote CR3 (even with the same value), it guarantees that your PTE updates will be used upon subsequent accesses. The lcr3() function will help you in this pursuit.

Handling Illegal Accesses
In both the cases above, you should be able to demonstrate what happens when user code tries to (a) access a null pointer or (b) overwrite an mprotected region of memory. In both cases, xv6 should trap and kill the process (this will happen without too much trouble on your part, if you do the project in a sensible way).
