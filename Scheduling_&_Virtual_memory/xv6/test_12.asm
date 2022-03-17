
_test_12:     file format elf32-i386


Disassembly of section .text:

00001000 <spin>:
#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"

void spin() {
    1000:	f3 0f 1e fb          	endbr32 
    1004:	55                   	push   %ebp
    1005:	89 e5                	mov    %esp,%ebp
    1007:	83 ec 10             	sub    $0x10,%esp
  int i = 0;
    100a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  int j = 0;
    1011:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int k = 0;
    1018:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  for (i = 0; i < 500; ++i) {
    101f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1026:	eb 44                	jmp    106c <spin+0x6c>
    for (j = 0; j < 200000; ++j) {
    1028:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    102f:	eb 2e                	jmp    105f <spin+0x5f>
      k = j % 10;
    1031:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1034:	ba 67 66 66 66       	mov    $0x66666667,%edx
    1039:	89 c8                	mov    %ecx,%eax
    103b:	f7 ea                	imul   %edx
    103d:	c1 fa 02             	sar    $0x2,%edx
    1040:	89 c8                	mov    %ecx,%eax
    1042:	c1 f8 1f             	sar    $0x1f,%eax
    1045:	29 c2                	sub    %eax,%edx
    1047:	89 d0                	mov    %edx,%eax
    1049:	c1 e0 02             	shl    $0x2,%eax
    104c:	01 d0                	add    %edx,%eax
    104e:	01 c0                	add    %eax,%eax
    1050:	29 c1                	sub    %eax,%ecx
    1052:	89 c8                	mov    %ecx,%eax
    1054:	89 45 f4             	mov    %eax,-0xc(%ebp)
      k = k + 1;
    1057:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    for (j = 0; j < 200000; ++j) {
    105b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    105f:	81 7d f8 3f 0d 03 00 	cmpl   $0x30d3f,-0x8(%ebp)
    1066:	7e c9                	jle    1031 <spin+0x31>
  for (i = 0; i < 500; ++i) {
    1068:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    106c:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%ebp)
    1073:	7e b3                	jle    1028 <spin+0x28>
    }
  }
}
    1075:	90                   	nop
    1076:	90                   	nop
    1077:	c9                   	leave  
    1078:	c3                   	ret    

00001079 <print>:

void print(struct pstat *st) {
    1079:	f3 0f 1e fb          	endbr32 
    107d:	55                   	push   %ebp
    107e:	89 e5                	mov    %esp,%ebp
    1080:	53                   	push   %ebx
    1081:	83 ec 14             	sub    $0x14,%esp
   int i;
   for(i = 0; i < NPROC; i++) {
    1084:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    108b:	eb 4d                	jmp    10da <print+0x61>
     if (st->inuse[i]) {
    108d:	8b 45 08             	mov    0x8(%ebp),%eax
    1090:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1093:	8b 04 90             	mov    (%eax,%edx,4),%eax
    1096:	85 c0                	test   %eax,%eax
    1098:	74 3c                	je     10d6 <print+0x5d>
       printf(1, "pid: %d tickets: %d ticks: %d\n", st->pid[i], st->tickets[i], st->ticks[i]);
    109a:	8b 45 08             	mov    0x8(%ebp),%eax
    109d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10a0:	81 c2 c0 00 00 00    	add    $0xc0,%edx
    10a6:	8b 0c 90             	mov    (%eax,%edx,4),%ecx
    10a9:	8b 45 08             	mov    0x8(%ebp),%eax
    10ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10af:	83 c2 40             	add    $0x40,%edx
    10b2:	8b 14 90             	mov    (%eax,%edx,4),%edx
    10b5:	8b 45 08             	mov    0x8(%ebp),%eax
    10b8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    10bb:	83 eb 80             	sub    $0xffffff80,%ebx
    10be:	8b 04 98             	mov    (%eax,%ebx,4),%eax
    10c1:	83 ec 0c             	sub    $0xc,%esp
    10c4:	51                   	push   %ecx
    10c5:	52                   	push   %edx
    10c6:	50                   	push   %eax
    10c7:	68 64 1b 00 00       	push   $0x1b64
    10cc:	6a 01                	push   $0x1
    10ce:	e8 ca 06 00 00       	call   179d <printf>
    10d3:	83 c4 20             	add    $0x20,%esp
   for(i = 0; i < NPROC; i++) {
    10d6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10da:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
    10de:	7e ad                	jle    108d <print+0x14>
     }
   }
}
    10e0:	90                   	nop
    10e1:	90                   	nop
    10e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10e5:	c9                   	leave  
    10e6:	c3                   	ret    

000010e7 <compare>:

void compare(int pid_low, int pid_high, struct pstat *before, struct pstat *after) {
    10e7:	f3 0f 1e fb          	endbr32 
    10eb:	55                   	push   %ebp
    10ec:	89 e5                	mov    %esp,%ebp
    10ee:	83 ec 28             	sub    $0x28,%esp
  int i, ticks_low_before=-1, ticks_low_after=-1, ticks_high_before=-1, ticks_high_after=-1;
    10f1:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    10f8:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%ebp)
    10ff:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
    1106:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  for(i = 0; i < NPROC; i++) {
    110d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1114:	e9 90 00 00 00       	jmp    11a9 <compare+0xc2>
    if (before->pid[i] == pid_low) 
    1119:	8b 45 10             	mov    0x10(%ebp),%eax
    111c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    111f:	83 ea 80             	sub    $0xffffff80,%edx
    1122:	8b 04 90             	mov    (%eax,%edx,4),%eax
    1125:	39 45 08             	cmp    %eax,0x8(%ebp)
    1128:	75 12                	jne    113c <compare+0x55>
        ticks_low_before = before->ticks[i];
    112a:	8b 45 10             	mov    0x10(%ebp),%eax
    112d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1130:	81 c2 c0 00 00 00    	add    $0xc0,%edx
    1136:	8b 04 90             	mov    (%eax,%edx,4),%eax
    1139:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (before->pid[i] == pid_high)
    113c:	8b 45 10             	mov    0x10(%ebp),%eax
    113f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1142:	83 ea 80             	sub    $0xffffff80,%edx
    1145:	8b 04 90             	mov    (%eax,%edx,4),%eax
    1148:	39 45 0c             	cmp    %eax,0xc(%ebp)
    114b:	75 12                	jne    115f <compare+0x78>
        ticks_high_before = before->ticks[i];
    114d:	8b 45 10             	mov    0x10(%ebp),%eax
    1150:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1153:	81 c2 c0 00 00 00    	add    $0xc0,%edx
    1159:	8b 04 90             	mov    (%eax,%edx,4),%eax
    115c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (after->pid[i] == pid_low)
    115f:	8b 45 14             	mov    0x14(%ebp),%eax
    1162:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1165:	83 ea 80             	sub    $0xffffff80,%edx
    1168:	8b 04 90             	mov    (%eax,%edx,4),%eax
    116b:	39 45 08             	cmp    %eax,0x8(%ebp)
    116e:	75 12                	jne    1182 <compare+0x9b>
        ticks_low_after = after->ticks[i];
    1170:	8b 45 14             	mov    0x14(%ebp),%eax
    1173:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1176:	81 c2 c0 00 00 00    	add    $0xc0,%edx
    117c:	8b 04 90             	mov    (%eax,%edx,4),%eax
    117f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (after->pid[i] == pid_high)
    1182:	8b 45 14             	mov    0x14(%ebp),%eax
    1185:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1188:	83 ea 80             	sub    $0xffffff80,%edx
    118b:	8b 04 90             	mov    (%eax,%edx,4),%eax
    118e:	39 45 0c             	cmp    %eax,0xc(%ebp)
    1191:	75 12                	jne    11a5 <compare+0xbe>
        ticks_high_after = after->ticks[i];
    1193:	8b 45 14             	mov    0x14(%ebp),%eax
    1196:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1199:	81 c2 c0 00 00 00    	add    $0xc0,%edx
    119f:	8b 04 90             	mov    (%eax,%edx,4),%eax
    11a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < NPROC; i++) {
    11a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11a9:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
    11ad:	0f 8e 66 ff ff ff    	jle    1119 <compare+0x32>
  }
  printf(1, "high before: %d high after: %d, low before: %d low after: %d\n", 
    11b3:	83 ec 08             	sub    $0x8,%esp
    11b6:	ff 75 ec             	pushl  -0x14(%ebp)
    11b9:	ff 75 f0             	pushl  -0x10(%ebp)
    11bc:	ff 75 e4             	pushl  -0x1c(%ebp)
    11bf:	ff 75 e8             	pushl  -0x18(%ebp)
    11c2:	68 84 1b 00 00       	push   $0x1b84
    11c7:	6a 01                	push   $0x1
    11c9:	e8 cf 05 00 00       	call   179d <printf>
    11ce:	83 c4 20             	add    $0x20,%esp
                     ticks_high_before, ticks_high_after, ticks_low_before, ticks_low_after);
  
  if (ticks_high_after-ticks_high_before > (ticks_low_after - ticks_low_before)*100) {
    11d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11d4:	2b 45 e8             	sub    -0x18(%ebp),%eax
    11d7:	89 c2                	mov    %eax,%edx
    11d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11dc:	2b 45 f0             	sub    -0x10(%ebp),%eax
    11df:	6b c0 64             	imul   $0x64,%eax,%eax
    11e2:	39 c2                	cmp    %eax,%edx
    11e4:	7e 14                	jle    11fa <compare+0x113>
    printf(1, "XV6_SCHEDULER\t SUCCESS\n"); 
    11e6:	83 ec 08             	sub    $0x8,%esp
    11e9:	68 c2 1b 00 00       	push   $0x1bc2
    11ee:	6a 01                	push   $0x1
    11f0:	e8 a8 05 00 00       	call   179d <printf>
    11f5:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    exit();
  }
}
    11f8:	eb 17                	jmp    1211 <compare+0x12a>
    printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    11fa:	83 ec 08             	sub    $0x8,%esp
    11fd:	68 da 1b 00 00       	push   $0x1bda
    1202:	6a 01                	push   $0x1
    1204:	e8 94 05 00 00       	call   179d <printf>
    1209:	83 c4 10             	add    $0x10,%esp
    exit();
    120c:	e8 00 04 00 00       	call   1611 <exit>
}
    1211:	c9                   	leave  
    1212:	c3                   	ret    

