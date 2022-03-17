
_test_7:     file format elf32-i386


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

   if(getpinfo((void *)0) == -1)
    1015:	83 ec 0c             	sub    $0xc,%esp
    1018:	6a 00                	push   $0x0
    101a:	e8 56 03 00 00       	call   1375 <getpinfo>
    101f:	83 c4 10             	add    $0x10,%esp
    1022:	83 f8 ff             	cmp    $0xffffffff,%eax
    1025:	75 14                	jne    103b <main+0x3b>
   {
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    1027:	83 ec 08             	sub    $0x8,%esp
    102a:	68 20 18 00 00       	push   $0x1820
    102f:	6a 01                	push   $0x1
    1031:	e8 23 04 00 00       	call   1459 <printf>
    1036:	83 c4 10             	add    $0x10,%esp
    1039:	eb 12                	jmp    104d <main+0x4d>
   }
   else
   {
    printf(1, "XV6_SCHEDULER\t FAILED\n");
    103b:	83 ec 08             	sub    $0x8,%esp
    103e:	68 38 18 00 00       	push   $0x1838
    1043:	6a 01                	push   $0x1
    1045:	e8 0f 04 00 00       	call   1459 <printf>
    104a:	83 c4 10             	add    $0x10,%esp
   }
   
   exit();
    104d:	e8 7b 02 00 00       	call   12cd <exit>

00001052 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1052:	55                   	push   %ebp
    1053:	89 e5                	mov    %esp,%ebp
    1055:	57                   	push   %edi
    1056:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1057:	8b 4d 08             	mov    0x8(%ebp),%ecx
    105a:	8b 55 10             	mov    0x10(%ebp),%edx
    105d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1060:	89 cb                	mov    %ecx,%ebx
    1062:	89 df                	mov    %ebx,%edi
    1064:	89 d1                	mov    %edx,%ecx
    1066:	fc                   	cld    
    1067:	f3 aa                	rep stos %al,%es:(%edi)
    1069:	89 ca                	mov    %ecx,%edx
    106b:	89 fb                	mov    %edi,%ebx
    106d:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1070:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1073:	90                   	nop
    1074:	5b                   	pop    %ebx
    1075:	5f                   	pop    %edi
    1076:	5d                   	pop    %ebp
    1077:	c3                   	ret    

00001078 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1078:	f3 0f 1e fb          	endbr32 
    107c:	55                   	push   %ebp
    107d:	89 e5                	mov    %esp,%ebp
    107f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1082:	8b 45 08             	mov    0x8(%ebp),%eax
    1085:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1088:	90                   	nop
    1089:	8b 55 0c             	mov    0xc(%ebp),%edx
    108c:	8d 42 01             	lea    0x1(%edx),%eax
    108f:	89 45 0c             	mov    %eax,0xc(%ebp)
    1092:	8b 45 08             	mov    0x8(%ebp),%eax
    1095:	8d 48 01             	lea    0x1(%eax),%ecx
    1098:	89 4d 08             	mov    %ecx,0x8(%ebp)
    109b:	0f b6 12             	movzbl (%edx),%edx
    109e:	88 10                	mov    %dl,(%eax)
    10a0:	0f b6 00             	movzbl (%eax),%eax
    10a3:	84 c0                	test   %al,%al
    10a5:	75 e2                	jne    1089 <strcpy+0x11>
    ;
  return os;
    10a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10aa:	c9                   	leave  
    10ab:	c3                   	ret    

000010ac <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10ac:	f3 0f 1e fb          	endbr32 
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10b3:	eb 08                	jmp    10bd <strcmp+0x11>
    p++, q++;
    10b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10b9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    10bd:	8b 45 08             	mov    0x8(%ebp),%eax
    10c0:	0f b6 00             	movzbl (%eax),%eax
    10c3:	84 c0                	test   %al,%al
    10c5:	74 10                	je     10d7 <strcmp+0x2b>
    10c7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ca:	0f b6 10             	movzbl (%eax),%edx
    10cd:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d0:	0f b6 00             	movzbl (%eax),%eax
    10d3:	38 c2                	cmp    %al,%dl
    10d5:	74 de                	je     10b5 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    10d7:	8b 45 08             	mov    0x8(%ebp),%eax
    10da:	0f b6 00             	movzbl (%eax),%eax
    10dd:	0f b6 d0             	movzbl %al,%edx
    10e0:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e3:	0f b6 00             	movzbl (%eax),%eax
    10e6:	0f b6 c0             	movzbl %al,%eax
    10e9:	29 c2                	sub    %eax,%edx
    10eb:	89 d0                	mov    %edx,%eax
}
    10ed:	5d                   	pop    %ebp
    10ee:	c3                   	ret    

