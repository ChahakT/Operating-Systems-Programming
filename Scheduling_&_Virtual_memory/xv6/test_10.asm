
_test_10:     file format elf32-i386


Disassembly of section .text:

00001000 <spin>:
#include "user.h"
#include "pstat.h"
#define PROC 5

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
    1088:	81 ec 14 05 00 00    	sub    $0x514,%esp
   struct pstat st;
   int count = 0;
    108e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
   int i = 0;
    1095:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
   int pid[NPROC];
   printf(1,"Spinning...\n");
    109c:	83 ec 08             	sub    $0x8,%esp
    109f:	68 dc 19 00 00       	push   $0x19dc
    10a4:	6a 01                	push   $0x1
    10a6:	e8 68 05 00 00       	call   1613 <printf>
    10ab:	83 c4 10             	add    $0x10,%esp
   while(i < PROC)
    10ae:	eb 2b                	jmp    10db <main+0x65>
   {
      pid[i] = fork();
    10b0:	e8 ca 03 00 00       	call   147f <fork>
    10b5:	8b 55 f0             	mov    -0x10(%ebp),%edx
    10b8:	89 84 95 f0 fa ff ff 	mov    %eax,-0x510(%ebp,%edx,4)
	    if(pid[i] == 0)
    10bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10c2:	8b 84 85 f0 fa ff ff 	mov    -0x510(%ebp,%eax,4),%eax
    10c9:	85 c0                	test   %eax,%eax
    10cb:	75 0a                	jne    10d7 <main+0x61>
     {
		    spin();
    10cd:	e8 2e ff ff ff       	call   1000 <spin>
		    exit();
    10d2:	e8 b0 03 00 00       	call   1487 <exit>
      }
	  i++;
    10d7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
   while(i < PROC)
    10db:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
    10df:	7e cf                	jle    10b0 <main+0x3a>
   }
   sleep(500);
    10e1:	83 ec 0c             	sub    $0xc,%esp
    10e4:	68 f4 01 00 00       	push   $0x1f4
    10e9:	e8 29 04 00 00       	call   1517 <sleep>
    10ee:	83 c4 10             	add    $0x10,%esp
   //spin();
   if(getpinfo(&st) == 0)
    10f1:	83 ec 0c             	sub    $0xc,%esp
    10f4:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
    10fa:	50                   	push   %eax
    10fb:	e8 2f 04 00 00       	call   152f <getpinfo>
    1100:	83 c4 10             	add    $0x10,%esp
    1103:	85 c0                	test   %eax,%eax
    1105:	74 17                	je     111e <main+0xa8>
   {
   }
   else
   {
    printf(1, "XV6_SCHEDULER\t FAILED\n");
    1107:	83 ec 08             	sub    $0x8,%esp
    110a:	68 e9 19 00 00       	push   $0x19e9
    110f:	6a 01                	push   $0x1
    1111:	e8 fd 04 00 00       	call   1613 <printf>
    1116:	83 c4 10             	add    $0x10,%esp
    exit();
    1119:	e8 69 03 00 00       	call   1487 <exit>
   }

   printf(1, "\n**** PInfo ****\n");
    111e:	83 ec 08             	sub    $0x8,%esp
    1121:	68 00 1a 00 00       	push   $0x1a00
    1126:	6a 01                	push   $0x1
    1128:	e8 e6 04 00 00       	call   1613 <printf>
    112d:	83 c4 10             	add    $0x10,%esp
   for(i = 0; i < NPROC; i++) {
    1130:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1137:	eb 54                	jmp    118d <main+0x117>
      if (st.inuse[i]) {
    1139:	8b 45 f0             	mov    -0x10(%ebp),%eax
    113c:	8b 84 85 f0 fb ff ff 	mov    -0x410(%ebp,%eax,4),%eax
    1143:	85 c0                	test   %eax,%eax
    1145:	74 42                	je     1189 <main+0x113>
	       count++;
    1147:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
         printf(1, "pid: %d tickets: %d ticks: %d\n", st.pid[i], st.tickets[i], st.ticks[i]);
    114b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    114e:	05 c0 00 00 00       	add    $0xc0,%eax
    1153:	8b 8c 85 f0 fb ff ff 	mov    -0x410(%ebp,%eax,4),%ecx
    115a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    115d:	83 c0 40             	add    $0x40,%eax
    1160:	8b 94 85 f0 fb ff ff 	mov    -0x410(%ebp,%eax,4),%edx
    1167:	8b 45 f0             	mov    -0x10(%ebp),%eax
    116a:	83 e8 80             	sub    $0xffffff80,%eax
    116d:	8b 84 85 f0 fb ff ff 	mov    -0x410(%ebp,%eax,4),%eax
    1174:	83 ec 0c             	sub    $0xc,%esp
    1177:	51                   	push   %ecx
    1178:	52                   	push   %edx
    1179:	50                   	push   %eax
    117a:	68 14 1a 00 00       	push   $0x1a14
    117f:	6a 01                	push   $0x1
    1181:	e8 8d 04 00 00       	call   1613 <printf>
    1186:	83 c4 20             	add    $0x20,%esp
   for(i = 0; i < NPROC; i++) {
    1189:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    118d:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    1191:	7e a6                	jle    1139 <main+0xc3>
      }
   }
   for(i = 0; i < PROC; i++)
    1193:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    119a:	eb 1a                	jmp    11b6 <main+0x140>
   {
	    kill(pid[i]);
    119c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    119f:	8b 84 85 f0 fa ff ff 	mov    -0x510(%ebp,%eax,4),%eax
    11a6:	83 ec 0c             	sub    $0xc,%esp
    11a9:	50                   	push   %eax
    11aa:	e8 08 03 00 00       	call   14b7 <kill>
    11af:	83 c4 10             	add    $0x10,%esp
   for(i = 0; i < PROC; i++)
    11b2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11b6:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
    11ba:	7e e0                	jle    119c <main+0x126>
   }
   while (wait() > 0);
    11bc:	90                   	nop
    11bd:	e8 cd 02 00 00       	call   148f <wait>
    11c2:	85 c0                	test   %eax,%eax
    11c4:	7f f7                	jg     11bd <main+0x147>
   printf(1,"Number of processes in use %d\n", count);
    11c6:	83 ec 04             	sub    $0x4,%esp
    11c9:	ff 75 f4             	pushl  -0xc(%ebp)
    11cc:	68 34 1a 00 00       	push   $0x1a34
    11d1:	6a 01                	push   $0x1
    11d3:	e8 3b 04 00 00       	call   1613 <printf>
    11d8:	83 c4 10             	add    $0x10,%esp
   
   if(count == 8)
    11db:	83 7d f4 08          	cmpl   $0x8,-0xc(%ebp)
    11df:	75 14                	jne    11f5 <main+0x17f>
   {
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    11e1:	83 ec 08             	sub    $0x8,%esp
    11e4:	68 53 1a 00 00       	push   $0x1a53
    11e9:	6a 01                	push   $0x1
    11eb:	e8 23 04 00 00       	call   1613 <printf>
    11f0:	83 c4 10             	add    $0x10,%esp
    11f3:	eb 12                	jmp    1207 <main+0x191>
   }
   else
   {
    printf(1, "XV6_SCHEDULER\t FAILED\n");
    11f5:	83 ec 08             	sub    $0x8,%esp
    11f8:	68 e9 19 00 00       	push   $0x19e9
    11fd:	6a 01                	push   $0x1
    11ff:	e8 0f 04 00 00       	call   1613 <printf>
    1204:	83 c4 10             	add    $0x10,%esp
   }
    
   exit();
    1207:	e8 7b 02 00 00       	call   1487 <exit>

0000120c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    120c:	55                   	push   %ebp
    120d:	89 e5                	mov    %esp,%ebp
    120f:	57                   	push   %edi
    1210:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1211:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1214:	8b 55 10             	mov    0x10(%ebp),%edx
    1217:	8b 45 0c             	mov    0xc(%ebp),%eax
    121a:	89 cb                	mov    %ecx,%ebx
    121c:	89 df                	mov    %ebx,%edi
    121e:	89 d1                	mov    %edx,%ecx
    1220:	fc                   	cld    
    1221:	f3 aa                	rep stos %al,%es:(%edi)
    1223:	89 ca                	mov    %ecx,%edx
    1225:	89 fb                	mov    %edi,%ebx
    1227:	89 5d 08             	mov    %ebx,0x8(%ebp)
    122a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    122d:	90                   	nop
    122e:	5b                   	pop    %ebx
    122f:	5f                   	pop    %edi
    1230:	5d                   	pop    %ebp
    1231:	c3                   	ret    

00001232 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1232:	f3 0f 1e fb          	endbr32 
    1236:	55                   	push   %ebp
    1237:	89 e5                	mov    %esp,%ebp
    1239:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    123c:	8b 45 08             	mov    0x8(%ebp),%eax
    123f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1242:	90                   	nop
    1243:	8b 55 0c             	mov    0xc(%ebp),%edx
    1246:	8d 42 01             	lea    0x1(%edx),%eax
    1249:	89 45 0c             	mov    %eax,0xc(%ebp)
    124c:	8b 45 08             	mov    0x8(%ebp),%eax
    124f:	8d 48 01             	lea    0x1(%eax),%ecx
    1252:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1255:	0f b6 12             	movzbl (%edx),%edx
    1258:	88 10                	mov    %dl,(%eax)
    125a:	0f b6 00             	movzbl (%eax),%eax
    125d:	84 c0                	test   %al,%al
    125f:	75 e2                	jne    1243 <strcpy+0x11>
    ;
  return os;
    1261:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1264:	c9                   	leave  
    1265:	c3                   	ret    

00001266 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1266:	f3 0f 1e fb          	endbr32 
    126a:	55                   	push   %ebp
    126b:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    126d:	eb 08                	jmp    1277 <strcmp+0x11>
    p++, q++;
    126f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1273:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    1277:	8b 45 08             	mov    0x8(%ebp),%eax
    127a:	0f b6 00             	movzbl (%eax),%eax
    127d:	84 c0                	test   %al,%al
    127f:	74 10                	je     1291 <strcmp+0x2b>
    1281:	8b 45 08             	mov    0x8(%ebp),%eax
    1284:	0f b6 10             	movzbl (%eax),%edx
    1287:	8b 45 0c             	mov    0xc(%ebp),%eax
    128a:	0f b6 00             	movzbl (%eax),%eax
    128d:	38 c2                	cmp    %al,%dl
    128f:	74 de                	je     126f <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	0f b6 00             	movzbl (%eax),%eax
    1297:	0f b6 d0             	movzbl %al,%edx
    129a:	8b 45 0c             	mov    0xc(%ebp),%eax
    129d:	0f b6 00             	movzbl (%eax),%eax
    12a0:	0f b6 c0             	movzbl %al,%eax
    12a3:	29 c2                	sub    %eax,%edx
    12a5:	89 d0                	mov    %edx,%eax
}
    12a7:	5d                   	pop    %ebp
    12a8:	c3                   	ret    

