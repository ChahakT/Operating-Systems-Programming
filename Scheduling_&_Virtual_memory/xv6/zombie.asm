
_zombie:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
    1000:	f3 0f 1e fb          	endbr32 
    1004:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1008:	83 e4 f0             	and    $0xfffffff0,%esp
    100b:	ff 71 fc             	pushl  -0x4(%ecx)
    100e:	55                   	push   %ebp
    100f:	89 e5                	mov    %esp,%ebp
    1011:	51                   	push   %ecx
    1012:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
    1015:	e8 89 02 00 00       	call   12a3 <fork>
    101a:	85 c0                	test   %eax,%eax
    101c:	7e 0d                	jle    102b <main+0x2b>
    sleep(5);  // Let child exit before parent.
    101e:	83 ec 0c             	sub    $0xc,%esp
    1021:	6a 05                	push   $0x5
    1023:	e8 13 03 00 00       	call   133b <sleep>
    1028:	83 c4 10             	add    $0x10,%esp
  exit();
    102b:	e8 7b 02 00 00       	call   12ab <exit>

00001030 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	57                   	push   %edi
    1034:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1035:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1038:	8b 55 10             	mov    0x10(%ebp),%edx
    103b:	8b 45 0c             	mov    0xc(%ebp),%eax
    103e:	89 cb                	mov    %ecx,%ebx
    1040:	89 df                	mov    %ebx,%edi
    1042:	89 d1                	mov    %edx,%ecx
    1044:	fc                   	cld    
    1045:	f3 aa                	rep stos %al,%es:(%edi)
    1047:	89 ca                	mov    %ecx,%edx
    1049:	89 fb                	mov    %edi,%ebx
    104b:	89 5d 08             	mov    %ebx,0x8(%ebp)
    104e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1051:	90                   	nop
    1052:	5b                   	pop    %ebx
    1053:	5f                   	pop    %edi
    1054:	5d                   	pop    %ebp
    1055:	c3                   	ret    

00001056 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1056:	f3 0f 1e fb          	endbr32 
    105a:	55                   	push   %ebp
    105b:	89 e5                	mov    %esp,%ebp
    105d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1060:	8b 45 08             	mov    0x8(%ebp),%eax
    1063:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1066:	90                   	nop
    1067:	8b 55 0c             	mov    0xc(%ebp),%edx
    106a:	8d 42 01             	lea    0x1(%edx),%eax
    106d:	89 45 0c             	mov    %eax,0xc(%ebp)
    1070:	8b 45 08             	mov    0x8(%ebp),%eax
    1073:	8d 48 01             	lea    0x1(%eax),%ecx
    1076:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1079:	0f b6 12             	movzbl (%edx),%edx
    107c:	88 10                	mov    %dl,(%eax)
    107e:	0f b6 00             	movzbl (%eax),%eax
    1081:	84 c0                	test   %al,%al
    1083:	75 e2                	jne    1067 <strcpy+0x11>
    ;
  return os;
    1085:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1088:	c9                   	leave  
    1089:	c3                   	ret    

0000108a <strcmp>:

int
strcmp(const char *p, const char *q)
{
    108a:	f3 0f 1e fb          	endbr32 
    108e:	55                   	push   %ebp
    108f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1091:	eb 08                	jmp    109b <strcmp+0x11>
    p++, q++;
    1093:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1097:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    109b:	8b 45 08             	mov    0x8(%ebp),%eax
    109e:	0f b6 00             	movzbl (%eax),%eax
    10a1:	84 c0                	test   %al,%al
    10a3:	74 10                	je     10b5 <strcmp+0x2b>
    10a5:	8b 45 08             	mov    0x8(%ebp),%eax
    10a8:	0f b6 10             	movzbl (%eax),%edx
    10ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ae:	0f b6 00             	movzbl (%eax),%eax
    10b1:	38 c2                	cmp    %al,%dl
    10b3:	74 de                	je     1093 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    10b5:	8b 45 08             	mov    0x8(%ebp),%eax
    10b8:	0f b6 00             	movzbl (%eax),%eax
    10bb:	0f b6 d0             	movzbl %al,%edx
    10be:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c1:	0f b6 00             	movzbl (%eax),%eax
    10c4:	0f b6 c0             	movzbl %al,%eax
    10c7:	29 c2                	sub    %eax,%edx
    10c9:	89 d0                	mov    %edx,%eax
}
    10cb:	5d                   	pop    %ebp
    10cc:	c3                   	ret    

000010cd <strlen>:

uint
strlen(const char *s)
{
    10cd:	f3 0f 1e fb          	endbr32 
    10d1:	55                   	push   %ebp
    10d2:	89 e5                	mov    %esp,%ebp
    10d4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10de:	eb 04                	jmp    10e4 <strlen+0x17>
    10e0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10e4:	8b 55 fc             	mov    -0x4(%ebp),%edx
    10e7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ea:	01 d0                	add    %edx,%eax
    10ec:	0f b6 00             	movzbl (%eax),%eax
    10ef:	84 c0                	test   %al,%al
    10f1:	75 ed                	jne    10e0 <strlen+0x13>
    ;
  return n;
    10f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10f6:	c9                   	leave  
    10f7:	c3                   	ret    

000010f8 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10f8:	f3 0f 1e fb          	endbr32 
    10fc:	55                   	push   %ebp
    10fd:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    10ff:	8b 45 10             	mov    0x10(%ebp),%eax
    1102:	50                   	push   %eax
    1103:	ff 75 0c             	pushl  0xc(%ebp)
    1106:	ff 75 08             	pushl  0x8(%ebp)
    1109:	e8 22 ff ff ff       	call   1030 <stosb>
    110e:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1111:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1114:	c9                   	leave  
    1115:	c3                   	ret    

00001116 <strchr>:

char*
strchr(const char *s, char c)
{
    1116:	f3 0f 1e fb          	endbr32 
    111a:	55                   	push   %ebp
    111b:	89 e5                	mov    %esp,%ebp
    111d:	83 ec 04             	sub    $0x4,%esp
    1120:	8b 45 0c             	mov    0xc(%ebp),%eax
    1123:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1126:	eb 14                	jmp    113c <strchr+0x26>
    if(*s == c)
    1128:	8b 45 08             	mov    0x8(%ebp),%eax
    112b:	0f b6 00             	movzbl (%eax),%eax
    112e:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1131:	75 05                	jne    1138 <strchr+0x22>
      return (char*)s;
    1133:	8b 45 08             	mov    0x8(%ebp),%eax
    1136:	eb 13                	jmp    114b <strchr+0x35>
  for(; *s; s++)
    1138:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    113c:	8b 45 08             	mov    0x8(%ebp),%eax
    113f:	0f b6 00             	movzbl (%eax),%eax
    1142:	84 c0                	test   %al,%al
    1144:	75 e2                	jne    1128 <strchr+0x12>
  return 0;
    1146:	b8 00 00 00 00       	mov    $0x0,%eax
}
    114b:	c9                   	leave  
    114c:	c3                   	ret    

0000114d <gets>:

char*
gets(char *buf, int max)
{
    114d:	f3 0f 1e fb          	endbr32 
    1151:	55                   	push   %ebp
    1152:	89 e5                	mov    %esp,%ebp
    1154:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1157:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    115e:	eb 42                	jmp    11a2 <gets+0x55>
    cc = read(0, &c, 1);
    1160:	83 ec 04             	sub    $0x4,%esp
    1163:	6a 01                	push   $0x1
    1165:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1168:	50                   	push   %eax
    1169:	6a 00                	push   $0x0
    116b:	e8 53 01 00 00       	call   12c3 <read>
    1170:	83 c4 10             	add    $0x10,%esp
    1173:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1176:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    117a:	7e 33                	jle    11af <gets+0x62>
      break;
    buf[i++] = c;
    117c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    117f:	8d 50 01             	lea    0x1(%eax),%edx
    1182:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1185:	89 c2                	mov    %eax,%edx
    1187:	8b 45 08             	mov    0x8(%ebp),%eax
    118a:	01 c2                	add    %eax,%edx
    118c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1190:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1192:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1196:	3c 0a                	cmp    $0xa,%al
    1198:	74 16                	je     11b0 <gets+0x63>
    119a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    119e:	3c 0d                	cmp    $0xd,%al
    11a0:	74 0e                	je     11b0 <gets+0x63>
  for(i=0; i+1 < max; ){
    11a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a5:	83 c0 01             	add    $0x1,%eax
    11a8:	39 45 0c             	cmp    %eax,0xc(%ebp)
    11ab:	7f b3                	jg     1160 <gets+0x13>
    11ad:	eb 01                	jmp    11b0 <gets+0x63>
      break;
    11af:	90                   	nop
      break;
  }
  buf[i] = '\0';
    11b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11b3:	8b 45 08             	mov    0x8(%ebp),%eax
    11b6:	01 d0                	add    %edx,%eax
    11b8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11be:	c9                   	leave  
    11bf:	c3                   	ret    

000011c0 <stat>:

int
stat(const char *n, struct stat *st)
{
    11c0:	f3 0f 1e fb          	endbr32 
    11c4:	55                   	push   %ebp
    11c5:	89 e5                	mov    %esp,%ebp
    11c7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11ca:	83 ec 08             	sub    $0x8,%esp
    11cd:	6a 00                	push   $0x0
    11cf:	ff 75 08             	pushl  0x8(%ebp)
    11d2:	e8 14 01 00 00       	call   12eb <open>
    11d7:	83 c4 10             	add    $0x10,%esp
    11da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    11dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11e1:	79 07                	jns    11ea <stat+0x2a>
    return -1;
    11e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    11e8:	eb 25                	jmp    120f <stat+0x4f>
  r = fstat(fd, st);
    11ea:	83 ec 08             	sub    $0x8,%esp
    11ed:	ff 75 0c             	pushl  0xc(%ebp)
    11f0:	ff 75 f4             	pushl  -0xc(%ebp)
    11f3:	e8 0b 01 00 00       	call   1303 <fstat>
    11f8:	83 c4 10             	add    $0x10,%esp
    11fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    11fe:	83 ec 0c             	sub    $0xc,%esp
    1201:	ff 75 f4             	pushl  -0xc(%ebp)
    1204:	e8 ca 00 00 00       	call   12d3 <close>
    1209:	83 c4 10             	add    $0x10,%esp
  return r;
    120c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    120f:	c9                   	leave  
    1210:	c3                   	ret    

00001211 <atoi>:

int
atoi(const char *s)
{
    1211:	f3 0f 1e fb          	endbr32 
    1215:	55                   	push   %ebp
    1216:	89 e5                	mov    %esp,%ebp
    1218:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    121b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1222:	eb 25                	jmp    1249 <atoi+0x38>
    n = n*10 + *s++ - '0';
    1224:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1227:	89 d0                	mov    %edx,%eax
    1229:	c1 e0 02             	shl    $0x2,%eax
    122c:	01 d0                	add    %edx,%eax
    122e:	01 c0                	add    %eax,%eax
    1230:	89 c1                	mov    %eax,%ecx
    1232:	8b 45 08             	mov    0x8(%ebp),%eax
    1235:	8d 50 01             	lea    0x1(%eax),%edx
    1238:	89 55 08             	mov    %edx,0x8(%ebp)
    123b:	0f b6 00             	movzbl (%eax),%eax
    123e:	0f be c0             	movsbl %al,%eax
    1241:	01 c8                	add    %ecx,%eax
    1243:	83 e8 30             	sub    $0x30,%eax
    1246:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1249:	8b 45 08             	mov    0x8(%ebp),%eax
    124c:	0f b6 00             	movzbl (%eax),%eax
    124f:	3c 2f                	cmp    $0x2f,%al
    1251:	7e 0a                	jle    125d <atoi+0x4c>
    1253:	8b 45 08             	mov    0x8(%ebp),%eax
    1256:	0f b6 00             	movzbl (%eax),%eax
    1259:	3c 39                	cmp    $0x39,%al
    125b:	7e c7                	jle    1224 <atoi+0x13>
  return n;
    125d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1260:	c9                   	leave  
    1261:	c3                   	ret    

00001262 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1262:	f3 0f 1e fb          	endbr32 
    1266:	55                   	push   %ebp
    1267:	89 e5                	mov    %esp,%ebp
    1269:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    126c:	8b 45 08             	mov    0x8(%ebp),%eax
    126f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1272:	8b 45 0c             	mov    0xc(%ebp),%eax
    1275:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1278:	eb 17                	jmp    1291 <memmove+0x2f>
    *dst++ = *src++;
    127a:	8b 55 f8             	mov    -0x8(%ebp),%edx
    127d:	8d 42 01             	lea    0x1(%edx),%eax
    1280:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1283:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1286:	8d 48 01             	lea    0x1(%eax),%ecx
    1289:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    128c:	0f b6 12             	movzbl (%edx),%edx
    128f:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    1291:	8b 45 10             	mov    0x10(%ebp),%eax
    1294:	8d 50 ff             	lea    -0x1(%eax),%edx
    1297:	89 55 10             	mov    %edx,0x10(%ebp)
    129a:	85 c0                	test   %eax,%eax
    129c:	7f dc                	jg     127a <memmove+0x18>
  return vdst;
    129e:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12a1:	c9                   	leave  
    12a2:	c3                   	ret    

000012a3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12a3:	b8 01 00 00 00       	mov    $0x1,%eax
    12a8:	cd 40                	int    $0x40
    12aa:	c3                   	ret    

000012ab <exit>:
SYSCALL(exit)
    12ab:	b8 02 00 00 00       	mov    $0x2,%eax
    12b0:	cd 40                	int    $0x40
    12b2:	c3                   	ret    

000012b3 <wait>:
SYSCALL(wait)
    12b3:	b8 03 00 00 00       	mov    $0x3,%eax
    12b8:	cd 40                	int    $0x40
    12ba:	c3                   	ret    

000012bb <pipe>:
SYSCALL(pipe)
    12bb:	b8 04 00 00 00       	mov    $0x4,%eax
    12c0:	cd 40                	int    $0x40
    12c2:	c3                   	ret    

000012c3 <read>:
SYSCALL(read)
    12c3:	b8 05 00 00 00       	mov    $0x5,%eax
    12c8:	cd 40                	int    $0x40
    12ca:	c3                   	ret    

000012cb <write>:
SYSCALL(write)
    12cb:	b8 10 00 00 00       	mov    $0x10,%eax
    12d0:	cd 40                	int    $0x40
    12d2:	c3                   	ret    

000012d3 <close>:
SYSCALL(close)
    12d3:	b8 15 00 00 00       	mov    $0x15,%eax
    12d8:	cd 40                	int    $0x40
    12da:	c3                   	ret    

000012db <kill>:
SYSCALL(kill)
    12db:	b8 06 00 00 00       	mov    $0x6,%eax
    12e0:	cd 40                	int    $0x40
    12e2:	c3                   	ret    

000012e3 <exec>:
SYSCALL(exec)
    12e3:	b8 07 00 00 00       	mov    $0x7,%eax
    12e8:	cd 40                	int    $0x40
    12ea:	c3                   	ret    

000012eb <open>:
SYSCALL(open)
    12eb:	b8 0f 00 00 00       	mov    $0xf,%eax
    12f0:	cd 40                	int    $0x40
    12f2:	c3                   	ret    

000012f3 <mknod>:
SYSCALL(mknod)
    12f3:	b8 11 00 00 00       	mov    $0x11,%eax
    12f8:	cd 40                	int    $0x40
    12fa:	c3                   	ret    

000012fb <unlink>:
SYSCALL(unlink)
    12fb:	b8 12 00 00 00       	mov    $0x12,%eax
    1300:	cd 40                	int    $0x40
    1302:	c3                   	ret    

00001303 <fstat>:
SYSCALL(fstat)
    1303:	b8 08 00 00 00       	mov    $0x8,%eax
    1308:	cd 40                	int    $0x40
    130a:	c3                   	ret    

0000130b <link>:
SYSCALL(link)
    130b:	b8 13 00 00 00       	mov    $0x13,%eax
    1310:	cd 40                	int    $0x40
    1312:	c3                   	ret    

00001313 <mkdir>:
SYSCALL(mkdir)
    1313:	b8 14 00 00 00       	mov    $0x14,%eax
    1318:	cd 40                	int    $0x40
    131a:	c3                   	ret    

0000131b <chdir>:
SYSCALL(chdir)
    131b:	b8 09 00 00 00       	mov    $0x9,%eax
    1320:	cd 40                	int    $0x40
    1322:	c3                   	ret    

00001323 <dup>:
SYSCALL(dup)
    1323:	b8 0a 00 00 00       	mov    $0xa,%eax
    1328:	cd 40                	int    $0x40
    132a:	c3                   	ret    

0000132b <getpid>:
SYSCALL(getpid)
    132b:	b8 0b 00 00 00       	mov    $0xb,%eax
    1330:	cd 40                	int    $0x40
    1332:	c3                   	ret    

00001333 <sbrk>:
SYSCALL(sbrk)
    1333:	b8 0c 00 00 00       	mov    $0xc,%eax
    1338:	cd 40                	int    $0x40
    133a:	c3                   	ret    

0000133b <sleep>:
SYSCALL(sleep)
    133b:	b8 0d 00 00 00       	mov    $0xd,%eax
    1340:	cd 40                	int    $0x40
    1342:	c3                   	ret    

00001343 <uptime>:
SYSCALL(uptime)
    1343:	b8 0e 00 00 00       	mov    $0xe,%eax
    1348:	cd 40                	int    $0x40
    134a:	c3                   	ret    

0000134b <settickets>:
SYSCALL(settickets)
    134b:	b8 16 00 00 00       	mov    $0x16,%eax
    1350:	cd 40                	int    $0x40
    1352:	c3                   	ret    

00001353 <getpinfo>:
SYSCALL(getpinfo)
    1353:	b8 17 00 00 00       	mov    $0x17,%eax
    1358:	cd 40                	int    $0x40
    135a:	c3                   	ret    

0000135b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    135b:	f3 0f 1e fb          	endbr32 
    135f:	55                   	push   %ebp
    1360:	89 e5                	mov    %esp,%ebp
    1362:	83 ec 18             	sub    $0x18,%esp
    1365:	8b 45 0c             	mov    0xc(%ebp),%eax
    1368:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    136b:	83 ec 04             	sub    $0x4,%esp
    136e:	6a 01                	push   $0x1
    1370:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1373:	50                   	push   %eax
    1374:	ff 75 08             	pushl  0x8(%ebp)
    1377:	e8 4f ff ff ff       	call   12cb <write>
    137c:	83 c4 10             	add    $0x10,%esp
}
    137f:	90                   	nop
    1380:	c9                   	leave  
    1381:	c3                   	ret    

00001382 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1382:	f3 0f 1e fb          	endbr32 
    1386:	55                   	push   %ebp
    1387:	89 e5                	mov    %esp,%ebp
    1389:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    138c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1393:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1397:	74 17                	je     13b0 <printint+0x2e>
    1399:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    139d:	79 11                	jns    13b0 <printint+0x2e>
    neg = 1;
    139f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a9:	f7 d8                	neg    %eax
    13ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13ae:	eb 06                	jmp    13b6 <printint+0x34>
  } else {
    x = xx;
    13b0:	8b 45 0c             	mov    0xc(%ebp),%eax
    13b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13bd:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13c3:	ba 00 00 00 00       	mov    $0x0,%edx
    13c8:	f7 f1                	div    %ecx
    13ca:	89 d1                	mov    %edx,%ecx
    13cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13cf:	8d 50 01             	lea    0x1(%eax),%edx
    13d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13d5:	0f b6 91 4c 1a 00 00 	movzbl 0x1a4c(%ecx),%edx
    13dc:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    13e0:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13e6:	ba 00 00 00 00       	mov    $0x0,%edx
    13eb:	f7 f1                	div    %ecx
    13ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    13f4:	75 c7                	jne    13bd <printint+0x3b>
  if(neg)
    13f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13fa:	74 2d                	je     1429 <printint+0xa7>
    buf[i++] = '-';
    13fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ff:	8d 50 01             	lea    0x1(%eax),%edx
    1402:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1405:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    140a:	eb 1d                	jmp    1429 <printint+0xa7>
    putc(fd, buf[i]);
    140c:	8d 55 dc             	lea    -0x24(%ebp),%edx
    140f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1412:	01 d0                	add    %edx,%eax
    1414:	0f b6 00             	movzbl (%eax),%eax
    1417:	0f be c0             	movsbl %al,%eax
    141a:	83 ec 08             	sub    $0x8,%esp
    141d:	50                   	push   %eax
    141e:	ff 75 08             	pushl  0x8(%ebp)
    1421:	e8 35 ff ff ff       	call   135b <putc>
    1426:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    1429:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    142d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1431:	79 d9                	jns    140c <printint+0x8a>
}
    1433:	90                   	nop
    1434:	90                   	nop
    1435:	c9                   	leave  
    1436:	c3                   	ret    

00001437 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1437:	f3 0f 1e fb          	endbr32 
    143b:	55                   	push   %ebp
    143c:	89 e5                	mov    %esp,%ebp
    143e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1441:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1448:	8d 45 0c             	lea    0xc(%ebp),%eax
    144b:	83 c0 04             	add    $0x4,%eax
    144e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1451:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1458:	e9 59 01 00 00       	jmp    15b6 <printf+0x17f>
    c = fmt[i] & 0xff;
    145d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1460:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1463:	01 d0                	add    %edx,%eax
    1465:	0f b6 00             	movzbl (%eax),%eax
    1468:	0f be c0             	movsbl %al,%eax
    146b:	25 ff 00 00 00       	and    $0xff,%eax
    1470:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1473:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1477:	75 2c                	jne    14a5 <printf+0x6e>
      if(c == '%'){
    1479:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    147d:	75 0c                	jne    148b <printf+0x54>
        state = '%';
    147f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1486:	e9 27 01 00 00       	jmp    15b2 <printf+0x17b>
      } else {
        putc(fd, c);
    148b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    148e:	0f be c0             	movsbl %al,%eax
    1491:	83 ec 08             	sub    $0x8,%esp
    1494:	50                   	push   %eax
    1495:	ff 75 08             	pushl  0x8(%ebp)
    1498:	e8 be fe ff ff       	call   135b <putc>
    149d:	83 c4 10             	add    $0x10,%esp
    14a0:	e9 0d 01 00 00       	jmp    15b2 <printf+0x17b>
      }
    } else if(state == '%'){
    14a5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14a9:	0f 85 03 01 00 00    	jne    15b2 <printf+0x17b>
      if(c == 'd'){
    14af:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14b3:	75 1e                	jne    14d3 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    14b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14b8:	8b 00                	mov    (%eax),%eax
    14ba:	6a 01                	push   $0x1
    14bc:	6a 0a                	push   $0xa
    14be:	50                   	push   %eax
    14bf:	ff 75 08             	pushl  0x8(%ebp)
    14c2:	e8 bb fe ff ff       	call   1382 <printint>
    14c7:	83 c4 10             	add    $0x10,%esp
        ap++;
    14ca:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14ce:	e9 d8 00 00 00       	jmp    15ab <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    14d3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    14d7:	74 06                	je     14df <printf+0xa8>
    14d9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    14dd:	75 1e                	jne    14fd <printf+0xc6>
        printint(fd, *ap, 16, 0);
    14df:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14e2:	8b 00                	mov    (%eax),%eax
    14e4:	6a 00                	push   $0x0
    14e6:	6a 10                	push   $0x10
    14e8:	50                   	push   %eax
    14e9:	ff 75 08             	pushl  0x8(%ebp)
    14ec:	e8 91 fe ff ff       	call   1382 <printint>
    14f1:	83 c4 10             	add    $0x10,%esp
        ap++;
    14f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14f8:	e9 ae 00 00 00       	jmp    15ab <printf+0x174>
      } else if(c == 's'){
    14fd:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1501:	75 43                	jne    1546 <printf+0x10f>
        s = (char*)*ap;
    1503:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1506:	8b 00                	mov    (%eax),%eax
    1508:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    150b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    150f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1513:	75 25                	jne    153a <printf+0x103>
          s = "(null)";
    1515:	c7 45 f4 fe 17 00 00 	movl   $0x17fe,-0xc(%ebp)
        while(*s != 0){
    151c:	eb 1c                	jmp    153a <printf+0x103>
          putc(fd, *s);
    151e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1521:	0f b6 00             	movzbl (%eax),%eax
    1524:	0f be c0             	movsbl %al,%eax
    1527:	83 ec 08             	sub    $0x8,%esp
    152a:	50                   	push   %eax
    152b:	ff 75 08             	pushl  0x8(%ebp)
    152e:	e8 28 fe ff ff       	call   135b <putc>
    1533:	83 c4 10             	add    $0x10,%esp
          s++;
    1536:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    153a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153d:	0f b6 00             	movzbl (%eax),%eax
    1540:	84 c0                	test   %al,%al
    1542:	75 da                	jne    151e <printf+0xe7>
    1544:	eb 65                	jmp    15ab <printf+0x174>
        }
      } else if(c == 'c'){
    1546:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    154a:	75 1d                	jne    1569 <printf+0x132>
        putc(fd, *ap);
    154c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    154f:	8b 00                	mov    (%eax),%eax
    1551:	0f be c0             	movsbl %al,%eax
    1554:	83 ec 08             	sub    $0x8,%esp
    1557:	50                   	push   %eax
    1558:	ff 75 08             	pushl  0x8(%ebp)
    155b:	e8 fb fd ff ff       	call   135b <putc>
    1560:	83 c4 10             	add    $0x10,%esp
        ap++;
    1563:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1567:	eb 42                	jmp    15ab <printf+0x174>
      } else if(c == '%'){
    1569:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    156d:	75 17                	jne    1586 <printf+0x14f>
        putc(fd, c);
    156f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1572:	0f be c0             	movsbl %al,%eax
    1575:	83 ec 08             	sub    $0x8,%esp
    1578:	50                   	push   %eax
    1579:	ff 75 08             	pushl  0x8(%ebp)
    157c:	e8 da fd ff ff       	call   135b <putc>
    1581:	83 c4 10             	add    $0x10,%esp
    1584:	eb 25                	jmp    15ab <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1586:	83 ec 08             	sub    $0x8,%esp
    1589:	6a 25                	push   $0x25
    158b:	ff 75 08             	pushl  0x8(%ebp)
    158e:	e8 c8 fd ff ff       	call   135b <putc>
    1593:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1596:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1599:	0f be c0             	movsbl %al,%eax
    159c:	83 ec 08             	sub    $0x8,%esp
    159f:	50                   	push   %eax
    15a0:	ff 75 08             	pushl  0x8(%ebp)
    15a3:	e8 b3 fd ff ff       	call   135b <putc>
    15a8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    15b2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    15b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15bc:	01 d0                	add    %edx,%eax
    15be:	0f b6 00             	movzbl (%eax),%eax
    15c1:	84 c0                	test   %al,%al
    15c3:	0f 85 94 fe ff ff    	jne    145d <printf+0x26>
    }
  }
}
    15c9:	90                   	nop
    15ca:	90                   	nop
    15cb:	c9                   	leave  
    15cc:	c3                   	ret    

