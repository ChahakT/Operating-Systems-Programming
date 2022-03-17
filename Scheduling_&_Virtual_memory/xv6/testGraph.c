#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"
#define PROC 4

void spin()
{
	int i = 0;
  int j = 0;
  int k = 0;
	for(i = 0; i < 50; ++i)
	{
		for(j = 0; j < 10000000; ++j)
		{
      k = j % 10;
      k = k + 1;
    }
	}
}


int
main(int argc, char *argv[])
{
   struct pstat st;
   int count = 0;
   int i = 0;
   int pid0, pid1, pid2, pid3;
   printf(1,"Spinning...\n");

 pid0 = fork();
  if (pid0 < 0) {
    printf(2, "Fork child process 1 failed\n");
  } else if (pid0 == 0) { // child process 1
    settickets(1);
    while (1){
//          sleep(1);
      spin();
    }
  }
   pid1 = fork();
  if (pid1 < 0) {
    printf(2, "Fork child process 1 failed\n");
  } else if (pid1 == 0) { // child process 1
    settickets(3);
    while (1){
//	    sleep(1);
      spin();
    }
  }

  pid2 = fork();
  if (pid2 < 0) {
    printf(2, "Fork child process 2 failed\n");
    exit();
  } else if (pid2 == 0) { // child process 2
    settickets(2);
    while (1)
      spin();
  }
  
  pid3 = fork();
  if (pid3 < 0) {
    printf(2, "Fork child process 3 failed\n");
    exit();
  } else if (pid3 == 0) { // child process 2
    settickets(1);
    while (1)
      spin();
  }

  sleep(20);
  kill(pid0);
  kill(pid1);
  kill(pid2);
  kill(pid3);
   
  sleep(500);
   //spin();

   printf(1, "\n**** PInfo ****\n");
   for(i = 0; i < NPROC; i++) {
      if (st.inuse[i]) {
         printf(1, "pid: %d tickets: %d ticks: %d\n", st.pid[i], st.tickets[i], st.ticks[i]);
      }
   }
   while (wait() > 0);
   printf(1,"Number of processes in use %d\n", count);
   
    
   exit();
}
