
_wc:     file format elf32-i386


Disassembly of section .text:

00001000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
    1000:	f3 0f 1e fb          	endbr32 
    1004:	55                   	push   %ebp
    1005:	89 e5                	mov    %esp,%ebp
    1007:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
    100a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1011:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1014:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1017:	8b 45 ec             	mov    -0x14(%ebp),%eax
    101a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
    101d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1024:	eb 69                	jmp    108f <wc+0x8f>
    for(i=0; i<n; i++){
    1026:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    102d:	eb 58                	jmp    1087 <wc+0x87>
      c++;
    102f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
    1033:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1036:	05 80 1c 00 00       	add    $0x1c80,%eax
    103b:	0f b6 00             	movzbl (%eax),%eax
    103e:	3c 0a                	cmp    $0xa,%al
    1040:	75 04                	jne    1046 <wc+0x46>
        l++;
    1042:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
    1046:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1049:	05 80 1c 00 00       	add    $0x1c80,%eax
    104e:	0f b6 00             	movzbl (%eax),%eax
    1051:	0f be c0             	movsbl %al,%eax
    1054:	83 ec 08             	sub    $0x8,%esp
    1057:	50                   	push   %eax
    1058:	68 93 19 00 00       	push   $0x1993
    105d:	e8 49 02 00 00       	call   12ab <strchr>
    1062:	83 c4 10             	add    $0x10,%esp
    1065:	85 c0                	test   %eax,%eax
    1067:	74 09                	je     1072 <wc+0x72>
        inword = 0;
    1069:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1070:	eb 11                	jmp    1083 <wc+0x83>
      else if(!inword){
    1072:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1076:	75 0b                	jne    1083 <wc+0x83>
        w++;
    1078:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
    107c:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
    1083:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1087:	8b 45 f4             	mov    -0xc(%ebp),%eax
    108a:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    108d:	7c a0                	jl     102f <wc+0x2f>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    108f:	83 ec 04             	sub    $0x4,%esp
    1092:	68 00 02 00 00       	push   $0x200
    1097:	68 80 1c 00 00       	push   $0x1c80
    109c:	ff 75 08             	pushl  0x8(%ebp)
    109f:	e8 b4 03 00 00       	call   1458 <read>
    10a4:	83 c4 10             	add    $0x10,%esp
    10a7:	89 45 e0             	mov    %eax,-0x20(%ebp)
    10aa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    10ae:	0f 8f 72 ff ff ff    	jg     1026 <wc+0x26>
      }
    }
  }
  if(n < 0){
    10b4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    10b8:	79 17                	jns    10d1 <wc+0xd1>
    printf(1, "wc: read error\n");
    10ba:	83 ec 08             	sub    $0x8,%esp
    10bd:	68 99 19 00 00       	push   $0x1999
    10c2:	6a 01                	push   $0x1
    10c4:	e8 03 05 00 00       	call   15cc <printf>
    10c9:	83 c4 10             	add    $0x10,%esp
    exit();
    10cc:	e8 6f 03 00 00       	call   1440 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
    10d1:	83 ec 08             	sub    $0x8,%esp
    10d4:	ff 75 0c             	pushl  0xc(%ebp)
    10d7:	ff 75 e8             	pushl  -0x18(%ebp)
    10da:	ff 75 ec             	pushl  -0x14(%ebp)
    10dd:	ff 75 f0             	pushl  -0x10(%ebp)
    10e0:	68 a9 19 00 00       	push   $0x19a9
    10e5:	6a 01                	push   $0x1
    10e7:	e8 e0 04 00 00       	call   15cc <printf>
    10ec:	83 c4 20             	add    $0x20,%esp
}
    10ef:	90                   	nop
    10f0:	c9                   	leave  
    10f1:	c3                   	ret    

000010f2 <main>:

