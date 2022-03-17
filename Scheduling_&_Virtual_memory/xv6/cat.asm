
_cat:     file format elf32-i386


Disassembly of section .text:

00001000 <cat>:

char buf[512];

void
cat(int fd)
{
    1000:	f3 0f 1e fb          	endbr32 
    1004:	55                   	push   %ebp
    1005:	89 e5                	mov    %esp,%ebp
    1007:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    100a:	eb 31                	jmp    103d <cat+0x3d>
    if (write(1, buf, n) != n) {
    100c:	83 ec 04             	sub    $0x4,%esp
    100f:	ff 75 f4             	pushl  -0xc(%ebp)
    1012:	68 e0 1b 00 00       	push   $0x1be0
    1017:	6a 01                	push   $0x1
    1019:	e8 b0 03 00 00       	call   13ce <write>
    101e:	83 c4 10             	add    $0x10,%esp
    1021:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1024:	74 17                	je     103d <cat+0x3d>
      printf(1, "cat: write error\n");
    1026:	83 ec 08             	sub    $0x8,%esp
    1029:	68 01 19 00 00       	push   $0x1901
    102e:	6a 01                	push   $0x1
    1030:	e8 05 05 00 00       	call   153a <printf>
    1035:	83 c4 10             	add    $0x10,%esp
      exit();
    1038:	e8 71 03 00 00       	call   13ae <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    103d:	83 ec 04             	sub    $0x4,%esp
    1040:	68 00 02 00 00       	push   $0x200
    1045:	68 e0 1b 00 00       	push   $0x1be0
    104a:	ff 75 08             	pushl  0x8(%ebp)
    104d:	e8 74 03 00 00       	call   13c6 <read>
    1052:	83 c4 10             	add    $0x10,%esp
    1055:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1058:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    105c:	7f ae                	jg     100c <cat+0xc>
    }
  }
  if(n < 0){
    105e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1062:	79 17                	jns    107b <cat+0x7b>
    printf(1, "cat: read error\n");
    1064:	83 ec 08             	sub    $0x8,%esp
    1067:	68 13 19 00 00       	push   $0x1913
    106c:	6a 01                	push   $0x1
    106e:	e8 c7 04 00 00       	call   153a <printf>
    1073:	83 c4 10             	add    $0x10,%esp
    exit();
    1076:	e8 33 03 00 00       	call   13ae <exit>
  }
}
    107b:	90                   	nop
    107c:	c9                   	leave  
    107d:	c3                   	ret    

0000107e <main>:

int
main(int argc, char *argv[])
{
    107e:	f3 0f 1e fb          	endbr32 
    1082:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1086:	83 e4 f0             	and    $0xfffffff0,%esp
    1089:	ff 71 fc             	pushl  -0x4(%ecx)
    108c:	55                   	push   %ebp
    108d:	89 e5                	mov    %esp,%ebp
    108f:	53                   	push   %ebx
    1090:	51                   	push   %ecx
    1091:	83 ec 10             	sub    $0x10,%esp
    1094:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
    1096:	83 3b 01             	cmpl   $0x1,(%ebx)
    1099:	7f 12                	jg     10ad <main+0x2f>
    cat(0);
    109b:	83 ec 0c             	sub    $0xc,%esp
    109e:	6a 00                	push   $0x0
    10a0:	e8 5b ff ff ff       	call   1000 <cat>
    10a5:	83 c4 10             	add    $0x10,%esp
    exit();
    10a8:	e8 01 03 00 00       	call   13ae <exit>
  }

  for(i = 1; i < argc; i++){
    10ad:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    10b4:	eb 71                	jmp    1127 <main+0xa9>
    if((fd = open(argv[i], 0)) < 0){
    10b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    10c0:	8b 43 04             	mov    0x4(%ebx),%eax
    10c3:	01 d0                	add    %edx,%eax
    10c5:	8b 00                	mov    (%eax),%eax
    10c7:	83 ec 08             	sub    $0x8,%esp
    10ca:	6a 00                	push   $0x0
    10cc:	50                   	push   %eax
    10cd:	e8 1c 03 00 00       	call   13ee <open>
    10d2:	83 c4 10             	add    $0x10,%esp
    10d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    10d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10dc:	79 29                	jns    1107 <main+0x89>
      printf(1, "cat: cannot open %s\n", argv[i]);
    10de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10e1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    10e8:	8b 43 04             	mov    0x4(%ebx),%eax
    10eb:	01 d0                	add    %edx,%eax
    10ed:	8b 00                	mov    (%eax),%eax
    10ef:	83 ec 04             	sub    $0x4,%esp
    10f2:	50                   	push   %eax
    10f3:	68 24 19 00 00       	push   $0x1924
    10f8:	6a 01                	push   $0x1
    10fa:	e8 3b 04 00 00       	call   153a <printf>
    10ff:	83 c4 10             	add    $0x10,%esp
      exit();
    1102:	e8 a7 02 00 00       	call   13ae <exit>
    }
    cat(fd);
    1107:	83 ec 0c             	sub    $0xc,%esp
    110a:	ff 75 f0             	pushl  -0x10(%ebp)
    110d:	e8 ee fe ff ff       	call   1000 <cat>
    1112:	83 c4 10             	add    $0x10,%esp
    close(fd);
    1115:	83 ec 0c             	sub    $0xc,%esp
    1118:	ff 75 f0             	pushl  -0x10(%ebp)
    111b:	e8 b6 02 00 00       	call   13d6 <close>
    1120:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
    1123:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1127:	8b 45 f4             	mov    -0xc(%ebp),%eax
    112a:	3b 03                	cmp    (%ebx),%eax
    112c:	7c 88                	jl     10b6 <main+0x38>
  }
  exit();
    112e:	e8 7b 02 00 00       	call   13ae <exit>