000010ef <strlen>:

uint
strlen(const char *s)
{
    10ef:	f3 0f 1e fb          	endbr32 
    10f3:	55                   	push   %ebp
    10f4:	89 e5                	mov    %esp,%ebp
    10f6:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1100:	eb 04                	jmp    1106 <strlen+0x17>
    1102:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1106:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1109:	8b 45 08             	mov    0x8(%ebp),%eax
    110c:	01 d0                	add    %edx,%eax
    110e:	0f b6 00             	movzbl (%eax),%eax
    1111:	84 c0                	test   %al,%al
    1113:	75 ed                	jne    1102 <strlen+0x13>
    ;
  return n;
    1115:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1118:	c9                   	leave  
    1119:	c3                   	ret    

0000111a <memset>:

void*
memset(void *dst, int c, uint n)
{
    111a:	f3 0f 1e fb          	endbr32 
    111e:	55                   	push   %ebp
    111f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1121:	8b 45 10             	mov    0x10(%ebp),%eax
    1124:	50                   	push   %eax
    1125:	ff 75 0c             	pushl  0xc(%ebp)
    1128:	ff 75 08             	pushl  0x8(%ebp)
    112b:	e8 22 ff ff ff       	call   1052 <stosb>
    1130:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1133:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1136:	c9                   	leave  
    1137:	c3                   	ret    

00001138 <strchr>:

char*
strchr(const char *s, char c)
{
    1138:	f3 0f 1e fb          	endbr32 
    113c:	55                   	push   %ebp
    113d:	89 e5                	mov    %esp,%ebp
    113f:	83 ec 04             	sub    $0x4,%esp
    1142:	8b 45 0c             	mov    0xc(%ebp),%eax
    1145:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1148:	eb 14                	jmp    115e <strchr+0x26>
    if(*s == c)
    114a:	8b 45 08             	mov    0x8(%ebp),%eax
    114d:	0f b6 00             	movzbl (%eax),%eax
    1150:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1153:	75 05                	jne    115a <strchr+0x22>
      return (char*)s;
    1155:	8b 45 08             	mov    0x8(%ebp),%eax
    1158:	eb 13                	jmp    116d <strchr+0x35>
  for(; *s; s++)
    115a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    115e:	8b 45 08             	mov    0x8(%ebp),%eax
    1161:	0f b6 00             	movzbl (%eax),%eax
    1164:	84 c0                	test   %al,%al
    1166:	75 e2                	jne    114a <strchr+0x12>
  return 0;
    1168:	b8 00 00 00 00       	mov    $0x0,%eax
}
    116d:	c9                   	leave  
    116e:	c3                   	ret    

0000116f <gets>:

char*
gets(char *buf, int max)
{
    116f:	f3 0f 1e fb          	endbr32 
    1173:	55                   	push   %ebp
    1174:	89 e5                	mov    %esp,%ebp
    1176:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1179:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1180:	eb 42                	jmp    11c4 <gets+0x55>
    cc = read(0, &c, 1);
    1182:	83 ec 04             	sub    $0x4,%esp
    1185:	6a 01                	push   $0x1
    1187:	8d 45 ef             	lea    -0x11(%ebp),%eax
    118a:	50                   	push   %eax
    118b:	6a 00                	push   $0x0
    118d:	e8 53 01 00 00       	call   12e5 <read>
    1192:	83 c4 10             	add    $0x10,%esp
    1195:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1198:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    119c:	7e 33                	jle    11d1 <gets+0x62>
      break;
    buf[i++] = c;
    119e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a1:	8d 50 01             	lea    0x1(%eax),%edx
    11a4:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11a7:	89 c2                	mov    %eax,%edx
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	01 c2                	add    %eax,%edx
    11ae:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11b2:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11b4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11b8:	3c 0a                	cmp    $0xa,%al
    11ba:	74 16                	je     11d2 <gets+0x63>
    11bc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c0:	3c 0d                	cmp    $0xd,%al
    11c2:	74 0e                	je     11d2 <gets+0x63>
  for(i=0; i+1 < max; ){
    11c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11c7:	83 c0 01             	add    $0x1,%eax
    11ca:	39 45 0c             	cmp    %eax,0xc(%ebp)
    11cd:	7f b3                	jg     1182 <gets+0x13>
    11cf:	eb 01                	jmp    11d2 <gets+0x63>
      break;
    11d1:	90                   	nop
      break;
  }
  buf[i] = '\0';
    11d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11d5:	8b 45 08             	mov    0x8(%ebp),%eax
    11d8:	01 d0                	add    %edx,%eax
    11da:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11dd:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11e0:	c9                   	leave  
    11e1:	c3                   	ret    

000011e2 <stat>:

int
stat(const char *n, struct stat *st)
{
    11e2:	f3 0f 1e fb          	endbr32 
    11e6:	55                   	push   %ebp
    11e7:	89 e5                	mov    %esp,%ebp
    11e9:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11ec:	83 ec 08             	sub    $0x8,%esp
    11ef:	6a 00                	push   $0x0
    11f1:	ff 75 08             	pushl  0x8(%ebp)
    11f4:	e8 14 01 00 00       	call   130d <open>
    11f9:	83 c4 10             	add    $0x10,%esp
    11fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    11ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1203:	79 07                	jns    120c <stat+0x2a>
    return -1;
    1205:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    120a:	eb 25                	jmp    1231 <stat+0x4f>
  r = fstat(fd, st);
    120c:	83 ec 08             	sub    $0x8,%esp
    120f:	ff 75 0c             	pushl  0xc(%ebp)
    1212:	ff 75 f4             	pushl  -0xc(%ebp)
    1215:	e8 0b 01 00 00       	call   1325 <fstat>
    121a:	83 c4 10             	add    $0x10,%esp
    121d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1220:	83 ec 0c             	sub    $0xc,%esp
    1223:	ff 75 f4             	pushl  -0xc(%ebp)
    1226:	e8 ca 00 00 00       	call   12f5 <close>
    122b:	83 c4 10             	add    $0x10,%esp
  return r;
    122e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1231:	c9                   	leave  
    1232:	c3                   	ret    

00001233 <atoi>:

int
atoi(const char *s)
{
    1233:	f3 0f 1e fb          	endbr32 
    1237:	55                   	push   %ebp
    1238:	89 e5                	mov    %esp,%ebp
    123a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    123d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1244:	eb 25                	jmp    126b <atoi+0x38>
    n = n*10 + *s++ - '0';
    1246:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1249:	89 d0                	mov    %edx,%eax
    124b:	c1 e0 02             	shl    $0x2,%eax
    124e:	01 d0                	add    %edx,%eax
    1250:	01 c0                	add    %eax,%eax
    1252:	89 c1                	mov    %eax,%ecx
    1254:	8b 45 08             	mov    0x8(%ebp),%eax
    1257:	8d 50 01             	lea    0x1(%eax),%edx
    125a:	89 55 08             	mov    %edx,0x8(%ebp)
    125d:	0f b6 00             	movzbl (%eax),%eax
    1260:	0f be c0             	movsbl %al,%eax
    1263:	01 c8                	add    %ecx,%eax
    1265:	83 e8 30             	sub    $0x30,%eax
    1268:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    126b:	8b 45 08             	mov    0x8(%ebp),%eax
    126e:	0f b6 00             	movzbl (%eax),%eax
    1271:	3c 2f                	cmp    $0x2f,%al
    1273:	7e 0a                	jle    127f <atoi+0x4c>
    1275:	8b 45 08             	mov    0x8(%ebp),%eax
    1278:	0f b6 00             	movzbl (%eax),%eax
    127b:	3c 39                	cmp    $0x39,%al
    127d:	7e c7                	jle    1246 <atoi+0x13>
  return n;
    127f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1282:	c9                   	leave  
    1283:	c3                   	ret    

00001284 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1284:	f3 0f 1e fb          	endbr32 
    1288:	55                   	push   %ebp
    1289:	89 e5                	mov    %esp,%ebp
    128b:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    128e:	8b 45 08             	mov    0x8(%ebp),%eax
    1291:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1294:	8b 45 0c             	mov    0xc(%ebp),%eax
    1297:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    129a:	eb 17                	jmp    12b3 <memmove+0x2f>
    *dst++ = *src++;
    129c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    129f:	8d 42 01             	lea    0x1(%edx),%eax
    12a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a8:	8d 48 01             	lea    0x1(%eax),%ecx
    12ab:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    12ae:	0f b6 12             	movzbl (%edx),%edx
    12b1:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    12b3:	8b 45 10             	mov    0x10(%ebp),%eax
    12b6:	8d 50 ff             	lea    -0x1(%eax),%edx
    12b9:	89 55 10             	mov    %edx,0x10(%ebp)
    12bc:	85 c0                	test   %eax,%eax
    12be:	7f dc                	jg     129c <memmove+0x18>
  return vdst;
    12c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12c3:	c9                   	leave  
    12c4:	c3                   	ret    

000012c5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12c5:	b8 01 00 00 00       	mov    $0x1,%eax
    12ca:	cd 40                	int    $0x40
    12cc:	c3                   	ret    

000012cd <exit>:
SYSCALL(exit)
    12cd:	b8 02 00 00 00       	mov    $0x2,%eax
    12d2:	cd 40                	int    $0x40
    12d4:	c3                   	ret    

000012d5 <wait>:
SYSCALL(wait)
    12d5:	b8 03 00 00 00       	mov    $0x3,%eax
    12da:	cd 40                	int    $0x40
    12dc:	c3                   	ret    

000012dd <pipe>:
SYSCALL(pipe)
    12dd:	b8 04 00 00 00       	mov    $0x4,%eax
    12e2:	cd 40                	int    $0x40
    12e4:	c3                   	ret    

000012e5 <read>:
SYSCALL(read)
    12e5:	b8 05 00 00 00       	mov    $0x5,%eax
    12ea:	cd 40                	int    $0x40
    12ec:	c3                   	ret    

000012ed <write>:
SYSCALL(write)
    12ed:	b8 10 00 00 00       	mov    $0x10,%eax
    12f2:	cd 40                	int    $0x40
    12f4:	c3                   	ret    

000012f5 <close>:
SYSCALL(close)
    12f5:	b8 15 00 00 00       	mov    $0x15,%eax
    12fa:	cd 40                	int    $0x40
    12fc:	c3                   	ret    

000012fd <kill>:
SYSCALL(kill)
    12fd:	b8 06 00 00 00       	mov    $0x6,%eax
    1302:	cd 40                	int    $0x40
    1304:	c3                   	ret    

00001305 <exec>:
SYSCALL(exec)
    1305:	b8 07 00 00 00       	mov    $0x7,%eax
    130a:	cd 40                	int    $0x40
    130c:	c3                   	ret    

0000130d <open>:
SYSCALL(open)
    130d:	b8 0f 00 00 00       	mov    $0xf,%eax
    1312:	cd 40                	int    $0x40
    1314:	c3                   	ret    

00001315 <mknod>:
SYSCALL(mknod)
    1315:	b8 11 00 00 00       	mov    $0x11,%eax
    131a:	cd 40                	int    $0x40
    131c:	c3                   	ret    

0000131d <unlink>:
SYSCALL(unlink)
    131d:	b8 12 00 00 00       	mov    $0x12,%eax
    1322:	cd 40                	int    $0x40
    1324:	c3                   	ret    

00001325 <fstat>:
SYSCALL(fstat)
    1325:	b8 08 00 00 00       	mov    $0x8,%eax
    132a:	cd 40                	int    $0x40
    132c:	c3                   	ret    

0000132d <link>:
SYSCALL(link)
    132d:	b8 13 00 00 00       	mov    $0x13,%eax
    1332:	cd 40                	int    $0x40
    1334:	c3                   	ret    

00001335 <mkdir>:
SYSCALL(mkdir)
    1335:	b8 14 00 00 00       	mov    $0x14,%eax
    133a:	cd 40                	int    $0x40
    133c:	c3                   	ret    

0000133d <chdir>:
SYSCALL(chdir)
    133d:	b8 09 00 00 00       	mov    $0x9,%eax
    1342:	cd 40                	int    $0x40
    1344:	c3                   	ret    

00001345 <dup>:
SYSCALL(dup)
    1345:	b8 0a 00 00 00       	mov    $0xa,%eax
    134a:	cd 40                	int    $0x40
    134c:	c3                   	ret    

0000134d <getpid>:
SYSCALL(getpid)
    134d:	b8 0b 00 00 00       	mov    $0xb,%eax
    1352:	cd 40                	int    $0x40
    1354:	c3                   	ret    

00001355 <sbrk>:
SYSCALL(sbrk)
    1355:	b8 0c 00 00 00       	mov    $0xc,%eax
    135a:	cd 40                	int    $0x40
    135c:	c3                   	ret    

0000135d <sleep>:
SYSCALL(sleep)
    135d:	b8 0d 00 00 00       	mov    $0xd,%eax
    1362:	cd 40                	int    $0x40
    1364:	c3                   	ret    

00001365 <uptime>:
SYSCALL(uptime)
    1365:	b8 0e 00 00 00       	mov    $0xe,%eax
    136a:	cd 40                	int    $0x40
    136c:	c3                   	ret    

0000136d <settickets>:
SYSCALL(settickets)
    136d:	b8 16 00 00 00       	mov    $0x16,%eax
    1372:	cd 40                	int    $0x40
    1374:	c3                   	ret    

00001375 <getpinfo>:
SYSCALL(getpinfo)
    1375:	b8 17 00 00 00       	mov    $0x17,%eax
    137a:	cd 40                	int    $0x40
    137c:	c3                   	ret    

0000137d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    137d:	f3 0f 1e fb          	endbr32 
    1381:	55                   	push   %ebp
    1382:	89 e5                	mov    %esp,%ebp
    1384:	83 ec 18             	sub    $0x18,%esp
    1387:	8b 45 0c             	mov    0xc(%ebp),%eax
    138a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    138d:	83 ec 04             	sub    $0x4,%esp
    1390:	6a 01                	push   $0x1
    1392:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1395:	50                   	push   %eax
    1396:	ff 75 08             	pushl  0x8(%ebp)
    1399:	e8 4f ff ff ff       	call   12ed <write>
    139e:	83 c4 10             	add    $0x10,%esp
}
    13a1:	90                   	nop
    13a2:	c9                   	leave  
    13a3:	c3                   	ret    

000013a4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13a4:	f3 0f 1e fb          	endbr32 
    13a8:	55                   	push   %ebp
    13a9:	89 e5                	mov    %esp,%ebp
    13ab:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13b5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13b9:	74 17                	je     13d2 <printint+0x2e>
    13bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13bf:	79 11                	jns    13d2 <printint+0x2e>
    neg = 1;
    13c1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13c8:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cb:	f7 d8                	neg    %eax
    13cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13d0:	eb 06                	jmp    13d8 <printint+0x34>
  } else {
    x = xx;
    13d2:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13df:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13e5:	ba 00 00 00 00       	mov    $0x0,%edx
    13ea:	f7 f1                	div    %ecx
    13ec:	89 d1                	mov    %edx,%ecx
    13ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f1:	8d 50 01             	lea    0x1(%eax),%edx
    13f4:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13f7:	0f b6 91 9c 1a 00 00 	movzbl 0x1a9c(%ecx),%edx
    13fe:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1402:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1405:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1408:	ba 00 00 00 00       	mov    $0x0,%edx
    140d:	f7 f1                	div    %ecx
    140f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1412:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1416:	75 c7                	jne    13df <printint+0x3b>
  if(neg)
    1418:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    141c:	74 2d                	je     144b <printint+0xa7>
    buf[i++] = '-';
    141e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1421:	8d 50 01             	lea    0x1(%eax),%edx
    1424:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1427:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    142c:	eb 1d                	jmp    144b <printint+0xa7>
    putc(fd, buf[i]);
    142e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1431:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1434:	01 d0                	add    %edx,%eax
    1436:	0f b6 00             	movzbl (%eax),%eax
    1439:	0f be c0             	movsbl %al,%eax
    143c:	83 ec 08             	sub    $0x8,%esp
    143f:	50                   	push   %eax
    1440:	ff 75 08             	pushl  0x8(%ebp)
    1443:	e8 35 ff ff ff       	call   137d <putc>
    1448:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    144b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    144f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1453:	79 d9                	jns    142e <printint+0x8a>
}
    1455:	90                   	nop
    1456:	90                   	nop
    1457:	c9                   	leave  
    1458:	c3                   	ret    

00001459 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1459:	f3 0f 1e fb          	endbr32 
    145d:	55                   	push   %ebp
    145e:	89 e5                	mov    %esp,%ebp
    1460:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1463:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    146a:	8d 45 0c             	lea    0xc(%ebp),%eax
    146d:	83 c0 04             	add    $0x4,%eax
    1470:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1473:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    147a:	e9 59 01 00 00       	jmp    15d8 <printf+0x17f>
    c = fmt[i] & 0xff;
    147f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1482:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1485:	01 d0                	add    %edx,%eax
    1487:	0f b6 00             	movzbl (%eax),%eax
    148a:	0f be c0             	movsbl %al,%eax
    148d:	25 ff 00 00 00       	and    $0xff,%eax
    1492:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1495:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1499:	75 2c                	jne    14c7 <printf+0x6e>
      if(c == '%'){
    149b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    149f:	75 0c                	jne    14ad <printf+0x54>
        state = '%';
    14a1:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14a8:	e9 27 01 00 00       	jmp    15d4 <printf+0x17b>
      } else {
        putc(fd, c);
    14ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14b0:	0f be c0             	movsbl %al,%eax
    14b3:	83 ec 08             	sub    $0x8,%esp
    14b6:	50                   	push   %eax
    14b7:	ff 75 08             	pushl  0x8(%ebp)
    14ba:	e8 be fe ff ff       	call   137d <putc>
    14bf:	83 c4 10             	add    $0x10,%esp
    14c2:	e9 0d 01 00 00       	jmp    15d4 <printf+0x17b>
      }
    } else if(state == '%'){
    14c7:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14cb:	0f 85 03 01 00 00    	jne    15d4 <printf+0x17b>
      if(c == 'd'){
    14d1:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14d5:	75 1e                	jne    14f5 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    14d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14da:	8b 00                	mov    (%eax),%eax
    14dc:	6a 01                	push   $0x1
    14de:	6a 0a                	push   $0xa
    14e0:	50                   	push   %eax
    14e1:	ff 75 08             	pushl  0x8(%ebp)
    14e4:	e8 bb fe ff ff       	call   13a4 <printint>
    14e9:	83 c4 10             	add    $0x10,%esp
        ap++;
    14ec:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14f0:	e9 d8 00 00 00       	jmp    15cd <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    14f5:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    14f9:	74 06                	je     1501 <printf+0xa8>
    14fb:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    14ff:	75 1e                	jne    151f <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1501:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1504:	8b 00                	mov    (%eax),%eax
    1506:	6a 00                	push   $0x0
    1508:	6a 10                	push   $0x10
    150a:	50                   	push   %eax
    150b:	ff 75 08             	pushl  0x8(%ebp)
    150e:	e8 91 fe ff ff       	call   13a4 <printint>
    1513:	83 c4 10             	add    $0x10,%esp
        ap++;
    1516:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    151a:	e9 ae 00 00 00       	jmp    15cd <printf+0x174>
      } else if(c == 's'){
    151f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1523:	75 43                	jne    1568 <printf+0x10f>
        s = (char*)*ap;
    1525:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1528:	8b 00                	mov    (%eax),%eax
    152a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    152d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1531:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1535:	75 25                	jne    155c <printf+0x103>
          s = "(null)";
    1537:	c7 45 f4 4f 18 00 00 	movl   $0x184f,-0xc(%ebp)
        while(*s != 0){
    153e:	eb 1c                	jmp    155c <printf+0x103>
          putc(fd, *s);
    1540:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1543:	0f b6 00             	movzbl (%eax),%eax
    1546:	0f be c0             	movsbl %al,%eax
    1549:	83 ec 08             	sub    $0x8,%esp
    154c:	50                   	push   %eax
    154d:	ff 75 08             	pushl  0x8(%ebp)
    1550:	e8 28 fe ff ff       	call   137d <putc>
    1555:	83 c4 10             	add    $0x10,%esp
          s++;
    1558:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    155c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155f:	0f b6 00             	movzbl (%eax),%eax
    1562:	84 c0                	test   %al,%al
    1564:	75 da                	jne    1540 <printf+0xe7>
    1566:	eb 65                	jmp    15cd <printf+0x174>
        }
      } else if(c == 'c'){
    1568:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    156c:	75 1d                	jne    158b <printf+0x132>
        putc(fd, *ap);
    156e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1571:	8b 00                	mov    (%eax),%eax
    1573:	0f be c0             	movsbl %al,%eax
    1576:	83 ec 08             	sub    $0x8,%esp
    1579:	50                   	push   %eax
    157a:	ff 75 08             	pushl  0x8(%ebp)
    157d:	e8 fb fd ff ff       	call   137d <putc>
    1582:	83 c4 10             	add    $0x10,%esp
        ap++;
    1585:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1589:	eb 42                	jmp    15cd <printf+0x174>
      } else if(c == '%'){
    158b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    158f:	75 17                	jne    15a8 <printf+0x14f>
        putc(fd, c);
    1591:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1594:	0f be c0             	movsbl %al,%eax
    1597:	83 ec 08             	sub    $0x8,%esp
    159a:	50                   	push   %eax
    159b:	ff 75 08             	pushl  0x8(%ebp)
    159e:	e8 da fd ff ff       	call   137d <putc>
    15a3:	83 c4 10             	add    $0x10,%esp
    15a6:	eb 25                	jmp    15cd <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15a8:	83 ec 08             	sub    $0x8,%esp
    15ab:	6a 25                	push   $0x25
    15ad:	ff 75 08             	pushl  0x8(%ebp)
    15b0:	e8 c8 fd ff ff       	call   137d <putc>
    15b5:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15bb:	0f be c0             	movsbl %al,%eax
    15be:	83 ec 08             	sub    $0x8,%esp
    15c1:	50                   	push   %eax
    15c2:	ff 75 08             	pushl  0x8(%ebp)
    15c5:	e8 b3 fd ff ff       	call   137d <putc>
    15ca:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15cd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    15d4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15d8:	8b 55 0c             	mov    0xc(%ebp),%edx
    15db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15de:	01 d0                	add    %edx,%eax
    15e0:	0f b6 00             	movzbl (%eax),%eax
    15e3:	84 c0                	test   %al,%al
    15e5:	0f 85 94 fe ff ff    	jne    147f <printf+0x26>
    }
  }
}
    15eb:	90                   	nop
    15ec:	90                   	nop
    15ed:	c9                   	leave  
    15ee:	c3                   	ret    

000015ef <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15ef:	f3 0f 1e fb          	endbr32 
    15f3:	55                   	push   %ebp
    15f4:	89 e5                	mov    %esp,%ebp
    15f6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15f9:	8b 45 08             	mov    0x8(%ebp),%eax
    15fc:	83 e8 08             	sub    $0x8,%eax
    15ff:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1602:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    1607:	89 45 fc             	mov    %eax,-0x4(%ebp)
    160a:	eb 24                	jmp    1630 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    160c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    160f:	8b 00                	mov    (%eax),%eax
    1611:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1614:	72 12                	jb     1628 <free+0x39>
    1616:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1619:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    161c:	77 24                	ja     1642 <free+0x53>
    161e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1621:	8b 00                	mov    (%eax),%eax
    1623:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1626:	72 1a                	jb     1642 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1628:	8b 45 fc             	mov    -0x4(%ebp),%eax
    162b:	8b 00                	mov    (%eax),%eax
    162d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1630:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1633:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1636:	76 d4                	jbe    160c <free+0x1d>
    1638:	8b 45 fc             	mov    -0x4(%ebp),%eax
    163b:	8b 00                	mov    (%eax),%eax
    163d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1640:	73 ca                	jae    160c <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1642:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1645:	8b 40 04             	mov    0x4(%eax),%eax
    1648:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    164f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1652:	01 c2                	add    %eax,%edx
    1654:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1657:	8b 00                	mov    (%eax),%eax
    1659:	39 c2                	cmp    %eax,%edx
    165b:	75 24                	jne    1681 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    165d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1660:	8b 50 04             	mov    0x4(%eax),%edx
    1663:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1666:	8b 00                	mov    (%eax),%eax
    1668:	8b 40 04             	mov    0x4(%eax),%eax
    166b:	01 c2                	add    %eax,%edx
    166d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1670:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1673:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1676:	8b 00                	mov    (%eax),%eax
    1678:	8b 10                	mov    (%eax),%edx
    167a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167d:	89 10                	mov    %edx,(%eax)
    167f:	eb 0a                	jmp    168b <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1681:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1684:	8b 10                	mov    (%eax),%edx
    1686:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1689:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    168b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    168e:	8b 40 04             	mov    0x4(%eax),%eax
    1691:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1698:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169b:	01 d0                	add    %edx,%eax
    169d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16a0:	75 20                	jne    16c2 <free+0xd3>
    p->s.size += bp->s.size;
    16a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a5:	8b 50 04             	mov    0x4(%eax),%edx
    16a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ab:	8b 40 04             	mov    0x4(%eax),%eax
    16ae:	01 c2                	add    %eax,%edx
    16b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b9:	8b 10                	mov    (%eax),%edx
    16bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16be:	89 10                	mov    %edx,(%eax)
    16c0:	eb 08                	jmp    16ca <free+0xdb>
  } else
    p->s.ptr = bp;
    16c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c5:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16c8:	89 10                	mov    %edx,(%eax)
  freep = p;
    16ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cd:	a3 b8 1a 00 00       	mov    %eax,0x1ab8
}
    16d2:	90                   	nop
    16d3:	c9                   	leave  
    16d4:	c3                   	ret    

