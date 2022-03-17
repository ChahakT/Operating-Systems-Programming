
_kill:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
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
  int i;

  if(argc < 2){
    1018:	83 3b 01             	cmpl   $0x1,(%ebx)
    101b:	7f 17                	jg     1034 <main+0x34>
    printf(2, "usage: kill pid...\n");
    101d:	83 ec 08             	sub    $0x8,%esp
    1020:	68 44 18 00 00       	push   $0x1844
    1025:	6a 02                	push   $0x2
    1027:	e8 51 04 00 00       	call   147d <printf>
    102c:	83 c4 10             	add    $0x10,%esp
    exit();
    102f:	e8 bd 02 00 00       	call   12f1 <exit>
  }
  for(i=1; i<argc; i++)
    1034:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    103b:	eb 2d                	jmp    106a <main+0x6a>
    kill(atoi(argv[i]));
    103d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1040:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1047:	8b 43 04             	mov    0x4(%ebx),%eax
    104a:	01 d0                	add    %edx,%eax
    104c:	8b 00                	mov    (%eax),%eax
    104e:	83 ec 0c             	sub    $0xc,%esp
    1051:	50                   	push   %eax
    1052:	e8 00 02 00 00       	call   1257 <atoi>
    1057:	83 c4 10             	add    $0x10,%esp
    105a:	83 ec 0c             	sub    $0xc,%esp
    105d:	50                   	push   %eax
    105e:	e8 be 02 00 00       	call   1321 <kill>
    1063:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
    1066:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    106a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    106d:	3b 03                	cmp    (%ebx),%eax
    106f:	7c cc                	jl     103d <main+0x3d>
  exit();
    1071:	e8 7b 02 00 00       	call   12f1 <exit>

00001076 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1076:	55                   	push   %ebp
    1077:	89 e5                	mov    %esp,%ebp
    1079:	57                   	push   %edi
    107a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    107b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    107e:	8b 55 10             	mov    0x10(%ebp),%edx
    1081:	8b 45 0c             	mov    0xc(%ebp),%eax
    1084:	89 cb                	mov    %ecx,%ebx
    1086:	89 df                	mov    %ebx,%edi
    1088:	89 d1                	mov    %edx,%ecx
    108a:	fc                   	cld    
    108b:	f3 aa                	rep stos %al,%es:(%edi)
    108d:	89 ca                	mov    %ecx,%edx
    108f:	89 fb                	mov    %edi,%ebx
    1091:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1094:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1097:	90                   	nop
    1098:	5b                   	pop    %ebx
    1099:	5f                   	pop    %edi
    109a:	5d                   	pop    %ebp
    109b:	c3                   	ret    

0000109c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    109c:	f3 0f 1e fb          	endbr32 
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10a6:	8b 45 08             	mov    0x8(%ebp),%eax
    10a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10ac:	90                   	nop
    10ad:	8b 55 0c             	mov    0xc(%ebp),%edx
    10b0:	8d 42 01             	lea    0x1(%edx),%eax
    10b3:	89 45 0c             	mov    %eax,0xc(%ebp)
    10b6:	8b 45 08             	mov    0x8(%ebp),%eax
    10b9:	8d 48 01             	lea    0x1(%eax),%ecx
    10bc:	89 4d 08             	mov    %ecx,0x8(%ebp)
    10bf:	0f b6 12             	movzbl (%edx),%edx
    10c2:	88 10                	mov    %dl,(%eax)
    10c4:	0f b6 00             	movzbl (%eax),%eax
    10c7:	84 c0                	test   %al,%al
    10c9:	75 e2                	jne    10ad <strcpy+0x11>
    ;
  return os;
    10cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10ce:	c9                   	leave  
    10cf:	c3                   	ret    

000010d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10d0:	f3 0f 1e fb          	endbr32 
    10d4:	55                   	push   %ebp
    10d5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10d7:	eb 08                	jmp    10e1 <strcmp+0x11>
    p++, q++;
    10d9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10dd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    10e1:	8b 45 08             	mov    0x8(%ebp),%eax
    10e4:	0f b6 00             	movzbl (%eax),%eax
    10e7:	84 c0                	test   %al,%al
    10e9:	74 10                	je     10fb <strcmp+0x2b>
    10eb:	8b 45 08             	mov    0x8(%ebp),%eax
    10ee:	0f b6 10             	movzbl (%eax),%edx
    10f1:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f4:	0f b6 00             	movzbl (%eax),%eax
    10f7:	38 c2                	cmp    %al,%dl
    10f9:	74 de                	je     10d9 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    10fb:	8b 45 08             	mov    0x8(%ebp),%eax
    10fe:	0f b6 00             	movzbl (%eax),%eax
    1101:	0f b6 d0             	movzbl %al,%edx
    1104:	8b 45 0c             	mov    0xc(%ebp),%eax
    1107:	0f b6 00             	movzbl (%eax),%eax
    110a:	0f b6 c0             	movzbl %al,%eax
    110d:	29 c2                	sub    %eax,%edx
    110f:	89 d0                	mov    %edx,%eax
}
    1111:	5d                   	pop    %ebp
    1112:	c3                   	ret    

