
_test_4:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "user.h"
#include "pstat.h"

int
main(int argc, char *argv[])
{  
    1000:	f3 0f 1e fb          	endbr32 
    1004:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1008:	83 e4 f0             	and    $0xfffffff0,%esp
    100b:	ff 71 fc             	pushl  -0x4(%ecx)
    100e:	55                   	push   %ebp
    100f:	89 e5                	mov    %esp,%ebp
    1011:	51                   	push   %ecx
    1012:	83 ec 04             	sub    $0x4,%esp
  if(settickets(1000000) == 0)
    1015:	83 ec 0c             	sub    $0xc,%esp
    1018:	68 40 42 0f 00       	push   $0xf4240
    101d:	e8 4d 03 00 00       	call   136f <settickets>
    1022:	83 c4 10             	add    $0x10,%esp
    1025:	85 c0                	test   %eax,%eax
    1027:	75 14                	jne    103d <main+0x3d>
  {
   printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    1029:	83 ec 08             	sub    $0x8,%esp
    102c:	68 22 18 00 00       	push   $0x1822
    1031:	6a 01                	push   $0x1
    1033:	e8 23 04 00 00       	call   145b <printf>
    1038:	83 c4 10             	add    $0x10,%esp
    103b:	eb 12                	jmp    104f <main+0x4f>
  }
  else
  {
   printf(1, "XV6_SCHEDULER\t FAILED\n");
    103d:	83 ec 08             	sub    $0x8,%esp
    1040:	68 3a 18 00 00       	push   $0x183a
    1045:	6a 01                	push   $0x1
    1047:	e8 0f 04 00 00       	call   145b <printf>
    104c:	83 c4 10             	add    $0x10,%esp
  }
   exit();
    104f:	e8 7b 02 00 00       	call   12cf <exit>

00001054 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1054:	55                   	push   %ebp
    1055:	89 e5                	mov    %esp,%ebp
    1057:	57                   	push   %edi
    1058:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1059:	8b 4d 08             	mov    0x8(%ebp),%ecx
    105c:	8b 55 10             	mov    0x10(%ebp),%edx
    105f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1062:	89 cb                	mov    %ecx,%ebx
    1064:	89 df                	mov    %ebx,%edi
    1066:	89 d1                	mov    %edx,%ecx
    1068:	fc                   	cld    
    1069:	f3 aa                	rep stos %al,%es:(%edi)
    106b:	89 ca                	mov    %ecx,%edx
    106d:	89 fb                	mov    %edi,%ebx
    106f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1072:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1075:	90                   	nop
    1076:	5b                   	pop    %ebx
    1077:	5f                   	pop    %edi
    1078:	5d                   	pop    %ebp
    1079:	c3                   	ret    

0000107a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    107a:	f3 0f 1e fb          	endbr32 
    107e:	55                   	push   %ebp
    107f:	89 e5                	mov    %esp,%ebp
    1081:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1084:	8b 45 08             	mov    0x8(%ebp),%eax
    1087:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    108a:	90                   	nop
    108b:	8b 55 0c             	mov    0xc(%ebp),%edx
    108e:	8d 42 01             	lea    0x1(%edx),%eax
    1091:	89 45 0c             	mov    %eax,0xc(%ebp)
    1094:	8b 45 08             	mov    0x8(%ebp),%eax
    1097:	8d 48 01             	lea    0x1(%eax),%ecx
    109a:	89 4d 08             	mov    %ecx,0x8(%ebp)
    109d:	0f b6 12             	movzbl (%edx),%edx
    10a0:	88 10                	mov    %dl,(%eax)
    10a2:	0f b6 00             	movzbl (%eax),%eax
    10a5:	84 c0                	test   %al,%al
    10a7:	75 e2                	jne    108b <strcpy+0x11>
    ;
  return os;
    10a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10ac:	c9                   	leave  
    10ad:	c3                   	ret    

000010ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10ae:	f3 0f 1e fb          	endbr32 
    10b2:	55                   	push   %ebp
    10b3:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10b5:	eb 08                	jmp    10bf <strcmp+0x11>
    p++, q++;
    10b7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10bb:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    10bf:	8b 45 08             	mov    0x8(%ebp),%eax
    10c2:	0f b6 00             	movzbl (%eax),%eax
    10c5:	84 c0                	test   %al,%al
    10c7:	74 10                	je     10d9 <strcmp+0x2b>
    10c9:	8b 45 08             	mov    0x8(%ebp),%eax
    10cc:	0f b6 10             	movzbl (%eax),%edx
    10cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d2:	0f b6 00             	movzbl (%eax),%eax
    10d5:	38 c2                	cmp    %al,%dl
    10d7:	74 de                	je     10b7 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    10d9:	8b 45 08             	mov    0x8(%ebp),%eax
    10dc:	0f b6 00             	movzbl (%eax),%eax
    10df:	0f b6 d0             	movzbl %al,%edx
    10e2:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e5:	0f b6 00             	movzbl (%eax),%eax
    10e8:	0f b6 c0             	movzbl %al,%eax
    10eb:	29 c2                	sub    %eax,%edx
    10ed:	89 d0                	mov    %edx,%eax
}
    10ef:	5d                   	pop    %ebp
    10f0:	c3                   	ret    

