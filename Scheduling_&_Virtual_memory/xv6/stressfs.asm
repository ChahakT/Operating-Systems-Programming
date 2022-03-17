
_stressfs:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "fs.h"
#include "fcntl.h"

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
    1012:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
    1018:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
    101f:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
    1026:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
    102c:	83 ec 08             	sub    $0x8,%esp
    102f:	68 24 19 00 00       	push   $0x1924
    1034:	6a 01                	push   $0x1
    1036:	e8 22 05 00 00       	call   155d <printf>
    103b:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
    103e:	83 ec 04             	sub    $0x4,%esp
    1041:	68 00 02 00 00       	push   $0x200
    1046:	6a 61                	push   $0x61
    1048:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
    104e:	50                   	push   %eax
    104f:	e8 ca 01 00 00       	call   121e <memset>
    1054:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
    1057:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    105e:	eb 0d                	jmp    106d <main+0x6d>
    if(fork() > 0)
    1060:	e8 64 03 00 00       	call   13c9 <fork>
    1065:	85 c0                	test   %eax,%eax
    1067:	7f 0c                	jg     1075 <main+0x75>
  for(i = 0; i < 4; i++)
    1069:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    106d:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
    1071:	7e ed                	jle    1060 <main+0x60>
    1073:	eb 01                	jmp    1076 <main+0x76>
      break;
    1075:	90                   	nop

  printf(1, "write %d\n", i);
    1076:	83 ec 04             	sub    $0x4,%esp
    1079:	ff 75 f4             	pushl  -0xc(%ebp)
    107c:	68 37 19 00 00       	push   $0x1937
    1081:	6a 01                	push   $0x1
    1083:	e8 d5 04 00 00       	call   155d <printf>
    1088:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
    108b:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
    108f:	89 c2                	mov    %eax,%edx
    1091:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1094:	01 d0                	add    %edx,%eax
    1096:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
    1099:	83 ec 08             	sub    $0x8,%esp
    109c:	68 02 02 00 00       	push   $0x202
    10a1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    10a4:	50                   	push   %eax
    10a5:	e8 67 03 00 00       	call   1411 <open>
    10aa:	83 c4 10             	add    $0x10,%esp
    10ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
    10b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10b7:	eb 1e                	jmp    10d7 <main+0xd7>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
    10b9:	83 ec 04             	sub    $0x4,%esp
    10bc:	68 00 02 00 00       	push   $0x200
    10c1:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
    10c7:	50                   	push   %eax
    10c8:	ff 75 f0             	pushl  -0x10(%ebp)
    10cb:	e8 21 03 00 00       	call   13f1 <write>
    10d0:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++)
    10d3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10d7:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    10db:	7e dc                	jle    10b9 <main+0xb9>
  close(fd);
    10dd:	83 ec 0c             	sub    $0xc,%esp
    10e0:	ff 75 f0             	pushl  -0x10(%ebp)
    10e3:	e8 11 03 00 00       	call   13f9 <close>
    10e8:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
    10eb:	83 ec 08             	sub    $0x8,%esp
    10ee:	68 41 19 00 00       	push   $0x1941
    10f3:	6a 01                	push   $0x1
    10f5:	e8 63 04 00 00       	call   155d <printf>
    10fa:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
    10fd:	83 ec 08             	sub    $0x8,%esp
    1100:	6a 00                	push   $0x0
    1102:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1105:	50                   	push   %eax
    1106:	e8 06 03 00 00       	call   1411 <open>
    110b:	83 c4 10             	add    $0x10,%esp
    110e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
    1111:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1118:	eb 1e                	jmp    1138 <main+0x138>
    read(fd, data, sizeof(data));
    111a:	83 ec 04             	sub    $0x4,%esp
    111d:	68 00 02 00 00       	push   $0x200
    1122:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
    1128:	50                   	push   %eax
    1129:	ff 75 f0             	pushl  -0x10(%ebp)
    112c:	e8 b8 02 00 00       	call   13e9 <read>
    1131:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < 20; i++)
    1134:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1138:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    113c:	7e dc                	jle    111a <main+0x11a>
  close(fd);
    113e:	83 ec 0c             	sub    $0xc,%esp
    1141:	ff 75 f0             	pushl  -0x10(%ebp)
    1144:	e8 b0 02 00 00       	call   13f9 <close>
    1149:	83 c4 10             	add    $0x10,%esp

  wait();
    114c:	e8 88 02 00 00       	call   13d9 <wait>

  exit();
    1151:	e8 7b 02 00 00       	call   13d1 <exit>

00001156 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1156:	55                   	push   %ebp
    1157:	89 e5                	mov    %esp,%ebp
    1159:	57                   	push   %edi
    115a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    115b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    115e:	8b 55 10             	mov    0x10(%ebp),%edx
    1161:	8b 45 0c             	mov    0xc(%ebp),%eax
    1164:	89 cb                	mov    %ecx,%ebx
    1166:	89 df                	mov    %ebx,%edi
    1168:	89 d1                	mov    %edx,%ecx
    116a:	fc                   	cld    
    116b:	f3 aa                	rep stos %al,%es:(%edi)
    116d:	89 ca                	mov    %ecx,%edx
    116f:	89 fb                	mov    %edi,%ebx
    1171:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1174:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1177:	90                   	nop
    1178:	5b                   	pop    %ebx
    1179:	5f                   	pop    %edi
    117a:	5d                   	pop    %ebp
    117b:	c3                   	ret    