000015cd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15cd:	f3 0f 1e fb          	endbr32 
    15d1:	55                   	push   %ebp
    15d2:	89 e5                	mov    %esp,%ebp
    15d4:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15d7:	8b 45 08             	mov    0x8(%ebp),%eax
    15da:	83 e8 08             	sub    $0x8,%eax
    15dd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15e0:	a1 68 1a 00 00       	mov    0x1a68,%eax
    15e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    15e8:	eb 24                	jmp    160e <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15ed:	8b 00                	mov    (%eax),%eax
    15ef:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    15f2:	72 12                	jb     1606 <free+0x39>
    15f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    15f7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    15fa:	77 24                	ja     1620 <free+0x53>
    15fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15ff:	8b 00                	mov    (%eax),%eax
    1601:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1604:	72 1a                	jb     1620 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1606:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1609:	8b 00                	mov    (%eax),%eax
    160b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    160e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1611:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1614:	76 d4                	jbe    15ea <free+0x1d>
    1616:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1619:	8b 00                	mov    (%eax),%eax
    161b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    161e:	73 ca                	jae    15ea <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1620:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1623:	8b 40 04             	mov    0x4(%eax),%eax
    1626:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    162d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1630:	01 c2                	add    %eax,%edx
    1632:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1635:	8b 00                	mov    (%eax),%eax
    1637:	39 c2                	cmp    %eax,%edx
    1639:	75 24                	jne    165f <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    163b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    163e:	8b 50 04             	mov    0x4(%eax),%edx
    1641:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1644:	8b 00                	mov    (%eax),%eax
    1646:	8b 40 04             	mov    0x4(%eax),%eax
    1649:	01 c2                	add    %eax,%edx
    164b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    164e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1651:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1654:	8b 00                	mov    (%eax),%eax
    1656:	8b 10                	mov    (%eax),%edx
    1658:	8b 45 f8             	mov    -0x8(%ebp),%eax
    165b:	89 10                	mov    %edx,(%eax)
    165d:	eb 0a                	jmp    1669 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    165f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1662:	8b 10                	mov    (%eax),%edx
    1664:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1667:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1669:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166c:	8b 40 04             	mov    0x4(%eax),%eax
    166f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1676:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1679:	01 d0                	add    %edx,%eax
    167b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    167e:	75 20                	jne    16a0 <free+0xd3>
    p->s.size += bp->s.size;
    1680:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1683:	8b 50 04             	mov    0x4(%eax),%edx
    1686:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1689:	8b 40 04             	mov    0x4(%eax),%eax
    168c:	01 c2                	add    %eax,%edx
    168e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1691:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1694:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1697:	8b 10                	mov    (%eax),%edx
    1699:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169c:	89 10                	mov    %edx,(%eax)
    169e:	eb 08                	jmp    16a8 <free+0xdb>
  } else
    p->s.ptr = bp;
    16a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16a6:	89 10                	mov    %edx,(%eax)
  freep = p;
    16a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ab:	a3 68 1a 00 00       	mov    %eax,0x1a68
}
    16b0:	90                   	nop
    16b1:	c9                   	leave  
    16b2:	c3                   	ret    

