This project is a bit different from previous ones. Instead of just building code, we will be doing some analysis. Specifically, we (ok, you) will analyze xv6 and understand its locking behavior and sleep/wake behavior. You will also write and then run code to help you understand things better, but the end goal is understanding.

Specifically, the project has two parts. In the first part, you will find two different locks and analyze their behavior. We are not going to pick specific locks for you; rather, you should look through the source code and find two that you think are interesting.

For each lock, you should understand (and document) where in the code it is used; analyze how long the critical sections are when it is in use; understand dynamically how often the lock is held and released when a process is running.

To do this, you may need to instrument the xv6 source code. Minimally, you might add some print outs to let you know when the lock you are studying gets acquired and released. You could also build a little tracing facility that recorded something each time a lock is held and released, and then print that out after running some tests. This is up to you.

The end goal for this part is simple: to fully understand how each of these two locks is used in xv6.

The second part focuses on processes that sleep and then wakeup. Again, you'll focus on two examples in the code of a process going to sleep. Your goal is to study this, and document the behavior.

To do so, first understand how sleeping and waking up works in xv6. For this, look in proc.c and the sleep(), wakeup(), and wakeup1() routines. Then, find two examples of how these are used and study them. Analyze how they are called, and again think of how you might trace such behavior.