0000117c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    117c:	f3 0f 1e fb          	endbr32 
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1186:	8b 45 08             	mov    0x8(%ebp),%eax
    1189:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    118c:	90                   	nop
    118d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1190:	8d 42 01             	lea    0x1(%edx),%eax
    1193:	89 45 0c             	mov    %eax,0xc(%ebp)
    1196:	8b 45 08             	mov    0x8(%ebp),%eax
    1199:	8d 48 01             	lea    0x1(%eax),%ecx
    119c:	89 4d 08             	mov    %ecx,0x8(%ebp)
    119f:	0f b6 12             	movzbl (%edx),%edx
    11a2:	88 10                	mov    %dl,(%eax)
    11a4:	0f b6 00             	movzbl (%eax),%eax
    11a7:	84 c0                	test   %al,%al
    11a9:	75 e2                	jne    118d <strcpy+0x11>
    ;
  return os;
    11ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    11ae:	c9                   	leave  
    11af:	c3                   	ret    

000011b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11b0:	f3 0f 1e fb          	endbr32 
    11b4:	55                   	push   %ebp
    11b5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    11b7:	eb 08                	jmp    11c1 <strcmp+0x11>
    p++, q++;
    11b9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11bd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    11c1:	8b 45 08             	mov    0x8(%ebp),%eax
    11c4:	0f b6 00             	movzbl (%eax),%eax
    11c7:	84 c0                	test   %al,%al
    11c9:	74 10                	je     11db <strcmp+0x2b>
    11cb:	8b 45 08             	mov    0x8(%ebp),%eax
    11ce:	0f b6 10             	movzbl (%eax),%edx
    11d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d4:	0f b6 00             	movzbl (%eax),%eax
    11d7:	38 c2                	cmp    %al,%dl
    11d9:	74 de                	je     11b9 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    11db:	8b 45 08             	mov    0x8(%ebp),%eax
    11de:	0f b6 00             	movzbl (%eax),%eax
    11e1:	0f b6 d0             	movzbl %al,%edx
    11e4:	8b 45 0c             	mov    0xc(%ebp),%eax
    11e7:	0f b6 00             	movzbl (%eax),%eax
    11ea:	0f b6 c0             	movzbl %al,%eax
    11ed:	29 c2                	sub    %eax,%edx
    11ef:	89 d0                	mov    %edx,%eax
}
    11f1:	5d                   	pop    %ebp
    11f2:	c3                   	ret    

000011f3 <strlen>:

uint
strlen(const char *s)
{
    11f3:	f3 0f 1e fb          	endbr32 
    11f7:	55                   	push   %ebp
    11f8:	89 e5                	mov    %esp,%ebp
    11fa:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    11fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1204:	eb 04                	jmp    120a <strlen+0x17>
    1206:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    120a:	8b 55 fc             	mov    -0x4(%ebp),%edx
    120d:	8b 45 08             	mov    0x8(%ebp),%eax
    1210:	01 d0                	add    %edx,%eax
    1212:	0f b6 00             	movzbl (%eax),%eax
    1215:	84 c0                	test   %al,%al
    1217:	75 ed                	jne    1206 <strlen+0x13>
    ;
  return n;
    1219:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    121c:	c9                   	leave  
    121d:	c3                   	ret    

0000121e <memset>:

void*
memset(void *dst, int c, uint n)
{
    121e:	f3 0f 1e fb          	endbr32 
    1222:	55                   	push   %ebp
    1223:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1225:	8b 45 10             	mov    0x10(%ebp),%eax
    1228:	50                   	push   %eax
    1229:	ff 75 0c             	pushl  0xc(%ebp)
    122c:	ff 75 08             	pushl  0x8(%ebp)
    122f:	e8 22 ff ff ff       	call   1156 <stosb>
    1234:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1237:	8b 45 08             	mov    0x8(%ebp),%eax
}
    123a:	c9                   	leave  
    123b:	c3                   	ret    

0000123c <strchr>:

char*
strchr(const char *s, char c)
{
    123c:	f3 0f 1e fb          	endbr32 
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	83 ec 04             	sub    $0x4,%esp
    1246:	8b 45 0c             	mov    0xc(%ebp),%eax
    1249:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    124c:	eb 14                	jmp    1262 <strchr+0x26>
    if(*s == c)
    124e:	8b 45 08             	mov    0x8(%ebp),%eax
    1251:	0f b6 00             	movzbl (%eax),%eax
    1254:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1257:	75 05                	jne    125e <strchr+0x22>
      return (char*)s;
    1259:	8b 45 08             	mov    0x8(%ebp),%eax
    125c:	eb 13                	jmp    1271 <strchr+0x35>
  for(; *s; s++)
    125e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1262:	8b 45 08             	mov    0x8(%ebp),%eax
    1265:	0f b6 00             	movzbl (%eax),%eax
    1268:	84 c0                	test   %al,%al
    126a:	75 e2                	jne    124e <strchr+0x12>
  return 0;
    126c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1271:	c9                   	leave  
    1272:	c3                   	ret    

00001273 <gets>:

char*
gets(char *buf, int max)
{
    1273:	f3 0f 1e fb          	endbr32 
    1277:	55                   	push   %ebp
    1278:	89 e5                	mov    %esp,%ebp
    127a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    127d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1284:	eb 42                	jmp    12c8 <gets+0x55>
    cc = read(0, &c, 1);
    1286:	83 ec 04             	sub    $0x4,%esp
    1289:	6a 01                	push   $0x1
    128b:	8d 45 ef             	lea    -0x11(%ebp),%eax
    128e:	50                   	push   %eax
    128f:	6a 00                	push   $0x0
    1291:	e8 53 01 00 00       	call   13e9 <read>
    1296:	83 c4 10             	add    $0x10,%esp
    1299:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    129c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12a0:	7e 33                	jle    12d5 <gets+0x62>
      break;
    buf[i++] = c;
    12a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12a5:	8d 50 01             	lea    0x1(%eax),%edx
    12a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
    12ab:	89 c2                	mov    %eax,%edx
    12ad:	8b 45 08             	mov    0x8(%ebp),%eax
    12b0:	01 c2                	add    %eax,%edx
    12b2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12b6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    12b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12bc:	3c 0a                	cmp    $0xa,%al
    12be:	74 16                	je     12d6 <gets+0x63>
    12c0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12c4:	3c 0d                	cmp    $0xd,%al
    12c6:	74 0e                	je     12d6 <gets+0x63>
  for(i=0; i+1 < max; ){
    12c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12cb:	83 c0 01             	add    $0x1,%eax
    12ce:	39 45 0c             	cmp    %eax,0xc(%ebp)
    12d1:	7f b3                	jg     1286 <gets+0x13>
    12d3:	eb 01                	jmp    12d6 <gets+0x63>
      break;
    12d5:	90                   	nop
      break;
  }
  buf[i] = '\0';
    12d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12d9:	8b 45 08             	mov    0x8(%ebp),%eax
    12dc:	01 d0                	add    %edx,%eax
    12de:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    12e1:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12e4:	c9                   	leave  
    12e5:	c3                   	ret    

000012e6 <stat>:

int
stat(const char *n, struct stat *st)
{
    12e6:	f3 0f 1e fb          	endbr32 
    12ea:	55                   	push   %ebp
    12eb:	89 e5                	mov    %esp,%ebp
    12ed:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12f0:	83 ec 08             	sub    $0x8,%esp
    12f3:	6a 00                	push   $0x0
    12f5:	ff 75 08             	pushl  0x8(%ebp)
    12f8:	e8 14 01 00 00       	call   1411 <open>
    12fd:	83 c4 10             	add    $0x10,%esp
    1300:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1303:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1307:	79 07                	jns    1310 <stat+0x2a>
    return -1;
    1309:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    130e:	eb 25                	jmp    1335 <stat+0x4f>
  r = fstat(fd, st);
    1310:	83 ec 08             	sub    $0x8,%esp
    1313:	ff 75 0c             	pushl  0xc(%ebp)
    1316:	ff 75 f4             	pushl  -0xc(%ebp)
    1319:	e8 0b 01 00 00       	call   1429 <fstat>
    131e:	83 c4 10             	add    $0x10,%esp
    1321:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1324:	83 ec 0c             	sub    $0xc,%esp
    1327:	ff 75 f4             	pushl  -0xc(%ebp)
    132a:	e8 ca 00 00 00       	call   13f9 <close>
    132f:	83 c4 10             	add    $0x10,%esp
  return r;
    1332:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1335:	c9                   	leave  
    1336:	c3                   	ret    

00001337 <atoi>:

int
atoi(const char *s)
{
    1337:	f3 0f 1e fb          	endbr32 
    133b:	55                   	push   %ebp
    133c:	89 e5                	mov    %esp,%ebp
    133e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1341:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1348:	eb 25                	jmp    136f <atoi+0x38>
    n = n*10 + *s++ - '0';
    134a:	8b 55 fc             	mov    -0x4(%ebp),%edx
    134d:	89 d0                	mov    %edx,%eax
    134f:	c1 e0 02             	shl    $0x2,%eax
    1352:	01 d0                	add    %edx,%eax
    1354:	01 c0                	add    %eax,%eax
    1356:	89 c1                	mov    %eax,%ecx
    1358:	8b 45 08             	mov    0x8(%ebp),%eax
    135b:	8d 50 01             	lea    0x1(%eax),%edx
    135e:	89 55 08             	mov    %edx,0x8(%ebp)
    1361:	0f b6 00             	movzbl (%eax),%eax
    1364:	0f be c0             	movsbl %al,%eax
    1367:	01 c8                	add    %ecx,%eax
    1369:	83 e8 30             	sub    $0x30,%eax
    136c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    136f:	8b 45 08             	mov    0x8(%ebp),%eax
    1372:	0f b6 00             	movzbl (%eax),%eax
    1375:	3c 2f                	cmp    $0x2f,%al
    1377:	7e 0a                	jle    1383 <atoi+0x4c>
    1379:	8b 45 08             	mov    0x8(%ebp),%eax
    137c:	0f b6 00             	movzbl (%eax),%eax
    137f:	3c 39                	cmp    $0x39,%al
    1381:	7e c7                	jle    134a <atoi+0x13>
  return n;
    1383:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1386:	c9                   	leave  
    1387:	c3                   	ret    

00001388 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1388:	f3 0f 1e fb          	endbr32 
    138c:	55                   	push   %ebp
    138d:	89 e5                	mov    %esp,%ebp
    138f:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    1392:	8b 45 08             	mov    0x8(%ebp),%eax
    1395:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1398:	8b 45 0c             	mov    0xc(%ebp),%eax
    139b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    139e:	eb 17                	jmp    13b7 <memmove+0x2f>
    *dst++ = *src++;
    13a0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    13a3:	8d 42 01             	lea    0x1(%edx),%eax
    13a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
    13a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13ac:	8d 48 01             	lea    0x1(%eax),%ecx
    13af:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    13b2:	0f b6 12             	movzbl (%edx),%edx
    13b5:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    13b7:	8b 45 10             	mov    0x10(%ebp),%eax
    13ba:	8d 50 ff             	lea    -0x1(%eax),%edx
    13bd:	89 55 10             	mov    %edx,0x10(%ebp)
    13c0:	85 c0                	test   %eax,%eax
    13c2:	7f dc                	jg     13a0 <memmove+0x18>
  return vdst;
    13c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
    13c7:	c9                   	leave  
    13c8:	c3                   	ret    

000013c9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13c9:	b8 01 00 00 00       	mov    $0x1,%eax
    13ce:	cd 40                	int    $0x40
    13d0:	c3                   	ret    

000013d1 <exit>:
SYSCALL(exit)
    13d1:	b8 02 00 00 00       	mov    $0x2,%eax
    13d6:	cd 40                	int    $0x40
    13d8:	c3                   	ret    

000013d9 <wait>:
SYSCALL(wait)
    13d9:	b8 03 00 00 00       	mov    $0x3,%eax
    13de:	cd 40                	int    $0x40
    13e0:	c3                   	ret    

000013e1 <pipe>:
SYSCALL(pipe)
    13e1:	b8 04 00 00 00       	mov    $0x4,%eax
    13e6:	cd 40                	int    $0x40
    13e8:	c3                   	ret    

000013e9 <read>:
SYSCALL(read)
    13e9:	b8 05 00 00 00       	mov    $0x5,%eax
    13ee:	cd 40                	int    $0x40
    13f0:	c3                   	ret    

000013f1 <write>:
SYSCALL(write)
    13f1:	b8 10 00 00 00       	mov    $0x10,%eax
    13f6:	cd 40                	int    $0x40
    13f8:	c3                   	ret    

000013f9 <close>:
SYSCALL(close)
    13f9:	b8 15 00 00 00       	mov    $0x15,%eax
    13fe:	cd 40                	int    $0x40
    1400:	c3                   	ret    

00001401 <kill>:
SYSCALL(kill)
    1401:	b8 06 00 00 00       	mov    $0x6,%eax
    1406:	cd 40                	int    $0x40
    1408:	c3                   	ret    

00001409 <exec>:
SYSCALL(exec)
    1409:	b8 07 00 00 00       	mov    $0x7,%eax
    140e:	cd 40                	int    $0x40
    1410:	c3                   	ret    

00001411 <open>:
SYSCALL(open)
    1411:	b8 0f 00 00 00       	mov    $0xf,%eax
    1416:	cd 40                	int    $0x40
    1418:	c3                   	ret    

00001419 <mknod>:
SYSCALL(mknod)
    1419:	b8 11 00 00 00       	mov    $0x11,%eax
    141e:	cd 40                	int    $0x40
    1420:	c3                   	ret    

00001421 <unlink>:
SYSCALL(unlink)
    1421:	b8 12 00 00 00       	mov    $0x12,%eax
    1426:	cd 40                	int    $0x40
    1428:	c3                   	ret    

00001429 <fstat>:
SYSCALL(fstat)
    1429:	b8 08 00 00 00       	mov    $0x8,%eax
    142e:	cd 40                	int    $0x40
    1430:	c3                   	ret    

00001431 <link>:
SYSCALL(link)
    1431:	b8 13 00 00 00       	mov    $0x13,%eax
    1436:	cd 40                	int    $0x40
    1438:	c3                   	ret    

00001439 <mkdir>:
SYSCALL(mkdir)
    1439:	b8 14 00 00 00       	mov    $0x14,%eax
    143e:	cd 40                	int    $0x40
    1440:	c3                   	ret    

00001441 <chdir>:
SYSCALL(chdir)
    1441:	b8 09 00 00 00       	mov    $0x9,%eax
    1446:	cd 40                	int    $0x40
    1448:	c3                   	ret    

00001449 <dup>:
SYSCALL(dup)
    1449:	b8 0a 00 00 00       	mov    $0xa,%eax
    144e:	cd 40                	int    $0x40
    1450:	c3                   	ret    

00001451 <getpid>:
SYSCALL(getpid)
    1451:	b8 0b 00 00 00       	mov    $0xb,%eax
    1456:	cd 40                	int    $0x40
    1458:	c3                   	ret    

00001459 <sbrk>:
SYSCALL(sbrk)
    1459:	b8 0c 00 00 00       	mov    $0xc,%eax
    145e:	cd 40                	int    $0x40
    1460:	c3                   	ret    

00001461 <sleep>:
SYSCALL(sleep)
    1461:	b8 0d 00 00 00       	mov    $0xd,%eax
    1466:	cd 40                	int    $0x40
    1468:	c3                   	ret    

00001469 <uptime>:
SYSCALL(uptime)
    1469:	b8 0e 00 00 00       	mov    $0xe,%eax
    146e:	cd 40                	int    $0x40
    1470:	c3                   	ret    

00001471 <settickets>:
SYSCALL(settickets)
    1471:	b8 16 00 00 00       	mov    $0x16,%eax
    1476:	cd 40                	int    $0x40
    1478:	c3                   	ret    

00001479 <getpinfo>:
SYSCALL(getpinfo)
    1479:	b8 17 00 00 00       	mov    $0x17,%eax
    147e:	cd 40                	int    $0x40
    1480:	c3                   	ret    

00001481 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1481:	f3 0f 1e fb          	endbr32 
    1485:	55                   	push   %ebp
    1486:	89 e5                	mov    %esp,%ebp
    1488:	83 ec 18             	sub    $0x18,%esp
    148b:	8b 45 0c             	mov    0xc(%ebp),%eax
    148e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1491:	83 ec 04             	sub    $0x4,%esp
    1494:	6a 01                	push   $0x1
    1496:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1499:	50                   	push   %eax
    149a:	ff 75 08             	pushl  0x8(%ebp)
    149d:	e8 4f ff ff ff       	call   13f1 <write>
    14a2:	83 c4 10             	add    $0x10,%esp
}
    14a5:	90                   	nop
    14a6:	c9                   	leave  
    14a7:	c3                   	ret    

000014a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    14a8:	f3 0f 1e fb          	endbr32 
    14ac:	55                   	push   %ebp
    14ad:	89 e5                	mov    %esp,%ebp
    14af:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    14b2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    14b9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    14bd:	74 17                	je     14d6 <printint+0x2e>
    14bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14c3:	79 11                	jns    14d6 <printint+0x2e>
    neg = 1;
    14c5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    14cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    14cf:	f7 d8                	neg    %eax
    14d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14d4:	eb 06                	jmp    14dc <printint+0x34>
  } else {
    x = xx;
    14d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    14d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    14dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    14e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
    14e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14e9:	ba 00 00 00 00       	mov    $0x0,%edx
    14ee:	f7 f1                	div    %ecx
    14f0:	89 d1                	mov    %edx,%ecx
    14f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f5:	8d 50 01             	lea    0x1(%eax),%edx
    14f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14fb:	0f b6 91 94 1b 00 00 	movzbl 0x1b94(%ecx),%edx
    1502:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1506:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1509:	8b 45 ec             	mov    -0x14(%ebp),%eax
    150c:	ba 00 00 00 00       	mov    $0x0,%edx
    1511:	f7 f1                	div    %ecx
    1513:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1516:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    151a:	75 c7                	jne    14e3 <printint+0x3b>
  if(neg)
    151c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1520:	74 2d                	je     154f <printint+0xa7>
    buf[i++] = '-';
    1522:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1525:	8d 50 01             	lea    0x1(%eax),%edx
    1528:	89 55 f4             	mov    %edx,-0xc(%ebp)
    152b:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1530:	eb 1d                	jmp    154f <printint+0xa7>
    putc(fd, buf[i]);
    1532:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1535:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1538:	01 d0                	add    %edx,%eax
    153a:	0f b6 00             	movzbl (%eax),%eax
    153d:	0f be c0             	movsbl %al,%eax
    1540:	83 ec 08             	sub    $0x8,%esp
    1543:	50                   	push   %eax
    1544:	ff 75 08             	pushl  0x8(%ebp)
    1547:	e8 35 ff ff ff       	call   1481 <putc>
    154c:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    154f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1553:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1557:	79 d9                	jns    1532 <printint+0x8a>
}
    1559:	90                   	nop
    155a:	90                   	nop
    155b:	c9                   	leave  
    155c:	c3                   	ret    

0000155d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    155d:	f3 0f 1e fb          	endbr32 
    1561:	55                   	push   %ebp
    1562:	89 e5                	mov    %esp,%ebp
    1564:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1567:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    156e:	8d 45 0c             	lea    0xc(%ebp),%eax
    1571:	83 c0 04             	add    $0x4,%eax
    1574:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1577:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    157e:	e9 59 01 00 00       	jmp    16dc <printf+0x17f>
    c = fmt[i] & 0xff;
    1583:	8b 55 0c             	mov    0xc(%ebp),%edx
    1586:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1589:	01 d0                	add    %edx,%eax
    158b:	0f b6 00             	movzbl (%eax),%eax
    158e:	0f be c0             	movsbl %al,%eax
    1591:	25 ff 00 00 00       	and    $0xff,%eax
    1596:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1599:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    159d:	75 2c                	jne    15cb <printf+0x6e>
      if(c == '%'){
    159f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15a3:	75 0c                	jne    15b1 <printf+0x54>
        state = '%';
    15a5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    15ac:	e9 27 01 00 00       	jmp    16d8 <printf+0x17b>
      } else {
        putc(fd, c);
    15b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15b4:	0f be c0             	movsbl %al,%eax
    15b7:	83 ec 08             	sub    $0x8,%esp
    15ba:	50                   	push   %eax
    15bb:	ff 75 08             	pushl  0x8(%ebp)
    15be:	e8 be fe ff ff       	call   1481 <putc>
    15c3:	83 c4 10             	add    $0x10,%esp
    15c6:	e9 0d 01 00 00       	jmp    16d8 <printf+0x17b>
      }
    } else if(state == '%'){
    15cb:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    15cf:	0f 85 03 01 00 00    	jne    16d8 <printf+0x17b>
      if(c == 'd'){
    15d5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    15d9:	75 1e                	jne    15f9 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    15db:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15de:	8b 00                	mov    (%eax),%eax
    15e0:	6a 01                	push   $0x1
    15e2:	6a 0a                	push   $0xa
    15e4:	50                   	push   %eax
    15e5:	ff 75 08             	pushl  0x8(%ebp)
    15e8:	e8 bb fe ff ff       	call   14a8 <printint>
    15ed:	83 c4 10             	add    $0x10,%esp
        ap++;
    15f0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15f4:	e9 d8 00 00 00       	jmp    16d1 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    15f9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    15fd:	74 06                	je     1605 <printf+0xa8>
    15ff:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1603:	75 1e                	jne    1623 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1605:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1608:	8b 00                	mov    (%eax),%eax
    160a:	6a 00                	push   $0x0
    160c:	6a 10                	push   $0x10
    160e:	50                   	push   %eax
    160f:	ff 75 08             	pushl  0x8(%ebp)
    1612:	e8 91 fe ff ff       	call   14a8 <printint>
    1617:	83 c4 10             	add    $0x10,%esp
        ap++;
    161a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    161e:	e9 ae 00 00 00       	jmp    16d1 <printf+0x174>
      } else if(c == 's'){
    1623:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1627:	75 43                	jne    166c <printf+0x10f>
        s = (char*)*ap;
    1629:	8b 45 e8             	mov    -0x18(%ebp),%eax
    162c:	8b 00                	mov    (%eax),%eax
    162e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1631:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1635:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1639:	75 25                	jne    1660 <printf+0x103>
          s = "(null)";
    163b:	c7 45 f4 47 19 00 00 	movl   $0x1947,-0xc(%ebp)
        while(*s != 0){
    1642:	eb 1c                	jmp    1660 <printf+0x103>
          putc(fd, *s);
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1647:	0f b6 00             	movzbl (%eax),%eax
    164a:	0f be c0             	movsbl %al,%eax
    164d:	83 ec 08             	sub    $0x8,%esp
    1650:	50                   	push   %eax
    1651:	ff 75 08             	pushl  0x8(%ebp)
    1654:	e8 28 fe ff ff       	call   1481 <putc>
    1659:	83 c4 10             	add    $0x10,%esp
          s++;
    165c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1660:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1663:	0f b6 00             	movzbl (%eax),%eax
    1666:	84 c0                	test   %al,%al
    1668:	75 da                	jne    1644 <printf+0xe7>
    166a:	eb 65                	jmp    16d1 <printf+0x174>
        }
      } else if(c == 'c'){
    166c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1670:	75 1d                	jne    168f <printf+0x132>
        putc(fd, *ap);
    1672:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1675:	8b 00                	mov    (%eax),%eax
    1677:	0f be c0             	movsbl %al,%eax
    167a:	83 ec 08             	sub    $0x8,%esp
    167d:	50                   	push   %eax
    167e:	ff 75 08             	pushl  0x8(%ebp)
    1681:	e8 fb fd ff ff       	call   1481 <putc>
    1686:	83 c4 10             	add    $0x10,%esp
        ap++;
    1689:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    168d:	eb 42                	jmp    16d1 <printf+0x174>
      } else if(c == '%'){
    168f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1693:	75 17                	jne    16ac <printf+0x14f>
        putc(fd, c);
    1695:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1698:	0f be c0             	movsbl %al,%eax
    169b:	83 ec 08             	sub    $0x8,%esp
    169e:	50                   	push   %eax
    169f:	ff 75 08             	pushl  0x8(%ebp)
    16a2:	e8 da fd ff ff       	call   1481 <putc>
    16a7:	83 c4 10             	add    $0x10,%esp
    16aa:	eb 25                	jmp    16d1 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    16ac:	83 ec 08             	sub    $0x8,%esp
    16af:	6a 25                	push   $0x25
    16b1:	ff 75 08             	pushl  0x8(%ebp)
    16b4:	e8 c8 fd ff ff       	call   1481 <putc>
    16b9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    16bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16bf:	0f be c0             	movsbl %al,%eax
    16c2:	83 ec 08             	sub    $0x8,%esp
    16c5:	50                   	push   %eax
    16c6:	ff 75 08             	pushl  0x8(%ebp)
    16c9:	e8 b3 fd ff ff       	call   1481 <putc>
    16ce:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    16d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    16d8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16dc:	8b 55 0c             	mov    0xc(%ebp),%edx
    16df:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16e2:	01 d0                	add    %edx,%eax
    16e4:	0f b6 00             	movzbl (%eax),%eax
    16e7:	84 c0                	test   %al,%al
    16e9:	0f 85 94 fe ff ff    	jne    1583 <printf+0x26>
    }
  }
}
    16ef:	90                   	nop
    16f0:	90                   	nop
    16f1:	c9                   	leave  
    16f2:	c3                   	ret    

000016f3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16f3:	f3 0f 1e fb          	endbr32 
    16f7:	55                   	push   %ebp
    16f8:	89 e5                	mov    %esp,%ebp
    16fa:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1700:	83 e8 08             	sub    $0x8,%eax
    1703:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1706:	a1 b0 1b 00 00       	mov    0x1bb0,%eax
    170b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    170e:	eb 24                	jmp    1734 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1710:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1713:	8b 00                	mov    (%eax),%eax
    1715:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1718:	72 12                	jb     172c <free+0x39>
    171a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    171d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1720:	77 24                	ja     1746 <free+0x53>
    1722:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1725:	8b 00                	mov    (%eax),%eax
    1727:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    172a:	72 1a                	jb     1746 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    172c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    172f:	8b 00                	mov    (%eax),%eax
    1731:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1734:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1737:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    173a:	76 d4                	jbe    1710 <free+0x1d>
    173c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    173f:	8b 00                	mov    (%eax),%eax
    1741:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1744:	73 ca                	jae    1710 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1746:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1749:	8b 40 04             	mov    0x4(%eax),%eax
    174c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1753:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1756:	01 c2                	add    %eax,%edx
    1758:	8b 45 fc             	mov    -0x4(%ebp),%eax
    175b:	8b 00                	mov    (%eax),%eax
    175d:	39 c2                	cmp    %eax,%edx
    175f:	75 24                	jne    1785 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1761:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1764:	8b 50 04             	mov    0x4(%eax),%edx
    1767:	8b 45 fc             	mov    -0x4(%ebp),%eax
    176a:	8b 00                	mov    (%eax),%eax
    176c:	8b 40 04             	mov    0x4(%eax),%eax
    176f:	01 c2                	add    %eax,%edx
    1771:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1774:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1777:	8b 45 fc             	mov    -0x4(%ebp),%eax
    177a:	8b 00                	mov    (%eax),%eax
    177c:	8b 10                	mov    (%eax),%edx
    177e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1781:	89 10                	mov    %edx,(%eax)
    1783:	eb 0a                	jmp    178f <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1785:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1788:	8b 10                	mov    (%eax),%edx
    178a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    178d:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    178f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1792:	8b 40 04             	mov    0x4(%eax),%eax
    1795:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    179c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179f:	01 d0                	add    %edx,%eax
    17a1:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    17a4:	75 20                	jne    17c6 <free+0xd3>
    p->s.size += bp->s.size;
    17a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a9:	8b 50 04             	mov    0x4(%eax),%edx
    17ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17af:	8b 40 04             	mov    0x4(%eax),%eax
    17b2:	01 c2                	add    %eax,%edx
    17b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    17ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17bd:	8b 10                	mov    (%eax),%edx
    17bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c2:	89 10                	mov    %edx,(%eax)
    17c4:	eb 08                	jmp    17ce <free+0xdb>
  } else
    p->s.ptr = bp;
    17c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c9:	8b 55 f8             	mov    -0x8(%ebp),%edx
    17cc:	89 10                	mov    %edx,(%eax)
  freep = p;
    17ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d1:	a3 b0 1b 00 00       	mov    %eax,0x1bb0
}
    17d6:	90                   	nop
    17d7:	c9                   	leave  
    17d8:	c3                   	ret    