000016b3 <morecore>:

static Header*
morecore(uint nu)
{
    16b3:	f3 0f 1e fb          	endbr32 
    16b7:	55                   	push   %ebp
    16b8:	89 e5                	mov    %esp,%ebp
    16ba:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16bd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16c4:	77 07                	ja     16cd <morecore+0x1a>
    nu = 4096;
    16c6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    16cd:	8b 45 08             	mov    0x8(%ebp),%eax
    16d0:	c1 e0 03             	shl    $0x3,%eax
    16d3:	83 ec 0c             	sub    $0xc,%esp
    16d6:	50                   	push   %eax
    16d7:	e8 57 fc ff ff       	call   1333 <sbrk>
    16dc:	83 c4 10             	add    $0x10,%esp
    16df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    16e2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    16e6:	75 07                	jne    16ef <morecore+0x3c>
    return 0;
    16e8:	b8 00 00 00 00       	mov    $0x0,%eax
    16ed:	eb 26                	jmp    1715 <morecore+0x62>
  hp = (Header*)p;
    16ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    16f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16f8:	8b 55 08             	mov    0x8(%ebp),%edx
    16fb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    16fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1701:	83 c0 08             	add    $0x8,%eax
    1704:	83 ec 0c             	sub    $0xc,%esp
    1707:	50                   	push   %eax
    1708:	e8 c0 fe ff ff       	call   15cd <free>
    170d:	83 c4 10             	add    $0x10,%esp
  return freep;
    1710:	a1 68 1a 00 00       	mov    0x1a68,%eax
}
    1715:	c9                   	leave  
    1716:	c3                   	ret    

