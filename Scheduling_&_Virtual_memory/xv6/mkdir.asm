
_mkdir:     file format elf32-i386


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
  int i;

  if(argc < 2){
    1018:	83 3b 01             	cmpl   $0x1,(%ebx)
    101b:	7f 17                	jg     1034 <main+0x34>
    printf(2, "Usage: mkdir files...\n");
    101d:	83 ec 08             	sub    $0x8,%esp
    1020:	68 62 18 00 00       	push   $0x1862
    1025:	6a 02                	push   $0x2
    1027:	e8 6f 04 00 00       	call   149b <printf>
    102c:	83 c4 10             	add    $0x10,%esp
    exit();
    102f:	e8 db 02 00 00       	call   130f <exit>
  }

  for(i = 1; i < argc; i++){
    1034:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    103b:	eb 4b                	jmp    1088 <main+0x88>
    if(mkdir(argv[i]) < 0){
    103d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1040:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1047:	8b 43 04             	mov    0x4(%ebx),%eax
    104a:	01 d0                	add    %edx,%eax
    104c:	8b 00                	mov    (%eax),%eax
    104e:	83 ec 0c             	sub    $0xc,%esp
    1051:	50                   	push   %eax
    1052:	e8 20 03 00 00       	call   1377 <mkdir>
    1057:	83 c4 10             	add    $0x10,%esp
    105a:	85 c0                	test   %eax,%eax
    105c:	79 26                	jns    1084 <main+0x84>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
    105e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1061:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1068:	8b 43 04             	mov    0x4(%ebx),%eax
    106b:	01 d0                	add    %edx,%eax
    106d:	8b 00                	mov    (%eax),%eax
    106f:	83 ec 04             	sub    $0x4,%esp
    1072:	50                   	push   %eax
    1073:	68 79 18 00 00       	push   $0x1879
    1078:	6a 02                	push   $0x2
    107a:	e8 1c 04 00 00       	call   149b <printf>
    107f:	83 c4 10             	add    $0x10,%esp
      break;
    1082:	eb 0b                	jmp    108f <main+0x8f>
  for(i = 1; i < argc; i++){
    1084:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1088:	8b 45 f4             	mov    -0xc(%ebp),%eax
    108b:	3b 03                	cmp    (%ebx),%eax
    108d:	7c ae                	jl     103d <main+0x3d>
    }
  }

  exit();
    108f:	e8 7b 02 00 00       	call   130f <exit>

00001094 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1094:	55                   	push   %ebp
    1095:	89 e5                	mov    %esp,%ebp
    1097:	57                   	push   %edi
    1098:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1099:	8b 4d 08             	mov    0x8(%ebp),%ecx
    109c:	8b 55 10             	mov    0x10(%ebp),%edx
    109f:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a2:	89 cb                	mov    %ecx,%ebx
    10a4:	89 df                	mov    %ebx,%edi
    10a6:	89 d1                	mov    %edx,%ecx
    10a8:	fc                   	cld    
    10a9:	f3 aa                	rep stos %al,%es:(%edi)
    10ab:	89 ca                	mov    %ecx,%edx
    10ad:	89 fb                	mov    %edi,%ebx
    10af:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10b2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10b5:	90                   	nop
    10b6:	5b                   	pop    %ebx
    10b7:	5f                   	pop    %edi
    10b8:	5d                   	pop    %ebp
    10b9:	c3                   	ret    

000010ba <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    10ba:	f3 0f 1e fb          	endbr32 
    10be:	55                   	push   %ebp
    10bf:	89 e5                	mov    %esp,%ebp
    10c1:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10c4:	8b 45 08             	mov    0x8(%ebp),%eax
    10c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10ca:	90                   	nop
    10cb:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ce:	8d 42 01             	lea    0x1(%edx),%eax
    10d1:	89 45 0c             	mov    %eax,0xc(%ebp)
    10d4:	8b 45 08             	mov    0x8(%ebp),%eax
    10d7:	8d 48 01             	lea    0x1(%eax),%ecx
    10da:	89 4d 08             	mov    %ecx,0x8(%ebp)
    10dd:	0f b6 12             	movzbl (%edx),%edx
    10e0:	88 10                	mov    %dl,(%eax)
    10e2:	0f b6 00             	movzbl (%eax),%eax
    10e5:	84 c0                	test   %al,%al
    10e7:	75 e2                	jne    10cb <strcpy+0x11>
    ;
  return os;
    10e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10ec:	c9                   	leave  
    10ed:	c3                   	ret    

000010ee <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10ee:	f3 0f 1e fb          	endbr32 
    10f2:	55                   	push   %ebp
    10f3:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10f5:	eb 08                	jmp    10ff <strcmp+0x11>
    p++, q++;
    10f7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10fb:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    10ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1102:	0f b6 00             	movzbl (%eax),%eax
    1105:	84 c0                	test   %al,%al
    1107:	74 10                	je     1119 <strcmp+0x2b>
    1109:	8b 45 08             	mov    0x8(%ebp),%eax
    110c:	0f b6 10             	movzbl (%eax),%edx
    110f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1112:	0f b6 00             	movzbl (%eax),%eax
    1115:	38 c2                	cmp    %al,%dl
    1117:	74 de                	je     10f7 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    1119:	8b 45 08             	mov    0x8(%ebp),%eax
    111c:	0f b6 00             	movzbl (%eax),%eax
    111f:	0f b6 d0             	movzbl %al,%edx
    1122:	8b 45 0c             	mov    0xc(%ebp),%eax
    1125:	0f b6 00             	movzbl (%eax),%eax
    1128:	0f b6 c0             	movzbl %al,%eax
    112b:	29 c2                	sub    %eax,%edx
    112d:	89 d0                	mov    %edx,%eax
}
    112f:	5d                   	pop    %ebp
    1130:	c3                   	ret    

