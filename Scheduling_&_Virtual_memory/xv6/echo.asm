
_echo:     file format elf32-i386


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

  for(i = 1; i < argc; i++)
    1018:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    101f:	eb 3c                	jmp    105d <main+0x5d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
    1021:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1024:	83 c0 01             	add    $0x1,%eax
    1027:	39 03                	cmp    %eax,(%ebx)
    1029:	7e 07                	jle    1032 <main+0x32>
    102b:	b9 37 18 00 00       	mov    $0x1837,%ecx
    1030:	eb 05                	jmp    1037 <main+0x37>
    1032:	b9 39 18 00 00       	mov    $0x1839,%ecx
    1037:	8b 45 f4             	mov    -0xc(%ebp),%eax
    103a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1041:	8b 43 04             	mov    0x4(%ebx),%eax
    1044:	01 d0                	add    %edx,%eax
    1046:	8b 00                	mov    (%eax),%eax
    1048:	51                   	push   %ecx
    1049:	50                   	push   %eax
    104a:	68 3b 18 00 00       	push   $0x183b
    104f:	6a 01                	push   $0x1
    1051:	e8 1a 04 00 00       	call   1470 <printf>
    1056:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++)
    1059:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    105d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1060:	3b 03                	cmp    (%ebx),%eax
    1062:	7c bd                	jl     1021 <main+0x21>
  exit();
    1064:	e8 7b 02 00 00       	call   12e4 <exit>

00001069 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1069:	55                   	push   %ebp
    106a:	89 e5                	mov    %esp,%ebp
    106c:	57                   	push   %edi
    106d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    106e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1071:	8b 55 10             	mov    0x10(%ebp),%edx
    1074:	8b 45 0c             	mov    0xc(%ebp),%eax
    1077:	89 cb                	mov    %ecx,%ebx
    1079:	89 df                	mov    %ebx,%edi
    107b:	89 d1                	mov    %edx,%ecx
    107d:	fc                   	cld    
    107e:	f3 aa                	rep stos %al,%es:(%edi)
    1080:	89 ca                	mov    %ecx,%edx
    1082:	89 fb                	mov    %edi,%ebx
    1084:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1087:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    108a:	90                   	nop
    108b:	5b                   	pop    %ebx
    108c:	5f                   	pop    %edi
    108d:	5d                   	pop    %ebp
    108e:	c3                   	ret    

0000108f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    108f:	f3 0f 1e fb          	endbr32 
    1093:	55                   	push   %ebp
    1094:	89 e5                	mov    %esp,%ebp
    1096:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1099:	8b 45 08             	mov    0x8(%ebp),%eax
    109c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    109f:	90                   	nop
    10a0:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a3:	8d 42 01             	lea    0x1(%edx),%eax
    10a6:	89 45 0c             	mov    %eax,0xc(%ebp)
    10a9:	8b 45 08             	mov    0x8(%ebp),%eax
    10ac:	8d 48 01             	lea    0x1(%eax),%ecx
    10af:	89 4d 08             	mov    %ecx,0x8(%ebp)
    10b2:	0f b6 12             	movzbl (%edx),%edx
    10b5:	88 10                	mov    %dl,(%eax)
    10b7:	0f b6 00             	movzbl (%eax),%eax
    10ba:	84 c0                	test   %al,%al
    10bc:	75 e2                	jne    10a0 <strcpy+0x11>
    ;
  return os;
    10be:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10c1:	c9                   	leave  
    10c2:	c3                   	ret    

000010c3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10c3:	f3 0f 1e fb          	endbr32 
    10c7:	55                   	push   %ebp
    10c8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10ca:	eb 08                	jmp    10d4 <strcmp+0x11>
    p++, q++;
    10cc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10d0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    10d4:	8b 45 08             	mov    0x8(%ebp),%eax
    10d7:	0f b6 00             	movzbl (%eax),%eax
    10da:	84 c0                	test   %al,%al
    10dc:	74 10                	je     10ee <strcmp+0x2b>
    10de:	8b 45 08             	mov    0x8(%ebp),%eax
    10e1:	0f b6 10             	movzbl (%eax),%edx
    10e4:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e7:	0f b6 00             	movzbl (%eax),%eax
    10ea:	38 c2                	cmp    %al,%dl
    10ec:	74 de                	je     10cc <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    10ee:	8b 45 08             	mov    0x8(%ebp),%eax
    10f1:	0f b6 00             	movzbl (%eax),%eax
    10f4:	0f b6 d0             	movzbl %al,%edx
    10f7:	8b 45 0c             	mov    0xc(%ebp),%eax
    10fa:	0f b6 00             	movzbl (%eax),%eax
    10fd:	0f b6 c0             	movzbl %al,%eax
    1100:	29 c2                	sub    %eax,%edx
    1102:	89 d0                	mov    %edx,%eax
}
    1104:	5d                   	pop    %ebp
    1105:	c3                   	ret    

