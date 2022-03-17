
_test_13:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "user.h"
#include "fcntl.h"
#include "pstat.h"

int
main(int argc, char *argv[]) {
    1000:	f3 0f 1e fb          	endbr32 
    1004:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1008:	83 e4 f0             	and    $0xfffffff0,%esp
    100b:	ff 71 fc             	pushl  -0x4(%ecx)
    100e:	55                   	push   %ebp
    100f:	89 e5                	mov    %esp,%ebp
    1011:	51                   	push   %ecx
    1012:	81 ec 54 04 00 00    	sub    $0x454,%esp
  
  char* p1_file = "P1.txt";
    1018:	c7 45 f4 f8 19 00 00 	movl   $0x19f8,-0xc(%ebp)
  char* p2_file = "P2.txt";
    101f:	c7 45 f0 ff 19 00 00 	movl   $0x19ff,-0x10(%ebp)
  struct pstat pstat;

  int pid1, pid2;
  int fd1, fd2;

  fd1 = open(p1_file, O_CREATE | O_WRONLY);
    1026:	83 ec 08             	sub    $0x8,%esp
    1029:	68 01 02 00 00       	push   $0x201
    102e:	ff 75 f4             	pushl  -0xc(%ebp)
    1031:	e8 ab 04 00 00       	call   14e1 <open>
    1036:	83 c4 10             	add    $0x10,%esp
    1039:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if (fd1 < 0) {
    103c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1040:	79 1a                	jns    105c <main+0x5c>
    printf(2, "Open %s failed\n", p1_file);
    1042:	83 ec 04             	sub    $0x4,%esp
    1045:	ff 75 f4             	pushl  -0xc(%ebp)
    1048:	68 06 1a 00 00       	push   $0x1a06
    104d:	6a 02                	push   $0x2
    104f:	e8 d9 05 00 00       	call   162d <printf>
    1054:	83 c4 10             	add    $0x10,%esp
    exit();
    1057:	e8 45 04 00 00       	call   14a1 <exit>
  }
 
  fd2 = open(p2_file, O_CREATE | O_WRONLY);
    105c:	83 ec 08             	sub    $0x8,%esp
    105f:	68 01 02 00 00       	push   $0x201
    1064:	ff 75 f0             	pushl  -0x10(%ebp)
    1067:	e8 75 04 00 00       	call   14e1 <open>
    106c:	83 c4 10             	add    $0x10,%esp
    106f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if (fd2 < 0) {
    1072:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1076:	79 1a                	jns    1092 <main+0x92>
    printf(2, "Open %s failed\n", p2_file);
    1078:	83 ec 04             	sub    $0x4,%esp
    107b:	ff 75 f0             	pushl  -0x10(%ebp)
    107e:	68 06 1a 00 00       	push   $0x1a06
    1083:	6a 02                	push   $0x2
    1085:	e8 a3 05 00 00       	call   162d <printf>
    108a:	83 c4 10             	add    $0x10,%esp
    exit();
    108d:	e8 0f 04 00 00       	call   14a1 <exit>
  }

  pid1 = fork();
    1092:	e8 02 04 00 00       	call   1499 <fork>
    1097:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if (pid1 < 0) {
    109a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    109e:	79 14                	jns    10b4 <main+0xb4>
    printf(2, "Fork child process 1 failed\n");
    10a0:	83 ec 08             	sub    $0x8,%esp
    10a3:	68 16 1a 00 00       	push   $0x1a16
    10a8:	6a 02                	push   $0x2
    10aa:	e8 7e 05 00 00       	call   162d <printf>
    10af:	83 c4 10             	add    $0x10,%esp
    10b2:	eb 28                	jmp    10dc <main+0xdc>
  } else if (pid1 == 0) { // child process 1
    10b4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    10b8:	75 22                	jne    10dc <main+0xdc>
    settickets(10);
    10ba:	83 ec 0c             	sub    $0xc,%esp
    10bd:	6a 0a                	push   $0xa
    10bf:	e8 7d 04 00 00       	call   1541 <settickets>
    10c4:	83 c4 10             	add    $0x10,%esp
    while (1) 
      printf(fd1, "A");
    10c7:	83 ec 08             	sub    $0x8,%esp
    10ca:	68 33 1a 00 00       	push   $0x1a33
    10cf:	ff 75 ec             	pushl  -0x14(%ebp)
    10d2:	e8 56 05 00 00       	call   162d <printf>
    10d7:	83 c4 10             	add    $0x10,%esp
    10da:	eb eb                	jmp    10c7 <main+0xc7>
  } 
  
  pid2 = fork();
    10dc:	e8 b8 03 00 00       	call   1499 <fork>
    10e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if (pid2 < 0) {
    10e4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    10e8:	79 17                	jns    1101 <main+0x101>
    printf(2, "Fork child process 2 failed\n");
    10ea:	83 ec 08             	sub    $0x8,%esp
    10ed:	68 35 1a 00 00       	push   $0x1a35
    10f2:	6a 02                	push   $0x2
    10f4:	e8 34 05 00 00       	call   162d <printf>
    10f9:	83 c4 10             	add    $0x10,%esp
    exit();
    10fc:	e8 a0 03 00 00       	call   14a1 <exit>
  } else if (pid2 == 0) { // child process 2
    1101:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    1105:	75 22                	jne    1129 <main+0x129>
    settickets(2);
    1107:	83 ec 0c             	sub    $0xc,%esp
    110a:	6a 02                	push   $0x2
    110c:	e8 30 04 00 00       	call   1541 <settickets>
    1111:	83 c4 10             	add    $0x10,%esp
    while (1) 
      printf(fd2, "A");
    1114:	83 ec 08             	sub    $0x8,%esp
    1117:	68 33 1a 00 00       	push   $0x1a33
    111c:	ff 75 e8             	pushl  -0x18(%ebp)
    111f:	e8 09 05 00 00       	call   162d <printf>
    1124:	83 c4 10             	add    $0x10,%esp
    1127:	eb eb                	jmp    1114 <main+0x114>
  }

  sleep(1000);
    1129:	83 ec 0c             	sub    $0xc,%esp
    112c:	68 e8 03 00 00       	push   $0x3e8
    1131:	e8 fb 03 00 00       	call   1531 <sleep>
    1136:	83 c4 10             	add    $0x10,%esp
  getpinfo(&pstat);
    1139:	83 ec 0c             	sub    $0xc,%esp
    113c:	8d 85 b8 fb ff ff    	lea    -0x448(%ebp),%eax
    1142:	50                   	push   %eax
    1143:	e8 01 04 00 00       	call   1549 <getpinfo>
    1148:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
    114b:	83 ec 0c             	sub    $0xc,%esp
    114e:	ff 75 e4             	pushl  -0x1c(%ebp)
    1151:	e8 7b 03 00 00       	call   14d1 <kill>
    1156:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
    1159:	83 ec 0c             	sub    $0xc,%esp
    115c:	ff 75 e0             	pushl  -0x20(%ebp)
    115f:	e8 6d 03 00 00       	call   14d1 <kill>
    1164:	83 c4 10             	add    $0x10,%esp

  wait();
    1167:	e8 3d 03 00 00       	call   14a9 <wait>
  wait();
    116c:	e8 38 03 00 00       	call   14a9 <wait>

  fstat(fd1, &f1);
    1171:	83 ec 08             	sub    $0x8,%esp
    1174:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1177:	50                   	push   %eax
    1178:	ff 75 ec             	pushl  -0x14(%ebp)
    117b:	e8 79 03 00 00       	call   14f9 <fstat>
    1180:	83 c4 10             	add    $0x10,%esp
  fstat(fd2, &f2);
    1183:	83 ec 08             	sub    $0x8,%esp
    1186:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1189:	50                   	push   %eax
    118a:	ff 75 e8             	pushl  -0x18(%ebp)
    118d:	e8 67 03 00 00       	call   14f9 <fstat>
    1192:	83 c4 10             	add    $0x10,%esp
  // compare file size made by child process
  if (f1.size > 2.4 * f2.size) {
    1195:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1198:	89 85 b0 fb ff ff    	mov    %eax,-0x450(%ebp)
    119e:	c7 85 b4 fb ff ff 00 	movl   $0x0,-0x44c(%ebp)
    11a5:	00 00 00 
    11a8:	df ad b0 fb ff ff    	fildll -0x450(%ebp)
    11ae:	8b 45 c8             	mov    -0x38(%ebp),%eax
    11b1:	89 85 b0 fb ff ff    	mov    %eax,-0x450(%ebp)
    11b7:	c7 85 b4 fb ff ff 00 	movl   $0x0,-0x44c(%ebp)
    11be:	00 00 00 
    11c1:	df ad b0 fb ff ff    	fildll -0x450(%ebp)
    11c7:	dd 05 70 1a 00 00    	fldl   0x1a70
    11cd:	de c9                	fmulp  %st,%st(1)
    11cf:	d9 c9                	fxch   %st(1)
    11d1:	df f1                	fcomip %st(1),%st
    11d3:	dd d8                	fstp   %st(0)
    11d5:	76 12                	jbe    11e9 <main+0x1e9>
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    11d7:	83 ec 08             	sub    $0x8,%esp
    11da:	68 52 1a 00 00       	push   $0x1a52
    11df:	6a 01                	push   $0x1
    11e1:	e8 47 04 00 00       	call   162d <printf>
    11e6:	83 c4 10             	add    $0x10,%esp
  }

  close(fd1);
    11e9:	83 ec 0c             	sub    $0xc,%esp
    11ec:	ff 75 ec             	pushl  -0x14(%ebp)
    11ef:	e8 d5 02 00 00       	call   14c9 <close>
    11f4:	83 c4 10             	add    $0x10,%esp
  close(fd2);
    11f7:	83 ec 0c             	sub    $0xc,%esp
    11fa:	ff 75 e8             	pushl  -0x18(%ebp)
    11fd:	e8 c7 02 00 00       	call   14c9 <close>
    1202:	83 c4 10             	add    $0x10,%esp
  
  unlink(p1_file);
    1205:	83 ec 0c             	sub    $0xc,%esp
    1208:	ff 75 f4             	pushl  -0xc(%ebp)
    120b:	e8 e1 02 00 00       	call   14f1 <unlink>
    1210:	83 c4 10             	add    $0x10,%esp
  unlink(p2_file);
    1213:	83 ec 0c             	sub    $0xc,%esp
    1216:	ff 75 f0             	pushl  -0x10(%ebp)
    1219:	e8 d3 02 00 00       	call   14f1 <unlink>
    121e:	83 c4 10             	add    $0x10,%esp

  exit();
    1221:	e8 7b 02 00 00       	call   14a1 <exit>

00001226 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1226:	55                   	push   %ebp
    1227:	89 e5                	mov    %esp,%ebp
    1229:	57                   	push   %edi
    122a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    122b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    122e:	8b 55 10             	mov    0x10(%ebp),%edx
    1231:	8b 45 0c             	mov    0xc(%ebp),%eax
    1234:	89 cb                	mov    %ecx,%ebx
    1236:	89 df                	mov    %ebx,%edi
    1238:	89 d1                	mov    %edx,%ecx
    123a:	fc                   	cld    
    123b:	f3 aa                	rep stos %al,%es:(%edi)
    123d:	89 ca                	mov    %ecx,%edx
    123f:	89 fb                	mov    %edi,%ebx
    1241:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1244:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1247:	90                   	nop
    1248:	5b                   	pop    %ebx
    1249:	5f                   	pop    %edi
    124a:	5d                   	pop    %ebp
    124b:	c3                   	ret    

0000124c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    124c:	f3 0f 1e fb          	endbr32 
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1256:	8b 45 08             	mov    0x8(%ebp),%eax
    1259:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    125c:	90                   	nop
    125d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1260:	8d 42 01             	lea    0x1(%edx),%eax
    1263:	89 45 0c             	mov    %eax,0xc(%ebp)
    1266:	8b 45 08             	mov    0x8(%ebp),%eax
    1269:	8d 48 01             	lea    0x1(%eax),%ecx
    126c:	89 4d 08             	mov    %ecx,0x8(%ebp)
    126f:	0f b6 12             	movzbl (%edx),%edx
    1272:	88 10                	mov    %dl,(%eax)
    1274:	0f b6 00             	movzbl (%eax),%eax
    1277:	84 c0                	test   %al,%al
    1279:	75 e2                	jne    125d <strcpy+0x11>
    ;
  return os;
    127b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    127e:	c9                   	leave  
    127f:	c3                   	ret    

00001280 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1280:	f3 0f 1e fb          	endbr32 
    1284:	55                   	push   %ebp
    1285:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1287:	eb 08                	jmp    1291 <strcmp+0x11>
    p++, q++;
    1289:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    128d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	0f b6 00             	movzbl (%eax),%eax
    1297:	84 c0                	test   %al,%al
    1299:	74 10                	je     12ab <strcmp+0x2b>
    129b:	8b 45 08             	mov    0x8(%ebp),%eax
    129e:	0f b6 10             	movzbl (%eax),%edx
    12a1:	8b 45 0c             	mov    0xc(%ebp),%eax
    12a4:	0f b6 00             	movzbl (%eax),%eax
    12a7:	38 c2                	cmp    %al,%dl
    12a9:	74 de                	je     1289 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    12ab:	8b 45 08             	mov    0x8(%ebp),%eax
    12ae:	0f b6 00             	movzbl (%eax),%eax
    12b1:	0f b6 d0             	movzbl %al,%edx
    12b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b7:	0f b6 00             	movzbl (%eax),%eax
    12ba:	0f b6 c0             	movzbl %al,%eax
    12bd:	29 c2                	sub    %eax,%edx
    12bf:	89 d0                	mov    %edx,%eax
}
    12c1:	5d                   	pop    %ebp
    12c2:	c3                   	ret    

