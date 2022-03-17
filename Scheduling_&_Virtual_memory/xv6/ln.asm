
_ln:     file format elf32-i386


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
    1013:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
    1015:	83 3b 03             	cmpl   $0x3,(%ebx)
    1018:	74 17                	je     1031 <main+0x31>
    printf(2, "Usage: ln old new\n");
    101a:	83 ec 08             	sub    $0x8,%esp
    101d:	68 46 18 00 00       	push   $0x1846
    1022:	6a 02                	push   $0x2
    1024:	e8 56 04 00 00       	call   147f <printf>
    1029:	83 c4 10             	add    $0x10,%esp
    exit();
    102c:	e8 c2 02 00 00       	call   12f3 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
    1031:	8b 43 04             	mov    0x4(%ebx),%eax
    1034:	83 c0 08             	add    $0x8,%eax
    1037:	8b 10                	mov    (%eax),%edx
    1039:	8b 43 04             	mov    0x4(%ebx),%eax
    103c:	83 c0 04             	add    $0x4,%eax
    103f:	8b 00                	mov    (%eax),%eax
    1041:	83 ec 08             	sub    $0x8,%esp
    1044:	52                   	push   %edx
    1045:	50                   	push   %eax
    1046:	e8 08 03 00 00       	call   1353 <link>
    104b:	83 c4 10             	add    $0x10,%esp
    104e:	85 c0                	test   %eax,%eax
    1050:	79 21                	jns    1073 <main+0x73>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
    1052:	8b 43 04             	mov    0x4(%ebx),%eax
    1055:	83 c0 08             	add    $0x8,%eax
    1058:	8b 10                	mov    (%eax),%edx
    105a:	8b 43 04             	mov    0x4(%ebx),%eax
    105d:	83 c0 04             	add    $0x4,%eax
    1060:	8b 00                	mov    (%eax),%eax
    1062:	52                   	push   %edx
    1063:	50                   	push   %eax
    1064:	68 59 18 00 00       	push   $0x1859
    1069:	6a 02                	push   $0x2
    106b:	e8 0f 04 00 00       	call   147f <printf>
    1070:	83 c4 10             	add    $0x10,%esp
  exit();
    1073:	e8 7b 02 00 00       	call   12f3 <exit>

00001078 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1078:	55                   	push   %ebp
    1079:	89 e5                	mov    %esp,%ebp
    107b:	57                   	push   %edi
    107c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    107d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1080:	8b 55 10             	mov    0x10(%ebp),%edx
    1083:	8b 45 0c             	mov    0xc(%ebp),%eax
    1086:	89 cb                	mov    %ecx,%ebx
    1088:	89 df                	mov    %ebx,%edi
    108a:	89 d1                	mov    %edx,%ecx
    108c:	fc                   	cld    
    108d:	f3 aa                	rep stos %al,%es:(%edi)
    108f:	89 ca                	mov    %ecx,%edx
    1091:	89 fb                	mov    %edi,%ebx
    1093:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1096:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1099:	90                   	nop
    109a:	5b                   	pop    %ebx
    109b:	5f                   	pop    %edi
    109c:	5d                   	pop    %ebp
    109d:	c3                   	ret    

0000109e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    109e:	f3 0f 1e fb          	endbr32 
    10a2:	55                   	push   %ebp
    10a3:	89 e5                	mov    %esp,%ebp
    10a5:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10a8:	8b 45 08             	mov    0x8(%ebp),%eax
    10ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10ae:	90                   	nop
    10af:	8b 55 0c             	mov    0xc(%ebp),%edx
    10b2:	8d 42 01             	lea    0x1(%edx),%eax
    10b5:	89 45 0c             	mov    %eax,0xc(%ebp)
    10b8:	8b 45 08             	mov    0x8(%ebp),%eax
    10bb:	8d 48 01             	lea    0x1(%eax),%ecx
    10be:	89 4d 08             	mov    %ecx,0x8(%ebp)
    10c1:	0f b6 12             	movzbl (%edx),%edx
    10c4:	88 10                	mov    %dl,(%eax)
    10c6:	0f b6 00             	movzbl (%eax),%eax
    10c9:	84 c0                	test   %al,%al
    10cb:	75 e2                	jne    10af <strcpy+0x11>
    ;
  return os;
    10cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10d0:	c9                   	leave  
    10d1:	c3                   	ret    