int
main(int argc, char *argv[])
{
    10f2:	f3 0f 1e fb          	endbr32 
    10f6:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    10fa:	83 e4 f0             	and    $0xfffffff0,%esp
    10fd:	ff 71 fc             	pushl  -0x4(%ecx)
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	53                   	push   %ebx
    1104:	51                   	push   %ecx
    1105:	83 ec 10             	sub    $0x10,%esp
    1108:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
    110a:	83 3b 01             	cmpl   $0x1,(%ebx)
    110d:	7f 17                	jg     1126 <main+0x34>
    wc(0, "");
    110f:	83 ec 08             	sub    $0x8,%esp
    1112:	68 b6 19 00 00       	push   $0x19b6
    1117:	6a 00                	push   $0x0
    1119:	e8 e2 fe ff ff       	call   1000 <wc>
    111e:	83 c4 10             	add    $0x10,%esp
    exit();
    1121:	e8 1a 03 00 00       	call   1440 <exit>
  }

  for(i = 1; i < argc; i++){
    1126:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    112d:	e9 83 00 00 00       	jmp    11b5 <main+0xc3>
    if((fd = open(argv[i], 0)) < 0){
    1132:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1135:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    113c:	8b 43 04             	mov    0x4(%ebx),%eax
    113f:	01 d0                	add    %edx,%eax
    1141:	8b 00                	mov    (%eax),%eax
    1143:	83 ec 08             	sub    $0x8,%esp
    1146:	6a 00                	push   $0x0
    1148:	50                   	push   %eax
    1149:	e8 32 03 00 00       	call   1480 <open>
    114e:	83 c4 10             	add    $0x10,%esp
    1151:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1154:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1158:	79 29                	jns    1183 <main+0x91>
      printf(1, "wc: cannot open %s\n", argv[i]);
    115a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    115d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1164:	8b 43 04             	mov    0x4(%ebx),%eax
    1167:	01 d0                	add    %edx,%eax
    1169:	8b 00                	mov    (%eax),%eax
    116b:	83 ec 04             	sub    $0x4,%esp
    116e:	50                   	push   %eax
    116f:	68 b7 19 00 00       	push   $0x19b7
    1174:	6a 01                	push   $0x1
    1176:	e8 51 04 00 00       	call   15cc <printf>
    117b:	83 c4 10             	add    $0x10,%esp
      exit();
    117e:	e8 bd 02 00 00       	call   1440 <exit>
    }
    wc(fd, argv[i]);
    1183:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1186:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    118d:	8b 43 04             	mov    0x4(%ebx),%eax
    1190:	01 d0                	add    %edx,%eax
    1192:	8b 00                	mov    (%eax),%eax
    1194:	83 ec 08             	sub    $0x8,%esp
    1197:	50                   	push   %eax
    1198:	ff 75 f0             	pushl  -0x10(%ebp)
    119b:	e8 60 fe ff ff       	call   1000 <wc>
    11a0:	83 c4 10             	add    $0x10,%esp
    close(fd);
    11a3:	83 ec 0c             	sub    $0xc,%esp
    11a6:	ff 75 f0             	pushl  -0x10(%ebp)
    11a9:	e8 ba 02 00 00       	call   1468 <close>
    11ae:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
    11b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b8:	3b 03                	cmp    (%ebx),%eax
    11ba:	0f 8c 72 ff ff ff    	jl     1132 <main+0x40>
  }
  exit();
    11c0:	e8 7b 02 00 00       	call   1440 <exit>

000011c5 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11c5:	55                   	push   %ebp
    11c6:	89 e5                	mov    %esp,%ebp
    11c8:	57                   	push   %edi
    11c9:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    11ca:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11cd:	8b 55 10             	mov    0x10(%ebp),%edx
    11d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d3:	89 cb                	mov    %ecx,%ebx
    11d5:	89 df                	mov    %ebx,%edi
    11d7:	89 d1                	mov    %edx,%ecx
    11d9:	fc                   	cld    
    11da:	f3 aa                	rep stos %al,%es:(%edi)
    11dc:	89 ca                	mov    %ecx,%edx
    11de:	89 fb                	mov    %edi,%ebx
    11e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
    11e3:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    11e6:	90                   	nop
    11e7:	5b                   	pop    %ebx
    11e8:	5f                   	pop    %edi
    11e9:	5d                   	pop    %ebp
    11ea:	c3                   	ret    

000011eb <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    11eb:	f3 0f 1e fb          	endbr32 
    11ef:	55                   	push   %ebp
    11f0:	89 e5                	mov    %esp,%ebp
    11f2:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    11f5:	8b 45 08             	mov    0x8(%ebp),%eax
    11f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    11fb:	90                   	nop
    11fc:	8b 55 0c             	mov    0xc(%ebp),%edx
    11ff:	8d 42 01             	lea    0x1(%edx),%eax
    1202:	89 45 0c             	mov    %eax,0xc(%ebp)
    1205:	8b 45 08             	mov    0x8(%ebp),%eax
    1208:	8d 48 01             	lea    0x1(%eax),%ecx
    120b:	89 4d 08             	mov    %ecx,0x8(%ebp)
    120e:	0f b6 12             	movzbl (%edx),%edx
    1211:	88 10                	mov    %dl,(%eax)
    1213:	0f b6 00             	movzbl (%eax),%eax
    1216:	84 c0                	test   %al,%al
    1218:	75 e2                	jne    11fc <strcpy+0x11>
    ;
  return os;
    121a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    121d:	c9                   	leave  
    121e:	c3                   	ret    

0000121f <strcmp>:

int
strcmp(const char *p, const char *q)
{
    121f:	f3 0f 1e fb          	endbr32 
    1223:	55                   	push   %ebp
    1224:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1226:	eb 08                	jmp    1230 <strcmp+0x11>
    p++, q++;
    1228:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    122c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    1230:	8b 45 08             	mov    0x8(%ebp),%eax
    1233:	0f b6 00             	movzbl (%eax),%eax
    1236:	84 c0                	test   %al,%al
    1238:	74 10                	je     124a <strcmp+0x2b>
    123a:	8b 45 08             	mov    0x8(%ebp),%eax
    123d:	0f b6 10             	movzbl (%eax),%edx
    1240:	8b 45 0c             	mov    0xc(%ebp),%eax
    1243:	0f b6 00             	movzbl (%eax),%eax
    1246:	38 c2                	cmp    %al,%dl
    1248:	74 de                	je     1228 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    124a:	8b 45 08             	mov    0x8(%ebp),%eax
    124d:	0f b6 00             	movzbl (%eax),%eax
    1250:	0f b6 d0             	movzbl %al,%edx
    1253:	8b 45 0c             	mov    0xc(%ebp),%eax
    1256:	0f b6 00             	movzbl (%eax),%eax
    1259:	0f b6 c0             	movzbl %al,%eax
    125c:	29 c2                	sub    %eax,%edx
    125e:	89 d0                	mov    %edx,%eax
}
    1260:	5d                   	pop    %ebp
    1261:	c3                   	ret    