000012c3 <strlen>:

uint
strlen(const char *s)
{
    12c3:	f3 0f 1e fb          	endbr32 
    12c7:	55                   	push   %ebp
    12c8:	89 e5                	mov    %esp,%ebp
    12ca:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    12cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    12d4:	eb 04                	jmp    12da <strlen+0x17>
    12d6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    12da:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12dd:	8b 45 08             	mov    0x8(%ebp),%eax
    12e0:	01 d0                	add    %edx,%eax
    12e2:	0f b6 00             	movzbl (%eax),%eax
    12e5:	84 c0                	test   %al,%al
    12e7:	75 ed                	jne    12d6 <strlen+0x13>
    ;
  return n;
    12e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12ec:	c9                   	leave  
    12ed:	c3                   	ret    

000012ee <memset>:

void*
memset(void *dst, int c, uint n)
{
    12ee:	f3 0f 1e fb          	endbr32 
    12f2:	55                   	push   %ebp
    12f3:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    12f5:	8b 45 10             	mov    0x10(%ebp),%eax
    12f8:	50                   	push   %eax
    12f9:	ff 75 0c             	pushl  0xc(%ebp)
    12fc:	ff 75 08             	pushl  0x8(%ebp)
    12ff:	e8 22 ff ff ff       	call   1226 <stosb>
    1304:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1307:	8b 45 08             	mov    0x8(%ebp),%eax
}
    130a:	c9                   	leave  
    130b:	c3                   	ret    

0000130c <strchr>:

char*
strchr(const char *s, char c)
{
    130c:	f3 0f 1e fb          	endbr32 
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	83 ec 04             	sub    $0x4,%esp
    1316:	8b 45 0c             	mov    0xc(%ebp),%eax
    1319:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    131c:	eb 14                	jmp    1332 <strchr+0x26>
    if(*s == c)
    131e:	8b 45 08             	mov    0x8(%ebp),%eax
    1321:	0f b6 00             	movzbl (%eax),%eax
    1324:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1327:	75 05                	jne    132e <strchr+0x22>
      return (char*)s;
    1329:	8b 45 08             	mov    0x8(%ebp),%eax
    132c:	eb 13                	jmp    1341 <strchr+0x35>
  for(; *s; s++)
    132e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1332:	8b 45 08             	mov    0x8(%ebp),%eax
    1335:	0f b6 00             	movzbl (%eax),%eax
    1338:	84 c0                	test   %al,%al
    133a:	75 e2                	jne    131e <strchr+0x12>
  return 0;
    133c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1341:	c9                   	leave  
    1342:	c3                   	ret    

00001343 <gets>:

char*
gets(char *buf, int max)
{
    1343:	f3 0f 1e fb          	endbr32 
    1347:	55                   	push   %ebp
    1348:	89 e5                	mov    %esp,%ebp
    134a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    134d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1354:	eb 42                	jmp    1398 <gets+0x55>
    cc = read(0, &c, 1);
    1356:	83 ec 04             	sub    $0x4,%esp
    1359:	6a 01                	push   $0x1
    135b:	8d 45 ef             	lea    -0x11(%ebp),%eax
    135e:	50                   	push   %eax
    135f:	6a 00                	push   $0x0
    1361:	e8 53 01 00 00       	call   14b9 <read>
    1366:	83 c4 10             	add    $0x10,%esp
    1369:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    136c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1370:	7e 33                	jle    13a5 <gets+0x62>
      break;
    buf[i++] = c;
    1372:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1375:	8d 50 01             	lea    0x1(%eax),%edx
    1378:	89 55 f4             	mov    %edx,-0xc(%ebp)
    137b:	89 c2                	mov    %eax,%edx
    137d:	8b 45 08             	mov    0x8(%ebp),%eax
    1380:	01 c2                	add    %eax,%edx
    1382:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1386:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1388:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    138c:	3c 0a                	cmp    $0xa,%al
    138e:	74 16                	je     13a6 <gets+0x63>
    1390:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1394:	3c 0d                	cmp    $0xd,%al
    1396:	74 0e                	je     13a6 <gets+0x63>
  for(i=0; i+1 < max; ){
    1398:	8b 45 f4             	mov    -0xc(%ebp),%eax
    139b:	83 c0 01             	add    $0x1,%eax
    139e:	39 45 0c             	cmp    %eax,0xc(%ebp)
    13a1:	7f b3                	jg     1356 <gets+0x13>
    13a3:	eb 01                	jmp    13a6 <gets+0x63>
      break;
    13a5:	90                   	nop
      break;
  }
  buf[i] = '\0';
    13a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13a9:	8b 45 08             	mov    0x8(%ebp),%eax
    13ac:	01 d0                	add    %edx,%eax
    13ae:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    13b1:	8b 45 08             	mov    0x8(%ebp),%eax
}
    13b4:	c9                   	leave  
    13b5:	c3                   	ret    

000013b6 <stat>:

int
stat(const char *n, struct stat *st)
{
    13b6:	f3 0f 1e fb          	endbr32 
    13ba:	55                   	push   %ebp
    13bb:	89 e5                	mov    %esp,%ebp
    13bd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13c0:	83 ec 08             	sub    $0x8,%esp
    13c3:	6a 00                	push   $0x0
    13c5:	ff 75 08             	pushl  0x8(%ebp)
    13c8:	e8 14 01 00 00       	call   14e1 <open>
    13cd:	83 c4 10             	add    $0x10,%esp
    13d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    13d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13d7:	79 07                	jns    13e0 <stat+0x2a>
    return -1;
    13d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13de:	eb 25                	jmp    1405 <stat+0x4f>
  r = fstat(fd, st);
    13e0:	83 ec 08             	sub    $0x8,%esp
    13e3:	ff 75 0c             	pushl  0xc(%ebp)
    13e6:	ff 75 f4             	pushl  -0xc(%ebp)
    13e9:	e8 0b 01 00 00       	call   14f9 <fstat>
    13ee:	83 c4 10             	add    $0x10,%esp
    13f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    13f4:	83 ec 0c             	sub    $0xc,%esp
    13f7:	ff 75 f4             	pushl  -0xc(%ebp)
    13fa:	e8 ca 00 00 00       	call   14c9 <close>
    13ff:	83 c4 10             	add    $0x10,%esp
  return r;
    1402:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1405:	c9                   	leave  
    1406:	c3                   	ret    

00001407 <atoi>:

int
atoi(const char *s)
{
    1407:	f3 0f 1e fb          	endbr32 
    140b:	55                   	push   %ebp
    140c:	89 e5                	mov    %esp,%ebp
    140e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1411:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1418:	eb 25                	jmp    143f <atoi+0x38>
    n = n*10 + *s++ - '0';
    141a:	8b 55 fc             	mov    -0x4(%ebp),%edx
    141d:	89 d0                	mov    %edx,%eax
    141f:	c1 e0 02             	shl    $0x2,%eax
    1422:	01 d0                	add    %edx,%eax
    1424:	01 c0                	add    %eax,%eax
    1426:	89 c1                	mov    %eax,%ecx
    1428:	8b 45 08             	mov    0x8(%ebp),%eax
    142b:	8d 50 01             	lea    0x1(%eax),%edx
    142e:	89 55 08             	mov    %edx,0x8(%ebp)
    1431:	0f b6 00             	movzbl (%eax),%eax
    1434:	0f be c0             	movsbl %al,%eax
    1437:	01 c8                	add    %ecx,%eax
    1439:	83 e8 30             	sub    $0x30,%eax
    143c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    143f:	8b 45 08             	mov    0x8(%ebp),%eax
    1442:	0f b6 00             	movzbl (%eax),%eax
    1445:	3c 2f                	cmp    $0x2f,%al
    1447:	7e 0a                	jle    1453 <atoi+0x4c>
    1449:	8b 45 08             	mov    0x8(%ebp),%eax
    144c:	0f b6 00             	movzbl (%eax),%eax
    144f:	3c 39                	cmp    $0x39,%al
    1451:	7e c7                	jle    141a <atoi+0x13>
  return n;
    1453:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1456:	c9                   	leave  
    1457:	c3                   	ret    

00001458 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1458:	f3 0f 1e fb          	endbr32 
    145c:	55                   	push   %ebp
    145d:	89 e5                	mov    %esp,%ebp
    145f:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    1462:	8b 45 08             	mov    0x8(%ebp),%eax
    1465:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1468:	8b 45 0c             	mov    0xc(%ebp),%eax
    146b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    146e:	eb 17                	jmp    1487 <memmove+0x2f>
    *dst++ = *src++;
    1470:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1473:	8d 42 01             	lea    0x1(%edx),%eax
    1476:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1479:	8b 45 fc             	mov    -0x4(%ebp),%eax
    147c:	8d 48 01             	lea    0x1(%eax),%ecx
    147f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    1482:	0f b6 12             	movzbl (%edx),%edx
    1485:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    1487:	8b 45 10             	mov    0x10(%ebp),%eax
    148a:	8d 50 ff             	lea    -0x1(%eax),%edx
    148d:	89 55 10             	mov    %edx,0x10(%ebp)
    1490:	85 c0                	test   %eax,%eax
    1492:	7f dc                	jg     1470 <memmove+0x18>
  return vdst;
    1494:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1497:	c9                   	leave  
    1498:	c3                   	ret    

00001499 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1499:	b8 01 00 00 00       	mov    $0x1,%eax
    149e:	cd 40                	int    $0x40
    14a0:	c3                   	ret    

000014a1 <exit>:
SYSCALL(exit)
    14a1:	b8 02 00 00 00       	mov    $0x2,%eax
    14a6:	cd 40                	int    $0x40
    14a8:	c3                   	ret    

000014a9 <wait>:
SYSCALL(wait)
    14a9:	b8 03 00 00 00       	mov    $0x3,%eax
    14ae:	cd 40                	int    $0x40
    14b0:	c3                   	ret    

000014b1 <pipe>:
SYSCALL(pipe)
    14b1:	b8 04 00 00 00       	mov    $0x4,%eax
    14b6:	cd 40                	int    $0x40
    14b8:	c3                   	ret    

000014b9 <read>:
SYSCALL(read)
    14b9:	b8 05 00 00 00       	mov    $0x5,%eax
    14be:	cd 40                	int    $0x40
    14c0:	c3                   	ret    

000014c1 <write>:
SYSCALL(write)
    14c1:	b8 10 00 00 00       	mov    $0x10,%eax
    14c6:	cd 40                	int    $0x40
    14c8:	c3                   	ret    

000014c9 <close>:
SYSCALL(close)
    14c9:	b8 15 00 00 00       	mov    $0x15,%eax
    14ce:	cd 40                	int    $0x40
    14d0:	c3                   	ret    

000014d1 <kill>:
SYSCALL(kill)
    14d1:	b8 06 00 00 00       	mov    $0x6,%eax
    14d6:	cd 40                	int    $0x40
    14d8:	c3                   	ret    

000014d9 <exec>:
SYSCALL(exec)
    14d9:	b8 07 00 00 00       	mov    $0x7,%eax
    14de:	cd 40                	int    $0x40
    14e0:	c3                   	ret    

000014e1 <open>:
SYSCALL(open)
    14e1:	b8 0f 00 00 00       	mov    $0xf,%eax
    14e6:	cd 40                	int    $0x40
    14e8:	c3                   	ret    

000014e9 <mknod>:
SYSCALL(mknod)
    14e9:	b8 11 00 00 00       	mov    $0x11,%eax
    14ee:	cd 40                	int    $0x40
    14f0:	c3                   	ret    

000014f1 <unlink>:
SYSCALL(unlink)
    14f1:	b8 12 00 00 00       	mov    $0x12,%eax
    14f6:	cd 40                	int    $0x40
    14f8:	c3                   	ret    

000014f9 <fstat>:
SYSCALL(fstat)
    14f9:	b8 08 00 00 00       	mov    $0x8,%eax
    14fe:	cd 40                	int    $0x40
    1500:	c3                   	ret    

00001501 <link>:
SYSCALL(link)
    1501:	b8 13 00 00 00       	mov    $0x13,%eax
    1506:	cd 40                	int    $0x40
    1508:	c3                   	ret    

00001509 <mkdir>:
SYSCALL(mkdir)
    1509:	b8 14 00 00 00       	mov    $0x14,%eax
    150e:	cd 40                	int    $0x40
    1510:	c3                   	ret    

00001511 <chdir>:
SYSCALL(chdir)
    1511:	b8 09 00 00 00       	mov    $0x9,%eax
    1516:	cd 40                	int    $0x40
    1518:	c3                   	ret    

00001519 <dup>:
SYSCALL(dup)
    1519:	b8 0a 00 00 00       	mov    $0xa,%eax
    151e:	cd 40                	int    $0x40
    1520:	c3                   	ret    

00001521 <getpid>:
SYSCALL(getpid)
    1521:	b8 0b 00 00 00       	mov    $0xb,%eax
    1526:	cd 40                	int    $0x40
    1528:	c3                   	ret    

00001529 <sbrk>:
SYSCALL(sbrk)
    1529:	b8 0c 00 00 00       	mov    $0xc,%eax
    152e:	cd 40                	int    $0x40
    1530:	c3                   	ret    

00001531 <sleep>:
SYSCALL(sleep)
    1531:	b8 0d 00 00 00       	mov    $0xd,%eax
    1536:	cd 40                	int    $0x40
    1538:	c3                   	ret    

00001539 <uptime>:
SYSCALL(uptime)
    1539:	b8 0e 00 00 00       	mov    $0xe,%eax
    153e:	cd 40                	int    $0x40
    1540:	c3                   	ret    

00001541 <settickets>:
SYSCALL(settickets)
    1541:	b8 16 00 00 00       	mov    $0x16,%eax
    1546:	cd 40                	int    $0x40
    1548:	c3                   	ret    

00001549 <getpinfo>:
SYSCALL(getpinfo)
    1549:	b8 17 00 00 00       	mov    $0x17,%eax
    154e:	cd 40                	int    $0x40
    1550:	c3                   	ret    

00001551 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1551:	f3 0f 1e fb          	endbr32 
    1555:	55                   	push   %ebp
    1556:	89 e5                	mov    %esp,%ebp
    1558:	83 ec 18             	sub    $0x18,%esp
    155b:	8b 45 0c             	mov    0xc(%ebp),%eax
    155e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1561:	83 ec 04             	sub    $0x4,%esp
    1564:	6a 01                	push   $0x1
    1566:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1569:	50                   	push   %eax
    156a:	ff 75 08             	pushl  0x8(%ebp)
    156d:	e8 4f ff ff ff       	call   14c1 <write>
    1572:	83 c4 10             	add    $0x10,%esp
}
    1575:	90                   	nop
    1576:	c9                   	leave  
    1577:	c3                   	ret    

00001578 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1578:	f3 0f 1e fb          	endbr32 
    157c:	55                   	push   %ebp
    157d:	89 e5                	mov    %esp,%ebp
    157f:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1582:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1589:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    158d:	74 17                	je     15a6 <printint+0x2e>
    158f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1593:	79 11                	jns    15a6 <printint+0x2e>
    neg = 1;
    1595:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    159c:	8b 45 0c             	mov    0xc(%ebp),%eax
    159f:	f7 d8                	neg    %eax
    15a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    15a4:	eb 06                	jmp    15ac <printint+0x34>
  } else {
    x = xx;
    15a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    15a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    15ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    15b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
    15b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15b9:	ba 00 00 00 00       	mov    $0x0,%edx
    15be:	f7 f1                	div    %ecx
    15c0:	89 d1                	mov    %edx,%ecx
    15c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c5:	8d 50 01             	lea    0x1(%eax),%edx
    15c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
    15cb:	0f b6 91 c4 1c 00 00 	movzbl 0x1cc4(%ecx),%edx
    15d2:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    15d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
    15d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15dc:	ba 00 00 00 00       	mov    $0x0,%edx
    15e1:	f7 f1                	div    %ecx
    15e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    15e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15ea:	75 c7                	jne    15b3 <printint+0x3b>
  if(neg)
    15ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15f0:	74 2d                	je     161f <printint+0xa7>
    buf[i++] = '-';
    15f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f5:	8d 50 01             	lea    0x1(%eax),%edx
    15f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
    15fb:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1600:	eb 1d                	jmp    161f <printint+0xa7>
    putc(fd, buf[i]);
    1602:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1605:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1608:	01 d0                	add    %edx,%eax
    160a:	0f b6 00             	movzbl (%eax),%eax
    160d:	0f be c0             	movsbl %al,%eax
    1610:	83 ec 08             	sub    $0x8,%esp
    1613:	50                   	push   %eax
    1614:	ff 75 08             	pushl  0x8(%ebp)
    1617:	e8 35 ff ff ff       	call   1551 <putc>
    161c:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    161f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1623:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1627:	79 d9                	jns    1602 <printint+0x8a>
}
    1629:	90                   	nop
    162a:	90                   	nop
    162b:	c9                   	leave  
    162c:	c3                   	ret    

0000162d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    162d:	f3 0f 1e fb          	endbr32 
    1631:	55                   	push   %ebp
    1632:	89 e5                	mov    %esp,%ebp
    1634:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1637:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    163e:	8d 45 0c             	lea    0xc(%ebp),%eax
    1641:	83 c0 04             	add    $0x4,%eax
    1644:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1647:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    164e:	e9 59 01 00 00       	jmp    17ac <printf+0x17f>
    c = fmt[i] & 0xff;
    1653:	8b 55 0c             	mov    0xc(%ebp),%edx
    1656:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1659:	01 d0                	add    %edx,%eax
    165b:	0f b6 00             	movzbl (%eax),%eax
    165e:	0f be c0             	movsbl %al,%eax
    1661:	25 ff 00 00 00       	and    $0xff,%eax
    1666:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1669:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    166d:	75 2c                	jne    169b <printf+0x6e>
      if(c == '%'){
    166f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1673:	75 0c                	jne    1681 <printf+0x54>
        state = '%';
    1675:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    167c:	e9 27 01 00 00       	jmp    17a8 <printf+0x17b>
      } else {
        putc(fd, c);
    1681:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1684:	0f be c0             	movsbl %al,%eax
    1687:	83 ec 08             	sub    $0x8,%esp
    168a:	50                   	push   %eax
    168b:	ff 75 08             	pushl  0x8(%ebp)
    168e:	e8 be fe ff ff       	call   1551 <putc>
    1693:	83 c4 10             	add    $0x10,%esp
    1696:	e9 0d 01 00 00       	jmp    17a8 <printf+0x17b>
      }
    } else if(state == '%'){
    169b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    169f:	0f 85 03 01 00 00    	jne    17a8 <printf+0x17b>
      if(c == 'd'){
    16a5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    16a9:	75 1e                	jne    16c9 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    16ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16ae:	8b 00                	mov    (%eax),%eax
    16b0:	6a 01                	push   $0x1
    16b2:	6a 0a                	push   $0xa
    16b4:	50                   	push   %eax
    16b5:	ff 75 08             	pushl  0x8(%ebp)
    16b8:	e8 bb fe ff ff       	call   1578 <printint>
    16bd:	83 c4 10             	add    $0x10,%esp
        ap++;
    16c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16c4:	e9 d8 00 00 00       	jmp    17a1 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    16c9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    16cd:	74 06                	je     16d5 <printf+0xa8>
    16cf:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    16d3:	75 1e                	jne    16f3 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    16d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16d8:	8b 00                	mov    (%eax),%eax
    16da:	6a 00                	push   $0x0
    16dc:	6a 10                	push   $0x10
    16de:	50                   	push   %eax
    16df:	ff 75 08             	pushl  0x8(%ebp)
    16e2:	e8 91 fe ff ff       	call   1578 <printint>
    16e7:	83 c4 10             	add    $0x10,%esp
        ap++;
    16ea:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16ee:	e9 ae 00 00 00       	jmp    17a1 <printf+0x174>
      } else if(c == 's'){
    16f3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    16f7:	75 43                	jne    173c <printf+0x10f>
        s = (char*)*ap;
    16f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16fc:	8b 00                	mov    (%eax),%eax
    16fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1701:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1705:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1709:	75 25                	jne    1730 <printf+0x103>
          s = "(null)";
    170b:	c7 45 f4 78 1a 00 00 	movl   $0x1a78,-0xc(%ebp)
        while(*s != 0){
    1712:	eb 1c                	jmp    1730 <printf+0x103>
          putc(fd, *s);
    1714:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1717:	0f b6 00             	movzbl (%eax),%eax
    171a:	0f be c0             	movsbl %al,%eax
    171d:	83 ec 08             	sub    $0x8,%esp
    1720:	50                   	push   %eax
    1721:	ff 75 08             	pushl  0x8(%ebp)
    1724:	e8 28 fe ff ff       	call   1551 <putc>
    1729:	83 c4 10             	add    $0x10,%esp
          s++;
    172c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1730:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1733:	0f b6 00             	movzbl (%eax),%eax
    1736:	84 c0                	test   %al,%al
    1738:	75 da                	jne    1714 <printf+0xe7>
    173a:	eb 65                	jmp    17a1 <printf+0x174>
        }
      } else if(c == 'c'){
    173c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1740:	75 1d                	jne    175f <printf+0x132>
        putc(fd, *ap);
    1742:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1745:	8b 00                	mov    (%eax),%eax
    1747:	0f be c0             	movsbl %al,%eax
    174a:	83 ec 08             	sub    $0x8,%esp
    174d:	50                   	push   %eax
    174e:	ff 75 08             	pushl  0x8(%ebp)
    1751:	e8 fb fd ff ff       	call   1551 <putc>
    1756:	83 c4 10             	add    $0x10,%esp
        ap++;
    1759:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    175d:	eb 42                	jmp    17a1 <printf+0x174>
      } else if(c == '%'){
    175f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1763:	75 17                	jne    177c <printf+0x14f>
        putc(fd, c);
    1765:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1768:	0f be c0             	movsbl %al,%eax
    176b:	83 ec 08             	sub    $0x8,%esp
    176e:	50                   	push   %eax
    176f:	ff 75 08             	pushl  0x8(%ebp)
    1772:	e8 da fd ff ff       	call   1551 <putc>
    1777:	83 c4 10             	add    $0x10,%esp
    177a:	eb 25                	jmp    17a1 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    177c:	83 ec 08             	sub    $0x8,%esp
    177f:	6a 25                	push   $0x25
    1781:	ff 75 08             	pushl  0x8(%ebp)
    1784:	e8 c8 fd ff ff       	call   1551 <putc>
    1789:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    178c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    178f:	0f be c0             	movsbl %al,%eax
    1792:	83 ec 08             	sub    $0x8,%esp
    1795:	50                   	push   %eax
    1796:	ff 75 08             	pushl  0x8(%ebp)
    1799:	e8 b3 fd ff ff       	call   1551 <putc>
    179e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    17a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    17a8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    17ac:	8b 55 0c             	mov    0xc(%ebp),%edx
    17af:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b2:	01 d0                	add    %edx,%eax
    17b4:	0f b6 00             	movzbl (%eax),%eax
    17b7:	84 c0                	test   %al,%al
    17b9:	0f 85 94 fe ff ff    	jne    1653 <printf+0x26>
    }
  }
}
    17bf:	90                   	nop
    17c0:	90                   	nop
    17c1:	c9                   	leave  
    17c2:	c3                   	ret    

