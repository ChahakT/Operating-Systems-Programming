
_testGraph:     file format elf32-i386


Disassembly of section .text:

00001000 <spin>:
#include "user.h"
#include "pstat.h"
#define PROC 4

void spin()
{
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
	for(i = 0; i < 50; ++i)
    101f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1026:	eb 44                	jmp    106c <spin+0x6c>
	{
		for(j = 0; j < 10000000; ++j)
    1028:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    102f:	eb 2e                	jmp    105f <spin+0x5f>
		{
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
		for(j = 0; j < 10000000; ++j)
    105b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    105f:	81 7d f8 7f 96 98 00 	cmpl   $0x98967f,-0x8(%ebp)
    1066:	7e c9                	jle    1031 <spin+0x31>
	for(i = 0; i < 50; ++i)
    1068:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    106c:	83 7d fc 31          	cmpl   $0x31,-0x4(%ebp)
    1070:	7e b6                	jle    1028 <spin+0x28>
    }
	}
}
    1072:	90                   	nop
    1073:	90                   	nop
    1074:	c9                   	leave  
    1075:	c3                   	ret    

00001076 <main>:


int
main(int argc, char *argv[])
{
    1076:	f3 0f 1e fb          	endbr32 
    107a:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    107e:	83 e4 f0             	and    $0xfffffff0,%esp
    1081:	ff 71 fc             	pushl  -0x4(%ecx)
    1084:	55                   	push   %ebp
    1085:	89 e5                	mov    %esp,%ebp
    1087:	51                   	push   %ecx
    1088:	81 ec 24 04 00 00    	sub    $0x424,%esp
   struct pstat st;
   int count = 0;
    108e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
   int i = 0;
    1095:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
   int pid0, pid1, pid2, pid3;
   printf(1,"Spinning...\n");
    109c:	83 ec 08             	sub    $0x8,%esp
    109f:	68 5c 1a 00 00       	push   $0x1a5c
    10a4:	6a 01                	push   $0x1
    10a6:	e8 ea 05 00 00       	call   1695 <printf>
    10ab:	83 c4 10             	add    $0x10,%esp

 pid0 = fork();
    10ae:	e8 4e 04 00 00       	call   1501 <fork>
    10b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if (pid0 < 0) {
    10b6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10ba:	79 14                	jns    10d0 <main+0x5a>
    printf(2, "Fork child process 1 failed\n");
    10bc:	83 ec 08             	sub    $0x8,%esp
    10bf:	68 69 1a 00 00       	push   $0x1a69
    10c4:	6a 02                	push   $0x2
    10c6:	e8 ca 05 00 00       	call   1695 <printf>
    10cb:	83 c4 10             	add    $0x10,%esp
    10ce:	eb 1a                	jmp    10ea <main+0x74>
  } else if (pid0 == 0) { // child process 1
    10d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10d4:	75 14                	jne    10ea <main+0x74>
    settickets(1);
    10d6:	83 ec 0c             	sub    $0xc,%esp
    10d9:	6a 01                	push   $0x1
    10db:	e8 c9 04 00 00       	call   15a9 <settickets>
    10e0:	83 c4 10             	add    $0x10,%esp
    while (1){
//          sleep(1);
      spin();
    10e3:	e8 18 ff ff ff       	call   1000 <spin>
    10e8:	eb f9                	jmp    10e3 <main+0x6d>
    }
  }
   pid1 = fork();
    10ea:	e8 12 04 00 00       	call   1501 <fork>
    10ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if (pid1 < 0) {
    10f2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    10f6:	79 14                	jns    110c <main+0x96>
    printf(2, "Fork child process 1 failed\n");
    10f8:	83 ec 08             	sub    $0x8,%esp
    10fb:	68 69 1a 00 00       	push   $0x1a69
    1100:	6a 02                	push   $0x2
    1102:	e8 8e 05 00 00       	call   1695 <printf>
    1107:	83 c4 10             	add    $0x10,%esp
    110a:	eb 1a                	jmp    1126 <main+0xb0>
  } else if (pid1 == 0) { // child process 1
    110c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1110:	75 14                	jne    1126 <main+0xb0>
    settickets(3);
    1112:	83 ec 0c             	sub    $0xc,%esp
    1115:	6a 03                	push   $0x3
    1117:	e8 8d 04 00 00       	call   15a9 <settickets>
    111c:	83 c4 10             	add    $0x10,%esp
    while (1){
//	    sleep(1);
      spin();
    111f:	e8 dc fe ff ff       	call   1000 <spin>
    1124:	eb f9                	jmp    111f <main+0xa9>
    }
  }

  pid2 = fork();
    1126:	e8 d6 03 00 00       	call   1501 <fork>
    112b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if (pid2 < 0) {
    112e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1132:	79 17                	jns    114b <main+0xd5>
    printf(2, "Fork child process 2 failed\n");
    1134:	83 ec 08             	sub    $0x8,%esp
    1137:	68 86 1a 00 00       	push   $0x1a86
    113c:	6a 02                	push   $0x2
    113e:	e8 52 05 00 00       	call   1695 <printf>
    1143:	83 c4 10             	add    $0x10,%esp
    exit();
    1146:	e8 be 03 00 00       	call   1509 <exit>
  } else if (pid2 == 0) { // child process 2
    114b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    114f:	75 14                	jne    1165 <main+0xef>
    settickets(2);
    1151:	83 ec 0c             	sub    $0xc,%esp
    1154:	6a 02                	push   $0x2
    1156:	e8 4e 04 00 00       	call   15a9 <settickets>
    115b:	83 c4 10             	add    $0x10,%esp
    while (1)
      spin();
    115e:	e8 9d fe ff ff       	call   1000 <spin>
    1163:	eb f9                	jmp    115e <main+0xe8>
  }
  
  pid3 = fork();
    1165:	e8 97 03 00 00       	call   1501 <fork>
    116a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if (pid3 < 0) {
    116d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    1171:	79 17                	jns    118a <main+0x114>
    printf(2, "Fork child process 3 failed\n");
    1173:	83 ec 08             	sub    $0x8,%esp
    1176:	68 a3 1a 00 00       	push   $0x1aa3
    117b:	6a 02                	push   $0x2
    117d:	e8 13 05 00 00       	call   1695 <printf>
    1182:	83 c4 10             	add    $0x10,%esp
    exit();
    1185:	e8 7f 03 00 00       	call   1509 <exit>
  } else if (pid3 == 0) { // child process 2
    118a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    118e:	75 14                	jne    11a4 <main+0x12e>
    settickets(1);
    1190:	83 ec 0c             	sub    $0xc,%esp
    1193:	6a 01                	push   $0x1
    1195:	e8 0f 04 00 00       	call   15a9 <settickets>
    119a:	83 c4 10             	add    $0x10,%esp
    while (1)
      spin();
    119d:	e8 5e fe ff ff       	call   1000 <spin>
    11a2:	eb f9                	jmp    119d <main+0x127>
  }

  sleep(20);
    11a4:	83 ec 0c             	sub    $0xc,%esp
    11a7:	6a 14                	push   $0x14
    11a9:	e8 eb 03 00 00       	call   1599 <sleep>
    11ae:	83 c4 10             	add    $0x10,%esp
  kill(pid0);
    11b1:	83 ec 0c             	sub    $0xc,%esp
    11b4:	ff 75 ec             	pushl  -0x14(%ebp)
    11b7:	e8 7d 03 00 00       	call   1539 <kill>
    11bc:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
    11bf:	83 ec 0c             	sub    $0xc,%esp
    11c2:	ff 75 e8             	pushl  -0x18(%ebp)
    11c5:	e8 6f 03 00 00       	call   1539 <kill>
    11ca:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
    11cd:	83 ec 0c             	sub    $0xc,%esp
    11d0:	ff 75 e4             	pushl  -0x1c(%ebp)
    11d3:	e8 61 03 00 00       	call   1539 <kill>
    11d8:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
    11db:	83 ec 0c             	sub    $0xc,%esp
    11de:	ff 75 e0             	pushl  -0x20(%ebp)
    11e1:	e8 53 03 00 00       	call   1539 <kill>
    11e6:	83 c4 10             	add    $0x10,%esp
   
  sleep(500);
    11e9:	83 ec 0c             	sub    $0xc,%esp
    11ec:	68 f4 01 00 00       	push   $0x1f4
    11f1:	e8 a3 03 00 00       	call   1599 <sleep>
    11f6:	83 c4 10             	add    $0x10,%esp
   //spin();

   printf(1, "\n**** PInfo ****\n");
    11f9:	83 ec 08             	sub    $0x8,%esp
    11fc:	68 c0 1a 00 00       	push   $0x1ac0
    1201:	6a 01                	push   $0x1
    1203:	e8 8d 04 00 00       	call   1695 <printf>
    1208:	83 c4 10             	add    $0x10,%esp
   for(i = 0; i < NPROC; i++) {
    120b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1212:	eb 50                	jmp    1264 <main+0x1ee>
      if (st.inuse[i]) {
    1214:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1217:	8b 84 85 e0 fb ff ff 	mov    -0x420(%ebp,%eax,4),%eax
    121e:	85 c0                	test   %eax,%eax
    1220:	74 3e                	je     1260 <main+0x1ea>
         printf(1, "pid: %d tickets: %d ticks: %d\n", st.pid[i], st.tickets[i], st.ticks[i]);
    1222:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1225:	05 c0 00 00 00       	add    $0xc0,%eax
    122a:	8b 8c 85 e0 fb ff ff 	mov    -0x420(%ebp,%eax,4),%ecx
    1231:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1234:	83 c0 40             	add    $0x40,%eax
    1237:	8b 94 85 e0 fb ff ff 	mov    -0x420(%ebp,%eax,4),%edx
    123e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1241:	83 e8 80             	sub    $0xffffff80,%eax
    1244:	8b 84 85 e0 fb ff ff 	mov    -0x420(%ebp,%eax,4),%eax
    124b:	83 ec 0c             	sub    $0xc,%esp
    124e:	51                   	push   %ecx
    124f:	52                   	push   %edx
    1250:	50                   	push   %eax
    1251:	68 d4 1a 00 00       	push   $0x1ad4
    1256:	6a 01                	push   $0x1
    1258:	e8 38 04 00 00       	call   1695 <printf>
    125d:	83 c4 20             	add    $0x20,%esp
   for(i = 0; i < NPROC; i++) {
    1260:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1264:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
    1268:	7e aa                	jle    1214 <main+0x19e>
      }
   }
   while (wait() > 0);
    126a:	90                   	nop
    126b:	e8 a1 02 00 00       	call   1511 <wait>
    1270:	85 c0                	test   %eax,%eax
    1272:	7f f7                	jg     126b <main+0x1f5>
   printf(1,"Number of processes in use %d\n", count);
    1274:	83 ec 04             	sub    $0x4,%esp
    1277:	ff 75 f0             	pushl  -0x10(%ebp)
    127a:	68 f4 1a 00 00       	push   $0x1af4
    127f:	6a 01                	push   $0x1
    1281:	e8 0f 04 00 00       	call   1695 <printf>
    1286:	83 c4 10             	add    $0x10,%esp
   
    
   exit();
    1289:	e8 7b 02 00 00       	call   1509 <exit>

0000128e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    128e:	55                   	push   %ebp
    128f:	89 e5                	mov    %esp,%ebp
    1291:	57                   	push   %edi
    1292:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1293:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1296:	8b 55 10             	mov    0x10(%ebp),%edx
    1299:	8b 45 0c             	mov    0xc(%ebp),%eax
    129c:	89 cb                	mov    %ecx,%ebx
    129e:	89 df                	mov    %ebx,%edi
    12a0:	89 d1                	mov    %edx,%ecx
    12a2:	fc                   	cld    
    12a3:	f3 aa                	rep stos %al,%es:(%edi)
    12a5:	89 ca                	mov    %ecx,%edx
    12a7:	89 fb                	mov    %edi,%ebx
    12a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
    12ac:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    12af:	90                   	nop
    12b0:	5b                   	pop    %ebx
    12b1:	5f                   	pop    %edi
    12b2:	5d                   	pop    %ebp
    12b3:	c3                   	ret    

000012b4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    12b4:	f3 0f 1e fb          	endbr32 
    12b8:	55                   	push   %ebp
    12b9:	89 e5                	mov    %esp,%ebp
    12bb:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    12be:	8b 45 08             	mov    0x8(%ebp),%eax
    12c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    12c4:	90                   	nop
    12c5:	8b 55 0c             	mov    0xc(%ebp),%edx
    12c8:	8d 42 01             	lea    0x1(%edx),%eax
    12cb:	89 45 0c             	mov    %eax,0xc(%ebp)
    12ce:	8b 45 08             	mov    0x8(%ebp),%eax
    12d1:	8d 48 01             	lea    0x1(%eax),%ecx
    12d4:	89 4d 08             	mov    %ecx,0x8(%ebp)
    12d7:	0f b6 12             	movzbl (%edx),%edx
    12da:	88 10                	mov    %dl,(%eax)
    12dc:	0f b6 00             	movzbl (%eax),%eax
    12df:	84 c0                	test   %al,%al
    12e1:	75 e2                	jne    12c5 <strcpy+0x11>
    ;
  return os;
    12e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12e6:	c9                   	leave  
    12e7:	c3                   	ret    

000012e8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    12e8:	f3 0f 1e fb          	endbr32 
    12ec:	55                   	push   %ebp
    12ed:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    12ef:	eb 08                	jmp    12f9 <strcmp+0x11>
    p++, q++;
    12f1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12f5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    12f9:	8b 45 08             	mov    0x8(%ebp),%eax
    12fc:	0f b6 00             	movzbl (%eax),%eax
    12ff:	84 c0                	test   %al,%al
    1301:	74 10                	je     1313 <strcmp+0x2b>
    1303:	8b 45 08             	mov    0x8(%ebp),%eax
    1306:	0f b6 10             	movzbl (%eax),%edx
    1309:	8b 45 0c             	mov    0xc(%ebp),%eax
    130c:	0f b6 00             	movzbl (%eax),%eax
    130f:	38 c2                	cmp    %al,%dl
    1311:	74 de                	je     12f1 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    1313:	8b 45 08             	mov    0x8(%ebp),%eax
    1316:	0f b6 00             	movzbl (%eax),%eax
    1319:	0f b6 d0             	movzbl %al,%edx
    131c:	8b 45 0c             	mov    0xc(%ebp),%eax
    131f:	0f b6 00             	movzbl (%eax),%eax
    1322:	0f b6 c0             	movzbl %al,%eax
    1325:	29 c2                	sub    %eax,%edx
    1327:	89 d0                	mov    %edx,%eax
}
    1329:	5d                   	pop    %ebp
    132a:	c3                   	ret    

0000132b <strlen>:

uint
strlen(const char *s)
{
    132b:	f3 0f 1e fb          	endbr32 
    132f:	55                   	push   %ebp
    1330:	89 e5                	mov    %esp,%ebp
    1332:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1335:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    133c:	eb 04                	jmp    1342 <strlen+0x17>
    133e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1342:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1345:	8b 45 08             	mov    0x8(%ebp),%eax
    1348:	01 d0                	add    %edx,%eax
    134a:	0f b6 00             	movzbl (%eax),%eax
    134d:	84 c0                	test   %al,%al
    134f:	75 ed                	jne    133e <strlen+0x13>
    ;
  return n;
    1351:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1354:	c9                   	leave  
    1355:	c3                   	ret    

00001356 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1356:	f3 0f 1e fb          	endbr32 
    135a:	55                   	push   %ebp
    135b:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    135d:	8b 45 10             	mov    0x10(%ebp),%eax
    1360:	50                   	push   %eax
    1361:	ff 75 0c             	pushl  0xc(%ebp)
    1364:	ff 75 08             	pushl  0x8(%ebp)
    1367:	e8 22 ff ff ff       	call   128e <stosb>
    136c:	83 c4 0c             	add    $0xc,%esp
  return dst;
    136f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1372:	c9                   	leave  
    1373:	c3                   	ret    

00001374 <strchr>:

char*
strchr(const char *s, char c)
{
    1374:	f3 0f 1e fb          	endbr32 
    1378:	55                   	push   %ebp
    1379:	89 e5                	mov    %esp,%ebp
    137b:	83 ec 04             	sub    $0x4,%esp
    137e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1381:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1384:	eb 14                	jmp    139a <strchr+0x26>
    if(*s == c)
    1386:	8b 45 08             	mov    0x8(%ebp),%eax
    1389:	0f b6 00             	movzbl (%eax),%eax
    138c:	38 45 fc             	cmp    %al,-0x4(%ebp)
    138f:	75 05                	jne    1396 <strchr+0x22>
      return (char*)s;
    1391:	8b 45 08             	mov    0x8(%ebp),%eax
    1394:	eb 13                	jmp    13a9 <strchr+0x35>
  for(; *s; s++)
    1396:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    139a:	8b 45 08             	mov    0x8(%ebp),%eax
    139d:	0f b6 00             	movzbl (%eax),%eax
    13a0:	84 c0                	test   %al,%al
    13a2:	75 e2                	jne    1386 <strchr+0x12>
  return 0;
    13a4:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13a9:	c9                   	leave  
    13aa:	c3                   	ret    

000013ab <gets>:

char*
gets(char *buf, int max)
{
    13ab:	f3 0f 1e fb          	endbr32 
    13af:	55                   	push   %ebp
    13b0:	89 e5                	mov    %esp,%ebp
    13b2:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13bc:	eb 42                	jmp    1400 <gets+0x55>
    cc = read(0, &c, 1);
    13be:	83 ec 04             	sub    $0x4,%esp
    13c1:	6a 01                	push   $0x1
    13c3:	8d 45 ef             	lea    -0x11(%ebp),%eax
    13c6:	50                   	push   %eax
    13c7:	6a 00                	push   $0x0
    13c9:	e8 53 01 00 00       	call   1521 <read>
    13ce:	83 c4 10             	add    $0x10,%esp
    13d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    13d4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13d8:	7e 33                	jle    140d <gets+0x62>
      break;
    buf[i++] = c;
    13da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13dd:	8d 50 01             	lea    0x1(%eax),%edx
    13e0:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13e3:	89 c2                	mov    %eax,%edx
    13e5:	8b 45 08             	mov    0x8(%ebp),%eax
    13e8:	01 c2                	add    %eax,%edx
    13ea:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    13ee:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    13f0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    13f4:	3c 0a                	cmp    $0xa,%al
    13f6:	74 16                	je     140e <gets+0x63>
    13f8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    13fc:	3c 0d                	cmp    $0xd,%al
    13fe:	74 0e                	je     140e <gets+0x63>
  for(i=0; i+1 < max; ){
    1400:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1403:	83 c0 01             	add    $0x1,%eax
    1406:	39 45 0c             	cmp    %eax,0xc(%ebp)
    1409:	7f b3                	jg     13be <gets+0x13>
    140b:	eb 01                	jmp    140e <gets+0x63>
      break;
    140d:	90                   	nop
      break;
  }
  buf[i] = '\0';
    140e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1411:	8b 45 08             	mov    0x8(%ebp),%eax
    1414:	01 d0                	add    %edx,%eax
    1416:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1419:	8b 45 08             	mov    0x8(%ebp),%eax
}
    141c:	c9                   	leave  
    141d:	c3                   	ret    

0000141e <stat>:

int
stat(const char *n, struct stat *st)
{
    141e:	f3 0f 1e fb          	endbr32 
    1422:	55                   	push   %ebp
    1423:	89 e5                	mov    %esp,%ebp
    1425:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1428:	83 ec 08             	sub    $0x8,%esp
    142b:	6a 00                	push   $0x0
    142d:	ff 75 08             	pushl  0x8(%ebp)
    1430:	e8 14 01 00 00       	call   1549 <open>
    1435:	83 c4 10             	add    $0x10,%esp
    1438:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    143b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    143f:	79 07                	jns    1448 <stat+0x2a>
    return -1;
    1441:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1446:	eb 25                	jmp    146d <stat+0x4f>
  r = fstat(fd, st);
    1448:	83 ec 08             	sub    $0x8,%esp
    144b:	ff 75 0c             	pushl  0xc(%ebp)
    144e:	ff 75 f4             	pushl  -0xc(%ebp)
    1451:	e8 0b 01 00 00       	call   1561 <fstat>
    1456:	83 c4 10             	add    $0x10,%esp
    1459:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    145c:	83 ec 0c             	sub    $0xc,%esp
    145f:	ff 75 f4             	pushl  -0xc(%ebp)
    1462:	e8 ca 00 00 00       	call   1531 <close>
    1467:	83 c4 10             	add    $0x10,%esp
  return r;
    146a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    146d:	c9                   	leave  
    146e:	c3                   	ret    

0000146f <atoi>:

int
atoi(const char *s)
{
    146f:	f3 0f 1e fb          	endbr32 
    1473:	55                   	push   %ebp
    1474:	89 e5                	mov    %esp,%ebp
    1476:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1479:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1480:	eb 25                	jmp    14a7 <atoi+0x38>
    n = n*10 + *s++ - '0';
    1482:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1485:	89 d0                	mov    %edx,%eax
    1487:	c1 e0 02             	shl    $0x2,%eax
    148a:	01 d0                	add    %edx,%eax
    148c:	01 c0                	add    %eax,%eax
    148e:	89 c1                	mov    %eax,%ecx
    1490:	8b 45 08             	mov    0x8(%ebp),%eax
    1493:	8d 50 01             	lea    0x1(%eax),%edx
    1496:	89 55 08             	mov    %edx,0x8(%ebp)
    1499:	0f b6 00             	movzbl (%eax),%eax
    149c:	0f be c0             	movsbl %al,%eax
    149f:	01 c8                	add    %ecx,%eax
    14a1:	83 e8 30             	sub    $0x30,%eax
    14a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    14a7:	8b 45 08             	mov    0x8(%ebp),%eax
    14aa:	0f b6 00             	movzbl (%eax),%eax
    14ad:	3c 2f                	cmp    $0x2f,%al
    14af:	7e 0a                	jle    14bb <atoi+0x4c>
    14b1:	8b 45 08             	mov    0x8(%ebp),%eax
    14b4:	0f b6 00             	movzbl (%eax),%eax
    14b7:	3c 39                	cmp    $0x39,%al
    14b9:	7e c7                	jle    1482 <atoi+0x13>
  return n;
    14bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    14be:	c9                   	leave  
    14bf:	c3                   	ret    

000014c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    14c0:	f3 0f 1e fb          	endbr32 
    14c4:	55                   	push   %ebp
    14c5:	89 e5                	mov    %esp,%ebp
    14c7:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    14ca:	8b 45 08             	mov    0x8(%ebp),%eax
    14cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    14d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    14d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    14d6:	eb 17                	jmp    14ef <memmove+0x2f>
    *dst++ = *src++;
    14d8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    14db:	8d 42 01             	lea    0x1(%edx),%eax
    14de:	89 45 f8             	mov    %eax,-0x8(%ebp)
    14e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14e4:	8d 48 01             	lea    0x1(%eax),%ecx
    14e7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    14ea:	0f b6 12             	movzbl (%edx),%edx
    14ed:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    14ef:	8b 45 10             	mov    0x10(%ebp),%eax
    14f2:	8d 50 ff             	lea    -0x1(%eax),%edx
    14f5:	89 55 10             	mov    %edx,0x10(%ebp)
    14f8:	85 c0                	test   %eax,%eax
    14fa:	7f dc                	jg     14d8 <memmove+0x18>
  return vdst;
    14fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14ff:	c9                   	leave  
    1500:	c3                   	ret    

00001501 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1501:	b8 01 00 00 00       	mov    $0x1,%eax
    1506:	cd 40                	int    $0x40
    1508:	c3                   	ret    

00001509 <exit>:
SYSCALL(exit)
    1509:	b8 02 00 00 00       	mov    $0x2,%eax
    150e:	cd 40                	int    $0x40
    1510:	c3                   	ret    

00001511 <wait>:
SYSCALL(wait)
    1511:	b8 03 00 00 00       	mov    $0x3,%eax
    1516:	cd 40                	int    $0x40
    1518:	c3                   	ret    

00001519 <pipe>:
SYSCALL(pipe)
    1519:	b8 04 00 00 00       	mov    $0x4,%eax
    151e:	cd 40                	int    $0x40
    1520:	c3                   	ret    

00001521 <read>:
SYSCALL(read)
    1521:	b8 05 00 00 00       	mov    $0x5,%eax
    1526:	cd 40                	int    $0x40
    1528:	c3                   	ret    

00001529 <write>:
SYSCALL(write)
    1529:	b8 10 00 00 00       	mov    $0x10,%eax
    152e:	cd 40                	int    $0x40
    1530:	c3                   	ret    

00001531 <close>:
SYSCALL(close)
    1531:	b8 15 00 00 00       	mov    $0x15,%eax
    1536:	cd 40                	int    $0x40
    1538:	c3                   	ret    

00001539 <kill>:
SYSCALL(kill)
    1539:	b8 06 00 00 00       	mov    $0x6,%eax
    153e:	cd 40                	int    $0x40
    1540:	c3                   	ret    

00001541 <exec>:
SYSCALL(exec)
    1541:	b8 07 00 00 00       	mov    $0x7,%eax
    1546:	cd 40                	int    $0x40
    1548:	c3                   	ret    

00001549 <open>:
SYSCALL(open)
    1549:	b8 0f 00 00 00       	mov    $0xf,%eax
    154e:	cd 40                	int    $0x40
    1550:	c3                   	ret    

00001551 <mknod>:
SYSCALL(mknod)
    1551:	b8 11 00 00 00       	mov    $0x11,%eax
    1556:	cd 40                	int    $0x40
    1558:	c3                   	ret    

00001559 <unlink>:
SYSCALL(unlink)
    1559:	b8 12 00 00 00       	mov    $0x12,%eax
    155e:	cd 40                	int    $0x40
    1560:	c3                   	ret    

00001561 <fstat>:
SYSCALL(fstat)
    1561:	b8 08 00 00 00       	mov    $0x8,%eax
    1566:	cd 40                	int    $0x40
    1568:	c3                   	ret    

00001569 <link>:
SYSCALL(link)
    1569:	b8 13 00 00 00       	mov    $0x13,%eax
    156e:	cd 40                	int    $0x40
    1570:	c3                   	ret    

00001571 <mkdir>:
SYSCALL(mkdir)
    1571:	b8 14 00 00 00       	mov    $0x14,%eax
    1576:	cd 40                	int    $0x40
    1578:	c3                   	ret    

00001579 <chdir>:
SYSCALL(chdir)
    1579:	b8 09 00 00 00       	mov    $0x9,%eax
    157e:	cd 40                	int    $0x40
    1580:	c3                   	ret    

00001581 <dup>:
SYSCALL(dup)
    1581:	b8 0a 00 00 00       	mov    $0xa,%eax
    1586:	cd 40                	int    $0x40
    1588:	c3                   	ret    

00001589 <getpid>:
SYSCALL(getpid)
    1589:	b8 0b 00 00 00       	mov    $0xb,%eax
    158e:	cd 40                	int    $0x40
    1590:	c3                   	ret    

00001591 <sbrk>:
SYSCALL(sbrk)
    1591:	b8 0c 00 00 00       	mov    $0xc,%eax
    1596:	cd 40                	int    $0x40
    1598:	c3                   	ret    

00001599 <sleep>:
SYSCALL(sleep)
    1599:	b8 0d 00 00 00       	mov    $0xd,%eax
    159e:	cd 40                	int    $0x40
    15a0:	c3                   	ret    

000015a1 <uptime>:
SYSCALL(uptime)
    15a1:	b8 0e 00 00 00       	mov    $0xe,%eax
    15a6:	cd 40                	int    $0x40
    15a8:	c3                   	ret    

000015a9 <settickets>:
SYSCALL(settickets)
    15a9:	b8 16 00 00 00       	mov    $0x16,%eax
    15ae:	cd 40                	int    $0x40
    15b0:	c3                   	ret    

000015b1 <getpinfo>:
SYSCALL(getpinfo)
    15b1:	b8 17 00 00 00       	mov    $0x17,%eax
    15b6:	cd 40                	int    $0x40
    15b8:	c3                   	ret    

000015b9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    15b9:	f3 0f 1e fb          	endbr32 
    15bd:	55                   	push   %ebp
    15be:	89 e5                	mov    %esp,%ebp
    15c0:	83 ec 18             	sub    $0x18,%esp
    15c3:	8b 45 0c             	mov    0xc(%ebp),%eax
    15c6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    15c9:	83 ec 04             	sub    $0x4,%esp
    15cc:	6a 01                	push   $0x1
    15ce:	8d 45 f4             	lea    -0xc(%ebp),%eax
    15d1:	50                   	push   %eax
    15d2:	ff 75 08             	pushl  0x8(%ebp)
    15d5:	e8 4f ff ff ff       	call   1529 <write>
    15da:	83 c4 10             	add    $0x10,%esp
}
    15dd:	90                   	nop
    15de:	c9                   	leave  
    15df:	c3                   	ret    

000015e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    15e0:	f3 0f 1e fb          	endbr32 
    15e4:	55                   	push   %ebp
    15e5:	89 e5                	mov    %esp,%ebp
    15e7:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    15ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    15f1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    15f5:	74 17                	je     160e <printint+0x2e>
    15f7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15fb:	79 11                	jns    160e <printint+0x2e>
    neg = 1;
    15fd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1604:	8b 45 0c             	mov    0xc(%ebp),%eax
    1607:	f7 d8                	neg    %eax
    1609:	89 45 ec             	mov    %eax,-0x14(%ebp)
    160c:	eb 06                	jmp    1614 <printint+0x34>
  } else {
    x = xx;
    160e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1611:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1614:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    161b:	8b 4d 10             	mov    0x10(%ebp),%ecx
    161e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1621:	ba 00 00 00 00       	mov    $0x0,%edx
    1626:	f7 f1                	div    %ecx
    1628:	89 d1                	mov    %edx,%ecx
    162a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162d:	8d 50 01             	lea    0x1(%eax),%edx
    1630:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1633:	0f b6 91 80 1d 00 00 	movzbl 0x1d80(%ecx),%edx
    163a:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    163e:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1641:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1644:	ba 00 00 00 00       	mov    $0x0,%edx
    1649:	f7 f1                	div    %ecx
    164b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    164e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1652:	75 c7                	jne    161b <printint+0x3b>
  if(neg)
    1654:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1658:	74 2d                	je     1687 <printint+0xa7>
    buf[i++] = '-';
    165a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165d:	8d 50 01             	lea    0x1(%eax),%edx
    1660:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1663:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1668:	eb 1d                	jmp    1687 <printint+0xa7>
    putc(fd, buf[i]);
    166a:	8d 55 dc             	lea    -0x24(%ebp),%edx
    166d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1670:	01 d0                	add    %edx,%eax
    1672:	0f b6 00             	movzbl (%eax),%eax
    1675:	0f be c0             	movsbl %al,%eax
    1678:	83 ec 08             	sub    $0x8,%esp
    167b:	50                   	push   %eax
    167c:	ff 75 08             	pushl  0x8(%ebp)
    167f:	e8 35 ff ff ff       	call   15b9 <putc>
    1684:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    1687:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    168b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    168f:	79 d9                	jns    166a <printint+0x8a>
}
    1691:	90                   	nop
    1692:	90                   	nop
    1693:	c9                   	leave  
    1694:	c3                   	ret    

00001695 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1695:	f3 0f 1e fb          	endbr32 
    1699:	55                   	push   %ebp
    169a:	89 e5                	mov    %esp,%ebp
    169c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    169f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    16a6:	8d 45 0c             	lea    0xc(%ebp),%eax
    16a9:	83 c0 04             	add    $0x4,%eax
    16ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    16af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    16b6:	e9 59 01 00 00       	jmp    1814 <printf+0x17f>
    c = fmt[i] & 0xff;
    16bb:	8b 55 0c             	mov    0xc(%ebp),%edx
    16be:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16c1:	01 d0                	add    %edx,%eax
    16c3:	0f b6 00             	movzbl (%eax),%eax
    16c6:	0f be c0             	movsbl %al,%eax
    16c9:	25 ff 00 00 00       	and    $0xff,%eax
    16ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    16d1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16d5:	75 2c                	jne    1703 <printf+0x6e>
      if(c == '%'){
    16d7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    16db:	75 0c                	jne    16e9 <printf+0x54>
        state = '%';
    16dd:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    16e4:	e9 27 01 00 00       	jmp    1810 <printf+0x17b>
      } else {
        putc(fd, c);
    16e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16ec:	0f be c0             	movsbl %al,%eax
    16ef:	83 ec 08             	sub    $0x8,%esp
    16f2:	50                   	push   %eax
    16f3:	ff 75 08             	pushl  0x8(%ebp)
    16f6:	e8 be fe ff ff       	call   15b9 <putc>
    16fb:	83 c4 10             	add    $0x10,%esp
    16fe:	e9 0d 01 00 00       	jmp    1810 <printf+0x17b>
      }
    } else if(state == '%'){
    1703:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1707:	0f 85 03 01 00 00    	jne    1810 <printf+0x17b>
      if(c == 'd'){
    170d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1711:	75 1e                	jne    1731 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    1713:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1716:	8b 00                	mov    (%eax),%eax
    1718:	6a 01                	push   $0x1
    171a:	6a 0a                	push   $0xa
    171c:	50                   	push   %eax
    171d:	ff 75 08             	pushl  0x8(%ebp)
    1720:	e8 bb fe ff ff       	call   15e0 <printint>
    1725:	83 c4 10             	add    $0x10,%esp
        ap++;
    1728:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    172c:	e9 d8 00 00 00       	jmp    1809 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    1731:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1735:	74 06                	je     173d <printf+0xa8>
    1737:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    173b:	75 1e                	jne    175b <printf+0xc6>
        printint(fd, *ap, 16, 0);
    173d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1740:	8b 00                	mov    (%eax),%eax
    1742:	6a 00                	push   $0x0
    1744:	6a 10                	push   $0x10
    1746:	50                   	push   %eax
    1747:	ff 75 08             	pushl  0x8(%ebp)
    174a:	e8 91 fe ff ff       	call   15e0 <printint>
    174f:	83 c4 10             	add    $0x10,%esp
        ap++;
    1752:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1756:	e9 ae 00 00 00       	jmp    1809 <printf+0x174>
      } else if(c == 's'){
    175b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    175f:	75 43                	jne    17a4 <printf+0x10f>
        s = (char*)*ap;
    1761:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1764:	8b 00                	mov    (%eax),%eax
    1766:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1769:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    176d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1771:	75 25                	jne    1798 <printf+0x103>
          s = "(null)";
    1773:	c7 45 f4 13 1b 00 00 	movl   $0x1b13,-0xc(%ebp)
        while(*s != 0){
    177a:	eb 1c                	jmp    1798 <printf+0x103>
          putc(fd, *s);
    177c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177f:	0f b6 00             	movzbl (%eax),%eax
    1782:	0f be c0             	movsbl %al,%eax
    1785:	83 ec 08             	sub    $0x8,%esp
    1788:	50                   	push   %eax
    1789:	ff 75 08             	pushl  0x8(%ebp)
    178c:	e8 28 fe ff ff       	call   15b9 <putc>
    1791:	83 c4 10             	add    $0x10,%esp
          s++;
    1794:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1798:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179b:	0f b6 00             	movzbl (%eax),%eax
    179e:	84 c0                	test   %al,%al
    17a0:	75 da                	jne    177c <printf+0xe7>
    17a2:	eb 65                	jmp    1809 <printf+0x174>
        }
      } else if(c == 'c'){
    17a4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    17a8:	75 1d                	jne    17c7 <printf+0x132>
        putc(fd, *ap);
    17aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17ad:	8b 00                	mov    (%eax),%eax
    17af:	0f be c0             	movsbl %al,%eax
    17b2:	83 ec 08             	sub    $0x8,%esp
    17b5:	50                   	push   %eax
    17b6:	ff 75 08             	pushl  0x8(%ebp)
    17b9:	e8 fb fd ff ff       	call   15b9 <putc>
    17be:	83 c4 10             	add    $0x10,%esp
        ap++;
    17c1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    17c5:	eb 42                	jmp    1809 <printf+0x174>
      } else if(c == '%'){
    17c7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    17cb:	75 17                	jne    17e4 <printf+0x14f>
        putc(fd, c);
    17cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17d0:	0f be c0             	movsbl %al,%eax
    17d3:	83 ec 08             	sub    $0x8,%esp
    17d6:	50                   	push   %eax
    17d7:	ff 75 08             	pushl  0x8(%ebp)
    17da:	e8 da fd ff ff       	call   15b9 <putc>
    17df:	83 c4 10             	add    $0x10,%esp
    17e2:	eb 25                	jmp    1809 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    17e4:	83 ec 08             	sub    $0x8,%esp
    17e7:	6a 25                	push   $0x25
    17e9:	ff 75 08             	pushl  0x8(%ebp)
    17ec:	e8 c8 fd ff ff       	call   15b9 <putc>
    17f1:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    17f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17f7:	0f be c0             	movsbl %al,%eax
    17fa:	83 ec 08             	sub    $0x8,%esp
    17fd:	50                   	push   %eax
    17fe:	ff 75 08             	pushl  0x8(%ebp)
    1801:	e8 b3 fd ff ff       	call   15b9 <putc>
    1806:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1809:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    1810:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1814:	8b 55 0c             	mov    0xc(%ebp),%edx
    1817:	8b 45 f0             	mov    -0x10(%ebp),%eax
    181a:	01 d0                	add    %edx,%eax
    181c:	0f b6 00             	movzbl (%eax),%eax
    181f:	84 c0                	test   %al,%al
    1821:	0f 85 94 fe ff ff    	jne    16bb <printf+0x26>
    }
  }
}
    1827:	90                   	nop
    1828:	90                   	nop
    1829:	c9                   	leave  
    182a:	c3                   	ret    

0000182b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    182b:	f3 0f 1e fb          	endbr32 
    182f:	55                   	push   %ebp
    1830:	89 e5                	mov    %esp,%ebp
    1832:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1835:	8b 45 08             	mov    0x8(%ebp),%eax
    1838:	83 e8 08             	sub    $0x8,%eax
    183b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    183e:	a1 9c 1d 00 00       	mov    0x1d9c,%eax
    1843:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1846:	eb 24                	jmp    186c <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1848:	8b 45 fc             	mov    -0x4(%ebp),%eax
    184b:	8b 00                	mov    (%eax),%eax
    184d:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1850:	72 12                	jb     1864 <free+0x39>
    1852:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1855:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1858:	77 24                	ja     187e <free+0x53>
    185a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    185d:	8b 00                	mov    (%eax),%eax
    185f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1862:	72 1a                	jb     187e <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1864:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1867:	8b 00                	mov    (%eax),%eax
    1869:	89 45 fc             	mov    %eax,-0x4(%ebp)
    186c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    186f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1872:	76 d4                	jbe    1848 <free+0x1d>
    1874:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1877:	8b 00                	mov    (%eax),%eax
    1879:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    187c:	73 ca                	jae    1848 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    187e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1881:	8b 40 04             	mov    0x4(%eax),%eax
    1884:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    188b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    188e:	01 c2                	add    %eax,%edx
    1890:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1893:	8b 00                	mov    (%eax),%eax
    1895:	39 c2                	cmp    %eax,%edx
    1897:	75 24                	jne    18bd <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1899:	8b 45 f8             	mov    -0x8(%ebp),%eax
    189c:	8b 50 04             	mov    0x4(%eax),%edx
    189f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18a2:	8b 00                	mov    (%eax),%eax
    18a4:	8b 40 04             	mov    0x4(%eax),%eax
    18a7:	01 c2                	add    %eax,%edx
    18a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18ac:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    18af:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18b2:	8b 00                	mov    (%eax),%eax
    18b4:	8b 10                	mov    (%eax),%edx
    18b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18b9:	89 10                	mov    %edx,(%eax)
    18bb:	eb 0a                	jmp    18c7 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    18bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18c0:	8b 10                	mov    (%eax),%edx
    18c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18c5:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    18c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18ca:	8b 40 04             	mov    0x4(%eax),%eax
    18cd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    18d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18d7:	01 d0                	add    %edx,%eax
    18d9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    18dc:	75 20                	jne    18fe <free+0xd3>
    p->s.size += bp->s.size;
    18de:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18e1:	8b 50 04             	mov    0x4(%eax),%edx
    18e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18e7:	8b 40 04             	mov    0x4(%eax),%eax
    18ea:	01 c2                	add    %eax,%edx
    18ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    18f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18f5:	8b 10                	mov    (%eax),%edx
    18f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18fa:	89 10                	mov    %edx,(%eax)
    18fc:	eb 08                	jmp    1906 <free+0xdb>
  } else
    p->s.ptr = bp;
    18fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1901:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1904:	89 10                	mov    %edx,(%eax)
  freep = p;
    1906:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1909:	a3 9c 1d 00 00       	mov    %eax,0x1d9c
}
    190e:	90                   	nop
    190f:	c9                   	leave  
    1910:	c3                   	ret    

