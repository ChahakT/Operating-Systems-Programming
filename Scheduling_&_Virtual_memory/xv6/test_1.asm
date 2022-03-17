
_test_1:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
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
    1012:	81 ec 04 04 00 00    	sub    $0x404,%esp
   struct pstat st;
  
  if(getpinfo(&st) == 0)
    1018:	83 ec 0c             	sub    $0xc,%esp
    101b:	8d 85 f8 fb ff ff    	lea    -0x408(%ebp),%eax
    1021:	50                   	push   %eax
    1022:	e8 55 03 00 00       	call   137c <getpinfo>
    1027:	83 c4 10             	add    $0x10,%esp
    102a:	85 c0                	test   %eax,%eax
    102c:	75 14                	jne    1042 <main+0x42>
  {
   printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    102e:	83 ec 08             	sub    $0x8,%esp
    1031:	68 27 18 00 00       	push   $0x1827
    1036:	6a 01                	push   $0x1
    1038:	e8 23 04 00 00       	call   1460 <printf>
    103d:	83 c4 10             	add    $0x10,%esp
    1040:	eb 12                	jmp    1054 <main+0x54>
  }
  else
  {
   printf(1, "XV6_SCHEDULER\t FAILED\n");
    1042:	83 ec 08             	sub    $0x8,%esp
    1045:	68 3f 18 00 00       	push   $0x183f
    104a:	6a 01                	push   $0x1
    104c:	e8 0f 04 00 00       	call   1460 <printf>
    1051:	83 c4 10             	add    $0x10,%esp
  }
   exit();
    1054:	e8 7b 02 00 00       	call   12d4 <exit>

00001059 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1059:	55                   	push   %ebp
    105a:	89 e5                	mov    %esp,%ebp
    105c:	57                   	push   %edi
    105d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    105e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1061:	8b 55 10             	mov    0x10(%ebp),%edx
    1064:	8b 45 0c             	mov    0xc(%ebp),%eax
    1067:	89 cb                	mov    %ecx,%ebx
    1069:	89 df                	mov    %ebx,%edi
    106b:	89 d1                	mov    %edx,%ecx
    106d:	fc                   	cld    
    106e:	f3 aa                	rep stos %al,%es:(%edi)
    1070:	89 ca                	mov    %ecx,%edx
    1072:	89 fb                	mov    %edi,%ebx
    1074:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1077:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    107a:	90                   	nop
    107b:	5b                   	pop    %ebx
    107c:	5f                   	pop    %edi
    107d:	5d                   	pop    %ebp
    107e:	c3                   	ret    

0000107f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    107f:	f3 0f 1e fb          	endbr32 
    1083:	55                   	push   %ebp
    1084:	89 e5                	mov    %esp,%ebp
    1086:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1089:	8b 45 08             	mov    0x8(%ebp),%eax
    108c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    108f:	90                   	nop
    1090:	8b 55 0c             	mov    0xc(%ebp),%edx
    1093:	8d 42 01             	lea    0x1(%edx),%eax
    1096:	89 45 0c             	mov    %eax,0xc(%ebp)
    1099:	8b 45 08             	mov    0x8(%ebp),%eax
    109c:	8d 48 01             	lea    0x1(%eax),%ecx
    109f:	89 4d 08             	mov    %ecx,0x8(%ebp)
    10a2:	0f b6 12             	movzbl (%edx),%edx
    10a5:	88 10                	mov    %dl,(%eax)
    10a7:	0f b6 00             	movzbl (%eax),%eax
    10aa:	84 c0                	test   %al,%al
    10ac:	75 e2                	jne    1090 <strcpy+0x11>
    ;
  return os;
    10ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10b1:	c9                   	leave  
    10b2:	c3                   	ret    