000017c3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    17c3:	f3 0f 1e fb          	endbr32 
    17c7:	55                   	push   %ebp
    17c8:	89 e5                	mov    %esp,%ebp
    17ca:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    17cd:	8b 45 08             	mov    0x8(%ebp),%eax
    17d0:	83 e8 08             	sub    $0x8,%eax
    17d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17d6:	a1 e0 1c 00 00       	mov    0x1ce0,%eax
    17db:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17de:	eb 24                	jmp    1804 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e3:	8b 00                	mov    (%eax),%eax
    17e5:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    17e8:	72 12                	jb     17fc <free+0x39>
    17ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17ed:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17f0:	77 24                	ja     1816 <free+0x53>
    17f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f5:	8b 00                	mov    (%eax),%eax
    17f7:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    17fa:	72 1a                	jb     1816 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ff:	8b 00                	mov    (%eax),%eax
    1801:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1804:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1807:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    180a:	76 d4                	jbe    17e0 <free+0x1d>
    180c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    180f:	8b 00                	mov    (%eax),%eax
    1811:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1814:	73 ca                	jae    17e0 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1816:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1819:	8b 40 04             	mov    0x4(%eax),%eax
    181c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1823:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1826:	01 c2                	add    %eax,%edx
    1828:	8b 45 fc             	mov    -0x4(%ebp),%eax
    182b:	8b 00                	mov    (%eax),%eax
    182d:	39 c2                	cmp    %eax,%edx
    182f:	75 24                	jne    1855 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1831:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1834:	8b 50 04             	mov    0x4(%eax),%edx
    1837:	8b 45 fc             	mov    -0x4(%ebp),%eax
    183a:	8b 00                	mov    (%eax),%eax
    183c:	8b 40 04             	mov    0x4(%eax),%eax
    183f:	01 c2                	add    %eax,%edx
    1841:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1844:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1847:	8b 45 fc             	mov    -0x4(%ebp),%eax
    184a:	8b 00                	mov    (%eax),%eax
    184c:	8b 10                	mov    (%eax),%edx
    184e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1851:	89 10                	mov    %edx,(%eax)
    1853:	eb 0a                	jmp    185f <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1855:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1858:	8b 10                	mov    (%eax),%edx
    185a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    185d:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    185f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1862:	8b 40 04             	mov    0x4(%eax),%eax
    1865:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    186c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    186f:	01 d0                	add    %edx,%eax
    1871:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1874:	75 20                	jne    1896 <free+0xd3>
    p->s.size += bp->s.size;
    1876:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1879:	8b 50 04             	mov    0x4(%eax),%edx
    187c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    187f:	8b 40 04             	mov    0x4(%eax),%eax
    1882:	01 c2                	add    %eax,%edx
    1884:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1887:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    188a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    188d:	8b 10                	mov    (%eax),%edx
    188f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1892:	89 10                	mov    %edx,(%eax)
    1894:	eb 08                	jmp    189e <free+0xdb>
  } else
    p->s.ptr = bp;
    1896:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1899:	8b 55 f8             	mov    -0x8(%ebp),%edx
    189c:	89 10                	mov    %edx,(%eax)
  freep = p;
    189e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18a1:	a3 e0 1c 00 00       	mov    %eax,0x1ce0
}
    18a6:	90                   	nop
    18a7:	c9                   	leave  
    18a8:	c3                   	ret    