00001213 <main>:

int
main(int argc, char *argv[])
{
    1213:	f3 0f 1e fb          	endbr32 
    1217:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    121b:	83 e4 f0             	and    $0xfffffff0,%esp
    121e:	ff 71 fc             	pushl  -0x4(%ecx)
    1221:	55                   	push   %ebp
    1222:	89 e5                	mov    %esp,%ebp
    1224:	51                   	push   %ecx
    1225:	81 ec 14 08 00 00    	sub    $0x814,%esp
  int pid_low = getpid();
    122b:	e8 61 04 00 00       	call   1691 <getpid>
    1230:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int lowtickets = 5, hightickets = 10000;
    1233:	c7 45 f0 05 00 00 00 	movl   $0x5,-0x10(%ebp)
    123a:	c7 45 ec 10 27 00 00 	movl   $0x2710,-0x14(%ebp)

  if (settickets(lowtickets) != 0) {
    1241:	83 ec 0c             	sub    $0xc,%esp
    1244:	ff 75 f0             	pushl  -0x10(%ebp)
    1247:	e8 65 04 00 00       	call   16b1 <settickets>
    124c:	83 c4 10             	add    $0x10,%esp
    124f:	85 c0                	test   %eax,%eax
    1251:	74 17                	je     126a <main+0x57>
    printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    1253:	83 ec 08             	sub    $0x8,%esp
    1256:	68 da 1b 00 00       	push   $0x1bda
    125b:	6a 01                	push   $0x1
    125d:	e8 3b 05 00 00       	call   179d <printf>
    1262:	83 c4 10             	add    $0x10,%esp
    exit();
    1265:	e8 a7 03 00 00       	call   1611 <exit>
  }

  if (fork() == 0) {  	
    126a:	e8 9a 03 00 00       	call   1609 <fork>
    126f:	85 c0                	test   %eax,%eax
    1271:	0f 85 0b 01 00 00    	jne    1382 <main+0x16f>
    if (settickets(hightickets) != 0) {
    1277:	83 ec 0c             	sub    $0xc,%esp
    127a:	ff 75 ec             	pushl  -0x14(%ebp)
    127d:	e8 2f 04 00 00       	call   16b1 <settickets>
    1282:	83 c4 10             	add    $0x10,%esp
    1285:	85 c0                	test   %eax,%eax
    1287:	74 17                	je     12a0 <main+0x8d>
      printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    1289:	83 ec 08             	sub    $0x8,%esp
    128c:	68 da 1b 00 00       	push   $0x1bda
    1291:	6a 01                	push   $0x1
    1293:	e8 05 05 00 00       	call   179d <printf>
    1298:	83 c4 10             	add    $0x10,%esp
      exit();
    129b:	e8 71 03 00 00       	call   1611 <exit>
    }
    
    int pid_high = getpid();
    12a0:	e8 ec 03 00 00       	call   1691 <getpid>
    12a5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    struct pstat st_before, st_after;
        
    if (getpinfo(&st_before) != 0) {
    12a8:	83 ec 0c             	sub    $0xc,%esp
    12ab:	8d 85 e8 f7 ff ff    	lea    -0x818(%ebp),%eax
    12b1:	50                   	push   %eax
    12b2:	e8 02 04 00 00       	call   16b9 <getpinfo>
    12b7:	83 c4 10             	add    $0x10,%esp
    12ba:	85 c0                	test   %eax,%eax
    12bc:	74 17                	je     12d5 <main+0xc2>
      printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    12be:	83 ec 08             	sub    $0x8,%esp
    12c1:	68 da 1b 00 00       	push   $0x1bda
    12c6:	6a 01                	push   $0x1
    12c8:	e8 d0 04 00 00       	call   179d <printf>
    12cd:	83 c4 10             	add    $0x10,%esp
      exit();
    12d0:	e8 3c 03 00 00       	call   1611 <exit>
    }
        
    printf(1, "\n ****PInfo before**** \n");
    12d5:	83 ec 08             	sub    $0x8,%esp
    12d8:	68 f1 1b 00 00       	push   $0x1bf1
    12dd:	6a 01                	push   $0x1
    12df:	e8 b9 04 00 00       	call   179d <printf>
    12e4:	83 c4 10             	add    $0x10,%esp
    print(&st_before);
    12e7:	83 ec 0c             	sub    $0xc,%esp
    12ea:	8d 85 e8 f7 ff ff    	lea    -0x818(%ebp),%eax
    12f0:	50                   	push   %eax
    12f1:	e8 83 fd ff ff       	call   1079 <print>
    12f6:	83 c4 10             	add    $0x10,%esp
    printf(1,"Spinning...\n");
    12f9:	83 ec 08             	sub    $0x8,%esp
    12fc:	68 0a 1c 00 00       	push   $0x1c0a
    1301:	6a 01                	push   $0x1
    1303:	e8 95 04 00 00       	call   179d <printf>
    1308:	83 c4 10             	add    $0x10,%esp

    spin();
    130b:	e8 f0 fc ff ff       	call   1000 <spin>
        
    if (getpinfo(&st_after) != 0) {
    1310:	83 ec 0c             	sub    $0xc,%esp
    1313:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
    1319:	50                   	push   %eax
    131a:	e8 9a 03 00 00       	call   16b9 <getpinfo>
    131f:	83 c4 10             	add    $0x10,%esp
    1322:	85 c0                	test   %eax,%eax
    1324:	74 17                	je     133d <main+0x12a>
      printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    1326:	83 ec 08             	sub    $0x8,%esp
    1329:	68 da 1b 00 00       	push   $0x1bda
    132e:	6a 01                	push   $0x1
    1330:	e8 68 04 00 00       	call   179d <printf>
    1335:	83 c4 10             	add    $0x10,%esp
      exit();
    1338:	e8 d4 02 00 00       	call   1611 <exit>
    }
        
    printf(1, "\n ****PInfo after**** \n");
    133d:	83 ec 08             	sub    $0x8,%esp
    1340:	68 17 1c 00 00       	push   $0x1c17
    1345:	6a 01                	push   $0x1
    1347:	e8 51 04 00 00       	call   179d <printf>
    134c:	83 c4 10             	add    $0x10,%esp
    print(&st_after);
    134f:	83 ec 0c             	sub    $0xc,%esp
    1352:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
    1358:	50                   	push   %eax
    1359:	e8 1b fd ff ff       	call   1079 <print>
    135e:	83 c4 10             	add    $0x10,%esp
	
    compare(pid_low, pid_high, &st_before, &st_after);
    1361:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
    1367:	50                   	push   %eax
    1368:	8d 85 e8 f7 ff ff    	lea    -0x818(%ebp),%eax
    136e:	50                   	push   %eax
    136f:	ff 75 e8             	pushl  -0x18(%ebp)
    1372:	ff 75 f4             	pushl  -0xc(%ebp)
    1375:	e8 6d fd ff ff       	call   10e7 <compare>
    137a:	83 c4 10             	add    $0x10,%esp
         
    exit();
    137d:	e8 8f 02 00 00       	call   1611 <exit>
  }
  spin();
    1382:	e8 79 fc ff ff       	call   1000 <spin>
  while (wait() > -1);
    1387:	90                   	nop
    1388:	e8 8c 02 00 00       	call   1619 <wait>
    138d:	85 c0                	test   %eax,%eax
    138f:	79 f7                	jns    1388 <main+0x175>
  exit();
    1391:	e8 7b 02 00 00       	call   1611 <exit>

00001396 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1396:	55                   	push   %ebp
    1397:	89 e5                	mov    %esp,%ebp
    1399:	57                   	push   %edi
    139a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    139b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    139e:	8b 55 10             	mov    0x10(%ebp),%edx
    13a1:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a4:	89 cb                	mov    %ecx,%ebx
    13a6:	89 df                	mov    %ebx,%edi
    13a8:	89 d1                	mov    %edx,%ecx
    13aa:	fc                   	cld    
    13ab:	f3 aa                	rep stos %al,%es:(%edi)
    13ad:	89 ca                	mov    %ecx,%edx
    13af:	89 fb                	mov    %edi,%ebx
    13b1:	89 5d 08             	mov    %ebx,0x8(%ebp)
    13b4:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    13b7:	90                   	nop
    13b8:	5b                   	pop    %ebx
    13b9:	5f                   	pop    %edi
    13ba:	5d                   	pop    %ebp
    13bb:	c3                   	ret    

000013bc <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    13bc:	f3 0f 1e fb          	endbr32 
    13c0:	55                   	push   %ebp
    13c1:	89 e5                	mov    %esp,%ebp
    13c3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    13c6:	8b 45 08             	mov    0x8(%ebp),%eax
    13c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    13cc:	90                   	nop
    13cd:	8b 55 0c             	mov    0xc(%ebp),%edx
    13d0:	8d 42 01             	lea    0x1(%edx),%eax
    13d3:	89 45 0c             	mov    %eax,0xc(%ebp)
    13d6:	8b 45 08             	mov    0x8(%ebp),%eax
    13d9:	8d 48 01             	lea    0x1(%eax),%ecx
    13dc:	89 4d 08             	mov    %ecx,0x8(%ebp)
    13df:	0f b6 12             	movzbl (%edx),%edx
    13e2:	88 10                	mov    %dl,(%eax)
    13e4:	0f b6 00             	movzbl (%eax),%eax
    13e7:	84 c0                	test   %al,%al
    13e9:	75 e2                	jne    13cd <strcpy+0x11>
    ;
  return os;
    13eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13ee:	c9                   	leave  
    13ef:	c3                   	ret    

000013f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    13f0:	f3 0f 1e fb          	endbr32 
    13f4:	55                   	push   %ebp
    13f5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    13f7:	eb 08                	jmp    1401 <strcmp+0x11>
    p++, q++;
    13f9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13fd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    1401:	8b 45 08             	mov    0x8(%ebp),%eax
    1404:	0f b6 00             	movzbl (%eax),%eax
    1407:	84 c0                	test   %al,%al
    1409:	74 10                	je     141b <strcmp+0x2b>
    140b:	8b 45 08             	mov    0x8(%ebp),%eax
    140e:	0f b6 10             	movzbl (%eax),%edx
    1411:	8b 45 0c             	mov    0xc(%ebp),%eax
    1414:	0f b6 00             	movzbl (%eax),%eax
    1417:	38 c2                	cmp    %al,%dl
    1419:	74 de                	je     13f9 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    141b:	8b 45 08             	mov    0x8(%ebp),%eax
    141e:	0f b6 00             	movzbl (%eax),%eax
    1421:	0f b6 d0             	movzbl %al,%edx
    1424:	8b 45 0c             	mov    0xc(%ebp),%eax
    1427:	0f b6 00             	movzbl (%eax),%eax
    142a:	0f b6 c0             	movzbl %al,%eax
    142d:	29 c2                	sub    %eax,%edx
    142f:	89 d0                	mov    %edx,%eax
}
    1431:	5d                   	pop    %ebp
    1432:	c3                   	ret    