000016d5 <morecore>:

static Header*
morecore(uint nu)
{
    16d5:	f3 0f 1e fb          	endbr32 
    16d9:	55                   	push   %ebp
    16da:	89 e5                	mov    %esp,%ebp
    16dc:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16df:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16e6:	77 07                	ja     16ef <morecore+0x1a>
    nu = 4096;
    16e8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    16ef:	8b 45 08             	mov    0x8(%ebp),%eax
    16f2:	c1 e0 03             	shl    $0x3,%eax
    16f5:	83 ec 0c             	sub    $0xc,%esp
    16f8:	50                   	push   %eax
    16f9:	e8 57 fc ff ff       	call   1355 <sbrk>
    16fe:	83 c4 10             	add    $0x10,%esp
    1701:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1704:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1708:	75 07                	jne    1711 <morecore+0x3c>
    return 0;
    170a:	b8 00 00 00 00       	mov    $0x0,%eax
    170f:	eb 26                	jmp    1737 <morecore+0x62>
  hp = (Header*)p;
    1711:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1714:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1717:	8b 45 f0             	mov    -0x10(%ebp),%eax
    171a:	8b 55 08             	mov    0x8(%ebp),%edx
    171d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1720:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1723:	83 c0 08             	add    $0x8,%eax
    1726:	83 ec 0c             	sub    $0xc,%esp
    1729:	50                   	push   %eax
    172a:	e8 c0 fe ff ff       	call   15ef <free>
    172f:	83 c4 10             	add    $0x10,%esp
  return freep;
    1732:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
}
    1737:	c9                   	leave  
    1738:	c3                   	ret    