000018a9 <morecore>:

static Header*
morecore(uint nu)
{
    18a9:	f3 0f 1e fb          	endbr32 
    18ad:	55                   	push   %ebp
    18ae:	89 e5                	mov    %esp,%ebp
    18b0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    18b3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    18ba:	77 07                	ja     18c3 <morecore+0x1a>
    nu = 4096;
    18bc:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    18c3:	8b 45 08             	mov    0x8(%ebp),%eax
    18c6:	c1 e0 03             	shl    $0x3,%eax
    18c9:	83 ec 0c             	sub    $0xc,%esp
    18cc:	50                   	push   %eax
    18cd:	e8 57 fc ff ff       	call   1529 <sbrk>
    18d2:	83 c4 10             	add    $0x10,%esp
    18d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    18d8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    18dc:	75 07                	jne    18e5 <morecore+0x3c>
    return 0;
    18de:	b8 00 00 00 00       	mov    $0x0,%eax
    18e3:	eb 26                	jmp    190b <morecore+0x62>
  hp = (Header*)p;
    18e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    18eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18ee:	8b 55 08             	mov    0x8(%ebp),%edx
    18f1:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    18f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18f7:	83 c0 08             	add    $0x8,%eax
    18fa:	83 ec 0c             	sub    $0xc,%esp
    18fd:	50                   	push   %eax
    18fe:	e8 c0 fe ff ff       	call   17c3 <free>
    1903:	83 c4 10             	add    $0x10,%esp
  return freep;
    1906:	a1 e0 1c 00 00       	mov    0x1ce0,%eax
}
    190b:	c9                   	leave  
    190c:	c3                   	ret    