00001433 <strlen>:

uint
strlen(const char *s)
{
    1433:	f3 0f 1e fb          	endbr32 
    1437:	55                   	push   %ebp
    1438:	89 e5                	mov    %esp,%ebp
    143a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    143d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1444:	eb 04                	jmp    144a <strlen+0x17>
    1446:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    144a:	8b 55 fc             	mov    -0x4(%ebp),%edx
    144d:	8b 45 08             	mov    0x8(%ebp),%eax
    1450:	01 d0                	add    %edx,%eax
    1452:	0f b6 00             	movzbl (%eax),%eax
    1455:	84 c0                	test   %al,%al
    1457:	75 ed                	jne    1446 <strlen+0x13>
    ;
  return n;
    1459:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    145c:	c9                   	leave  
    145d:	c3                   	ret    

0000145e <memset>:

void*
memset(void *dst, int c, uint n)
{
    145e:	f3 0f 1e fb          	endbr32 
    1462:	55                   	push   %ebp
    1463:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1465:	8b 45 10             	mov    0x10(%ebp),%eax
    1468:	50                   	push   %eax
    1469:	ff 75 0c             	pushl  0xc(%ebp)
    146c:	ff 75 08             	pushl  0x8(%ebp)
    146f:	e8 22 ff ff ff       	call   1396 <stosb>
    1474:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1477:	8b 45 08             	mov    0x8(%ebp),%eax
}
    147a:	c9                   	leave  
    147b:	c3                   	ret    

0000147c <strchr>:

char*
strchr(const char *s, char c)
{
    147c:	f3 0f 1e fb          	endbr32 
    1480:	55                   	push   %ebp
    1481:	89 e5                	mov    %esp,%ebp
    1483:	83 ec 04             	sub    $0x4,%esp
    1486:	8b 45 0c             	mov    0xc(%ebp),%eax
    1489:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    148c:	eb 14                	jmp    14a2 <strchr+0x26>
    if(*s == c)
    148e:	8b 45 08             	mov    0x8(%ebp),%eax
    1491:	0f b6 00             	movzbl (%eax),%eax
    1494:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1497:	75 05                	jne    149e <strchr+0x22>
      return (char*)s;
    1499:	8b 45 08             	mov    0x8(%ebp),%eax
    149c:	eb 13                	jmp    14b1 <strchr+0x35>
  for(; *s; s++)
    149e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    14a2:	8b 45 08             	mov    0x8(%ebp),%eax
    14a5:	0f b6 00             	movzbl (%eax),%eax
    14a8:	84 c0                	test   %al,%al
    14aa:	75 e2                	jne    148e <strchr+0x12>
  return 0;
    14ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
    14b1:	c9                   	leave  
    14b2:	c3                   	ret    

000014b3 <gets>:

char*
gets(char *buf, int max)
{
    14b3:	f3 0f 1e fb          	endbr32 
    14b7:	55                   	push   %ebp
    14b8:	89 e5                	mov    %esp,%ebp
    14ba:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    14bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14c4:	eb 42                	jmp    1508 <gets+0x55>
    cc = read(0, &c, 1);
    14c6:	83 ec 04             	sub    $0x4,%esp
    14c9:	6a 01                	push   $0x1
    14cb:	8d 45 ef             	lea    -0x11(%ebp),%eax
    14ce:	50                   	push   %eax
    14cf:	6a 00                	push   $0x0
    14d1:	e8 53 01 00 00       	call   1629 <read>
    14d6:	83 c4 10             	add    $0x10,%esp
    14d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    14dc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14e0:	7e 33                	jle    1515 <gets+0x62>
      break;
    buf[i++] = c;
    14e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e5:	8d 50 01             	lea    0x1(%eax),%edx
    14e8:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14eb:	89 c2                	mov    %eax,%edx
    14ed:	8b 45 08             	mov    0x8(%ebp),%eax
    14f0:	01 c2                	add    %eax,%edx
    14f2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14f6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    14f8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14fc:	3c 0a                	cmp    $0xa,%al
    14fe:	74 16                	je     1516 <gets+0x63>
    1500:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1504:	3c 0d                	cmp    $0xd,%al
    1506:	74 0e                	je     1516 <gets+0x63>
  for(i=0; i+1 < max; ){
    1508:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150b:	83 c0 01             	add    $0x1,%eax
    150e:	39 45 0c             	cmp    %eax,0xc(%ebp)
    1511:	7f b3                	jg     14c6 <gets+0x13>
    1513:	eb 01                	jmp    1516 <gets+0x63>
      break;
    1515:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1516:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1519:	8b 45 08             	mov    0x8(%ebp),%eax
    151c:	01 d0                	add    %edx,%eax
    151e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1521:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1524:	c9                   	leave  
    1525:	c3                   	ret    

00001526 <stat>:

int
stat(const char *n, struct stat *st)
{
    1526:	f3 0f 1e fb          	endbr32 
    152a:	55                   	push   %ebp
    152b:	89 e5                	mov    %esp,%ebp
    152d:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1530:	83 ec 08             	sub    $0x8,%esp
    1533:	6a 00                	push   $0x0
    1535:	ff 75 08             	pushl  0x8(%ebp)
    1538:	e8 14 01 00 00       	call   1651 <open>
    153d:	83 c4 10             	add    $0x10,%esp
    1540:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1543:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1547:	79 07                	jns    1550 <stat+0x2a>
    return -1;
    1549:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    154e:	eb 25                	jmp    1575 <stat+0x4f>
  r = fstat(fd, st);
    1550:	83 ec 08             	sub    $0x8,%esp
    1553:	ff 75 0c             	pushl  0xc(%ebp)
    1556:	ff 75 f4             	pushl  -0xc(%ebp)
    1559:	e8 0b 01 00 00       	call   1669 <fstat>
    155e:	83 c4 10             	add    $0x10,%esp
    1561:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1564:	83 ec 0c             	sub    $0xc,%esp
    1567:	ff 75 f4             	pushl  -0xc(%ebp)
    156a:	e8 ca 00 00 00       	call   1639 <close>
    156f:	83 c4 10             	add    $0x10,%esp
  return r;
    1572:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1575:	c9                   	leave  
    1576:	c3                   	ret    

00001577 <atoi>:

int
atoi(const char *s)
{
    1577:	f3 0f 1e fb          	endbr32 
    157b:	55                   	push   %ebp
    157c:	89 e5                	mov    %esp,%ebp
    157e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1581:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1588:	eb 25                	jmp    15af <atoi+0x38>
    n = n*10 + *s++ - '0';
    158a:	8b 55 fc             	mov    -0x4(%ebp),%edx
    158d:	89 d0                	mov    %edx,%eax
    158f:	c1 e0 02             	shl    $0x2,%eax
    1592:	01 d0                	add    %edx,%eax
    1594:	01 c0                	add    %eax,%eax
    1596:	89 c1                	mov    %eax,%ecx
    1598:	8b 45 08             	mov    0x8(%ebp),%eax
    159b:	8d 50 01             	lea    0x1(%eax),%edx
    159e:	89 55 08             	mov    %edx,0x8(%ebp)
    15a1:	0f b6 00             	movzbl (%eax),%eax
    15a4:	0f be c0             	movsbl %al,%eax
    15a7:	01 c8                	add    %ecx,%eax
    15a9:	83 e8 30             	sub    $0x30,%eax
    15ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    15af:	8b 45 08             	mov    0x8(%ebp),%eax
    15b2:	0f b6 00             	movzbl (%eax),%eax
    15b5:	3c 2f                	cmp    $0x2f,%al
    15b7:	7e 0a                	jle    15c3 <atoi+0x4c>
    15b9:	8b 45 08             	mov    0x8(%ebp),%eax
    15bc:	0f b6 00             	movzbl (%eax),%eax
    15bf:	3c 39                	cmp    $0x39,%al
    15c1:	7e c7                	jle    158a <atoi+0x13>
  return n;
    15c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    15c6:	c9                   	leave  
    15c7:	c3                   	ret    

000015c8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    15c8:	f3 0f 1e fb          	endbr32 
    15cc:	55                   	push   %ebp
    15cd:	89 e5                	mov    %esp,%ebp
    15cf:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    15d2:	8b 45 08             	mov    0x8(%ebp),%eax
    15d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    15d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    15db:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    15de:	eb 17                	jmp    15f7 <memmove+0x2f>
    *dst++ = *src++;
    15e0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    15e3:	8d 42 01             	lea    0x1(%edx),%eax
    15e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
    15e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15ec:	8d 48 01             	lea    0x1(%eax),%ecx
    15ef:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    15f2:	0f b6 12             	movzbl (%edx),%edx
    15f5:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    15f7:	8b 45 10             	mov    0x10(%ebp),%eax
    15fa:	8d 50 ff             	lea    -0x1(%eax),%edx
    15fd:	89 55 10             	mov    %edx,0x10(%ebp)
    1600:	85 c0                	test   %eax,%eax
    1602:	7f dc                	jg     15e0 <memmove+0x18>
  return vdst;
    1604:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1607:	c9                   	leave  
    1608:	c3                   	ret    

00001609 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1609:	b8 01 00 00 00       	mov    $0x1,%eax
    160e:	cd 40                	int    $0x40
    1610:	c3                   	ret    

00001611 <exit>:
SYSCALL(exit)
    1611:	b8 02 00 00 00       	mov    $0x2,%eax
    1616:	cd 40                	int    $0x40
    1618:	c3                   	ret    

00001619 <wait>:
SYSCALL(wait)
    1619:	b8 03 00 00 00       	mov    $0x3,%eax
    161e:	cd 40                	int    $0x40
    1620:	c3                   	ret    

00001621 <pipe>:
SYSCALL(pipe)
    1621:	b8 04 00 00 00       	mov    $0x4,%eax
    1626:	cd 40                	int    $0x40
    1628:	c3                   	ret    

00001629 <read>:
SYSCALL(read)
    1629:	b8 05 00 00 00       	mov    $0x5,%eax
    162e:	cd 40                	int    $0x40
    1630:	c3                   	ret    

00001631 <write>:
SYSCALL(write)
    1631:	b8 10 00 00 00       	mov    $0x10,%eax
    1636:	cd 40                	int    $0x40
    1638:	c3                   	ret    

00001639 <close>:
SYSCALL(close)
    1639:	b8 15 00 00 00       	mov    $0x15,%eax
    163e:	cd 40                	int    $0x40
    1640:	c3                   	ret    

00001641 <kill>:
SYSCALL(kill)
    1641:	b8 06 00 00 00       	mov    $0x6,%eax
    1646:	cd 40                	int    $0x40
    1648:	c3                   	ret    

00001649 <exec>:
SYSCALL(exec)
    1649:	b8 07 00 00 00       	mov    $0x7,%eax
    164e:	cd 40                	int    $0x40
    1650:	c3                   	ret    

00001651 <open>:
SYSCALL(open)
    1651:	b8 0f 00 00 00       	mov    $0xf,%eax
    1656:	cd 40                	int    $0x40
    1658:	c3                   	ret    

00001659 <mknod>:
SYSCALL(mknod)
    1659:	b8 11 00 00 00       	mov    $0x11,%eax
    165e:	cd 40                	int    $0x40
    1660:	c3                   	ret    

00001661 <unlink>:
SYSCALL(unlink)
    1661:	b8 12 00 00 00       	mov    $0x12,%eax
    1666:	cd 40                	int    $0x40
    1668:	c3                   	ret    

00001669 <fstat>:
SYSCALL(fstat)
    1669:	b8 08 00 00 00       	mov    $0x8,%eax
    166e:	cd 40                	int    $0x40
    1670:	c3                   	ret    

00001671 <link>:
SYSCALL(link)
    1671:	b8 13 00 00 00       	mov    $0x13,%eax
    1676:	cd 40                	int    $0x40
    1678:	c3                   	ret    

00001679 <mkdir>:
SYSCALL(mkdir)
    1679:	b8 14 00 00 00       	mov    $0x14,%eax
    167e:	cd 40                	int    $0x40
    1680:	c3                   	ret    

00001681 <chdir>:
SYSCALL(chdir)
    1681:	b8 09 00 00 00       	mov    $0x9,%eax
    1686:	cd 40                	int    $0x40
    1688:	c3                   	ret    

00001689 <dup>:
SYSCALL(dup)
    1689:	b8 0a 00 00 00       	mov    $0xa,%eax
    168e:	cd 40                	int    $0x40
    1690:	c3                   	ret    

00001691 <getpid>:
SYSCALL(getpid)
    1691:	b8 0b 00 00 00       	mov    $0xb,%eax
    1696:	cd 40                	int    $0x40
    1698:	c3                   	ret    

00001699 <sbrk>:
SYSCALL(sbrk)
    1699:	b8 0c 00 00 00       	mov    $0xc,%eax
    169e:	cd 40                	int    $0x40
    16a0:	c3                   	ret    

000016a1 <sleep>:
SYSCALL(sleep)
    16a1:	b8 0d 00 00 00       	mov    $0xd,%eax
    16a6:	cd 40                	int    $0x40
    16a8:	c3                   	ret    

000016a9 <uptime>:
SYSCALL(uptime)
    16a9:	b8 0e 00 00 00       	mov    $0xe,%eax
    16ae:	cd 40                	int    $0x40
    16b0:	c3                   	ret    

000016b1 <settickets>:
SYSCALL(settickets)
    16b1:	b8 16 00 00 00       	mov    $0x16,%eax
    16b6:	cd 40                	int    $0x40
    16b8:	c3                   	ret    

000016b9 <getpinfo>:
SYSCALL(getpinfo)
    16b9:	b8 17 00 00 00       	mov    $0x17,%eax
    16be:	cd 40                	int    $0x40
    16c0:	c3                   	ret    

000016c1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    16c1:	f3 0f 1e fb          	endbr32 
    16c5:	55                   	push   %ebp
    16c6:	89 e5                	mov    %esp,%ebp
    16c8:	83 ec 18             	sub    $0x18,%esp
    16cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    16ce:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    16d1:	83 ec 04             	sub    $0x4,%esp
    16d4:	6a 01                	push   $0x1
    16d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    16d9:	50                   	push   %eax
    16da:	ff 75 08             	pushl  0x8(%ebp)
    16dd:	e8 4f ff ff ff       	call   1631 <write>
    16e2:	83 c4 10             	add    $0x10,%esp
}
    16e5:	90                   	nop
    16e6:	c9                   	leave  
    16e7:	c3                   	ret    

000016e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    16e8:	f3 0f 1e fb          	endbr32 
    16ec:	55                   	push   %ebp
    16ed:	89 e5                	mov    %esp,%ebp
    16ef:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    16f2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    16f9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    16fd:	74 17                	je     1716 <printint+0x2e>
    16ff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1703:	79 11                	jns    1716 <printint+0x2e>
    neg = 1;
    1705:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    170c:	8b 45 0c             	mov    0xc(%ebp),%eax
    170f:	f7 d8                	neg    %eax
    1711:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1714:	eb 06                	jmp    171c <printint+0x34>
  } else {
    x = xx;
    1716:	8b 45 0c             	mov    0xc(%ebp),%eax
    1719:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    171c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1723:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1726:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1729:	ba 00 00 00 00       	mov    $0x0,%edx
    172e:	f7 f1                	div    %ecx
    1730:	89 d1                	mov    %edx,%ecx
    1732:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1735:	8d 50 01             	lea    0x1(%eax),%edx
    1738:	89 55 f4             	mov    %edx,-0xc(%ebp)
    173b:	0f b6 91 e0 1e 00 00 	movzbl 0x1ee0(%ecx),%edx
    1742:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1746:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1749:	8b 45 ec             	mov    -0x14(%ebp),%eax
    174c:	ba 00 00 00 00       	mov    $0x0,%edx
    1751:	f7 f1                	div    %ecx
    1753:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1756:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    175a:	75 c7                	jne    1723 <printint+0x3b>
  if(neg)
    175c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1760:	74 2d                	je     178f <printint+0xa7>
    buf[i++] = '-';
    1762:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1765:	8d 50 01             	lea    0x1(%eax),%edx
    1768:	89 55 f4             	mov    %edx,-0xc(%ebp)
    176b:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1770:	eb 1d                	jmp    178f <printint+0xa7>
    putc(fd, buf[i]);
    1772:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1775:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1778:	01 d0                	add    %edx,%eax
    177a:	0f b6 00             	movzbl (%eax),%eax
    177d:	0f be c0             	movsbl %al,%eax
    1780:	83 ec 08             	sub    $0x8,%esp
    1783:	50                   	push   %eax
    1784:	ff 75 08             	pushl  0x8(%ebp)
    1787:	e8 35 ff ff ff       	call   16c1 <putc>
    178c:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    178f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1793:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1797:	79 d9                	jns    1772 <printint+0x8a>
}
    1799:	90                   	nop
    179a:	90                   	nop
    179b:	c9                   	leave  
    179c:	c3                   	ret    

0000179d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    179d:	f3 0f 1e fb          	endbr32 
    17a1:	55                   	push   %ebp
    17a2:	89 e5                	mov    %esp,%ebp
    17a4:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    17a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    17ae:	8d 45 0c             	lea    0xc(%ebp),%eax
    17b1:	83 c0 04             	add    $0x4,%eax
    17b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    17b7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    17be:	e9 59 01 00 00       	jmp    191c <printf+0x17f>
    c = fmt[i] & 0xff;
    17c3:	8b 55 0c             	mov    0xc(%ebp),%edx
    17c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17c9:	01 d0                	add    %edx,%eax
    17cb:	0f b6 00             	movzbl (%eax),%eax
    17ce:	0f be c0             	movsbl %al,%eax
    17d1:	25 ff 00 00 00       	and    $0xff,%eax
    17d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    17d9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17dd:	75 2c                	jne    180b <printf+0x6e>
      if(c == '%'){
    17df:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    17e3:	75 0c                	jne    17f1 <printf+0x54>
        state = '%';
    17e5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    17ec:	e9 27 01 00 00       	jmp    1918 <printf+0x17b>
      } else {
        putc(fd, c);
    17f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17f4:	0f be c0             	movsbl %al,%eax
    17f7:	83 ec 08             	sub    $0x8,%esp
    17fa:	50                   	push   %eax
    17fb:	ff 75 08             	pushl  0x8(%ebp)
    17fe:	e8 be fe ff ff       	call   16c1 <putc>
    1803:	83 c4 10             	add    $0x10,%esp
    1806:	e9 0d 01 00 00       	jmp    1918 <printf+0x17b>
      }
    } else if(state == '%'){
    180b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    180f:	0f 85 03 01 00 00    	jne    1918 <printf+0x17b>
      if(c == 'd'){
    1815:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1819:	75 1e                	jne    1839 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    181b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    181e:	8b 00                	mov    (%eax),%eax
    1820:	6a 01                	push   $0x1
    1822:	6a 0a                	push   $0xa
    1824:	50                   	push   %eax
    1825:	ff 75 08             	pushl  0x8(%ebp)
    1828:	e8 bb fe ff ff       	call   16e8 <printint>
    182d:	83 c4 10             	add    $0x10,%esp
        ap++;
    1830:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1834:	e9 d8 00 00 00       	jmp    1911 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    1839:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    183d:	74 06                	je     1845 <printf+0xa8>
    183f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1843:	75 1e                	jne    1863 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1845:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1848:	8b 00                	mov    (%eax),%eax
    184a:	6a 00                	push   $0x0
    184c:	6a 10                	push   $0x10
    184e:	50                   	push   %eax
    184f:	ff 75 08             	pushl  0x8(%ebp)
    1852:	e8 91 fe ff ff       	call   16e8 <printint>
    1857:	83 c4 10             	add    $0x10,%esp
        ap++;
    185a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    185e:	e9 ae 00 00 00       	jmp    1911 <printf+0x174>
      } else if(c == 's'){
    1863:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1867:	75 43                	jne    18ac <printf+0x10f>
        s = (char*)*ap;
    1869:	8b 45 e8             	mov    -0x18(%ebp),%eax
    186c:	8b 00                	mov    (%eax),%eax
    186e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1871:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1875:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1879:	75 25                	jne    18a0 <printf+0x103>
          s = "(null)";
    187b:	c7 45 f4 2f 1c 00 00 	movl   $0x1c2f,-0xc(%ebp)
        while(*s != 0){
    1882:	eb 1c                	jmp    18a0 <printf+0x103>
          putc(fd, *s);
    1884:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1887:	0f b6 00             	movzbl (%eax),%eax
    188a:	0f be c0             	movsbl %al,%eax
    188d:	83 ec 08             	sub    $0x8,%esp
    1890:	50                   	push   %eax
    1891:	ff 75 08             	pushl  0x8(%ebp)
    1894:	e8 28 fe ff ff       	call   16c1 <putc>
    1899:	83 c4 10             	add    $0x10,%esp
          s++;
    189c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    18a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a3:	0f b6 00             	movzbl (%eax),%eax
    18a6:	84 c0                	test   %al,%al
    18a8:	75 da                	jne    1884 <printf+0xe7>
    18aa:	eb 65                	jmp    1911 <printf+0x174>
        }
      } else if(c == 'c'){
    18ac:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    18b0:	75 1d                	jne    18cf <printf+0x132>
        putc(fd, *ap);
    18b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18b5:	8b 00                	mov    (%eax),%eax
    18b7:	0f be c0             	movsbl %al,%eax
    18ba:	83 ec 08             	sub    $0x8,%esp
    18bd:	50                   	push   %eax
    18be:	ff 75 08             	pushl  0x8(%ebp)
    18c1:	e8 fb fd ff ff       	call   16c1 <putc>
    18c6:	83 c4 10             	add    $0x10,%esp
        ap++;
    18c9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    18cd:	eb 42                	jmp    1911 <printf+0x174>
      } else if(c == '%'){
    18cf:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    18d3:	75 17                	jne    18ec <printf+0x14f>
        putc(fd, c);
    18d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18d8:	0f be c0             	movsbl %al,%eax
    18db:	83 ec 08             	sub    $0x8,%esp
    18de:	50                   	push   %eax
    18df:	ff 75 08             	pushl  0x8(%ebp)
    18e2:	e8 da fd ff ff       	call   16c1 <putc>
    18e7:	83 c4 10             	add    $0x10,%esp
    18ea:	eb 25                	jmp    1911 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    18ec:	83 ec 08             	sub    $0x8,%esp
    18ef:	6a 25                	push   $0x25
    18f1:	ff 75 08             	pushl  0x8(%ebp)
    18f4:	e8 c8 fd ff ff       	call   16c1 <putc>
    18f9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    18fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18ff:	0f be c0             	movsbl %al,%eax
    1902:	83 ec 08             	sub    $0x8,%esp
    1905:	50                   	push   %eax
    1906:	ff 75 08             	pushl  0x8(%ebp)
    1909:	e8 b3 fd ff ff       	call   16c1 <putc>
    190e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1911:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    1918:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    191c:	8b 55 0c             	mov    0xc(%ebp),%edx
    191f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1922:	01 d0                	add    %edx,%eax
    1924:	0f b6 00             	movzbl (%eax),%eax
    1927:	84 c0                	test   %al,%al
    1929:	0f 85 94 fe ff ff    	jne    17c3 <printf+0x26>
    }
  }
}
    192f:	90                   	nop
    1930:	90                   	nop
    1931:	c9                   	leave  
    1932:	c3                   	ret    

00001933 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1933:	f3 0f 1e fb          	endbr32 
    1937:	55                   	push   %ebp
    1938:	89 e5                	mov    %esp,%ebp
    193a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    193d:	8b 45 08             	mov    0x8(%ebp),%eax
    1940:	83 e8 08             	sub    $0x8,%eax
    1943:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1946:	a1 fc 1e 00 00       	mov    0x1efc,%eax
    194b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    194e:	eb 24                	jmp    1974 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1950:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1953:	8b 00                	mov    (%eax),%eax
    1955:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1958:	72 12                	jb     196c <free+0x39>
    195a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    195d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1960:	77 24                	ja     1986 <free+0x53>
    1962:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1965:	8b 00                	mov    (%eax),%eax
    1967:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    196a:	72 1a                	jb     1986 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    196c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    196f:	8b 00                	mov    (%eax),%eax
    1971:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1974:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1977:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    197a:	76 d4                	jbe    1950 <free+0x1d>
    197c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    197f:	8b 00                	mov    (%eax),%eax
    1981:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1984:	73 ca                	jae    1950 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1986:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1989:	8b 40 04             	mov    0x4(%eax),%eax
    198c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1993:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1996:	01 c2                	add    %eax,%edx
    1998:	8b 45 fc             	mov    -0x4(%ebp),%eax
    199b:	8b 00                	mov    (%eax),%eax
    199d:	39 c2                	cmp    %eax,%edx
    199f:	75 24                	jne    19c5 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    19a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19a4:	8b 50 04             	mov    0x4(%eax),%edx
    19a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19aa:	8b 00                	mov    (%eax),%eax
    19ac:	8b 40 04             	mov    0x4(%eax),%eax
    19af:	01 c2                	add    %eax,%edx
    19b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19b4:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    19b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19ba:	8b 00                	mov    (%eax),%eax
    19bc:	8b 10                	mov    (%eax),%edx
    19be:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19c1:	89 10                	mov    %edx,(%eax)
    19c3:	eb 0a                	jmp    19cf <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    19c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19c8:	8b 10                	mov    (%eax),%edx
    19ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19cd:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    19cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19d2:	8b 40 04             	mov    0x4(%eax),%eax
    19d5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    19dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19df:	01 d0                	add    %edx,%eax
    19e1:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    19e4:	75 20                	jne    1a06 <free+0xd3>
    p->s.size += bp->s.size;
    19e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19e9:	8b 50 04             	mov    0x4(%eax),%edx
    19ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19ef:	8b 40 04             	mov    0x4(%eax),%eax
    19f2:	01 c2                	add    %eax,%edx
    19f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19f7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    19fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19fd:	8b 10                	mov    (%eax),%edx
    19ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a02:	89 10                	mov    %edx,(%eax)
    1a04:	eb 08                	jmp    1a0e <free+0xdb>
  } else
    p->s.ptr = bp;
    1a06:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a09:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1a0c:	89 10                	mov    %edx,(%eax)
  freep = p;
    1a0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a11:	a3 fc 1e 00 00       	mov    %eax,0x1efc
}
    1a16:	90                   	nop
    1a17:	c9                   	leave  
    1a18:	c3                   	ret    