000010d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10d2:	f3 0f 1e fb          	endbr32 
    10d6:	55                   	push   %ebp
    10d7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10d9:	eb 08                	jmp    10e3 <strcmp+0x11>
    p++, q++;
    10db:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10df:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    10e3:	8b 45 08             	mov    0x8(%ebp),%eax
    10e6:	0f b6 00             	movzbl (%eax),%eax
    10e9:	84 c0                	test   %al,%al
    10eb:	74 10                	je     10fd <strcmp+0x2b>
    10ed:	8b 45 08             	mov    0x8(%ebp),%eax
    10f0:	0f b6 10             	movzbl (%eax),%edx
    10f3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f6:	0f b6 00             	movzbl (%eax),%eax
    10f9:	38 c2                	cmp    %al,%dl
    10fb:	74 de                	je     10db <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    10fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1100:	0f b6 00             	movzbl (%eax),%eax
    1103:	0f b6 d0             	movzbl %al,%edx
    1106:	8b 45 0c             	mov    0xc(%ebp),%eax
    1109:	0f b6 00             	movzbl (%eax),%eax
    110c:	0f b6 c0             	movzbl %al,%eax
    110f:	29 c2                	sub    %eax,%edx
    1111:	89 d0                	mov    %edx,%eax
}
    1113:	5d                   	pop    %ebp
    1114:	c3                   	ret    

00001115 <strlen>:

uint
strlen(const char *s)
{
    1115:	f3 0f 1e fb          	endbr32 
    1119:	55                   	push   %ebp
    111a:	89 e5                	mov    %esp,%ebp
    111c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    111f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1126:	eb 04                	jmp    112c <strlen+0x17>
    1128:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    112c:	8b 55 fc             	mov    -0x4(%ebp),%edx
    112f:	8b 45 08             	mov    0x8(%ebp),%eax
    1132:	01 d0                	add    %edx,%eax
    1134:	0f b6 00             	movzbl (%eax),%eax
    1137:	84 c0                	test   %al,%al
    1139:	75 ed                	jne    1128 <strlen+0x13>
    ;
  return n;
    113b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    113e:	c9                   	leave  
    113f:	c3                   	ret    

00001140 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1140:	f3 0f 1e fb          	endbr32 
    1144:	55                   	push   %ebp
    1145:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1147:	8b 45 10             	mov    0x10(%ebp),%eax
    114a:	50                   	push   %eax
    114b:	ff 75 0c             	pushl  0xc(%ebp)
    114e:	ff 75 08             	pushl  0x8(%ebp)
    1151:	e8 22 ff ff ff       	call   1078 <stosb>
    1156:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1159:	8b 45 08             	mov    0x8(%ebp),%eax
}
    115c:	c9                   	leave  
    115d:	c3                   	ret    

0000115e <strchr>:

char*
strchr(const char *s, char c)
{
    115e:	f3 0f 1e fb          	endbr32 
    1162:	55                   	push   %ebp
    1163:	89 e5                	mov    %esp,%ebp
    1165:	83 ec 04             	sub    $0x4,%esp
    1168:	8b 45 0c             	mov    0xc(%ebp),%eax
    116b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    116e:	eb 14                	jmp    1184 <strchr+0x26>
    if(*s == c)
    1170:	8b 45 08             	mov    0x8(%ebp),%eax
    1173:	0f b6 00             	movzbl (%eax),%eax
    1176:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1179:	75 05                	jne    1180 <strchr+0x22>
      return (char*)s;
    117b:	8b 45 08             	mov    0x8(%ebp),%eax
    117e:	eb 13                	jmp    1193 <strchr+0x35>
  for(; *s; s++)
    1180:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	0f b6 00             	movzbl (%eax),%eax
    118a:	84 c0                	test   %al,%al
    118c:	75 e2                	jne    1170 <strchr+0x12>
  return 0;
    118e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1193:	c9                   	leave  
    1194:	c3                   	ret    

00001195 <gets>:

char*
gets(char *buf, int max)
{
    1195:	f3 0f 1e fb          	endbr32 
    1199:	55                   	push   %ebp
    119a:	89 e5                	mov    %esp,%ebp
    119c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    119f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11a6:	eb 42                	jmp    11ea <gets+0x55>
    cc = read(0, &c, 1);
    11a8:	83 ec 04             	sub    $0x4,%esp
    11ab:	6a 01                	push   $0x1
    11ad:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11b0:	50                   	push   %eax
    11b1:	6a 00                	push   $0x0
    11b3:	e8 53 01 00 00       	call   130b <read>
    11b8:	83 c4 10             	add    $0x10,%esp
    11bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11c2:	7e 33                	jle    11f7 <gets+0x62>
      break;
    buf[i++] = c;
    11c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11c7:	8d 50 01             	lea    0x1(%eax),%edx
    11ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11cd:	89 c2                	mov    %eax,%edx
    11cf:	8b 45 08             	mov    0x8(%ebp),%eax
    11d2:	01 c2                	add    %eax,%edx
    11d4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11d8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11da:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11de:	3c 0a                	cmp    $0xa,%al
    11e0:	74 16                	je     11f8 <gets+0x63>
    11e2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11e6:	3c 0d                	cmp    $0xd,%al
    11e8:	74 0e                	je     11f8 <gets+0x63>
  for(i=0; i+1 < max; ){
    11ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ed:	83 c0 01             	add    $0x1,%eax
    11f0:	39 45 0c             	cmp    %eax,0xc(%ebp)
    11f3:	7f b3                	jg     11a8 <gets+0x13>
    11f5:	eb 01                	jmp    11f8 <gets+0x63>
      break;
    11f7:	90                   	nop
      break;
  }
  buf[i] = '\0';
    11f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11fb:	8b 45 08             	mov    0x8(%ebp),%eax
    11fe:	01 d0                	add    %edx,%eax
    1200:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1203:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1206:	c9                   	leave  
    1207:	c3                   	ret    

00001208 <stat>:

int
stat(const char *n, struct stat *st)
{
    1208:	f3 0f 1e fb          	endbr32 
    120c:	55                   	push   %ebp
    120d:	89 e5                	mov    %esp,%ebp
    120f:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1212:	83 ec 08             	sub    $0x8,%esp
    1215:	6a 00                	push   $0x0
    1217:	ff 75 08             	pushl  0x8(%ebp)
    121a:	e8 14 01 00 00       	call   1333 <open>
    121f:	83 c4 10             	add    $0x10,%esp
    1222:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1225:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1229:	79 07                	jns    1232 <stat+0x2a>
    return -1;
    122b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1230:	eb 25                	jmp    1257 <stat+0x4f>
  r = fstat(fd, st);
    1232:	83 ec 08             	sub    $0x8,%esp
    1235:	ff 75 0c             	pushl  0xc(%ebp)
    1238:	ff 75 f4             	pushl  -0xc(%ebp)
    123b:	e8 0b 01 00 00       	call   134b <fstat>
    1240:	83 c4 10             	add    $0x10,%esp
    1243:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1246:	83 ec 0c             	sub    $0xc,%esp
    1249:	ff 75 f4             	pushl  -0xc(%ebp)
    124c:	e8 ca 00 00 00       	call   131b <close>
    1251:	83 c4 10             	add    $0x10,%esp
  return r;
    1254:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1257:	c9                   	leave  
    1258:	c3                   	ret    

00001259 <atoi>:

int
atoi(const char *s)
{
    1259:	f3 0f 1e fb          	endbr32 
    125d:	55                   	push   %ebp
    125e:	89 e5                	mov    %esp,%ebp
    1260:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1263:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    126a:	eb 25                	jmp    1291 <atoi+0x38>
    n = n*10 + *s++ - '0';
    126c:	8b 55 fc             	mov    -0x4(%ebp),%edx
    126f:	89 d0                	mov    %edx,%eax
    1271:	c1 e0 02             	shl    $0x2,%eax
    1274:	01 d0                	add    %edx,%eax
    1276:	01 c0                	add    %eax,%eax
    1278:	89 c1                	mov    %eax,%ecx
    127a:	8b 45 08             	mov    0x8(%ebp),%eax
    127d:	8d 50 01             	lea    0x1(%eax),%edx
    1280:	89 55 08             	mov    %edx,0x8(%ebp)
    1283:	0f b6 00             	movzbl (%eax),%eax
    1286:	0f be c0             	movsbl %al,%eax
    1289:	01 c8                	add    %ecx,%eax
    128b:	83 e8 30             	sub    $0x30,%eax
    128e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	0f b6 00             	movzbl (%eax),%eax
    1297:	3c 2f                	cmp    $0x2f,%al
    1299:	7e 0a                	jle    12a5 <atoi+0x4c>
    129b:	8b 45 08             	mov    0x8(%ebp),%eax
    129e:	0f b6 00             	movzbl (%eax),%eax
    12a1:	3c 39                	cmp    $0x39,%al
    12a3:	7e c7                	jle    126c <atoi+0x13>
  return n;
    12a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12a8:	c9                   	leave  
    12a9:	c3                   	ret    

000012aa <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12aa:	f3 0f 1e fb          	endbr32 
    12ae:	55                   	push   %ebp
    12af:	89 e5                	mov    %esp,%ebp
    12b1:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    12b4:	8b 45 08             	mov    0x8(%ebp),%eax
    12b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    12bd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12c0:	eb 17                	jmp    12d9 <memmove+0x2f>
    *dst++ = *src++;
    12c2:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12c5:	8d 42 01             	lea    0x1(%edx),%eax
    12c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ce:	8d 48 01             	lea    0x1(%eax),%ecx
    12d1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    12d4:	0f b6 12             	movzbl (%edx),%edx
    12d7:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    12d9:	8b 45 10             	mov    0x10(%ebp),%eax
    12dc:	8d 50 ff             	lea    -0x1(%eax),%edx
    12df:	89 55 10             	mov    %edx,0x10(%ebp)
    12e2:	85 c0                	test   %eax,%eax
    12e4:	7f dc                	jg     12c2 <memmove+0x18>
  return vdst;
    12e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12e9:	c9                   	leave  
    12ea:	c3                   	ret    

000012eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12eb:	b8 01 00 00 00       	mov    $0x1,%eax
    12f0:	cd 40                	int    $0x40
    12f2:	c3                   	ret    

000012f3 <exit>:
SYSCALL(exit)
    12f3:	b8 02 00 00 00       	mov    $0x2,%eax
    12f8:	cd 40                	int    $0x40
    12fa:	c3                   	ret    

000012fb <wait>:
SYSCALL(wait)
    12fb:	b8 03 00 00 00       	mov    $0x3,%eax
    1300:	cd 40                	int    $0x40
    1302:	c3                   	ret    

00001303 <pipe>:
SYSCALL(pipe)
    1303:	b8 04 00 00 00       	mov    $0x4,%eax
    1308:	cd 40                	int    $0x40
    130a:	c3                   	ret    

0000130b <read>:
SYSCALL(read)
    130b:	b8 05 00 00 00       	mov    $0x5,%eax
    1310:	cd 40                	int    $0x40
    1312:	c3                   	ret    

00001313 <write>:
SYSCALL(write)
    1313:	b8 10 00 00 00       	mov    $0x10,%eax
    1318:	cd 40                	int    $0x40
    131a:	c3                   	ret    

0000131b <close>:
SYSCALL(close)
    131b:	b8 15 00 00 00       	mov    $0x15,%eax
    1320:	cd 40                	int    $0x40
    1322:	c3                   	ret    

00001323 <kill>:
SYSCALL(kill)
    1323:	b8 06 00 00 00       	mov    $0x6,%eax
    1328:	cd 40                	int    $0x40
    132a:	c3                   	ret    

0000132b <exec>:
SYSCALL(exec)
    132b:	b8 07 00 00 00       	mov    $0x7,%eax
    1330:	cd 40                	int    $0x40
    1332:	c3                   	ret    

00001333 <open>:
SYSCALL(open)
    1333:	b8 0f 00 00 00       	mov    $0xf,%eax
    1338:	cd 40                	int    $0x40
    133a:	c3                   	ret    

0000133b <mknod>:
SYSCALL(mknod)
    133b:	b8 11 00 00 00       	mov    $0x11,%eax
    1340:	cd 40                	int    $0x40
    1342:	c3                   	ret    

00001343 <unlink>:
SYSCALL(unlink)
    1343:	b8 12 00 00 00       	mov    $0x12,%eax
    1348:	cd 40                	int    $0x40
    134a:	c3                   	ret    

0000134b <fstat>:
SYSCALL(fstat)
    134b:	b8 08 00 00 00       	mov    $0x8,%eax
    1350:	cd 40                	int    $0x40
    1352:	c3                   	ret    

00001353 <link>:
SYSCALL(link)
    1353:	b8 13 00 00 00       	mov    $0x13,%eax
    1358:	cd 40                	int    $0x40
    135a:	c3                   	ret    

0000135b <mkdir>:
SYSCALL(mkdir)
    135b:	b8 14 00 00 00       	mov    $0x14,%eax
    1360:	cd 40                	int    $0x40
    1362:	c3                   	ret    

00001363 <chdir>:
SYSCALL(chdir)
    1363:	b8 09 00 00 00       	mov    $0x9,%eax
    1368:	cd 40                	int    $0x40
    136a:	c3                   	ret    

0000136b <dup>:
SYSCALL(dup)
    136b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1370:	cd 40                	int    $0x40
    1372:	c3                   	ret    

00001373 <getpid>:
SYSCALL(getpid)
    1373:	b8 0b 00 00 00       	mov    $0xb,%eax
    1378:	cd 40                	int    $0x40
    137a:	c3                   	ret    

0000137b <sbrk>:
SYSCALL(sbrk)
    137b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1380:	cd 40                	int    $0x40
    1382:	c3                   	ret    

00001383 <sleep>:
SYSCALL(sleep)
    1383:	b8 0d 00 00 00       	mov    $0xd,%eax
    1388:	cd 40                	int    $0x40
    138a:	c3                   	ret    

0000138b <uptime>:
SYSCALL(uptime)
    138b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1390:	cd 40                	int    $0x40
    1392:	c3                   	ret    

00001393 <settickets>:
SYSCALL(settickets)
    1393:	b8 16 00 00 00       	mov    $0x16,%eax
    1398:	cd 40                	int    $0x40
    139a:	c3                   	ret    

0000139b <getpinfo>:
SYSCALL(getpinfo)
    139b:	b8 17 00 00 00       	mov    $0x17,%eax
    13a0:	cd 40                	int    $0x40
    13a2:	c3                   	ret    

000013a3 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13a3:	f3 0f 1e fb          	endbr32 
    13a7:	55                   	push   %ebp
    13a8:	89 e5                	mov    %esp,%ebp
    13aa:	83 ec 18             	sub    $0x18,%esp
    13ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    13b0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13b3:	83 ec 04             	sub    $0x4,%esp
    13b6:	6a 01                	push   $0x1
    13b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13bb:	50                   	push   %eax
    13bc:	ff 75 08             	pushl  0x8(%ebp)
    13bf:	e8 4f ff ff ff       	call   1313 <write>
    13c4:	83 c4 10             	add    $0x10,%esp
}
    13c7:	90                   	nop
    13c8:	c9                   	leave  
    13c9:	c3                   	ret    

000013ca <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13ca:	f3 0f 1e fb          	endbr32 
    13ce:	55                   	push   %ebp
    13cf:	89 e5                	mov    %esp,%ebp
    13d1:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13d4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13db:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13df:	74 17                	je     13f8 <printint+0x2e>
    13e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13e5:	79 11                	jns    13f8 <printint+0x2e>
    neg = 1;
    13e7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f1:	f7 d8                	neg    %eax
    13f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13f6:	eb 06                	jmp    13fe <printint+0x34>
  } else {
    x = xx;
    13f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    13fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1405:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1408:	8b 45 ec             	mov    -0x14(%ebp),%eax
    140b:	ba 00 00 00 00       	mov    $0x0,%edx
    1410:	f7 f1                	div    %ecx
    1412:	89 d1                	mov    %edx,%ecx
    1414:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1417:	8d 50 01             	lea    0x1(%eax),%edx
    141a:	89 55 f4             	mov    %edx,-0xc(%ebp)
    141d:	0f b6 91 bc 1a 00 00 	movzbl 0x1abc(%ecx),%edx
    1424:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1428:	8b 4d 10             	mov    0x10(%ebp),%ecx
    142b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    142e:	ba 00 00 00 00       	mov    $0x0,%edx
    1433:	f7 f1                	div    %ecx
    1435:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1438:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    143c:	75 c7                	jne    1405 <printint+0x3b>
  if(neg)
    143e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1442:	74 2d                	je     1471 <printint+0xa7>
    buf[i++] = '-';
    1444:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1447:	8d 50 01             	lea    0x1(%eax),%edx
    144a:	89 55 f4             	mov    %edx,-0xc(%ebp)
    144d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1452:	eb 1d                	jmp    1471 <printint+0xa7>
    putc(fd, buf[i]);
    1454:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1457:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145a:	01 d0                	add    %edx,%eax
    145c:	0f b6 00             	movzbl (%eax),%eax
    145f:	0f be c0             	movsbl %al,%eax
    1462:	83 ec 08             	sub    $0x8,%esp
    1465:	50                   	push   %eax
    1466:	ff 75 08             	pushl  0x8(%ebp)
    1469:	e8 35 ff ff ff       	call   13a3 <putc>
    146e:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    1471:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1475:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1479:	79 d9                	jns    1454 <printint+0x8a>
}
    147b:	90                   	nop
    147c:	90                   	nop
    147d:	c9                   	leave  
    147e:	c3                   	ret    

0000147f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    147f:	f3 0f 1e fb          	endbr32 
    1483:	55                   	push   %ebp
    1484:	89 e5                	mov    %esp,%ebp
    1486:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1489:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1490:	8d 45 0c             	lea    0xc(%ebp),%eax
    1493:	83 c0 04             	add    $0x4,%eax
    1496:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1499:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14a0:	e9 59 01 00 00       	jmp    15fe <printf+0x17f>
    c = fmt[i] & 0xff;
    14a5:	8b 55 0c             	mov    0xc(%ebp),%edx
    14a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ab:	01 d0                	add    %edx,%eax
    14ad:	0f b6 00             	movzbl (%eax),%eax
    14b0:	0f be c0             	movsbl %al,%eax
    14b3:	25 ff 00 00 00       	and    $0xff,%eax
    14b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14bb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14bf:	75 2c                	jne    14ed <printf+0x6e>
      if(c == '%'){
    14c1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14c5:	75 0c                	jne    14d3 <printf+0x54>
        state = '%';
    14c7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14ce:	e9 27 01 00 00       	jmp    15fa <printf+0x17b>
      } else {
        putc(fd, c);
    14d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14d6:	0f be c0             	movsbl %al,%eax
    14d9:	83 ec 08             	sub    $0x8,%esp
    14dc:	50                   	push   %eax
    14dd:	ff 75 08             	pushl  0x8(%ebp)
    14e0:	e8 be fe ff ff       	call   13a3 <putc>
    14e5:	83 c4 10             	add    $0x10,%esp
    14e8:	e9 0d 01 00 00       	jmp    15fa <printf+0x17b>
      }
    } else if(state == '%'){
    14ed:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14f1:	0f 85 03 01 00 00    	jne    15fa <printf+0x17b>
      if(c == 'd'){
    14f7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14fb:	75 1e                	jne    151b <printf+0x9c>
        printint(fd, *ap, 10, 1);
    14fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1500:	8b 00                	mov    (%eax),%eax
    1502:	6a 01                	push   $0x1
    1504:	6a 0a                	push   $0xa
    1506:	50                   	push   %eax
    1507:	ff 75 08             	pushl  0x8(%ebp)
    150a:	e8 bb fe ff ff       	call   13ca <printint>
    150f:	83 c4 10             	add    $0x10,%esp
        ap++;
    1512:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1516:	e9 d8 00 00 00       	jmp    15f3 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    151b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    151f:	74 06                	je     1527 <printf+0xa8>
    1521:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1525:	75 1e                	jne    1545 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1527:	8b 45 e8             	mov    -0x18(%ebp),%eax
    152a:	8b 00                	mov    (%eax),%eax
    152c:	6a 00                	push   $0x0
    152e:	6a 10                	push   $0x10
    1530:	50                   	push   %eax
    1531:	ff 75 08             	pushl  0x8(%ebp)
    1534:	e8 91 fe ff ff       	call   13ca <printint>
    1539:	83 c4 10             	add    $0x10,%esp
        ap++;
    153c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1540:	e9 ae 00 00 00       	jmp    15f3 <printf+0x174>
      } else if(c == 's'){
    1545:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1549:	75 43                	jne    158e <printf+0x10f>
        s = (char*)*ap;
    154b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    154e:	8b 00                	mov    (%eax),%eax
    1550:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1553:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1557:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    155b:	75 25                	jne    1582 <printf+0x103>
          s = "(null)";
    155d:	c7 45 f4 6d 18 00 00 	movl   $0x186d,-0xc(%ebp)
        while(*s != 0){
    1564:	eb 1c                	jmp    1582 <printf+0x103>
          putc(fd, *s);
    1566:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1569:	0f b6 00             	movzbl (%eax),%eax
    156c:	0f be c0             	movsbl %al,%eax
    156f:	83 ec 08             	sub    $0x8,%esp
    1572:	50                   	push   %eax
    1573:	ff 75 08             	pushl  0x8(%ebp)
    1576:	e8 28 fe ff ff       	call   13a3 <putc>
    157b:	83 c4 10             	add    $0x10,%esp
          s++;
    157e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1582:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1585:	0f b6 00             	movzbl (%eax),%eax
    1588:	84 c0                	test   %al,%al
    158a:	75 da                	jne    1566 <printf+0xe7>
    158c:	eb 65                	jmp    15f3 <printf+0x174>
        }
      } else if(c == 'c'){
    158e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1592:	75 1d                	jne    15b1 <printf+0x132>
        putc(fd, *ap);
    1594:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1597:	8b 00                	mov    (%eax),%eax
    1599:	0f be c0             	movsbl %al,%eax
    159c:	83 ec 08             	sub    $0x8,%esp
    159f:	50                   	push   %eax
    15a0:	ff 75 08             	pushl  0x8(%ebp)
    15a3:	e8 fb fd ff ff       	call   13a3 <putc>
    15a8:	83 c4 10             	add    $0x10,%esp
        ap++;
    15ab:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15af:	eb 42                	jmp    15f3 <printf+0x174>
      } else if(c == '%'){
    15b1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15b5:	75 17                	jne    15ce <printf+0x14f>
        putc(fd, c);
    15b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ba:	0f be c0             	movsbl %al,%eax
    15bd:	83 ec 08             	sub    $0x8,%esp
    15c0:	50                   	push   %eax
    15c1:	ff 75 08             	pushl  0x8(%ebp)
    15c4:	e8 da fd ff ff       	call   13a3 <putc>
    15c9:	83 c4 10             	add    $0x10,%esp
    15cc:	eb 25                	jmp    15f3 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15ce:	83 ec 08             	sub    $0x8,%esp
    15d1:	6a 25                	push   $0x25
    15d3:	ff 75 08             	pushl  0x8(%ebp)
    15d6:	e8 c8 fd ff ff       	call   13a3 <putc>
    15db:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15e1:	0f be c0             	movsbl %al,%eax
    15e4:	83 ec 08             	sub    $0x8,%esp
    15e7:	50                   	push   %eax
    15e8:	ff 75 08             	pushl  0x8(%ebp)
    15eb:	e8 b3 fd ff ff       	call   13a3 <putc>
    15f0:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15f3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    15fa:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15fe:	8b 55 0c             	mov    0xc(%ebp),%edx
    1601:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1604:	01 d0                	add    %edx,%eax
    1606:	0f b6 00             	movzbl (%eax),%eax
    1609:	84 c0                	test   %al,%al
    160b:	0f 85 94 fe ff ff    	jne    14a5 <printf+0x26>
    }
  }
}
    1611:	90                   	nop
    1612:	90                   	nop
    1613:	c9                   	leave  
    1614:	c3                   	ret    

