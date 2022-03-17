
_test_8:     file format elf32-i386


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

   if(getpinfo((struct pstat *)1000000) == -1)
    1015:	83 ec 0c             	sub    $0xc,%esp
    1018:	68 40 42 0f 00       	push   $0xf4240
    101d:	e8 56 03 00 00       	call   1378 <getpinfo>
    1022:	83 c4 10             	add    $0x10,%esp
    1025:	83 f8 ff             	cmp    $0xffffffff,%eax
    1028:	75 14                	jne    103e <main+0x3e>
   {
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    102a:	83 ec 08             	sub    $0x8,%esp
    102d:	68 23 18 00 00       	push   $0x1823
    1032:	6a 01                	push   $0x1
    1034:	e8 23 04 00 00       	call   145c <printf>
    1039:	83 c4 10             	add    $0x10,%esp
    103c:	eb 12                	jmp    1050 <main+0x50>
   }
   else
   {
    printf(1, "XV6_SCHEDULER\t FAILED\n");
    103e:	83 ec 08             	sub    $0x8,%esp
    1041:	68 3b 18 00 00       	push   $0x183b
    1046:	6a 01                	push   $0x1
    1048:	e8 0f 04 00 00       	call   145c <printf>
    104d:	83 c4 10             	add    $0x10,%esp
   }
   
   exit();
    1050:	e8 7b 02 00 00       	call   12d0 <exit>

00001055 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1055:	55                   	push   %ebp
    1056:	89 e5                	mov    %esp,%ebp
    1058:	57                   	push   %edi
    1059:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    105a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    105d:	8b 55 10             	mov    0x10(%ebp),%edx
    1060:	8b 45 0c             	mov    0xc(%ebp),%eax
    1063:	89 cb                	mov    %ecx,%ebx
    1065:	89 df                	mov    %ebx,%edi
    1067:	89 d1                	mov    %edx,%ecx
    1069:	fc                   	cld    
    106a:	f3 aa                	rep stos %al,%es:(%edi)
    106c:	89 ca                	mov    %ecx,%edx
    106e:	89 fb                	mov    %edi,%ebx
    1070:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1073:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1076:	90                   	nop
    1077:	5b                   	pop    %ebx
    1078:	5f                   	pop    %edi
    1079:	5d                   	pop    %ebp
    107a:	c3                   	ret    

0000107b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    107b:	f3 0f 1e fb          	endbr32 
    107f:	55                   	push   %ebp
    1080:	89 e5                	mov    %esp,%ebp
    1082:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1085:	8b 45 08             	mov    0x8(%ebp),%eax
    1088:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    108b:	90                   	nop
    108c:	8b 55 0c             	mov    0xc(%ebp),%edx
    108f:	8d 42 01             	lea    0x1(%edx),%eax
    1092:	89 45 0c             	mov    %eax,0xc(%ebp)
    1095:	8b 45 08             	mov    0x8(%ebp),%eax
    1098:	8d 48 01             	lea    0x1(%eax),%ecx
    109b:	89 4d 08             	mov    %ecx,0x8(%ebp)
    109e:	0f b6 12             	movzbl (%edx),%edx
    10a1:	88 10                	mov    %dl,(%eax)
    10a3:	0f b6 00             	movzbl (%eax),%eax
    10a6:	84 c0                	test   %al,%al
    10a8:	75 e2                	jne    108c <strcpy+0x11>
    ;
  return os;
    10aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10ad:	c9                   	leave  
    10ae:	c3                   	ret    

000010af <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10af:	f3 0f 1e fb          	endbr32 
    10b3:	55                   	push   %ebp
    10b4:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10b6:	eb 08                	jmp    10c0 <strcmp+0x11>
    p++, q++;
    10b8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10bc:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    10c0:	8b 45 08             	mov    0x8(%ebp),%eax
    10c3:	0f b6 00             	movzbl (%eax),%eax
    10c6:	84 c0                	test   %al,%al
    10c8:	74 10                	je     10da <strcmp+0x2b>
    10ca:	8b 45 08             	mov    0x8(%ebp),%eax
    10cd:	0f b6 10             	movzbl (%eax),%edx
    10d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d3:	0f b6 00             	movzbl (%eax),%eax
    10d6:	38 c2                	cmp    %al,%dl
    10d8:	74 de                	je     10b8 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    10da:	8b 45 08             	mov    0x8(%ebp),%eax
    10dd:	0f b6 00             	movzbl (%eax),%eax
    10e0:	0f b6 d0             	movzbl %al,%edx
    10e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e6:	0f b6 00             	movzbl (%eax),%eax
    10e9:	0f b6 c0             	movzbl %al,%eax
    10ec:	29 c2                	sub    %eax,%edx
    10ee:	89 d0                	mov    %edx,%eax
}
    10f0:	5d                   	pop    %ebp
    10f1:	c3                   	ret    