00001113 <strlen>:

uint
strlen(const char *s)
{
    1113:	f3 0f 1e fb          	endbr32 
    1117:	55                   	push   %ebp
    1118:	89 e5                	mov    %esp,%ebp
    111a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    111d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1124:	eb 04                	jmp    112a <strlen+0x17>
    1126:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    112a:	8b 55 fc             	mov    -0x4(%ebp),%edx
    112d:	8b 45 08             	mov    0x8(%ebp),%eax
    1130:	01 d0                	add    %edx,%eax
    1132:	0f b6 00             	movzbl (%eax),%eax
    1135:	84 c0                	test   %al,%al
    1137:	75 ed                	jne    1126 <strlen+0x13>
    ;
  return n;
    1139:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    113c:	c9                   	leave  
    113d:	c3                   	ret    

0000113e <memset>:

void*
memset(void *dst, int c, uint n)
{
    113e:	f3 0f 1e fb          	endbr32 
    1142:	55                   	push   %ebp
    1143:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1145:	8b 45 10             	mov    0x10(%ebp),%eax
    1148:	50                   	push   %eax
    1149:	ff 75 0c             	pushl  0xc(%ebp)
    114c:	ff 75 08             	pushl  0x8(%ebp)
    114f:	e8 22 ff ff ff       	call   1076 <stosb>
    1154:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1157:	8b 45 08             	mov    0x8(%ebp),%eax
}
    115a:	c9                   	leave  
    115b:	c3                   	ret    

0000115c <strchr>:

char*
strchr(const char *s, char c)
{
    115c:	f3 0f 1e fb          	endbr32 
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	83 ec 04             	sub    $0x4,%esp
    1166:	8b 45 0c             	mov    0xc(%ebp),%eax
    1169:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    116c:	eb 14                	jmp    1182 <strchr+0x26>
    if(*s == c)
    116e:	8b 45 08             	mov    0x8(%ebp),%eax
    1171:	0f b6 00             	movzbl (%eax),%eax
    1174:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1177:	75 05                	jne    117e <strchr+0x22>
      return (char*)s;
    1179:	8b 45 08             	mov    0x8(%ebp),%eax
    117c:	eb 13                	jmp    1191 <strchr+0x35>
  for(; *s; s++)
    117e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1182:	8b 45 08             	mov    0x8(%ebp),%eax
    1185:	0f b6 00             	movzbl (%eax),%eax
    1188:	84 c0                	test   %al,%al
    118a:	75 e2                	jne    116e <strchr+0x12>
  return 0;
    118c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1191:	c9                   	leave  
    1192:	c3                   	ret    

00001193 <gets>:

char*
gets(char *buf, int max)
{
    1193:	f3 0f 1e fb          	endbr32 
    1197:	55                   	push   %ebp
    1198:	89 e5                	mov    %esp,%ebp
    119a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    119d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11a4:	eb 42                	jmp    11e8 <gets+0x55>
    cc = read(0, &c, 1);
    11a6:	83 ec 04             	sub    $0x4,%esp
    11a9:	6a 01                	push   $0x1
    11ab:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11ae:	50                   	push   %eax
    11af:	6a 00                	push   $0x0
    11b1:	e8 53 01 00 00       	call   1309 <read>
    11b6:	83 c4 10             	add    $0x10,%esp
    11b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11c0:	7e 33                	jle    11f5 <gets+0x62>
      break;
    buf[i++] = c;
    11c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11c5:	8d 50 01             	lea    0x1(%eax),%edx
    11c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11cb:	89 c2                	mov    %eax,%edx
    11cd:	8b 45 08             	mov    0x8(%ebp),%eax
    11d0:	01 c2                	add    %eax,%edx
    11d2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11d6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11d8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11dc:	3c 0a                	cmp    $0xa,%al
    11de:	74 16                	je     11f6 <gets+0x63>
    11e0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11e4:	3c 0d                	cmp    $0xd,%al
    11e6:	74 0e                	je     11f6 <gets+0x63>
  for(i=0; i+1 < max; ){
    11e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11eb:	83 c0 01             	add    $0x1,%eax
    11ee:	39 45 0c             	cmp    %eax,0xc(%ebp)
    11f1:	7f b3                	jg     11a6 <gets+0x13>
    11f3:	eb 01                	jmp    11f6 <gets+0x63>
      break;
    11f5:	90                   	nop
      break;
  }
  buf[i] = '\0';
    11f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11f9:	8b 45 08             	mov    0x8(%ebp),%eax
    11fc:	01 d0                	add    %edx,%eax
    11fe:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1201:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1204:	c9                   	leave  
    1205:	c3                   	ret    

00001206 <stat>:

int
stat(const char *n, struct stat *st)
{
    1206:	f3 0f 1e fb          	endbr32 
    120a:	55                   	push   %ebp
    120b:	89 e5                	mov    %esp,%ebp
    120d:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1210:	83 ec 08             	sub    $0x8,%esp
    1213:	6a 00                	push   $0x0
    1215:	ff 75 08             	pushl  0x8(%ebp)
    1218:	e8 14 01 00 00       	call   1331 <open>
    121d:	83 c4 10             	add    $0x10,%esp
    1220:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1223:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1227:	79 07                	jns    1230 <stat+0x2a>
    return -1;
    1229:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    122e:	eb 25                	jmp    1255 <stat+0x4f>
  r = fstat(fd, st);
    1230:	83 ec 08             	sub    $0x8,%esp
    1233:	ff 75 0c             	pushl  0xc(%ebp)
    1236:	ff 75 f4             	pushl  -0xc(%ebp)
    1239:	e8 0b 01 00 00       	call   1349 <fstat>
    123e:	83 c4 10             	add    $0x10,%esp
    1241:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1244:	83 ec 0c             	sub    $0xc,%esp
    1247:	ff 75 f4             	pushl  -0xc(%ebp)
    124a:	e8 ca 00 00 00       	call   1319 <close>
    124f:	83 c4 10             	add    $0x10,%esp
  return r;
    1252:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1255:	c9                   	leave  
    1256:	c3                   	ret    

00001257 <atoi>:

int
atoi(const char *s)
{
    1257:	f3 0f 1e fb          	endbr32 
    125b:	55                   	push   %ebp
    125c:	89 e5                	mov    %esp,%ebp
    125e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1261:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1268:	eb 25                	jmp    128f <atoi+0x38>
    n = n*10 + *s++ - '0';
    126a:	8b 55 fc             	mov    -0x4(%ebp),%edx
    126d:	89 d0                	mov    %edx,%eax
    126f:	c1 e0 02             	shl    $0x2,%eax
    1272:	01 d0                	add    %edx,%eax
    1274:	01 c0                	add    %eax,%eax
    1276:	89 c1                	mov    %eax,%ecx
    1278:	8b 45 08             	mov    0x8(%ebp),%eax
    127b:	8d 50 01             	lea    0x1(%eax),%edx
    127e:	89 55 08             	mov    %edx,0x8(%ebp)
    1281:	0f b6 00             	movzbl (%eax),%eax
    1284:	0f be c0             	movsbl %al,%eax
    1287:	01 c8                	add    %ecx,%eax
    1289:	83 e8 30             	sub    $0x30,%eax
    128c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    128f:	8b 45 08             	mov    0x8(%ebp),%eax
    1292:	0f b6 00             	movzbl (%eax),%eax
    1295:	3c 2f                	cmp    $0x2f,%al
    1297:	7e 0a                	jle    12a3 <atoi+0x4c>
    1299:	8b 45 08             	mov    0x8(%ebp),%eax
    129c:	0f b6 00             	movzbl (%eax),%eax
    129f:	3c 39                	cmp    $0x39,%al
    12a1:	7e c7                	jle    126a <atoi+0x13>
  return n;
    12a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12a6:	c9                   	leave  
    12a7:	c3                   	ret    

000012a8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12a8:	f3 0f 1e fb          	endbr32 
    12ac:	55                   	push   %ebp
    12ad:	89 e5                	mov    %esp,%ebp
    12af:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    12b2:	8b 45 08             	mov    0x8(%ebp),%eax
    12b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12b8:	8b 45 0c             	mov    0xc(%ebp),%eax
    12bb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12be:	eb 17                	jmp    12d7 <memmove+0x2f>
    *dst++ = *src++;
    12c0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12c3:	8d 42 01             	lea    0x1(%edx),%eax
    12c6:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12cc:	8d 48 01             	lea    0x1(%eax),%ecx
    12cf:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    12d2:	0f b6 12             	movzbl (%edx),%edx
    12d5:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    12d7:	8b 45 10             	mov    0x10(%ebp),%eax
    12da:	8d 50 ff             	lea    -0x1(%eax),%edx
    12dd:	89 55 10             	mov    %edx,0x10(%ebp)
    12e0:	85 c0                	test   %eax,%eax
    12e2:	7f dc                	jg     12c0 <memmove+0x18>
  return vdst;
    12e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12e7:	c9                   	leave  
    12e8:	c3                   	ret    

000012e9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12e9:	b8 01 00 00 00       	mov    $0x1,%eax
    12ee:	cd 40                	int    $0x40
    12f0:	c3                   	ret    

000012f1 <exit>:
SYSCALL(exit)
    12f1:	b8 02 00 00 00       	mov    $0x2,%eax
    12f6:	cd 40                	int    $0x40
    12f8:	c3                   	ret    

000012f9 <wait>:
SYSCALL(wait)
    12f9:	b8 03 00 00 00       	mov    $0x3,%eax
    12fe:	cd 40                	int    $0x40
    1300:	c3                   	ret    

00001301 <pipe>:
SYSCALL(pipe)
    1301:	b8 04 00 00 00       	mov    $0x4,%eax
    1306:	cd 40                	int    $0x40
    1308:	c3                   	ret    

00001309 <read>:
SYSCALL(read)
    1309:	b8 05 00 00 00       	mov    $0x5,%eax
    130e:	cd 40                	int    $0x40
    1310:	c3                   	ret    

00001311 <write>:
SYSCALL(write)
    1311:	b8 10 00 00 00       	mov    $0x10,%eax
    1316:	cd 40                	int    $0x40
    1318:	c3                   	ret    

00001319 <close>:
SYSCALL(close)
    1319:	b8 15 00 00 00       	mov    $0x15,%eax
    131e:	cd 40                	int    $0x40
    1320:	c3                   	ret    

00001321 <kill>:
SYSCALL(kill)
    1321:	b8 06 00 00 00       	mov    $0x6,%eax
    1326:	cd 40                	int    $0x40
    1328:	c3                   	ret    

00001329 <exec>:
SYSCALL(exec)
    1329:	b8 07 00 00 00       	mov    $0x7,%eax
    132e:	cd 40                	int    $0x40
    1330:	c3                   	ret    

00001331 <open>:
SYSCALL(open)
    1331:	b8 0f 00 00 00       	mov    $0xf,%eax
    1336:	cd 40                	int    $0x40
    1338:	c3                   	ret    

00001339 <mknod>:
SYSCALL(mknod)
    1339:	b8 11 00 00 00       	mov    $0x11,%eax
    133e:	cd 40                	int    $0x40
    1340:	c3                   	ret    

00001341 <unlink>:
SYSCALL(unlink)
    1341:	b8 12 00 00 00       	mov    $0x12,%eax
    1346:	cd 40                	int    $0x40
    1348:	c3                   	ret    

00001349 <fstat>:
SYSCALL(fstat)
    1349:	b8 08 00 00 00       	mov    $0x8,%eax
    134e:	cd 40                	int    $0x40
    1350:	c3                   	ret    

00001351 <link>:
SYSCALL(link)
    1351:	b8 13 00 00 00       	mov    $0x13,%eax
    1356:	cd 40                	int    $0x40
    1358:	c3                   	ret    

00001359 <mkdir>:
SYSCALL(mkdir)
    1359:	b8 14 00 00 00       	mov    $0x14,%eax
    135e:	cd 40                	int    $0x40
    1360:	c3                   	ret    

00001361 <chdir>:
SYSCALL(chdir)
    1361:	b8 09 00 00 00       	mov    $0x9,%eax
    1366:	cd 40                	int    $0x40
    1368:	c3                   	ret    

00001369 <dup>:
SYSCALL(dup)
    1369:	b8 0a 00 00 00       	mov    $0xa,%eax
    136e:	cd 40                	int    $0x40
    1370:	c3                   	ret    

00001371 <getpid>:
SYSCALL(getpid)
    1371:	b8 0b 00 00 00       	mov    $0xb,%eax
    1376:	cd 40                	int    $0x40
    1378:	c3                   	ret    

00001379 <sbrk>:
SYSCALL(sbrk)
    1379:	b8 0c 00 00 00       	mov    $0xc,%eax
    137e:	cd 40                	int    $0x40
    1380:	c3                   	ret    

00001381 <sleep>:
SYSCALL(sleep)
    1381:	b8 0d 00 00 00       	mov    $0xd,%eax
    1386:	cd 40                	int    $0x40
    1388:	c3                   	ret    

00001389 <uptime>:
SYSCALL(uptime)
    1389:	b8 0e 00 00 00       	mov    $0xe,%eax
    138e:	cd 40                	int    $0x40
    1390:	c3                   	ret    

00001391 <settickets>:
SYSCALL(settickets)
    1391:	b8 16 00 00 00       	mov    $0x16,%eax
    1396:	cd 40                	int    $0x40
    1398:	c3                   	ret    

00001399 <getpinfo>:
SYSCALL(getpinfo)
    1399:	b8 17 00 00 00       	mov    $0x17,%eax
    139e:	cd 40                	int    $0x40
    13a0:	c3                   	ret    

000013a1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13a1:	f3 0f 1e fb          	endbr32 
    13a5:	55                   	push   %ebp
    13a6:	89 e5                	mov    %esp,%ebp
    13a8:	83 ec 18             	sub    $0x18,%esp
    13ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ae:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13b1:	83 ec 04             	sub    $0x4,%esp
    13b4:	6a 01                	push   $0x1
    13b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13b9:	50                   	push   %eax
    13ba:	ff 75 08             	pushl  0x8(%ebp)
    13bd:	e8 4f ff ff ff       	call   1311 <write>
    13c2:	83 c4 10             	add    $0x10,%esp
}
    13c5:	90                   	nop
    13c6:	c9                   	leave  
    13c7:	c3                   	ret    

000013c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13c8:	f3 0f 1e fb          	endbr32 
    13cc:	55                   	push   %ebp
    13cd:	89 e5                	mov    %esp,%ebp
    13cf:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13d9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13dd:	74 17                	je     13f6 <printint+0x2e>
    13df:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13e3:	79 11                	jns    13f6 <printint+0x2e>
    neg = 1;
    13e5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13ec:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ef:	f7 d8                	neg    %eax
    13f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13f4:	eb 06                	jmp    13fc <printint+0x34>
  } else {
    x = xx;
    13f6:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1403:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1406:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1409:	ba 00 00 00 00       	mov    $0x0,%edx
    140e:	f7 f1                	div    %ecx
    1410:	89 d1                	mov    %edx,%ecx
    1412:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1415:	8d 50 01             	lea    0x1(%eax),%edx
    1418:	89 55 f4             	mov    %edx,-0xc(%ebp)
    141b:	0f b6 91 a8 1a 00 00 	movzbl 0x1aa8(%ecx),%edx
    1422:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1426:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1429:	8b 45 ec             	mov    -0x14(%ebp),%eax
    142c:	ba 00 00 00 00       	mov    $0x0,%edx
    1431:	f7 f1                	div    %ecx
    1433:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1436:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    143a:	75 c7                	jne    1403 <printint+0x3b>
  if(neg)
    143c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1440:	74 2d                	je     146f <printint+0xa7>
    buf[i++] = '-';
    1442:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1445:	8d 50 01             	lea    0x1(%eax),%edx
    1448:	89 55 f4             	mov    %edx,-0xc(%ebp)
    144b:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1450:	eb 1d                	jmp    146f <printint+0xa7>
    putc(fd, buf[i]);
    1452:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1455:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1458:	01 d0                	add    %edx,%eax
    145a:	0f b6 00             	movzbl (%eax),%eax
    145d:	0f be c0             	movsbl %al,%eax
    1460:	83 ec 08             	sub    $0x8,%esp
    1463:	50                   	push   %eax
    1464:	ff 75 08             	pushl  0x8(%ebp)
    1467:	e8 35 ff ff ff       	call   13a1 <putc>
    146c:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    146f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1473:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1477:	79 d9                	jns    1452 <printint+0x8a>
}
    1479:	90                   	nop
    147a:	90                   	nop
    147b:	c9                   	leave  
    147c:	c3                   	ret    

0000147d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    147d:	f3 0f 1e fb          	endbr32 
    1481:	55                   	push   %ebp
    1482:	89 e5                	mov    %esp,%ebp
    1484:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1487:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    148e:	8d 45 0c             	lea    0xc(%ebp),%eax
    1491:	83 c0 04             	add    $0x4,%eax
    1494:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1497:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    149e:	e9 59 01 00 00       	jmp    15fc <printf+0x17f>
    c = fmt[i] & 0xff;
    14a3:	8b 55 0c             	mov    0xc(%ebp),%edx
    14a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14a9:	01 d0                	add    %edx,%eax
    14ab:	0f b6 00             	movzbl (%eax),%eax
    14ae:	0f be c0             	movsbl %al,%eax
    14b1:	25 ff 00 00 00       	and    $0xff,%eax
    14b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14bd:	75 2c                	jne    14eb <printf+0x6e>
      if(c == '%'){
    14bf:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14c3:	75 0c                	jne    14d1 <printf+0x54>
        state = '%';
    14c5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14cc:	e9 27 01 00 00       	jmp    15f8 <printf+0x17b>
      } else {
        putc(fd, c);
    14d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14d4:	0f be c0             	movsbl %al,%eax
    14d7:	83 ec 08             	sub    $0x8,%esp
    14da:	50                   	push   %eax
    14db:	ff 75 08             	pushl  0x8(%ebp)
    14de:	e8 be fe ff ff       	call   13a1 <putc>
    14e3:	83 c4 10             	add    $0x10,%esp
    14e6:	e9 0d 01 00 00       	jmp    15f8 <printf+0x17b>
      }
    } else if(state == '%'){
    14eb:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14ef:	0f 85 03 01 00 00    	jne    15f8 <printf+0x17b>
      if(c == 'd'){
    14f5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14f9:	75 1e                	jne    1519 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    14fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14fe:	8b 00                	mov    (%eax),%eax
    1500:	6a 01                	push   $0x1
    1502:	6a 0a                	push   $0xa
    1504:	50                   	push   %eax
    1505:	ff 75 08             	pushl  0x8(%ebp)
    1508:	e8 bb fe ff ff       	call   13c8 <printint>
    150d:	83 c4 10             	add    $0x10,%esp
        ap++;
    1510:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1514:	e9 d8 00 00 00       	jmp    15f1 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    1519:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    151d:	74 06                	je     1525 <printf+0xa8>
    151f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1523:	75 1e                	jne    1543 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1525:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1528:	8b 00                	mov    (%eax),%eax
    152a:	6a 00                	push   $0x0
    152c:	6a 10                	push   $0x10
    152e:	50                   	push   %eax
    152f:	ff 75 08             	pushl  0x8(%ebp)
    1532:	e8 91 fe ff ff       	call   13c8 <printint>
    1537:	83 c4 10             	add    $0x10,%esp
        ap++;
    153a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    153e:	e9 ae 00 00 00       	jmp    15f1 <printf+0x174>
      } else if(c == 's'){
    1543:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1547:	75 43                	jne    158c <printf+0x10f>
        s = (char*)*ap;
    1549:	8b 45 e8             	mov    -0x18(%ebp),%eax
    154c:	8b 00                	mov    (%eax),%eax
    154e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1551:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1555:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1559:	75 25                	jne    1580 <printf+0x103>
          s = "(null)";
    155b:	c7 45 f4 58 18 00 00 	movl   $0x1858,-0xc(%ebp)
        while(*s != 0){
    1562:	eb 1c                	jmp    1580 <printf+0x103>
          putc(fd, *s);
    1564:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1567:	0f b6 00             	movzbl (%eax),%eax
    156a:	0f be c0             	movsbl %al,%eax
    156d:	83 ec 08             	sub    $0x8,%esp
    1570:	50                   	push   %eax
    1571:	ff 75 08             	pushl  0x8(%ebp)
    1574:	e8 28 fe ff ff       	call   13a1 <putc>
    1579:	83 c4 10             	add    $0x10,%esp
          s++;
    157c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1580:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1583:	0f b6 00             	movzbl (%eax),%eax
    1586:	84 c0                	test   %al,%al
    1588:	75 da                	jne    1564 <printf+0xe7>
    158a:	eb 65                	jmp    15f1 <printf+0x174>
        }
      } else if(c == 'c'){
    158c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1590:	75 1d                	jne    15af <printf+0x132>
        putc(fd, *ap);
    1592:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1595:	8b 00                	mov    (%eax),%eax
    1597:	0f be c0             	movsbl %al,%eax
    159a:	83 ec 08             	sub    $0x8,%esp
    159d:	50                   	push   %eax
    159e:	ff 75 08             	pushl  0x8(%ebp)
    15a1:	e8 fb fd ff ff       	call   13a1 <putc>
    15a6:	83 c4 10             	add    $0x10,%esp
        ap++;
    15a9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15ad:	eb 42                	jmp    15f1 <printf+0x174>
      } else if(c == '%'){
    15af:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15b3:	75 17                	jne    15cc <printf+0x14f>
        putc(fd, c);
    15b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15b8:	0f be c0             	movsbl %al,%eax
    15bb:	83 ec 08             	sub    $0x8,%esp
    15be:	50                   	push   %eax
    15bf:	ff 75 08             	pushl  0x8(%ebp)
    15c2:	e8 da fd ff ff       	call   13a1 <putc>
    15c7:	83 c4 10             	add    $0x10,%esp
    15ca:	eb 25                	jmp    15f1 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15cc:	83 ec 08             	sub    $0x8,%esp
    15cf:	6a 25                	push   $0x25
    15d1:	ff 75 08             	pushl  0x8(%ebp)
    15d4:	e8 c8 fd ff ff       	call   13a1 <putc>
    15d9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15df:	0f be c0             	movsbl %al,%eax
    15e2:	83 ec 08             	sub    $0x8,%esp
    15e5:	50                   	push   %eax
    15e6:	ff 75 08             	pushl  0x8(%ebp)
    15e9:	e8 b3 fd ff ff       	call   13a1 <putc>
    15ee:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    15f8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15fc:	8b 55 0c             	mov    0xc(%ebp),%edx
    15ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1602:	01 d0                	add    %edx,%eax
    1604:	0f b6 00             	movzbl (%eax),%eax
    1607:	84 c0                	test   %al,%al
    1609:	0f 85 94 fe ff ff    	jne    14a3 <printf+0x26>
    }
  }
}
    160f:	90                   	nop
    1610:	90                   	nop
    1611:	c9                   	leave  
    1612:	c3                   	ret    

00001613 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1613:	f3 0f 1e fb          	endbr32 
    1617:	55                   	push   %ebp
    1618:	89 e5                	mov    %esp,%ebp
    161a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    161d:	8b 45 08             	mov    0x8(%ebp),%eax
    1620:	83 e8 08             	sub    $0x8,%eax
    1623:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1626:	a1 c4 1a 00 00       	mov    0x1ac4,%eax
    162b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    162e:	eb 24                	jmp    1654 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1630:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1633:	8b 00                	mov    (%eax),%eax
    1635:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1638:	72 12                	jb     164c <free+0x39>
    163a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    163d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1640:	77 24                	ja     1666 <free+0x53>
    1642:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1645:	8b 00                	mov    (%eax),%eax
    1647:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    164a:	72 1a                	jb     1666 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    164c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    164f:	8b 00                	mov    (%eax),%eax
    1651:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1654:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1657:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    165a:	76 d4                	jbe    1630 <free+0x1d>
    165c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165f:	8b 00                	mov    (%eax),%eax
    1661:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1664:	73 ca                	jae    1630 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1666:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1669:	8b 40 04             	mov    0x4(%eax),%eax
    166c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1673:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1676:	01 c2                	add    %eax,%edx
    1678:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167b:	8b 00                	mov    (%eax),%eax
    167d:	39 c2                	cmp    %eax,%edx
    167f:	75 24                	jne    16a5 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1681:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1684:	8b 50 04             	mov    0x4(%eax),%edx
    1687:	8b 45 fc             	mov    -0x4(%ebp),%eax
    168a:	8b 00                	mov    (%eax),%eax
    168c:	8b 40 04             	mov    0x4(%eax),%eax
    168f:	01 c2                	add    %eax,%edx
    1691:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1694:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1697:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169a:	8b 00                	mov    (%eax),%eax
    169c:	8b 10                	mov    (%eax),%edx
    169e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a1:	89 10                	mov    %edx,(%eax)
    16a3:	eb 0a                	jmp    16af <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    16a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a8:	8b 10                	mov    (%eax),%edx
    16aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ad:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16af:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b2:	8b 40 04             	mov    0x4(%eax),%eax
    16b5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bf:	01 d0                	add    %edx,%eax
    16c1:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16c4:	75 20                	jne    16e6 <free+0xd3>
    p->s.size += bp->s.size;
    16c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c9:	8b 50 04             	mov    0x4(%eax),%edx
    16cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16cf:	8b 40 04             	mov    0x4(%eax),%eax
    16d2:	01 c2                	add    %eax,%edx
    16d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16da:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16dd:	8b 10                	mov    (%eax),%edx
    16df:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e2:	89 10                	mov    %edx,(%eax)
    16e4:	eb 08                	jmp    16ee <free+0xdb>
  } else
    p->s.ptr = bp;
    16e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e9:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16ec:	89 10                	mov    %edx,(%eax)
  freep = p;
    16ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f1:	a3 c4 1a 00 00       	mov    %eax,0x1ac4
}
    16f6:	90                   	nop
    16f7:	c9                   	leave  
    16f8:	c3                   	ret    