00001133 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1133:	55                   	push   %ebp
    1134:	89 e5                	mov    %esp,%ebp
    1136:	57                   	push   %edi
    1137:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1138:	8b 4d 08             	mov    0x8(%ebp),%ecx
    113b:	8b 55 10             	mov    0x10(%ebp),%edx
    113e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1141:	89 cb                	mov    %ecx,%ebx
    1143:	89 df                	mov    %ebx,%edi
    1145:	89 d1                	mov    %edx,%ecx
    1147:	fc                   	cld    
    1148:	f3 aa                	rep stos %al,%es:(%edi)
    114a:	89 ca                	mov    %ecx,%edx
    114c:	89 fb                	mov    %edi,%ebx
    114e:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1151:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1154:	90                   	nop
    1155:	5b                   	pop    %ebx
    1156:	5f                   	pop    %edi
    1157:	5d                   	pop    %ebp
    1158:	c3                   	ret    

00001159 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1159:	f3 0f 1e fb          	endbr32 
    115d:	55                   	push   %ebp
    115e:	89 e5                	mov    %esp,%ebp
    1160:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1163:	8b 45 08             	mov    0x8(%ebp),%eax
    1166:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1169:	90                   	nop
    116a:	8b 55 0c             	mov    0xc(%ebp),%edx
    116d:	8d 42 01             	lea    0x1(%edx),%eax
    1170:	89 45 0c             	mov    %eax,0xc(%ebp)
    1173:	8b 45 08             	mov    0x8(%ebp),%eax
    1176:	8d 48 01             	lea    0x1(%eax),%ecx
    1179:	89 4d 08             	mov    %ecx,0x8(%ebp)
    117c:	0f b6 12             	movzbl (%edx),%edx
    117f:	88 10                	mov    %dl,(%eax)
    1181:	0f b6 00             	movzbl (%eax),%eax
    1184:	84 c0                	test   %al,%al
    1186:	75 e2                	jne    116a <strcpy+0x11>
    ;
  return os;
    1188:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    118b:	c9                   	leave  
    118c:	c3                   	ret    

0000118d <strcmp>:

int
strcmp(const char *p, const char *q)
{
    118d:	f3 0f 1e fb          	endbr32 
    1191:	55                   	push   %ebp
    1192:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1194:	eb 08                	jmp    119e <strcmp+0x11>
    p++, q++;
    1196:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    119a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    119e:	8b 45 08             	mov    0x8(%ebp),%eax
    11a1:	0f b6 00             	movzbl (%eax),%eax
    11a4:	84 c0                	test   %al,%al
    11a6:	74 10                	je     11b8 <strcmp+0x2b>
    11a8:	8b 45 08             	mov    0x8(%ebp),%eax
    11ab:	0f b6 10             	movzbl (%eax),%edx
    11ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    11b1:	0f b6 00             	movzbl (%eax),%eax
    11b4:	38 c2                	cmp    %al,%dl
    11b6:	74 de                	je     1196 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    11b8:	8b 45 08             	mov    0x8(%ebp),%eax
    11bb:	0f b6 00             	movzbl (%eax),%eax
    11be:	0f b6 d0             	movzbl %al,%edx
    11c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c4:	0f b6 00             	movzbl (%eax),%eax
    11c7:	0f b6 c0             	movzbl %al,%eax
    11ca:	29 c2                	sub    %eax,%edx
    11cc:	89 d0                	mov    %edx,%eax
}
    11ce:	5d                   	pop    %ebp
    11cf:	c3                   	ret    

000011d0 <strlen>:

