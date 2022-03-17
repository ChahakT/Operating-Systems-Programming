
_test_3:     file format elf32-i386


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
  if(settickets(10) == 0)
    1015:	83 ec 0c             	sub    $0xc,%esp
    1018:	6a 0a                	push   $0xa
    101a:	e8 4d 03 00 00       	call   136c <settickets>
    101f:	83 c4 10             	add    $0x10,%esp
    1022:	85 c0                	test   %eax,%eax
    1024:	75 14                	jne    103a <main+0x3a>
  {
   printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    1026:	83 ec 08             	sub    $0x8,%esp
    1029:	68 1f 18 00 00       	push   $0x181f
    102e:	6a 01                	push   $0x1
    1030:	e8 23 04 00 00       	call   1458 <printf>
    1035:	83 c4 10             	add    $0x10,%esp
    1038:	eb 12                	jmp    104c <main+0x4c>
  }
  else
  {
   printf(1, "XV6_SCHEDULER\t FAILED\n");
    103a:	83 ec 08             	sub    $0x8,%esp
    103d:	68 37 18 00 00       	push   $0x1837
    1042:	6a 01                	push   $0x1
    1044:	e8 0f 04 00 00       	call   1458 <printf>
    1049:	83 c4 10             	add    $0x10,%esp
  }
   exit();
    104c:	e8 7b 02 00 00       	call   12cc <exit>

00001051 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1051:	55                   	push   %ebp
    1052:	89 e5                	mov    %esp,%ebp
    1054:	57                   	push   %edi
    1055:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1056:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1059:	8b 55 10             	mov    0x10(%ebp),%edx
    105c:	8b 45 0c             	mov    0xc(%ebp),%eax
    105f:	89 cb                	mov    %ecx,%ebx
    1061:	89 df                	mov    %ebx,%edi
    1063:	89 d1                	mov    %edx,%ecx
    1065:	fc                   	cld    
    1066:	f3 aa                	rep stos %al,%es:(%edi)
    1068:	89 ca                	mov    %ecx,%edx
    106a:	89 fb                	mov    %edi,%ebx
    106c:	89 5d 08             	mov    %ebx,0x8(%ebp)
    106f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1072:	90                   	nop
    1073:	5b                   	pop    %ebx
    1074:	5f                   	pop    %edi
    1075:	5d                   	pop    %ebp
    1076:	c3                   	ret    

00001077 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1077:	f3 0f 1e fb          	endbr32 
    107b:	55                   	push   %ebp
    107c:	89 e5                	mov    %esp,%ebp
    107e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1081:	8b 45 08             	mov    0x8(%ebp),%eax
    1084:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1087:	90                   	nop
    1088:	8b 55 0c             	mov    0xc(%ebp),%edx
    108b:	8d 42 01             	lea    0x1(%edx),%eax
    108e:	89 45 0c             	mov    %eax,0xc(%ebp)
    1091:	8b 45 08             	mov    0x8(%ebp),%eax
    1094:	8d 48 01             	lea    0x1(%eax),%ecx
    1097:	89 4d 08             	mov    %ecx,0x8(%ebp)
    109a:	0f b6 12             	movzbl (%edx),%edx
    109d:	88 10                	mov    %dl,(%eax)
    109f:	0f b6 00             	movzbl (%eax),%eax
    10a2:	84 c0                	test   %al,%al
    10a4:	75 e2                	jne    1088 <strcpy+0x11>
    ;
  return os;
    10a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10a9:	c9                   	leave  
    10aa:	c3                   	ret    

000010ab <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10ab:	f3 0f 1e fb          	endbr32 
    10af:	55                   	push   %ebp
    10b0:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10b2:	eb 08                	jmp    10bc <strcmp+0x11>
    p++, q++;
    10b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10b8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    10bc:	8b 45 08             	mov    0x8(%ebp),%eax
    10bf:	0f b6 00             	movzbl (%eax),%eax
    10c2:	84 c0                	test   %al,%al
    10c4:	74 10                	je     10d6 <strcmp+0x2b>
    10c6:	8b 45 08             	mov    0x8(%ebp),%eax
    10c9:	0f b6 10             	movzbl (%eax),%edx
    10cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    10cf:	0f b6 00             	movzbl (%eax),%eax
    10d2:	38 c2                	cmp    %al,%dl
    10d4:	74 de                	je     10b4 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    10d6:	8b 45 08             	mov    0x8(%ebp),%eax
    10d9:	0f b6 00             	movzbl (%eax),%eax
    10dc:	0f b6 d0             	movzbl %al,%edx
    10df:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e2:	0f b6 00             	movzbl (%eax),%eax
    10e5:	0f b6 c0             	movzbl %al,%eax
    10e8:	29 c2                	sub    %eax,%edx
    10ea:	89 d0                	mov    %edx,%eax
}
    10ec:	5d                   	pop    %ebp
    10ed:	c3                   	ret    