00001615 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1615:	f3 0f 1e fb          	endbr32 
    1619:	55                   	push   %ebp
    161a:	89 e5                	mov    %esp,%ebp
    161c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    161f:	8b 45 08             	mov    0x8(%ebp),%eax
    1622:	83 e8 08             	sub    $0x8,%eax
    1625:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1628:	a1 d8 1a 00 00       	mov    0x1ad8,%eax
    162d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1630:	eb 24                	jmp    1656 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1632:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1635:	8b 00                	mov    (%eax),%eax
    1637:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    163a:	72 12                	jb     164e <free+0x39>
    163c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    163f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1642:	77 24                	ja     1668 <free+0x53>
    1644:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1647:	8b 00                	mov    (%eax),%eax
    1649:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    164c:	72 1a                	jb     1668 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    164e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1651:	8b 00                	mov    (%eax),%eax
    1653:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1656:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1659:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    165c:	76 d4                	jbe    1632 <free+0x1d>
    165e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1661:	8b 00                	mov    (%eax),%eax
    1663:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1666:	73 ca                	jae    1632 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1668:	8b 45 f8             	mov    -0x8(%ebp),%eax
    166b:	8b 40 04             	mov    0x4(%eax),%eax
    166e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1675:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1678:	01 c2                	add    %eax,%edx
    167a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167d:	8b 00                	mov    (%eax),%eax
    167f:	39 c2                	cmp    %eax,%edx
    1681:	75 24                	jne    16a7 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1683:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1686:	8b 50 04             	mov    0x4(%eax),%edx
    1689:	8b 45 fc             	mov    -0x4(%ebp),%eax
    168c:	8b 00                	mov    (%eax),%eax
    168e:	8b 40 04             	mov    0x4(%eax),%eax
    1691:	01 c2                	add    %eax,%edx
    1693:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1696:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1699:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169c:	8b 00                	mov    (%eax),%eax
    169e:	8b 10                	mov    (%eax),%edx
    16a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a3:	89 10                	mov    %edx,(%eax)
    16a5:	eb 0a                	jmp    16b1 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    16a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16aa:	8b 10                	mov    (%eax),%edx
    16ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16af:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b4:	8b 40 04             	mov    0x4(%eax),%eax
    16b7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16be:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c1:	01 d0                	add    %edx,%eax
    16c3:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16c6:	75 20                	jne    16e8 <free+0xd3>
    p->s.size += bp->s.size;
    16c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cb:	8b 50 04             	mov    0x4(%eax),%edx
    16ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d1:	8b 40 04             	mov    0x4(%eax),%eax
    16d4:	01 c2                	add    %eax,%edx
    16d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16df:	8b 10                	mov    (%eax),%edx
    16e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e4:	89 10                	mov    %edx,(%eax)
    16e6:	eb 08                	jmp    16f0 <free+0xdb>
  } else
    p->s.ptr = bp;
    16e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16eb:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16ee:	89 10                	mov    %edx,(%eax)
  freep = p;
    16f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f3:	a3 d8 1a 00 00       	mov    %eax,0x1ad8
}
    16f8:	90                   	nop
    16f9:	c9                   	leave  
    16fa:	c3                   	ret    