000010f1 <strlen>:

uint
strlen(const char *s)
{
    10f1:	f3 0f 1e fb          	endbr32 
    10f5:	55                   	push   %ebp
    10f6:	89 e5                	mov    %esp,%ebp
    10f8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1102:	eb 04                	jmp    1108 <strlen+0x17>
    1104:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1108:	8b 55 fc             	mov    -0x4(%ebp),%edx
    110b:	8b 45 08             	mov    0x8(%ebp),%eax
    110e:	01 d0                	add    %edx,%eax
    1110:	0f b6 00             	movzbl (%eax),%eax
    1113:	84 c0                	test   %al,%al
    1115:	75 ed                	jne    1104 <strlen+0x13>
    ;
  return n;
    1117:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    111a:	c9                   	leave  
    111b:	c3                   	ret    

0000111c <memset>:

void*
memset(void *dst, int c, uint n)
{
    111c:	f3 0f 1e fb          	endbr32 
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1123:	8b 45 10             	mov    0x10(%ebp),%eax
    1126:	50                   	push   %eax
    1127:	ff 75 0c             	pushl  0xc(%ebp)
    112a:	ff 75 08             	pushl  0x8(%ebp)
    112d:	e8 22 ff ff ff       	call   1054 <stosb>
    1132:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1135:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1138:	c9                   	leave  
    1139:	c3                   	ret    

0000113a <strchr>:

char*
strchr(const char *s, char c)
{
    113a:	f3 0f 1e fb          	endbr32 
    113e:	55                   	push   %ebp
    113f:	89 e5                	mov    %esp,%ebp
    1141:	83 ec 04             	sub    $0x4,%esp
    1144:	8b 45 0c             	mov    0xc(%ebp),%eax
    1147:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    114a:	eb 14                	jmp    1160 <strchr+0x26>
    if(*s == c)
    114c:	8b 45 08             	mov    0x8(%ebp),%eax
    114f:	0f b6 00             	movzbl (%eax),%eax
    1152:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1155:	75 05                	jne    115c <strchr+0x22>
      return (char*)s;
    1157:	8b 45 08             	mov    0x8(%ebp),%eax
    115a:	eb 13                	jmp    116f <strchr+0x35>
  for(; *s; s++)
    115c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1160:	8b 45 08             	mov    0x8(%ebp),%eax
    1163:	0f b6 00             	movzbl (%eax),%eax
    1166:	84 c0                	test   %al,%al
    1168:	75 e2                	jne    114c <strchr+0x12>
  return 0;
    116a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    116f:	c9                   	leave  
    1170:	c3                   	ret    

00001171 <gets>:

char*
gets(char *buf, int max)
{
    1171:	f3 0f 1e fb          	endbr32 
    1175:	55                   	push   %ebp
    1176:	89 e5                	mov    %esp,%ebp
    1178:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    117b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1182:	eb 42                	jmp    11c6 <gets+0x55>
    cc = read(0, &c, 1);
    1184:	83 ec 04             	sub    $0x4,%esp
    1187:	6a 01                	push   $0x1
    1189:	8d 45 ef             	lea    -0x11(%ebp),%eax
    118c:	50                   	push   %eax
    118d:	6a 00                	push   $0x0
    118f:	e8 53 01 00 00       	call   12e7 <read>
    1194:	83 c4 10             	add    $0x10,%esp
    1197:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    119a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    119e:	7e 33                	jle    11d3 <gets+0x62>
      break;
    buf[i++] = c;
    11a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a3:	8d 50 01             	lea    0x1(%eax),%edx
    11a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11a9:	89 c2                	mov    %eax,%edx
    11ab:	8b 45 08             	mov    0x8(%ebp),%eax
    11ae:	01 c2                	add    %eax,%edx
    11b0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11b4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11b6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11ba:	3c 0a                	cmp    $0xa,%al
    11bc:	74 16                	je     11d4 <gets+0x63>
    11be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c2:	3c 0d                	cmp    $0xd,%al
    11c4:	74 0e                	je     11d4 <gets+0x63>
  for(i=0; i+1 < max; ){
    11c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11c9:	83 c0 01             	add    $0x1,%eax
    11cc:	39 45 0c             	cmp    %eax,0xc(%ebp)
    11cf:	7f b3                	jg     1184 <gets+0x13>
    11d1:	eb 01                	jmp    11d4 <gets+0x63>
      break;
    11d3:	90                   	nop
      break;
  }
  buf[i] = '\0';
    11d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11d7:	8b 45 08             	mov    0x8(%ebp),%eax
    11da:	01 d0                	add    %edx,%eax
    11dc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11df:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11e2:	c9                   	leave  
    11e3:	c3                   	ret    

000011e4 <stat>:

int
stat(const char *n, struct stat *st)
{
    11e4:	f3 0f 1e fb          	endbr32 
    11e8:	55                   	push   %ebp
    11e9:	89 e5                	mov    %esp,%ebp
    11eb:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11ee:	83 ec 08             	sub    $0x8,%esp
    11f1:	6a 00                	push   $0x0
    11f3:	ff 75 08             	pushl  0x8(%ebp)
    11f6:	e8 14 01 00 00       	call   130f <open>
    11fb:	83 c4 10             	add    $0x10,%esp
    11fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1201:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1205:	79 07                	jns    120e <stat+0x2a>
    return -1;
    1207:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    120c:	eb 25                	jmp    1233 <stat+0x4f>
  r = fstat(fd, st);
    120e:	83 ec 08             	sub    $0x8,%esp
    1211:	ff 75 0c             	pushl  0xc(%ebp)
    1214:	ff 75 f4             	pushl  -0xc(%ebp)
    1217:	e8 0b 01 00 00       	call   1327 <fstat>
    121c:	83 c4 10             	add    $0x10,%esp
    121f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1222:	83 ec 0c             	sub    $0xc,%esp
    1225:	ff 75 f4             	pushl  -0xc(%ebp)
    1228:	e8 ca 00 00 00       	call   12f7 <close>
    122d:	83 c4 10             	add    $0x10,%esp
  return r;
    1230:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1233:	c9                   	leave  
    1234:	c3                   	ret    

00001235 <atoi>:

int
atoi(const char *s)
{
    1235:	f3 0f 1e fb          	endbr32 
    1239:	55                   	push   %ebp
    123a:	89 e5                	mov    %esp,%ebp
    123c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    123f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1246:	eb 25                	jmp    126d <atoi+0x38>
    n = n*10 + *s++ - '0';
    1248:	8b 55 fc             	mov    -0x4(%ebp),%edx
    124b:	89 d0                	mov    %edx,%eax
    124d:	c1 e0 02             	shl    $0x2,%eax
    1250:	01 d0                	add    %edx,%eax
    1252:	01 c0                	add    %eax,%eax
    1254:	89 c1                	mov    %eax,%ecx
    1256:	8b 45 08             	mov    0x8(%ebp),%eax
    1259:	8d 50 01             	lea    0x1(%eax),%edx
    125c:	89 55 08             	mov    %edx,0x8(%ebp)
    125f:	0f b6 00             	movzbl (%eax),%eax
    1262:	0f be c0             	movsbl %al,%eax
    1265:	01 c8                	add    %ecx,%eax
    1267:	83 e8 30             	sub    $0x30,%eax
    126a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    126d:	8b 45 08             	mov    0x8(%ebp),%eax
    1270:	0f b6 00             	movzbl (%eax),%eax
    1273:	3c 2f                	cmp    $0x2f,%al
    1275:	7e 0a                	jle    1281 <atoi+0x4c>
    1277:	8b 45 08             	mov    0x8(%ebp),%eax
    127a:	0f b6 00             	movzbl (%eax),%eax
    127d:	3c 39                	cmp    $0x39,%al
    127f:	7e c7                	jle    1248 <atoi+0x13>
  return n;
    1281:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1284:	c9                   	leave  
    1285:	c3                   	ret    

00001286 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1286:	f3 0f 1e fb          	endbr32 
    128a:	55                   	push   %ebp
    128b:	89 e5                	mov    %esp,%ebp
    128d:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    1290:	8b 45 08             	mov    0x8(%ebp),%eax
    1293:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1296:	8b 45 0c             	mov    0xc(%ebp),%eax
    1299:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    129c:	eb 17                	jmp    12b5 <memmove+0x2f>
    *dst++ = *src++;
    129e:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12a1:	8d 42 01             	lea    0x1(%edx),%eax
    12a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12aa:	8d 48 01             	lea    0x1(%eax),%ecx
    12ad:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    12b0:	0f b6 12             	movzbl (%edx),%edx
    12b3:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    12b5:	8b 45 10             	mov    0x10(%ebp),%eax
    12b8:	8d 50 ff             	lea    -0x1(%eax),%edx
    12bb:	89 55 10             	mov    %edx,0x10(%ebp)
    12be:	85 c0                	test   %eax,%eax
    12c0:	7f dc                	jg     129e <memmove+0x18>
  return vdst;
    12c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12c5:	c9                   	leave  
    12c6:	c3                   	ret    

000012c7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12c7:	b8 01 00 00 00       	mov    $0x1,%eax
    12cc:	cd 40                	int    $0x40
    12ce:	c3                   	ret    

000012cf <exit>:
SYSCALL(exit)
    12cf:	b8 02 00 00 00       	mov    $0x2,%eax
    12d4:	cd 40                	int    $0x40
    12d6:	c3                   	ret    

000012d7 <wait>:
SYSCALL(wait)
    12d7:	b8 03 00 00 00       	mov    $0x3,%eax
    12dc:	cd 40                	int    $0x40
    12de:	c3                   	ret    

000012df <pipe>:
SYSCALL(pipe)
    12df:	b8 04 00 00 00       	mov    $0x4,%eax
    12e4:	cd 40                	int    $0x40
    12e6:	c3                   	ret    

000012e7 <read>:
SYSCALL(read)
    12e7:	b8 05 00 00 00       	mov    $0x5,%eax
    12ec:	cd 40                	int    $0x40
    12ee:	c3                   	ret    

000012ef <write>:
SYSCALL(write)
    12ef:	b8 10 00 00 00       	mov    $0x10,%eax
    12f4:	cd 40                	int    $0x40
    12f6:	c3                   	ret    

000012f7 <close>:
SYSCALL(close)
    12f7:	b8 15 00 00 00       	mov    $0x15,%eax
    12fc:	cd 40                	int    $0x40
    12fe:	c3                   	ret    

000012ff <kill>:
SYSCALL(kill)
    12ff:	b8 06 00 00 00       	mov    $0x6,%eax
    1304:	cd 40                	int    $0x40
    1306:	c3                   	ret    

00001307 <exec>:
SYSCALL(exec)
    1307:	b8 07 00 00 00       	mov    $0x7,%eax
    130c:	cd 40                	int    $0x40
    130e:	c3                   	ret    

0000130f <open>:
SYSCALL(open)
    130f:	b8 0f 00 00 00       	mov    $0xf,%eax
    1314:	cd 40                	int    $0x40
    1316:	c3                   	ret    

00001317 <mknod>:
SYSCALL(mknod)
    1317:	b8 11 00 00 00       	mov    $0x11,%eax
    131c:	cd 40                	int    $0x40
    131e:	c3                   	ret    

0000131f <unlink>:
SYSCALL(unlink)
    131f:	b8 12 00 00 00       	mov    $0x12,%eax
    1324:	cd 40                	int    $0x40
    1326:	c3                   	ret    

00001327 <fstat>:
SYSCALL(fstat)
    1327:	b8 08 00 00 00       	mov    $0x8,%eax
    132c:	cd 40                	int    $0x40
    132e:	c3                   	ret    

0000132f <link>:
SYSCALL(link)
    132f:	b8 13 00 00 00       	mov    $0x13,%eax
    1334:	cd 40                	int    $0x40
    1336:	c3                   	ret    

00001337 <mkdir>:
SYSCALL(mkdir)
    1337:	b8 14 00 00 00       	mov    $0x14,%eax
    133c:	cd 40                	int    $0x40
    133e:	c3                   	ret    

0000133f <chdir>:
SYSCALL(chdir)
    133f:	b8 09 00 00 00       	mov    $0x9,%eax
    1344:	cd 40                	int    $0x40
    1346:	c3                   	ret    

00001347 <dup>:
SYSCALL(dup)
    1347:	b8 0a 00 00 00       	mov    $0xa,%eax
    134c:	cd 40                	int    $0x40
    134e:	c3                   	ret    

0000134f <getpid>:
SYSCALL(getpid)
    134f:	b8 0b 00 00 00       	mov    $0xb,%eax
    1354:	cd 40                	int    $0x40
    1356:	c3                   	ret    

00001357 <sbrk>:
SYSCALL(sbrk)
    1357:	b8 0c 00 00 00       	mov    $0xc,%eax
    135c:	cd 40                	int    $0x40
    135e:	c3                   	ret    

0000135f <sleep>:
SYSCALL(sleep)
    135f:	b8 0d 00 00 00       	mov    $0xd,%eax
    1364:	cd 40                	int    $0x40
    1366:	c3                   	ret    

00001367 <uptime>:
SYSCALL(uptime)
    1367:	b8 0e 00 00 00       	mov    $0xe,%eax
    136c:	cd 40                	int    $0x40
    136e:	c3                   	ret    

0000136f <settickets>:
SYSCALL(settickets)
    136f:	b8 16 00 00 00       	mov    $0x16,%eax
    1374:	cd 40                	int    $0x40
    1376:	c3                   	ret    

00001377 <getpinfo>:
SYSCALL(getpinfo)
    1377:	b8 17 00 00 00       	mov    $0x17,%eax
    137c:	cd 40                	int    $0x40
    137e:	c3                   	ret    

0000137f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    137f:	f3 0f 1e fb          	endbr32 
    1383:	55                   	push   %ebp
    1384:	89 e5                	mov    %esp,%ebp
    1386:	83 ec 18             	sub    $0x18,%esp
    1389:	8b 45 0c             	mov    0xc(%ebp),%eax
    138c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    138f:	83 ec 04             	sub    $0x4,%esp
    1392:	6a 01                	push   $0x1
    1394:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1397:	50                   	push   %eax
    1398:	ff 75 08             	pushl  0x8(%ebp)
    139b:	e8 4f ff ff ff       	call   12ef <write>
    13a0:	83 c4 10             	add    $0x10,%esp
}
    13a3:	90                   	nop
    13a4:	c9                   	leave  
    13a5:	c3                   	ret    

000013a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13a6:	f3 0f 1e fb          	endbr32 
    13aa:	55                   	push   %ebp
    13ab:	89 e5                	mov    %esp,%ebp
    13ad:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13b0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13b7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13bb:	74 17                	je     13d4 <printint+0x2e>
    13bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13c1:	79 11                	jns    13d4 <printint+0x2e>
    neg = 1;
    13c3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cd:	f7 d8                	neg    %eax
    13cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13d2:	eb 06                	jmp    13da <printint+0x34>
  } else {
    x = xx;
    13d4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13e1:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13e7:	ba 00 00 00 00       	mov    $0x0,%edx
    13ec:	f7 f1                	div    %ecx
    13ee:	89 d1                	mov    %edx,%ecx
    13f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f3:	8d 50 01             	lea    0x1(%eax),%edx
    13f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13f9:	0f b6 91 9c 1a 00 00 	movzbl 0x1a9c(%ecx),%edx
    1400:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1404:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1407:	8b 45 ec             	mov    -0x14(%ebp),%eax
    140a:	ba 00 00 00 00       	mov    $0x0,%edx
    140f:	f7 f1                	div    %ecx
    1411:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1414:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1418:	75 c7                	jne    13e1 <printint+0x3b>
  if(neg)
    141a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    141e:	74 2d                	je     144d <printint+0xa7>
    buf[i++] = '-';
    1420:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1423:	8d 50 01             	lea    0x1(%eax),%edx
    1426:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1429:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    142e:	eb 1d                	jmp    144d <printint+0xa7>
    putc(fd, buf[i]);
    1430:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1433:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1436:	01 d0                	add    %edx,%eax
    1438:	0f b6 00             	movzbl (%eax),%eax
    143b:	0f be c0             	movsbl %al,%eax
    143e:	83 ec 08             	sub    $0x8,%esp
    1441:	50                   	push   %eax
    1442:	ff 75 08             	pushl  0x8(%ebp)
    1445:	e8 35 ff ff ff       	call   137f <putc>
    144a:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    144d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1451:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1455:	79 d9                	jns    1430 <printint+0x8a>
}
    1457:	90                   	nop
    1458:	90                   	nop
    1459:	c9                   	leave  
    145a:	c3                   	ret    

0000145b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    145b:	f3 0f 1e fb          	endbr32 
    145f:	55                   	push   %ebp
    1460:	89 e5                	mov    %esp,%ebp
    1462:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1465:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    146c:	8d 45 0c             	lea    0xc(%ebp),%eax
    146f:	83 c0 04             	add    $0x4,%eax
    1472:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1475:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    147c:	e9 59 01 00 00       	jmp    15da <printf+0x17f>
    c = fmt[i] & 0xff;
    1481:	8b 55 0c             	mov    0xc(%ebp),%edx
    1484:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1487:	01 d0                	add    %edx,%eax
    1489:	0f b6 00             	movzbl (%eax),%eax
    148c:	0f be c0             	movsbl %al,%eax
    148f:	25 ff 00 00 00       	and    $0xff,%eax
    1494:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1497:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    149b:	75 2c                	jne    14c9 <printf+0x6e>
      if(c == '%'){
    149d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14a1:	75 0c                	jne    14af <printf+0x54>
        state = '%';
    14a3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14aa:	e9 27 01 00 00       	jmp    15d6 <printf+0x17b>
      } else {
        putc(fd, c);
    14af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14b2:	0f be c0             	movsbl %al,%eax
    14b5:	83 ec 08             	sub    $0x8,%esp
    14b8:	50                   	push   %eax
    14b9:	ff 75 08             	pushl  0x8(%ebp)
    14bc:	e8 be fe ff ff       	call   137f <putc>
    14c1:	83 c4 10             	add    $0x10,%esp
    14c4:	e9 0d 01 00 00       	jmp    15d6 <printf+0x17b>
      }
    } else if(state == '%'){
    14c9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14cd:	0f 85 03 01 00 00    	jne    15d6 <printf+0x17b>
      if(c == 'd'){
    14d3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14d7:	75 1e                	jne    14f7 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    14d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14dc:	8b 00                	mov    (%eax),%eax
    14de:	6a 01                	push   $0x1
    14e0:	6a 0a                	push   $0xa
    14e2:	50                   	push   %eax
    14e3:	ff 75 08             	pushl  0x8(%ebp)
    14e6:	e8 bb fe ff ff       	call   13a6 <printint>
    14eb:	83 c4 10             	add    $0x10,%esp
        ap++;
    14ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14f2:	e9 d8 00 00 00       	jmp    15cf <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    14f7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    14fb:	74 06                	je     1503 <printf+0xa8>
    14fd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1501:	75 1e                	jne    1521 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1503:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1506:	8b 00                	mov    (%eax),%eax
    1508:	6a 00                	push   $0x0
    150a:	6a 10                	push   $0x10
    150c:	50                   	push   %eax
    150d:	ff 75 08             	pushl  0x8(%ebp)
    1510:	e8 91 fe ff ff       	call   13a6 <printint>
    1515:	83 c4 10             	add    $0x10,%esp
        ap++;
    1518:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    151c:	e9 ae 00 00 00       	jmp    15cf <printf+0x174>
      } else if(c == 's'){
    1521:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1525:	75 43                	jne    156a <printf+0x10f>
        s = (char*)*ap;
    1527:	8b 45 e8             	mov    -0x18(%ebp),%eax
    152a:	8b 00                	mov    (%eax),%eax
    152c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    152f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1533:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1537:	75 25                	jne    155e <printf+0x103>
          s = "(null)";
    1539:	c7 45 f4 51 18 00 00 	movl   $0x1851,-0xc(%ebp)
        while(*s != 0){
    1540:	eb 1c                	jmp    155e <printf+0x103>
          putc(fd, *s);
    1542:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1545:	0f b6 00             	movzbl (%eax),%eax
    1548:	0f be c0             	movsbl %al,%eax
    154b:	83 ec 08             	sub    $0x8,%esp
    154e:	50                   	push   %eax
    154f:	ff 75 08             	pushl  0x8(%ebp)
    1552:	e8 28 fe ff ff       	call   137f <putc>
    1557:	83 c4 10             	add    $0x10,%esp
          s++;
    155a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    155e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1561:	0f b6 00             	movzbl (%eax),%eax
    1564:	84 c0                	test   %al,%al
    1566:	75 da                	jne    1542 <printf+0xe7>
    1568:	eb 65                	jmp    15cf <printf+0x174>
        }
      } else if(c == 'c'){
    156a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    156e:	75 1d                	jne    158d <printf+0x132>
        putc(fd, *ap);
    1570:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1573:	8b 00                	mov    (%eax),%eax
    1575:	0f be c0             	movsbl %al,%eax
    1578:	83 ec 08             	sub    $0x8,%esp
    157b:	50                   	push   %eax
    157c:	ff 75 08             	pushl  0x8(%ebp)
    157f:	e8 fb fd ff ff       	call   137f <putc>
    1584:	83 c4 10             	add    $0x10,%esp
        ap++;
    1587:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    158b:	eb 42                	jmp    15cf <printf+0x174>
      } else if(c == '%'){
    158d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1591:	75 17                	jne    15aa <printf+0x14f>
        putc(fd, c);
    1593:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1596:	0f be c0             	movsbl %al,%eax
    1599:	83 ec 08             	sub    $0x8,%esp
    159c:	50                   	push   %eax
    159d:	ff 75 08             	pushl  0x8(%ebp)
    15a0:	e8 da fd ff ff       	call   137f <putc>
    15a5:	83 c4 10             	add    $0x10,%esp
    15a8:	eb 25                	jmp    15cf <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15aa:	83 ec 08             	sub    $0x8,%esp
    15ad:	6a 25                	push   $0x25
    15af:	ff 75 08             	pushl  0x8(%ebp)
    15b2:	e8 c8 fd ff ff       	call   137f <putc>
    15b7:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15bd:	0f be c0             	movsbl %al,%eax
    15c0:	83 ec 08             	sub    $0x8,%esp
    15c3:	50                   	push   %eax
    15c4:	ff 75 08             	pushl  0x8(%ebp)
    15c7:	e8 b3 fd ff ff       	call   137f <putc>
    15cc:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15cf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    15d6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15da:	8b 55 0c             	mov    0xc(%ebp),%edx
    15dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15e0:	01 d0                	add    %edx,%eax
    15e2:	0f b6 00             	movzbl (%eax),%eax
    15e5:	84 c0                	test   %al,%al
    15e7:	0f 85 94 fe ff ff    	jne    1481 <printf+0x26>
    }
  }
}
    15ed:	90                   	nop
    15ee:	90                   	nop
    15ef:	c9                   	leave  
    15f0:	c3                   	ret    

000015f1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15f1:	f3 0f 1e fb          	endbr32 
    15f5:	55                   	push   %ebp
    15f6:	89 e5                	mov    %esp,%ebp
    15f8:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15fb:	8b 45 08             	mov    0x8(%ebp),%eax
    15fe:	83 e8 08             	sub    $0x8,%eax
    1601:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1604:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    1609:	89 45 fc             	mov    %eax,-0x4(%ebp)
    160c:	eb 24                	jmp    1632 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    160e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1611:	8b 00                	mov    (%eax),%eax
    1613:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1616:	72 12                	jb     162a <free+0x39>
    1618:	8b 45 f8             	mov    -0x8(%ebp),%eax
    161b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    161e:	77 24                	ja     1644 <free+0x53>
    1620:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1623:	8b 00                	mov    (%eax),%eax
    1625:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1628:	72 1a                	jb     1644 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    162a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    162d:	8b 00                	mov    (%eax),%eax
    162f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1632:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1635:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1638:	76 d4                	jbe    160e <free+0x1d>
    163a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    163d:	8b 00                	mov    (%eax),%eax
    163f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1642:	73 ca                	jae    160e <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1644:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1647:	8b 40 04             	mov    0x4(%eax),%eax
    164a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1651:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1654:	01 c2                	add    %eax,%edx
    1656:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1659:	8b 00                	mov    (%eax),%eax
    165b:	39 c2                	cmp    %eax,%edx
    165d:	75 24                	jne    1683 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    165f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1662:	8b 50 04             	mov    0x4(%eax),%edx
    1665:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1668:	8b 00                	mov    (%eax),%eax
    166a:	8b 40 04             	mov    0x4(%eax),%eax
    166d:	01 c2                	add    %eax,%edx
    166f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1672:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1675:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1678:	8b 00                	mov    (%eax),%eax
    167a:	8b 10                	mov    (%eax),%edx
    167c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167f:	89 10                	mov    %edx,(%eax)
    1681:	eb 0a                	jmp    168d <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1683:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1686:	8b 10                	mov    (%eax),%edx
    1688:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    168d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1690:	8b 40 04             	mov    0x4(%eax),%eax
    1693:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    169a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169d:	01 d0                	add    %edx,%eax
    169f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16a2:	75 20                	jne    16c4 <free+0xd3>
    p->s.size += bp->s.size;
    16a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a7:	8b 50 04             	mov    0x4(%eax),%edx
    16aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ad:	8b 40 04             	mov    0x4(%eax),%eax
    16b0:	01 c2                	add    %eax,%edx
    16b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16bb:	8b 10                	mov    (%eax),%edx
    16bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c0:	89 10                	mov    %edx,(%eax)
    16c2:	eb 08                	jmp    16cc <free+0xdb>
  } else
    p->s.ptr = bp;
    16c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c7:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16ca:	89 10                	mov    %edx,(%eax)
  freep = p;
    16cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cf:	a3 b8 1a 00 00       	mov    %eax,0x1ab8
}
    16d4:	90                   	nop
    16d5:	c9                   	leave  
    16d6:	c3                   	ret    