000010f2 <strlen>:

uint
strlen(const char *s)
{
    10f2:	f3 0f 1e fb          	endbr32 
    10f6:	55                   	push   %ebp
    10f7:	89 e5                	mov    %esp,%ebp
    10f9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1103:	eb 04                	jmp    1109 <strlen+0x17>
    1105:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1109:	8b 55 fc             	mov    -0x4(%ebp),%edx
    110c:	8b 45 08             	mov    0x8(%ebp),%eax
    110f:	01 d0                	add    %edx,%eax
    1111:	0f b6 00             	movzbl (%eax),%eax
    1114:	84 c0                	test   %al,%al
    1116:	75 ed                	jne    1105 <strlen+0x13>
    ;
  return n;
    1118:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    111b:	c9                   	leave  
    111c:	c3                   	ret    

0000111d <memset>:

void*
memset(void *dst, int c, uint n)
{
    111d:	f3 0f 1e fb          	endbr32 
    1121:	55                   	push   %ebp
    1122:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1124:	8b 45 10             	mov    0x10(%ebp),%eax
    1127:	50                   	push   %eax
    1128:	ff 75 0c             	pushl  0xc(%ebp)
    112b:	ff 75 08             	pushl  0x8(%ebp)
    112e:	e8 22 ff ff ff       	call   1055 <stosb>
    1133:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1136:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1139:	c9                   	leave  
    113a:	c3                   	ret    

0000113b <strchr>:

char*
strchr(const char *s, char c)
{
    113b:	f3 0f 1e fb          	endbr32 
    113f:	55                   	push   %ebp
    1140:	89 e5                	mov    %esp,%ebp
    1142:	83 ec 04             	sub    $0x4,%esp
    1145:	8b 45 0c             	mov    0xc(%ebp),%eax
    1148:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    114b:	eb 14                	jmp    1161 <strchr+0x26>
    if(*s == c)
    114d:	8b 45 08             	mov    0x8(%ebp),%eax
    1150:	0f b6 00             	movzbl (%eax),%eax
    1153:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1156:	75 05                	jne    115d <strchr+0x22>
      return (char*)s;
    1158:	8b 45 08             	mov    0x8(%ebp),%eax
    115b:	eb 13                	jmp    1170 <strchr+0x35>
  for(; *s; s++)
    115d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1161:	8b 45 08             	mov    0x8(%ebp),%eax
    1164:	0f b6 00             	movzbl (%eax),%eax
    1167:	84 c0                	test   %al,%al
    1169:	75 e2                	jne    114d <strchr+0x12>
  return 0;
    116b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1170:	c9                   	leave  
    1171:	c3                   	ret    

00001172 <gets>:

char*
gets(char *buf, int max)
{
    1172:	f3 0f 1e fb          	endbr32 
    1176:	55                   	push   %ebp
    1177:	89 e5                	mov    %esp,%ebp
    1179:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    117c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1183:	eb 42                	jmp    11c7 <gets+0x55>
    cc = read(0, &c, 1);
    1185:	83 ec 04             	sub    $0x4,%esp
    1188:	6a 01                	push   $0x1
    118a:	8d 45 ef             	lea    -0x11(%ebp),%eax
    118d:	50                   	push   %eax
    118e:	6a 00                	push   $0x0
    1190:	e8 53 01 00 00       	call   12e8 <read>
    1195:	83 c4 10             	add    $0x10,%esp
    1198:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    119b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    119f:	7e 33                	jle    11d4 <gets+0x62>
      break;
    buf[i++] = c;
    11a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a4:	8d 50 01             	lea    0x1(%eax),%edx
    11a7:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11aa:	89 c2                	mov    %eax,%edx
    11ac:	8b 45 08             	mov    0x8(%ebp),%eax
    11af:	01 c2                	add    %eax,%edx
    11b1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11b5:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11b7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11bb:	3c 0a                	cmp    $0xa,%al
    11bd:	74 16                	je     11d5 <gets+0x63>
    11bf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c3:	3c 0d                	cmp    $0xd,%al
    11c5:	74 0e                	je     11d5 <gets+0x63>
  for(i=0; i+1 < max; ){
    11c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ca:	83 c0 01             	add    $0x1,%eax
    11cd:	39 45 0c             	cmp    %eax,0xc(%ebp)
    11d0:	7f b3                	jg     1185 <gets+0x13>
    11d2:	eb 01                	jmp    11d5 <gets+0x63>
      break;
    11d4:	90                   	nop
      break;
  }
  buf[i] = '\0';
    11d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11d8:	8b 45 08             	mov    0x8(%ebp),%eax
    11db:	01 d0                	add    %edx,%eax
    11dd:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11e3:	c9                   	leave  
    11e4:	c3                   	ret    

000011e5 <stat>:

int
stat(const char *n, struct stat *st)
{
    11e5:	f3 0f 1e fb          	endbr32 
    11e9:	55                   	push   %ebp
    11ea:	89 e5                	mov    %esp,%ebp
    11ec:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11ef:	83 ec 08             	sub    $0x8,%esp
    11f2:	6a 00                	push   $0x0
    11f4:	ff 75 08             	pushl  0x8(%ebp)
    11f7:	e8 14 01 00 00       	call   1310 <open>
    11fc:	83 c4 10             	add    $0x10,%esp
    11ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1202:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1206:	79 07                	jns    120f <stat+0x2a>
    return -1;
    1208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    120d:	eb 25                	jmp    1234 <stat+0x4f>
  r = fstat(fd, st);
    120f:	83 ec 08             	sub    $0x8,%esp
    1212:	ff 75 0c             	pushl  0xc(%ebp)
    1215:	ff 75 f4             	pushl  -0xc(%ebp)
    1218:	e8 0b 01 00 00       	call   1328 <fstat>
    121d:	83 c4 10             	add    $0x10,%esp
    1220:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1223:	83 ec 0c             	sub    $0xc,%esp
    1226:	ff 75 f4             	pushl  -0xc(%ebp)
    1229:	e8 ca 00 00 00       	call   12f8 <close>
    122e:	83 c4 10             	add    $0x10,%esp
  return r;
    1231:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1234:	c9                   	leave  
    1235:	c3                   	ret    

00001236 <atoi>:

int
atoi(const char *s)
{
    1236:	f3 0f 1e fb          	endbr32 
    123a:	55                   	push   %ebp
    123b:	89 e5                	mov    %esp,%ebp
    123d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1240:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1247:	eb 25                	jmp    126e <atoi+0x38>
    n = n*10 + *s++ - '0';
    1249:	8b 55 fc             	mov    -0x4(%ebp),%edx
    124c:	89 d0                	mov    %edx,%eax
    124e:	c1 e0 02             	shl    $0x2,%eax
    1251:	01 d0                	add    %edx,%eax
    1253:	01 c0                	add    %eax,%eax
    1255:	89 c1                	mov    %eax,%ecx
    1257:	8b 45 08             	mov    0x8(%ebp),%eax
    125a:	8d 50 01             	lea    0x1(%eax),%edx
    125d:	89 55 08             	mov    %edx,0x8(%ebp)
    1260:	0f b6 00             	movzbl (%eax),%eax
    1263:	0f be c0             	movsbl %al,%eax
    1266:	01 c8                	add    %ecx,%eax
    1268:	83 e8 30             	sub    $0x30,%eax
    126b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    126e:	8b 45 08             	mov    0x8(%ebp),%eax
    1271:	0f b6 00             	movzbl (%eax),%eax
    1274:	3c 2f                	cmp    $0x2f,%al
    1276:	7e 0a                	jle    1282 <atoi+0x4c>
    1278:	8b 45 08             	mov    0x8(%ebp),%eax
    127b:	0f b6 00             	movzbl (%eax),%eax
    127e:	3c 39                	cmp    $0x39,%al
    1280:	7e c7                	jle    1249 <atoi+0x13>
  return n;
    1282:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1285:	c9                   	leave  
    1286:	c3                   	ret    

00001287 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1287:	f3 0f 1e fb          	endbr32 
    128b:	55                   	push   %ebp
    128c:	89 e5                	mov    %esp,%ebp
    128e:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1297:	8b 45 0c             	mov    0xc(%ebp),%eax
    129a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    129d:	eb 17                	jmp    12b6 <memmove+0x2f>
    *dst++ = *src++;
    129f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12a2:	8d 42 01             	lea    0x1(%edx),%eax
    12a5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ab:	8d 48 01             	lea    0x1(%eax),%ecx
    12ae:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    12b1:	0f b6 12             	movzbl (%edx),%edx
    12b4:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    12b6:	8b 45 10             	mov    0x10(%ebp),%eax
    12b9:	8d 50 ff             	lea    -0x1(%eax),%edx
    12bc:	89 55 10             	mov    %edx,0x10(%ebp)
    12bf:	85 c0                	test   %eax,%eax
    12c1:	7f dc                	jg     129f <memmove+0x18>
  return vdst;
    12c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12c6:	c9                   	leave  
    12c7:	c3                   	ret    

000012c8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12c8:	b8 01 00 00 00       	mov    $0x1,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <exit>:
SYSCALL(exit)
    12d0:	b8 02 00 00 00       	mov    $0x2,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <wait>:
SYSCALL(wait)
    12d8:	b8 03 00 00 00       	mov    $0x3,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <pipe>:
SYSCALL(pipe)
    12e0:	b8 04 00 00 00       	mov    $0x4,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <read>:
SYSCALL(read)
    12e8:	b8 05 00 00 00       	mov    $0x5,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <write>:
SYSCALL(write)
    12f0:	b8 10 00 00 00       	mov    $0x10,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <close>:
SYSCALL(close)
    12f8:	b8 15 00 00 00       	mov    $0x15,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <kill>:
SYSCALL(kill)
    1300:	b8 06 00 00 00       	mov    $0x6,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <exec>:
SYSCALL(exec)
    1308:	b8 07 00 00 00       	mov    $0x7,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <open>:
SYSCALL(open)
    1310:	b8 0f 00 00 00       	mov    $0xf,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <mknod>:
SYSCALL(mknod)
    1318:	b8 11 00 00 00       	mov    $0x11,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <unlink>:
SYSCALL(unlink)
    1320:	b8 12 00 00 00       	mov    $0x12,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <fstat>:
SYSCALL(fstat)
    1328:	b8 08 00 00 00       	mov    $0x8,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <link>:
SYSCALL(link)
    1330:	b8 13 00 00 00       	mov    $0x13,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <mkdir>:
SYSCALL(mkdir)
    1338:	b8 14 00 00 00       	mov    $0x14,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <chdir>:
SYSCALL(chdir)
    1340:	b8 09 00 00 00       	mov    $0x9,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <dup>:
SYSCALL(dup)
    1348:	b8 0a 00 00 00       	mov    $0xa,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <getpid>:
SYSCALL(getpid)
    1350:	b8 0b 00 00 00       	mov    $0xb,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <sbrk>:
SYSCALL(sbrk)
    1358:	b8 0c 00 00 00       	mov    $0xc,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <sleep>:
SYSCALL(sleep)
    1360:	b8 0d 00 00 00       	mov    $0xd,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <uptime>:
SYSCALL(uptime)
    1368:	b8 0e 00 00 00       	mov    $0xe,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <settickets>:
SYSCALL(settickets)
    1370:	b8 16 00 00 00       	mov    $0x16,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <getpinfo>:
SYSCALL(getpinfo)
    1378:	b8 17 00 00 00       	mov    $0x17,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1380:	f3 0f 1e fb          	endbr32 
    1384:	55                   	push   %ebp
    1385:	89 e5                	mov    %esp,%ebp
    1387:	83 ec 18             	sub    $0x18,%esp
    138a:	8b 45 0c             	mov    0xc(%ebp),%eax
    138d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1390:	83 ec 04             	sub    $0x4,%esp
    1393:	6a 01                	push   $0x1
    1395:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1398:	50                   	push   %eax
    1399:	ff 75 08             	pushl  0x8(%ebp)
    139c:	e8 4f ff ff ff       	call   12f0 <write>
    13a1:	83 c4 10             	add    $0x10,%esp
}
    13a4:	90                   	nop
    13a5:	c9                   	leave  
    13a6:	c3                   	ret    

000013a7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13a7:	f3 0f 1e fb          	endbr32 
    13ab:	55                   	push   %ebp
    13ac:	89 e5                	mov    %esp,%ebp
    13ae:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13b8:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13bc:	74 17                	je     13d5 <printint+0x2e>
    13be:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13c2:	79 11                	jns    13d5 <printint+0x2e>
    neg = 1;
    13c4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ce:	f7 d8                	neg    %eax
    13d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13d3:	eb 06                	jmp    13db <printint+0x34>
  } else {
    x = xx;
    13d5:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13e2:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13e8:	ba 00 00 00 00       	mov    $0x0,%edx
    13ed:	f7 f1                	div    %ecx
    13ef:	89 d1                	mov    %edx,%ecx
    13f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f4:	8d 50 01             	lea    0x1(%eax),%edx
    13f7:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13fa:	0f b6 91 a0 1a 00 00 	movzbl 0x1aa0(%ecx),%edx
    1401:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1405:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1408:	8b 45 ec             	mov    -0x14(%ebp),%eax
    140b:	ba 00 00 00 00       	mov    $0x0,%edx
    1410:	f7 f1                	div    %ecx
    1412:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1415:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1419:	75 c7                	jne    13e2 <printint+0x3b>
  if(neg)
    141b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    141f:	74 2d                	je     144e <printint+0xa7>
    buf[i++] = '-';
    1421:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1424:	8d 50 01             	lea    0x1(%eax),%edx
    1427:	89 55 f4             	mov    %edx,-0xc(%ebp)
    142a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    142f:	eb 1d                	jmp    144e <printint+0xa7>
    putc(fd, buf[i]);
    1431:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1434:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1437:	01 d0                	add    %edx,%eax
    1439:	0f b6 00             	movzbl (%eax),%eax
    143c:	0f be c0             	movsbl %al,%eax
    143f:	83 ec 08             	sub    $0x8,%esp
    1442:	50                   	push   %eax
    1443:	ff 75 08             	pushl  0x8(%ebp)
    1446:	e8 35 ff ff ff       	call   1380 <putc>
    144b:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    144e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1452:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1456:	79 d9                	jns    1431 <printint+0x8a>
}
    1458:	90                   	nop
    1459:	90                   	nop
    145a:	c9                   	leave  
    145b:	c3                   	ret    

0000145c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    145c:	f3 0f 1e fb          	endbr32 
    1460:	55                   	push   %ebp
    1461:	89 e5                	mov    %esp,%ebp
    1463:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1466:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    146d:	8d 45 0c             	lea    0xc(%ebp),%eax
    1470:	83 c0 04             	add    $0x4,%eax
    1473:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1476:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    147d:	e9 59 01 00 00       	jmp    15db <printf+0x17f>
    c = fmt[i] & 0xff;
    1482:	8b 55 0c             	mov    0xc(%ebp),%edx
    1485:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1488:	01 d0                	add    %edx,%eax
    148a:	0f b6 00             	movzbl (%eax),%eax
    148d:	0f be c0             	movsbl %al,%eax
    1490:	25 ff 00 00 00       	and    $0xff,%eax
    1495:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1498:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    149c:	75 2c                	jne    14ca <printf+0x6e>
      if(c == '%'){
    149e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14a2:	75 0c                	jne    14b0 <printf+0x54>
        state = '%';
    14a4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14ab:	e9 27 01 00 00       	jmp    15d7 <printf+0x17b>
      } else {
        putc(fd, c);
    14b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14b3:	0f be c0             	movsbl %al,%eax
    14b6:	83 ec 08             	sub    $0x8,%esp
    14b9:	50                   	push   %eax
    14ba:	ff 75 08             	pushl  0x8(%ebp)
    14bd:	e8 be fe ff ff       	call   1380 <putc>
    14c2:	83 c4 10             	add    $0x10,%esp
    14c5:	e9 0d 01 00 00       	jmp    15d7 <printf+0x17b>
      }
    } else if(state == '%'){
    14ca:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14ce:	0f 85 03 01 00 00    	jne    15d7 <printf+0x17b>
      if(c == 'd'){
    14d4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14d8:	75 1e                	jne    14f8 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    14da:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14dd:	8b 00                	mov    (%eax),%eax
    14df:	6a 01                	push   $0x1
    14e1:	6a 0a                	push   $0xa
    14e3:	50                   	push   %eax
    14e4:	ff 75 08             	pushl  0x8(%ebp)
    14e7:	e8 bb fe ff ff       	call   13a7 <printint>
    14ec:	83 c4 10             	add    $0x10,%esp
        ap++;
    14ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14f3:	e9 d8 00 00 00       	jmp    15d0 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    14f8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    14fc:	74 06                	je     1504 <printf+0xa8>
    14fe:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1502:	75 1e                	jne    1522 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1504:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1507:	8b 00                	mov    (%eax),%eax
    1509:	6a 00                	push   $0x0
    150b:	6a 10                	push   $0x10
    150d:	50                   	push   %eax
    150e:	ff 75 08             	pushl  0x8(%ebp)
    1511:	e8 91 fe ff ff       	call   13a7 <printint>
    1516:	83 c4 10             	add    $0x10,%esp
        ap++;
    1519:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    151d:	e9 ae 00 00 00       	jmp    15d0 <printf+0x174>
      } else if(c == 's'){
    1522:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1526:	75 43                	jne    156b <printf+0x10f>
        s = (char*)*ap;
    1528:	8b 45 e8             	mov    -0x18(%ebp),%eax
    152b:	8b 00                	mov    (%eax),%eax
    152d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1530:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1534:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1538:	75 25                	jne    155f <printf+0x103>
          s = "(null)";
    153a:	c7 45 f4 52 18 00 00 	movl   $0x1852,-0xc(%ebp)
        while(*s != 0){
    1541:	eb 1c                	jmp    155f <printf+0x103>
          putc(fd, *s);
    1543:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1546:	0f b6 00             	movzbl (%eax),%eax
    1549:	0f be c0             	movsbl %al,%eax
    154c:	83 ec 08             	sub    $0x8,%esp
    154f:	50                   	push   %eax
    1550:	ff 75 08             	pushl  0x8(%ebp)
    1553:	e8 28 fe ff ff       	call   1380 <putc>
    1558:	83 c4 10             	add    $0x10,%esp
          s++;
    155b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    155f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1562:	0f b6 00             	movzbl (%eax),%eax
    1565:	84 c0                	test   %al,%al
    1567:	75 da                	jne    1543 <printf+0xe7>
    1569:	eb 65                	jmp    15d0 <printf+0x174>
        }
      } else if(c == 'c'){
    156b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    156f:	75 1d                	jne    158e <printf+0x132>
        putc(fd, *ap);
    1571:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1574:	8b 00                	mov    (%eax),%eax
    1576:	0f be c0             	movsbl %al,%eax
    1579:	83 ec 08             	sub    $0x8,%esp
    157c:	50                   	push   %eax
    157d:	ff 75 08             	pushl  0x8(%ebp)
    1580:	e8 fb fd ff ff       	call   1380 <putc>
    1585:	83 c4 10             	add    $0x10,%esp
        ap++;
    1588:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    158c:	eb 42                	jmp    15d0 <printf+0x174>
      } else if(c == '%'){
    158e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1592:	75 17                	jne    15ab <printf+0x14f>
        putc(fd, c);
    1594:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1597:	0f be c0             	movsbl %al,%eax
    159a:	83 ec 08             	sub    $0x8,%esp
    159d:	50                   	push   %eax
    159e:	ff 75 08             	pushl  0x8(%ebp)
    15a1:	e8 da fd ff ff       	call   1380 <putc>
    15a6:	83 c4 10             	add    $0x10,%esp
    15a9:	eb 25                	jmp    15d0 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15ab:	83 ec 08             	sub    $0x8,%esp
    15ae:	6a 25                	push   $0x25
    15b0:	ff 75 08             	pushl  0x8(%ebp)
    15b3:	e8 c8 fd ff ff       	call   1380 <putc>
    15b8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15be:	0f be c0             	movsbl %al,%eax
    15c1:	83 ec 08             	sub    $0x8,%esp
    15c4:	50                   	push   %eax
    15c5:	ff 75 08             	pushl  0x8(%ebp)
    15c8:	e8 b3 fd ff ff       	call   1380 <putc>
    15cd:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15d0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    15d7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15db:	8b 55 0c             	mov    0xc(%ebp),%edx
    15de:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15e1:	01 d0                	add    %edx,%eax
    15e3:	0f b6 00             	movzbl (%eax),%eax
    15e6:	84 c0                	test   %al,%al
    15e8:	0f 85 94 fe ff ff    	jne    1482 <printf+0x26>
    }
  }
}
    15ee:	90                   	nop
    15ef:	90                   	nop
    15f0:	c9                   	leave  
    15f1:	c3                   	ret    

000015f2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15f2:	f3 0f 1e fb          	endbr32 
    15f6:	55                   	push   %ebp
    15f7:	89 e5                	mov    %esp,%ebp
    15f9:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15fc:	8b 45 08             	mov    0x8(%ebp),%eax
    15ff:	83 e8 08             	sub    $0x8,%eax
    1602:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1605:	a1 bc 1a 00 00       	mov    0x1abc,%eax
    160a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    160d:	eb 24                	jmp    1633 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    160f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1612:	8b 00                	mov    (%eax),%eax
    1614:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1617:	72 12                	jb     162b <free+0x39>
    1619:	8b 45 f8             	mov    -0x8(%ebp),%eax
    161c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    161f:	77 24                	ja     1645 <free+0x53>
    1621:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1624:	8b 00                	mov    (%eax),%eax
    1626:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1629:	72 1a                	jb     1645 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    162b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    162e:	8b 00                	mov    (%eax),%eax
    1630:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1633:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1636:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1639:	76 d4                	jbe    160f <free+0x1d>
    163b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    163e:	8b 00                	mov    (%eax),%eax
    1640:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1643:	73 ca                	jae    160f <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1645:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1648:	8b 40 04             	mov    0x4(%eax),%eax
    164b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1652:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1655:	01 c2                	add    %eax,%edx
    1657:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165a:	8b 00                	mov    (%eax),%eax
    165c:	39 c2                	cmp    %eax,%edx
    165e:	75 24                	jne    1684 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1660:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1663:	8b 50 04             	mov    0x4(%eax),%edx
    1666:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1669:	8b 00                	mov    (%eax),%eax
    166b:	8b 40 04             	mov    0x4(%eax),%eax
    166e:	01 c2                	add    %eax,%edx
    1670:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1673:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1676:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1679:	8b 00                	mov    (%eax),%eax
    167b:	8b 10                	mov    (%eax),%edx
    167d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1680:	89 10                	mov    %edx,(%eax)
    1682:	eb 0a                	jmp    168e <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1684:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1687:	8b 10                	mov    (%eax),%edx
    1689:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    168e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1691:	8b 40 04             	mov    0x4(%eax),%eax
    1694:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    169b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169e:	01 d0                	add    %edx,%eax
    16a0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16a3:	75 20                	jne    16c5 <free+0xd3>
    p->s.size += bp->s.size;
    16a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a8:	8b 50 04             	mov    0x4(%eax),%edx
    16ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ae:	8b 40 04             	mov    0x4(%eax),%eax
    16b1:	01 c2                	add    %eax,%edx
    16b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16bc:	8b 10                	mov    (%eax),%edx
    16be:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c1:	89 10                	mov    %edx,(%eax)
    16c3:	eb 08                	jmp    16cd <free+0xdb>
  } else
    p->s.ptr = bp;
    16c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16cb:	89 10                	mov    %edx,(%eax)
  freep = p;
    16cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d0:	a3 bc 1a 00 00       	mov    %eax,0x1abc
}
    16d5:	90                   	nop
    16d6:	c9                   	leave  
    16d7:	c3                   	ret    