000010ee <strlen>:

uint
strlen(const char *s)
{
    10ee:	f3 0f 1e fb          	endbr32 
    10f2:	55                   	push   %ebp
    10f3:	89 e5                	mov    %esp,%ebp
    10f5:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10ff:	eb 04                	jmp    1105 <strlen+0x17>
    1101:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1105:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1108:	8b 45 08             	mov    0x8(%ebp),%eax
    110b:	01 d0                	add    %edx,%eax
    110d:	0f b6 00             	movzbl (%eax),%eax
    1110:	84 c0                	test   %al,%al
    1112:	75 ed                	jne    1101 <strlen+0x13>
    ;
  return n;
    1114:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1117:	c9                   	leave  
    1118:	c3                   	ret    

00001119 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1119:	f3 0f 1e fb          	endbr32 
    111d:	55                   	push   %ebp
    111e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1120:	8b 45 10             	mov    0x10(%ebp),%eax
    1123:	50                   	push   %eax
    1124:	ff 75 0c             	pushl  0xc(%ebp)
    1127:	ff 75 08             	pushl  0x8(%ebp)
    112a:	e8 22 ff ff ff       	call   1051 <stosb>
    112f:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1132:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1135:	c9                   	leave  
    1136:	c3                   	ret    

00001137 <strchr>:

char*
strchr(const char *s, char c)
{
    1137:	f3 0f 1e fb          	endbr32 
    113b:	55                   	push   %ebp
    113c:	89 e5                	mov    %esp,%ebp
    113e:	83 ec 04             	sub    $0x4,%esp
    1141:	8b 45 0c             	mov    0xc(%ebp),%eax
    1144:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1147:	eb 14                	jmp    115d <strchr+0x26>
    if(*s == c)
    1149:	8b 45 08             	mov    0x8(%ebp),%eax
    114c:	0f b6 00             	movzbl (%eax),%eax
    114f:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1152:	75 05                	jne    1159 <strchr+0x22>
      return (char*)s;
    1154:	8b 45 08             	mov    0x8(%ebp),%eax
    1157:	eb 13                	jmp    116c <strchr+0x35>
  for(; *s; s++)
    1159:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    115d:	8b 45 08             	mov    0x8(%ebp),%eax
    1160:	0f b6 00             	movzbl (%eax),%eax
    1163:	84 c0                	test   %al,%al
    1165:	75 e2                	jne    1149 <strchr+0x12>
  return 0;
    1167:	b8 00 00 00 00       	mov    $0x0,%eax
}
    116c:	c9                   	leave  
    116d:	c3                   	ret    

0000116e <gets>:

char*
gets(char *buf, int max)
{
    116e:	f3 0f 1e fb          	endbr32 
    1172:	55                   	push   %ebp
    1173:	89 e5                	mov    %esp,%ebp
    1175:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1178:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    117f:	eb 42                	jmp    11c3 <gets+0x55>
    cc = read(0, &c, 1);
    1181:	83 ec 04             	sub    $0x4,%esp
    1184:	6a 01                	push   $0x1
    1186:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1189:	50                   	push   %eax
    118a:	6a 00                	push   $0x0
    118c:	e8 53 01 00 00       	call   12e4 <read>
    1191:	83 c4 10             	add    $0x10,%esp
    1194:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1197:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    119b:	7e 33                	jle    11d0 <gets+0x62>
      break;
    buf[i++] = c;
    119d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a0:	8d 50 01             	lea    0x1(%eax),%edx
    11a3:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11a6:	89 c2                	mov    %eax,%edx
    11a8:	8b 45 08             	mov    0x8(%ebp),%eax
    11ab:	01 c2                	add    %eax,%edx
    11ad:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11b1:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11b3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11b7:	3c 0a                	cmp    $0xa,%al
    11b9:	74 16                	je     11d1 <gets+0x63>
    11bb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11bf:	3c 0d                	cmp    $0xd,%al
    11c1:	74 0e                	je     11d1 <gets+0x63>
  for(i=0; i+1 < max; ){
    11c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11c6:	83 c0 01             	add    $0x1,%eax
    11c9:	39 45 0c             	cmp    %eax,0xc(%ebp)
    11cc:	7f b3                	jg     1181 <gets+0x13>
    11ce:	eb 01                	jmp    11d1 <gets+0x63>
      break;
    11d0:	90                   	nop
      break;
  }
  buf[i] = '\0';
    11d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11d4:	8b 45 08             	mov    0x8(%ebp),%eax
    11d7:	01 d0                	add    %edx,%eax
    11d9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11dc:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11df:	c9                   	leave  
    11e0:	c3                   	ret    

000011e1 <stat>:

int
stat(const char *n, struct stat *st)
{
    11e1:	f3 0f 1e fb          	endbr32 
    11e5:	55                   	push   %ebp
    11e6:	89 e5                	mov    %esp,%ebp
    11e8:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11eb:	83 ec 08             	sub    $0x8,%esp
    11ee:	6a 00                	push   $0x0
    11f0:	ff 75 08             	pushl  0x8(%ebp)
    11f3:	e8 14 01 00 00       	call   130c <open>
    11f8:	83 c4 10             	add    $0x10,%esp
    11fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    11fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1202:	79 07                	jns    120b <stat+0x2a>
    return -1;
    1204:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1209:	eb 25                	jmp    1230 <stat+0x4f>
  r = fstat(fd, st);
    120b:	83 ec 08             	sub    $0x8,%esp
    120e:	ff 75 0c             	pushl  0xc(%ebp)
    1211:	ff 75 f4             	pushl  -0xc(%ebp)
    1214:	e8 0b 01 00 00       	call   1324 <fstat>
    1219:	83 c4 10             	add    $0x10,%esp
    121c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    121f:	83 ec 0c             	sub    $0xc,%esp
    1222:	ff 75 f4             	pushl  -0xc(%ebp)
    1225:	e8 ca 00 00 00       	call   12f4 <close>
    122a:	83 c4 10             	add    $0x10,%esp
  return r;
    122d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1230:	c9                   	leave  
    1231:	c3                   	ret    

00001232 <atoi>:

int
atoi(const char *s)
{
    1232:	f3 0f 1e fb          	endbr32 
    1236:	55                   	push   %ebp
    1237:	89 e5                	mov    %esp,%ebp
    1239:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    123c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1243:	eb 25                	jmp    126a <atoi+0x38>
    n = n*10 + *s++ - '0';
    1245:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1248:	89 d0                	mov    %edx,%eax
    124a:	c1 e0 02             	shl    $0x2,%eax
    124d:	01 d0                	add    %edx,%eax
    124f:	01 c0                	add    %eax,%eax
    1251:	89 c1                	mov    %eax,%ecx
    1253:	8b 45 08             	mov    0x8(%ebp),%eax
    1256:	8d 50 01             	lea    0x1(%eax),%edx
    1259:	89 55 08             	mov    %edx,0x8(%ebp)
    125c:	0f b6 00             	movzbl (%eax),%eax
    125f:	0f be c0             	movsbl %al,%eax
    1262:	01 c8                	add    %ecx,%eax
    1264:	83 e8 30             	sub    $0x30,%eax
    1267:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    126a:	8b 45 08             	mov    0x8(%ebp),%eax
    126d:	0f b6 00             	movzbl (%eax),%eax
    1270:	3c 2f                	cmp    $0x2f,%al
    1272:	7e 0a                	jle    127e <atoi+0x4c>
    1274:	8b 45 08             	mov    0x8(%ebp),%eax
    1277:	0f b6 00             	movzbl (%eax),%eax
    127a:	3c 39                	cmp    $0x39,%al
    127c:	7e c7                	jle    1245 <atoi+0x13>
  return n;
    127e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1281:	c9                   	leave  
    1282:	c3                   	ret    

00001283 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1283:	f3 0f 1e fb          	endbr32 
    1287:	55                   	push   %ebp
    1288:	89 e5                	mov    %esp,%ebp
    128a:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    128d:	8b 45 08             	mov    0x8(%ebp),%eax
    1290:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1293:	8b 45 0c             	mov    0xc(%ebp),%eax
    1296:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1299:	eb 17                	jmp    12b2 <memmove+0x2f>
    *dst++ = *src++;
    129b:	8b 55 f8             	mov    -0x8(%ebp),%edx
    129e:	8d 42 01             	lea    0x1(%edx),%eax
    12a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a7:	8d 48 01             	lea    0x1(%eax),%ecx
    12aa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    12ad:	0f b6 12             	movzbl (%edx),%edx
    12b0:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    12b2:	8b 45 10             	mov    0x10(%ebp),%eax
    12b5:	8d 50 ff             	lea    -0x1(%eax),%edx
    12b8:	89 55 10             	mov    %edx,0x10(%ebp)
    12bb:	85 c0                	test   %eax,%eax
    12bd:	7f dc                	jg     129b <memmove+0x18>
  return vdst;
    12bf:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12c2:	c9                   	leave  
    12c3:	c3                   	ret    

000012c4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12c4:	b8 01 00 00 00       	mov    $0x1,%eax
    12c9:	cd 40                	int    $0x40
    12cb:	c3                   	ret    

000012cc <exit>:
SYSCALL(exit)
    12cc:	b8 02 00 00 00       	mov    $0x2,%eax
    12d1:	cd 40                	int    $0x40
    12d3:	c3                   	ret    

000012d4 <wait>:
SYSCALL(wait)
    12d4:	b8 03 00 00 00       	mov    $0x3,%eax
    12d9:	cd 40                	int    $0x40
    12db:	c3                   	ret    

000012dc <pipe>:
SYSCALL(pipe)
    12dc:	b8 04 00 00 00       	mov    $0x4,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <read>:
SYSCALL(read)
    12e4:	b8 05 00 00 00       	mov    $0x5,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <write>:
SYSCALL(write)
    12ec:	b8 10 00 00 00       	mov    $0x10,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <close>:
SYSCALL(close)
    12f4:	b8 15 00 00 00       	mov    $0x15,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <kill>:
SYSCALL(kill)
    12fc:	b8 06 00 00 00       	mov    $0x6,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <exec>:
SYSCALL(exec)
    1304:	b8 07 00 00 00       	mov    $0x7,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <open>:
SYSCALL(open)
    130c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <mknod>:
SYSCALL(mknod)
    1314:	b8 11 00 00 00       	mov    $0x11,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <unlink>:
SYSCALL(unlink)
    131c:	b8 12 00 00 00       	mov    $0x12,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <fstat>:
SYSCALL(fstat)
    1324:	b8 08 00 00 00       	mov    $0x8,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <link>:
SYSCALL(link)
    132c:	b8 13 00 00 00       	mov    $0x13,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <mkdir>:
SYSCALL(mkdir)
    1334:	b8 14 00 00 00       	mov    $0x14,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <chdir>:
SYSCALL(chdir)
    133c:	b8 09 00 00 00       	mov    $0x9,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <dup>:
SYSCALL(dup)
    1344:	b8 0a 00 00 00       	mov    $0xa,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <getpid>:
SYSCALL(getpid)
    134c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <sbrk>:
SYSCALL(sbrk)
    1354:	b8 0c 00 00 00       	mov    $0xc,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <sleep>:
SYSCALL(sleep)
    135c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <uptime>:
SYSCALL(uptime)
    1364:	b8 0e 00 00 00       	mov    $0xe,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <settickets>:
SYSCALL(settickets)
    136c:	b8 16 00 00 00       	mov    $0x16,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <getpinfo>:
SYSCALL(getpinfo)
    1374:	b8 17 00 00 00       	mov    $0x17,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    137c:	f3 0f 1e fb          	endbr32 
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	83 ec 18             	sub    $0x18,%esp
    1386:	8b 45 0c             	mov    0xc(%ebp),%eax
    1389:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    138c:	83 ec 04             	sub    $0x4,%esp
    138f:	6a 01                	push   $0x1
    1391:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1394:	50                   	push   %eax
    1395:	ff 75 08             	pushl  0x8(%ebp)
    1398:	e8 4f ff ff ff       	call   12ec <write>
    139d:	83 c4 10             	add    $0x10,%esp
}
    13a0:	90                   	nop
    13a1:	c9                   	leave  
    13a2:	c3                   	ret    

000013a3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13a3:	f3 0f 1e fb          	endbr32 
    13a7:	55                   	push   %ebp
    13a8:	89 e5                	mov    %esp,%ebp
    13aa:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13b4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13b8:	74 17                	je     13d1 <printint+0x2e>
    13ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13be:	79 11                	jns    13d1 <printint+0x2e>
    neg = 1;
    13c0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13c7:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ca:	f7 d8                	neg    %eax
    13cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13cf:	eb 06                	jmp    13d7 <printint+0x34>
  } else {
    x = xx;
    13d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13de:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13e4:	ba 00 00 00 00       	mov    $0x0,%edx
    13e9:	f7 f1                	div    %ecx
    13eb:	89 d1                	mov    %edx,%ecx
    13ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f0:	8d 50 01             	lea    0x1(%eax),%edx
    13f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13f6:	0f b6 91 9c 1a 00 00 	movzbl 0x1a9c(%ecx),%edx
    13fd:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1401:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1404:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1407:	ba 00 00 00 00       	mov    $0x0,%edx
    140c:	f7 f1                	div    %ecx
    140e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1411:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1415:	75 c7                	jne    13de <printint+0x3b>
  if(neg)
    1417:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    141b:	74 2d                	je     144a <printint+0xa7>
    buf[i++] = '-';
    141d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1420:	8d 50 01             	lea    0x1(%eax),%edx
    1423:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1426:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    142b:	eb 1d                	jmp    144a <printint+0xa7>
    putc(fd, buf[i]);
    142d:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1430:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1433:	01 d0                	add    %edx,%eax
    1435:	0f b6 00             	movzbl (%eax),%eax
    1438:	0f be c0             	movsbl %al,%eax
    143b:	83 ec 08             	sub    $0x8,%esp
    143e:	50                   	push   %eax
    143f:	ff 75 08             	pushl  0x8(%ebp)
    1442:	e8 35 ff ff ff       	call   137c <putc>
    1447:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    144a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    144e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1452:	79 d9                	jns    142d <printint+0x8a>
}
    1454:	90                   	nop
    1455:	90                   	nop
    1456:	c9                   	leave  
    1457:	c3                   	ret    

00001458 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1458:	f3 0f 1e fb          	endbr32 
    145c:	55                   	push   %ebp
    145d:	89 e5                	mov    %esp,%ebp
    145f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1462:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1469:	8d 45 0c             	lea    0xc(%ebp),%eax
    146c:	83 c0 04             	add    $0x4,%eax
    146f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1472:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1479:	e9 59 01 00 00       	jmp    15d7 <printf+0x17f>
    c = fmt[i] & 0xff;
    147e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1481:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1484:	01 d0                	add    %edx,%eax
    1486:	0f b6 00             	movzbl (%eax),%eax
    1489:	0f be c0             	movsbl %al,%eax
    148c:	25 ff 00 00 00       	and    $0xff,%eax
    1491:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1494:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1498:	75 2c                	jne    14c6 <printf+0x6e>
      if(c == '%'){
    149a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    149e:	75 0c                	jne    14ac <printf+0x54>
        state = '%';
    14a0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14a7:	e9 27 01 00 00       	jmp    15d3 <printf+0x17b>
      } else {
        putc(fd, c);
    14ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14af:	0f be c0             	movsbl %al,%eax
    14b2:	83 ec 08             	sub    $0x8,%esp
    14b5:	50                   	push   %eax
    14b6:	ff 75 08             	pushl  0x8(%ebp)
    14b9:	e8 be fe ff ff       	call   137c <putc>
    14be:	83 c4 10             	add    $0x10,%esp
    14c1:	e9 0d 01 00 00       	jmp    15d3 <printf+0x17b>
      }
    } else if(state == '%'){
    14c6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14ca:	0f 85 03 01 00 00    	jne    15d3 <printf+0x17b>
      if(c == 'd'){
    14d0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14d4:	75 1e                	jne    14f4 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    14d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14d9:	8b 00                	mov    (%eax),%eax
    14db:	6a 01                	push   $0x1
    14dd:	6a 0a                	push   $0xa
    14df:	50                   	push   %eax
    14e0:	ff 75 08             	pushl  0x8(%ebp)
    14e3:	e8 bb fe ff ff       	call   13a3 <printint>
    14e8:	83 c4 10             	add    $0x10,%esp
        ap++;
    14eb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14ef:	e9 d8 00 00 00       	jmp    15cc <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    14f4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    14f8:	74 06                	je     1500 <printf+0xa8>
    14fa:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    14fe:	75 1e                	jne    151e <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1500:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1503:	8b 00                	mov    (%eax),%eax
    1505:	6a 00                	push   $0x0
    1507:	6a 10                	push   $0x10
    1509:	50                   	push   %eax
    150a:	ff 75 08             	pushl  0x8(%ebp)
    150d:	e8 91 fe ff ff       	call   13a3 <printint>
    1512:	83 c4 10             	add    $0x10,%esp
        ap++;
    1515:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1519:	e9 ae 00 00 00       	jmp    15cc <printf+0x174>
      } else if(c == 's'){
    151e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1522:	75 43                	jne    1567 <printf+0x10f>
        s = (char*)*ap;
    1524:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1527:	8b 00                	mov    (%eax),%eax
    1529:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    152c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1530:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1534:	75 25                	jne    155b <printf+0x103>
          s = "(null)";
    1536:	c7 45 f4 4e 18 00 00 	movl   $0x184e,-0xc(%ebp)
        while(*s != 0){
    153d:	eb 1c                	jmp    155b <printf+0x103>
          putc(fd, *s);
    153f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1542:	0f b6 00             	movzbl (%eax),%eax
    1545:	0f be c0             	movsbl %al,%eax
    1548:	83 ec 08             	sub    $0x8,%esp
    154b:	50                   	push   %eax
    154c:	ff 75 08             	pushl  0x8(%ebp)
    154f:	e8 28 fe ff ff       	call   137c <putc>
    1554:	83 c4 10             	add    $0x10,%esp
          s++;
    1557:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    155b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155e:	0f b6 00             	movzbl (%eax),%eax
    1561:	84 c0                	test   %al,%al
    1563:	75 da                	jne    153f <printf+0xe7>
    1565:	eb 65                	jmp    15cc <printf+0x174>
        }
      } else if(c == 'c'){
    1567:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    156b:	75 1d                	jne    158a <printf+0x132>
        putc(fd, *ap);
    156d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1570:	8b 00                	mov    (%eax),%eax
    1572:	0f be c0             	movsbl %al,%eax
    1575:	83 ec 08             	sub    $0x8,%esp
    1578:	50                   	push   %eax
    1579:	ff 75 08             	pushl  0x8(%ebp)
    157c:	e8 fb fd ff ff       	call   137c <putc>
    1581:	83 c4 10             	add    $0x10,%esp
        ap++;
    1584:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1588:	eb 42                	jmp    15cc <printf+0x174>
      } else if(c == '%'){
    158a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    158e:	75 17                	jne    15a7 <printf+0x14f>
        putc(fd, c);
    1590:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1593:	0f be c0             	movsbl %al,%eax
    1596:	83 ec 08             	sub    $0x8,%esp
    1599:	50                   	push   %eax
    159a:	ff 75 08             	pushl  0x8(%ebp)
    159d:	e8 da fd ff ff       	call   137c <putc>
    15a2:	83 c4 10             	add    $0x10,%esp
    15a5:	eb 25                	jmp    15cc <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15a7:	83 ec 08             	sub    $0x8,%esp
    15aa:	6a 25                	push   $0x25
    15ac:	ff 75 08             	pushl  0x8(%ebp)
    15af:	e8 c8 fd ff ff       	call   137c <putc>
    15b4:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ba:	0f be c0             	movsbl %al,%eax
    15bd:	83 ec 08             	sub    $0x8,%esp
    15c0:	50                   	push   %eax
    15c1:	ff 75 08             	pushl  0x8(%ebp)
    15c4:	e8 b3 fd ff ff       	call   137c <putc>
    15c9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15cc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    15d3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15d7:	8b 55 0c             	mov    0xc(%ebp),%edx
    15da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15dd:	01 d0                	add    %edx,%eax
    15df:	0f b6 00             	movzbl (%eax),%eax
    15e2:	84 c0                	test   %al,%al
    15e4:	0f 85 94 fe ff ff    	jne    147e <printf+0x26>
    }
  }
}
    15ea:	90                   	nop
    15eb:	90                   	nop
    15ec:	c9                   	leave  
    15ed:	c3                   	ret    