000012a9 <strlen>:

uint
strlen(const char *s)
{
    12a9:	f3 0f 1e fb          	endbr32 
    12ad:	55                   	push   %ebp
    12ae:	89 e5                	mov    %esp,%ebp
    12b0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    12b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    12ba:	eb 04                	jmp    12c0 <strlen+0x17>
    12bc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    12c0:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12c3:	8b 45 08             	mov    0x8(%ebp),%eax
    12c6:	01 d0                	add    %edx,%eax
    12c8:	0f b6 00             	movzbl (%eax),%eax
    12cb:	84 c0                	test   %al,%al
    12cd:	75 ed                	jne    12bc <strlen+0x13>
    ;
  return n;
    12cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12d2:	c9                   	leave  
    12d3:	c3                   	ret    

000012d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
    12d4:	f3 0f 1e fb          	endbr32 
    12d8:	55                   	push   %ebp
    12d9:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    12db:	8b 45 10             	mov    0x10(%ebp),%eax
    12de:	50                   	push   %eax
    12df:	ff 75 0c             	pushl  0xc(%ebp)
    12e2:	ff 75 08             	pushl  0x8(%ebp)
    12e5:	e8 22 ff ff ff       	call   120c <stosb>
    12ea:	83 c4 0c             	add    $0xc,%esp
  return dst;
    12ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12f0:	c9                   	leave  
    12f1:	c3                   	ret    

000012f2 <strchr>:

char*
strchr(const char *s, char c)
{
    12f2:	f3 0f 1e fb          	endbr32 
    12f6:	55                   	push   %ebp
    12f7:	89 e5                	mov    %esp,%ebp
    12f9:	83 ec 04             	sub    $0x4,%esp
    12fc:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ff:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1302:	eb 14                	jmp    1318 <strchr+0x26>
    if(*s == c)
    1304:	8b 45 08             	mov    0x8(%ebp),%eax
    1307:	0f b6 00             	movzbl (%eax),%eax
    130a:	38 45 fc             	cmp    %al,-0x4(%ebp)
    130d:	75 05                	jne    1314 <strchr+0x22>
      return (char*)s;
    130f:	8b 45 08             	mov    0x8(%ebp),%eax
    1312:	eb 13                	jmp    1327 <strchr+0x35>
  for(; *s; s++)
    1314:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1318:	8b 45 08             	mov    0x8(%ebp),%eax
    131b:	0f b6 00             	movzbl (%eax),%eax
    131e:	84 c0                	test   %al,%al
    1320:	75 e2                	jne    1304 <strchr+0x12>
  return 0;
    1322:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1327:	c9                   	leave  
    1328:	c3                   	ret    

00001329 <gets>:

char*
gets(char *buf, int max)
{
    1329:	f3 0f 1e fb          	endbr32 
    132d:	55                   	push   %ebp
    132e:	89 e5                	mov    %esp,%ebp
    1330:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1333:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    133a:	eb 42                	jmp    137e <gets+0x55>
    cc = read(0, &c, 1);
    133c:	83 ec 04             	sub    $0x4,%esp
    133f:	6a 01                	push   $0x1
    1341:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1344:	50                   	push   %eax
    1345:	6a 00                	push   $0x0
    1347:	e8 53 01 00 00       	call   149f <read>
    134c:	83 c4 10             	add    $0x10,%esp
    134f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1352:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1356:	7e 33                	jle    138b <gets+0x62>
      break;
    buf[i++] = c;
    1358:	8b 45 f4             	mov    -0xc(%ebp),%eax
    135b:	8d 50 01             	lea    0x1(%eax),%edx
    135e:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1361:	89 c2                	mov    %eax,%edx
    1363:	8b 45 08             	mov    0x8(%ebp),%eax
    1366:	01 c2                	add    %eax,%edx
    1368:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    136c:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    136e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1372:	3c 0a                	cmp    $0xa,%al
    1374:	74 16                	je     138c <gets+0x63>
    1376:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    137a:	3c 0d                	cmp    $0xd,%al
    137c:	74 0e                	je     138c <gets+0x63>
  for(i=0; i+1 < max; ){
    137e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1381:	83 c0 01             	add    $0x1,%eax
    1384:	39 45 0c             	cmp    %eax,0xc(%ebp)
    1387:	7f b3                	jg     133c <gets+0x13>
    1389:	eb 01                	jmp    138c <gets+0x63>
      break;
    138b:	90                   	nop
      break;
  }
  buf[i] = '\0';
    138c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    138f:	8b 45 08             	mov    0x8(%ebp),%eax
    1392:	01 d0                	add    %edx,%eax
    1394:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1397:	8b 45 08             	mov    0x8(%ebp),%eax
}
    139a:	c9                   	leave  
    139b:	c3                   	ret    

0000139c <stat>:

int
stat(const char *n, struct stat *st)
{
    139c:	f3 0f 1e fb          	endbr32 
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13a6:	83 ec 08             	sub    $0x8,%esp
    13a9:	6a 00                	push   $0x0
    13ab:	ff 75 08             	pushl  0x8(%ebp)
    13ae:	e8 14 01 00 00       	call   14c7 <open>
    13b3:	83 c4 10             	add    $0x10,%esp
    13b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    13b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13bd:	79 07                	jns    13c6 <stat+0x2a>
    return -1;
    13bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13c4:	eb 25                	jmp    13eb <stat+0x4f>
  r = fstat(fd, st);
    13c6:	83 ec 08             	sub    $0x8,%esp
    13c9:	ff 75 0c             	pushl  0xc(%ebp)
    13cc:	ff 75 f4             	pushl  -0xc(%ebp)
    13cf:	e8 0b 01 00 00       	call   14df <fstat>
    13d4:	83 c4 10             	add    $0x10,%esp
    13d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    13da:	83 ec 0c             	sub    $0xc,%esp
    13dd:	ff 75 f4             	pushl  -0xc(%ebp)
    13e0:	e8 ca 00 00 00       	call   14af <close>
    13e5:	83 c4 10             	add    $0x10,%esp
  return r;
    13e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    13eb:	c9                   	leave  
    13ec:	c3                   	ret    

000013ed <atoi>:

int
atoi(const char *s)
{
    13ed:	f3 0f 1e fb          	endbr32 
    13f1:	55                   	push   %ebp
    13f2:	89 e5                	mov    %esp,%ebp
    13f4:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    13f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    13fe:	eb 25                	jmp    1425 <atoi+0x38>
    n = n*10 + *s++ - '0';
    1400:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1403:	89 d0                	mov    %edx,%eax
    1405:	c1 e0 02             	shl    $0x2,%eax
    1408:	01 d0                	add    %edx,%eax
    140a:	01 c0                	add    %eax,%eax
    140c:	89 c1                	mov    %eax,%ecx
    140e:	8b 45 08             	mov    0x8(%ebp),%eax
    1411:	8d 50 01             	lea    0x1(%eax),%edx
    1414:	89 55 08             	mov    %edx,0x8(%ebp)
    1417:	0f b6 00             	movzbl (%eax),%eax
    141a:	0f be c0             	movsbl %al,%eax
    141d:	01 c8                	add    %ecx,%eax
    141f:	83 e8 30             	sub    $0x30,%eax
    1422:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1425:	8b 45 08             	mov    0x8(%ebp),%eax
    1428:	0f b6 00             	movzbl (%eax),%eax
    142b:	3c 2f                	cmp    $0x2f,%al
    142d:	7e 0a                	jle    1439 <atoi+0x4c>
    142f:	8b 45 08             	mov    0x8(%ebp),%eax
    1432:	0f b6 00             	movzbl (%eax),%eax
    1435:	3c 39                	cmp    $0x39,%al
    1437:	7e c7                	jle    1400 <atoi+0x13>
  return n;
    1439:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    143c:	c9                   	leave  
    143d:	c3                   	ret    

0000143e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    143e:	f3 0f 1e fb          	endbr32 
    1442:	55                   	push   %ebp
    1443:	89 e5                	mov    %esp,%ebp
    1445:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    1448:	8b 45 08             	mov    0x8(%ebp),%eax
    144b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    144e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1451:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1454:	eb 17                	jmp    146d <memmove+0x2f>
    *dst++ = *src++;
    1456:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1459:	8d 42 01             	lea    0x1(%edx),%eax
    145c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    145f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1462:	8d 48 01             	lea    0x1(%eax),%ecx
    1465:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    1468:	0f b6 12             	movzbl (%edx),%edx
    146b:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    146d:	8b 45 10             	mov    0x10(%ebp),%eax
    1470:	8d 50 ff             	lea    -0x1(%eax),%edx
    1473:	89 55 10             	mov    %edx,0x10(%ebp)
    1476:	85 c0                	test   %eax,%eax
    1478:	7f dc                	jg     1456 <memmove+0x18>
  return vdst;
    147a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    147d:	c9                   	leave  
    147e:	c3                   	ret    

0000147f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    147f:	b8 01 00 00 00       	mov    $0x1,%eax
    1484:	cd 40                	int    $0x40
    1486:	c3                   	ret    

00001487 <exit>:
SYSCALL(exit)
    1487:	b8 02 00 00 00       	mov    $0x2,%eax
    148c:	cd 40                	int    $0x40
    148e:	c3                   	ret    

0000148f <wait>:
SYSCALL(wait)
    148f:	b8 03 00 00 00       	mov    $0x3,%eax
    1494:	cd 40                	int    $0x40
    1496:	c3                   	ret    

00001497 <pipe>:
SYSCALL(pipe)
    1497:	b8 04 00 00 00       	mov    $0x4,%eax
    149c:	cd 40                	int    $0x40
    149e:	c3                   	ret    

0000149f <read>:
SYSCALL(read)
    149f:	b8 05 00 00 00       	mov    $0x5,%eax
    14a4:	cd 40                	int    $0x40
    14a6:	c3                   	ret    

000014a7 <write>:
SYSCALL(write)
    14a7:	b8 10 00 00 00       	mov    $0x10,%eax
    14ac:	cd 40                	int    $0x40
    14ae:	c3                   	ret    

000014af <close>:
SYSCALL(close)
    14af:	b8 15 00 00 00       	mov    $0x15,%eax
    14b4:	cd 40                	int    $0x40
    14b6:	c3                   	ret    

000014b7 <kill>:
SYSCALL(kill)
    14b7:	b8 06 00 00 00       	mov    $0x6,%eax
    14bc:	cd 40                	int    $0x40
    14be:	c3                   	ret    

000014bf <exec>:
SYSCALL(exec)
    14bf:	b8 07 00 00 00       	mov    $0x7,%eax
    14c4:	cd 40                	int    $0x40
    14c6:	c3                   	ret    

000014c7 <open>:
SYSCALL(open)
    14c7:	b8 0f 00 00 00       	mov    $0xf,%eax
    14cc:	cd 40                	int    $0x40
    14ce:	c3                   	ret    

000014cf <mknod>:
SYSCALL(mknod)
    14cf:	b8 11 00 00 00       	mov    $0x11,%eax
    14d4:	cd 40                	int    $0x40
    14d6:	c3                   	ret    

000014d7 <unlink>:
SYSCALL(unlink)
    14d7:	b8 12 00 00 00       	mov    $0x12,%eax
    14dc:	cd 40                	int    $0x40
    14de:	c3                   	ret    

000014df <fstat>:
SYSCALL(fstat)
    14df:	b8 08 00 00 00       	mov    $0x8,%eax
    14e4:	cd 40                	int    $0x40
    14e6:	c3                   	ret    

000014e7 <link>:
SYSCALL(link)
    14e7:	b8 13 00 00 00       	mov    $0x13,%eax
    14ec:	cd 40                	int    $0x40
    14ee:	c3                   	ret    

000014ef <mkdir>:
SYSCALL(mkdir)
    14ef:	b8 14 00 00 00       	mov    $0x14,%eax
    14f4:	cd 40                	int    $0x40
    14f6:	c3                   	ret    

000014f7 <chdir>:
SYSCALL(chdir)
    14f7:	b8 09 00 00 00       	mov    $0x9,%eax
    14fc:	cd 40                	int    $0x40
    14fe:	c3                   	ret    

000014ff <dup>:
SYSCALL(dup)
    14ff:	b8 0a 00 00 00       	mov    $0xa,%eax
    1504:	cd 40                	int    $0x40
    1506:	c3                   	ret    

00001507 <getpid>:
SYSCALL(getpid)
    1507:	b8 0b 00 00 00       	mov    $0xb,%eax
    150c:	cd 40                	int    $0x40
    150e:	c3                   	ret    

0000150f <sbrk>:
SYSCALL(sbrk)
    150f:	b8 0c 00 00 00       	mov    $0xc,%eax
    1514:	cd 40                	int    $0x40
    1516:	c3                   	ret    

00001517 <sleep>:
SYSCALL(sleep)
    1517:	b8 0d 00 00 00       	mov    $0xd,%eax
    151c:	cd 40                	int    $0x40
    151e:	c3                   	ret    

0000151f <uptime>:
SYSCALL(uptime)
    151f:	b8 0e 00 00 00       	mov    $0xe,%eax
    1524:	cd 40                	int    $0x40
    1526:	c3                   	ret    

00001527 <settickets>:
SYSCALL(settickets)
    1527:	b8 16 00 00 00       	mov    $0x16,%eax
    152c:	cd 40                	int    $0x40
    152e:	c3                   	ret    

0000152f <getpinfo>:
SYSCALL(getpinfo)
    152f:	b8 17 00 00 00       	mov    $0x17,%eax
    1534:	cd 40                	int    $0x40
    1536:	c3                   	ret    

00001537 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1537:	f3 0f 1e fb          	endbr32 
    153b:	55                   	push   %ebp
    153c:	89 e5                	mov    %esp,%ebp
    153e:	83 ec 18             	sub    $0x18,%esp
    1541:	8b 45 0c             	mov    0xc(%ebp),%eax
    1544:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1547:	83 ec 04             	sub    $0x4,%esp
    154a:	6a 01                	push   $0x1
    154c:	8d 45 f4             	lea    -0xc(%ebp),%eax
    154f:	50                   	push   %eax
    1550:	ff 75 08             	pushl  0x8(%ebp)
    1553:	e8 4f ff ff ff       	call   14a7 <write>
    1558:	83 c4 10             	add    $0x10,%esp
}
    155b:	90                   	nop
    155c:	c9                   	leave  
    155d:	c3                   	ret    

0000155e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    155e:	f3 0f 1e fb          	endbr32 
    1562:	55                   	push   %ebp
    1563:	89 e5                	mov    %esp,%ebp
    1565:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1568:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    156f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1573:	74 17                	je     158c <printint+0x2e>
    1575:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1579:	79 11                	jns    158c <printint+0x2e>
    neg = 1;
    157b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1582:	8b 45 0c             	mov    0xc(%ebp),%eax
    1585:	f7 d8                	neg    %eax
    1587:	89 45 ec             	mov    %eax,-0x14(%ebp)
    158a:	eb 06                	jmp    1592 <printint+0x34>
  } else {
    x = xx;
    158c:	8b 45 0c             	mov    0xc(%ebp),%eax
    158f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1592:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1599:	8b 4d 10             	mov    0x10(%ebp),%ecx
    159c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    159f:	ba 00 00 00 00       	mov    $0x0,%edx
    15a4:	f7 f1                	div    %ecx
    15a6:	89 d1                	mov    %edx,%ecx
    15a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ab:	8d 50 01             	lea    0x1(%eax),%edx
    15ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
    15b1:	0f b6 91 d8 1c 00 00 	movzbl 0x1cd8(%ecx),%edx
    15b8:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    15bc:	8b 4d 10             	mov    0x10(%ebp),%ecx
    15bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15c2:	ba 00 00 00 00       	mov    $0x0,%edx
    15c7:	f7 f1                	div    %ecx
    15c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    15cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15d0:	75 c7                	jne    1599 <printint+0x3b>
  if(neg)
    15d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15d6:	74 2d                	je     1605 <printint+0xa7>
    buf[i++] = '-';
    15d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15db:	8d 50 01             	lea    0x1(%eax),%edx
    15de:	89 55 f4             	mov    %edx,-0xc(%ebp)
    15e1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    15e6:	eb 1d                	jmp    1605 <printint+0xa7>
    putc(fd, buf[i]);
    15e8:	8d 55 dc             	lea    -0x24(%ebp),%edx
    15eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ee:	01 d0                	add    %edx,%eax
    15f0:	0f b6 00             	movzbl (%eax),%eax
    15f3:	0f be c0             	movsbl %al,%eax
    15f6:	83 ec 08             	sub    $0x8,%esp
    15f9:	50                   	push   %eax
    15fa:	ff 75 08             	pushl  0x8(%ebp)
    15fd:	e8 35 ff ff ff       	call   1537 <putc>
    1602:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    1605:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1609:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    160d:	79 d9                	jns    15e8 <printint+0x8a>
}
    160f:	90                   	nop
    1610:	90                   	nop
    1611:	c9                   	leave  
    1612:	c3                   	ret    

00001613 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1613:	f3 0f 1e fb          	endbr32 
    1617:	55                   	push   %ebp
    1618:	89 e5                	mov    %esp,%ebp
    161a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    161d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1624:	8d 45 0c             	lea    0xc(%ebp),%eax
    1627:	83 c0 04             	add    $0x4,%eax
    162a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    162d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1634:	e9 59 01 00 00       	jmp    1792 <printf+0x17f>
    c = fmt[i] & 0xff;
    1639:	8b 55 0c             	mov    0xc(%ebp),%edx
    163c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    163f:	01 d0                	add    %edx,%eax
    1641:	0f b6 00             	movzbl (%eax),%eax
    1644:	0f be c0             	movsbl %al,%eax
    1647:	25 ff 00 00 00       	and    $0xff,%eax
    164c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    164f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1653:	75 2c                	jne    1681 <printf+0x6e>
      if(c == '%'){
    1655:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1659:	75 0c                	jne    1667 <printf+0x54>
        state = '%';
    165b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1662:	e9 27 01 00 00       	jmp    178e <printf+0x17b>
      } else {
        putc(fd, c);
    1667:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    166a:	0f be c0             	movsbl %al,%eax
    166d:	83 ec 08             	sub    $0x8,%esp
    1670:	50                   	push   %eax
    1671:	ff 75 08             	pushl  0x8(%ebp)
    1674:	e8 be fe ff ff       	call   1537 <putc>
    1679:	83 c4 10             	add    $0x10,%esp
    167c:	e9 0d 01 00 00       	jmp    178e <printf+0x17b>
      }
    } else if(state == '%'){
    1681:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1685:	0f 85 03 01 00 00    	jne    178e <printf+0x17b>
      if(c == 'd'){
    168b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    168f:	75 1e                	jne    16af <printf+0x9c>
        printint(fd, *ap, 10, 1);
    1691:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1694:	8b 00                	mov    (%eax),%eax
    1696:	6a 01                	push   $0x1
    1698:	6a 0a                	push   $0xa
    169a:	50                   	push   %eax
    169b:	ff 75 08             	pushl  0x8(%ebp)
    169e:	e8 bb fe ff ff       	call   155e <printint>
    16a3:	83 c4 10             	add    $0x10,%esp
        ap++;
    16a6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16aa:	e9 d8 00 00 00       	jmp    1787 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    16af:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    16b3:	74 06                	je     16bb <printf+0xa8>
    16b5:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    16b9:	75 1e                	jne    16d9 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    16bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16be:	8b 00                	mov    (%eax),%eax
    16c0:	6a 00                	push   $0x0
    16c2:	6a 10                	push   $0x10
    16c4:	50                   	push   %eax
    16c5:	ff 75 08             	pushl  0x8(%ebp)
    16c8:	e8 91 fe ff ff       	call   155e <printint>
    16cd:	83 c4 10             	add    $0x10,%esp
        ap++;
    16d0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16d4:	e9 ae 00 00 00       	jmp    1787 <printf+0x174>
      } else if(c == 's'){
    16d9:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    16dd:	75 43                	jne    1722 <printf+0x10f>
        s = (char*)*ap;
    16df:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16e2:	8b 00                	mov    (%eax),%eax
    16e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    16e7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    16eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16ef:	75 25                	jne    1716 <printf+0x103>
          s = "(null)";
    16f1:	c7 45 f4 6b 1a 00 00 	movl   $0x1a6b,-0xc(%ebp)
        while(*s != 0){
    16f8:	eb 1c                	jmp    1716 <printf+0x103>
          putc(fd, *s);
    16fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fd:	0f b6 00             	movzbl (%eax),%eax
    1700:	0f be c0             	movsbl %al,%eax
    1703:	83 ec 08             	sub    $0x8,%esp
    1706:	50                   	push   %eax
    1707:	ff 75 08             	pushl  0x8(%ebp)
    170a:	e8 28 fe ff ff       	call   1537 <putc>
    170f:	83 c4 10             	add    $0x10,%esp
          s++;
    1712:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1716:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1719:	0f b6 00             	movzbl (%eax),%eax
    171c:	84 c0                	test   %al,%al
    171e:	75 da                	jne    16fa <printf+0xe7>
    1720:	eb 65                	jmp    1787 <printf+0x174>
        }
      } else if(c == 'c'){
    1722:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1726:	75 1d                	jne    1745 <printf+0x132>
        putc(fd, *ap);
    1728:	8b 45 e8             	mov    -0x18(%ebp),%eax
    172b:	8b 00                	mov    (%eax),%eax
    172d:	0f be c0             	movsbl %al,%eax
    1730:	83 ec 08             	sub    $0x8,%esp
    1733:	50                   	push   %eax
    1734:	ff 75 08             	pushl  0x8(%ebp)
    1737:	e8 fb fd ff ff       	call   1537 <putc>
    173c:	83 c4 10             	add    $0x10,%esp
        ap++;
    173f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1743:	eb 42                	jmp    1787 <printf+0x174>
      } else if(c == '%'){
    1745:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1749:	75 17                	jne    1762 <printf+0x14f>
        putc(fd, c);
    174b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    174e:	0f be c0             	movsbl %al,%eax
    1751:	83 ec 08             	sub    $0x8,%esp
    1754:	50                   	push   %eax
    1755:	ff 75 08             	pushl  0x8(%ebp)
    1758:	e8 da fd ff ff       	call   1537 <putc>
    175d:	83 c4 10             	add    $0x10,%esp
    1760:	eb 25                	jmp    1787 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1762:	83 ec 08             	sub    $0x8,%esp
    1765:	6a 25                	push   $0x25
    1767:	ff 75 08             	pushl  0x8(%ebp)
    176a:	e8 c8 fd ff ff       	call   1537 <putc>
    176f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1772:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1775:	0f be c0             	movsbl %al,%eax
    1778:	83 ec 08             	sub    $0x8,%esp
    177b:	50                   	push   %eax
    177c:	ff 75 08             	pushl  0x8(%ebp)
    177f:	e8 b3 fd ff ff       	call   1537 <putc>
    1784:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1787:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    178e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1792:	8b 55 0c             	mov    0xc(%ebp),%edx
    1795:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1798:	01 d0                	add    %edx,%eax
    179a:	0f b6 00             	movzbl (%eax),%eax
    179d:	84 c0                	test   %al,%al
    179f:	0f 85 94 fe ff ff    	jne    1639 <printf+0x26>
    }
  }
}
    17a5:	90                   	nop
    17a6:	90                   	nop
    17a7:	c9                   	leave  
    17a8:	c3                   	ret    

