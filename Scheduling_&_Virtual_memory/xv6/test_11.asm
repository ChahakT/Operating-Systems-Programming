
_test_11:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	f3 0f 1e fb          	endbr32 
    1004:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1008:	83 e4 f0             	and    $0xfffffff0,%esp
    100b:	ff 71 fc             	pushl  -0x4(%ecx)
    100e:	55                   	push   %ebp
    100f:	89 e5                	mov    %esp,%ebp
    1011:	53                   	push   %ebx
    1012:	51                   	push   %ecx
    1013:	83 ec 10             	sub    $0x10,%esp
    1016:	89 cb                	mov    %ecx,%ebx
   int ppid = getpid();
    1018:	e8 77 03 00 00       	call   1394 <getpid>
    101d:	89 45 f4             	mov    %eax,-0xc(%ebp)

   if (fork() == 0) {     
    1020:	e8 e7 02 00 00       	call   130c <fork>
    1025:	85 c0                	test   %eax,%eax
    1027:	75 54                	jne    107d <main+0x7d>

      int *p = (int *)atoi(argv[1]);
    1029:	8b 43 04             	mov    0x4(%ebx),%eax
    102c:	83 c0 04             	add    $0x4,%eax
    102f:	8b 00                	mov    (%eax),%eax
    1031:	83 ec 0c             	sub    $0xc,%esp
    1034:	50                   	push   %eax
    1035:	e8 40 02 00 00       	call   127a <atoi>
    103a:	83 c4 10             	add    $0x10,%esp
    103d:	89 45 f0             	mov    %eax,-0x10(%ebp)
      printf(1, "%d\n", *p);
    1040:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1043:	8b 00                	mov    (%eax),%eax
    1045:	83 ec 04             	sub    $0x4,%esp
    1048:	50                   	push   %eax
    1049:	68 67 18 00 00       	push   $0x1867
    104e:	6a 01                	push   $0x1
    1050:	e8 4b 04 00 00       	call   14a0 <printf>
    1055:	83 c4 10             	add    $0x10,%esp

      printf(1, "XV6_VM\t FAILED\n");
    1058:	83 ec 08             	sub    $0x8,%esp
    105b:	68 6b 18 00 00       	push   $0x186b
    1060:	6a 01                	push   $0x1
    1062:	e8 39 04 00 00       	call   14a0 <printf>
    1067:	83 c4 10             	add    $0x10,%esp
      
      kill(ppid);
    106a:	83 ec 0c             	sub    $0xc,%esp
    106d:	ff 75 f4             	pushl  -0xc(%ebp)
    1070:	e8 cf 02 00 00       	call   1344 <kill>
    1075:	83 c4 10             	add    $0x10,%esp
      
      exit();
    1078:	e8 97 02 00 00       	call   1314 <exit>
   } else {
      wait();
    107d:	e8 9a 02 00 00       	call   131c <wait>
   }

   printf(1, "XV6_VM\t SUCCESS\n");
    1082:	83 ec 08             	sub    $0x8,%esp
    1085:	68 7b 18 00 00       	push   $0x187b
    108a:	6a 01                	push   $0x1
    108c:	e8 0f 04 00 00       	call   14a0 <printf>
    1091:	83 c4 10             	add    $0x10,%esp
   exit();
    1094:	e8 7b 02 00 00       	call   1314 <exit>

00001099 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1099:	55                   	push   %ebp
    109a:	89 e5                	mov    %esp,%ebp
    109c:	57                   	push   %edi
    109d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    109e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10a1:	8b 55 10             	mov    0x10(%ebp),%edx
    10a4:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a7:	89 cb                	mov    %ecx,%ebx
    10a9:	89 df                	mov    %ebx,%edi
    10ab:	89 d1                	mov    %edx,%ecx
    10ad:	fc                   	cld    
    10ae:	f3 aa                	rep stos %al,%es:(%edi)
    10b0:	89 ca                	mov    %ecx,%edx
    10b2:	89 fb                	mov    %edi,%ebx
    10b4:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10b7:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10ba:	90                   	nop
    10bb:	5b                   	pop    %ebx
    10bc:	5f                   	pop    %edi
    10bd:	5d                   	pop    %ebp
    10be:	c3                   	ret    