uint
strlen(const char *s)
{
    11d0:	f3 0f 1e fb          	endbr32 
    11d4:	55                   	push   %ebp
    11d5:	89 e5                	mov    %esp,%ebp
    11d7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    11da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    11e1:	eb 04                	jmp    11e7 <strlen+0x17>
    11e3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    11e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
    11ea:	8b 45 08             	mov    0x8(%ebp),%eax
    11ed:	01 d0                	add    %edx,%eax
    11ef:	0f b6 00             	movzbl (%eax),%eax
    11f2:	84 c0                	test   %al,%al
    11f4:	75 ed                	jne    11e3 <strlen+0x13>
    ;
  return n;
    11f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    11f9:	c9                   	leave  
    11fa:	c3                   	ret    

000011fb <memset>:

void*
memset(void *dst, int c, uint n)
{
    11fb:	f3 0f 1e fb          	endbr32 
    11ff:	55                   	push   %ebp
    1200:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1202:	8b 45 10             	mov    0x10(%ebp),%eax
    1205:	50                   	push   %eax
    1206:	ff 75 0c             	pushl  0xc(%ebp)
    1209:	ff 75 08             	pushl  0x8(%ebp)
    120c:	e8 22 ff ff ff       	call   1133 <stosb>
    1211:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1214:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1217:	c9                   	leave  
    1218:	c3                   	ret    

00001219 <strchr>:

char*
strchr(const char *s, char c)
{
    1219:	f3 0f 1e fb          	endbr32 
    121d:	55                   	push   %ebp
    121e:	89 e5                	mov    %esp,%ebp
    1220:	83 ec 04             	sub    $0x4,%esp
    1223:	8b 45 0c             	mov    0xc(%ebp),%eax
    1226:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1229:	eb 14                	jmp    123f <strchr+0x26>
    if(*s == c)
    122b:	8b 45 08             	mov    0x8(%ebp),%eax
    122e:	0f b6 00             	movzbl (%eax),%eax
    1231:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1234:	75 05                	jne    123b <strchr+0x22>
      return (char*)s;
    1236:	8b 45 08             	mov    0x8(%ebp),%eax
    1239:	eb 13                	jmp    124e <strchr+0x35>
  for(; *s; s++)
    123b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    123f:	8b 45 08             	mov    0x8(%ebp),%eax
    1242:	0f b6 00             	movzbl (%eax),%eax
    1245:	84 c0                	test   %al,%al
    1247:	75 e2                	jne    122b <strchr+0x12>
  return 0;
    1249:	b8 00 00 00 00       	mov    $0x0,%eax
}
    124e:	c9                   	leave  
    124f:	c3                   	ret    

00001250 <gets>:

char*
gets(char *buf, int max)
{
    1250:	f3 0f 1e fb          	endbr32 
    1254:	55                   	push   %ebp
    1255:	89 e5                	mov    %esp,%ebp
    1257:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    125a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1261:	eb 42                	jmp    12a5 <gets+0x55>
    cc = read(0, &c, 1);
    1263:	83 ec 04             	sub    $0x4,%esp
    1266:	6a 01                	push   $0x1
    1268:	8d 45 ef             	lea    -0x11(%ebp),%eax
    126b:	50                   	push   %eax
    126c:	6a 00                	push   $0x0
    126e:	e8 53 01 00 00       	call   13c6 <read>
    1273:	83 c4 10             	add    $0x10,%esp
    1276:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1279:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    127d:	7e 33                	jle    12b2 <gets+0x62>
      break;
    buf[i++] = c;
    127f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1282:	8d 50 01             	lea    0x1(%eax),%edx
    1285:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1288:	89 c2                	mov    %eax,%edx
    128a:	8b 45 08             	mov    0x8(%ebp),%eax
    128d:	01 c2                	add    %eax,%edx
    128f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1293:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1295:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1299:	3c 0a                	cmp    $0xa,%al
    129b:	74 16                	je     12b3 <gets+0x63>
    129d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12a1:	3c 0d                	cmp    $0xd,%al
    12a3:	74 0e                	je     12b3 <gets+0x63>
  for(i=0; i+1 < max; ){
    12a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12a8:	83 c0 01             	add    $0x1,%eax
    12ab:	39 45 0c             	cmp    %eax,0xc(%ebp)
    12ae:	7f b3                	jg     1263 <gets+0x13>
    12b0:	eb 01                	jmp    12b3 <gets+0x63>
      break;
    12b2:	90                   	nop
      break;
  }
  buf[i] = '\0';
    12b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12b6:	8b 45 08             	mov    0x8(%ebp),%eax
    12b9:	01 d0                	add    %edx,%eax
    12bb:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    12be:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12c1:	c9                   	leave  
    12c2:	c3                   	ret    

000012c3 <stat>:

int
stat(const char *n, struct stat *st)
{
    12c3:	f3 0f 1e fb          	endbr32 
    12c7:	55                   	push   %ebp
    12c8:	89 e5                	mov    %esp,%ebp
    12ca:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12cd:	83 ec 08             	sub    $0x8,%esp
    12d0:	6a 00                	push   $0x0
    12d2:	ff 75 08             	pushl  0x8(%ebp)
    12d5:	e8 14 01 00 00       	call   13ee <open>
    12da:	83 c4 10             	add    $0x10,%esp
    12dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    12e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12e4:	79 07                	jns    12ed <stat+0x2a>
    return -1;
    12e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12eb:	eb 25                	jmp    1312 <stat+0x4f>
  r = fstat(fd, st);
    12ed:	83 ec 08             	sub    $0x8,%esp
    12f0:	ff 75 0c             	pushl  0xc(%ebp)
    12f3:	ff 75 f4             	pushl  -0xc(%ebp)
    12f6:	e8 0b 01 00 00       	call   1406 <fstat>
    12fb:	83 c4 10             	add    $0x10,%esp
    12fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1301:	83 ec 0c             	sub    $0xc,%esp
    1304:	ff 75 f4             	pushl  -0xc(%ebp)
    1307:	e8 ca 00 00 00       	call   13d6 <close>
    130c:	83 c4 10             	add    $0x10,%esp
  return r;
    130f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1312:	c9                   	leave  
    1313:	c3                   	ret    

00001314 <atoi>:

int
atoi(const char *s)
{
    1314:	f3 0f 1e fb          	endbr32 
    1318:	55                   	push   %ebp
    1319:	89 e5                	mov    %esp,%ebp
    131b:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    131e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1325:	eb 25                	jmp    134c <atoi+0x38>
    n = n*10 + *s++ - '0';
    1327:	8b 55 fc             	mov    -0x4(%ebp),%edx
    132a:	89 d0                	mov    %edx,%eax
    132c:	c1 e0 02             	shl    $0x2,%eax
    132f:	01 d0                	add    %edx,%eax
    1331:	01 c0                	add    %eax,%eax
    1333:	89 c1                	mov    %eax,%ecx
    1335:	8b 45 08             	mov    0x8(%ebp),%eax
    1338:	8d 50 01             	lea    0x1(%eax),%edx
    133b:	89 55 08             	mov    %edx,0x8(%ebp)
    133e:	0f b6 00             	movzbl (%eax),%eax
    1341:	0f be c0             	movsbl %al,%eax
    1344:	01 c8                	add    %ecx,%eax
    1346:	83 e8 30             	sub    $0x30,%eax
    1349:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    134c:	8b 45 08             	mov    0x8(%ebp),%eax
    134f:	0f b6 00             	movzbl (%eax),%eax
    1352:	3c 2f                	cmp    $0x2f,%al
    1354:	7e 0a                	jle    1360 <atoi+0x4c>
    1356:	8b 45 08             	mov    0x8(%ebp),%eax
    1359:	0f b6 00             	movzbl (%eax),%eax
    135c:	3c 39                	cmp    $0x39,%al
    135e:	7e c7                	jle    1327 <atoi+0x13>
  return n;
    1360:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1363:	c9                   	leave  
    1364:	c3                   	ret    

00001365 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1365:	f3 0f 1e fb          	endbr32 
    1369:	55                   	push   %ebp
    136a:	89 e5                	mov    %esp,%ebp
    136c:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    136f:	8b 45 08             	mov    0x8(%ebp),%eax
    1372:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1375:	8b 45 0c             	mov    0xc(%ebp),%eax
    1378:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    137b:	eb 17                	jmp    1394 <memmove+0x2f>
    *dst++ = *src++;
    137d:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1380:	8d 42 01             	lea    0x1(%edx),%eax
    1383:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1386:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1389:	8d 48 01             	lea    0x1(%eax),%ecx
    138c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    138f:	0f b6 12             	movzbl (%edx),%edx
    1392:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    1394:	8b 45 10             	mov    0x10(%ebp),%eax
    1397:	8d 50 ff             	lea    -0x1(%eax),%edx
    139a:	89 55 10             	mov    %edx,0x10(%ebp)
    139d:	85 c0                	test   %eax,%eax
    139f:	7f dc                	jg     137d <memmove+0x18>
  return vdst;
    13a1:	8b 45 08             	mov    0x8(%ebp),%eax
}
    13a4:	c9                   	leave  
    13a5:	c3                   	ret    

000013a6 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13a6:	b8 01 00 00 00       	mov    $0x1,%eax
    13ab:	cd 40                	int    $0x40
    13ad:	c3                   	ret    

000013ae <exit>:
SYSCALL(exit)
    13ae:	b8 02 00 00 00       	mov    $0x2,%eax
    13b3:	cd 40                	int    $0x40
    13b5:	c3                   	ret    

000013b6 <wait>:
SYSCALL(wait)
    13b6:	b8 03 00 00 00       	mov    $0x3,%eax
    13bb:	cd 40                	int    $0x40
    13bd:	c3                   	ret    

000013be <pipe>:
SYSCALL(pipe)
    13be:	b8 04 00 00 00       	mov    $0x4,%eax
    13c3:	cd 40                	int    $0x40
    13c5:	c3                   	ret    

000013c6 <read>:
SYSCALL(read)
    13c6:	b8 05 00 00 00       	mov    $0x5,%eax
    13cb:	cd 40                	int    $0x40
    13cd:	c3                   	ret    

000013ce <write>:
SYSCALL(write)
    13ce:	b8 10 00 00 00       	mov    $0x10,%eax
    13d3:	cd 40                	int    $0x40
    13d5:	c3                   	ret    

000013d6 <close>:
SYSCALL(close)
    13d6:	b8 15 00 00 00       	mov    $0x15,%eax
    13db:	cd 40                	int    $0x40
    13dd:	c3                   	ret    

000013de <kill>:
SYSCALL(kill)
    13de:	b8 06 00 00 00       	mov    $0x6,%eax
    13e3:	cd 40                	int    $0x40
    13e5:	c3                   	ret    

000013e6 <exec>:
SYSCALL(exec)
    13e6:	b8 07 00 00 00       	mov    $0x7,%eax
    13eb:	cd 40                	int    $0x40
    13ed:	c3                   	ret    

000013ee <open>:
SYSCALL(open)
    13ee:	b8 0f 00 00 00       	mov    $0xf,%eax
    13f3:	cd 40                	int    $0x40
    13f5:	c3                   	ret    

000013f6 <mknod>:
SYSCALL(mknod)
    13f6:	b8 11 00 00 00       	mov    $0x11,%eax
    13fb:	cd 40                	int    $0x40
    13fd:	c3                   	ret    

000013fe <unlink>:
SYSCALL(unlink)
    13fe:	b8 12 00 00 00       	mov    $0x12,%eax
    1403:	cd 40                	int    $0x40
    1405:	c3                   	ret    

00001406 <fstat>:
SYSCALL(fstat)
    1406:	b8 08 00 00 00       	mov    $0x8,%eax
    140b:	cd 40                	int    $0x40
    140d:	c3                   	ret    

0000140e <link>:
SYSCALL(link)
    140e:	b8 13 00 00 00       	mov    $0x13,%eax
    1413:	cd 40                	int    $0x40
    1415:	c3                   	ret    

00001416 <mkdir>:
SYSCALL(mkdir)
    1416:	b8 14 00 00 00       	mov    $0x14,%eax
    141b:	cd 40                	int    $0x40
    141d:	c3                   	ret    

0000141e <chdir>:
SYSCALL(chdir)
    141e:	b8 09 00 00 00       	mov    $0x9,%eax
    1423:	cd 40                	int    $0x40
    1425:	c3                   	ret    

00001426 <dup>:
SYSCALL(dup)
    1426:	b8 0a 00 00 00       	mov    $0xa,%eax
    142b:	cd 40                	int    $0x40
    142d:	c3                   	ret    

0000142e <getpid>:
SYSCALL(getpid)
    142e:	b8 0b 00 00 00       	mov    $0xb,%eax
    1433:	cd 40                	int    $0x40
    1435:	c3                   	ret    

00001436 <sbrk>:
SYSCALL(sbrk)
    1436:	b8 0c 00 00 00       	mov    $0xc,%eax
    143b:	cd 40                	int    $0x40
    143d:	c3                   	ret    

0000143e <sleep>:
SYSCALL(sleep)
    143e:	b8 0d 00 00 00       	mov    $0xd,%eax
    1443:	cd 40                	int    $0x40
    1445:	c3                   	ret    

00001446 <uptime>:
SYSCALL(uptime)
    1446:	b8 0e 00 00 00       	mov    $0xe,%eax
    144b:	cd 40                	int    $0x40
    144d:	c3                   	ret    

0000144e <settickets>:
SYSCALL(settickets)
    144e:	b8 16 00 00 00       	mov    $0x16,%eax
    1453:	cd 40                	int    $0x40
    1455:	c3                   	ret    

00001456 <getpinfo>:
SYSCALL(getpinfo)
    1456:	b8 17 00 00 00       	mov    $0x17,%eax
    145b:	cd 40                	int    $0x40
    145d:	c3                   	ret    

0000145e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    145e:	f3 0f 1e fb          	endbr32 
    1462:	55                   	push   %ebp
    1463:	89 e5                	mov    %esp,%ebp
    1465:	83 ec 18             	sub    $0x18,%esp
    1468:	8b 45 0c             	mov    0xc(%ebp),%eax
    146b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    146e:	83 ec 04             	sub    $0x4,%esp
    1471:	6a 01                	push   $0x1
    1473:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1476:	50                   	push   %eax
    1477:	ff 75 08             	pushl  0x8(%ebp)
    147a:	e8 4f ff ff ff       	call   13ce <write>
    147f:	83 c4 10             	add    $0x10,%esp
}
    1482:	90                   	nop
    1483:	c9                   	leave  
    1484:	c3                   	ret    

00001485 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1485:	f3 0f 1e fb          	endbr32 
    1489:	55                   	push   %ebp
    148a:	89 e5                	mov    %esp,%ebp
    148c:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    148f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1496:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    149a:	74 17                	je     14b3 <printint+0x2e>
    149c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14a0:	79 11                	jns    14b3 <printint+0x2e>
    neg = 1;
    14a2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    14a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ac:	f7 d8                	neg    %eax
    14ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14b1:	eb 06                	jmp    14b9 <printint+0x34>
  } else {
    x = xx;
    14b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    14b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    14b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    14c0:	8b 4d 10             	mov    0x10(%ebp),%ecx
    14c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14c6:	ba 00 00 00 00       	mov    $0x0,%edx
    14cb:	f7 f1                	div    %ecx
    14cd:	89 d1                	mov    %edx,%ecx
    14cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d2:	8d 50 01             	lea    0x1(%eax),%edx
    14d5:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14d8:	0f b6 91 a8 1b 00 00 	movzbl 0x1ba8(%ecx),%edx
    14df:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    14e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
    14e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14e9:	ba 00 00 00 00       	mov    $0x0,%edx
    14ee:	f7 f1                	div    %ecx
    14f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14f7:	75 c7                	jne    14c0 <printint+0x3b>
  if(neg)
    14f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14fd:	74 2d                	je     152c <printint+0xa7>
    buf[i++] = '-';
    14ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1502:	8d 50 01             	lea    0x1(%eax),%edx
    1505:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1508:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    150d:	eb 1d                	jmp    152c <printint+0xa7>
    putc(fd, buf[i]);
    150f:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1512:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1515:	01 d0                	add    %edx,%eax
    1517:	0f b6 00             	movzbl (%eax),%eax
    151a:	0f be c0             	movsbl %al,%eax
    151d:	83 ec 08             	sub    $0x8,%esp
    1520:	50                   	push   %eax
    1521:	ff 75 08             	pushl  0x8(%ebp)
    1524:	e8 35 ff ff ff       	call   145e <putc>
    1529:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    152c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1530:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1534:	79 d9                	jns    150f <printint+0x8a>
}
    1536:	90                   	nop
    1537:	90                   	nop
    1538:	c9                   	leave  
    1539:	c3                   	ret    

0000153a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    153a:	f3 0f 1e fb          	endbr32 
    153e:	55                   	push   %ebp
    153f:	89 e5                	mov    %esp,%ebp
    1541:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1544:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    154b:	8d 45 0c             	lea    0xc(%ebp),%eax
    154e:	83 c0 04             	add    $0x4,%eax
    1551:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1554:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    155b:	e9 59 01 00 00       	jmp    16b9 <printf+0x17f>
    c = fmt[i] & 0xff;
    1560:	8b 55 0c             	mov    0xc(%ebp),%edx
    1563:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1566:	01 d0                	add    %edx,%eax
    1568:	0f b6 00             	movzbl (%eax),%eax
    156b:	0f be c0             	movsbl %al,%eax
    156e:	25 ff 00 00 00       	and    $0xff,%eax
    1573:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1576:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    157a:	75 2c                	jne    15a8 <printf+0x6e>
      if(c == '%'){
    157c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1580:	75 0c                	jne    158e <printf+0x54>
        state = '%';
    1582:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1589:	e9 27 01 00 00       	jmp    16b5 <printf+0x17b>
      } else {
        putc(fd, c);
    158e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1591:	0f be c0             	movsbl %al,%eax
    1594:	83 ec 08             	sub    $0x8,%esp
    1597:	50                   	push   %eax
    1598:	ff 75 08             	pushl  0x8(%ebp)
    159b:	e8 be fe ff ff       	call   145e <putc>
    15a0:	83 c4 10             	add    $0x10,%esp
    15a3:	e9 0d 01 00 00       	jmp    16b5 <printf+0x17b>
      }
    } else if(state == '%'){
    15a8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    15ac:	0f 85 03 01 00 00    	jne    16b5 <printf+0x17b>
      if(c == 'd'){
    15b2:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    15b6:	75 1e                	jne    15d6 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    15b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15bb:	8b 00                	mov    (%eax),%eax
    15bd:	6a 01                	push   $0x1
    15bf:	6a 0a                	push   $0xa
    15c1:	50                   	push   %eax
    15c2:	ff 75 08             	pushl  0x8(%ebp)
    15c5:	e8 bb fe ff ff       	call   1485 <printint>
    15ca:	83 c4 10             	add    $0x10,%esp
        ap++;
    15cd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15d1:	e9 d8 00 00 00       	jmp    16ae <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    15d6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    15da:	74 06                	je     15e2 <printf+0xa8>
    15dc:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    15e0:	75 1e                	jne    1600 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    15e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15e5:	8b 00                	mov    (%eax),%eax
    15e7:	6a 00                	push   $0x0
    15e9:	6a 10                	push   $0x10
    15eb:	50                   	push   %eax
    15ec:	ff 75 08             	pushl  0x8(%ebp)
    15ef:	e8 91 fe ff ff       	call   1485 <printint>
    15f4:	83 c4 10             	add    $0x10,%esp
        ap++;
    15f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15fb:	e9 ae 00 00 00       	jmp    16ae <printf+0x174>
      } else if(c == 's'){
    1600:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1604:	75 43                	jne    1649 <printf+0x10f>
        s = (char*)*ap;
    1606:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1609:	8b 00                	mov    (%eax),%eax
    160b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    160e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1612:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1616:	75 25                	jne    163d <printf+0x103>
          s = "(null)";
    1618:	c7 45 f4 39 19 00 00 	movl   $0x1939,-0xc(%ebp)
        while(*s != 0){
    161f:	eb 1c                	jmp    163d <printf+0x103>
          putc(fd, *s);
    1621:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1624:	0f b6 00             	movzbl (%eax),%eax
    1627:	0f be c0             	movsbl %al,%eax
    162a:	83 ec 08             	sub    $0x8,%esp
    162d:	50                   	push   %eax
    162e:	ff 75 08             	pushl  0x8(%ebp)
    1631:	e8 28 fe ff ff       	call   145e <putc>
    1636:	83 c4 10             	add    $0x10,%esp
          s++;
    1639:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    163d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1640:	0f b6 00             	movzbl (%eax),%eax
    1643:	84 c0                	test   %al,%al
    1645:	75 da                	jne    1621 <printf+0xe7>
    1647:	eb 65                	jmp    16ae <printf+0x174>
        }
      } else if(c == 'c'){
    1649:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    164d:	75 1d                	jne    166c <printf+0x132>
        putc(fd, *ap);
    164f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1652:	8b 00                	mov    (%eax),%eax
    1654:	0f be c0             	movsbl %al,%eax
    1657:	83 ec 08             	sub    $0x8,%esp
    165a:	50                   	push   %eax
    165b:	ff 75 08             	pushl  0x8(%ebp)
    165e:	e8 fb fd ff ff       	call   145e <putc>
    1663:	83 c4 10             	add    $0x10,%esp
        ap++;
    1666:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    166a:	eb 42                	jmp    16ae <printf+0x174>
      } else if(c == '%'){
    166c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1670:	75 17                	jne    1689 <printf+0x14f>
        putc(fd, c);
    1672:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1675:	0f be c0             	movsbl %al,%eax
    1678:	83 ec 08             	sub    $0x8,%esp
    167b:	50                   	push   %eax
    167c:	ff 75 08             	pushl  0x8(%ebp)
    167f:	e8 da fd ff ff       	call   145e <putc>
    1684:	83 c4 10             	add    $0x10,%esp
    1687:	eb 25                	jmp    16ae <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1689:	83 ec 08             	sub    $0x8,%esp
    168c:	6a 25                	push   $0x25
    168e:	ff 75 08             	pushl  0x8(%ebp)
    1691:	e8 c8 fd ff ff       	call   145e <putc>
    1696:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1699:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    169c:	0f be c0             	movsbl %al,%eax
    169f:	83 ec 08             	sub    $0x8,%esp
    16a2:	50                   	push   %eax
    16a3:	ff 75 08             	pushl  0x8(%ebp)
    16a6:	e8 b3 fd ff ff       	call   145e <putc>
    16ab:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    16ae:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    16b5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16b9:	8b 55 0c             	mov    0xc(%ebp),%edx
    16bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16bf:	01 d0                	add    %edx,%eax
    16c1:	0f b6 00             	movzbl (%eax),%eax
    16c4:	84 c0                	test   %al,%al
    16c6:	0f 85 94 fe ff ff    	jne    1560 <printf+0x26>
    }
  }
}
    16cc:	90                   	nop
    16cd:	90                   	nop
    16ce:	c9                   	leave  
    16cf:	c3                   	ret    

