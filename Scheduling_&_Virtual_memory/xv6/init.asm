
_init:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

char *argv[] = { "sh", 0 };

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
    1012:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    1015:	83 ec 08             	sub    $0x8,%esp
    1018:	6a 02                	push   $0x2
    101a:	68 d6 18 00 00       	push   $0x18d6
    101f:	e8 9c 03 00 00       	call   13c0 <open>
    1024:	83 c4 10             	add    $0x10,%esp
    1027:	85 c0                	test   %eax,%eax
    1029:	79 26                	jns    1051 <main+0x51>
    mknod("console", 1, 1);
    102b:	83 ec 04             	sub    $0x4,%esp
    102e:	6a 01                	push   $0x1
    1030:	6a 01                	push   $0x1
    1032:	68 d6 18 00 00       	push   $0x18d6
    1037:	e8 8c 03 00 00       	call   13c8 <mknod>
    103c:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
    103f:	83 ec 08             	sub    $0x8,%esp
    1042:	6a 02                	push   $0x2
    1044:	68 d6 18 00 00       	push   $0x18d6
    1049:	e8 72 03 00 00       	call   13c0 <open>
    104e:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
    1051:	83 ec 0c             	sub    $0xc,%esp
    1054:	6a 00                	push   $0x0
    1056:	e8 9d 03 00 00       	call   13f8 <dup>
    105b:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
    105e:	83 ec 0c             	sub    $0xc,%esp
    1061:	6a 00                	push   $0x0
    1063:	e8 90 03 00 00       	call   13f8 <dup>
    1068:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
    106b:	83 ec 08             	sub    $0x8,%esp
    106e:	68 de 18 00 00       	push   $0x18de
    1073:	6a 01                	push   $0x1
    1075:	e8 92 04 00 00       	call   150c <printf>
    107a:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    107d:	e8 f6 02 00 00       	call   1378 <fork>
    1082:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
    1085:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1089:	79 17                	jns    10a2 <main+0xa2>
      printf(1, "init: fork failed\n");
    108b:	83 ec 08             	sub    $0x8,%esp
    108e:	68 f1 18 00 00       	push   $0x18f1
    1093:	6a 01                	push   $0x1
    1095:	e8 72 04 00 00       	call   150c <printf>
    109a:	83 c4 10             	add    $0x10,%esp
      exit();
    109d:	e8 de 02 00 00       	call   1380 <exit>
    }
    if(pid == 0){
    10a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10a6:	75 3e                	jne    10e6 <main+0xe6>
      exec("sh", argv);
    10a8:	83 ec 08             	sub    $0x8,%esp
    10ab:	68 70 1b 00 00       	push   $0x1b70
    10b0:	68 d3 18 00 00       	push   $0x18d3
    10b5:	e8 fe 02 00 00       	call   13b8 <exec>
    10ba:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
    10bd:	83 ec 08             	sub    $0x8,%esp
    10c0:	68 04 19 00 00       	push   $0x1904
    10c5:	6a 01                	push   $0x1
    10c7:	e8 40 04 00 00       	call   150c <printf>
    10cc:	83 c4 10             	add    $0x10,%esp
      exit();
    10cf:	e8 ac 02 00 00       	call   1380 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
    10d4:	83 ec 08             	sub    $0x8,%esp
    10d7:	68 1a 19 00 00       	push   $0x191a
    10dc:	6a 01                	push   $0x1
    10de:	e8 29 04 00 00       	call   150c <printf>
    10e3:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
    10e6:	e8 9d 02 00 00       	call   1388 <wait>
    10eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    10ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10f2:	0f 88 73 ff ff ff    	js     106b <main+0x6b>
    10f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    10fe:	75 d4                	jne    10d4 <main+0xd4>
    printf(1, "init: starting sh\n");
    1100:	e9 66 ff ff ff       	jmp    106b <main+0x6b>

00001105 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1105:	55                   	push   %ebp
    1106:	89 e5                	mov    %esp,%ebp
    1108:	57                   	push   %edi
    1109:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    110a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    110d:	8b 55 10             	mov    0x10(%ebp),%edx
    1110:	8b 45 0c             	mov    0xc(%ebp),%eax
    1113:	89 cb                	mov    %ecx,%ebx
    1115:	89 df                	mov    %ebx,%edi
    1117:	89 d1                	mov    %edx,%ecx
    1119:	fc                   	cld    
    111a:	f3 aa                	rep stos %al,%es:(%edi)
    111c:	89 ca                	mov    %ecx,%edx
    111e:	89 fb                	mov    %edi,%ebx
    1120:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1123:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1126:	90                   	nop
    1127:	5b                   	pop    %ebx
    1128:	5f                   	pop    %edi
    1129:	5d                   	pop    %ebp
    112a:	c3                   	ret    

0000112b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    112b:	f3 0f 1e fb          	endbr32 
    112f:	55                   	push   %ebp
    1130:	89 e5                	mov    %esp,%ebp
    1132:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1135:	8b 45 08             	mov    0x8(%ebp),%eax
    1138:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    113b:	90                   	nop
    113c:	8b 55 0c             	mov    0xc(%ebp),%edx
    113f:	8d 42 01             	lea    0x1(%edx),%eax
    1142:	89 45 0c             	mov    %eax,0xc(%ebp)
    1145:	8b 45 08             	mov    0x8(%ebp),%eax
    1148:	8d 48 01             	lea    0x1(%eax),%ecx
    114b:	89 4d 08             	mov    %ecx,0x8(%ebp)
    114e:	0f b6 12             	movzbl (%edx),%edx
    1151:	88 10                	mov    %dl,(%eax)
    1153:	0f b6 00             	movzbl (%eax),%eax
    1156:	84 c0                	test   %al,%al
    1158:	75 e2                	jne    113c <strcpy+0x11>
    ;
  return os;
    115a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    115d:	c9                   	leave  
    115e:	c3                   	ret    

0000115f <strcmp>:

int
strcmp(const char *p, const char *q)
{
    115f:	f3 0f 1e fb          	endbr32 
    1163:	55                   	push   %ebp
    1164:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1166:	eb 08                	jmp    1170 <strcmp+0x11>
    p++, q++;
    1168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    116c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    1170:	8b 45 08             	mov    0x8(%ebp),%eax
    1173:	0f b6 00             	movzbl (%eax),%eax
    1176:	84 c0                	test   %al,%al
    1178:	74 10                	je     118a <strcmp+0x2b>
    117a:	8b 45 08             	mov    0x8(%ebp),%eax
    117d:	0f b6 10             	movzbl (%eax),%edx
    1180:	8b 45 0c             	mov    0xc(%ebp),%eax
    1183:	0f b6 00             	movzbl (%eax),%eax
    1186:	38 c2                	cmp    %al,%dl
    1188:	74 de                	je     1168 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    118a:	8b 45 08             	mov    0x8(%ebp),%eax
    118d:	0f b6 00             	movzbl (%eax),%eax
    1190:	0f b6 d0             	movzbl %al,%edx
    1193:	8b 45 0c             	mov    0xc(%ebp),%eax
    1196:	0f b6 00             	movzbl (%eax),%eax
    1199:	0f b6 c0             	movzbl %al,%eax
    119c:	29 c2                	sub    %eax,%edx
    119e:	89 d0                	mov    %edx,%eax
}
    11a0:	5d                   	pop    %ebp
    11a1:	c3                   	ret    

000011a2 <strlen>:

uint
strlen(const char *s)
{
    11a2:	f3 0f 1e fb          	endbr32 
    11a6:	55                   	push   %ebp
    11a7:	89 e5                	mov    %esp,%ebp
    11a9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    11ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    11b3:	eb 04                	jmp    11b9 <strlen+0x17>
    11b5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    11b9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    11bc:	8b 45 08             	mov    0x8(%ebp),%eax
    11bf:	01 d0                	add    %edx,%eax
    11c1:	0f b6 00             	movzbl (%eax),%eax
    11c4:	84 c0                	test   %al,%al
    11c6:	75 ed                	jne    11b5 <strlen+0x13>
    ;
  return n;
    11c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    11cb:	c9                   	leave  
    11cc:	c3                   	ret    

000011cd <memset>:

void*
memset(void *dst, int c, uint n)
{
    11cd:	f3 0f 1e fb          	endbr32 
    11d1:	55                   	push   %ebp
    11d2:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    11d4:	8b 45 10             	mov    0x10(%ebp),%eax
    11d7:	50                   	push   %eax
    11d8:	ff 75 0c             	pushl  0xc(%ebp)
    11db:	ff 75 08             	pushl  0x8(%ebp)
    11de:	e8 22 ff ff ff       	call   1105 <stosb>
    11e3:	83 c4 0c             	add    $0xc,%esp
  return dst;
    11e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11e9:	c9                   	leave  
    11ea:	c3                   	ret    

000011eb <strchr>:

char*
strchr(const char *s, char c)
{
    11eb:	f3 0f 1e fb          	endbr32 
    11ef:	55                   	push   %ebp
    11f0:	89 e5                	mov    %esp,%ebp
    11f2:	83 ec 04             	sub    $0x4,%esp
    11f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11f8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    11fb:	eb 14                	jmp    1211 <strchr+0x26>
    if(*s == c)
    11fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1200:	0f b6 00             	movzbl (%eax),%eax
    1203:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1206:	75 05                	jne    120d <strchr+0x22>
      return (char*)s;
    1208:	8b 45 08             	mov    0x8(%ebp),%eax
    120b:	eb 13                	jmp    1220 <strchr+0x35>
  for(; *s; s++)
    120d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1211:	8b 45 08             	mov    0x8(%ebp),%eax
    1214:	0f b6 00             	movzbl (%eax),%eax
    1217:	84 c0                	test   %al,%al
    1219:	75 e2                	jne    11fd <strchr+0x12>
  return 0;
    121b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1220:	c9                   	leave  
    1221:	c3                   	ret    

00001222 <gets>:

char*
gets(char *buf, int max)
{
    1222:	f3 0f 1e fb          	endbr32 
    1226:	55                   	push   %ebp
    1227:	89 e5                	mov    %esp,%ebp
    1229:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    122c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1233:	eb 42                	jmp    1277 <gets+0x55>
    cc = read(0, &c, 1);
    1235:	83 ec 04             	sub    $0x4,%esp
    1238:	6a 01                	push   $0x1
    123a:	8d 45 ef             	lea    -0x11(%ebp),%eax
    123d:	50                   	push   %eax
    123e:	6a 00                	push   $0x0
    1240:	e8 53 01 00 00       	call   1398 <read>
    1245:	83 c4 10             	add    $0x10,%esp
    1248:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    124b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    124f:	7e 33                	jle    1284 <gets+0x62>
      break;
    buf[i++] = c;
    1251:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1254:	8d 50 01             	lea    0x1(%eax),%edx
    1257:	89 55 f4             	mov    %edx,-0xc(%ebp)
    125a:	89 c2                	mov    %eax,%edx
    125c:	8b 45 08             	mov    0x8(%ebp),%eax
    125f:	01 c2                	add    %eax,%edx
    1261:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1265:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1267:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    126b:	3c 0a                	cmp    $0xa,%al
    126d:	74 16                	je     1285 <gets+0x63>
    126f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1273:	3c 0d                	cmp    $0xd,%al
    1275:	74 0e                	je     1285 <gets+0x63>
  for(i=0; i+1 < max; ){
    1277:	8b 45 f4             	mov    -0xc(%ebp),%eax
    127a:	83 c0 01             	add    $0x1,%eax
    127d:	39 45 0c             	cmp    %eax,0xc(%ebp)
    1280:	7f b3                	jg     1235 <gets+0x13>
    1282:	eb 01                	jmp    1285 <gets+0x63>
      break;
    1284:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1285:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1288:	8b 45 08             	mov    0x8(%ebp),%eax
    128b:	01 d0                	add    %edx,%eax
    128d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1290:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1293:	c9                   	leave  
    1294:	c3                   	ret    

00001295 <stat>:

int
stat(const char *n, struct stat *st)
{
    1295:	f3 0f 1e fb          	endbr32 
    1299:	55                   	push   %ebp
    129a:	89 e5                	mov    %esp,%ebp
    129c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    129f:	83 ec 08             	sub    $0x8,%esp
    12a2:	6a 00                	push   $0x0
    12a4:	ff 75 08             	pushl  0x8(%ebp)
    12a7:	e8 14 01 00 00       	call   13c0 <open>
    12ac:	83 c4 10             	add    $0x10,%esp
    12af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    12b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12b6:	79 07                	jns    12bf <stat+0x2a>
    return -1;
    12b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12bd:	eb 25                	jmp    12e4 <stat+0x4f>
  r = fstat(fd, st);
    12bf:	83 ec 08             	sub    $0x8,%esp
    12c2:	ff 75 0c             	pushl  0xc(%ebp)
    12c5:	ff 75 f4             	pushl  -0xc(%ebp)
    12c8:	e8 0b 01 00 00       	call   13d8 <fstat>
    12cd:	83 c4 10             	add    $0x10,%esp
    12d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    12d3:	83 ec 0c             	sub    $0xc,%esp
    12d6:	ff 75 f4             	pushl  -0xc(%ebp)
    12d9:	e8 ca 00 00 00       	call   13a8 <close>
    12de:	83 c4 10             	add    $0x10,%esp
  return r;
    12e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    12e4:	c9                   	leave  
    12e5:	c3                   	ret    

000012e6 <atoi>:

int
atoi(const char *s)
{
    12e6:	f3 0f 1e fb          	endbr32 
    12ea:	55                   	push   %ebp
    12eb:	89 e5                	mov    %esp,%ebp
    12ed:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    12f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12f7:	eb 25                	jmp    131e <atoi+0x38>
    n = n*10 + *s++ - '0';
    12f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12fc:	89 d0                	mov    %edx,%eax
    12fe:	c1 e0 02             	shl    $0x2,%eax
    1301:	01 d0                	add    %edx,%eax
    1303:	01 c0                	add    %eax,%eax
    1305:	89 c1                	mov    %eax,%ecx
    1307:	8b 45 08             	mov    0x8(%ebp),%eax
    130a:	8d 50 01             	lea    0x1(%eax),%edx
    130d:	89 55 08             	mov    %edx,0x8(%ebp)
    1310:	0f b6 00             	movzbl (%eax),%eax
    1313:	0f be c0             	movsbl %al,%eax
    1316:	01 c8                	add    %ecx,%eax
    1318:	83 e8 30             	sub    $0x30,%eax
    131b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    131e:	8b 45 08             	mov    0x8(%ebp),%eax
    1321:	0f b6 00             	movzbl (%eax),%eax
    1324:	3c 2f                	cmp    $0x2f,%al
    1326:	7e 0a                	jle    1332 <atoi+0x4c>
    1328:	8b 45 08             	mov    0x8(%ebp),%eax
    132b:	0f b6 00             	movzbl (%eax),%eax
    132e:	3c 39                	cmp    $0x39,%al
    1330:	7e c7                	jle    12f9 <atoi+0x13>
  return n;
    1332:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1335:	c9                   	leave  
    1336:	c3                   	ret    

00001337 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1337:	f3 0f 1e fb          	endbr32 
    133b:	55                   	push   %ebp
    133c:	89 e5                	mov    %esp,%ebp
    133e:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    1341:	8b 45 08             	mov    0x8(%ebp),%eax
    1344:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1347:	8b 45 0c             	mov    0xc(%ebp),%eax
    134a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    134d:	eb 17                	jmp    1366 <memmove+0x2f>
    *dst++ = *src++;
    134f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1352:	8d 42 01             	lea    0x1(%edx),%eax
    1355:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1358:	8b 45 fc             	mov    -0x4(%ebp),%eax
    135b:	8d 48 01             	lea    0x1(%eax),%ecx
    135e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    1361:	0f b6 12             	movzbl (%edx),%edx
    1364:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    1366:	8b 45 10             	mov    0x10(%ebp),%eax
    1369:	8d 50 ff             	lea    -0x1(%eax),%edx
    136c:	89 55 10             	mov    %edx,0x10(%ebp)
    136f:	85 c0                	test   %eax,%eax
    1371:	7f dc                	jg     134f <memmove+0x18>
  return vdst;
    1373:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1376:	c9                   	leave  
    1377:	c3                   	ret    

00001378 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1378:	b8 01 00 00 00       	mov    $0x1,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <exit>:
SYSCALL(exit)
    1380:	b8 02 00 00 00       	mov    $0x2,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <wait>:
SYSCALL(wait)
    1388:	b8 03 00 00 00       	mov    $0x3,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <pipe>:
SYSCALL(pipe)
    1390:	b8 04 00 00 00       	mov    $0x4,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <read>:
SYSCALL(read)
    1398:	b8 05 00 00 00       	mov    $0x5,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <write>:
SYSCALL(write)
    13a0:	b8 10 00 00 00       	mov    $0x10,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <close>:
SYSCALL(close)
    13a8:	b8 15 00 00 00       	mov    $0x15,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <kill>:
SYSCALL(kill)
    13b0:	b8 06 00 00 00       	mov    $0x6,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <exec>:
SYSCALL(exec)
    13b8:	b8 07 00 00 00       	mov    $0x7,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <open>:
SYSCALL(open)
    13c0:	b8 0f 00 00 00       	mov    $0xf,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <mknod>:
SYSCALL(mknod)
    13c8:	b8 11 00 00 00       	mov    $0x11,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <unlink>:
SYSCALL(unlink)
    13d0:	b8 12 00 00 00       	mov    $0x12,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <fstat>:
SYSCALL(fstat)
    13d8:	b8 08 00 00 00       	mov    $0x8,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <link>:
SYSCALL(link)
    13e0:	b8 13 00 00 00       	mov    $0x13,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <mkdir>:
SYSCALL(mkdir)
    13e8:	b8 14 00 00 00       	mov    $0x14,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <chdir>:
SYSCALL(chdir)
    13f0:	b8 09 00 00 00       	mov    $0x9,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <dup>:
SYSCALL(dup)
    13f8:	b8 0a 00 00 00       	mov    $0xa,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <getpid>:
SYSCALL(getpid)
    1400:	b8 0b 00 00 00       	mov    $0xb,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <sbrk>:
SYSCALL(sbrk)
    1408:	b8 0c 00 00 00       	mov    $0xc,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <sleep>:
SYSCALL(sleep)
    1410:	b8 0d 00 00 00       	mov    $0xd,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <uptime>:
SYSCALL(uptime)
    1418:	b8 0e 00 00 00       	mov    $0xe,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <settickets>:
SYSCALL(settickets)
    1420:	b8 16 00 00 00       	mov    $0x16,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <getpinfo>:
SYSCALL(getpinfo)
    1428:	b8 17 00 00 00       	mov    $0x17,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1430:	f3 0f 1e fb          	endbr32 
    1434:	55                   	push   %ebp
    1435:	89 e5                	mov    %esp,%ebp
    1437:	83 ec 18             	sub    $0x18,%esp
    143a:	8b 45 0c             	mov    0xc(%ebp),%eax
    143d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1440:	83 ec 04             	sub    $0x4,%esp
    1443:	6a 01                	push   $0x1
    1445:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1448:	50                   	push   %eax
    1449:	ff 75 08             	pushl  0x8(%ebp)
    144c:	e8 4f ff ff ff       	call   13a0 <write>
    1451:	83 c4 10             	add    $0x10,%esp
}
    1454:	90                   	nop
    1455:	c9                   	leave  
    1456:	c3                   	ret    

00001457 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1457:	f3 0f 1e fb          	endbr32 
    145b:	55                   	push   %ebp
    145c:	89 e5                	mov    %esp,%ebp
    145e:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1461:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1468:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    146c:	74 17                	je     1485 <printint+0x2e>
    146e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1472:	79 11                	jns    1485 <printint+0x2e>
    neg = 1;
    1474:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    147b:	8b 45 0c             	mov    0xc(%ebp),%eax
    147e:	f7 d8                	neg    %eax
    1480:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1483:	eb 06                	jmp    148b <printint+0x34>
  } else {
    x = xx;
    1485:	8b 45 0c             	mov    0xc(%ebp),%eax
    1488:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    148b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1492:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1495:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1498:	ba 00 00 00 00       	mov    $0x0,%edx
    149d:	f7 f1                	div    %ecx
    149f:	89 d1                	mov    %edx,%ecx
    14a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a4:	8d 50 01             	lea    0x1(%eax),%edx
    14a7:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14aa:	0f b6 91 78 1b 00 00 	movzbl 0x1b78(%ecx),%edx
    14b1:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    14b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
    14b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14bb:	ba 00 00 00 00       	mov    $0x0,%edx
    14c0:	f7 f1                	div    %ecx
    14c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14c5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14c9:	75 c7                	jne    1492 <printint+0x3b>
  if(neg)
    14cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14cf:	74 2d                	je     14fe <printint+0xa7>
    buf[i++] = '-';
    14d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d4:	8d 50 01             	lea    0x1(%eax),%edx
    14d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14da:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    14df:	eb 1d                	jmp    14fe <printint+0xa7>
    putc(fd, buf[i]);
    14e1:	8d 55 dc             	lea    -0x24(%ebp),%edx
    14e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e7:	01 d0                	add    %edx,%eax
    14e9:	0f b6 00             	movzbl (%eax),%eax
    14ec:	0f be c0             	movsbl %al,%eax
    14ef:	83 ec 08             	sub    $0x8,%esp
    14f2:	50                   	push   %eax
    14f3:	ff 75 08             	pushl  0x8(%ebp)
    14f6:	e8 35 ff ff ff       	call   1430 <putc>
    14fb:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    14fe:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1502:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1506:	79 d9                	jns    14e1 <printint+0x8a>
}
    1508:	90                   	nop
    1509:	90                   	nop
    150a:	c9                   	leave  
    150b:	c3                   	ret    

0000150c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    150c:	f3 0f 1e fb          	endbr32 
    1510:	55                   	push   %ebp
    1511:	89 e5                	mov    %esp,%ebp
    1513:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1516:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    151d:	8d 45 0c             	lea    0xc(%ebp),%eax
    1520:	83 c0 04             	add    $0x4,%eax
    1523:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1526:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    152d:	e9 59 01 00 00       	jmp    168b <printf+0x17f>
    c = fmt[i] & 0xff;
    1532:	8b 55 0c             	mov    0xc(%ebp),%edx
    1535:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1538:	01 d0                	add    %edx,%eax
    153a:	0f b6 00             	movzbl (%eax),%eax
    153d:	0f be c0             	movsbl %al,%eax
    1540:	25 ff 00 00 00       	and    $0xff,%eax
    1545:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1548:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    154c:	75 2c                	jne    157a <printf+0x6e>
      if(c == '%'){
    154e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1552:	75 0c                	jne    1560 <printf+0x54>
        state = '%';
    1554:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    155b:	e9 27 01 00 00       	jmp    1687 <printf+0x17b>
      } else {
        putc(fd, c);
    1560:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1563:	0f be c0             	movsbl %al,%eax
    1566:	83 ec 08             	sub    $0x8,%esp
    1569:	50                   	push   %eax
    156a:	ff 75 08             	pushl  0x8(%ebp)
    156d:	e8 be fe ff ff       	call   1430 <putc>
    1572:	83 c4 10             	add    $0x10,%esp
    1575:	e9 0d 01 00 00       	jmp    1687 <printf+0x17b>
      }
    } else if(state == '%'){
    157a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    157e:	0f 85 03 01 00 00    	jne    1687 <printf+0x17b>
      if(c == 'd'){
    1584:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1588:	75 1e                	jne    15a8 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    158a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    158d:	8b 00                	mov    (%eax),%eax
    158f:	6a 01                	push   $0x1
    1591:	6a 0a                	push   $0xa
    1593:	50                   	push   %eax
    1594:	ff 75 08             	pushl  0x8(%ebp)
    1597:	e8 bb fe ff ff       	call   1457 <printint>
    159c:	83 c4 10             	add    $0x10,%esp
        ap++;
    159f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15a3:	e9 d8 00 00 00       	jmp    1680 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    15a8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    15ac:	74 06                	je     15b4 <printf+0xa8>
    15ae:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    15b2:	75 1e                	jne    15d2 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    15b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15b7:	8b 00                	mov    (%eax),%eax
    15b9:	6a 00                	push   $0x0
    15bb:	6a 10                	push   $0x10
    15bd:	50                   	push   %eax
    15be:	ff 75 08             	pushl  0x8(%ebp)
    15c1:	e8 91 fe ff ff       	call   1457 <printint>
    15c6:	83 c4 10             	add    $0x10,%esp
        ap++;
    15c9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15cd:	e9 ae 00 00 00       	jmp    1680 <printf+0x174>
      } else if(c == 's'){
    15d2:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    15d6:	75 43                	jne    161b <printf+0x10f>
        s = (char*)*ap;
    15d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15db:	8b 00                	mov    (%eax),%eax
    15dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    15e0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    15e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15e8:	75 25                	jne    160f <printf+0x103>
          s = "(null)";
    15ea:	c7 45 f4 23 19 00 00 	movl   $0x1923,-0xc(%ebp)
        while(*s != 0){
    15f1:	eb 1c                	jmp    160f <printf+0x103>
          putc(fd, *s);
    15f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f6:	0f b6 00             	movzbl (%eax),%eax
    15f9:	0f be c0             	movsbl %al,%eax
    15fc:	83 ec 08             	sub    $0x8,%esp
    15ff:	50                   	push   %eax
    1600:	ff 75 08             	pushl  0x8(%ebp)
    1603:	e8 28 fe ff ff       	call   1430 <putc>
    1608:	83 c4 10             	add    $0x10,%esp
          s++;
    160b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    160f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1612:	0f b6 00             	movzbl (%eax),%eax
    1615:	84 c0                	test   %al,%al
    1617:	75 da                	jne    15f3 <printf+0xe7>
    1619:	eb 65                	jmp    1680 <printf+0x174>
        }
      } else if(c == 'c'){
    161b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    161f:	75 1d                	jne    163e <printf+0x132>
        putc(fd, *ap);
    1621:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1624:	8b 00                	mov    (%eax),%eax
    1626:	0f be c0             	movsbl %al,%eax
    1629:	83 ec 08             	sub    $0x8,%esp
    162c:	50                   	push   %eax
    162d:	ff 75 08             	pushl  0x8(%ebp)
    1630:	e8 fb fd ff ff       	call   1430 <putc>
    1635:	83 c4 10             	add    $0x10,%esp
        ap++;
    1638:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    163c:	eb 42                	jmp    1680 <printf+0x174>
      } else if(c == '%'){
    163e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1642:	75 17                	jne    165b <printf+0x14f>
        putc(fd, c);
    1644:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1647:	0f be c0             	movsbl %al,%eax
    164a:	83 ec 08             	sub    $0x8,%esp
    164d:	50                   	push   %eax
    164e:	ff 75 08             	pushl  0x8(%ebp)
    1651:	e8 da fd ff ff       	call   1430 <putc>
    1656:	83 c4 10             	add    $0x10,%esp
    1659:	eb 25                	jmp    1680 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    165b:	83 ec 08             	sub    $0x8,%esp
    165e:	6a 25                	push   $0x25
    1660:	ff 75 08             	pushl  0x8(%ebp)
    1663:	e8 c8 fd ff ff       	call   1430 <putc>
    1668:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    166b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    166e:	0f be c0             	movsbl %al,%eax
    1671:	83 ec 08             	sub    $0x8,%esp
    1674:	50                   	push   %eax
    1675:	ff 75 08             	pushl  0x8(%ebp)
    1678:	e8 b3 fd ff ff       	call   1430 <putc>
    167d:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1680:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    1687:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    168b:	8b 55 0c             	mov    0xc(%ebp),%edx
    168e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1691:	01 d0                	add    %edx,%eax
    1693:	0f b6 00             	movzbl (%eax),%eax
    1696:	84 c0                	test   %al,%al
    1698:	0f 85 94 fe ff ff    	jne    1532 <printf+0x26>
    }
  }
}
    169e:	90                   	nop
    169f:	90                   	nop
    16a0:	c9                   	leave  
    16a1:	c3                   	ret    

000016a2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16a2:	f3 0f 1e fb          	endbr32 
    16a6:	55                   	push   %ebp
    16a7:	89 e5                	mov    %esp,%ebp
    16a9:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16ac:	8b 45 08             	mov    0x8(%ebp),%eax
    16af:	83 e8 08             	sub    $0x8,%eax
    16b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16b5:	a1 94 1b 00 00       	mov    0x1b94,%eax
    16ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16bd:	eb 24                	jmp    16e3 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c2:	8b 00                	mov    (%eax),%eax
    16c4:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    16c7:	72 12                	jb     16db <free+0x39>
    16c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16cc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16cf:	77 24                	ja     16f5 <free+0x53>
    16d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d4:	8b 00                	mov    (%eax),%eax
    16d6:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16d9:	72 1a                	jb     16f5 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16db:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16de:	8b 00                	mov    (%eax),%eax
    16e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16e9:	76 d4                	jbe    16bf <free+0x1d>
    16eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ee:	8b 00                	mov    (%eax),%eax
    16f0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16f3:	73 ca                	jae    16bf <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f8:	8b 40 04             	mov    0x4(%eax),%eax
    16fb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1702:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1705:	01 c2                	add    %eax,%edx
    1707:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170a:	8b 00                	mov    (%eax),%eax
    170c:	39 c2                	cmp    %eax,%edx
    170e:	75 24                	jne    1734 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1710:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1713:	8b 50 04             	mov    0x4(%eax),%edx
    1716:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1719:	8b 00                	mov    (%eax),%eax
    171b:	8b 40 04             	mov    0x4(%eax),%eax
    171e:	01 c2                	add    %eax,%edx
    1720:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1723:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1726:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1729:	8b 00                	mov    (%eax),%eax
    172b:	8b 10                	mov    (%eax),%edx
    172d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1730:	89 10                	mov    %edx,(%eax)
    1732:	eb 0a                	jmp    173e <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1734:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1737:	8b 10                	mov    (%eax),%edx
    1739:	8b 45 f8             	mov    -0x8(%ebp),%eax
    173c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    173e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1741:	8b 40 04             	mov    0x4(%eax),%eax
    1744:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    174b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    174e:	01 d0                	add    %edx,%eax
    1750:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1753:	75 20                	jne    1775 <free+0xd3>
    p->s.size += bp->s.size;
    1755:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1758:	8b 50 04             	mov    0x4(%eax),%edx
    175b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    175e:	8b 40 04             	mov    0x4(%eax),%eax
    1761:	01 c2                	add    %eax,%edx
    1763:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1766:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1769:	8b 45 f8             	mov    -0x8(%ebp),%eax
    176c:	8b 10                	mov    (%eax),%edx
    176e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1771:	89 10                	mov    %edx,(%eax)
    1773:	eb 08                	jmp    177d <free+0xdb>
  } else
    p->s.ptr = bp;
    1775:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1778:	8b 55 f8             	mov    -0x8(%ebp),%edx
    177b:	89 10                	mov    %edx,(%eax)
  freep = p;
    177d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1780:	a3 94 1b 00 00       	mov    %eax,0x1b94
}
    1785:	90                   	nop
    1786:	c9                   	leave  
    1787:	c3                   	ret    

00001788 <morecore>:

static Header*
morecore(uint nu)
{
    1788:	f3 0f 1e fb          	endbr32 
    178c:	55                   	push   %ebp
    178d:	89 e5                	mov    %esp,%ebp
    178f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1792:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1799:	77 07                	ja     17a2 <morecore+0x1a>
    nu = 4096;
    179b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    17a2:	8b 45 08             	mov    0x8(%ebp),%eax
    17a5:	c1 e0 03             	shl    $0x3,%eax
    17a8:	83 ec 0c             	sub    $0xc,%esp
    17ab:	50                   	push   %eax
    17ac:	e8 57 fc ff ff       	call   1408 <sbrk>
    17b1:	83 c4 10             	add    $0x10,%esp
    17b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    17b7:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    17bb:	75 07                	jne    17c4 <morecore+0x3c>
    return 0;
    17bd:	b8 00 00 00 00       	mov    $0x0,%eax
    17c2:	eb 26                	jmp    17ea <morecore+0x62>
  hp = (Header*)p;
    17c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    17ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17cd:	8b 55 08             	mov    0x8(%ebp),%edx
    17d0:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    17d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d6:	83 c0 08             	add    $0x8,%eax
    17d9:	83 ec 0c             	sub    $0xc,%esp
    17dc:	50                   	push   %eax
    17dd:	e8 c0 fe ff ff       	call   16a2 <free>
    17e2:	83 c4 10             	add    $0x10,%esp
  return freep;
    17e5:	a1 94 1b 00 00       	mov    0x1b94,%eax
}
    17ea:	c9                   	leave  
    17eb:	c3                   	ret    

000017ec <malloc>:

void*
malloc(uint nbytes)
{
    17ec:	f3 0f 1e fb          	endbr32 
    17f0:	55                   	push   %ebp
    17f1:	89 e5                	mov    %esp,%ebp
    17f3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17f6:	8b 45 08             	mov    0x8(%ebp),%eax
    17f9:	83 c0 07             	add    $0x7,%eax
    17fc:	c1 e8 03             	shr    $0x3,%eax
    17ff:	83 c0 01             	add    $0x1,%eax
    1802:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1805:	a1 94 1b 00 00       	mov    0x1b94,%eax
    180a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    180d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1811:	75 23                	jne    1836 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1813:	c7 45 f0 8c 1b 00 00 	movl   $0x1b8c,-0x10(%ebp)
    181a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    181d:	a3 94 1b 00 00       	mov    %eax,0x1b94
    1822:	a1 94 1b 00 00       	mov    0x1b94,%eax
    1827:	a3 8c 1b 00 00       	mov    %eax,0x1b8c
    base.s.size = 0;
    182c:	c7 05 90 1b 00 00 00 	movl   $0x0,0x1b90
    1833:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1836:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1839:	8b 00                	mov    (%eax),%eax
    183b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    183e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1841:	8b 40 04             	mov    0x4(%eax),%eax
    1844:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1847:	77 4d                	ja     1896 <malloc+0xaa>
      if(p->s.size == nunits)
    1849:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184c:	8b 40 04             	mov    0x4(%eax),%eax
    184f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1852:	75 0c                	jne    1860 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    1854:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1857:	8b 10                	mov    (%eax),%edx
    1859:	8b 45 f0             	mov    -0x10(%ebp),%eax
    185c:	89 10                	mov    %edx,(%eax)
    185e:	eb 26                	jmp    1886 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    1860:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1863:	8b 40 04             	mov    0x4(%eax),%eax
    1866:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1869:	89 c2                	mov    %eax,%edx
    186b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1871:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1874:	8b 40 04             	mov    0x4(%eax),%eax
    1877:	c1 e0 03             	shl    $0x3,%eax
    187a:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    187d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1880:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1883:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1886:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1889:	a3 94 1b 00 00       	mov    %eax,0x1b94
      return (void*)(p + 1);
    188e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1891:	83 c0 08             	add    $0x8,%eax
    1894:	eb 3b                	jmp    18d1 <malloc+0xe5>
    }
    if(p == freep)
    1896:	a1 94 1b 00 00       	mov    0x1b94,%eax
    189b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    189e:	75 1e                	jne    18be <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    18a0:	83 ec 0c             	sub    $0xc,%esp
    18a3:	ff 75 ec             	pushl  -0x14(%ebp)
    18a6:	e8 dd fe ff ff       	call   1788 <morecore>
    18ab:	83 c4 10             	add    $0x10,%esp
    18ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18b5:	75 07                	jne    18be <malloc+0xd2>
        return 0;
    18b7:	b8 00 00 00 00       	mov    $0x0,%eax
    18bc:	eb 13                	jmp    18d1 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c7:	8b 00                	mov    (%eax),%eax
    18c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    18cc:	e9 6d ff ff ff       	jmp    183e <malloc+0x52>
  }
}
    18d1:	c9                   	leave  
    18d2:	c3                   	ret    