000010bf <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    10bf:	f3 0f 1e fb          	endbr32 
    10c3:	55                   	push   %ebp
    10c4:	89 e5                	mov    %esp,%ebp
    10c6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10c9:	8b 45 08             	mov    0x8(%ebp),%eax
    10cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10cf:	90                   	nop
    10d0:	8b 55 0c             	mov    0xc(%ebp),%edx
    10d3:	8d 42 01             	lea    0x1(%edx),%eax
    10d6:	89 45 0c             	mov    %eax,0xc(%ebp)
    10d9:	8b 45 08             	mov    0x8(%ebp),%eax
    10dc:	8d 48 01             	lea    0x1(%eax),%ecx
    10df:	89 4d 08             	mov    %ecx,0x8(%ebp)
    10e2:	0f b6 12             	movzbl (%edx),%edx
    10e5:	88 10                	mov    %dl,(%eax)
    10e7:	0f b6 00             	movzbl (%eax),%eax
    10ea:	84 c0                	test   %al,%al
    10ec:	75 e2                	jne    10d0 <strcpy+0x11>
    ;
  return os;
    10ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10f1:	c9                   	leave  
    10f2:	c3                   	ret    

000010f3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10f3:	f3 0f 1e fb          	endbr32 
    10f7:	55                   	push   %ebp
    10f8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10fa:	eb 08                	jmp    1104 <strcmp+0x11>
    p++, q++;
    10fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1100:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    1104:	8b 45 08             	mov    0x8(%ebp),%eax
    1107:	0f b6 00             	movzbl (%eax),%eax
    110a:	84 c0                	test   %al,%al
    110c:	74 10                	je     111e <strcmp+0x2b>
    110e:	8b 45 08             	mov    0x8(%ebp),%eax
    1111:	0f b6 10             	movzbl (%eax),%edx
    1114:	8b 45 0c             	mov    0xc(%ebp),%eax
    1117:	0f b6 00             	movzbl (%eax),%eax
    111a:	38 c2                	cmp    %al,%dl
    111c:	74 de                	je     10fc <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    111e:	8b 45 08             	mov    0x8(%ebp),%eax
    1121:	0f b6 00             	movzbl (%eax),%eax
    1124:	0f b6 d0             	movzbl %al,%edx
    1127:	8b 45 0c             	mov    0xc(%ebp),%eax
    112a:	0f b6 00             	movzbl (%eax),%eax
    112d:	0f b6 c0             	movzbl %al,%eax
    1130:	29 c2                	sub    %eax,%edx
    1132:	89 d0                	mov    %edx,%eax
}
    1134:	5d                   	pop    %ebp
    1135:	c3                   	ret    

00001136 <strlen>:

uint
strlen(const char *s)
{
    1136:	f3 0f 1e fb          	endbr32 
    113a:	55                   	push   %ebp
    113b:	89 e5                	mov    %esp,%ebp
    113d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1140:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1147:	eb 04                	jmp    114d <strlen+0x17>
    1149:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    114d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1150:	8b 45 08             	mov    0x8(%ebp),%eax
    1153:	01 d0                	add    %edx,%eax
    1155:	0f b6 00             	movzbl (%eax),%eax
    1158:	84 c0                	test   %al,%al
    115a:	75 ed                	jne    1149 <strlen+0x13>
    ;
  return n;
    115c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    115f:	c9                   	leave  
    1160:	c3                   	ret    

00001161 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1161:	f3 0f 1e fb          	endbr32 
    1165:	55                   	push   %ebp
    1166:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1168:	8b 45 10             	mov    0x10(%ebp),%eax
    116b:	50                   	push   %eax
    116c:	ff 75 0c             	pushl  0xc(%ebp)
    116f:	ff 75 08             	pushl  0x8(%ebp)
    1172:	e8 22 ff ff ff       	call   1099 <stosb>
    1177:	83 c4 0c             	add    $0xc,%esp
  return dst;
    117a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    117d:	c9                   	leave  
    117e:	c3                   	ret    

0000117f <strchr>:

char*
strchr(const char *s, char c)
{
    117f:	f3 0f 1e fb          	endbr32 
    1183:	55                   	push   %ebp
    1184:	89 e5                	mov    %esp,%ebp
    1186:	83 ec 04             	sub    $0x4,%esp
    1189:	8b 45 0c             	mov    0xc(%ebp),%eax
    118c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    118f:	eb 14                	jmp    11a5 <strchr+0x26>
    if(*s == c)
    1191:	8b 45 08             	mov    0x8(%ebp),%eax
    1194:	0f b6 00             	movzbl (%eax),%eax
    1197:	38 45 fc             	cmp    %al,-0x4(%ebp)
    119a:	75 05                	jne    11a1 <strchr+0x22>
      return (char*)s;
    119c:	8b 45 08             	mov    0x8(%ebp),%eax
    119f:	eb 13                	jmp    11b4 <strchr+0x35>
  for(; *s; s++)
    11a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11a5:	8b 45 08             	mov    0x8(%ebp),%eax
    11a8:	0f b6 00             	movzbl (%eax),%eax
    11ab:	84 c0                	test   %al,%al
    11ad:	75 e2                	jne    1191 <strchr+0x12>
  return 0;
    11af:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11b4:	c9                   	leave  
    11b5:	c3                   	ret    

000011b6 <gets>:

char*
gets(char *buf, int max)
{
    11b6:	f3 0f 1e fb          	endbr32 
    11ba:	55                   	push   %ebp
    11bb:	89 e5                	mov    %esp,%ebp
    11bd:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11c7:	eb 42                	jmp    120b <gets+0x55>
    cc = read(0, &c, 1);
    11c9:	83 ec 04             	sub    $0x4,%esp
    11cc:	6a 01                	push   $0x1
    11ce:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11d1:	50                   	push   %eax
    11d2:	6a 00                	push   $0x0
    11d4:	e8 53 01 00 00       	call   132c <read>
    11d9:	83 c4 10             	add    $0x10,%esp
    11dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11e3:	7e 33                	jle    1218 <gets+0x62>
      break;
    buf[i++] = c;
    11e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11e8:	8d 50 01             	lea    0x1(%eax),%edx
    11eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11ee:	89 c2                	mov    %eax,%edx
    11f0:	8b 45 08             	mov    0x8(%ebp),%eax
    11f3:	01 c2                	add    %eax,%edx
    11f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11f9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11fb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11ff:	3c 0a                	cmp    $0xa,%al
    1201:	74 16                	je     1219 <gets+0x63>
    1203:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1207:	3c 0d                	cmp    $0xd,%al
    1209:	74 0e                	je     1219 <gets+0x63>
  for(i=0; i+1 < max; ){
    120b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    120e:	83 c0 01             	add    $0x1,%eax
    1211:	39 45 0c             	cmp    %eax,0xc(%ebp)
    1214:	7f b3                	jg     11c9 <gets+0x13>
    1216:	eb 01                	jmp    1219 <gets+0x63>
      break;
    1218:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1219:	8b 55 f4             	mov    -0xc(%ebp),%edx
    121c:	8b 45 08             	mov    0x8(%ebp),%eax
    121f:	01 d0                	add    %edx,%eax
    1221:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1224:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1227:	c9                   	leave  
    1228:	c3                   	ret    

00001229 <stat>:

int
stat(const char *n, struct stat *st)
{
    1229:	f3 0f 1e fb          	endbr32 
    122d:	55                   	push   %ebp
    122e:	89 e5                	mov    %esp,%ebp
    1230:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1233:	83 ec 08             	sub    $0x8,%esp
    1236:	6a 00                	push   $0x0
    1238:	ff 75 08             	pushl  0x8(%ebp)
    123b:	e8 14 01 00 00       	call   1354 <open>
    1240:	83 c4 10             	add    $0x10,%esp
    1243:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1246:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    124a:	79 07                	jns    1253 <stat+0x2a>
    return -1;
    124c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1251:	eb 25                	jmp    1278 <stat+0x4f>
  r = fstat(fd, st);
    1253:	83 ec 08             	sub    $0x8,%esp
    1256:	ff 75 0c             	pushl  0xc(%ebp)
    1259:	ff 75 f4             	pushl  -0xc(%ebp)
    125c:	e8 0b 01 00 00       	call   136c <fstat>
    1261:	83 c4 10             	add    $0x10,%esp
    1264:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1267:	83 ec 0c             	sub    $0xc,%esp
    126a:	ff 75 f4             	pushl  -0xc(%ebp)
    126d:	e8 ca 00 00 00       	call   133c <close>
    1272:	83 c4 10             	add    $0x10,%esp
  return r;
    1275:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1278:	c9                   	leave  
    1279:	c3                   	ret    

0000127a <atoi>:

int
atoi(const char *s)
{
    127a:	f3 0f 1e fb          	endbr32 
    127e:	55                   	push   %ebp
    127f:	89 e5                	mov    %esp,%ebp
    1281:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1284:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    128b:	eb 25                	jmp    12b2 <atoi+0x38>
    n = n*10 + *s++ - '0';
    128d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1290:	89 d0                	mov    %edx,%eax
    1292:	c1 e0 02             	shl    $0x2,%eax
    1295:	01 d0                	add    %edx,%eax
    1297:	01 c0                	add    %eax,%eax
    1299:	89 c1                	mov    %eax,%ecx
    129b:	8b 45 08             	mov    0x8(%ebp),%eax
    129e:	8d 50 01             	lea    0x1(%eax),%edx
    12a1:	89 55 08             	mov    %edx,0x8(%ebp)
    12a4:	0f b6 00             	movzbl (%eax),%eax
    12a7:	0f be c0             	movsbl %al,%eax
    12aa:	01 c8                	add    %ecx,%eax
    12ac:	83 e8 30             	sub    $0x30,%eax
    12af:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12b2:	8b 45 08             	mov    0x8(%ebp),%eax
    12b5:	0f b6 00             	movzbl (%eax),%eax
    12b8:	3c 2f                	cmp    $0x2f,%al
    12ba:	7e 0a                	jle    12c6 <atoi+0x4c>
    12bc:	8b 45 08             	mov    0x8(%ebp),%eax
    12bf:	0f b6 00             	movzbl (%eax),%eax
    12c2:	3c 39                	cmp    $0x39,%al
    12c4:	7e c7                	jle    128d <atoi+0x13>
  return n;
    12c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12c9:	c9                   	leave  
    12ca:	c3                   	ret    

000012cb <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12cb:	f3 0f 1e fb          	endbr32 
    12cf:	55                   	push   %ebp
    12d0:	89 e5                	mov    %esp,%ebp
    12d2:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    12d5:	8b 45 08             	mov    0x8(%ebp),%eax
    12d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12db:	8b 45 0c             	mov    0xc(%ebp),%eax
    12de:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12e1:	eb 17                	jmp    12fa <memmove+0x2f>
    *dst++ = *src++;
    12e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12e6:	8d 42 01             	lea    0x1(%edx),%eax
    12e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ef:	8d 48 01             	lea    0x1(%eax),%ecx
    12f2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    12f5:	0f b6 12             	movzbl (%edx),%edx
    12f8:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    12fa:	8b 45 10             	mov    0x10(%ebp),%eax
    12fd:	8d 50 ff             	lea    -0x1(%eax),%edx
    1300:	89 55 10             	mov    %edx,0x10(%ebp)
    1303:	85 c0                	test   %eax,%eax
    1305:	7f dc                	jg     12e3 <memmove+0x18>
  return vdst;
    1307:	8b 45 08             	mov    0x8(%ebp),%eax
}
    130a:	c9                   	leave  
    130b:	c3                   	ret    

0000130c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    130c:	b8 01 00 00 00       	mov    $0x1,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <exit>:
SYSCALL(exit)
    1314:	b8 02 00 00 00       	mov    $0x2,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <wait>:
SYSCALL(wait)
    131c:	b8 03 00 00 00       	mov    $0x3,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <pipe>:
SYSCALL(pipe)
    1324:	b8 04 00 00 00       	mov    $0x4,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <read>:
SYSCALL(read)
    132c:	b8 05 00 00 00       	mov    $0x5,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <write>:
SYSCALL(write)
    1334:	b8 10 00 00 00       	mov    $0x10,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <close>:
SYSCALL(close)
    133c:	b8 15 00 00 00       	mov    $0x15,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <kill>:
SYSCALL(kill)
    1344:	b8 06 00 00 00       	mov    $0x6,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <exec>:
SYSCALL(exec)
    134c:	b8 07 00 00 00       	mov    $0x7,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <open>:
SYSCALL(open)
    1354:	b8 0f 00 00 00       	mov    $0xf,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <mknod>:
SYSCALL(mknod)
    135c:	b8 11 00 00 00       	mov    $0x11,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <unlink>:
SYSCALL(unlink)
    1364:	b8 12 00 00 00       	mov    $0x12,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <fstat>:
SYSCALL(fstat)
    136c:	b8 08 00 00 00       	mov    $0x8,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <link>:
SYSCALL(link)
    1374:	b8 13 00 00 00       	mov    $0x13,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <mkdir>:
SYSCALL(mkdir)
    137c:	b8 14 00 00 00       	mov    $0x14,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <chdir>:
SYSCALL(chdir)
    1384:	b8 09 00 00 00       	mov    $0x9,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <dup>:
SYSCALL(dup)
    138c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <getpid>:
SYSCALL(getpid)
    1394:	b8 0b 00 00 00       	mov    $0xb,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <sbrk>:
SYSCALL(sbrk)
    139c:	b8 0c 00 00 00       	mov    $0xc,%eax
    13a1:	cd 40                	int    $0x40
    13a3:	c3                   	ret    

000013a4 <sleep>:
SYSCALL(sleep)
    13a4:	b8 0d 00 00 00       	mov    $0xd,%eax
    13a9:	cd 40                	int    $0x40
    13ab:	c3                   	ret    

000013ac <uptime>:
SYSCALL(uptime)
    13ac:	b8 0e 00 00 00       	mov    $0xe,%eax
    13b1:	cd 40                	int    $0x40
    13b3:	c3                   	ret    

000013b4 <settickets>:
SYSCALL(settickets)
    13b4:	b8 16 00 00 00       	mov    $0x16,%eax
    13b9:	cd 40                	int    $0x40
    13bb:	c3                   	ret    

000013bc <getpinfo>:
SYSCALL(getpinfo)
    13bc:	b8 17 00 00 00       	mov    $0x17,%eax
    13c1:	cd 40                	int    $0x40
    13c3:	c3                   	ret    

000013c4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13c4:	f3 0f 1e fb          	endbr32 
    13c8:	55                   	push   %ebp
    13c9:	89 e5                	mov    %esp,%ebp
    13cb:	83 ec 18             	sub    $0x18,%esp
    13ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13d4:	83 ec 04             	sub    $0x4,%esp
    13d7:	6a 01                	push   $0x1
    13d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13dc:	50                   	push   %eax
    13dd:	ff 75 08             	pushl  0x8(%ebp)
    13e0:	e8 4f ff ff ff       	call   1334 <write>
    13e5:	83 c4 10             	add    $0x10,%esp
}
    13e8:	90                   	nop
    13e9:	c9                   	leave  
    13ea:	c3                   	ret    

000013eb <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13eb:	f3 0f 1e fb          	endbr32 
    13ef:	55                   	push   %ebp
    13f0:	89 e5                	mov    %esp,%ebp
    13f2:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13f5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13fc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1400:	74 17                	je     1419 <printint+0x2e>
    1402:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1406:	79 11                	jns    1419 <printint+0x2e>
    neg = 1;
    1408:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    140f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1412:	f7 d8                	neg    %eax
    1414:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1417:	eb 06                	jmp    141f <printint+0x34>
  } else {
    x = xx;
    1419:	8b 45 0c             	mov    0xc(%ebp),%eax
    141c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    141f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1426:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1429:	8b 45 ec             	mov    -0x14(%ebp),%eax
    142c:	ba 00 00 00 00       	mov    $0x0,%edx
    1431:	f7 f1                	div    %ecx
    1433:	89 d1                	mov    %edx,%ecx
    1435:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1438:	8d 50 01             	lea    0x1(%eax),%edx
    143b:	89 55 f4             	mov    %edx,-0xc(%ebp)
    143e:	0f b6 91 dc 1a 00 00 	movzbl 0x1adc(%ecx),%edx
    1445:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1449:	8b 4d 10             	mov    0x10(%ebp),%ecx
    144c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    144f:	ba 00 00 00 00       	mov    $0x0,%edx
    1454:	f7 f1                	div    %ecx
    1456:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1459:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    145d:	75 c7                	jne    1426 <printint+0x3b>
  if(neg)
    145f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1463:	74 2d                	je     1492 <printint+0xa7>
    buf[i++] = '-';
    1465:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1468:	8d 50 01             	lea    0x1(%eax),%edx
    146b:	89 55 f4             	mov    %edx,-0xc(%ebp)
    146e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1473:	eb 1d                	jmp    1492 <printint+0xa7>
    putc(fd, buf[i]);
    1475:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1478:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147b:	01 d0                	add    %edx,%eax
    147d:	0f b6 00             	movzbl (%eax),%eax
    1480:	0f be c0             	movsbl %al,%eax
    1483:	83 ec 08             	sub    $0x8,%esp
    1486:	50                   	push   %eax
    1487:	ff 75 08             	pushl  0x8(%ebp)
    148a:	e8 35 ff ff ff       	call   13c4 <putc>
    148f:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    1492:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1496:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    149a:	79 d9                	jns    1475 <printint+0x8a>
}
    149c:	90                   	nop
    149d:	90                   	nop
    149e:	c9                   	leave  
    149f:	c3                   	ret    

000014a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    14a0:	f3 0f 1e fb          	endbr32 
    14a4:	55                   	push   %ebp
    14a5:	89 e5                	mov    %esp,%ebp
    14a7:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14aa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14b1:	8d 45 0c             	lea    0xc(%ebp),%eax
    14b4:	83 c0 04             	add    $0x4,%eax
    14b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    14ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14c1:	e9 59 01 00 00       	jmp    161f <printf+0x17f>
    c = fmt[i] & 0xff;
    14c6:	8b 55 0c             	mov    0xc(%ebp),%edx
    14c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14cc:	01 d0                	add    %edx,%eax
    14ce:	0f b6 00             	movzbl (%eax),%eax
    14d1:	0f be c0             	movsbl %al,%eax
    14d4:	25 ff 00 00 00       	and    $0xff,%eax
    14d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14dc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14e0:	75 2c                	jne    150e <printf+0x6e>
      if(c == '%'){
    14e2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14e6:	75 0c                	jne    14f4 <printf+0x54>
        state = '%';
    14e8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14ef:	e9 27 01 00 00       	jmp    161b <printf+0x17b>
      } else {
        putc(fd, c);
    14f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14f7:	0f be c0             	movsbl %al,%eax
    14fa:	83 ec 08             	sub    $0x8,%esp
    14fd:	50                   	push   %eax
    14fe:	ff 75 08             	pushl  0x8(%ebp)
    1501:	e8 be fe ff ff       	call   13c4 <putc>
    1506:	83 c4 10             	add    $0x10,%esp
    1509:	e9 0d 01 00 00       	jmp    161b <printf+0x17b>
      }
    } else if(state == '%'){
    150e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1512:	0f 85 03 01 00 00    	jne    161b <printf+0x17b>
      if(c == 'd'){
    1518:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    151c:	75 1e                	jne    153c <printf+0x9c>
        printint(fd, *ap, 10, 1);
    151e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1521:	8b 00                	mov    (%eax),%eax
    1523:	6a 01                	push   $0x1
    1525:	6a 0a                	push   $0xa
    1527:	50                   	push   %eax
    1528:	ff 75 08             	pushl  0x8(%ebp)
    152b:	e8 bb fe ff ff       	call   13eb <printint>
    1530:	83 c4 10             	add    $0x10,%esp
        ap++;
    1533:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1537:	e9 d8 00 00 00       	jmp    1614 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    153c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1540:	74 06                	je     1548 <printf+0xa8>
    1542:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1546:	75 1e                	jne    1566 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1548:	8b 45 e8             	mov    -0x18(%ebp),%eax
    154b:	8b 00                	mov    (%eax),%eax
    154d:	6a 00                	push   $0x0
    154f:	6a 10                	push   $0x10
    1551:	50                   	push   %eax
    1552:	ff 75 08             	pushl  0x8(%ebp)
    1555:	e8 91 fe ff ff       	call   13eb <printint>
    155a:	83 c4 10             	add    $0x10,%esp
        ap++;
    155d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1561:	e9 ae 00 00 00       	jmp    1614 <printf+0x174>
      } else if(c == 's'){
    1566:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    156a:	75 43                	jne    15af <printf+0x10f>
        s = (char*)*ap;
    156c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    156f:	8b 00                	mov    (%eax),%eax
    1571:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1574:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1578:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    157c:	75 25                	jne    15a3 <printf+0x103>
          s = "(null)";
    157e:	c7 45 f4 8c 18 00 00 	movl   $0x188c,-0xc(%ebp)
        while(*s != 0){
    1585:	eb 1c                	jmp    15a3 <printf+0x103>
          putc(fd, *s);
    1587:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158a:	0f b6 00             	movzbl (%eax),%eax
    158d:	0f be c0             	movsbl %al,%eax
    1590:	83 ec 08             	sub    $0x8,%esp
    1593:	50                   	push   %eax
    1594:	ff 75 08             	pushl  0x8(%ebp)
    1597:	e8 28 fe ff ff       	call   13c4 <putc>
    159c:	83 c4 10             	add    $0x10,%esp
          s++;
    159f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    15a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a6:	0f b6 00             	movzbl (%eax),%eax
    15a9:	84 c0                	test   %al,%al
    15ab:	75 da                	jne    1587 <printf+0xe7>
    15ad:	eb 65                	jmp    1614 <printf+0x174>
        }
      } else if(c == 'c'){
    15af:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15b3:	75 1d                	jne    15d2 <printf+0x132>
        putc(fd, *ap);
    15b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15b8:	8b 00                	mov    (%eax),%eax
    15ba:	0f be c0             	movsbl %al,%eax
    15bd:	83 ec 08             	sub    $0x8,%esp
    15c0:	50                   	push   %eax
    15c1:	ff 75 08             	pushl  0x8(%ebp)
    15c4:	e8 fb fd ff ff       	call   13c4 <putc>
    15c9:	83 c4 10             	add    $0x10,%esp
        ap++;
    15cc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15d0:	eb 42                	jmp    1614 <printf+0x174>
      } else if(c == '%'){
    15d2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15d6:	75 17                	jne    15ef <printf+0x14f>
        putc(fd, c);
    15d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15db:	0f be c0             	movsbl %al,%eax
    15de:	83 ec 08             	sub    $0x8,%esp
    15e1:	50                   	push   %eax
    15e2:	ff 75 08             	pushl  0x8(%ebp)
    15e5:	e8 da fd ff ff       	call   13c4 <putc>
    15ea:	83 c4 10             	add    $0x10,%esp
    15ed:	eb 25                	jmp    1614 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15ef:	83 ec 08             	sub    $0x8,%esp
    15f2:	6a 25                	push   $0x25
    15f4:	ff 75 08             	pushl  0x8(%ebp)
    15f7:	e8 c8 fd ff ff       	call   13c4 <putc>
    15fc:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1602:	0f be c0             	movsbl %al,%eax
    1605:	83 ec 08             	sub    $0x8,%esp
    1608:	50                   	push   %eax
    1609:	ff 75 08             	pushl  0x8(%ebp)
    160c:	e8 b3 fd ff ff       	call   13c4 <putc>
    1611:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1614:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    161b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    161f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1622:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1625:	01 d0                	add    %edx,%eax
    1627:	0f b6 00             	movzbl (%eax),%eax
    162a:	84 c0                	test   %al,%al
    162c:	0f 85 94 fe ff ff    	jne    14c6 <printf+0x26>
    }
  }
}
    1632:	90                   	nop
    1633:	90                   	nop
    1634:	c9                   	leave  
    1635:	c3                   	ret    

00001636 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1636:	f3 0f 1e fb          	endbr32 
    163a:	55                   	push   %ebp
    163b:	89 e5                	mov    %esp,%ebp
    163d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1640:	8b 45 08             	mov    0x8(%ebp),%eax
    1643:	83 e8 08             	sub    $0x8,%eax
    1646:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1649:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    164e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1651:	eb 24                	jmp    1677 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1653:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1656:	8b 00                	mov    (%eax),%eax
    1658:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    165b:	72 12                	jb     166f <free+0x39>
    165d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1660:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1663:	77 24                	ja     1689 <free+0x53>
    1665:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1668:	8b 00                	mov    (%eax),%eax
    166a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    166d:	72 1a                	jb     1689 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    166f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1672:	8b 00                	mov    (%eax),%eax
    1674:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1677:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    167d:	76 d4                	jbe    1653 <free+0x1d>
    167f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1682:	8b 00                	mov    (%eax),%eax
    1684:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1687:	73 ca                	jae    1653 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1689:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168c:	8b 40 04             	mov    0x4(%eax),%eax
    168f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1696:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1699:	01 c2                	add    %eax,%edx
    169b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169e:	8b 00                	mov    (%eax),%eax
    16a0:	39 c2                	cmp    %eax,%edx
    16a2:	75 24                	jne    16c8 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    16a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a7:	8b 50 04             	mov    0x4(%eax),%edx
    16aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ad:	8b 00                	mov    (%eax),%eax
    16af:	8b 40 04             	mov    0x4(%eax),%eax
    16b2:	01 c2                	add    %eax,%edx
    16b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b7:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bd:	8b 00                	mov    (%eax),%eax
    16bf:	8b 10                	mov    (%eax),%edx
    16c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c4:	89 10                	mov    %edx,(%eax)
    16c6:	eb 0a                	jmp    16d2 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    16c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cb:	8b 10                	mov    (%eax),%edx
    16cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d0:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d5:	8b 40 04             	mov    0x4(%eax),%eax
    16d8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16df:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e2:	01 d0                	add    %edx,%eax
    16e4:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16e7:	75 20                	jne    1709 <free+0xd3>
    p->s.size += bp->s.size;
    16e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ec:	8b 50 04             	mov    0x4(%eax),%edx
    16ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f2:	8b 40 04             	mov    0x4(%eax),%eax
    16f5:	01 c2                	add    %eax,%edx
    16f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fa:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1700:	8b 10                	mov    (%eax),%edx
    1702:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1705:	89 10                	mov    %edx,(%eax)
    1707:	eb 08                	jmp    1711 <free+0xdb>
  } else
    p->s.ptr = bp;
    1709:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    170f:	89 10                	mov    %edx,(%eax)
  freep = p;
    1711:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1714:	a3 f8 1a 00 00       	mov    %eax,0x1af8
}
    1719:	90                   	nop
    171a:	c9                   	leave  
    171b:	c3                   	ret    