0000190d <malloc>:

void*
malloc(uint nbytes)
{
    190d:	f3 0f 1e fb          	endbr32 
    1911:	55                   	push   %ebp
    1912:	89 e5                	mov    %esp,%ebp
    1914:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1917:	8b 45 08             	mov    0x8(%ebp),%eax
    191a:	83 c0 07             	add    $0x7,%eax
    191d:	c1 e8 03             	shr    $0x3,%eax
    1920:	83 c0 01             	add    $0x1,%eax
    1923:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1926:	a1 e0 1c 00 00       	mov    0x1ce0,%eax
    192b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    192e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1932:	75 23                	jne    1957 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1934:	c7 45 f0 d8 1c 00 00 	movl   $0x1cd8,-0x10(%ebp)
    193b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    193e:	a3 e0 1c 00 00       	mov    %eax,0x1ce0
    1943:	a1 e0 1c 00 00       	mov    0x1ce0,%eax
    1948:	a3 d8 1c 00 00       	mov    %eax,0x1cd8
    base.s.size = 0;
    194d:	c7 05 dc 1c 00 00 00 	movl   $0x0,0x1cdc
    1954:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1957:	8b 45 f0             	mov    -0x10(%ebp),%eax
    195a:	8b 00                	mov    (%eax),%eax
    195c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    195f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1962:	8b 40 04             	mov    0x4(%eax),%eax
    1965:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1968:	77 4d                	ja     19b7 <malloc+0xaa>
      if(p->s.size == nunits)
    196a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    196d:	8b 40 04             	mov    0x4(%eax),%eax
    1970:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1973:	75 0c                	jne    1981 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    1975:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1978:	8b 10                	mov    (%eax),%edx
    197a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    197d:	89 10                	mov    %edx,(%eax)
    197f:	eb 26                	jmp    19a7 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    1981:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1984:	8b 40 04             	mov    0x4(%eax),%eax
    1987:	2b 45 ec             	sub    -0x14(%ebp),%eax
    198a:	89 c2                	mov    %eax,%edx
    198c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    198f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1992:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1995:	8b 40 04             	mov    0x4(%eax),%eax
    1998:	c1 e0 03             	shl    $0x3,%eax
    199b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    199e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    19a4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    19a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19aa:	a3 e0 1c 00 00       	mov    %eax,0x1ce0
      return (void*)(p + 1);
    19af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b2:	83 c0 08             	add    $0x8,%eax
    19b5:	eb 3b                	jmp    19f2 <malloc+0xe5>
    }
    if(p == freep)
    19b7:	a1 e0 1c 00 00       	mov    0x1ce0,%eax
    19bc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    19bf:	75 1e                	jne    19df <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    19c1:	83 ec 0c             	sub    $0xc,%esp
    19c4:	ff 75 ec             	pushl  -0x14(%ebp)
    19c7:	e8 dd fe ff ff       	call   18a9 <morecore>
    19cc:	83 c4 10             	add    $0x10,%esp
    19cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19d6:	75 07                	jne    19df <malloc+0xd2>
        return 0;
    19d8:	b8 00 00 00 00       	mov    $0x0,%eax
    19dd:	eb 13                	jmp    19f2 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e8:	8b 00                	mov    (%eax),%eax
    19ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    19ed:	e9 6d ff ff ff       	jmp    195f <malloc+0x52>
  }
}
    19f2:	c9                   	leave  
    19f3:	c3                   	ret    