000017d9 <morecore>:

static Header*
morecore(uint nu)
{
    17d9:	f3 0f 1e fb          	endbr32 
    17dd:	55                   	push   %ebp
    17de:	89 e5                	mov    %esp,%ebp
    17e0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    17e3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    17ea:	77 07                	ja     17f3 <morecore+0x1a>
    nu = 4096;
    17ec:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    17f3:	8b 45 08             	mov    0x8(%ebp),%eax
    17f6:	c1 e0 03             	shl    $0x3,%eax
    17f9:	83 ec 0c             	sub    $0xc,%esp
    17fc:	50                   	push   %eax
    17fd:	e8 57 fc ff ff       	call   1459 <sbrk>
    1802:	83 c4 10             	add    $0x10,%esp
    1805:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1808:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    180c:	75 07                	jne    1815 <morecore+0x3c>
    return 0;
    180e:	b8 00 00 00 00       	mov    $0x0,%eax
    1813:	eb 26                	jmp    183b <morecore+0x62>
  hp = (Header*)p;
    1815:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1818:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    181b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    181e:	8b 55 08             	mov    0x8(%ebp),%edx
    1821:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1824:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1827:	83 c0 08             	add    $0x8,%eax
    182a:	83 ec 0c             	sub    $0xc,%esp
    182d:	50                   	push   %eax
    182e:	e8 c0 fe ff ff       	call   16f3 <free>
    1833:	83 c4 10             	add    $0x10,%esp
  return freep;
    1836:	a1 b0 1b 00 00       	mov    0x1bb0,%eax
}
    183b:	c9                   	leave  
    183c:	c3                   	ret    