00001106 <strlen>:

uint
strlen(const char *s)
{
    1106:	f3 0f 1e fb          	endbr32 
    110a:	55                   	push   %ebp
    110b:	89 e5                	mov    %esp,%ebp
    110d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1110:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1117:	eb 04                	jmp    111d <strlen+0x17>
    1119:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    111d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1120:	8b 45 08             	mov    0x8(%ebp),%eax
    1123:	01 d0                	add    %edx,%eax
    1125:	0f b6 00             	movzbl (%eax),%eax
    1128:	84 c0                	test   %al,%al
    112a:	75 ed                	jne    1119 <strlen+0x13>
    ;
  return n;
    112c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    112f:	c9                   	leave  
    1130:	c3                   	ret    

00001131 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1131:	f3 0f 1e fb          	endbr32 
    1135:	55                   	push   %ebp
    1136:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1138:	8b 45 10             	mov    0x10(%ebp),%eax
    113b:	50                   	push   %eax
    113c:	ff 75 0c             	pushl  0xc(%ebp)
    113f:	ff 75 08             	pushl  0x8(%ebp)
    1142:	e8 22 ff ff ff       	call   1069 <stosb>
    1147:	83 c4 0c             	add    $0xc,%esp
  return dst;
    114a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    114d:	c9                   	leave  
    114e:	c3                   	ret    

0000114f <strchr>:

char*
strchr(const char *s, char c)
{
    114f:	f3 0f 1e fb          	endbr32 
    1153:	55                   	push   %ebp
    1154:	89 e5                	mov    %esp,%ebp
    1156:	83 ec 04             	sub    $0x4,%esp
    1159:	8b 45 0c             	mov    0xc(%ebp),%eax
    115c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    115f:	eb 14                	jmp    1175 <strchr+0x26>
    if(*s == c)
    1161:	8b 45 08             	mov    0x8(%ebp),%eax
    1164:	0f b6 00             	movzbl (%eax),%eax
    1167:	38 45 fc             	cmp    %al,-0x4(%ebp)
    116a:	75 05                	jne    1171 <strchr+0x22>
      return (char*)s;
    116c:	8b 45 08             	mov    0x8(%ebp),%eax
    116f:	eb 13                	jmp    1184 <strchr+0x35>
  for(; *s; s++)
    1171:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1175:	8b 45 08             	mov    0x8(%ebp),%eax
    1178:	0f b6 00             	movzbl (%eax),%eax
    117b:	84 c0                	test   %al,%al
    117d:	75 e2                	jne    1161 <strchr+0x12>
  return 0;
    117f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1184:	c9                   	leave  
    1185:	c3                   	ret    

00001186 <gets>:

char*
gets(char *buf, int max)
{
    1186:	f3 0f 1e fb          	endbr32 
    118a:	55                   	push   %ebp
    118b:	89 e5                	mov    %esp,%ebp
    118d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1190:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1197:	eb 42                	jmp    11db <gets+0x55>
    cc = read(0, &c, 1);
    1199:	83 ec 04             	sub    $0x4,%esp
    119c:	6a 01                	push   $0x1
    119e:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11a1:	50                   	push   %eax
    11a2:	6a 00                	push   $0x0
    11a4:	e8 53 01 00 00       	call   12fc <read>
    11a9:	83 c4 10             	add    $0x10,%esp
    11ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11b3:	7e 33                	jle    11e8 <gets+0x62>
      break;
    buf[i++] = c;
    11b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b8:	8d 50 01             	lea    0x1(%eax),%edx
    11bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11be:	89 c2                	mov    %eax,%edx
    11c0:	8b 45 08             	mov    0x8(%ebp),%eax
    11c3:	01 c2                	add    %eax,%edx
    11c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11cb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11cf:	3c 0a                	cmp    $0xa,%al
    11d1:	74 16                	je     11e9 <gets+0x63>
    11d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11d7:	3c 0d                	cmp    $0xd,%al
    11d9:	74 0e                	je     11e9 <gets+0x63>
  for(i=0; i+1 < max; ){
    11db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11de:	83 c0 01             	add    $0x1,%eax
    11e1:	39 45 0c             	cmp    %eax,0xc(%ebp)
    11e4:	7f b3                	jg     1199 <gets+0x13>
    11e6:	eb 01                	jmp    11e9 <gets+0x63>
      break;
    11e8:	90                   	nop
      break;
  }
  buf[i] = '\0';
    11e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11ec:	8b 45 08             	mov    0x8(%ebp),%eax
    11ef:	01 d0                	add    %edx,%eax
    11f1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11f4:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11f7:	c9                   	leave  
    11f8:	c3                   	ret    

000011f9 <stat>:

int
stat(const char *n, struct stat *st)
{
    11f9:	f3 0f 1e fb          	endbr32 
    11fd:	55                   	push   %ebp
    11fe:	89 e5                	mov    %esp,%ebp
    1200:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1203:	83 ec 08             	sub    $0x8,%esp
    1206:	6a 00                	push   $0x0
    1208:	ff 75 08             	pushl  0x8(%ebp)
    120b:	e8 14 01 00 00       	call   1324 <open>
    1210:	83 c4 10             	add    $0x10,%esp
    1213:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1216:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    121a:	79 07                	jns    1223 <stat+0x2a>
    return -1;
    121c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1221:	eb 25                	jmp    1248 <stat+0x4f>
  r = fstat(fd, st);
    1223:	83 ec 08             	sub    $0x8,%esp
    1226:	ff 75 0c             	pushl  0xc(%ebp)
    1229:	ff 75 f4             	pushl  -0xc(%ebp)
    122c:	e8 0b 01 00 00       	call   133c <fstat>
    1231:	83 c4 10             	add    $0x10,%esp
    1234:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1237:	83 ec 0c             	sub    $0xc,%esp
    123a:	ff 75 f4             	pushl  -0xc(%ebp)
    123d:	e8 ca 00 00 00       	call   130c <close>
    1242:	83 c4 10             	add    $0x10,%esp
  return r;
    1245:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1248:	c9                   	leave  
    1249:	c3                   	ret    

0000124a <atoi>:

int
atoi(const char *s)
{
    124a:	f3 0f 1e fb          	endbr32 
    124e:	55                   	push   %ebp
    124f:	89 e5                	mov    %esp,%ebp
    1251:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    125b:	eb 25                	jmp    1282 <atoi+0x38>
    n = n*10 + *s++ - '0';
    125d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1260:	89 d0                	mov    %edx,%eax
    1262:	c1 e0 02             	shl    $0x2,%eax
    1265:	01 d0                	add    %edx,%eax
    1267:	01 c0                	add    %eax,%eax
    1269:	89 c1                	mov    %eax,%ecx
    126b:	8b 45 08             	mov    0x8(%ebp),%eax
    126e:	8d 50 01             	lea    0x1(%eax),%edx
    1271:	89 55 08             	mov    %edx,0x8(%ebp)
    1274:	0f b6 00             	movzbl (%eax),%eax
    1277:	0f be c0             	movsbl %al,%eax
    127a:	01 c8                	add    %ecx,%eax
    127c:	83 e8 30             	sub    $0x30,%eax
    127f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1282:	8b 45 08             	mov    0x8(%ebp),%eax
    1285:	0f b6 00             	movzbl (%eax),%eax
    1288:	3c 2f                	cmp    $0x2f,%al
    128a:	7e 0a                	jle    1296 <atoi+0x4c>
    128c:	8b 45 08             	mov    0x8(%ebp),%eax
    128f:	0f b6 00             	movzbl (%eax),%eax
    1292:	3c 39                	cmp    $0x39,%al
    1294:	7e c7                	jle    125d <atoi+0x13>
  return n;
    1296:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1299:	c9                   	leave  
    129a:	c3                   	ret    

0000129b <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    129b:	f3 0f 1e fb          	endbr32 
    129f:	55                   	push   %ebp
    12a0:	89 e5                	mov    %esp,%ebp
    12a2:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    12a5:	8b 45 08             	mov    0x8(%ebp),%eax
    12a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12b1:	eb 17                	jmp    12ca <memmove+0x2f>
    *dst++ = *src++;
    12b3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12b6:	8d 42 01             	lea    0x1(%edx),%eax
    12b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12bf:	8d 48 01             	lea    0x1(%eax),%ecx
    12c2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    12c5:	0f b6 12             	movzbl (%edx),%edx
    12c8:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    12ca:	8b 45 10             	mov    0x10(%ebp),%eax
    12cd:	8d 50 ff             	lea    -0x1(%eax),%edx
    12d0:	89 55 10             	mov    %edx,0x10(%ebp)
    12d3:	85 c0                	test   %eax,%eax
    12d5:	7f dc                	jg     12b3 <memmove+0x18>
  return vdst;
    12d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12da:	c9                   	leave  
    12db:	c3                   	ret    

000012dc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12dc:	b8 01 00 00 00       	mov    $0x1,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <exit>:
SYSCALL(exit)
    12e4:	b8 02 00 00 00       	mov    $0x2,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <wait>:
SYSCALL(wait)
    12ec:	b8 03 00 00 00       	mov    $0x3,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <pipe>:
SYSCALL(pipe)
    12f4:	b8 04 00 00 00       	mov    $0x4,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <read>:
SYSCALL(read)
    12fc:	b8 05 00 00 00       	mov    $0x5,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <write>:
SYSCALL(write)
    1304:	b8 10 00 00 00       	mov    $0x10,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <close>:
SYSCALL(close)
    130c:	b8 15 00 00 00       	mov    $0x15,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <kill>:
SYSCALL(kill)
    1314:	b8 06 00 00 00       	mov    $0x6,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <exec>:
SYSCALL(exec)
    131c:	b8 07 00 00 00       	mov    $0x7,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <open>:
SYSCALL(open)
    1324:	b8 0f 00 00 00       	mov    $0xf,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <mknod>:
SYSCALL(mknod)
    132c:	b8 11 00 00 00       	mov    $0x11,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <unlink>:
SYSCALL(unlink)
    1334:	b8 12 00 00 00       	mov    $0x12,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <fstat>:
SYSCALL(fstat)
    133c:	b8 08 00 00 00       	mov    $0x8,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <link>:
SYSCALL(link)
    1344:	b8 13 00 00 00       	mov    $0x13,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <mkdir>:
SYSCALL(mkdir)
    134c:	b8 14 00 00 00       	mov    $0x14,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <chdir>:
SYSCALL(chdir)
    1354:	b8 09 00 00 00       	mov    $0x9,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <dup>:
SYSCALL(dup)
    135c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <getpid>:
SYSCALL(getpid)
    1364:	b8 0b 00 00 00       	mov    $0xb,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <sbrk>:
SYSCALL(sbrk)
    136c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <sleep>:
SYSCALL(sleep)
    1374:	b8 0d 00 00 00       	mov    $0xd,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <uptime>:
SYSCALL(uptime)
    137c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <settickets>:
SYSCALL(settickets)
    1384:	b8 16 00 00 00       	mov    $0x16,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <getpinfo>:
SYSCALL(getpinfo)
    138c:	b8 17 00 00 00       	mov    $0x17,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1394:	f3 0f 1e fb          	endbr32 
    1398:	55                   	push   %ebp
    1399:	89 e5                	mov    %esp,%ebp
    139b:	83 ec 18             	sub    $0x18,%esp
    139e:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13a4:	83 ec 04             	sub    $0x4,%esp
    13a7:	6a 01                	push   $0x1
    13a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13ac:	50                   	push   %eax
    13ad:	ff 75 08             	pushl  0x8(%ebp)
    13b0:	e8 4f ff ff ff       	call   1304 <write>
    13b5:	83 c4 10             	add    $0x10,%esp
}
    13b8:	90                   	nop
    13b9:	c9                   	leave  
    13ba:	c3                   	ret    

000013bb <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13bb:	f3 0f 1e fb          	endbr32 
    13bf:	55                   	push   %ebp
    13c0:	89 e5                	mov    %esp,%ebp
    13c2:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13cc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13d0:	74 17                	je     13e9 <printint+0x2e>
    13d2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13d6:	79 11                	jns    13e9 <printint+0x2e>
    neg = 1;
    13d8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13df:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e2:	f7 d8                	neg    %eax
    13e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13e7:	eb 06                	jmp    13ef <printint+0x34>
  } else {
    x = xx;
    13e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13fc:	ba 00 00 00 00       	mov    $0x0,%edx
    1401:	f7 f1                	div    %ecx
    1403:	89 d1                	mov    %edx,%ecx
    1405:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1408:	8d 50 01             	lea    0x1(%eax),%edx
    140b:	89 55 f4             	mov    %edx,-0xc(%ebp)
    140e:	0f b6 91 90 1a 00 00 	movzbl 0x1a90(%ecx),%edx
    1415:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1419:	8b 4d 10             	mov    0x10(%ebp),%ecx
    141c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    141f:	ba 00 00 00 00       	mov    $0x0,%edx
    1424:	f7 f1                	div    %ecx
    1426:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1429:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    142d:	75 c7                	jne    13f6 <printint+0x3b>
  if(neg)
    142f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1433:	74 2d                	je     1462 <printint+0xa7>
    buf[i++] = '-';
    1435:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1438:	8d 50 01             	lea    0x1(%eax),%edx
    143b:	89 55 f4             	mov    %edx,-0xc(%ebp)
    143e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1443:	eb 1d                	jmp    1462 <printint+0xa7>
    putc(fd, buf[i]);
    1445:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1448:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144b:	01 d0                	add    %edx,%eax
    144d:	0f b6 00             	movzbl (%eax),%eax
    1450:	0f be c0             	movsbl %al,%eax
    1453:	83 ec 08             	sub    $0x8,%esp
    1456:	50                   	push   %eax
    1457:	ff 75 08             	pushl  0x8(%ebp)
    145a:	e8 35 ff ff ff       	call   1394 <putc>
    145f:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    1462:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1466:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    146a:	79 d9                	jns    1445 <printint+0x8a>
}
    146c:	90                   	nop
    146d:	90                   	nop
    146e:	c9                   	leave  
    146f:	c3                   	ret    

00001470 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1470:	f3 0f 1e fb          	endbr32 
    1474:	55                   	push   %ebp
    1475:	89 e5                	mov    %esp,%ebp
    1477:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    147a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1481:	8d 45 0c             	lea    0xc(%ebp),%eax
    1484:	83 c0 04             	add    $0x4,%eax
    1487:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    148a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1491:	e9 59 01 00 00       	jmp    15ef <printf+0x17f>
    c = fmt[i] & 0xff;
    1496:	8b 55 0c             	mov    0xc(%ebp),%edx
    1499:	8b 45 f0             	mov    -0x10(%ebp),%eax
    149c:	01 d0                	add    %edx,%eax
    149e:	0f b6 00             	movzbl (%eax),%eax
    14a1:	0f be c0             	movsbl %al,%eax
    14a4:	25 ff 00 00 00       	and    $0xff,%eax
    14a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14ac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14b0:	75 2c                	jne    14de <printf+0x6e>
      if(c == '%'){
    14b2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14b6:	75 0c                	jne    14c4 <printf+0x54>
        state = '%';
    14b8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14bf:	e9 27 01 00 00       	jmp    15eb <printf+0x17b>
      } else {
        putc(fd, c);
    14c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14c7:	0f be c0             	movsbl %al,%eax
    14ca:	83 ec 08             	sub    $0x8,%esp
    14cd:	50                   	push   %eax
    14ce:	ff 75 08             	pushl  0x8(%ebp)
    14d1:	e8 be fe ff ff       	call   1394 <putc>
    14d6:	83 c4 10             	add    $0x10,%esp
    14d9:	e9 0d 01 00 00       	jmp    15eb <printf+0x17b>
      }
    } else if(state == '%'){
    14de:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14e2:	0f 85 03 01 00 00    	jne    15eb <printf+0x17b>
      if(c == 'd'){
    14e8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14ec:	75 1e                	jne    150c <printf+0x9c>
        printint(fd, *ap, 10, 1);
    14ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14f1:	8b 00                	mov    (%eax),%eax
    14f3:	6a 01                	push   $0x1
    14f5:	6a 0a                	push   $0xa
    14f7:	50                   	push   %eax
    14f8:	ff 75 08             	pushl  0x8(%ebp)
    14fb:	e8 bb fe ff ff       	call   13bb <printint>
    1500:	83 c4 10             	add    $0x10,%esp
        ap++;
    1503:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1507:	e9 d8 00 00 00       	jmp    15e4 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    150c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1510:	74 06                	je     1518 <printf+0xa8>
    1512:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1516:	75 1e                	jne    1536 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1518:	8b 45 e8             	mov    -0x18(%ebp),%eax
    151b:	8b 00                	mov    (%eax),%eax
    151d:	6a 00                	push   $0x0
    151f:	6a 10                	push   $0x10
    1521:	50                   	push   %eax
    1522:	ff 75 08             	pushl  0x8(%ebp)
    1525:	e8 91 fe ff ff       	call   13bb <printint>
    152a:	83 c4 10             	add    $0x10,%esp
        ap++;
    152d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1531:	e9 ae 00 00 00       	jmp    15e4 <printf+0x174>
      } else if(c == 's'){
    1536:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    153a:	75 43                	jne    157f <printf+0x10f>
        s = (char*)*ap;
    153c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    153f:	8b 00                	mov    (%eax),%eax
    1541:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1544:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1548:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    154c:	75 25                	jne    1573 <printf+0x103>
          s = "(null)";
    154e:	c7 45 f4 40 18 00 00 	movl   $0x1840,-0xc(%ebp)
        while(*s != 0){
    1555:	eb 1c                	jmp    1573 <printf+0x103>
          putc(fd, *s);
    1557:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155a:	0f b6 00             	movzbl (%eax),%eax
    155d:	0f be c0             	movsbl %al,%eax
    1560:	83 ec 08             	sub    $0x8,%esp
    1563:	50                   	push   %eax
    1564:	ff 75 08             	pushl  0x8(%ebp)
    1567:	e8 28 fe ff ff       	call   1394 <putc>
    156c:	83 c4 10             	add    $0x10,%esp
          s++;
    156f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1573:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1576:	0f b6 00             	movzbl (%eax),%eax
    1579:	84 c0                	test   %al,%al
    157b:	75 da                	jne    1557 <printf+0xe7>
    157d:	eb 65                	jmp    15e4 <printf+0x174>
        }
      } else if(c == 'c'){
    157f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1583:	75 1d                	jne    15a2 <printf+0x132>
        putc(fd, *ap);
    1585:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1588:	8b 00                	mov    (%eax),%eax
    158a:	0f be c0             	movsbl %al,%eax
    158d:	83 ec 08             	sub    $0x8,%esp
    1590:	50                   	push   %eax
    1591:	ff 75 08             	pushl  0x8(%ebp)
    1594:	e8 fb fd ff ff       	call   1394 <putc>
    1599:	83 c4 10             	add    $0x10,%esp
        ap++;
    159c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15a0:	eb 42                	jmp    15e4 <printf+0x174>
      } else if(c == '%'){
    15a2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15a6:	75 17                	jne    15bf <printf+0x14f>
        putc(fd, c);
    15a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ab:	0f be c0             	movsbl %al,%eax
    15ae:	83 ec 08             	sub    $0x8,%esp
    15b1:	50                   	push   %eax
    15b2:	ff 75 08             	pushl  0x8(%ebp)
    15b5:	e8 da fd ff ff       	call   1394 <putc>
    15ba:	83 c4 10             	add    $0x10,%esp
    15bd:	eb 25                	jmp    15e4 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15bf:	83 ec 08             	sub    $0x8,%esp
    15c2:	6a 25                	push   $0x25
    15c4:	ff 75 08             	pushl  0x8(%ebp)
    15c7:	e8 c8 fd ff ff       	call   1394 <putc>
    15cc:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15d2:	0f be c0             	movsbl %al,%eax
    15d5:	83 ec 08             	sub    $0x8,%esp
    15d8:	50                   	push   %eax
    15d9:	ff 75 08             	pushl  0x8(%ebp)
    15dc:	e8 b3 fd ff ff       	call   1394 <putc>
    15e1:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    15eb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15ef:	8b 55 0c             	mov    0xc(%ebp),%edx
    15f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15f5:	01 d0                	add    %edx,%eax
    15f7:	0f b6 00             	movzbl (%eax),%eax
    15fa:	84 c0                	test   %al,%al
    15fc:	0f 85 94 fe ff ff    	jne    1496 <printf+0x26>
    }
  }
}
    1602:	90                   	nop
    1603:	90                   	nop
    1604:	c9                   	leave  
    1605:	c3                   	ret    

00001606 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1606:	f3 0f 1e fb          	endbr32 
    160a:	55                   	push   %ebp
    160b:	89 e5                	mov    %esp,%ebp
    160d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1610:	8b 45 08             	mov    0x8(%ebp),%eax
    1613:	83 e8 08             	sub    $0x8,%eax
    1616:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1619:	a1 ac 1a 00 00       	mov    0x1aac,%eax
    161e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1621:	eb 24                	jmp    1647 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1623:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1626:	8b 00                	mov    (%eax),%eax
    1628:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    162b:	72 12                	jb     163f <free+0x39>
    162d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1630:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1633:	77 24                	ja     1659 <free+0x53>
    1635:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1638:	8b 00                	mov    (%eax),%eax
    163a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    163d:	72 1a                	jb     1659 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    163f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1642:	8b 00                	mov    (%eax),%eax
    1644:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1647:	8b 45 f8             	mov    -0x8(%ebp),%eax
    164a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    164d:	76 d4                	jbe    1623 <free+0x1d>
    164f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1652:	8b 00                	mov    (%eax),%eax
    1654:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1657:	73 ca                	jae    1623 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1659:	8b 45 f8             	mov    -0x8(%ebp),%eax
    165c:	8b 40 04             	mov    0x4(%eax),%eax
    165f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1666:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1669:	01 c2                	add    %eax,%edx
    166b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166e:	8b 00                	mov    (%eax),%eax
    1670:	39 c2                	cmp    %eax,%edx
    1672:	75 24                	jne    1698 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1674:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1677:	8b 50 04             	mov    0x4(%eax),%edx
    167a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167d:	8b 00                	mov    (%eax),%eax
    167f:	8b 40 04             	mov    0x4(%eax),%eax
    1682:	01 c2                	add    %eax,%edx
    1684:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1687:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    168a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    168d:	8b 00                	mov    (%eax),%eax
    168f:	8b 10                	mov    (%eax),%edx
    1691:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1694:	89 10                	mov    %edx,(%eax)
    1696:	eb 0a                	jmp    16a2 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1698:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169b:	8b 10                	mov    (%eax),%edx
    169d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a0:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    16a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a5:	8b 40 04             	mov    0x4(%eax),%eax
    16a8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16af:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b2:	01 d0                	add    %edx,%eax
    16b4:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16b7:	75 20                	jne    16d9 <free+0xd3>
    p->s.size += bp->s.size;
    16b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bc:	8b 50 04             	mov    0x4(%eax),%edx
    16bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c2:	8b 40 04             	mov    0x4(%eax),%eax
    16c5:	01 c2                	add    %eax,%edx
    16c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ca:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d0:	8b 10                	mov    (%eax),%edx
    16d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d5:	89 10                	mov    %edx,(%eax)
    16d7:	eb 08                	jmp    16e1 <free+0xdb>
  } else
    p->s.ptr = bp;
    16d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16dc:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16df:	89 10                	mov    %edx,(%eax)
  freep = p;
    16e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e4:	a3 ac 1a 00 00       	mov    %eax,0x1aac
}
    16e9:	90                   	nop
    16ea:	c9                   	leave  
    16eb:	c3                   	ret    