000016fb <morecore>:

static Header*
morecore(uint nu)
{
    16fb:	f3 0f 1e fb          	endbr32 
    16ff:	55                   	push   %ebp
    1700:	89 e5                	mov    %esp,%ebp
    1702:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1705:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    170c:	77 07                	ja     1715 <morecore+0x1a>
    nu = 4096;
    170e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1715:	8b 45 08             	mov    0x8(%ebp),%eax
    1718:	c1 e0 03             	shl    $0x3,%eax
    171b:	83 ec 0c             	sub    $0xc,%esp
    171e:	50                   	push   %eax
    171f:	e8 57 fc ff ff       	call   137b <sbrk>
    1724:	83 c4 10             	add    $0x10,%esp
    1727:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    172a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    172e:	75 07                	jne    1737 <morecore+0x3c>
    return 0;
    1730:	b8 00 00 00 00       	mov    $0x0,%eax
    1735:	eb 26                	jmp    175d <morecore+0x62>
  hp = (Header*)p;
    1737:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    173d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1740:	8b 55 08             	mov    0x8(%ebp),%edx
    1743:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1746:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1749:	83 c0 08             	add    $0x8,%eax
    174c:	83 ec 0c             	sub    $0xc,%esp
    174f:	50                   	push   %eax
    1750:	e8 c0 fe ff ff       	call   1615 <free>
    1755:	83 c4 10             	add    $0x10,%esp
  return freep;
    1758:	a1 d8 1a 00 00       	mov    0x1ad8,%eax
}
    175d:	c9                   	leave  
    175e:	c3                   	ret    