00001911 <morecore>:

static Header*
morecore(uint nu)
{
    1911:	f3 0f 1e fb          	endbr32 
    1915:	55                   	push   %ebp
    1916:	89 e5                	mov    %esp,%ebp
    1918:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    191b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1922:	77 07                	ja     192b <morecore+0x1a>
    nu = 4096;
    1924:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    192b:	8b 45 08             	mov    0x8(%ebp),%eax
    192e:	c1 e0 03             	shl    $0x3,%eax
    1931:	83 ec 0c             	sub    $0xc,%esp
    1934:	50                   	push   %eax
    1935:	e8 57 fc ff ff       	call   1591 <sbrk>
    193a:	83 c4 10             	add    $0x10,%esp
    193d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1940:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1944:	75 07                	jne    194d <morecore+0x3c>
    return 0;
    1946:	b8 00 00 00 00       	mov    $0x0,%eax
    194b:	eb 26                	jmp    1973 <morecore+0x62>
  hp = (Header*)p;
    194d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1950:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1953:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1956:	8b 55 08             	mov    0x8(%ebp),%edx
    1959:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    195c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    195f:	83 c0 08             	add    $0x8,%eax
    1962:	83 ec 0c             	sub    $0xc,%esp
    1965:	50                   	push   %eax
    1966:	e8 c0 fe ff ff       	call   182b <free>
    196b:	83 c4 10             	add    $0x10,%esp
  return freep;
    196e:	a1 9c 1d 00 00       	mov    0x1d9c,%eax
}
    1973:	c9                   	leave  
    1974:	c3                   	ret    