000015ee <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15ee:	f3 0f 1e fb          	endbr32 
    15f2:	55                   	push   %ebp
    15f3:	89 e5                	mov    %esp,%ebp
    15f5:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15f8:	8b 45 08             	mov    0x8(%ebp),%eax
    15fb:	83 e8 08             	sub    $0x8,%eax
    15fe:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1601:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    1606:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1609:	eb 24                	jmp    162f <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    160b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    160e:	8b 00                	mov    (%eax),%eax
    1610:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1613:	72 12                	jb     1627 <free+0x39>
    1615:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1618:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    161b:	77 24                	ja     1641 <free+0x53>
    161d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1620:	8b 00                	mov    (%eax),%eax
    1622:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1625:	72 1a                	jb     1641 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1627:	8b 45 fc             	mov    -0x4(%ebp),%eax
    162a:	8b 00                	mov    (%eax),%eax
    162c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    162f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1632:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1635:	76 d4                	jbe    160b <free+0x1d>
    1637:	8b 45 fc             	mov    -0x4(%ebp),%eax
    163a:	8b 00                	mov    (%eax),%eax
    163c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    163f:	73 ca                	jae    160b <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1641:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1644:	8b 40 04             	mov    0x4(%eax),%eax
    1647:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    164e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1651:	01 c2                	add    %eax,%edx
    1653:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1656:	8b 00                	mov    (%eax),%eax
    1658:	39 c2                	cmp    %eax,%edx
    165a:	75 24                	jne    1680 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    165c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    165f:	8b 50 04             	mov    0x4(%eax),%edx
    1662:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1665:	8b 00                	mov    (%eax),%eax
    1667:	8b 40 04             	mov    0x4(%eax),%eax
    166a:	01 c2                	add    %eax,%edx
    166c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    166f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1672:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1675:	8b 00                	mov    (%eax),%eax
    1677:	8b 10                	mov    (%eax),%edx
    1679:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167c:	89 10                	mov    %edx,(%eax)
    167e:	eb 0a                	jmp    168a <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1680:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1683:	8b 10                	mov    (%eax),%edx
    1685:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1688:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    168a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    168d:	8b 40 04             	mov    0x4(%eax),%eax
    1690:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1697:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169a:	01 d0                	add    %edx,%eax
    169c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    169f:	75 20                	jne    16c1 <free+0xd3>
    p->s.size += bp->s.size;
    16a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a4:	8b 50 04             	mov    0x4(%eax),%edx
    16a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16aa:	8b 40 04             	mov    0x4(%eax),%eax
    16ad:	01 c2                	add    %eax,%edx
    16af:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b8:	8b 10                	mov    (%eax),%edx
    16ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16bd:	89 10                	mov    %edx,(%eax)
    16bf:	eb 08                	jmp    16c9 <free+0xdb>
  } else
    p->s.ptr = bp;
    16c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c4:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16c7:	89 10                	mov    %edx,(%eax)
  freep = p;
    16c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cc:	a3 b8 1a 00 00       	mov    %eax,0x1ab8
}
    16d1:	90                   	nop
    16d2:	c9                   	leave  
    16d3:	c3                   	ret    