000016d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16d0:	f3 0f 1e fb          	endbr32 
    16d4:	55                   	push   %ebp
    16d5:	89 e5                	mov    %esp,%ebp
    16d7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16da:	8b 45 08             	mov    0x8(%ebp),%eax
    16dd:	83 e8 08             	sub    $0x8,%eax
    16e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16e3:	a1 c8 1b 00 00       	mov    0x1bc8,%eax
    16e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16eb:	eb 24                	jmp    1711 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f0:	8b 00                	mov    (%eax),%eax
    16f2:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    16f5:	72 12                	jb     1709 <free+0x39>
    16f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16fd:	77 24                	ja     1723 <free+0x53>
    16ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1702:	8b 00                	mov    (%eax),%eax
    1704:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1707:	72 1a                	jb     1723 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1709:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170c:	8b 00                	mov    (%eax),%eax
    170e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1711:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1714:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1717:	76 d4                	jbe    16ed <free+0x1d>
    1719:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171c:	8b 00                	mov    (%eax),%eax
    171e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1721:	73 ca                	jae    16ed <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1723:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1726:	8b 40 04             	mov    0x4(%eax),%eax
    1729:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1730:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1733:	01 c2                	add    %eax,%edx
    1735:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1738:	8b 00                	mov    (%eax),%eax
    173a:	39 c2                	cmp    %eax,%edx
    173c:	75 24                	jne    1762 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    173e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1741:	8b 50 04             	mov    0x4(%eax),%edx
    1744:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1747:	8b 00                	mov    (%eax),%eax
    1749:	8b 40 04             	mov    0x4(%eax),%eax
    174c:	01 c2                	add    %eax,%edx
    174e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1751:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1754:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1757:	8b 00                	mov    (%eax),%eax
    1759:	8b 10                	mov    (%eax),%edx
    175b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    175e:	89 10                	mov    %edx,(%eax)
    1760:	eb 0a                	jmp    176c <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1762:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1765:	8b 10                	mov    (%eax),%edx
    1767:	8b 45 f8             	mov    -0x8(%ebp),%eax
    176a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    176c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    176f:	8b 40 04             	mov    0x4(%eax),%eax
    1772:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1779:	8b 45 fc             	mov    -0x4(%ebp),%eax
    177c:	01 d0                	add    %edx,%eax
    177e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1781:	75 20                	jne    17a3 <free+0xd3>
    p->s.size += bp->s.size;
    1783:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1786:	8b 50 04             	mov    0x4(%eax),%edx
    1789:	8b 45 f8             	mov    -0x8(%ebp),%eax
    178c:	8b 40 04             	mov    0x4(%eax),%eax
    178f:	01 c2                	add    %eax,%edx
    1791:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1794:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1797:	8b 45 f8             	mov    -0x8(%ebp),%eax
    179a:	8b 10                	mov    (%eax),%edx
    179c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179f:	89 10                	mov    %edx,(%eax)
    17a1:	eb 08                	jmp    17ab <free+0xdb>
  } else
    p->s.ptr = bp;
    17a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a6:	8b 55 f8             	mov    -0x8(%ebp),%edx
    17a9:	89 10                	mov    %edx,(%eax)
  freep = p;
    17ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ae:	a3 c8 1b 00 00       	mov    %eax,0x1bc8
}
    17b3:	90                   	nop
    17b4:	c9                   	leave  
    17b5:	c3                   	ret    