000016ec <morecore>:

static Header*
morecore(uint nu)
{
    16ec:	f3 0f 1e fb          	endbr32 
    16f0:	55                   	push   %ebp
    16f1:	89 e5                	mov    %esp,%ebp
    16f3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16f6:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16fd:	77 07                	ja     1706 <morecore+0x1a>
    nu = 4096;
    16ff:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1706:	8b 45 08             	mov    0x8(%ebp),%eax
    1709:	c1 e0 03             	shl    $0x3,%eax
    170c:	83 ec 0c             	sub    $0xc,%esp
    170f:	50                   	push   %eax
    1710:	e8 57 fc ff ff       	call   136c <sbrk>
    1715:	83 c4 10             	add    $0x10,%esp
    1718:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    171b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    171f:	75 07                	jne    1728 <morecore+0x3c>
    return 0;
    1721:	b8 00 00 00 00       	mov    $0x0,%eax
    1726:	eb 26                	jmp    174e <morecore+0x62>
  hp = (Header*)p;
    1728:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    172e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1731:	8b 55 08             	mov    0x8(%ebp),%edx
    1734:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1737:	8b 45 f0             	mov    -0x10(%ebp),%eax
    173a:	83 c0 08             	add    $0x8,%eax
    173d:	83 ec 0c             	sub    $0xc,%esp
    1740:	50                   	push   %eax
    1741:	e8 c0 fe ff ff       	call   1606 <free>
    1746:	83 c4 10             	add    $0x10,%esp
  return freep;
    1749:	a1 ac 1a 00 00       	mov    0x1aac,%eax
}
    174e:	c9                   	leave  
    174f:	c3                   	ret    