000010b3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10b3:	f3 0f 1e fb          	endbr32 
    10b7:	55                   	push   %ebp
    10b8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10ba:	eb 08                	jmp    10c4 <strcmp+0x11>
    p++, q++;
    10bc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10c0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    10c4:	8b 45 08             	mov    0x8(%ebp),%eax
    10c7:	0f b6 00             	movzbl (%eax),%eax
    10ca:	84 c0                	test   %al,%al
    10cc:	74 10                	je     10de <strcmp+0x2b>
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	0f b6 10             	movzbl (%eax),%edx
    10d4:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d7:	0f b6 00             	movzbl (%eax),%eax
    10da:	38 c2                	cmp    %al,%dl
    10dc:	74 de                	je     10bc <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    10de:	8b 45 08             	mov    0x8(%ebp),%eax
    10e1:	0f b6 00             	movzbl (%eax),%eax
    10e4:	0f b6 d0             	movzbl %al,%edx
    10e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ea:	0f b6 00             	movzbl (%eax),%eax
    10ed:	0f b6 c0             	movzbl %al,%eax
    10f0:	29 c2                	sub    %eax,%edx
    10f2:	89 d0                	mov    %edx,%eax
}
    10f4:	5d                   	pop    %ebp
    10f5:	c3                   	ret    

000010f6 <strlen>:

uint
strlen(const char *s)
{
    10f6:	f3 0f 1e fb          	endbr32 
    10fa:	55                   	push   %ebp
    10fb:	89 e5                	mov    %esp,%ebp
    10fd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1100:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1107:	eb 04                	jmp    110d <strlen+0x17>
    1109:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    110d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1110:	8b 45 08             	mov    0x8(%ebp),%eax
    1113:	01 d0                	add    %edx,%eax
    1115:	0f b6 00             	movzbl (%eax),%eax
    1118:	84 c0                	test   %al,%al
    111a:	75 ed                	jne    1109 <strlen+0x13>
    ;
  return n;
    111c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    111f:	c9                   	leave  
    1120:	c3                   	ret    

00001121 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1121:	f3 0f 1e fb          	endbr32 
    1125:	55                   	push   %ebp
    1126:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1128:	8b 45 10             	mov    0x10(%ebp),%eax
    112b:	50                   	push   %eax
    112c:	ff 75 0c             	pushl  0xc(%ebp)
    112f:	ff 75 08             	pushl  0x8(%ebp)
    1132:	e8 22 ff ff ff       	call   1059 <stosb>
    1137:	83 c4 0c             	add    $0xc,%esp
  return dst;
    113a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    113d:	c9                   	leave  
    113e:	c3                   	ret    

0000113f <strchr>:

char*
strchr(const char *s, char c)
{
    113f:	f3 0f 1e fb          	endbr32 
    1143:	55                   	push   %ebp
    1144:	89 e5                	mov    %esp,%ebp
    1146:	83 ec 04             	sub    $0x4,%esp
    1149:	8b 45 0c             	mov    0xc(%ebp),%eax
    114c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    114f:	eb 14                	jmp    1165 <strchr+0x26>
    if(*s == c)
    1151:	8b 45 08             	mov    0x8(%ebp),%eax
    1154:	0f b6 00             	movzbl (%eax),%eax
    1157:	38 45 fc             	cmp    %al,-0x4(%ebp)
    115a:	75 05                	jne    1161 <strchr+0x22>
      return (char*)s;
    115c:	8b 45 08             	mov    0x8(%ebp),%eax
    115f:	eb 13                	jmp    1174 <strchr+0x35>
  for(; *s; s++)
    1161:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1165:	8b 45 08             	mov    0x8(%ebp),%eax
    1168:	0f b6 00             	movzbl (%eax),%eax
    116b:	84 c0                	test   %al,%al
    116d:	75 e2                	jne    1151 <strchr+0x12>
  return 0;
    116f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1174:	c9                   	leave  
    1175:	c3                   	ret    

00001176 <gets>:

char*
gets(char *buf, int max)
{
    1176:	f3 0f 1e fb          	endbr32 
    117a:	55                   	push   %ebp
    117b:	89 e5                	mov    %esp,%ebp
    117d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1180:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1187:	eb 42                	jmp    11cb <gets+0x55>
    cc = read(0, &c, 1);
    1189:	83 ec 04             	sub    $0x4,%esp
    118c:	6a 01                	push   $0x1
    118e:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1191:	50                   	push   %eax
    1192:	6a 00                	push   $0x0
    1194:	e8 53 01 00 00       	call   12ec <read>
    1199:	83 c4 10             	add    $0x10,%esp
    119c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    119f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11a3:	7e 33                	jle    11d8 <gets+0x62>
      break;
    buf[i++] = c;
    11a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a8:	8d 50 01             	lea    0x1(%eax),%edx
    11ab:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11ae:	89 c2                	mov    %eax,%edx
    11b0:	8b 45 08             	mov    0x8(%ebp),%eax
    11b3:	01 c2                	add    %eax,%edx
    11b5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11b9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11bb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11bf:	3c 0a                	cmp    $0xa,%al
    11c1:	74 16                	je     11d9 <gets+0x63>
    11c3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c7:	3c 0d                	cmp    $0xd,%al
    11c9:	74 0e                	je     11d9 <gets+0x63>
  for(i=0; i+1 < max; ){
    11cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ce:	83 c0 01             	add    $0x1,%eax
    11d1:	39 45 0c             	cmp    %eax,0xc(%ebp)
    11d4:	7f b3                	jg     1189 <gets+0x13>
    11d6:	eb 01                	jmp    11d9 <gets+0x63>
      break;
    11d8:	90                   	nop
      break;
  }
  buf[i] = '\0';
    11d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11dc:	8b 45 08             	mov    0x8(%ebp),%eax
    11df:	01 d0                	add    %edx,%eax
    11e1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11e7:	c9                   	leave  
    11e8:	c3                   	ret    

000011e9 <stat>:

int
stat(const char *n, struct stat *st)
{
    11e9:	f3 0f 1e fb          	endbr32 
    11ed:	55                   	push   %ebp
    11ee:	89 e5                	mov    %esp,%ebp
    11f0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11f3:	83 ec 08             	sub    $0x8,%esp
    11f6:	6a 00                	push   $0x0
    11f8:	ff 75 08             	pushl  0x8(%ebp)
    11fb:	e8 14 01 00 00       	call   1314 <open>
    1200:	83 c4 10             	add    $0x10,%esp
    1203:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1206:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    120a:	79 07                	jns    1213 <stat+0x2a>
    return -1;
    120c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1211:	eb 25                	jmp    1238 <stat+0x4f>
  r = fstat(fd, st);
    1213:	83 ec 08             	sub    $0x8,%esp
    1216:	ff 75 0c             	pushl  0xc(%ebp)
    1219:	ff 75 f4             	pushl  -0xc(%ebp)
    121c:	e8 0b 01 00 00       	call   132c <fstat>
    1221:	83 c4 10             	add    $0x10,%esp
    1224:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1227:	83 ec 0c             	sub    $0xc,%esp
    122a:	ff 75 f4             	pushl  -0xc(%ebp)
    122d:	e8 ca 00 00 00       	call   12fc <close>
    1232:	83 c4 10             	add    $0x10,%esp
  return r;
    1235:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1238:	c9                   	leave  
    1239:	c3                   	ret    

0000123a <atoi>:

int
atoi(const char *s)
{
    123a:	f3 0f 1e fb          	endbr32 
    123e:	55                   	push   %ebp
    123f:	89 e5                	mov    %esp,%ebp
    1241:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1244:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    124b:	eb 25                	jmp    1272 <atoi+0x38>
    n = n*10 + *s++ - '0';
    124d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1250:	89 d0                	mov    %edx,%eax
    1252:	c1 e0 02             	shl    $0x2,%eax
    1255:	01 d0                	add    %edx,%eax
    1257:	01 c0                	add    %eax,%eax
    1259:	89 c1                	mov    %eax,%ecx
    125b:	8b 45 08             	mov    0x8(%ebp),%eax
    125e:	8d 50 01             	lea    0x1(%eax),%edx
    1261:	89 55 08             	mov    %edx,0x8(%ebp)
    1264:	0f b6 00             	movzbl (%eax),%eax
    1267:	0f be c0             	movsbl %al,%eax
    126a:	01 c8                	add    %ecx,%eax
    126c:	83 e8 30             	sub    $0x30,%eax
    126f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1272:	8b 45 08             	mov    0x8(%ebp),%eax
    1275:	0f b6 00             	movzbl (%eax),%eax
    1278:	3c 2f                	cmp    $0x2f,%al
    127a:	7e 0a                	jle    1286 <atoi+0x4c>
    127c:	8b 45 08             	mov    0x8(%ebp),%eax
    127f:	0f b6 00             	movzbl (%eax),%eax
    1282:	3c 39                	cmp    $0x39,%al
    1284:	7e c7                	jle    124d <atoi+0x13>
  return n;
    1286:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1289:	c9                   	leave  
    128a:	c3                   	ret    

0000128b <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    128b:	f3 0f 1e fb          	endbr32 
    128f:	55                   	push   %ebp
    1290:	89 e5                	mov    %esp,%ebp
    1292:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    1295:	8b 45 08             	mov    0x8(%ebp),%eax
    1298:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    129b:	8b 45 0c             	mov    0xc(%ebp),%eax
    129e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12a1:	eb 17                	jmp    12ba <memmove+0x2f>
    *dst++ = *src++;
    12a3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12a6:	8d 42 01             	lea    0x1(%edx),%eax
    12a9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    12ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12af:	8d 48 01             	lea    0x1(%eax),%ecx
    12b2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    12b5:	0f b6 12             	movzbl (%edx),%edx
    12b8:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    12ba:	8b 45 10             	mov    0x10(%ebp),%eax
    12bd:	8d 50 ff             	lea    -0x1(%eax),%edx
    12c0:	89 55 10             	mov    %edx,0x10(%ebp)
    12c3:	85 c0                	test   %eax,%eax
    12c5:	7f dc                	jg     12a3 <memmove+0x18>
  return vdst;
    12c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12ca:	c9                   	leave  
    12cb:	c3                   	ret    

000012cc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12cc:	b8 01 00 00 00       	mov    $0x1,%eax
    12d1:	cd 40                	int    $0x40
    12d3:	c3                   	ret    

000012d4 <exit>:
SYSCALL(exit)
    12d4:	b8 02 00 00 00       	mov    $0x2,%eax
    12d9:	cd 40                	int    $0x40
    12db:	c3                   	ret    

000012dc <wait>:
SYSCALL(wait)
    12dc:	b8 03 00 00 00       	mov    $0x3,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <pipe>:
SYSCALL(pipe)
    12e4:	b8 04 00 00 00       	mov    $0x4,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <read>:
SYSCALL(read)
    12ec:	b8 05 00 00 00       	mov    $0x5,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <write>:
SYSCALL(write)
    12f4:	b8 10 00 00 00       	mov    $0x10,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <close>:
SYSCALL(close)
    12fc:	b8 15 00 00 00       	mov    $0x15,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <kill>:
SYSCALL(kill)
    1304:	b8 06 00 00 00       	mov    $0x6,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <exec>:
SYSCALL(exec)
    130c:	b8 07 00 00 00       	mov    $0x7,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <open>:
SYSCALL(open)
    1314:	b8 0f 00 00 00       	mov    $0xf,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <mknod>:
SYSCALL(mknod)
    131c:	b8 11 00 00 00       	mov    $0x11,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <unlink>:
SYSCALL(unlink)
    1324:	b8 12 00 00 00       	mov    $0x12,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <fstat>:
SYSCALL(fstat)
    132c:	b8 08 00 00 00       	mov    $0x8,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <link>:
SYSCALL(link)
    1334:	b8 13 00 00 00       	mov    $0x13,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <mkdir>:
SYSCALL(mkdir)
    133c:	b8 14 00 00 00       	mov    $0x14,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <chdir>:
SYSCALL(chdir)
    1344:	b8 09 00 00 00       	mov    $0x9,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <dup>:
SYSCALL(dup)
    134c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <getpid>:
SYSCALL(getpid)
    1354:	b8 0b 00 00 00       	mov    $0xb,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <sbrk>:
SYSCALL(sbrk)
    135c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <sleep>:
SYSCALL(sleep)
    1364:	b8 0d 00 00 00       	mov    $0xd,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <uptime>:
SYSCALL(uptime)
    136c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <settickets>:
SYSCALL(settickets)
    1374:	b8 16 00 00 00       	mov    $0x16,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <getpinfo>:
SYSCALL(getpinfo)
    137c:	b8 17 00 00 00       	mov    $0x17,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1384:	f3 0f 1e fb          	endbr32 
    1388:	55                   	push   %ebp
    1389:	89 e5                	mov    %esp,%ebp
    138b:	83 ec 18             	sub    $0x18,%esp
    138e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1391:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1394:	83 ec 04             	sub    $0x4,%esp
    1397:	6a 01                	push   $0x1
    1399:	8d 45 f4             	lea    -0xc(%ebp),%eax
    139c:	50                   	push   %eax
    139d:	ff 75 08             	pushl  0x8(%ebp)
    13a0:	e8 4f ff ff ff       	call   12f4 <write>
    13a5:	83 c4 10             	add    $0x10,%esp
}
    13a8:	90                   	nop
    13a9:	c9                   	leave  
    13aa:	c3                   	ret    

000013ab <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13ab:	f3 0f 1e fb          	endbr32 
    13af:	55                   	push   %ebp
    13b0:	89 e5                	mov    %esp,%ebp
    13b2:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13bc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13c0:	74 17                	je     13d9 <printint+0x2e>
    13c2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13c6:	79 11                	jns    13d9 <printint+0x2e>
    neg = 1;
    13c8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d2:	f7 d8                	neg    %eax
    13d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13d7:	eb 06                	jmp    13df <printint+0x34>
  } else {
    x = xx;
    13d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13ec:	ba 00 00 00 00       	mov    $0x0,%edx
    13f1:	f7 f1                	div    %ecx
    13f3:	89 d1                	mov    %edx,%ecx
    13f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f8:	8d 50 01             	lea    0x1(%eax),%edx
    13fb:	89 55 f4             	mov    %edx,-0xc(%ebp)
    13fe:	0f b6 91 a4 1a 00 00 	movzbl 0x1aa4(%ecx),%edx
    1405:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1409:	8b 4d 10             	mov    0x10(%ebp),%ecx
    140c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    140f:	ba 00 00 00 00       	mov    $0x0,%edx
    1414:	f7 f1                	div    %ecx
    1416:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1419:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    141d:	75 c7                	jne    13e6 <printint+0x3b>
  if(neg)
    141f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1423:	74 2d                	je     1452 <printint+0xa7>
    buf[i++] = '-';
    1425:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1428:	8d 50 01             	lea    0x1(%eax),%edx
    142b:	89 55 f4             	mov    %edx,-0xc(%ebp)
    142e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1433:	eb 1d                	jmp    1452 <printint+0xa7>
    putc(fd, buf[i]);
    1435:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1438:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143b:	01 d0                	add    %edx,%eax
    143d:	0f b6 00             	movzbl (%eax),%eax
    1440:	0f be c0             	movsbl %al,%eax
    1443:	83 ec 08             	sub    $0x8,%esp
    1446:	50                   	push   %eax
    1447:	ff 75 08             	pushl  0x8(%ebp)
    144a:	e8 35 ff ff ff       	call   1384 <putc>
    144f:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    1452:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1456:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    145a:	79 d9                	jns    1435 <printint+0x8a>
}
    145c:	90                   	nop
    145d:	90                   	nop
    145e:	c9                   	leave  
    145f:	c3                   	ret    

00001460 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1460:	f3 0f 1e fb          	endbr32 
    1464:	55                   	push   %ebp
    1465:	89 e5                	mov    %esp,%ebp
    1467:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    146a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1471:	8d 45 0c             	lea    0xc(%ebp),%eax
    1474:	83 c0 04             	add    $0x4,%eax
    1477:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    147a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1481:	e9 59 01 00 00       	jmp    15df <printf+0x17f>
    c = fmt[i] & 0xff;
    1486:	8b 55 0c             	mov    0xc(%ebp),%edx
    1489:	8b 45 f0             	mov    -0x10(%ebp),%eax
    148c:	01 d0                	add    %edx,%eax
    148e:	0f b6 00             	movzbl (%eax),%eax
    1491:	0f be c0             	movsbl %al,%eax
    1494:	25 ff 00 00 00       	and    $0xff,%eax
    1499:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    149c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14a0:	75 2c                	jne    14ce <printf+0x6e>
      if(c == '%'){
    14a2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14a6:	75 0c                	jne    14b4 <printf+0x54>
        state = '%';
    14a8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14af:	e9 27 01 00 00       	jmp    15db <printf+0x17b>
      } else {
        putc(fd, c);
    14b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14b7:	0f be c0             	movsbl %al,%eax
    14ba:	83 ec 08             	sub    $0x8,%esp
    14bd:	50                   	push   %eax
    14be:	ff 75 08             	pushl  0x8(%ebp)
    14c1:	e8 be fe ff ff       	call   1384 <putc>
    14c6:	83 c4 10             	add    $0x10,%esp
    14c9:	e9 0d 01 00 00       	jmp    15db <printf+0x17b>
      }
    } else if(state == '%'){
    14ce:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14d2:	0f 85 03 01 00 00    	jne    15db <printf+0x17b>
      if(c == 'd'){
    14d8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14dc:	75 1e                	jne    14fc <printf+0x9c>
        printint(fd, *ap, 10, 1);
    14de:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14e1:	8b 00                	mov    (%eax),%eax
    14e3:	6a 01                	push   $0x1
    14e5:	6a 0a                	push   $0xa
    14e7:	50                   	push   %eax
    14e8:	ff 75 08             	pushl  0x8(%ebp)
    14eb:	e8 bb fe ff ff       	call   13ab <printint>
    14f0:	83 c4 10             	add    $0x10,%esp
        ap++;
    14f3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    14f7:	e9 d8 00 00 00       	jmp    15d4 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    14fc:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1500:	74 06                	je     1508 <printf+0xa8>
    1502:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1506:	75 1e                	jne    1526 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1508:	8b 45 e8             	mov    -0x18(%ebp),%eax
    150b:	8b 00                	mov    (%eax),%eax
    150d:	6a 00                	push   $0x0
    150f:	6a 10                	push   $0x10
    1511:	50                   	push   %eax
    1512:	ff 75 08             	pushl  0x8(%ebp)
    1515:	e8 91 fe ff ff       	call   13ab <printint>
    151a:	83 c4 10             	add    $0x10,%esp
        ap++;
    151d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1521:	e9 ae 00 00 00       	jmp    15d4 <printf+0x174>
      } else if(c == 's'){
    1526:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    152a:	75 43                	jne    156f <printf+0x10f>
        s = (char*)*ap;
    152c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    152f:	8b 00                	mov    (%eax),%eax
    1531:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1534:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1538:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    153c:	75 25                	jne    1563 <printf+0x103>
          s = "(null)";
    153e:	c7 45 f4 56 18 00 00 	movl   $0x1856,-0xc(%ebp)
        while(*s != 0){
    1545:	eb 1c                	jmp    1563 <printf+0x103>
          putc(fd, *s);
    1547:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154a:	0f b6 00             	movzbl (%eax),%eax
    154d:	0f be c0             	movsbl %al,%eax
    1550:	83 ec 08             	sub    $0x8,%esp
    1553:	50                   	push   %eax
    1554:	ff 75 08             	pushl  0x8(%ebp)
    1557:	e8 28 fe ff ff       	call   1384 <putc>
    155c:	83 c4 10             	add    $0x10,%esp
          s++;
    155f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1563:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1566:	0f b6 00             	movzbl (%eax),%eax
    1569:	84 c0                	test   %al,%al
    156b:	75 da                	jne    1547 <printf+0xe7>
    156d:	eb 65                	jmp    15d4 <printf+0x174>
        }
      } else if(c == 'c'){
    156f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1573:	75 1d                	jne    1592 <printf+0x132>
        putc(fd, *ap);
    1575:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1578:	8b 00                	mov    (%eax),%eax
    157a:	0f be c0             	movsbl %al,%eax
    157d:	83 ec 08             	sub    $0x8,%esp
    1580:	50                   	push   %eax
    1581:	ff 75 08             	pushl  0x8(%ebp)
    1584:	e8 fb fd ff ff       	call   1384 <putc>
    1589:	83 c4 10             	add    $0x10,%esp
        ap++;
    158c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1590:	eb 42                	jmp    15d4 <printf+0x174>
      } else if(c == '%'){
    1592:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1596:	75 17                	jne    15af <printf+0x14f>
        putc(fd, c);
    1598:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    159b:	0f be c0             	movsbl %al,%eax
    159e:	83 ec 08             	sub    $0x8,%esp
    15a1:	50                   	push   %eax
    15a2:	ff 75 08             	pushl  0x8(%ebp)
    15a5:	e8 da fd ff ff       	call   1384 <putc>
    15aa:	83 c4 10             	add    $0x10,%esp
    15ad:	eb 25                	jmp    15d4 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15af:	83 ec 08             	sub    $0x8,%esp
    15b2:	6a 25                	push   $0x25
    15b4:	ff 75 08             	pushl  0x8(%ebp)
    15b7:	e8 c8 fd ff ff       	call   1384 <putc>
    15bc:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15c2:	0f be c0             	movsbl %al,%eax
    15c5:	83 ec 08             	sub    $0x8,%esp
    15c8:	50                   	push   %eax
    15c9:	ff 75 08             	pushl  0x8(%ebp)
    15cc:	e8 b3 fd ff ff       	call   1384 <putc>
    15d1:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15d4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    15db:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15df:	8b 55 0c             	mov    0xc(%ebp),%edx
    15e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15e5:	01 d0                	add    %edx,%eax
    15e7:	0f b6 00             	movzbl (%eax),%eax
    15ea:	84 c0                	test   %al,%al
    15ec:	0f 85 94 fe ff ff    	jne    1486 <printf+0x26>
    }
  }
}
    15f2:	90                   	nop
    15f3:	90                   	nop
    15f4:	c9                   	leave  
    15f5:	c3                   	ret    

000015f6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15f6:	f3 0f 1e fb          	endbr32 
    15fa:	55                   	push   %ebp
    15fb:	89 e5                	mov    %esp,%ebp
    15fd:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1600:	8b 45 08             	mov    0x8(%ebp),%eax
    1603:	83 e8 08             	sub    $0x8,%eax
    1606:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1609:	a1 c0 1a 00 00       	mov    0x1ac0,%eax
    160e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1611:	eb 24                	jmp    1637 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1613:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1616:	8b 00                	mov    (%eax),%eax
    1618:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    161b:	72 12                	jb     162f <free+0x39>
    161d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1620:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1623:	77 24                	ja     1649 <free+0x53>
    1625:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1628:	8b 00                	mov    (%eax),%eax
    162a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    162d:	72 1a                	jb     1649 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    162f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1632:	8b 00                	mov    (%eax),%eax
    1634:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1637:	8b 45 f8             	mov    -0x8(%ebp),%eax
    163a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    163d:	76 d4                	jbe    1613 <free+0x1d>
    163f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1642:	8b 00                	mov    (%eax),%eax
    1644:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1647:	73 ca                	jae    1613 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1649:	8b 45 f8             	mov    -0x8(%ebp),%eax
    164c:	8b 40 04             	mov    0x4(%eax),%eax
    164f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1656:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1659:	01 c2                	add    %eax,%edx
    165b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    165e:	8b 00                	mov    (%eax),%eax
    1660:	39 c2                	cmp    %eax,%edx
    1662:	75 24                	jne    1688 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1664:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1667:	8b 50 04             	mov    0x4(%eax),%edx
    166a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166d:	8b 00                	mov    (%eax),%eax
    166f:	8b 40 04             	mov    0x4(%eax),%eax
    1672:	01 c2                	add    %eax,%edx
    1674:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1677:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    167a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167d:	8b 00                	mov    (%eax),%eax
    167f:	8b 10                	mov    (%eax),%edx
    1681:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1684:	89 10                	mov    %edx,(%eax)
    1686:	eb 0a                	jmp    1692 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1688:	8b 45 fc             	mov    -0x4(%ebp),%eax
    168b:	8b 10                	mov    (%eax),%edx
    168d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1690:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1692:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1695:	8b 40 04             	mov    0x4(%eax),%eax
    1698:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    169f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a2:	01 d0                	add    %edx,%eax
    16a4:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16a7:	75 20                	jne    16c9 <free+0xd3>
    p->s.size += bp->s.size;
    16a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ac:	8b 50 04             	mov    0x4(%eax),%edx
    16af:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b2:	8b 40 04             	mov    0x4(%eax),%eax
    16b5:	01 c2                	add    %eax,%edx
    16b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ba:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c0:	8b 10                	mov    (%eax),%edx
    16c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c5:	89 10                	mov    %edx,(%eax)
    16c7:	eb 08                	jmp    16d1 <free+0xdb>
  } else
    p->s.ptr = bp;
    16c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cc:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16cf:	89 10                	mov    %edx,(%eax)
  freep = p;
    16d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d4:	a3 c0 1a 00 00       	mov    %eax,0x1ac0
}
    16d9:	90                   	nop
    16da:	c9                   	leave  
    16db:	c3                   	ret    