000016d7 <morecore>:

static Header*
morecore(uint nu)
{
    16d7:	f3 0f 1e fb          	endbr32 
    16db:	55                   	push   %ebp
    16dc:	89 e5                	mov    %esp,%ebp
    16de:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16e1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16e8:	77 07                	ja     16f1 <morecore+0x1a>
    nu = 4096;
    16ea:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    16f1:	8b 45 08             	mov    0x8(%ebp),%eax
    16f4:	c1 e0 03             	shl    $0x3,%eax
    16f7:	83 ec 0c             	sub    $0xc,%esp
    16fa:	50                   	push   %eax
    16fb:	e8 57 fc ff ff       	call   1357 <sbrk>
    1700:	83 c4 10             	add    $0x10,%esp
    1703:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1706:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    170a:	75 07                	jne    1713 <morecore+0x3c>
    return 0;
    170c:	b8 00 00 00 00       	mov    $0x0,%eax
    1711:	eb 26                	jmp    1739 <morecore+0x62>
  hp = (Header*)p;
    1713:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1716:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1719:	8b 45 f0             	mov    -0x10(%ebp),%eax
    171c:	8b 55 08             	mov    0x8(%ebp),%edx
    171f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1722:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1725:	83 c0 08             	add    $0x8,%eax
    1728:	83 ec 0c             	sub    $0xc,%esp
    172b:	50                   	push   %eax
    172c:	e8 c0 fe ff ff       	call   15f1 <free>
    1731:	83 c4 10             	add    $0x10,%esp
  return freep;
    1734:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
}
    1739:	c9                   	leave  
    173a:	c3                   	ret    