000017b6 <morecore>:

static Header*
morecore(uint nu)
{
    17b6:	f3 0f 1e fb          	endbr32 
    17ba:	55                   	push   %ebp
    17bb:	89 e5                	mov    %esp,%ebp
    17bd:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    17c0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    17c7:	77 07                	ja     17d0 <morecore+0x1a>
    nu = 4096;
    17c9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    17d0:	8b 45 08             	mov    0x8(%ebp),%eax
    17d3:	c1 e0 03             	shl    $0x3,%eax
    17d6:	83 ec 0c             	sub    $0xc,%esp
    17d9:	50                   	push   %eax
    17da:	e8 57 fc ff ff       	call   1436 <sbrk>
    17df:	83 c4 10             	add    $0x10,%esp
    17e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    17e5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    17e9:	75 07                	jne    17f2 <morecore+0x3c>
    return 0;
    17eb:	b8 00 00 00 00       	mov    $0x0,%eax
    17f0:	eb 26                	jmp    1818 <morecore+0x62>
  hp = (Header*)p;
    17f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    17f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17fb:	8b 55 08             	mov    0x8(%ebp),%edx
    17fe:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1801:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1804:	83 c0 08             	add    $0x8,%eax
    1807:	83 ec 0c             	sub    $0xc,%esp
    180a:	50                   	push   %eax
    180b:	e8 c0 fe ff ff       	call   16d0 <free>
    1810:	83 c4 10             	add    $0x10,%esp
  return freep;
    1813:	a1 c8 1b 00 00       	mov    0x1bc8,%eax
}
    1818:	c9                   	leave  
    1819:	c3                   	ret    