00001a19 <morecore>:

static Header*
morecore(uint nu)
{
    1a19:	f3 0f 1e fb          	endbr32 
    1a1d:	55                   	push   %ebp
    1a1e:	89 e5                	mov    %esp,%ebp
    1a20:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1a23:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1a2a:	77 07                	ja     1a33 <morecore+0x1a>
    nu = 4096;
    1a2c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1a33:	8b 45 08             	mov    0x8(%ebp),%eax
    1a36:	c1 e0 03             	shl    $0x3,%eax
    1a39:	83 ec 0c             	sub    $0xc,%esp
    1a3c:	50                   	push   %eax
    1a3d:	e8 57 fc ff ff       	call   1699 <sbrk>
    1a42:	83 c4 10             	add    $0x10,%esp
    1a45:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1a48:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1a4c:	75 07                	jne    1a55 <morecore+0x3c>
    return 0;
    1a4e:	b8 00 00 00 00       	mov    $0x0,%eax
    1a53:	eb 26                	jmp    1a7b <morecore+0x62>
  hp = (Header*)p;
    1a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a58:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1a5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a5e:	8b 55 08             	mov    0x8(%ebp),%edx
    1a61:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1a64:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a67:	83 c0 08             	add    $0x8,%eax
    1a6a:	83 ec 0c             	sub    $0xc,%esp
    1a6d:	50                   	push   %eax
    1a6e:	e8 c0 fe ff ff       	call   1933 <free>
    1a73:	83 c4 10             	add    $0x10,%esp
  return freep;
    1a76:	a1 fc 1e 00 00       	mov    0x1efc,%eax
}
    1a7b:	c9                   	leave  
    1a7c:	c3                   	ret    