000016dc <morecore>:

static Header*
morecore(uint nu)
{
    16dc:	f3 0f 1e fb          	endbr32 
    16e0:	55                   	push   %ebp
    16e1:	89 e5                	mov    %esp,%ebp
    16e3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16e6:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16ed:	77 07                	ja     16f6 <morecore+0x1a>
    nu = 4096;
    16ef:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    16f6:	8b 45 08             	mov    0x8(%ebp),%eax
    16f9:	c1 e0 03             	shl    $0x3,%eax
    16fc:	83 ec 0c             	sub    $0xc,%esp
    16ff:	50                   	push   %eax
    1700:	e8 57 fc ff ff       	call   135c <sbrk>
    1705:	83 c4 10             	add    $0x10,%esp
    1708:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    170b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    170f:	75 07                	jne    1718 <morecore+0x3c>
    return 0;
    1711:	b8 00 00 00 00       	mov    $0x0,%eax
    1716:	eb 26                	jmp    173e <morecore+0x62>
  hp = (Header*)p;
    1718:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    171e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1721:	8b 55 08             	mov    0x8(%ebp),%edx
    1724:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1727:	8b 45 f0             	mov    -0x10(%ebp),%eax
    172a:	83 c0 08             	add    $0x8,%eax
    172d:	83 ec 0c             	sub    $0xc,%esp
    1730:	50                   	push   %eax
    1731:	e8 c0 fe ff ff       	call   15f6 <free>
    1736:	83 c4 10             	add    $0x10,%esp
  return freep;
    1739:	a1 c0 1a 00 00       	mov    0x1ac0,%eax
}
    173e:	c9                   	leave  
    173f:	c3                   	ret    