000016f9 <morecore>:

static Header*
morecore(uint nu)
{
    16f9:	f3 0f 1e fb          	endbr32 
    16fd:	55                   	push   %ebp
    16fe:	89 e5                	mov    %esp,%ebp
    1700:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1703:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    170a:	77 07                	ja     1713 <morecore+0x1a>
    nu = 4096;
    170c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1713:	8b 45 08             	mov    0x8(%ebp),%eax
    1716:	c1 e0 03             	shl    $0x3,%eax
    1719:	83 ec 0c             	sub    $0xc,%esp
    171c:	50                   	push   %eax
    171d:	e8 57 fc ff ff       	call   1379 <sbrk>
    1722:	83 c4 10             	add    $0x10,%esp
    1725:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1728:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    172c:	75 07                	jne    1735 <morecore+0x3c>
    return 0;
    172e:	b8 00 00 00 00       	mov    $0x0,%eax
    1733:	eb 26                	jmp    175b <morecore+0x62>
  hp = (Header*)p;
    1735:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1738:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    173b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    173e:	8b 55 08             	mov    0x8(%ebp),%edx
    1741:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1744:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1747:	83 c0 08             	add    $0x8,%eax
    174a:	83 ec 0c             	sub    $0xc,%esp
    174d:	50                   	push   %eax
    174e:	e8 c0 fe ff ff       	call   1613 <free>
    1753:	83 c4 10             	add    $0x10,%esp
  return freep;
    1756:	a1 c4 1a 00 00       	mov    0x1ac4,%eax
}
    175b:	c9                   	leave  
    175c:	c3                   	ret    