00001131 <strlen>:

uint
strlen(const char *s)
{
    1131:	f3 0f 1e fb          	endbr32 
    1135:	55                   	push   %ebp
    1136:	89 e5                	mov    %esp,%ebp
    1138:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    113b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1142:	eb 04                	jmp    1148 <strlen+0x17>
    1144:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1148:	8b 55 fc             	mov    -0x4(%ebp),%edx
    114b:	8b 45 08             	mov    0x8(%ebp),%eax
    114e:	01 d0                	add    %edx,%eax
    1150:	0f b6 00             	movzbl (%eax),%eax
    1153:	84 c0                	test   %al,%al
    1155:	75 ed                	jne    1144 <strlen+0x13>
    ;
  return n;
    1157:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    115a:	c9                   	leave  
    115b:	c3                   	ret    

0000115c <memset>:

void*
memset(void *dst, int c, uint n)
{
    115c:	f3 0f 1e fb          	endbr32 
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1163:	8b 45 10             	mov    0x10(%ebp),%eax
    1166:	50                   	push   %eax
    1167:	ff 75 0c             	pushl  0xc(%ebp)
    116a:	ff 75 08             	pushl  0x8(%ebp)
    116d:	e8 22 ff ff ff       	call   1094 <stosb>
    1172:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1175:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1178:	c9                   	leave  
    1179:	c3                   	ret    

0000117a <strchr>:

char*
strchr(const char *s, char c)
{
    117a:	f3 0f 1e fb          	endbr32 
    117e:	55                   	push   %ebp
    117f:	89 e5                	mov    %esp,%ebp
    1181:	83 ec 04             	sub    $0x4,%esp
    1184:	8b 45 0c             	mov    0xc(%ebp),%eax
    1187:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    118a:	eb 14                	jmp    11a0 <strchr+0x26>
    if(*s == c)
    118c:	8b 45 08             	mov    0x8(%ebp),%eax
    118f:	0f b6 00             	movzbl (%eax),%eax
    1192:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1195:	75 05                	jne    119c <strchr+0x22>
      return (char*)s;
    1197:	8b 45 08             	mov    0x8(%ebp),%eax
    119a:	eb 13                	jmp    11af <strchr+0x35>
  for(; *s; s++)
    119c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11a0:	8b 45 08             	mov    0x8(%ebp),%eax
    11a3:	0f b6 00             	movzbl (%eax),%eax
    11a6:	84 c0                	test   %al,%al
    11a8:	75 e2                	jne    118c <strchr+0x12>
  return 0;
    11aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11af:	c9                   	leave  
    11b0:	c3                   	ret    

000011b1 <gets>:

char*
gets(char *buf, int max)
{
    11b1:	f3 0f 1e fb          	endbr32 
    11b5:	55                   	push   %ebp
    11b6:	89 e5                	mov    %esp,%ebp
    11b8:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11c2:	eb 42                	jmp    1206 <gets+0x55>
    cc = read(0, &c, 1);
    11c4:	83 ec 04             	sub    $0x4,%esp
    11c7:	6a 01                	push   $0x1
    11c9:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11cc:	50                   	push   %eax
    11cd:	6a 00                	push   $0x0
    11cf:	e8 53 01 00 00       	call   1327 <read>
    11d4:	83 c4 10             	add    $0x10,%esp
    11d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11da:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11de:	7e 33                	jle    1213 <gets+0x62>
      break;
    buf[i++] = c;
    11e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11e3:	8d 50 01             	lea    0x1(%eax),%edx
    11e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11e9:	89 c2                	mov    %eax,%edx
    11eb:	8b 45 08             	mov    0x8(%ebp),%eax
    11ee:	01 c2                	add    %eax,%edx
    11f0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11f4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11f6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11fa:	3c 0a                	cmp    $0xa,%al
    11fc:	74 16                	je     1214 <gets+0x63>
    11fe:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1202:	3c 0d                	cmp    $0xd,%al
    1204:	74 0e                	je     1214 <gets+0x63>
  for(i=0; i+1 < max; ){
    1206:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1209:	83 c0 01             	add    $0x1,%eax
    120c:	39 45 0c             	cmp    %eax,0xc(%ebp)
    120f:	7f b3                	jg     11c4 <gets+0x13>
    1211:	eb 01                	jmp    1214 <gets+0x63>
      break;
    1213:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1214:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1217:	8b 45 08             	mov    0x8(%ebp),%eax
    121a:	01 d0                	add    %edx,%eax
    121c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    121f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1222:	c9                   	leave  
    1223:	c3                   	ret    

00001224 <stat>:

int
stat(const char *n, struct stat *st)
{
    1224:	f3 0f 1e fb          	endbr32 
    1228:	55                   	push   %ebp
    1229:	89 e5                	mov    %esp,%ebp
    122b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    122e:	83 ec 08             	sub    $0x8,%esp
    1231:	6a 00                	push   $0x0
    1233:	ff 75 08             	pushl  0x8(%ebp)
    1236:	e8 14 01 00 00       	call   134f <open>
    123b:	83 c4 10             	add    $0x10,%esp
    123e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1241:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1245:	79 07                	jns    124e <stat+0x2a>
    return -1;
    1247:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    124c:	eb 25                	jmp    1273 <stat+0x4f>
  r = fstat(fd, st);
    124e:	83 ec 08             	sub    $0x8,%esp
    1251:	ff 75 0c             	pushl  0xc(%ebp)
    1254:	ff 75 f4             	pushl  -0xc(%ebp)
    1257:	e8 0b 01 00 00       	call   1367 <fstat>
    125c:	83 c4 10             	add    $0x10,%esp
    125f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1262:	83 ec 0c             	sub    $0xc,%esp
    1265:	ff 75 f4             	pushl  -0xc(%ebp)
    1268:	e8 ca 00 00 00       	call   1337 <close>
    126d:	83 c4 10             	add    $0x10,%esp
  return r;
    1270:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1273:	c9                   	leave  
    1274:	c3                   	ret    

00001275 <atoi>:

int
atoi(const char *s)
{
    1275:	f3 0f 1e fb          	endbr32 
    1279:	55                   	push   %ebp
    127a:	89 e5                	mov    %esp,%ebp
    127c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    127f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1286:	eb 25                	jmp    12ad <atoi+0x38>
    n = n*10 + *s++ - '0';
    1288:	8b 55 fc             	mov    -0x4(%ebp),%edx
    128b:	89 d0                	mov    %edx,%eax
    128d:	c1 e0 02             	shl    $0x2,%eax
    1290:	01 d0                	add    %edx,%eax
    1292:	01 c0                	add    %eax,%eax
    1294:	89 c1                	mov    %eax,%ecx
    1296:	8b 45 08             	mov    0x8(%ebp),%eax
    1299:	8d 50 01             	lea    0x1(%eax),%edx
    129c:	89 55 08             	mov    %edx,0x8(%ebp)
    129f:	0f b6 00             	movzbl (%eax),%eax
    12a2:	0f be c0             	movsbl %al,%eax
    12a5:	01 c8                	add    %ecx,%eax
    12a7:	83 e8 30             	sub    $0x30,%eax
    12aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12ad:	8b 45 08             	mov    0x8(%ebp),%eax
    12b0:	0f b6 00             	movzbl (%eax),%eax
    12b3:	3c 2f                	cmp    $0x2f,%al
    12b5:	7e 0a                	jle    12c1 <atoi+0x4c>
    12b7:	8b 45 08             	mov    0x8(%ebp),%eax
    12ba:	0f b6 00             	movzbl (%eax),%eax
    12bd:	3c 39                	cmp    $0x39,%al
    12bf:	7e c7                	jle    1288 <atoi+0x13>
  return n;
    12c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12c4:	c9                   	leave  
    12c5:	c3                   	ret    

000012c6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12c6:	f3 0f 1e fb          	endbr32 
    12ca:	55                   	push   %ebp
    12cb:	89 e5                	mov    %esp,%ebp
    12cd:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    12d0:	8b 45 08             	mov    0x8(%ebp),%eax
    12d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12dc:	eb 17                	jmp    12f5 <memmove+0x2f>
    *dst++ = *src++;
    12de:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12e1:	8d 42 01             	lea    0x1(%edx),%eax
    12e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ea:	8d 48 01             	lea    0x1(%eax),%ecx
    12ed:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    12f0:	0f b6 12             	movzbl (%edx),%edx
    12f3:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    12f5:	8b 45 10             	mov    0x10(%ebp),%eax
    12f8:	8d 50 ff             	lea    -0x1(%eax),%edx
    12fb:	89 55 10             	mov    %edx,0x10(%ebp)
    12fe:	85 c0                	test   %eax,%eax
    1300:	7f dc                	jg     12de <memmove+0x18>
  return vdst;
    1302:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1305:	c9                   	leave  
    1306:	c3                   	ret    

00001307 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1307:	b8 01 00 00 00       	mov    $0x1,%eax
    130c:	cd 40                	int    $0x40
    130e:	c3                   	ret    

0000130f <exit>:
SYSCALL(exit)
    130f:	b8 02 00 00 00       	mov    $0x2,%eax
    1314:	cd 40                	int    $0x40
    1316:	c3                   	ret    

00001317 <wait>:
SYSCALL(wait)
    1317:	b8 03 00 00 00       	mov    $0x3,%eax
    131c:	cd 40                	int    $0x40
    131e:	c3                   	ret    

0000131f <pipe>:
SYSCALL(pipe)
    131f:	b8 04 00 00 00       	mov    $0x4,%eax
    1324:	cd 40                	int    $0x40
    1326:	c3                   	ret    

00001327 <read>:
SYSCALL(read)
    1327:	b8 05 00 00 00       	mov    $0x5,%eax
    132c:	cd 40                	int    $0x40
    132e:	c3                   	ret    

0000132f <write>:
SYSCALL(write)
    132f:	b8 10 00 00 00       	mov    $0x10,%eax
    1334:	cd 40                	int    $0x40
    1336:	c3                   	ret    

00001337 <close>:
SYSCALL(close)
    1337:	b8 15 00 00 00       	mov    $0x15,%eax
    133c:	cd 40                	int    $0x40
    133e:	c3                   	ret    

0000133f <kill>:
SYSCALL(kill)
    133f:	b8 06 00 00 00       	mov    $0x6,%eax
    1344:	cd 40                	int    $0x40
    1346:	c3                   	ret    

00001347 <exec>:
SYSCALL(exec)
    1347:	b8 07 00 00 00       	mov    $0x7,%eax
    134c:	cd 40                	int    $0x40
    134e:	c3                   	ret    

0000134f <open>:
SYSCALL(open)
    134f:	b8 0f 00 00 00       	mov    $0xf,%eax
    1354:	cd 40                	int    $0x40
    1356:	c3                   	ret    

00001357 <mknod>:
SYSCALL(mknod)
    1357:	b8 11 00 00 00       	mov    $0x11,%eax
    135c:	cd 40                	int    $0x40
    135e:	c3                   	ret    

0000135f <unlink>:
SYSCALL(unlink)
    135f:	b8 12 00 00 00       	mov    $0x12,%eax
    1364:	cd 40                	int    $0x40
    1366:	c3                   	ret    

00001367 <fstat>:
SYSCALL(fstat)
    1367:	b8 08 00 00 00       	mov    $0x8,%eax
    136c:	cd 40                	int    $0x40
    136e:	c3                   	ret    

0000136f <link>:
SYSCALL(link)
    136f:	b8 13 00 00 00       	mov    $0x13,%eax
    1374:	cd 40                	int    $0x40
    1376:	c3                   	ret    

00001377 <mkdir>:
SYSCALL(mkdir)
    1377:	b8 14 00 00 00       	mov    $0x14,%eax
    137c:	cd 40                	int    $0x40
    137e:	c3                   	ret    

0000137f <chdir>:
SYSCALL(chdir)
    137f:	b8 09 00 00 00       	mov    $0x9,%eax
    1384:	cd 40                	int    $0x40
    1386:	c3                   	ret    

00001387 <dup>:
SYSCALL(dup)
    1387:	b8 0a 00 00 00       	mov    $0xa,%eax
    138c:	cd 40                	int    $0x40
    138e:	c3                   	ret    

0000138f <getpid>:
SYSCALL(getpid)
    138f:	b8 0b 00 00 00       	mov    $0xb,%eax
    1394:	cd 40                	int    $0x40
    1396:	c3                   	ret    

00001397 <sbrk>:
SYSCALL(sbrk)
    1397:	b8 0c 00 00 00       	mov    $0xc,%eax
    139c:	cd 40                	int    $0x40
    139e:	c3                   	ret    

0000139f <sleep>:
SYSCALL(sleep)
    139f:	b8 0d 00 00 00       	mov    $0xd,%eax
    13a4:	cd 40                	int    $0x40
    13a6:	c3                   	ret    

000013a7 <uptime>:
SYSCALL(uptime)
    13a7:	b8 0e 00 00 00       	mov    $0xe,%eax
    13ac:	cd 40                	int    $0x40
    13ae:	c3                   	ret    

000013af <settickets>:
SYSCALL(settickets)
    13af:	b8 16 00 00 00       	mov    $0x16,%eax
    13b4:	cd 40                	int    $0x40
    13b6:	c3                   	ret    

000013b7 <getpinfo>:
SYSCALL(getpinfo)
    13b7:	b8 17 00 00 00       	mov    $0x17,%eax
    13bc:	cd 40                	int    $0x40
    13be:	c3                   	ret    

000013bf <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13bf:	f3 0f 1e fb          	endbr32 
    13c3:	55                   	push   %ebp
    13c4:	89 e5                	mov    %esp,%ebp
    13c6:	83 ec 18             	sub    $0x18,%esp
    13c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cc:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13cf:	83 ec 04             	sub    $0x4,%esp
    13d2:	6a 01                	push   $0x1
    13d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13d7:	50                   	push   %eax
    13d8:	ff 75 08             	pushl  0x8(%ebp)
    13db:	e8 4f ff ff ff       	call   132f <write>
    13e0:	83 c4 10             	add    $0x10,%esp
}
    13e3:	90                   	nop
    13e4:	c9                   	leave  
    13e5:	c3                   	ret    

000013e6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13e6:	f3 0f 1e fb          	endbr32 
    13ea:	55                   	push   %ebp
    13eb:	89 e5                	mov    %esp,%ebp
    13ed:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13f0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13f7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13fb:	74 17                	je     1414 <printint+0x2e>
    13fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1401:	79 11                	jns    1414 <printint+0x2e>
    neg = 1;
    1403:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    140a:	8b 45 0c             	mov    0xc(%ebp),%eax
    140d:	f7 d8                	neg    %eax
    140f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1412:	eb 06                	jmp    141a <printint+0x34>
  } else {
    x = xx;
    1414:	8b 45 0c             	mov    0xc(%ebp),%eax
    1417:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    141a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1421:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1424:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1427:	ba 00 00 00 00       	mov    $0x0,%edx
    142c:	f7 f1                	div    %ecx
    142e:	89 d1                	mov    %edx,%ecx
    1430:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1433:	8d 50 01             	lea    0x1(%eax),%edx
    1436:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1439:	0f b6 91 e4 1a 00 00 	movzbl 0x1ae4(%ecx),%edx
    1440:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1444:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1447:	8b 45 ec             	mov    -0x14(%ebp),%eax
    144a:	ba 00 00 00 00       	mov    $0x0,%edx
    144f:	f7 f1                	div    %ecx
    1451:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1454:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1458:	75 c7                	jne    1421 <printint+0x3b>
  if(neg)
    145a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    145e:	74 2d                	je     148d <printint+0xa7>
    buf[i++] = '-';
    1460:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1463:	8d 50 01             	lea    0x1(%eax),%edx
    1466:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1469:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    146e:	eb 1d                	jmp    148d <printint+0xa7>
    putc(fd, buf[i]);
    1470:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1473:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1476:	01 d0                	add    %edx,%eax
    1478:	0f b6 00             	movzbl (%eax),%eax
    147b:	0f be c0             	movsbl %al,%eax
    147e:	83 ec 08             	sub    $0x8,%esp
    1481:	50                   	push   %eax
    1482:	ff 75 08             	pushl  0x8(%ebp)
    1485:	e8 35 ff ff ff       	call   13bf <putc>
    148a:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    148d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1491:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1495:	79 d9                	jns    1470 <printint+0x8a>
}
    1497:	90                   	nop
    1498:	90                   	nop
    1499:	c9                   	leave  
    149a:	c3                   	ret    

0000149b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    149b:	f3 0f 1e fb          	endbr32 
    149f:	55                   	push   %ebp
    14a0:	89 e5                	mov    %esp,%ebp
    14a2:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14a5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14ac:	8d 45 0c             	lea    0xc(%ebp),%eax
    14af:	83 c0 04             	add    $0x4,%eax
    14b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    14b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14bc:	e9 59 01 00 00       	jmp    161a <printf+0x17f>
    c = fmt[i] & 0xff;
    14c1:	8b 55 0c             	mov    0xc(%ebp),%edx
    14c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14c7:	01 d0                	add    %edx,%eax
    14c9:	0f b6 00             	movzbl (%eax),%eax
    14cc:	0f be c0             	movsbl %al,%eax
    14cf:	25 ff 00 00 00       	and    $0xff,%eax
    14d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14db:	75 2c                	jne    1509 <printf+0x6e>
      if(c == '%'){
    14dd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14e1:	75 0c                	jne    14ef <printf+0x54>
        state = '%';
    14e3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14ea:	e9 27 01 00 00       	jmp    1616 <printf+0x17b>
      } else {
        putc(fd, c);
    14ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14f2:	0f be c0             	movsbl %al,%eax
    14f5:	83 ec 08             	sub    $0x8,%esp
    14f8:	50                   	push   %eax
    14f9:	ff 75 08             	pushl  0x8(%ebp)
    14fc:	e8 be fe ff ff       	call   13bf <putc>
    1501:	83 c4 10             	add    $0x10,%esp
    1504:	e9 0d 01 00 00       	jmp    1616 <printf+0x17b>
      }
    } else if(state == '%'){
    1509:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    150d:	0f 85 03 01 00 00    	jne    1616 <printf+0x17b>
      if(c == 'd'){
    1513:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1517:	75 1e                	jne    1537 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    1519:	8b 45 e8             	mov    -0x18(%ebp),%eax
    151c:	8b 00                	mov    (%eax),%eax
    151e:	6a 01                	push   $0x1
    1520:	6a 0a                	push   $0xa
    1522:	50                   	push   %eax
    1523:	ff 75 08             	pushl  0x8(%ebp)
    1526:	e8 bb fe ff ff       	call   13e6 <printint>
    152b:	83 c4 10             	add    $0x10,%esp
        ap++;
    152e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1532:	e9 d8 00 00 00       	jmp    160f <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    1537:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    153b:	74 06                	je     1543 <printf+0xa8>
    153d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1541:	75 1e                	jne    1561 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1543:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1546:	8b 00                	mov    (%eax),%eax
    1548:	6a 00                	push   $0x0
    154a:	6a 10                	push   $0x10
    154c:	50                   	push   %eax
    154d:	ff 75 08             	pushl  0x8(%ebp)
    1550:	e8 91 fe ff ff       	call   13e6 <printint>
    1555:	83 c4 10             	add    $0x10,%esp
        ap++;
    1558:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    155c:	e9 ae 00 00 00       	jmp    160f <printf+0x174>
      } else if(c == 's'){
    1561:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1565:	75 43                	jne    15aa <printf+0x10f>
        s = (char*)*ap;
    1567:	8b 45 e8             	mov    -0x18(%ebp),%eax
    156a:	8b 00                	mov    (%eax),%eax
    156c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    156f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1573:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1577:	75 25                	jne    159e <printf+0x103>
          s = "(null)";
    1579:	c7 45 f4 95 18 00 00 	movl   $0x1895,-0xc(%ebp)
        while(*s != 0){
    1580:	eb 1c                	jmp    159e <printf+0x103>
          putc(fd, *s);
    1582:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1585:	0f b6 00             	movzbl (%eax),%eax
    1588:	0f be c0             	movsbl %al,%eax
    158b:	83 ec 08             	sub    $0x8,%esp
    158e:	50                   	push   %eax
    158f:	ff 75 08             	pushl  0x8(%ebp)
    1592:	e8 28 fe ff ff       	call   13bf <putc>
    1597:	83 c4 10             	add    $0x10,%esp
          s++;
    159a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    159e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a1:	0f b6 00             	movzbl (%eax),%eax
    15a4:	84 c0                	test   %al,%al
    15a6:	75 da                	jne    1582 <printf+0xe7>
    15a8:	eb 65                	jmp    160f <printf+0x174>
        }
      } else if(c == 'c'){
    15aa:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15ae:	75 1d                	jne    15cd <printf+0x132>
        putc(fd, *ap);
    15b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15b3:	8b 00                	mov    (%eax),%eax
    15b5:	0f be c0             	movsbl %al,%eax
    15b8:	83 ec 08             	sub    $0x8,%esp
    15bb:	50                   	push   %eax
    15bc:	ff 75 08             	pushl  0x8(%ebp)
    15bf:	e8 fb fd ff ff       	call   13bf <putc>
    15c4:	83 c4 10             	add    $0x10,%esp
        ap++;
    15c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15cb:	eb 42                	jmp    160f <printf+0x174>
      } else if(c == '%'){
    15cd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15d1:	75 17                	jne    15ea <printf+0x14f>
        putc(fd, c);
    15d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15d6:	0f be c0             	movsbl %al,%eax
    15d9:	83 ec 08             	sub    $0x8,%esp
    15dc:	50                   	push   %eax
    15dd:	ff 75 08             	pushl  0x8(%ebp)
    15e0:	e8 da fd ff ff       	call   13bf <putc>
    15e5:	83 c4 10             	add    $0x10,%esp
    15e8:	eb 25                	jmp    160f <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15ea:	83 ec 08             	sub    $0x8,%esp
    15ed:	6a 25                	push   $0x25
    15ef:	ff 75 08             	pushl  0x8(%ebp)
    15f2:	e8 c8 fd ff ff       	call   13bf <putc>
    15f7:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15fd:	0f be c0             	movsbl %al,%eax
    1600:	83 ec 08             	sub    $0x8,%esp
    1603:	50                   	push   %eax
    1604:	ff 75 08             	pushl  0x8(%ebp)
    1607:	e8 b3 fd ff ff       	call   13bf <putc>
    160c:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    160f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    1616:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    161a:	8b 55 0c             	mov    0xc(%ebp),%edx
    161d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1620:	01 d0                	add    %edx,%eax
    1622:	0f b6 00             	movzbl (%eax),%eax
    1625:	84 c0                	test   %al,%al
    1627:	0f 85 94 fe ff ff    	jne    14c1 <printf+0x26>
    }
  }
}
    162d:	90                   	nop
    162e:	90                   	nop
    162f:	c9                   	leave  
    1630:	c3                   	ret    

00001631 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1631:	f3 0f 1e fb          	endbr32 
    1635:	55                   	push   %ebp
    1636:	89 e5                	mov    %esp,%ebp
    1638:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    163b:	8b 45 08             	mov    0x8(%ebp),%eax
    163e:	83 e8 08             	sub    $0x8,%eax
    1641:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1644:	a1 00 1b 00 00       	mov    0x1b00,%eax
    1649:	89 45 fc             	mov    %eax,-0x4(%ebp)
    164c:	eb 24                	jmp    1672 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    164e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1651:	8b 00                	mov    (%eax),%eax
    1653:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1656:	72 12                	jb     166a <free+0x39>
    1658:	8b 45 f8             	mov    -0x8(%ebp),%eax
    165b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    165e:	77 24                	ja     1684 <free+0x53>
    1660:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1663:	8b 00                	mov    (%eax),%eax
    1665:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1668:	72 1a                	jb     1684 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    166a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166d:	8b 00                	mov    (%eax),%eax
    166f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1672:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1675:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1678:	76 d4                	jbe    164e <free+0x1d>
    167a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167d:	8b 00                	mov    (%eax),%eax
    167f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1682:	73 ca                	jae    164e <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1684:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1687:	8b 40 04             	mov    0x4(%eax),%eax
    168a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1691:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1694:	01 c2                	add    %eax,%edx
    1696:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1699:	8b 00                	mov    (%eax),%eax
    169b:	39 c2                	cmp    %eax,%edx
    169d:	75 24                	jne    16c3 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    169f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a2:	8b 50 04             	mov    0x4(%eax),%edx
    16a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a8:	8b 00                	mov    (%eax),%eax
    16aa:	8b 40 04             	mov    0x4(%eax),%eax
    16ad:	01 c2                	add    %eax,%edx
    16af:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b2:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b8:	8b 00                	mov    (%eax),%eax
    16ba:	8b 10                	mov    (%eax),%edx
    16bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16bf:	89 10                	mov    %edx,(%eax)
    16c1:	eb 0a                	jmp    16cd <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    16c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c6:	8b 10                	mov    (%eax),%edx
    16c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16cb:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d0:	8b 40 04             	mov    0x4(%eax),%eax
    16d3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16da:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16dd:	01 d0                	add    %edx,%eax
    16df:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16e2:	75 20                	jne    1704 <free+0xd3>
    p->s.size += bp->s.size;
    16e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e7:	8b 50 04             	mov    0x4(%eax),%edx
    16ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ed:	8b 40 04             	mov    0x4(%eax),%eax
    16f0:	01 c2                	add    %eax,%edx
    16f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16fb:	8b 10                	mov    (%eax),%edx
    16fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1700:	89 10                	mov    %edx,(%eax)
    1702:	eb 08                	jmp    170c <free+0xdb>
  } else
    p->s.ptr = bp;
    1704:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1707:	8b 55 f8             	mov    -0x8(%ebp),%edx
    170a:	89 10                	mov    %edx,(%eax)
  freep = p;
    170c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170f:	a3 00 1b 00 00       	mov    %eax,0x1b00
}
    1714:	90                   	nop
    1715:	c9                   	leave  
    1716:	c3                   	ret    

00001717 <morecore>:

static Header*
morecore(uint nu)
{
    1717:	f3 0f 1e fb          	endbr32 
    171b:	55                   	push   %ebp
    171c:	89 e5                	mov    %esp,%ebp
    171e:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1721:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1728:	77 07                	ja     1731 <morecore+0x1a>
    nu = 4096;
    172a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1731:	8b 45 08             	mov    0x8(%ebp),%eax
    1734:	c1 e0 03             	shl    $0x3,%eax
    1737:	83 ec 0c             	sub    $0xc,%esp
    173a:	50                   	push   %eax
    173b:	e8 57 fc ff ff       	call   1397 <sbrk>
    1740:	83 c4 10             	add    $0x10,%esp
    1743:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1746:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    174a:	75 07                	jne    1753 <morecore+0x3c>
    return 0;
    174c:	b8 00 00 00 00       	mov    $0x0,%eax
    1751:	eb 26                	jmp    1779 <morecore+0x62>
  hp = (Header*)p;
    1753:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1756:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1759:	8b 45 f0             	mov    -0x10(%ebp),%eax
    175c:	8b 55 08             	mov    0x8(%ebp),%edx
    175f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1762:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1765:	83 c0 08             	add    $0x8,%eax
    1768:	83 ec 0c             	sub    $0xc,%esp
    176b:	50                   	push   %eax
    176c:	e8 c0 fe ff ff       	call   1631 <free>
    1771:	83 c4 10             	add    $0x10,%esp
  return freep;
    1774:	a1 00 1b 00 00       	mov    0x1b00,%eax
}
    1779:	c9                   	leave  
    177a:	c3                   	ret    

0000177b <malloc>:

void*
malloc(uint nbytes)
{
    177b:	f3 0f 1e fb          	endbr32 
    177f:	55                   	push   %ebp
    1780:	89 e5                	mov    %esp,%ebp
    1782:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1785:	8b 45 08             	mov    0x8(%ebp),%eax
    1788:	83 c0 07             	add    $0x7,%eax
    178b:	c1 e8 03             	shr    $0x3,%eax
    178e:	83 c0 01             	add    $0x1,%eax
    1791:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1794:	a1 00 1b 00 00       	mov    0x1b00,%eax
    1799:	89 45 f0             	mov    %eax,-0x10(%ebp)
    179c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17a0:	75 23                	jne    17c5 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    17a2:	c7 45 f0 f8 1a 00 00 	movl   $0x1af8,-0x10(%ebp)
    17a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ac:	a3 00 1b 00 00       	mov    %eax,0x1b00
    17b1:	a1 00 1b 00 00       	mov    0x1b00,%eax
    17b6:	a3 f8 1a 00 00       	mov    %eax,0x1af8
    base.s.size = 0;
    17bb:	c7 05 fc 1a 00 00 00 	movl   $0x0,0x1afc
    17c2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17c8:	8b 00                	mov    (%eax),%eax
    17ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d0:	8b 40 04             	mov    0x4(%eax),%eax
    17d3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17d6:	77 4d                	ja     1825 <malloc+0xaa>
      if(p->s.size == nunits)
    17d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17db:	8b 40 04             	mov    0x4(%eax),%eax
    17de:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17e1:	75 0c                	jne    17ef <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    17e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e6:	8b 10                	mov    (%eax),%edx
    17e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17eb:	89 10                	mov    %edx,(%eax)
    17ed:	eb 26                	jmp    1815 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    17ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f2:	8b 40 04             	mov    0x4(%eax),%eax
    17f5:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17f8:	89 c2                	mov    %eax,%edx
    17fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1800:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1803:	8b 40 04             	mov    0x4(%eax),%eax
    1806:	c1 e0 03             	shl    $0x3,%eax
    1809:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    180c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180f:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1812:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1815:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1818:	a3 00 1b 00 00       	mov    %eax,0x1b00
      return (void*)(p + 1);
    181d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1820:	83 c0 08             	add    $0x8,%eax
    1823:	eb 3b                	jmp    1860 <malloc+0xe5>
    }
    if(p == freep)
    1825:	a1 00 1b 00 00       	mov    0x1b00,%eax
    182a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    182d:	75 1e                	jne    184d <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    182f:	83 ec 0c             	sub    $0xc,%esp
    1832:	ff 75 ec             	pushl  -0x14(%ebp)
    1835:	e8 dd fe ff ff       	call   1717 <morecore>
    183a:	83 c4 10             	add    $0x10,%esp
    183d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1840:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1844:	75 07                	jne    184d <malloc+0xd2>
        return 0;
    1846:	b8 00 00 00 00       	mov    $0x0,%eax
    184b:	eb 13                	jmp    1860 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    184d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1850:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1853:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1856:	8b 00                	mov    (%eax),%eax
    1858:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    185b:	e9 6d ff ff ff       	jmp    17cd <malloc+0x52>
  }
}
    1860:	c9                   	leave  
    1861:	c3                   	ret    