000017a9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    17a9:	f3 0f 1e fb          	endbr32 
    17ad:	55                   	push   %ebp
    17ae:	89 e5                	mov    %esp,%ebp
    17b0:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    17b3:	8b 45 08             	mov    0x8(%ebp),%eax
    17b6:	83 e8 08             	sub    $0x8,%eax
    17b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17bc:	a1 f4 1c 00 00       	mov    0x1cf4,%eax
    17c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17c4:	eb 24                	jmp    17ea <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c9:	8b 00                	mov    (%eax),%eax
    17cb:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    17ce:	72 12                	jb     17e2 <free+0x39>
    17d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17d3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17d6:	77 24                	ja     17fc <free+0x53>
    17d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17db:	8b 00                	mov    (%eax),%eax
    17dd:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    17e0:	72 1a                	jb     17fc <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e5:	8b 00                	mov    (%eax),%eax
    17e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17ed:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17f0:	76 d4                	jbe    17c6 <free+0x1d>
    17f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f5:	8b 00                	mov    (%eax),%eax
    17f7:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    17fa:	73 ca                	jae    17c6 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    17fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17ff:	8b 40 04             	mov    0x4(%eax),%eax
    1802:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1809:	8b 45 f8             	mov    -0x8(%ebp),%eax
    180c:	01 c2                	add    %eax,%edx
    180e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1811:	8b 00                	mov    (%eax),%eax
    1813:	39 c2                	cmp    %eax,%edx
    1815:	75 24                	jne    183b <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1817:	8b 45 f8             	mov    -0x8(%ebp),%eax
    181a:	8b 50 04             	mov    0x4(%eax),%edx
    181d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1820:	8b 00                	mov    (%eax),%eax
    1822:	8b 40 04             	mov    0x4(%eax),%eax
    1825:	01 c2                	add    %eax,%edx
    1827:	8b 45 f8             	mov    -0x8(%ebp),%eax
    182a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    182d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1830:	8b 00                	mov    (%eax),%eax
    1832:	8b 10                	mov    (%eax),%edx
    1834:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1837:	89 10                	mov    %edx,(%eax)
    1839:	eb 0a                	jmp    1845 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    183b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    183e:	8b 10                	mov    (%eax),%edx
    1840:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1843:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1845:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1848:	8b 40 04             	mov    0x4(%eax),%eax
    184b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1852:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1855:	01 d0                	add    %edx,%eax
    1857:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    185a:	75 20                	jne    187c <free+0xd3>
    p->s.size += bp->s.size;
    185c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    185f:	8b 50 04             	mov    0x4(%eax),%edx
    1862:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1865:	8b 40 04             	mov    0x4(%eax),%eax
    1868:	01 c2                	add    %eax,%edx
    186a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    186d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1870:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1873:	8b 10                	mov    (%eax),%edx
    1875:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1878:	89 10                	mov    %edx,(%eax)
    187a:	eb 08                	jmp    1884 <free+0xdb>
  } else
    p->s.ptr = bp;
    187c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    187f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1882:	89 10                	mov    %edx,(%eax)
  freep = p;
    1884:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1887:	a3 f4 1c 00 00       	mov    %eax,0x1cf4
}
    188c:	90                   	nop
    188d:	c9                   	leave  
    188e:	c3                   	ret    