0000171c <morecore>:

static Header*
morecore(uint nu)
{
    171c:	f3 0f 1e fb          	endbr32 
    1720:	55                   	push   %ebp
    1721:	89 e5                	mov    %esp,%ebp
    1723:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1726:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    172d:	77 07                	ja     1736 <morecore+0x1a>
    nu = 4096;
    172f:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1736:	8b 45 08             	mov    0x8(%ebp),%eax
    1739:	c1 e0 03             	shl    $0x3,%eax
    173c:	83 ec 0c             	sub    $0xc,%esp
    173f:	50                   	push   %eax
    1740:	e8 57 fc ff ff       	call   139c <sbrk>
    1745:	83 c4 10             	add    $0x10,%esp
    1748:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    174b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    174f:	75 07                	jne    1758 <morecore+0x3c>
    return 0;
    1751:	b8 00 00 00 00       	mov    $0x0,%eax
    1756:	eb 26                	jmp    177e <morecore+0x62>
  hp = (Header*)p;
    1758:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    175e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1761:	8b 55 08             	mov    0x8(%ebp),%edx
    1764:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1767:	8b 45 f0             	mov    -0x10(%ebp),%eax
    176a:	83 c0 08             	add    $0x8,%eax
    176d:	83 ec 0c             	sub    $0xc,%esp
    1770:	50                   	push   %eax
    1771:	e8 c0 fe ff ff       	call   1636 <free>
    1776:	83 c4 10             	add    $0x10,%esp
  return freep;
    1779:	a1 f8 1a 00 00       	mov    0x1af8,%eax
}
    177e:	c9                   	leave  
    177f:	c3                   	ret    