00001717 <malloc>:

void*
malloc(uint nbytes)
{
    1717:	f3 0f 1e fb          	endbr32 
    171b:	55                   	push   %ebp
    171c:	89 e5                	mov    %esp,%ebp
    171e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1721:	8b 45 08             	mov    0x8(%ebp),%eax
    1724:	83 c0 07             	add    $0x7,%eax
    1727:	c1 e8 03             	shr    $0x3,%eax
    172a:	83 c0 01             	add    $0x1,%eax
    172d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1730:	a1 68 1a 00 00       	mov    0x1a68,%eax
    1735:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1738:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    173c:	75 23                	jne    1761 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    173e:	c7 45 f0 60 1a 00 00 	movl   $0x1a60,-0x10(%ebp)
    1745:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1748:	a3 68 1a 00 00       	mov    %eax,0x1a68
    174d:	a1 68 1a 00 00       	mov    0x1a68,%eax
    1752:	a3 60 1a 00 00       	mov    %eax,0x1a60
    base.s.size = 0;
    1757:	c7 05 64 1a 00 00 00 	movl   $0x0,0x1a64
    175e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1761:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1764:	8b 00                	mov    (%eax),%eax
    1766:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1769:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176c:	8b 40 04             	mov    0x4(%eax),%eax
    176f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1772:	77 4d                	ja     17c1 <malloc+0xaa>
      if(p->s.size == nunits)
    1774:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1777:	8b 40 04             	mov    0x4(%eax),%eax
    177a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    177d:	75 0c                	jne    178b <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    177f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1782:	8b 10                	mov    (%eax),%edx
    1784:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1787:	89 10                	mov    %edx,(%eax)
    1789:	eb 26                	jmp    17b1 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    178b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178e:	8b 40 04             	mov    0x4(%eax),%eax
    1791:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1794:	89 c2                	mov    %eax,%edx
    1796:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1799:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    179c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179f:	8b 40 04             	mov    0x4(%eax),%eax
    17a2:	c1 e0 03             	shl    $0x3,%eax
    17a5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17ae:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b4:	a3 68 1a 00 00       	mov    %eax,0x1a68
      return (void*)(p + 1);
    17b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bc:	83 c0 08             	add    $0x8,%eax
    17bf:	eb 3b                	jmp    17fc <malloc+0xe5>
    }
    if(p == freep)
    17c1:	a1 68 1a 00 00       	mov    0x1a68,%eax
    17c6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    17c9:	75 1e                	jne    17e9 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    17cb:	83 ec 0c             	sub    $0xc,%esp
    17ce:	ff 75 ec             	pushl  -0x14(%ebp)
    17d1:	e8 dd fe ff ff       	call   16b3 <morecore>
    17d6:	83 c4 10             	add    $0x10,%esp
    17d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17e0:	75 07                	jne    17e9 <malloc+0xd2>
        return 0;
    17e2:	b8 00 00 00 00       	mov    $0x0,%eax
    17e7:	eb 13                	jmp    17fc <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f2:	8b 00                	mov    (%eax),%eax
    17f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17f7:	e9 6d ff ff ff       	jmp    1769 <malloc+0x52>
  }
}
    17fc:	c9                   	leave  
    17fd:	c3                   	ret    