0000188f <morecore>:

static Header*
morecore(uint nu)
{
    188f:	f3 0f 1e fb          	endbr32 
    1893:	55                   	push   %ebp
    1894:	89 e5                	mov    %esp,%ebp
    1896:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1899:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    18a0:	77 07                	ja     18a9 <morecore+0x1a>
    nu = 4096;
    18a2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    18a9:	8b 45 08             	mov    0x8(%ebp),%eax
    18ac:	c1 e0 03             	shl    $0x3,%eax
    18af:	83 ec 0c             	sub    $0xc,%esp
    18b2:	50                   	push   %eax
    18b3:	e8 57 fc ff ff       	call   150f <sbrk>
    18b8:	83 c4 10             	add    $0x10,%esp
    18bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    18be:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    18c2:	75 07                	jne    18cb <morecore+0x3c>
    return 0;
    18c4:	b8 00 00 00 00       	mov    $0x0,%eax
    18c9:	eb 26                	jmp    18f1 <morecore+0x62>
  hp = (Header*)p;
    18cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    18d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18d4:	8b 55 08             	mov    0x8(%ebp),%edx
    18d7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    18da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18dd:	83 c0 08             	add    $0x8,%eax
    18e0:	83 ec 0c             	sub    $0xc,%esp
    18e3:	50                   	push   %eax
    18e4:	e8 c0 fe ff ff       	call   17a9 <free>
    18e9:	83 c4 10             	add    $0x10,%esp
  return freep;
    18ec:	a1 f4 1c 00 00       	mov    0x1cf4,%eax
}
    18f1:	c9                   	leave  
    18f2:	c3                   	ret    