0000181a <malloc>:

void*
malloc(uint nbytes)
{
    181a:	f3 0f 1e fb          	endbr32 
    181e:	55                   	push   %ebp
    181f:	89 e5                	mov    %esp,%ebp
    1821:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1824:	8b 45 08             	mov    0x8(%ebp),%eax
    1827:	83 c0 07             	add    $0x7,%eax
    182a:	c1 e8 03             	shr    $0x3,%eax
    182d:	83 c0 01             	add    $0x1,%eax
    1830:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1833:	a1 c8 1b 00 00       	mov    0x1bc8,%eax
    1838:	89 45 f0             	mov    %eax,-0x10(%ebp)
    183b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    183f:	75 23                	jne    1864 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1841:	c7 45 f0 c0 1b 00 00 	movl   $0x1bc0,-0x10(%ebp)
    1848:	8b 45 f0             	mov    -0x10(%ebp),%eax
    184b:	a3 c8 1b 00 00       	mov    %eax,0x1bc8
    1850:	a1 c8 1b 00 00       	mov    0x1bc8,%eax
    1855:	a3 c0 1b 00 00       	mov    %eax,0x1bc0
    base.s.size = 0;
    185a:	c7 05 c4 1b 00 00 00 	movl   $0x0,0x1bc4
    1861:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1864:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1867:	8b 00                	mov    (%eax),%eax
    1869:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    186c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186f:	8b 40 04             	mov    0x4(%eax),%eax
    1872:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1875:	77 4d                	ja     18c4 <malloc+0xaa>
      if(p->s.size == nunits)
    1877:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187a:	8b 40 04             	mov    0x4(%eax),%eax
    187d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1880:	75 0c                	jne    188e <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    1882:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1885:	8b 10                	mov    (%eax),%edx
    1887:	8b 45 f0             	mov    -0x10(%ebp),%eax
    188a:	89 10                	mov    %edx,(%eax)
    188c:	eb 26                	jmp    18b4 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    188e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1891:	8b 40 04             	mov    0x4(%eax),%eax
    1894:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1897:	89 c2                	mov    %eax,%edx
    1899:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    189f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a2:	8b 40 04             	mov    0x4(%eax),%eax
    18a5:	c1 e0 03             	shl    $0x3,%eax
    18a8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    18ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ae:	8b 55 ec             	mov    -0x14(%ebp),%edx
    18b1:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    18b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18b7:	a3 c8 1b 00 00       	mov    %eax,0x1bc8
      return (void*)(p + 1);
    18bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18bf:	83 c0 08             	add    $0x8,%eax
    18c2:	eb 3b                	jmp    18ff <malloc+0xe5>
    }
    if(p == freep)
    18c4:	a1 c8 1b 00 00       	mov    0x1bc8,%eax
    18c9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    18cc:	75 1e                	jne    18ec <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    18ce:	83 ec 0c             	sub    $0xc,%esp
    18d1:	ff 75 ec             	pushl  -0x14(%ebp)
    18d4:	e8 dd fe ff ff       	call   17b6 <morecore>
    18d9:	83 c4 10             	add    $0x10,%esp
    18dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18e3:	75 07                	jne    18ec <malloc+0xd2>
        return 0;
    18e5:	b8 00 00 00 00       	mov    $0x0,%eax
    18ea:	eb 13                	jmp    18ff <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f5:	8b 00                	mov    (%eax),%eax
    18f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    18fa:	e9 6d ff ff ff       	jmp    186c <malloc+0x52>
  }
}
    18ff:	c9                   	leave  
    1900:	c3                   	ret    