0000175f <malloc>:

void*
malloc(uint nbytes)
{
    175f:	f3 0f 1e fb          	endbr32 
    1763:	55                   	push   %ebp
    1764:	89 e5                	mov    %esp,%ebp
    1766:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1769:	8b 45 08             	mov    0x8(%ebp),%eax
    176c:	83 c0 07             	add    $0x7,%eax
    176f:	c1 e8 03             	shr    $0x3,%eax
    1772:	83 c0 01             	add    $0x1,%eax
    1775:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1778:	a1 d8 1a 00 00       	mov    0x1ad8,%eax
    177d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1780:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1784:	75 23                	jne    17a9 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1786:	c7 45 f0 d0 1a 00 00 	movl   $0x1ad0,-0x10(%ebp)
    178d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1790:	a3 d8 1a 00 00       	mov    %eax,0x1ad8
    1795:	a1 d8 1a 00 00       	mov    0x1ad8,%eax
    179a:	a3 d0 1a 00 00       	mov    %eax,0x1ad0
    base.s.size = 0;
    179f:	c7 05 d4 1a 00 00 00 	movl   $0x0,0x1ad4
    17a6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ac:	8b 00                	mov    (%eax),%eax
    17ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b4:	8b 40 04             	mov    0x4(%eax),%eax
    17b7:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17ba:	77 4d                	ja     1809 <malloc+0xaa>
      if(p->s.size == nunits)
    17bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bf:	8b 40 04             	mov    0x4(%eax),%eax
    17c2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17c5:	75 0c                	jne    17d3 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    17c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ca:	8b 10                	mov    (%eax),%edx
    17cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17cf:	89 10                	mov    %edx,(%eax)
    17d1:	eb 26                	jmp    17f9 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    17d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d6:	8b 40 04             	mov    0x4(%eax),%eax
    17d9:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17dc:	89 c2                	mov    %eax,%edx
    17de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e7:	8b 40 04             	mov    0x4(%eax),%eax
    17ea:	c1 e0 03             	shl    $0x3,%eax
    17ed:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f3:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17f6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17fc:	a3 d8 1a 00 00       	mov    %eax,0x1ad8
      return (void*)(p + 1);
    1801:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1804:	83 c0 08             	add    $0x8,%eax
    1807:	eb 3b                	jmp    1844 <malloc+0xe5>
    }
    if(p == freep)
    1809:	a1 d8 1a 00 00       	mov    0x1ad8,%eax
    180e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1811:	75 1e                	jne    1831 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1813:	83 ec 0c             	sub    $0xc,%esp
    1816:	ff 75 ec             	pushl  -0x14(%ebp)
    1819:	e8 dd fe ff ff       	call   16fb <morecore>
    181e:	83 c4 10             	add    $0x10,%esp
    1821:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1824:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1828:	75 07                	jne    1831 <malloc+0xd2>
        return 0;
    182a:	b8 00 00 00 00       	mov    $0x0,%eax
    182f:	eb 13                	jmp    1844 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1831:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1834:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1837:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183a:	8b 00                	mov    (%eax),%eax
    183c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    183f:	e9 6d ff ff ff       	jmp    17b1 <malloc+0x52>
  }
}
    1844:	c9                   	leave  
    1845:	c3                   	ret    