00001740 <malloc>:

void*
malloc(uint nbytes)
{
    1740:	f3 0f 1e fb          	endbr32 
    1744:	55                   	push   %ebp
    1745:	89 e5                	mov    %esp,%ebp
    1747:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    174a:	8b 45 08             	mov    0x8(%ebp),%eax
    174d:	83 c0 07             	add    $0x7,%eax
    1750:	c1 e8 03             	shr    $0x3,%eax
    1753:	83 c0 01             	add    $0x1,%eax
    1756:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1759:	a1 c0 1a 00 00       	mov    0x1ac0,%eax
    175e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1761:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1765:	75 23                	jne    178a <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1767:	c7 45 f0 b8 1a 00 00 	movl   $0x1ab8,-0x10(%ebp)
    176e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1771:	a3 c0 1a 00 00       	mov    %eax,0x1ac0
    1776:	a1 c0 1a 00 00       	mov    0x1ac0,%eax
    177b:	a3 b8 1a 00 00       	mov    %eax,0x1ab8
    base.s.size = 0;
    1780:	c7 05 bc 1a 00 00 00 	movl   $0x0,0x1abc
    1787:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    178a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    178d:	8b 00                	mov    (%eax),%eax
    178f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1792:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1795:	8b 40 04             	mov    0x4(%eax),%eax
    1798:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    179b:	77 4d                	ja     17ea <malloc+0xaa>
      if(p->s.size == nunits)
    179d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a0:	8b 40 04             	mov    0x4(%eax),%eax
    17a3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17a6:	75 0c                	jne    17b4 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    17a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ab:	8b 10                	mov    (%eax),%edx
    17ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b0:	89 10                	mov    %edx,(%eax)
    17b2:	eb 26                	jmp    17da <malloc+0x9a>
      else {
        p->s.size -= nunits;
    17b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b7:	8b 40 04             	mov    0x4(%eax),%eax
    17ba:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17bd:	89 c2                	mov    %eax,%edx
    17bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c2:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c8:	8b 40 04             	mov    0x4(%eax),%eax
    17cb:	c1 e0 03             	shl    $0x3,%eax
    17ce:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17d7:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17dd:	a3 c0 1a 00 00       	mov    %eax,0x1ac0
      return (void*)(p + 1);
    17e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e5:	83 c0 08             	add    $0x8,%eax
    17e8:	eb 3b                	jmp    1825 <malloc+0xe5>
    }
    if(p == freep)
    17ea:	a1 c0 1a 00 00       	mov    0x1ac0,%eax
    17ef:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    17f2:	75 1e                	jne    1812 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    17f4:	83 ec 0c             	sub    $0xc,%esp
    17f7:	ff 75 ec             	pushl  -0x14(%ebp)
    17fa:	e8 dd fe ff ff       	call   16dc <morecore>
    17ff:	83 c4 10             	add    $0x10,%esp
    1802:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1805:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1809:	75 07                	jne    1812 <malloc+0xd2>
        return 0;
    180b:	b8 00 00 00 00       	mov    $0x0,%eax
    1810:	eb 13                	jmp    1825 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1812:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1815:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1818:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181b:	8b 00                	mov    (%eax),%eax
    181d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1820:	e9 6d ff ff ff       	jmp    1792 <malloc+0x52>
  }
}
    1825:	c9                   	leave  
    1826:	c3                   	ret    