000016d8 <morecore>:

static Header*
morecore(uint nu)
{
    16d8:	f3 0f 1e fb          	endbr32 
    16dc:	55                   	push   %ebp
    16dd:	89 e5                	mov    %esp,%ebp
    16df:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16e2:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16e9:	77 07                	ja     16f2 <morecore+0x1a>
    nu = 4096;
    16eb:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    16f2:	8b 45 08             	mov    0x8(%ebp),%eax
    16f5:	c1 e0 03             	shl    $0x3,%eax
    16f8:	83 ec 0c             	sub    $0xc,%esp
    16fb:	50                   	push   %eax
    16fc:	e8 57 fc ff ff       	call   1358 <sbrk>
    1701:	83 c4 10             	add    $0x10,%esp
    1704:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1707:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    170b:	75 07                	jne    1714 <morecore+0x3c>
    return 0;
    170d:	b8 00 00 00 00       	mov    $0x0,%eax
    1712:	eb 26                	jmp    173a <morecore+0x62>
  hp = (Header*)p;
    1714:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1717:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    171a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    171d:	8b 55 08             	mov    0x8(%ebp),%edx
    1720:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1723:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1726:	83 c0 08             	add    $0x8,%eax
    1729:	83 ec 0c             	sub    $0xc,%esp
    172c:	50                   	push   %eax
    172d:	e8 c0 fe ff ff       	call   15f2 <free>
    1732:	83 c4 10             	add    $0x10,%esp
  return freep;
    1735:	a1 bc 1a 00 00       	mov    0x1abc,%eax
}
    173a:	c9                   	leave  
    173b:	c3                   	ret    