0000175d <malloc>:

void*
malloc(uint nbytes)
{
    175d:	f3 0f 1e fb          	endbr32 
    1761:	55                   	push   %ebp
    1762:	89 e5                	mov    %esp,%ebp
    1764:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1767:	8b 45 08             	mov    0x8(%ebp),%eax
    176a:	83 c0 07             	add    $0x7,%eax
    176d:	c1 e8 03             	shr    $0x3,%eax
    1770:	83 c0 01             	add    $0x1,%eax
    1773:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1776:	a1 c4 1a 00 00       	mov    0x1ac4,%eax
    177b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    177e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1782:	75 23                	jne    17a7 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1784:	c7 45 f0 bc 1a 00 00 	movl   $0x1abc,-0x10(%ebp)
    178b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    178e:	a3 c4 1a 00 00       	mov    %eax,0x1ac4
    1793:	a1 c4 1a 00 00       	mov    0x1ac4,%eax
    1798:	a3 bc 1a 00 00       	mov    %eax,0x1abc
    base.s.size = 0;
    179d:	c7 05 c0 1a 00 00 00 	movl   $0x0,0x1ac0
    17a4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17aa:	8b 00                	mov    (%eax),%eax
    17ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b2:	8b 40 04             	mov    0x4(%eax),%eax
    17b5:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17b8:	77 4d                	ja     1807 <malloc+0xaa>
      if(p->s.size == nunits)
    17ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bd:	8b 40 04             	mov    0x4(%eax),%eax
    17c0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17c3:	75 0c                	jne    17d1 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    17c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c8:	8b 10                	mov    (%eax),%edx
    17ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17cd:	89 10                	mov    %edx,(%eax)
    17cf:	eb 26                	jmp    17f7 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    17d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d4:	8b 40 04             	mov    0x4(%eax),%eax
    17d7:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17da:	89 c2                	mov    %eax,%edx
    17dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17df:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e5:	8b 40 04             	mov    0x4(%eax),%eax
    17e8:	c1 e0 03             	shl    $0x3,%eax
    17eb:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17f4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17fa:	a3 c4 1a 00 00       	mov    %eax,0x1ac4
      return (void*)(p + 1);
    17ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1802:	83 c0 08             	add    $0x8,%eax
    1805:	eb 3b                	jmp    1842 <malloc+0xe5>
    }
    if(p == freep)
    1807:	a1 c4 1a 00 00       	mov    0x1ac4,%eax
    180c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    180f:	75 1e                	jne    182f <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1811:	83 ec 0c             	sub    $0xc,%esp
    1814:	ff 75 ec             	pushl  -0x14(%ebp)
    1817:	e8 dd fe ff ff       	call   16f9 <morecore>
    181c:	83 c4 10             	add    $0x10,%esp
    181f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1822:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1826:	75 07                	jne    182f <malloc+0xd2>
        return 0;
    1828:	b8 00 00 00 00       	mov    $0x0,%eax
    182d:	eb 13                	jmp    1842 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    182f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1832:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1835:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1838:	8b 00                	mov    (%eax),%eax
    183a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    183d:	e9 6d ff ff ff       	jmp    17af <malloc+0x52>
  }
}
    1842:	c9                   	leave  
    1843:	c3                   	ret    