00001739 <malloc>:

void*
malloc(uint nbytes)
{
    1739:	f3 0f 1e fb          	endbr32 
    173d:	55                   	push   %ebp
    173e:	89 e5                	mov    %esp,%ebp
    1740:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1743:	8b 45 08             	mov    0x8(%ebp),%eax
    1746:	83 c0 07             	add    $0x7,%eax
    1749:	c1 e8 03             	shr    $0x3,%eax
    174c:	83 c0 01             	add    $0x1,%eax
    174f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1752:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    1757:	89 45 f0             	mov    %eax,-0x10(%ebp)
    175a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    175e:	75 23                	jne    1783 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1760:	c7 45 f0 b0 1a 00 00 	movl   $0x1ab0,-0x10(%ebp)
    1767:	8b 45 f0             	mov    -0x10(%ebp),%eax
    176a:	a3 b8 1a 00 00       	mov    %eax,0x1ab8
    176f:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    1774:	a3 b0 1a 00 00       	mov    %eax,0x1ab0
    base.s.size = 0;
    1779:	c7 05 b4 1a 00 00 00 	movl   $0x0,0x1ab4
    1780:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1783:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1786:	8b 00                	mov    (%eax),%eax
    1788:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    178b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178e:	8b 40 04             	mov    0x4(%eax),%eax
    1791:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1794:	77 4d                	ja     17e3 <malloc+0xaa>
      if(p->s.size == nunits)
    1796:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1799:	8b 40 04             	mov    0x4(%eax),%eax
    179c:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    179f:	75 0c                	jne    17ad <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    17a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a4:	8b 10                	mov    (%eax),%edx
    17a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17a9:	89 10                	mov    %edx,(%eax)
    17ab:	eb 26                	jmp    17d3 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    17ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b0:	8b 40 04             	mov    0x4(%eax),%eax
    17b3:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17b6:	89 c2                	mov    %eax,%edx
    17b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c1:	8b 40 04             	mov    0x4(%eax),%eax
    17c4:	c1 e0 03             	shl    $0x3,%eax
    17c7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cd:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17d0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d6:	a3 b8 1a 00 00       	mov    %eax,0x1ab8
      return (void*)(p + 1);
    17db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17de:	83 c0 08             	add    $0x8,%eax
    17e1:	eb 3b                	jmp    181e <malloc+0xe5>
    }
    if(p == freep)
    17e3:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
    17e8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    17eb:	75 1e                	jne    180b <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    17ed:	83 ec 0c             	sub    $0xc,%esp
    17f0:	ff 75 ec             	pushl  -0x14(%ebp)
    17f3:	e8 dd fe ff ff       	call   16d5 <morecore>
    17f8:	83 c4 10             	add    $0x10,%esp
    17fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1802:	75 07                	jne    180b <malloc+0xd2>
        return 0;
    1804:	b8 00 00 00 00       	mov    $0x0,%eax
    1809:	eb 13                	jmp    181e <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    180b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1811:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1814:	8b 00                	mov    (%eax),%eax
    1816:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1819:	e9 6d ff ff ff       	jmp    178b <malloc+0x52>
  }
}
    181e:	c9                   	leave  
    181f:	c3                   	ret    