00001780 <malloc>:

void*
malloc(uint nbytes)
{
    1780:	f3 0f 1e fb          	endbr32 
    1784:	55                   	push   %ebp
    1785:	89 e5                	mov    %esp,%ebp
    1787:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    178a:	8b 45 08             	mov    0x8(%ebp),%eax
    178d:	83 c0 07             	add    $0x7,%eax
    1790:	c1 e8 03             	shr    $0x3,%eax
    1793:	83 c0 01             	add    $0x1,%eax
    1796:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1799:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    179e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17a1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17a5:	75 23                	jne    17ca <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    17a7:	c7 45 f0 f0 1a 00 00 	movl   $0x1af0,-0x10(%ebp)
    17ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b1:	a3 f8 1a 00 00       	mov    %eax,0x1af8
    17b6:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    17bb:	a3 f0 1a 00 00       	mov    %eax,0x1af0
    base.s.size = 0;
    17c0:	c7 05 f4 1a 00 00 00 	movl   $0x0,0x1af4
    17c7:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17cd:	8b 00                	mov    (%eax),%eax
    17cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d5:	8b 40 04             	mov    0x4(%eax),%eax
    17d8:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17db:	77 4d                	ja     182a <malloc+0xaa>
      if(p->s.size == nunits)
    17dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e0:	8b 40 04             	mov    0x4(%eax),%eax
    17e3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17e6:	75 0c                	jne    17f4 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    17e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17eb:	8b 10                	mov    (%eax),%edx
    17ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17f0:	89 10                	mov    %edx,(%eax)
    17f2:	eb 26                	jmp    181a <malloc+0x9a>
      else {
        p->s.size -= nunits;
    17f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f7:	8b 40 04             	mov    0x4(%eax),%eax
    17fa:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17fd:	89 c2                	mov    %eax,%edx
    17ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1802:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1805:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1808:	8b 40 04             	mov    0x4(%eax),%eax
    180b:	c1 e0 03             	shl    $0x3,%eax
    180e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1811:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1814:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1817:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    181a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    181d:	a3 f8 1a 00 00       	mov    %eax,0x1af8
      return (void*)(p + 1);
    1822:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1825:	83 c0 08             	add    $0x8,%eax
    1828:	eb 3b                	jmp    1865 <malloc+0xe5>
    }
    if(p == freep)
    182a:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    182f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1832:	75 1e                	jne    1852 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1834:	83 ec 0c             	sub    $0xc,%esp
    1837:	ff 75 ec             	pushl  -0x14(%ebp)
    183a:	e8 dd fe ff ff       	call   171c <morecore>
    183f:	83 c4 10             	add    $0x10,%esp
    1842:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1845:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1849:	75 07                	jne    1852 <malloc+0xd2>
        return 0;
    184b:	b8 00 00 00 00       	mov    $0x0,%eax
    1850:	eb 13                	jmp    1865 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1852:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1855:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1858:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185b:	8b 00                	mov    (%eax),%eax
    185d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1860:	e9 6d ff ff ff       	jmp    17d2 <malloc+0x52>
  }
}
    1865:	c9                   	leave  
    1866:	c3                   	ret    