0000183d <malloc>:

void*
malloc(uint nbytes)
{
    183d:	f3 0f 1e fb          	endbr32 
    1841:	55                   	push   %ebp
    1842:	89 e5                	mov    %esp,%ebp
    1844:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1847:	8b 45 08             	mov    0x8(%ebp),%eax
    184a:	83 c0 07             	add    $0x7,%eax
    184d:	c1 e8 03             	shr    $0x3,%eax
    1850:	83 c0 01             	add    $0x1,%eax
    1853:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1856:	a1 b0 1b 00 00       	mov    0x1bb0,%eax
    185b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    185e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1862:	75 23                	jne    1887 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1864:	c7 45 f0 a8 1b 00 00 	movl   $0x1ba8,-0x10(%ebp)
    186b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    186e:	a3 b0 1b 00 00       	mov    %eax,0x1bb0
    1873:	a1 b0 1b 00 00       	mov    0x1bb0,%eax
    1878:	a3 a8 1b 00 00       	mov    %eax,0x1ba8
    base.s.size = 0;
    187d:	c7 05 ac 1b 00 00 00 	movl   $0x0,0x1bac
    1884:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1887:	8b 45 f0             	mov    -0x10(%ebp),%eax
    188a:	8b 00                	mov    (%eax),%eax
    188c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    188f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1892:	8b 40 04             	mov    0x4(%eax),%eax
    1895:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1898:	77 4d                	ja     18e7 <malloc+0xaa>
      if(p->s.size == nunits)
    189a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189d:	8b 40 04             	mov    0x4(%eax),%eax
    18a0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    18a3:	75 0c                	jne    18b1 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    18a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a8:	8b 10                	mov    (%eax),%edx
    18aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18ad:	89 10                	mov    %edx,(%eax)
    18af:	eb 26                	jmp    18d7 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    18b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b4:	8b 40 04             	mov    0x4(%eax),%eax
    18b7:	2b 45 ec             	sub    -0x14(%ebp),%eax
    18ba:	89 c2                	mov    %eax,%edx
    18bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18bf:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    18c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c5:	8b 40 04             	mov    0x4(%eax),%eax
    18c8:	c1 e0 03             	shl    $0x3,%eax
    18cb:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    18ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    18d4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    18d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18da:	a3 b0 1b 00 00       	mov    %eax,0x1bb0
      return (void*)(p + 1);
    18df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e2:	83 c0 08             	add    $0x8,%eax
    18e5:	eb 3b                	jmp    1922 <malloc+0xe5>
    }
    if(p == freep)
    18e7:	a1 b0 1b 00 00       	mov    0x1bb0,%eax
    18ec:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    18ef:	75 1e                	jne    190f <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    18f1:	83 ec 0c             	sub    $0xc,%esp
    18f4:	ff 75 ec             	pushl  -0x14(%ebp)
    18f7:	e8 dd fe ff ff       	call   17d9 <morecore>
    18fc:	83 c4 10             	add    $0x10,%esp
    18ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1902:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1906:	75 07                	jne    190f <malloc+0xd2>
        return 0;
    1908:	b8 00 00 00 00       	mov    $0x0,%eax
    190d:	eb 13                	jmp    1922 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    190f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1912:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1915:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1918:	8b 00                	mov    (%eax),%eax
    191a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    191d:	e9 6d ff ff ff       	jmp    188f <malloc+0x52>
  }
}
    1922:	c9                   	leave  
    1923:	c3                   	ret    