0000173c <malloc>:

void*
malloc(uint nbytes)
{
    173c:	f3 0f 1e fb          	endbr32 
    1740:	55                   	push   %ebp
    1741:	89 e5                	mov    %esp,%ebp
    1743:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1746:	8b 45 08             	mov    0x8(%ebp),%eax
    1749:	83 c0 07             	add    $0x7,%eax
    174c:	c1 e8 03             	shr    $0x3,%eax
    174f:	83 c0 01             	add    $0x1,%eax
    1752:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1755:	a1 bc 1a 00 00       	mov    0x1abc,%eax
    175a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    175d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1761:	75 23                	jne    1786 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1763:	c7 45 f0 b4 1a 00 00 	movl   $0x1ab4,-0x10(%ebp)
    176a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    176d:	a3 bc 1a 00 00       	mov    %eax,0x1abc
    1772:	a1 bc 1a 00 00       	mov    0x1abc,%eax
    1777:	a3 b4 1a 00 00       	mov    %eax,0x1ab4
    base.s.size = 0;
    177c:	c7 05 b8 1a 00 00 00 	movl   $0x0,0x1ab8
    1783:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1786:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1789:	8b 00                	mov    (%eax),%eax
    178b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    178e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1791:	8b 40 04             	mov    0x4(%eax),%eax
    1794:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1797:	77 4d                	ja     17e6 <malloc+0xaa>
      if(p->s.size == nunits)
    1799:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179c:	8b 40 04             	mov    0x4(%eax),%eax
    179f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17a2:	75 0c                	jne    17b0 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    17a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a7:	8b 10                	mov    (%eax),%edx
    17a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ac:	89 10                	mov    %edx,(%eax)
    17ae:	eb 26                	jmp    17d6 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    17b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b3:	8b 40 04             	mov    0x4(%eax),%eax
    17b6:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17b9:	89 c2                	mov    %eax,%edx
    17bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17be:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c4:	8b 40 04             	mov    0x4(%eax),%eax
    17c7:	c1 e0 03             	shl    $0x3,%eax
    17ca:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17d3:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d9:	a3 bc 1a 00 00       	mov    %eax,0x1abc
      return (void*)(p + 1);
    17de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e1:	83 c0 08             	add    $0x8,%eax
    17e4:	eb 3b                	jmp    1821 <malloc+0xe5>
    }
    if(p == freep)
    17e6:	a1 bc 1a 00 00       	mov    0x1abc,%eax
    17eb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    17ee:	75 1e                	jne    180e <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    17f0:	83 ec 0c             	sub    $0xc,%esp
    17f3:	ff 75 ec             	pushl  -0x14(%ebp)
    17f6:	e8 dd fe ff ff       	call   16d8 <morecore>
    17fb:	83 c4 10             	add    $0x10,%esp
    17fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1801:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1805:	75 07                	jne    180e <malloc+0xd2>
        return 0;
    1807:	b8 00 00 00 00       	mov    $0x0,%eax
    180c:	eb 13                	jmp    1821 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    180e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1811:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1814:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1817:	8b 00                	mov    (%eax),%eax
    1819:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    181c:	e9 6d ff ff ff       	jmp    178e <malloc+0x52>
  }
}
    1821:	c9                   	leave  
    1822:	c3                   	ret    