00001262 <strlen>:

uint
strlen(const char *s)
{
    1262:	f3 0f 1e fb          	endbr32 
    1266:	55                   	push   %ebp
    1267:	89 e5                	mov    %esp,%ebp
    1269:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    126c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1273:	eb 04                	jmp    1279 <strlen+0x17>
    1275:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1279:	8b 55 fc             	mov    -0x4(%ebp),%edx
    127c:	8b 45 08             	mov    0x8(%ebp),%eax
    127f:	01 d0                	add    %edx,%eax
    1281:	0f b6 00             	movzbl (%eax),%eax
    1284:	84 c0                	test   %al,%al
    1286:	75 ed                	jne    1275 <strlen+0x13>
    ;
  return n;
    1288:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    128b:	c9                   	leave  
    128c:	c3                   	ret    

0000128d <memset>:

void*
memset(void *dst, int c, uint n)
{
    128d:	f3 0f 1e fb          	endbr32 
    1291:	55                   	push   %ebp
    1292:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1294:	8b 45 10             	mov    0x10(%ebp),%eax
    1297:	50                   	push   %eax
    1298:	ff 75 0c             	pushl  0xc(%ebp)
    129b:	ff 75 08             	pushl  0x8(%ebp)
    129e:	e8 22 ff ff ff       	call   11c5 <stosb>
    12a3:	83 c4 0c             	add    $0xc,%esp
  return dst;
    12a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12a9:	c9                   	leave  
    12aa:	c3                   	ret    

000012ab <strchr>:

char*
strchr(const char *s, char c)
{
    12ab:	f3 0f 1e fb          	endbr32 
    12af:	55                   	push   %ebp
    12b0:	89 e5                	mov    %esp,%ebp
    12b2:	83 ec 04             	sub    $0x4,%esp
    12b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    12bb:	eb 14                	jmp    12d1 <strchr+0x26>
    if(*s == c)
    12bd:	8b 45 08             	mov    0x8(%ebp),%eax
    12c0:	0f b6 00             	movzbl (%eax),%eax
    12c3:	38 45 fc             	cmp    %al,-0x4(%ebp)
    12c6:	75 05                	jne    12cd <strchr+0x22>
      return (char*)s;
    12c8:	8b 45 08             	mov    0x8(%ebp),%eax
    12cb:	eb 13                	jmp    12e0 <strchr+0x35>
  for(; *s; s++)
    12cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12d1:	8b 45 08             	mov    0x8(%ebp),%eax
    12d4:	0f b6 00             	movzbl (%eax),%eax
    12d7:	84 c0                	test   %al,%al
    12d9:	75 e2                	jne    12bd <strchr+0x12>
  return 0;
    12db:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12e0:	c9                   	leave  
    12e1:	c3                   	ret    

000012e2 <gets>:

char*
gets(char *buf, int max)
{
    12e2:	f3 0f 1e fb          	endbr32 
    12e6:	55                   	push   %ebp
    12e7:	89 e5                	mov    %esp,%ebp
    12e9:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12f3:	eb 42                	jmp    1337 <gets+0x55>
    cc = read(0, &c, 1);
    12f5:	83 ec 04             	sub    $0x4,%esp
    12f8:	6a 01                	push   $0x1
    12fa:	8d 45 ef             	lea    -0x11(%ebp),%eax
    12fd:	50                   	push   %eax
    12fe:	6a 00                	push   $0x0
    1300:	e8 53 01 00 00       	call   1458 <read>
    1305:	83 c4 10             	add    $0x10,%esp
    1308:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    130b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    130f:	7e 33                	jle    1344 <gets+0x62>
      break;
    buf[i++] = c;
    1311:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1314:	8d 50 01             	lea    0x1(%eax),%edx
    1317:	89 55 f4             	mov    %edx,-0xc(%ebp)
    131a:	89 c2                	mov    %eax,%edx
    131c:	8b 45 08             	mov    0x8(%ebp),%eax
    131f:	01 c2                	add    %eax,%edx
    1321:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1325:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1327:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    132b:	3c 0a                	cmp    $0xa,%al
    132d:	74 16                	je     1345 <gets+0x63>
    132f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1333:	3c 0d                	cmp    $0xd,%al
    1335:	74 0e                	je     1345 <gets+0x63>
  for(i=0; i+1 < max; ){
    1337:	8b 45 f4             	mov    -0xc(%ebp),%eax
    133a:	83 c0 01             	add    $0x1,%eax
    133d:	39 45 0c             	cmp    %eax,0xc(%ebp)
    1340:	7f b3                	jg     12f5 <gets+0x13>
    1342:	eb 01                	jmp    1345 <gets+0x63>
      break;
    1344:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1345:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1348:	8b 45 08             	mov    0x8(%ebp),%eax
    134b:	01 d0                	add    %edx,%eax
    134d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1350:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1353:	c9                   	leave  
    1354:	c3                   	ret    

00001355 <stat>:

int
stat(const char *n, struct stat *st)
{
    1355:	f3 0f 1e fb          	endbr32 
    1359:	55                   	push   %ebp
    135a:	89 e5                	mov    %esp,%ebp
    135c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    135f:	83 ec 08             	sub    $0x8,%esp
    1362:	6a 00                	push   $0x0
    1364:	ff 75 08             	pushl  0x8(%ebp)
    1367:	e8 14 01 00 00       	call   1480 <open>
    136c:	83 c4 10             	add    $0x10,%esp
    136f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1372:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1376:	79 07                	jns    137f <stat+0x2a>
    return -1;
    1378:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    137d:	eb 25                	jmp    13a4 <stat+0x4f>
  r = fstat(fd, st);
    137f:	83 ec 08             	sub    $0x8,%esp
    1382:	ff 75 0c             	pushl  0xc(%ebp)
    1385:	ff 75 f4             	pushl  -0xc(%ebp)
    1388:	e8 0b 01 00 00       	call   1498 <fstat>
    138d:	83 c4 10             	add    $0x10,%esp
    1390:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1393:	83 ec 0c             	sub    $0xc,%esp
    1396:	ff 75 f4             	pushl  -0xc(%ebp)
    1399:	e8 ca 00 00 00       	call   1468 <close>
    139e:	83 c4 10             	add    $0x10,%esp
  return r;
    13a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    13a4:	c9                   	leave  
    13a5:	c3                   	ret    

000013a6 <atoi>:

int
atoi(const char *s)
{
    13a6:	f3 0f 1e fb          	endbr32 
    13aa:	55                   	push   %ebp
    13ab:	89 e5                	mov    %esp,%ebp
    13ad:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    13b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    13b7:	eb 25                	jmp    13de <atoi+0x38>
    n = n*10 + *s++ - '0';
    13b9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13bc:	89 d0                	mov    %edx,%eax
    13be:	c1 e0 02             	shl    $0x2,%eax
    13c1:	01 d0                	add    %edx,%eax
    13c3:	01 c0                	add    %eax,%eax
    13c5:	89 c1                	mov    %eax,%ecx
    13c7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ca:	8d 50 01             	lea    0x1(%eax),%edx
    13cd:	89 55 08             	mov    %edx,0x8(%ebp)
    13d0:	0f b6 00             	movzbl (%eax),%eax
    13d3:	0f be c0             	movsbl %al,%eax
    13d6:	01 c8                	add    %ecx,%eax
    13d8:	83 e8 30             	sub    $0x30,%eax
    13db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    13de:	8b 45 08             	mov    0x8(%ebp),%eax
    13e1:	0f b6 00             	movzbl (%eax),%eax
    13e4:	3c 2f                	cmp    $0x2f,%al
    13e6:	7e 0a                	jle    13f2 <atoi+0x4c>
    13e8:	8b 45 08             	mov    0x8(%ebp),%eax
    13eb:	0f b6 00             	movzbl (%eax),%eax
    13ee:	3c 39                	cmp    $0x39,%al
    13f0:	7e c7                	jle    13b9 <atoi+0x13>
  return n;
    13f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13f5:	c9                   	leave  
    13f6:	c3                   	ret    

000013f7 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    13f7:	f3 0f 1e fb          	endbr32 
    13fb:	55                   	push   %ebp
    13fc:	89 e5                	mov    %esp,%ebp
    13fe:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    1401:	8b 45 08             	mov    0x8(%ebp),%eax
    1404:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1407:	8b 45 0c             	mov    0xc(%ebp),%eax
    140a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    140d:	eb 17                	jmp    1426 <memmove+0x2f>
    *dst++ = *src++;
    140f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1412:	8d 42 01             	lea    0x1(%edx),%eax
    1415:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1418:	8b 45 fc             	mov    -0x4(%ebp),%eax
    141b:	8d 48 01             	lea    0x1(%eax),%ecx
    141e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    1421:	0f b6 12             	movzbl (%edx),%edx
    1424:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    1426:	8b 45 10             	mov    0x10(%ebp),%eax
    1429:	8d 50 ff             	lea    -0x1(%eax),%edx
    142c:	89 55 10             	mov    %edx,0x10(%ebp)
    142f:	85 c0                	test   %eax,%eax
    1431:	7f dc                	jg     140f <memmove+0x18>
  return vdst;
    1433:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1436:	c9                   	leave  
    1437:	c3                   	ret    

00001438 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1438:	b8 01 00 00 00       	mov    $0x1,%eax
    143d:	cd 40                	int    $0x40
    143f:	c3                   	ret    

00001440 <exit>:
SYSCALL(exit)
    1440:	b8 02 00 00 00       	mov    $0x2,%eax
    1445:	cd 40                	int    $0x40
    1447:	c3                   	ret    

00001448 <wait>:
SYSCALL(wait)
    1448:	b8 03 00 00 00       	mov    $0x3,%eax
    144d:	cd 40                	int    $0x40
    144f:	c3                   	ret    

00001450 <pipe>:
SYSCALL(pipe)
    1450:	b8 04 00 00 00       	mov    $0x4,%eax
    1455:	cd 40                	int    $0x40
    1457:	c3                   	ret    

00001458 <read>:
SYSCALL(read)
    1458:	b8 05 00 00 00       	mov    $0x5,%eax
    145d:	cd 40                	int    $0x40
    145f:	c3                   	ret    

00001460 <write>:
SYSCALL(write)
    1460:	b8 10 00 00 00       	mov    $0x10,%eax
    1465:	cd 40                	int    $0x40
    1467:	c3                   	ret    

00001468 <close>:
SYSCALL(close)
    1468:	b8 15 00 00 00       	mov    $0x15,%eax
    146d:	cd 40                	int    $0x40
    146f:	c3                   	ret    

00001470 <kill>:
SYSCALL(kill)
    1470:	b8 06 00 00 00       	mov    $0x6,%eax
    1475:	cd 40                	int    $0x40
    1477:	c3                   	ret    

00001478 <exec>:
SYSCALL(exec)
    1478:	b8 07 00 00 00       	mov    $0x7,%eax
    147d:	cd 40                	int    $0x40
    147f:	c3                   	ret    

00001480 <open>:
SYSCALL(open)
    1480:	b8 0f 00 00 00       	mov    $0xf,%eax
    1485:	cd 40                	int    $0x40
    1487:	c3                   	ret    

00001488 <mknod>:
SYSCALL(mknod)
    1488:	b8 11 00 00 00       	mov    $0x11,%eax
    148d:	cd 40                	int    $0x40
    148f:	c3                   	ret    

00001490 <unlink>:
SYSCALL(unlink)
    1490:	b8 12 00 00 00       	mov    $0x12,%eax
    1495:	cd 40                	int    $0x40
    1497:	c3                   	ret    

00001498 <fstat>:
SYSCALL(fstat)
    1498:	b8 08 00 00 00       	mov    $0x8,%eax
    149d:	cd 40                	int    $0x40
    149f:	c3                   	ret    

000014a0 <link>:
SYSCALL(link)
    14a0:	b8 13 00 00 00       	mov    $0x13,%eax
    14a5:	cd 40                	int    $0x40
    14a7:	c3                   	ret    

000014a8 <mkdir>:
SYSCALL(mkdir)
    14a8:	b8 14 00 00 00       	mov    $0x14,%eax
    14ad:	cd 40                	int    $0x40
    14af:	c3                   	ret    

000014b0 <chdir>:
SYSCALL(chdir)
    14b0:	b8 09 00 00 00       	mov    $0x9,%eax
    14b5:	cd 40                	int    $0x40
    14b7:	c3                   	ret    

000014b8 <dup>:
SYSCALL(dup)
    14b8:	b8 0a 00 00 00       	mov    $0xa,%eax
    14bd:	cd 40                	int    $0x40
    14bf:	c3                   	ret    

000014c0 <getpid>:
SYSCALL(getpid)
    14c0:	b8 0b 00 00 00       	mov    $0xb,%eax
    14c5:	cd 40                	int    $0x40
    14c7:	c3                   	ret    

000014c8 <sbrk>:
SYSCALL(sbrk)
    14c8:	b8 0c 00 00 00       	mov    $0xc,%eax
    14cd:	cd 40                	int    $0x40
    14cf:	c3                   	ret    

000014d0 <sleep>:
SYSCALL(sleep)
    14d0:	b8 0d 00 00 00       	mov    $0xd,%eax
    14d5:	cd 40                	int    $0x40
    14d7:	c3                   	ret    

000014d8 <uptime>:
SYSCALL(uptime)
    14d8:	b8 0e 00 00 00       	mov    $0xe,%eax
    14dd:	cd 40                	int    $0x40
    14df:	c3                   	ret    

000014e0 <settickets>:
SYSCALL(settickets)
    14e0:	b8 16 00 00 00       	mov    $0x16,%eax
    14e5:	cd 40                	int    $0x40
    14e7:	c3                   	ret    

000014e8 <getpinfo>:
SYSCALL(getpinfo)
    14e8:	b8 17 00 00 00       	mov    $0x17,%eax
    14ed:	cd 40                	int    $0x40
    14ef:	c3                   	ret    

000014f0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    14f0:	f3 0f 1e fb          	endbr32 
    14f4:	55                   	push   %ebp
    14f5:	89 e5                	mov    %esp,%ebp
    14f7:	83 ec 18             	sub    $0x18,%esp
    14fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    14fd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1500:	83 ec 04             	sub    $0x4,%esp
    1503:	6a 01                	push   $0x1
    1505:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1508:	50                   	push   %eax
    1509:	ff 75 08             	pushl  0x8(%ebp)
    150c:	e8 4f ff ff ff       	call   1460 <write>
    1511:	83 c4 10             	add    $0x10,%esp
}
    1514:	90                   	nop
    1515:	c9                   	leave  
    1516:	c3                   	ret    

00001517 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1517:	f3 0f 1e fb          	endbr32 
    151b:	55                   	push   %ebp
    151c:	89 e5                	mov    %esp,%ebp
    151e:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1521:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1528:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    152c:	74 17                	je     1545 <printint+0x2e>
    152e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1532:	79 11                	jns    1545 <printint+0x2e>
    neg = 1;
    1534:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    153b:	8b 45 0c             	mov    0xc(%ebp),%eax
    153e:	f7 d8                	neg    %eax
    1540:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1543:	eb 06                	jmp    154b <printint+0x34>
  } else {
    x = xx;
    1545:	8b 45 0c             	mov    0xc(%ebp),%eax
    1548:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    154b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1552:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1555:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1558:	ba 00 00 00 00       	mov    $0x0,%edx
    155d:	f7 f1                	div    %ecx
    155f:	89 d1                	mov    %edx,%ecx
    1561:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1564:	8d 50 01             	lea    0x1(%eax),%edx
    1567:	89 55 f4             	mov    %edx,-0xc(%ebp)
    156a:	0f b6 91 3c 1c 00 00 	movzbl 0x1c3c(%ecx),%edx
    1571:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1575:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1578:	8b 45 ec             	mov    -0x14(%ebp),%eax
    157b:	ba 00 00 00 00       	mov    $0x0,%edx
    1580:	f7 f1                	div    %ecx
    1582:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1585:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1589:	75 c7                	jne    1552 <printint+0x3b>
  if(neg)
    158b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    158f:	74 2d                	je     15be <printint+0xa7>
    buf[i++] = '-';
    1591:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1594:	8d 50 01             	lea    0x1(%eax),%edx
    1597:	89 55 f4             	mov    %edx,-0xc(%ebp)
    159a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    159f:	eb 1d                	jmp    15be <printint+0xa7>
    putc(fd, buf[i]);
    15a1:	8d 55 dc             	lea    -0x24(%ebp),%edx
    15a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a7:	01 d0                	add    %edx,%eax
    15a9:	0f b6 00             	movzbl (%eax),%eax
    15ac:	0f be c0             	movsbl %al,%eax
    15af:	83 ec 08             	sub    $0x8,%esp
    15b2:	50                   	push   %eax
    15b3:	ff 75 08             	pushl  0x8(%ebp)
    15b6:	e8 35 ff ff ff       	call   14f0 <putc>
    15bb:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    15be:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    15c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15c6:	79 d9                	jns    15a1 <printint+0x8a>
}
    15c8:	90                   	nop
    15c9:	90                   	nop
    15ca:	c9                   	leave  
    15cb:	c3                   	ret    

000015cc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    15cc:	f3 0f 1e fb          	endbr32 
    15d0:	55                   	push   %ebp
    15d1:	89 e5                	mov    %esp,%ebp
    15d3:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    15d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    15dd:	8d 45 0c             	lea    0xc(%ebp),%eax
    15e0:	83 c0 04             	add    $0x4,%eax
    15e3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    15e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15ed:	e9 59 01 00 00       	jmp    174b <printf+0x17f>
    c = fmt[i] & 0xff;
    15f2:	8b 55 0c             	mov    0xc(%ebp),%edx
    15f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15f8:	01 d0                	add    %edx,%eax
    15fa:	0f b6 00             	movzbl (%eax),%eax
    15fd:	0f be c0             	movsbl %al,%eax
    1600:	25 ff 00 00 00       	and    $0xff,%eax
    1605:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1608:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    160c:	75 2c                	jne    163a <printf+0x6e>
      if(c == '%'){
    160e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1612:	75 0c                	jne    1620 <printf+0x54>
        state = '%';
    1614:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    161b:	e9 27 01 00 00       	jmp    1747 <printf+0x17b>
      } else {
        putc(fd, c);
    1620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1623:	0f be c0             	movsbl %al,%eax
    1626:	83 ec 08             	sub    $0x8,%esp
    1629:	50                   	push   %eax
    162a:	ff 75 08             	pushl  0x8(%ebp)
    162d:	e8 be fe ff ff       	call   14f0 <putc>
    1632:	83 c4 10             	add    $0x10,%esp
    1635:	e9 0d 01 00 00       	jmp    1747 <printf+0x17b>
      }
    } else if(state == '%'){
    163a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    163e:	0f 85 03 01 00 00    	jne    1747 <printf+0x17b>
      if(c == 'd'){
    1644:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1648:	75 1e                	jne    1668 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    164a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    164d:	8b 00                	mov    (%eax),%eax
    164f:	6a 01                	push   $0x1
    1651:	6a 0a                	push   $0xa
    1653:	50                   	push   %eax
    1654:	ff 75 08             	pushl  0x8(%ebp)
    1657:	e8 bb fe ff ff       	call   1517 <printint>
    165c:	83 c4 10             	add    $0x10,%esp
        ap++;
    165f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1663:	e9 d8 00 00 00       	jmp    1740 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    1668:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    166c:	74 06                	je     1674 <printf+0xa8>
    166e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1672:	75 1e                	jne    1692 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1674:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1677:	8b 00                	mov    (%eax),%eax
    1679:	6a 00                	push   $0x0
    167b:	6a 10                	push   $0x10
    167d:	50                   	push   %eax
    167e:	ff 75 08             	pushl  0x8(%ebp)
    1681:	e8 91 fe ff ff       	call   1517 <printint>
    1686:	83 c4 10             	add    $0x10,%esp
        ap++;
    1689:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    168d:	e9 ae 00 00 00       	jmp    1740 <printf+0x174>
      } else if(c == 's'){
    1692:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1696:	75 43                	jne    16db <printf+0x10f>
        s = (char*)*ap;
    1698:	8b 45 e8             	mov    -0x18(%ebp),%eax
    169b:	8b 00                	mov    (%eax),%eax
    169d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    16a0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    16a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16a8:	75 25                	jne    16cf <printf+0x103>
          s = "(null)";
    16aa:	c7 45 f4 cb 19 00 00 	movl   $0x19cb,-0xc(%ebp)
        while(*s != 0){
    16b1:	eb 1c                	jmp    16cf <printf+0x103>
          putc(fd, *s);
    16b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b6:	0f b6 00             	movzbl (%eax),%eax
    16b9:	0f be c0             	movsbl %al,%eax
    16bc:	83 ec 08             	sub    $0x8,%esp
    16bf:	50                   	push   %eax
    16c0:	ff 75 08             	pushl  0x8(%ebp)
    16c3:	e8 28 fe ff ff       	call   14f0 <putc>
    16c8:	83 c4 10             	add    $0x10,%esp
          s++;
    16cb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    16cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d2:	0f b6 00             	movzbl (%eax),%eax
    16d5:	84 c0                	test   %al,%al
    16d7:	75 da                	jne    16b3 <printf+0xe7>
    16d9:	eb 65                	jmp    1740 <printf+0x174>
        }
      } else if(c == 'c'){
    16db:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    16df:	75 1d                	jne    16fe <printf+0x132>
        putc(fd, *ap);
    16e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16e4:	8b 00                	mov    (%eax),%eax
    16e6:	0f be c0             	movsbl %al,%eax
    16e9:	83 ec 08             	sub    $0x8,%esp
    16ec:	50                   	push   %eax
    16ed:	ff 75 08             	pushl  0x8(%ebp)
    16f0:	e8 fb fd ff ff       	call   14f0 <putc>
    16f5:	83 c4 10             	add    $0x10,%esp
        ap++;
    16f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16fc:	eb 42                	jmp    1740 <printf+0x174>
      } else if(c == '%'){
    16fe:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1702:	75 17                	jne    171b <printf+0x14f>
        putc(fd, c);
    1704:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1707:	0f be c0             	movsbl %al,%eax
    170a:	83 ec 08             	sub    $0x8,%esp
    170d:	50                   	push   %eax
    170e:	ff 75 08             	pushl  0x8(%ebp)
    1711:	e8 da fd ff ff       	call   14f0 <putc>
    1716:	83 c4 10             	add    $0x10,%esp
    1719:	eb 25                	jmp    1740 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    171b:	83 ec 08             	sub    $0x8,%esp
    171e:	6a 25                	push   $0x25
    1720:	ff 75 08             	pushl  0x8(%ebp)
    1723:	e8 c8 fd ff ff       	call   14f0 <putc>
    1728:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    172b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    172e:	0f be c0             	movsbl %al,%eax
    1731:	83 ec 08             	sub    $0x8,%esp
    1734:	50                   	push   %eax
    1735:	ff 75 08             	pushl  0x8(%ebp)
    1738:	e8 b3 fd ff ff       	call   14f0 <putc>
    173d:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1740:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    1747:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    174b:	8b 55 0c             	mov    0xc(%ebp),%edx
    174e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1751:	01 d0                	add    %edx,%eax
    1753:	0f b6 00             	movzbl (%eax),%eax
    1756:	84 c0                	test   %al,%al
    1758:	0f 85 94 fe ff ff    	jne    15f2 <printf+0x26>
    }
  }
}
    175e:	90                   	nop
    175f:	90                   	nop
    1760:	c9                   	leave  
    1761:	c3                   	ret    

00001762 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1762:	f3 0f 1e fb          	endbr32 
    1766:	55                   	push   %ebp
    1767:	89 e5                	mov    %esp,%ebp
    1769:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    176c:	8b 45 08             	mov    0x8(%ebp),%eax
    176f:	83 e8 08             	sub    $0x8,%eax
    1772:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1775:	a1 68 1c 00 00       	mov    0x1c68,%eax
    177a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    177d:	eb 24                	jmp    17a3 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    177f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1782:	8b 00                	mov    (%eax),%eax
    1784:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1787:	72 12                	jb     179b <free+0x39>
    1789:	8b 45 f8             	mov    -0x8(%ebp),%eax
    178c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    178f:	77 24                	ja     17b5 <free+0x53>
    1791:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1794:	8b 00                	mov    (%eax),%eax
    1796:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1799:	72 1a                	jb     17b5 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    179b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179e:	8b 00                	mov    (%eax),%eax
    17a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17a6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17a9:	76 d4                	jbe    177f <free+0x1d>
    17ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ae:	8b 00                	mov    (%eax),%eax
    17b0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    17b3:	73 ca                	jae    177f <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    17b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b8:	8b 40 04             	mov    0x4(%eax),%eax
    17bb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    17c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c5:	01 c2                	add    %eax,%edx
    17c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ca:	8b 00                	mov    (%eax),%eax
    17cc:	39 c2                	cmp    %eax,%edx
    17ce:	75 24                	jne    17f4 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    17d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17d3:	8b 50 04             	mov    0x4(%eax),%edx
    17d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d9:	8b 00                	mov    (%eax),%eax
    17db:	8b 40 04             	mov    0x4(%eax),%eax
    17de:	01 c2                	add    %eax,%edx
    17e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e3:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    17e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e9:	8b 00                	mov    (%eax),%eax
    17eb:	8b 10                	mov    (%eax),%edx
    17ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f0:	89 10                	mov    %edx,(%eax)
    17f2:	eb 0a                	jmp    17fe <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    17f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f7:	8b 10                	mov    (%eax),%edx
    17f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17fc:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    17fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1801:	8b 40 04             	mov    0x4(%eax),%eax
    1804:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    180b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    180e:	01 d0                	add    %edx,%eax
    1810:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1813:	75 20                	jne    1835 <free+0xd3>
    p->s.size += bp->s.size;
    1815:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1818:	8b 50 04             	mov    0x4(%eax),%edx
    181b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    181e:	8b 40 04             	mov    0x4(%eax),%eax
    1821:	01 c2                	add    %eax,%edx
    1823:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1826:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1829:	8b 45 f8             	mov    -0x8(%ebp),%eax
    182c:	8b 10                	mov    (%eax),%edx
    182e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1831:	89 10                	mov    %edx,(%eax)
    1833:	eb 08                	jmp    183d <free+0xdb>
  } else
    p->s.ptr = bp;
    1835:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1838:	8b 55 f8             	mov    -0x8(%ebp),%edx
    183b:	89 10                	mov    %edx,(%eax)
  freep = p;
    183d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1840:	a3 68 1c 00 00       	mov    %eax,0x1c68
}
    1845:	90                   	nop
    1846:	c9                   	leave  
    1847:	c3                   	ret    

00001848 <morecore>:

static Header*
morecore(uint nu)
{
    1848:	f3 0f 1e fb          	endbr32 
    184c:	55                   	push   %ebp
    184d:	89 e5                	mov    %esp,%ebp
    184f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1852:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1859:	77 07                	ja     1862 <morecore+0x1a>
    nu = 4096;
    185b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1862:	8b 45 08             	mov    0x8(%ebp),%eax
    1865:	c1 e0 03             	shl    $0x3,%eax
    1868:	83 ec 0c             	sub    $0xc,%esp
    186b:	50                   	push   %eax
    186c:	e8 57 fc ff ff       	call   14c8 <sbrk>
    1871:	83 c4 10             	add    $0x10,%esp
    1874:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1877:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    187b:	75 07                	jne    1884 <morecore+0x3c>
    return 0;
    187d:	b8 00 00 00 00       	mov    $0x0,%eax
    1882:	eb 26                	jmp    18aa <morecore+0x62>
  hp = (Header*)p;
    1884:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1887:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    188a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    188d:	8b 55 08             	mov    0x8(%ebp),%edx
    1890:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1893:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1896:	83 c0 08             	add    $0x8,%eax
    1899:	83 ec 0c             	sub    $0xc,%esp
    189c:	50                   	push   %eax
    189d:	e8 c0 fe ff ff       	call   1762 <free>
    18a2:	83 c4 10             	add    $0x10,%esp
  return freep;
    18a5:	a1 68 1c 00 00       	mov    0x1c68,%eax
}
    18aa:	c9                   	leave  
    18ab:	c3                   	ret    

000018ac <malloc>:

void*
malloc(uint nbytes)
{
    18ac:	f3 0f 1e fb          	endbr32 
    18b0:	55                   	push   %ebp
    18b1:	89 e5                	mov    %esp,%ebp
    18b3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18b6:	8b 45 08             	mov    0x8(%ebp),%eax
    18b9:	83 c0 07             	add    $0x7,%eax
    18bc:	c1 e8 03             	shr    $0x3,%eax
    18bf:	83 c0 01             	add    $0x1,%eax
    18c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    18c5:	a1 68 1c 00 00       	mov    0x1c68,%eax
    18ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18cd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18d1:	75 23                	jne    18f6 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    18d3:	c7 45 f0 60 1c 00 00 	movl   $0x1c60,-0x10(%ebp)
    18da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18dd:	a3 68 1c 00 00       	mov    %eax,0x1c68
    18e2:	a1 68 1c 00 00       	mov    0x1c68,%eax
    18e7:	a3 60 1c 00 00       	mov    %eax,0x1c60
    base.s.size = 0;
    18ec:	c7 05 64 1c 00 00 00 	movl   $0x0,0x1c64
    18f3:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18f9:	8b 00                	mov    (%eax),%eax
    18fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    18fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1901:	8b 40 04             	mov    0x4(%eax),%eax
    1904:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1907:	77 4d                	ja     1956 <malloc+0xaa>
      if(p->s.size == nunits)
    1909:	8b 45 f4             	mov    -0xc(%ebp),%eax
    190c:	8b 40 04             	mov    0x4(%eax),%eax
    190f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1912:	75 0c                	jne    1920 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    1914:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1917:	8b 10                	mov    (%eax),%edx
    1919:	8b 45 f0             	mov    -0x10(%ebp),%eax
    191c:	89 10                	mov    %edx,(%eax)
    191e:	eb 26                	jmp    1946 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    1920:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1923:	8b 40 04             	mov    0x4(%eax),%eax
    1926:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1929:	89 c2                	mov    %eax,%edx
    192b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1931:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1934:	8b 40 04             	mov    0x4(%eax),%eax
    1937:	c1 e0 03             	shl    $0x3,%eax
    193a:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    193d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1940:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1943:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1946:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1949:	a3 68 1c 00 00       	mov    %eax,0x1c68
      return (void*)(p + 1);
    194e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1951:	83 c0 08             	add    $0x8,%eax
    1954:	eb 3b                	jmp    1991 <malloc+0xe5>
    }
    if(p == freep)
    1956:	a1 68 1c 00 00       	mov    0x1c68,%eax
    195b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    195e:	75 1e                	jne    197e <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1960:	83 ec 0c             	sub    $0xc,%esp
    1963:	ff 75 ec             	pushl  -0x14(%ebp)
    1966:	e8 dd fe ff ff       	call   1848 <morecore>
    196b:	83 c4 10             	add    $0x10,%esp
    196e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1971:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1975:	75 07                	jne    197e <malloc+0xd2>
        return 0;
    1977:	b8 00 00 00 00       	mov    $0x0,%eax
    197c:	eb 13                	jmp    1991 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    197e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1981:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1984:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1987:	8b 00                	mov    (%eax),%eax
    1989:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    198c:	e9 6d ff ff ff       	jmp    18fe <malloc+0x52>
  }
}
    1991:	c9                   	leave  
    1992:	c3                   	ret    