0000173b <malloc>:

void*
malloc(uint nbytes)
{
    173b:	f3 0f 1e fb          	endbr32 
    173f:	55                   	push   %ebp
    1740:	89 e5                	mov    %esp,%ebp
    1742:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1745:	8b 45 08             	mov    0x8(%ebp),%eax
    1748:	83 c0 07             	add    $0x7,%eax
    174b:	c1 e8 03             	shr    $0x3,%eax
    174e:	83 c0 01             	add    $0x1,%eax
    1751:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1754:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    1759:	89 45 f0             	mov    %eax,-0x10(%ebp)
    175c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1760:	75 23                	jne    1785 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1762:	c7 45 f0 b0 1a 00 00 	movl   $0x1ab0,-0x10(%ebp)
    1769:	8b 45 f0             	mov    -0x10(%ebp),%eax
    176c:	a3 b8 1a 00 00       	mov    %eax,0x1ab8
    1771:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    1776:	a3 b0 1a 00 00       	mov    %eax,0x1ab0
    base.s.size = 0;
    177b:	c7 05 b4 1a 00 00 00 	movl   $0x0,0x1ab4
    1782:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1785:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1788:	8b 00                	mov    (%eax),%eax
    178a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    178d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1790:	8b 40 04             	mov    0x4(%eax),%eax
    1793:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1796:	77 4d                	ja     17e5 <malloc+0xaa>
      if(p->s.size == nunits)
    1798:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179b:	8b 40 04             	mov    0x4(%eax),%eax
    179e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17a1:	75 0c                	jne    17af <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    17a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a6:	8b 10                	mov    (%eax),%edx
    17a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ab:	89 10                	mov    %edx,(%eax)
    17ad:	eb 26                	jmp    17d5 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    17af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b2:	8b 40 04             	mov    0x4(%eax),%eax
    17b5:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17b8:	89 c2                	mov    %eax,%edx
    17ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c3:	8b 40 04             	mov    0x4(%eax),%eax
    17c6:	c1 e0 03             	shl    $0x3,%eax
    17c9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cf:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17d2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d8:	a3 b8 1a 00 00       	mov    %eax,0x1ab8
      return (void*)(p + 1);
    17dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e0:	83 c0 08             	add    $0x8,%eax
    17e3:	eb 3b                	jmp    1820 <malloc+0xe5>
    }
    if(p == freep)
    17e5:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    17ea:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    17ed:	75 1e                	jne    180d <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    17ef:	83 ec 0c             	sub    $0xc,%esp
    17f2:	ff 75 ec             	pushl  -0x14(%ebp)
    17f5:	e8 dd fe ff ff       	call   16d7 <morecore>
    17fa:	83 c4 10             	add    $0x10,%esp
    17fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1800:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1804:	75 07                	jne    180d <malloc+0xd2>
        return 0;
    1806:	b8 00 00 00 00       	mov    $0x0,%eax
    180b:	eb 13                	jmp    1820 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    180d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1810:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1813:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1816:	8b 00                	mov    (%eax),%eax
    1818:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    181b:	e9 6d ff ff ff       	jmp    178d <malloc+0x52>
  }
}
    1820:	c9                   	leave  
    1821:	c3                   	ret    