00001a7d <malloc>:

void*
malloc(uint nbytes)
{
    1a7d:	f3 0f 1e fb          	endbr32 
    1a81:	55                   	push   %ebp
    1a82:	89 e5                	mov    %esp,%ebp
    1a84:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1a87:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8a:	83 c0 07             	add    $0x7,%eax
    1a8d:	c1 e8 03             	shr    $0x3,%eax
    1a90:	83 c0 01             	add    $0x1,%eax
    1a93:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1a96:	a1 fc 1e 00 00       	mov    0x1efc,%eax
    1a9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a9e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1aa2:	75 23                	jne    1ac7 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1aa4:	c7 45 f0 f4 1e 00 00 	movl   $0x1ef4,-0x10(%ebp)
    1aab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aae:	a3 fc 1e 00 00       	mov    %eax,0x1efc
    1ab3:	a1 fc 1e 00 00       	mov    0x1efc,%eax
    1ab8:	a3 f4 1e 00 00       	mov    %eax,0x1ef4
    base.s.size = 0;
    1abd:	c7 05 f8 1e 00 00 00 	movl   $0x0,0x1ef8
    1ac4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ac7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aca:	8b 00                	mov    (%eax),%eax
    1acc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1acf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ad2:	8b 40 04             	mov    0x4(%eax),%eax
    1ad5:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1ad8:	77 4d                	ja     1b27 <malloc+0xaa>
      if(p->s.size == nunits)
    1ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1add:	8b 40 04             	mov    0x4(%eax),%eax
    1ae0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1ae3:	75 0c                	jne    1af1 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    1ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ae8:	8b 10                	mov    (%eax),%edx
    1aea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aed:	89 10                	mov    %edx,(%eax)
    1aef:	eb 26                	jmp    1b17 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    1af1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1af4:	8b 40 04             	mov    0x4(%eax),%eax
    1af7:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1afa:	89 c2                	mov    %eax,%edx
    1afc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aff:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b05:	8b 40 04             	mov    0x4(%eax),%eax
    1b08:	c1 e0 03             	shl    $0x3,%eax
    1b0b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1b0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b11:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1b14:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1b17:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b1a:	a3 fc 1e 00 00       	mov    %eax,0x1efc
      return (void*)(p + 1);
    1b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b22:	83 c0 08             	add    $0x8,%eax
    1b25:	eb 3b                	jmp    1b62 <malloc+0xe5>
    }
    if(p == freep)
    1b27:	a1 fc 1e 00 00       	mov    0x1efc,%eax
    1b2c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1b2f:	75 1e                	jne    1b4f <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1b31:	83 ec 0c             	sub    $0xc,%esp
    1b34:	ff 75 ec             	pushl  -0x14(%ebp)
    1b37:	e8 dd fe ff ff       	call   1a19 <morecore>
    1b3c:	83 c4 10             	add    $0x10,%esp
    1b3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1b42:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1b46:	75 07                	jne    1b4f <malloc+0xd2>
        return 0;
    1b48:	b8 00 00 00 00       	mov    $0x0,%eax
    1b4d:	eb 13                	jmp    1b62 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b52:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b58:	8b 00                	mov    (%eax),%eax
    1b5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1b5d:	e9 6d ff ff ff       	jmp    1acf <malloc+0x52>
  }
}
    1b62:	c9                   	leave  
    1b63:	c3                   	ret    