00001750 <malloc>:

void*
malloc(uint nbytes)
{
    1750:	f3 0f 1e fb          	endbr32 
    1754:	55                   	push   %ebp
    1755:	89 e5                	mov    %esp,%ebp
    1757:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    175a:	8b 45 08             	mov    0x8(%ebp),%eax
    175d:	83 c0 07             	add    $0x7,%eax
    1760:	c1 e8 03             	shr    $0x3,%eax
    1763:	83 c0 01             	add    $0x1,%eax
    1766:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1769:	a1 ac 1a 00 00       	mov    0x1aac,%eax
    176e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1771:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1775:	75 23                	jne    179a <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1777:	c7 45 f0 a4 1a 00 00 	movl   $0x1aa4,-0x10(%ebp)
    177e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1781:	a3 ac 1a 00 00       	mov    %eax,0x1aac
    1786:	a1 ac 1a 00 00       	mov    0x1aac,%eax
    178b:	a3 a4 1a 00 00       	mov    %eax,0x1aa4
    base.s.size = 0;
    1790:	c7 05 a8 1a 00 00 00 	movl   $0x0,0x1aa8
    1797:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    179a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    179d:	8b 00                	mov    (%eax),%eax
    179f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    17a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a5:	8b 40 04             	mov    0x4(%eax),%eax
    17a8:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17ab:	77 4d                	ja     17fa <malloc+0xaa>
      if(p->s.size == nunits)
    17ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b0:	8b 40 04             	mov    0x4(%eax),%eax
    17b3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17b6:	75 0c                	jne    17c4 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    17b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bb:	8b 10                	mov    (%eax),%edx
    17bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17c0:	89 10                	mov    %edx,(%eax)
    17c2:	eb 26                	jmp    17ea <malloc+0x9a>
      else {
        p->s.size -= nunits;
    17c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c7:	8b 40 04             	mov    0x4(%eax),%eax
    17ca:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17cd:	89 c2                	mov    %eax,%edx
    17cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d2:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d8:	8b 40 04             	mov    0x4(%eax),%eax
    17db:	c1 e0 03             	shl    $0x3,%eax
    17de:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17e7:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ed:	a3 ac 1a 00 00       	mov    %eax,0x1aac
      return (void*)(p + 1);
    17f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f5:	83 c0 08             	add    $0x8,%eax
    17f8:	eb 3b                	jmp    1835 <malloc+0xe5>
    }
    if(p == freep)
    17fa:	a1 ac 1a 00 00       	mov    0x1aac,%eax
    17ff:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1802:	75 1e                	jne    1822 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1804:	83 ec 0c             	sub    $0xc,%esp
    1807:	ff 75 ec             	pushl  -0x14(%ebp)
    180a:	e8 dd fe ff ff       	call   16ec <morecore>
    180f:	83 c4 10             	add    $0x10,%esp
    1812:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1815:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1819:	75 07                	jne    1822 <malloc+0xd2>
        return 0;
    181b:	b8 00 00 00 00       	mov    $0x0,%eax
    1820:	eb 13                	jmp    1835 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1822:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1825:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1828:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182b:	8b 00                	mov    (%eax),%eax
    182d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1830:	e9 6d ff ff ff       	jmp    17a2 <malloc+0x52>
  }
}
    1835:	c9                   	leave  
    1836:	c3                   	ret    