000016d4 <morecore>:

static Header*
morecore(uint nu)
{
    16d4:	f3 0f 1e fb          	endbr32 
    16d8:	55                   	push   %ebp
    16d9:	89 e5                	mov    %esp,%ebp
    16db:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16de:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16e5:	77 07                	ja     16ee <morecore+0x1a>
    nu = 4096;
    16e7:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    16ee:	8b 45 08             	mov    0x8(%ebp),%eax
    16f1:	c1 e0 03             	shl    $0x3,%eax
    16f4:	83 ec 0c             	sub    $0xc,%esp
    16f7:	50                   	push   %eax
    16f8:	e8 57 fc ff ff       	call   1354 <sbrk>
    16fd:	83 c4 10             	add    $0x10,%esp
    1700:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1703:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1707:	75 07                	jne    1710 <morecore+0x3c>
    return 0;
    1709:	b8 00 00 00 00       	mov    $0x0,%eax
    170e:	eb 26                	jmp    1736 <morecore+0x62>
  hp = (Header*)p;
    1710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1713:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1716:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1719:	8b 55 08             	mov    0x8(%ebp),%edx
    171c:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    171f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1722:	83 c0 08             	add    $0x8,%eax
    1725:	83 ec 0c             	sub    $0xc,%esp
    1728:	50                   	push   %eax
    1729:	e8 c0 fe ff ff       	call   15ee <free>
    172e:	83 c4 10             	add    $0x10,%esp
  return freep;
    1731:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
}
    1736:	c9                   	leave  
    1737:	c3                   	ret    