00001975 <malloc>:

void*
malloc(uint nbytes)
{
    1975:	f3 0f 1e fb          	endbr32 
    1979:	55                   	push   %ebp
    197a:	89 e5                	mov    %esp,%ebp
    197c:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    197f:	8b 45 08             	mov    0x8(%ebp),%eax
    1982:	83 c0 07             	add    $0x7,%eax
    1985:	c1 e8 03             	shr    $0x3,%eax
    1988:	83 c0 01             	add    $0x1,%eax
    198b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    198e:	a1 9c 1d 00 00       	mov    0x1d9c,%eax
    1993:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1996:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    199a:	75 23                	jne    19bf <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    199c:	c7 45 f0 94 1d 00 00 	movl   $0x1d94,-0x10(%ebp)
    19a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19a6:	a3 9c 1d 00 00       	mov    %eax,0x1d9c
    19ab:	a1 9c 1d 00 00       	mov    0x1d9c,%eax
    19b0:	a3 94 1d 00 00       	mov    %eax,0x1d94
    base.s.size = 0;
    19b5:	c7 05 98 1d 00 00 00 	movl   $0x0,0x1d98
    19bc:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19c2:	8b 00                	mov    (%eax),%eax
    19c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    19c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ca:	8b 40 04             	mov    0x4(%eax),%eax
    19cd:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    19d0:	77 4d                	ja     1a1f <malloc+0xaa>
      if(p->s.size == nunits)
    19d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d5:	8b 40 04             	mov    0x4(%eax),%eax
    19d8:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    19db:	75 0c                	jne    19e9 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    19dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e0:	8b 10                	mov    (%eax),%edx
    19e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19e5:	89 10                	mov    %edx,(%eax)
    19e7:	eb 26                	jmp    1a0f <malloc+0x9a>
      else {
        p->s.size -= nunits;
    19e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ec:	8b 40 04             	mov    0x4(%eax),%eax
    19ef:	2b 45 ec             	sub    -0x14(%ebp),%eax
    19f2:	89 c2                	mov    %eax,%edx
    19f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    19fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19fd:	8b 40 04             	mov    0x4(%eax),%eax
    1a00:	c1 e0 03             	shl    $0x3,%eax
    1a03:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a09:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1a0c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1a0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a12:	a3 9c 1d 00 00       	mov    %eax,0x1d9c
      return (void*)(p + 1);
    1a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a1a:	83 c0 08             	add    $0x8,%eax
    1a1d:	eb 3b                	jmp    1a5a <malloc+0xe5>
    }
    if(p == freep)
    1a1f:	a1 9c 1d 00 00       	mov    0x1d9c,%eax
    1a24:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1a27:	75 1e                	jne    1a47 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1a29:	83 ec 0c             	sub    $0xc,%esp
    1a2c:	ff 75 ec             	pushl  -0x14(%ebp)
    1a2f:	e8 dd fe ff ff       	call   1911 <morecore>
    1a34:	83 c4 10             	add    $0x10,%esp
    1a37:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a3a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a3e:	75 07                	jne    1a47 <malloc+0xd2>
        return 0;
    1a40:	b8 00 00 00 00       	mov    $0x0,%eax
    1a45:	eb 13                	jmp    1a5a <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a50:	8b 00                	mov    (%eax),%eax
    1a52:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1a55:	e9 6d ff ff ff       	jmp    19c7 <malloc+0x52>
  }
}
    1a5a:	c9                   	leave  
    1a5b:	c3                   	ret    