000018f3 <malloc>:

void*
malloc(uint nbytes)
{
    18f3:	f3 0f 1e fb          	endbr32 
    18f7:	55                   	push   %ebp
    18f8:	89 e5                	mov    %esp,%ebp
    18fa:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1900:	83 c0 07             	add    $0x7,%eax
    1903:	c1 e8 03             	shr    $0x3,%eax
    1906:	83 c0 01             	add    $0x1,%eax
    1909:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    190c:	a1 f4 1c 00 00       	mov    0x1cf4,%eax
    1911:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1914:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1918:	75 23                	jne    193d <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    191a:	c7 45 f0 ec 1c 00 00 	movl   $0x1cec,-0x10(%ebp)
    1921:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1924:	a3 f4 1c 00 00       	mov    %eax,0x1cf4
    1929:	a1 f4 1c 00 00       	mov    0x1cf4,%eax
    192e:	a3 ec 1c 00 00       	mov    %eax,0x1cec
    base.s.size = 0;
    1933:	c7 05 f0 1c 00 00 00 	movl   $0x0,0x1cf0
    193a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    193d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1940:	8b 00                	mov    (%eax),%eax
    1942:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1945:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1948:	8b 40 04             	mov    0x4(%eax),%eax
    194b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    194e:	77 4d                	ja     199d <malloc+0xaa>
      if(p->s.size == nunits)
    1950:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1953:	8b 40 04             	mov    0x4(%eax),%eax
    1956:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1959:	75 0c                	jne    1967 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    195b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    195e:	8b 10                	mov    (%eax),%edx
    1960:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1963:	89 10                	mov    %edx,(%eax)
    1965:	eb 26                	jmp    198d <malloc+0x9a>
      else {
        p->s.size -= nunits;
    1967:	8b 45 f4             	mov    -0xc(%ebp),%eax
    196a:	8b 40 04             	mov    0x4(%eax),%eax
    196d:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1970:	89 c2                	mov    %eax,%edx
    1972:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1975:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1978:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197b:	8b 40 04             	mov    0x4(%eax),%eax
    197e:	c1 e0 03             	shl    $0x3,%eax
    1981:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1984:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1987:	8b 55 ec             	mov    -0x14(%ebp),%edx
    198a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    198d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1990:	a3 f4 1c 00 00       	mov    %eax,0x1cf4
      return (void*)(p + 1);
    1995:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1998:	83 c0 08             	add    $0x8,%eax
    199b:	eb 3b                	jmp    19d8 <malloc+0xe5>
    }
    if(p == freep)
    199d:	a1 f4 1c 00 00       	mov    0x1cf4,%eax
    19a2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    19a5:	75 1e                	jne    19c5 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    19a7:	83 ec 0c             	sub    $0xc,%esp
    19aa:	ff 75 ec             	pushl  -0x14(%ebp)
    19ad:	e8 dd fe ff ff       	call   188f <morecore>
    19b2:	83 c4 10             	add    $0x10,%esp
    19b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19bc:	75 07                	jne    19c5 <malloc+0xd2>
        return 0;
    19be:	b8 00 00 00 00       	mov    $0x0,%eax
    19c3:	eb 13                	jmp    19d8 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ce:	8b 00                	mov    (%eax),%eax
    19d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    19d3:	e9 6d ff ff ff       	jmp    1945 <malloc+0x52>
  }
}
    19d8:	c9                   	leave  
    19d9:	c3                   	ret    