00001738 <malloc>:

void*
malloc(uint nbytes)
{
    1738:	f3 0f 1e fb          	endbr32 
    173c:	55                   	push   %ebp
    173d:	89 e5                	mov    %esp,%ebp
    173f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1742:	8b 45 08             	mov    0x8(%ebp),%eax
    1745:	83 c0 07             	add    $0x7,%eax
    1748:	c1 e8 03             	shr    $0x3,%eax
    174b:	83 c0 01             	add    $0x1,%eax
    174e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1751:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    1756:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1759:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    175d:	75 23                	jne    1782 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    175f:	c7 45 f0 b0 1a 00 00 	movl   $0x1ab0,-0x10(%ebp)
    1766:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1769:	a3 b8 1a 00 00       	mov    %eax,0x1ab8
    176e:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    1773:	a3 b0 1a 00 00       	mov    %eax,0x1ab0
    base.s.size = 0;
    1778:	c7 05 b4 1a 00 00 00 	movl   $0x0,0x1ab4
    177f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1782:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1785:	8b 00                	mov    (%eax),%eax
    1787:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    178a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178d:	8b 40 04             	mov    0x4(%eax),%eax
    1790:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1793:	77 4d                	ja     17e2 <malloc+0xaa>
      if(p->s.size == nunits)
    1795:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1798:	8b 40 04             	mov    0x4(%eax),%eax
    179b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    179e:	75 0c                	jne    17ac <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    17a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a3:	8b 10                	mov    (%eax),%edx
    17a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17a8:	89 10                	mov    %edx,(%eax)
    17aa:	eb 26                	jmp    17d2 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    17ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17af:	8b 40 04             	mov    0x4(%eax),%eax
    17b2:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17b5:	89 c2                	mov    %eax,%edx
    17b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ba:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c0:	8b 40 04             	mov    0x4(%eax),%eax
    17c3:	c1 e0 03             	shl    $0x3,%eax
    17c6:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cc:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17cf:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d5:	a3 b8 1a 00 00       	mov    %eax,0x1ab8
      return (void*)(p + 1);
    17da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17dd:	83 c0 08             	add    $0x8,%eax
    17e0:	eb 3b                	jmp    181d <malloc+0xe5>
    }
    if(p == freep)
    17e2:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    17e7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    17ea:	75 1e                	jne    180a <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    17ec:	83 ec 0c             	sub    $0xc,%esp
    17ef:	ff 75 ec             	pushl  -0x14(%ebp)
    17f2:	e8 dd fe ff ff       	call   16d4 <morecore>
    17f7:	83 c4 10             	add    $0x10,%esp
    17fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1801:	75 07                	jne    180a <malloc+0xd2>
        return 0;
    1803:	b8 00 00 00 00       	mov    $0x0,%eax
    1808:	eb 13                	jmp    181d <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    180a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1810:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1813:	8b 00                	mov    (%eax),%eax
    1815:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1818:	e9 6d ff ff ff       	jmp    178a <malloc+0x52>
  }
}
    181d:	c9                   	leave  
    181e:	c3                   	ret    
