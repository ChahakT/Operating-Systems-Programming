
_grep:     file format elf32-i386


Disassembly of section .text:

00001000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
    1000:	f3 0f 1e fb          	endbr32 
    1004:	55                   	push   %ebp
    1005:	89 e5                	mov    %esp,%ebp
    1007:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;

  m = 0;
    100a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    1011:	e9 ae 00 00 00       	jmp    10c4 <grep+0xc4>
    m += n;
    1016:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1019:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
    101c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    101f:	05 60 1e 00 00       	add    $0x1e60,%eax
    1024:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
    1027:	c7 45 f0 60 1e 00 00 	movl   $0x1e60,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
    102e:	eb 44                	jmp    1074 <grep+0x74>
      *q = 0;
    1030:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1033:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
    1036:	83 ec 08             	sub    $0x8,%esp
    1039:	ff 75 f0             	pushl  -0x10(%ebp)
    103c:	ff 75 08             	pushl  0x8(%ebp)
    103f:	e8 97 01 00 00       	call   11db <match>
    1044:	83 c4 10             	add    $0x10,%esp
    1047:	85 c0                	test   %eax,%eax
    1049:	74 20                	je     106b <grep+0x6b>
        *q = '\n';
    104b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    104e:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
    1051:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1054:	83 c0 01             	add    $0x1,%eax
    1057:	2b 45 f0             	sub    -0x10(%ebp),%eax
    105a:	83 ec 04             	sub    $0x4,%esp
    105d:	50                   	push   %eax
    105e:	ff 75 f0             	pushl  -0x10(%ebp)
    1061:	6a 01                	push   $0x1
    1063:	e8 76 05 00 00       	call   15de <write>
    1068:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
    106b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    106e:	83 c0 01             	add    $0x1,%eax
    1071:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
    1074:	83 ec 08             	sub    $0x8,%esp
    1077:	6a 0a                	push   $0xa
    1079:	ff 75 f0             	pushl  -0x10(%ebp)
    107c:	e8 a8 03 00 00       	call   1429 <strchr>
    1081:	83 c4 10             	add    $0x10,%esp
    1084:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1087:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    108b:	75 a3                	jne    1030 <grep+0x30>
    }
    if(p == buf)
    108d:	81 7d f0 60 1e 00 00 	cmpl   $0x1e60,-0x10(%ebp)
    1094:	75 07                	jne    109d <grep+0x9d>
      m = 0;
    1096:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
    109d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10a1:	7e 21                	jle    10c4 <grep+0xc4>
      m -= p - buf;
    10a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10a6:	2d 60 1e 00 00       	sub    $0x1e60,%eax
    10ab:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
    10ae:	83 ec 04             	sub    $0x4,%esp
    10b1:	ff 75 f4             	pushl  -0xc(%ebp)
    10b4:	ff 75 f0             	pushl  -0x10(%ebp)
    10b7:	68 60 1e 00 00       	push   $0x1e60
    10bc:	e8 b4 04 00 00       	call   1575 <memmove>
    10c1:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    10c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c7:	ba ff 03 00 00       	mov    $0x3ff,%edx
    10cc:	29 c2                	sub    %eax,%edx
    10ce:	89 d0                	mov    %edx,%eax
    10d0:	89 c2                	mov    %eax,%edx
    10d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10d5:	05 60 1e 00 00       	add    $0x1e60,%eax
    10da:	83 ec 04             	sub    $0x4,%esp
    10dd:	52                   	push   %edx
    10de:	50                   	push   %eax
    10df:	ff 75 0c             	pushl  0xc(%ebp)
    10e2:	e8 ef 04 00 00       	call   15d6 <read>
    10e7:	83 c4 10             	add    $0x10,%esp
    10ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
    10ed:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10f1:	0f 8f 1f ff ff ff    	jg     1016 <grep+0x16>
    }
  }
}
    10f7:	90                   	nop
    10f8:	90                   	nop
    10f9:	c9                   	leave  
    10fa:	c3                   	ret    

000010fb <main>:

int
main(int argc, char *argv[])
{
    10fb:	f3 0f 1e fb          	endbr32 
    10ff:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1103:	83 e4 f0             	and    $0xfffffff0,%esp
    1106:	ff 71 fc             	pushl  -0x4(%ecx)
    1109:	55                   	push   %ebp
    110a:	89 e5                	mov    %esp,%ebp
    110c:	53                   	push   %ebx
    110d:	51                   	push   %ecx
    110e:	83 ec 10             	sub    $0x10,%esp
    1111:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
    1113:	83 3b 01             	cmpl   $0x1,(%ebx)
    1116:	7f 17                	jg     112f <main+0x34>
    printf(2, "usage: grep pattern [file ...]\n");
    1118:	83 ec 08             	sub    $0x8,%esp
    111b:	68 14 1b 00 00       	push   $0x1b14
    1120:	6a 02                	push   $0x2
    1122:	e8 23 06 00 00       	call   174a <printf>
    1127:	83 c4 10             	add    $0x10,%esp
    exit();
    112a:	e8 8f 04 00 00       	call   15be <exit>
  }
  pattern = argv[1];
    112f:	8b 43 04             	mov    0x4(%ebx),%eax
    1132:	8b 40 04             	mov    0x4(%eax),%eax
    1135:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(argc <= 2){
    1138:	83 3b 02             	cmpl   $0x2,(%ebx)
    113b:	7f 15                	jg     1152 <main+0x57>
    grep(pattern, 0);
    113d:	83 ec 08             	sub    $0x8,%esp
    1140:	6a 00                	push   $0x0
    1142:	ff 75 f0             	pushl  -0x10(%ebp)
    1145:	e8 b6 fe ff ff       	call   1000 <grep>
    114a:	83 c4 10             	add    $0x10,%esp
    exit();
    114d:	e8 6c 04 00 00       	call   15be <exit>
  }

  for(i = 2; i < argc; i++){
    1152:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
    1159:	eb 74                	jmp    11cf <main+0xd4>
    if((fd = open(argv[i], 0)) < 0){
    115b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    115e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1165:	8b 43 04             	mov    0x4(%ebx),%eax
    1168:	01 d0                	add    %edx,%eax
    116a:	8b 00                	mov    (%eax),%eax
    116c:	83 ec 08             	sub    $0x8,%esp
    116f:	6a 00                	push   $0x0
    1171:	50                   	push   %eax
    1172:	e8 87 04 00 00       	call   15fe <open>
    1177:	83 c4 10             	add    $0x10,%esp
    117a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    117d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1181:	79 29                	jns    11ac <main+0xb1>
      printf(1, "grep: cannot open %s\n", argv[i]);
    1183:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1186:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    118d:	8b 43 04             	mov    0x4(%ebx),%eax
    1190:	01 d0                	add    %edx,%eax
    1192:	8b 00                	mov    (%eax),%eax
    1194:	83 ec 04             	sub    $0x4,%esp
    1197:	50                   	push   %eax
    1198:	68 34 1b 00 00       	push   $0x1b34
    119d:	6a 01                	push   $0x1
    119f:	e8 a6 05 00 00       	call   174a <printf>
    11a4:	83 c4 10             	add    $0x10,%esp
      exit();
    11a7:	e8 12 04 00 00       	call   15be <exit>
    }
    grep(pattern, fd);
    11ac:	83 ec 08             	sub    $0x8,%esp
    11af:	ff 75 ec             	pushl  -0x14(%ebp)
    11b2:	ff 75 f0             	pushl  -0x10(%ebp)
    11b5:	e8 46 fe ff ff       	call   1000 <grep>
    11ba:	83 c4 10             	add    $0x10,%esp
    close(fd);
    11bd:	83 ec 0c             	sub    $0xc,%esp
    11c0:	ff 75 ec             	pushl  -0x14(%ebp)
    11c3:	e8 1e 04 00 00       	call   15e6 <close>
    11c8:	83 c4 10             	add    $0x10,%esp
  for(i = 2; i < argc; i++){
    11cb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11d2:	3b 03                	cmp    (%ebx),%eax
    11d4:	7c 85                	jl     115b <main+0x60>
  }
  exit();
    11d6:	e8 e3 03 00 00       	call   15be <exit>

000011db <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
    11db:	f3 0f 1e fb          	endbr32 
    11df:	55                   	push   %ebp
    11e0:	89 e5                	mov    %esp,%ebp
    11e2:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
    11e5:	8b 45 08             	mov    0x8(%ebp),%eax
    11e8:	0f b6 00             	movzbl (%eax),%eax
    11eb:	3c 5e                	cmp    $0x5e,%al
    11ed:	75 17                	jne    1206 <match+0x2b>
    return matchhere(re+1, text);
    11ef:	8b 45 08             	mov    0x8(%ebp),%eax
    11f2:	83 c0 01             	add    $0x1,%eax
    11f5:	83 ec 08             	sub    $0x8,%esp
    11f8:	ff 75 0c             	pushl  0xc(%ebp)
    11fb:	50                   	push   %eax
    11fc:	e8 38 00 00 00       	call   1239 <matchhere>
    1201:	83 c4 10             	add    $0x10,%esp
    1204:	eb 31                	jmp    1237 <match+0x5c>
  do{  // must look at empty string
    if(matchhere(re, text))
    1206:	83 ec 08             	sub    $0x8,%esp
    1209:	ff 75 0c             	pushl  0xc(%ebp)
    120c:	ff 75 08             	pushl  0x8(%ebp)
    120f:	e8 25 00 00 00       	call   1239 <matchhere>
    1214:	83 c4 10             	add    $0x10,%esp
    1217:	85 c0                	test   %eax,%eax
    1219:	74 07                	je     1222 <match+0x47>
      return 1;
    121b:	b8 01 00 00 00       	mov    $0x1,%eax
    1220:	eb 15                	jmp    1237 <match+0x5c>
  }while(*text++ != '\0');
    1222:	8b 45 0c             	mov    0xc(%ebp),%eax
    1225:	8d 50 01             	lea    0x1(%eax),%edx
    1228:	89 55 0c             	mov    %edx,0xc(%ebp)
    122b:	0f b6 00             	movzbl (%eax),%eax
    122e:	84 c0                	test   %al,%al
    1230:	75 d4                	jne    1206 <match+0x2b>
  return 0;
    1232:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1237:	c9                   	leave  
    1238:	c3                   	ret    

00001239 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
    1239:	f3 0f 1e fb          	endbr32 
    123d:	55                   	push   %ebp
    123e:	89 e5                	mov    %esp,%ebp
    1240:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
    1243:	8b 45 08             	mov    0x8(%ebp),%eax
    1246:	0f b6 00             	movzbl (%eax),%eax
    1249:	84 c0                	test   %al,%al
    124b:	75 0a                	jne    1257 <matchhere+0x1e>
    return 1;
    124d:	b8 01 00 00 00       	mov    $0x1,%eax
    1252:	e9 99 00 00 00       	jmp    12f0 <matchhere+0xb7>
  if(re[1] == '*')
    1257:	8b 45 08             	mov    0x8(%ebp),%eax
    125a:	83 c0 01             	add    $0x1,%eax
    125d:	0f b6 00             	movzbl (%eax),%eax
    1260:	3c 2a                	cmp    $0x2a,%al
    1262:	75 21                	jne    1285 <matchhere+0x4c>
    return matchstar(re[0], re+2, text);
    1264:	8b 45 08             	mov    0x8(%ebp),%eax
    1267:	8d 50 02             	lea    0x2(%eax),%edx
    126a:	8b 45 08             	mov    0x8(%ebp),%eax
    126d:	0f b6 00             	movzbl (%eax),%eax
    1270:	0f be c0             	movsbl %al,%eax
    1273:	83 ec 04             	sub    $0x4,%esp
    1276:	ff 75 0c             	pushl  0xc(%ebp)
    1279:	52                   	push   %edx
    127a:	50                   	push   %eax
    127b:	e8 72 00 00 00       	call   12f2 <matchstar>
    1280:	83 c4 10             	add    $0x10,%esp
    1283:	eb 6b                	jmp    12f0 <matchhere+0xb7>
  if(re[0] == '$' && re[1] == '\0')
    1285:	8b 45 08             	mov    0x8(%ebp),%eax
    1288:	0f b6 00             	movzbl (%eax),%eax
    128b:	3c 24                	cmp    $0x24,%al
    128d:	75 1d                	jne    12ac <matchhere+0x73>
    128f:	8b 45 08             	mov    0x8(%ebp),%eax
    1292:	83 c0 01             	add    $0x1,%eax
    1295:	0f b6 00             	movzbl (%eax),%eax
    1298:	84 c0                	test   %al,%al
    129a:	75 10                	jne    12ac <matchhere+0x73>
    return *text == '\0';
    129c:	8b 45 0c             	mov    0xc(%ebp),%eax
    129f:	0f b6 00             	movzbl (%eax),%eax
    12a2:	84 c0                	test   %al,%al
    12a4:	0f 94 c0             	sete   %al
    12a7:	0f b6 c0             	movzbl %al,%eax
    12aa:	eb 44                	jmp    12f0 <matchhere+0xb7>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    12ac:	8b 45 0c             	mov    0xc(%ebp),%eax
    12af:	0f b6 00             	movzbl (%eax),%eax
    12b2:	84 c0                	test   %al,%al
    12b4:	74 35                	je     12eb <matchhere+0xb2>
    12b6:	8b 45 08             	mov    0x8(%ebp),%eax
    12b9:	0f b6 00             	movzbl (%eax),%eax
    12bc:	3c 2e                	cmp    $0x2e,%al
    12be:	74 10                	je     12d0 <matchhere+0x97>
    12c0:	8b 45 08             	mov    0x8(%ebp),%eax
    12c3:	0f b6 10             	movzbl (%eax),%edx
    12c6:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c9:	0f b6 00             	movzbl (%eax),%eax
    12cc:	38 c2                	cmp    %al,%dl
    12ce:	75 1b                	jne    12eb <matchhere+0xb2>
    return matchhere(re+1, text+1);
    12d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d3:	8d 50 01             	lea    0x1(%eax),%edx
    12d6:	8b 45 08             	mov    0x8(%ebp),%eax
    12d9:	83 c0 01             	add    $0x1,%eax
    12dc:	83 ec 08             	sub    $0x8,%esp
    12df:	52                   	push   %edx
    12e0:	50                   	push   %eax
    12e1:	e8 53 ff ff ff       	call   1239 <matchhere>
    12e6:	83 c4 10             	add    $0x10,%esp
    12e9:	eb 05                	jmp    12f0 <matchhere+0xb7>
  return 0;
    12eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12f0:	c9                   	leave  
    12f1:	c3                   	ret    

000012f2 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
    12f2:	f3 0f 1e fb          	endbr32 
    12f6:	55                   	push   %ebp
    12f7:	89 e5                	mov    %esp,%ebp
    12f9:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
    12fc:	83 ec 08             	sub    $0x8,%esp
    12ff:	ff 75 10             	pushl  0x10(%ebp)
    1302:	ff 75 0c             	pushl  0xc(%ebp)
    1305:	e8 2f ff ff ff       	call   1239 <matchhere>
    130a:	83 c4 10             	add    $0x10,%esp
    130d:	85 c0                	test   %eax,%eax
    130f:	74 07                	je     1318 <matchstar+0x26>
      return 1;
    1311:	b8 01 00 00 00       	mov    $0x1,%eax
    1316:	eb 29                	jmp    1341 <matchstar+0x4f>
  }while(*text!='\0' && (*text++==c || c=='.'));
    1318:	8b 45 10             	mov    0x10(%ebp),%eax
    131b:	0f b6 00             	movzbl (%eax),%eax
    131e:	84 c0                	test   %al,%al
    1320:	74 1a                	je     133c <matchstar+0x4a>
    1322:	8b 45 10             	mov    0x10(%ebp),%eax
    1325:	8d 50 01             	lea    0x1(%eax),%edx
    1328:	89 55 10             	mov    %edx,0x10(%ebp)
    132b:	0f b6 00             	movzbl (%eax),%eax
    132e:	0f be c0             	movsbl %al,%eax
    1331:	39 45 08             	cmp    %eax,0x8(%ebp)
    1334:	74 c6                	je     12fc <matchstar+0xa>
    1336:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
    133a:	74 c0                	je     12fc <matchstar+0xa>
  return 0;
    133c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1341:	c9                   	leave  
    1342:	c3                   	ret    

00001343 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1343:	55                   	push   %ebp
    1344:	89 e5                	mov    %esp,%ebp
    1346:	57                   	push   %edi
    1347:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1348:	8b 4d 08             	mov    0x8(%ebp),%ecx
    134b:	8b 55 10             	mov    0x10(%ebp),%edx
    134e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1351:	89 cb                	mov    %ecx,%ebx
    1353:	89 df                	mov    %ebx,%edi
    1355:	89 d1                	mov    %edx,%ecx
    1357:	fc                   	cld    
    1358:	f3 aa                	rep stos %al,%es:(%edi)
    135a:	89 ca                	mov    %ecx,%edx
    135c:	89 fb                	mov    %edi,%ebx
    135e:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1361:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1364:	90                   	nop
    1365:	5b                   	pop    %ebx
    1366:	5f                   	pop    %edi
    1367:	5d                   	pop    %ebp
    1368:	c3                   	ret    

00001369 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1369:	f3 0f 1e fb          	endbr32 
    136d:	55                   	push   %ebp
    136e:	89 e5                	mov    %esp,%ebp
    1370:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1373:	8b 45 08             	mov    0x8(%ebp),%eax
    1376:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1379:	90                   	nop
    137a:	8b 55 0c             	mov    0xc(%ebp),%edx
    137d:	8d 42 01             	lea    0x1(%edx),%eax
    1380:	89 45 0c             	mov    %eax,0xc(%ebp)
    1383:	8b 45 08             	mov    0x8(%ebp),%eax
    1386:	8d 48 01             	lea    0x1(%eax),%ecx
    1389:	89 4d 08             	mov    %ecx,0x8(%ebp)
    138c:	0f b6 12             	movzbl (%edx),%edx
    138f:	88 10                	mov    %dl,(%eax)
    1391:	0f b6 00             	movzbl (%eax),%eax
    1394:	84 c0                	test   %al,%al
    1396:	75 e2                	jne    137a <strcpy+0x11>
    ;
  return os;
    1398:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    139b:	c9                   	leave  
    139c:	c3                   	ret    

0000139d <strcmp>:

int
strcmp(const char *p, const char *q)
{
    139d:	f3 0f 1e fb          	endbr32 
    13a1:	55                   	push   %ebp
    13a2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    13a4:	eb 08                	jmp    13ae <strcmp+0x11>
    p++, q++;
    13a6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13aa:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    13ae:	8b 45 08             	mov    0x8(%ebp),%eax
    13b1:	0f b6 00             	movzbl (%eax),%eax
    13b4:	84 c0                	test   %al,%al
    13b6:	74 10                	je     13c8 <strcmp+0x2b>
    13b8:	8b 45 08             	mov    0x8(%ebp),%eax
    13bb:	0f b6 10             	movzbl (%eax),%edx
    13be:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c1:	0f b6 00             	movzbl (%eax),%eax
    13c4:	38 c2                	cmp    %al,%dl
    13c6:	74 de                	je     13a6 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    13c8:	8b 45 08             	mov    0x8(%ebp),%eax
    13cb:	0f b6 00             	movzbl (%eax),%eax
    13ce:	0f b6 d0             	movzbl %al,%edx
    13d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d4:	0f b6 00             	movzbl (%eax),%eax
    13d7:	0f b6 c0             	movzbl %al,%eax
    13da:	29 c2                	sub    %eax,%edx
    13dc:	89 d0                	mov    %edx,%eax
}
    13de:	5d                   	pop    %ebp
    13df:	c3                   	ret    

000013e0 <strlen>:

uint
strlen(const char *s)
{
    13e0:	f3 0f 1e fb          	endbr32 
    13e4:	55                   	push   %ebp
    13e5:	89 e5                	mov    %esp,%ebp
    13e7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    13ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    13f1:	eb 04                	jmp    13f7 <strlen+0x17>
    13f3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    13f7:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13fa:	8b 45 08             	mov    0x8(%ebp),%eax
    13fd:	01 d0                	add    %edx,%eax
    13ff:	0f b6 00             	movzbl (%eax),%eax
    1402:	84 c0                	test   %al,%al
    1404:	75 ed                	jne    13f3 <strlen+0x13>
    ;
  return n;
    1406:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1409:	c9                   	leave  
    140a:	c3                   	ret    

0000140b <memset>:

void*
memset(void *dst, int c, uint n)
{
    140b:	f3 0f 1e fb          	endbr32 
    140f:	55                   	push   %ebp
    1410:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1412:	8b 45 10             	mov    0x10(%ebp),%eax
    1415:	50                   	push   %eax
    1416:	ff 75 0c             	pushl  0xc(%ebp)
    1419:	ff 75 08             	pushl  0x8(%ebp)
    141c:	e8 22 ff ff ff       	call   1343 <stosb>
    1421:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1424:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1427:	c9                   	leave  
    1428:	c3                   	ret    

00001429 <strchr>:

char*
strchr(const char *s, char c)
{
    1429:	f3 0f 1e fb          	endbr32 
    142d:	55                   	push   %ebp
    142e:	89 e5                	mov    %esp,%ebp
    1430:	83 ec 04             	sub    $0x4,%esp
    1433:	8b 45 0c             	mov    0xc(%ebp),%eax
    1436:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1439:	eb 14                	jmp    144f <strchr+0x26>
    if(*s == c)
    143b:	8b 45 08             	mov    0x8(%ebp),%eax
    143e:	0f b6 00             	movzbl (%eax),%eax
    1441:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1444:	75 05                	jne    144b <strchr+0x22>
      return (char*)s;
    1446:	8b 45 08             	mov    0x8(%ebp),%eax
    1449:	eb 13                	jmp    145e <strchr+0x35>
  for(; *s; s++)
    144b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    144f:	8b 45 08             	mov    0x8(%ebp),%eax
    1452:	0f b6 00             	movzbl (%eax),%eax
    1455:	84 c0                	test   %al,%al
    1457:	75 e2                	jne    143b <strchr+0x12>
  return 0;
    1459:	b8 00 00 00 00       	mov    $0x0,%eax
}
    145e:	c9                   	leave  
    145f:	c3                   	ret    

00001460 <gets>:

char*
gets(char *buf, int max)
{
    1460:	f3 0f 1e fb          	endbr32 
    1464:	55                   	push   %ebp
    1465:	89 e5                	mov    %esp,%ebp
    1467:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    146a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1471:	eb 42                	jmp    14b5 <gets+0x55>
    cc = read(0, &c, 1);
    1473:	83 ec 04             	sub    $0x4,%esp
    1476:	6a 01                	push   $0x1
    1478:	8d 45 ef             	lea    -0x11(%ebp),%eax
    147b:	50                   	push   %eax
    147c:	6a 00                	push   $0x0
    147e:	e8 53 01 00 00       	call   15d6 <read>
    1483:	83 c4 10             	add    $0x10,%esp
    1486:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1489:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    148d:	7e 33                	jle    14c2 <gets+0x62>
      break;
    buf[i++] = c;
    148f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1492:	8d 50 01             	lea    0x1(%eax),%edx
    1495:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1498:	89 c2                	mov    %eax,%edx
    149a:	8b 45 08             	mov    0x8(%ebp),%eax
    149d:	01 c2                	add    %eax,%edx
    149f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14a3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    14a5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14a9:	3c 0a                	cmp    $0xa,%al
    14ab:	74 16                	je     14c3 <gets+0x63>
    14ad:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14b1:	3c 0d                	cmp    $0xd,%al
    14b3:	74 0e                	je     14c3 <gets+0x63>
  for(i=0; i+1 < max; ){
    14b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b8:	83 c0 01             	add    $0x1,%eax
    14bb:	39 45 0c             	cmp    %eax,0xc(%ebp)
    14be:	7f b3                	jg     1473 <gets+0x13>
    14c0:	eb 01                	jmp    14c3 <gets+0x63>
      break;
    14c2:	90                   	nop
      break;
  }
  buf[i] = '\0';
    14c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    14c6:	8b 45 08             	mov    0x8(%ebp),%eax
    14c9:	01 d0                	add    %edx,%eax
    14cb:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    14ce:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14d1:	c9                   	leave  
    14d2:	c3                   	ret    

000014d3 <stat>:

int
stat(const char *n, struct stat *st)
{
    14d3:	f3 0f 1e fb          	endbr32 
    14d7:	55                   	push   %ebp
    14d8:	89 e5                	mov    %esp,%ebp
    14da:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14dd:	83 ec 08             	sub    $0x8,%esp
    14e0:	6a 00                	push   $0x0
    14e2:	ff 75 08             	pushl  0x8(%ebp)
    14e5:	e8 14 01 00 00       	call   15fe <open>
    14ea:	83 c4 10             	add    $0x10,%esp
    14ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    14f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14f4:	79 07                	jns    14fd <stat+0x2a>
    return -1;
    14f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14fb:	eb 25                	jmp    1522 <stat+0x4f>
  r = fstat(fd, st);
    14fd:	83 ec 08             	sub    $0x8,%esp
    1500:	ff 75 0c             	pushl  0xc(%ebp)
    1503:	ff 75 f4             	pushl  -0xc(%ebp)
    1506:	e8 0b 01 00 00       	call   1616 <fstat>
    150b:	83 c4 10             	add    $0x10,%esp
    150e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1511:	83 ec 0c             	sub    $0xc,%esp
    1514:	ff 75 f4             	pushl  -0xc(%ebp)
    1517:	e8 ca 00 00 00       	call   15e6 <close>
    151c:	83 c4 10             	add    $0x10,%esp
  return r;
    151f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1522:	c9                   	leave  
    1523:	c3                   	ret    

00001524 <atoi>:

int
atoi(const char *s)
{
    1524:	f3 0f 1e fb          	endbr32 
    1528:	55                   	push   %ebp
    1529:	89 e5                	mov    %esp,%ebp
    152b:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    152e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1535:	eb 25                	jmp    155c <atoi+0x38>
    n = n*10 + *s++ - '0';
    1537:	8b 55 fc             	mov    -0x4(%ebp),%edx
    153a:	89 d0                	mov    %edx,%eax
    153c:	c1 e0 02             	shl    $0x2,%eax
    153f:	01 d0                	add    %edx,%eax
    1541:	01 c0                	add    %eax,%eax
    1543:	89 c1                	mov    %eax,%ecx
    1545:	8b 45 08             	mov    0x8(%ebp),%eax
    1548:	8d 50 01             	lea    0x1(%eax),%edx
    154b:	89 55 08             	mov    %edx,0x8(%ebp)
    154e:	0f b6 00             	movzbl (%eax),%eax
    1551:	0f be c0             	movsbl %al,%eax
    1554:	01 c8                	add    %ecx,%eax
    1556:	83 e8 30             	sub    $0x30,%eax
    1559:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    155c:	8b 45 08             	mov    0x8(%ebp),%eax
    155f:	0f b6 00             	movzbl (%eax),%eax
    1562:	3c 2f                	cmp    $0x2f,%al
    1564:	7e 0a                	jle    1570 <atoi+0x4c>
    1566:	8b 45 08             	mov    0x8(%ebp),%eax
    1569:	0f b6 00             	movzbl (%eax),%eax
    156c:	3c 39                	cmp    $0x39,%al
    156e:	7e c7                	jle    1537 <atoi+0x13>
  return n;
    1570:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1573:	c9                   	leave  
    1574:	c3                   	ret    

00001575 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1575:	f3 0f 1e fb          	endbr32 
    1579:	55                   	push   %ebp
    157a:	89 e5                	mov    %esp,%ebp
    157c:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    157f:	8b 45 08             	mov    0x8(%ebp),%eax
    1582:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1585:	8b 45 0c             	mov    0xc(%ebp),%eax
    1588:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    158b:	eb 17                	jmp    15a4 <memmove+0x2f>
    *dst++ = *src++;
    158d:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1590:	8d 42 01             	lea    0x1(%edx),%eax
    1593:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1596:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1599:	8d 48 01             	lea    0x1(%eax),%ecx
    159c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    159f:	0f b6 12             	movzbl (%edx),%edx
    15a2:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    15a4:	8b 45 10             	mov    0x10(%ebp),%eax
    15a7:	8d 50 ff             	lea    -0x1(%eax),%edx
    15aa:	89 55 10             	mov    %edx,0x10(%ebp)
    15ad:	85 c0                	test   %eax,%eax
    15af:	7f dc                	jg     158d <memmove+0x18>
  return vdst;
    15b1:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15b4:	c9                   	leave  
    15b5:	c3                   	ret    

000015b6 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    15b6:	b8 01 00 00 00       	mov    $0x1,%eax
    15bb:	cd 40                	int    $0x40
    15bd:	c3                   	ret    

000015be <exit>:
SYSCALL(exit)
    15be:	b8 02 00 00 00       	mov    $0x2,%eax
    15c3:	cd 40                	int    $0x40
    15c5:	c3                   	ret    

000015c6 <wait>:
SYSCALL(wait)
    15c6:	b8 03 00 00 00       	mov    $0x3,%eax
    15cb:	cd 40                	int    $0x40
    15cd:	c3                   	ret    

000015ce <pipe>:
SYSCALL(pipe)
    15ce:	b8 04 00 00 00       	mov    $0x4,%eax
    15d3:	cd 40                	int    $0x40
    15d5:	c3                   	ret    

000015d6 <read>:
SYSCALL(read)
    15d6:	b8 05 00 00 00       	mov    $0x5,%eax
    15db:	cd 40                	int    $0x40
    15dd:	c3                   	ret    

000015de <write>:
SYSCALL(write)
    15de:	b8 10 00 00 00       	mov    $0x10,%eax
    15e3:	cd 40                	int    $0x40
    15e5:	c3                   	ret    

000015e6 <close>:
SYSCALL(close)
    15e6:	b8 15 00 00 00       	mov    $0x15,%eax
    15eb:	cd 40                	int    $0x40
    15ed:	c3                   	ret    

000015ee <kill>:
SYSCALL(kill)
    15ee:	b8 06 00 00 00       	mov    $0x6,%eax
    15f3:	cd 40                	int    $0x40
    15f5:	c3                   	ret    

000015f6 <exec>:
SYSCALL(exec)
    15f6:	b8 07 00 00 00       	mov    $0x7,%eax
    15fb:	cd 40                	int    $0x40
    15fd:	c3                   	ret    

000015fe <open>:
SYSCALL(open)
    15fe:	b8 0f 00 00 00       	mov    $0xf,%eax
    1603:	cd 40                	int    $0x40
    1605:	c3                   	ret    

00001606 <mknod>:
SYSCALL(mknod)
    1606:	b8 11 00 00 00       	mov    $0x11,%eax
    160b:	cd 40                	int    $0x40
    160d:	c3                   	ret    

0000160e <unlink>:
SYSCALL(unlink)
    160e:	b8 12 00 00 00       	mov    $0x12,%eax
    1613:	cd 40                	int    $0x40
    1615:	c3                   	ret    

00001616 <fstat>:
SYSCALL(fstat)
    1616:	b8 08 00 00 00       	mov    $0x8,%eax
    161b:	cd 40                	int    $0x40
    161d:	c3                   	ret    

0000161e <link>:
SYSCALL(link)
    161e:	b8 13 00 00 00       	mov    $0x13,%eax
    1623:	cd 40                	int    $0x40
    1625:	c3                   	ret    

00001626 <mkdir>:
SYSCALL(mkdir)
    1626:	b8 14 00 00 00       	mov    $0x14,%eax
    162b:	cd 40                	int    $0x40
    162d:	c3                   	ret    

0000162e <chdir>:
SYSCALL(chdir)
    162e:	b8 09 00 00 00       	mov    $0x9,%eax
    1633:	cd 40                	int    $0x40
    1635:	c3                   	ret    

00001636 <dup>:
SYSCALL(dup)
    1636:	b8 0a 00 00 00       	mov    $0xa,%eax
    163b:	cd 40                	int    $0x40
    163d:	c3                   	ret    

0000163e <getpid>:
SYSCALL(getpid)
    163e:	b8 0b 00 00 00       	mov    $0xb,%eax
    1643:	cd 40                	int    $0x40
    1645:	c3                   	ret    

00001646 <sbrk>:
SYSCALL(sbrk)
    1646:	b8 0c 00 00 00       	mov    $0xc,%eax
    164b:	cd 40                	int    $0x40
    164d:	c3                   	ret    

0000164e <sleep>:
SYSCALL(sleep)
    164e:	b8 0d 00 00 00       	mov    $0xd,%eax
    1653:	cd 40                	int    $0x40
    1655:	c3                   	ret    

00001656 <uptime>:
SYSCALL(uptime)
    1656:	b8 0e 00 00 00       	mov    $0xe,%eax
    165b:	cd 40                	int    $0x40
    165d:	c3                   	ret    

0000165e <settickets>:
SYSCALL(settickets)
    165e:	b8 16 00 00 00       	mov    $0x16,%eax
    1663:	cd 40                	int    $0x40
    1665:	c3                   	ret    

00001666 <getpinfo>:
SYSCALL(getpinfo)
    1666:	b8 17 00 00 00       	mov    $0x17,%eax
    166b:	cd 40                	int    $0x40
    166d:	c3                   	ret    

0000166e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    166e:	f3 0f 1e fb          	endbr32 
    1672:	55                   	push   %ebp
    1673:	89 e5                	mov    %esp,%ebp
    1675:	83 ec 18             	sub    $0x18,%esp
    1678:	8b 45 0c             	mov    0xc(%ebp),%eax
    167b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    167e:	83 ec 04             	sub    $0x4,%esp
    1681:	6a 01                	push   $0x1
    1683:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1686:	50                   	push   %eax
    1687:	ff 75 08             	pushl  0x8(%ebp)
    168a:	e8 4f ff ff ff       	call   15de <write>
    168f:	83 c4 10             	add    $0x10,%esp
}
    1692:	90                   	nop
    1693:	c9                   	leave  
    1694:	c3                   	ret    

00001695 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1695:	f3 0f 1e fb          	endbr32 
    1699:	55                   	push   %ebp
    169a:	89 e5                	mov    %esp,%ebp
    169c:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    169f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    16a6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    16aa:	74 17                	je     16c3 <printint+0x2e>
    16ac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16b0:	79 11                	jns    16c3 <printint+0x2e>
    neg = 1;
    16b2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    16b9:	8b 45 0c             	mov    0xc(%ebp),%eax
    16bc:	f7 d8                	neg    %eax
    16be:	89 45 ec             	mov    %eax,-0x14(%ebp)
    16c1:	eb 06                	jmp    16c9 <printint+0x34>
  } else {
    x = xx;
    16c3:	8b 45 0c             	mov    0xc(%ebp),%eax
    16c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    16c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    16d0:	8b 4d 10             	mov    0x10(%ebp),%ecx
    16d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16d6:	ba 00 00 00 00       	mov    $0x0,%edx
    16db:	f7 f1                	div    %ecx
    16dd:	89 d1                	mov    %edx,%ecx
    16df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e2:	8d 50 01             	lea    0x1(%eax),%edx
    16e5:	89 55 f4             	mov    %edx,-0xc(%ebp)
    16e8:	0f b6 91 1c 1e 00 00 	movzbl 0x1e1c(%ecx),%edx
    16ef:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    16f3:	8b 4d 10             	mov    0x10(%ebp),%ecx
    16f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16f9:	ba 00 00 00 00       	mov    $0x0,%edx
    16fe:	f7 f1                	div    %ecx
    1700:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1703:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1707:	75 c7                	jne    16d0 <printint+0x3b>
  if(neg)
    1709:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    170d:	74 2d                	je     173c <printint+0xa7>
    buf[i++] = '-';
    170f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1712:	8d 50 01             	lea    0x1(%eax),%edx
    1715:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1718:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    171d:	eb 1d                	jmp    173c <printint+0xa7>
    putc(fd, buf[i]);
    171f:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1722:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1725:	01 d0                	add    %edx,%eax
    1727:	0f b6 00             	movzbl (%eax),%eax
    172a:	0f be c0             	movsbl %al,%eax
    172d:	83 ec 08             	sub    $0x8,%esp
    1730:	50                   	push   %eax
    1731:	ff 75 08             	pushl  0x8(%ebp)
    1734:	e8 35 ff ff ff       	call   166e <putc>
    1739:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    173c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1740:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1744:	79 d9                	jns    171f <printint+0x8a>
}
    1746:	90                   	nop
    1747:	90                   	nop
    1748:	c9                   	leave  
    1749:	c3                   	ret    

0000174a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    174a:	f3 0f 1e fb          	endbr32 
    174e:	55                   	push   %ebp
    174f:	89 e5                	mov    %esp,%ebp
    1751:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1754:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    175b:	8d 45 0c             	lea    0xc(%ebp),%eax
    175e:	83 c0 04             	add    $0x4,%eax
    1761:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1764:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    176b:	e9 59 01 00 00       	jmp    18c9 <printf+0x17f>
    c = fmt[i] & 0xff;
    1770:	8b 55 0c             	mov    0xc(%ebp),%edx
    1773:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1776:	01 d0                	add    %edx,%eax
    1778:	0f b6 00             	movzbl (%eax),%eax
    177b:	0f be c0             	movsbl %al,%eax
    177e:	25 ff 00 00 00       	and    $0xff,%eax
    1783:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1786:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    178a:	75 2c                	jne    17b8 <printf+0x6e>
      if(c == '%'){
    178c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1790:	75 0c                	jne    179e <printf+0x54>
        state = '%';
    1792:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1799:	e9 27 01 00 00       	jmp    18c5 <printf+0x17b>
      } else {
        putc(fd, c);
    179e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17a1:	0f be c0             	movsbl %al,%eax
    17a4:	83 ec 08             	sub    $0x8,%esp
    17a7:	50                   	push   %eax
    17a8:	ff 75 08             	pushl  0x8(%ebp)
    17ab:	e8 be fe ff ff       	call   166e <putc>
    17b0:	83 c4 10             	add    $0x10,%esp
    17b3:	e9 0d 01 00 00       	jmp    18c5 <printf+0x17b>
      }
    } else if(state == '%'){
    17b8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    17bc:	0f 85 03 01 00 00    	jne    18c5 <printf+0x17b>
      if(c == 'd'){
    17c2:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    17c6:	75 1e                	jne    17e6 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    17c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17cb:	8b 00                	mov    (%eax),%eax
    17cd:	6a 01                	push   $0x1
    17cf:	6a 0a                	push   $0xa
    17d1:	50                   	push   %eax
    17d2:	ff 75 08             	pushl  0x8(%ebp)
    17d5:	e8 bb fe ff ff       	call   1695 <printint>
    17da:	83 c4 10             	add    $0x10,%esp
        ap++;
    17dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    17e1:	e9 d8 00 00 00       	jmp    18be <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    17e6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    17ea:	74 06                	je     17f2 <printf+0xa8>
    17ec:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    17f0:	75 1e                	jne    1810 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    17f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17f5:	8b 00                	mov    (%eax),%eax
    17f7:	6a 00                	push   $0x0
    17f9:	6a 10                	push   $0x10
    17fb:	50                   	push   %eax
    17fc:	ff 75 08             	pushl  0x8(%ebp)
    17ff:	e8 91 fe ff ff       	call   1695 <printint>
    1804:	83 c4 10             	add    $0x10,%esp
        ap++;
    1807:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    180b:	e9 ae 00 00 00       	jmp    18be <printf+0x174>
      } else if(c == 's'){
    1810:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1814:	75 43                	jne    1859 <printf+0x10f>
        s = (char*)*ap;
    1816:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1819:	8b 00                	mov    (%eax),%eax
    181b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    181e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1822:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1826:	75 25                	jne    184d <printf+0x103>
          s = "(null)";
    1828:	c7 45 f4 4a 1b 00 00 	movl   $0x1b4a,-0xc(%ebp)
        while(*s != 0){
    182f:	eb 1c                	jmp    184d <printf+0x103>
          putc(fd, *s);
    1831:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1834:	0f b6 00             	movzbl (%eax),%eax
    1837:	0f be c0             	movsbl %al,%eax
    183a:	83 ec 08             	sub    $0x8,%esp
    183d:	50                   	push   %eax
    183e:	ff 75 08             	pushl  0x8(%ebp)
    1841:	e8 28 fe ff ff       	call   166e <putc>
    1846:	83 c4 10             	add    $0x10,%esp
          s++;
    1849:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    184d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1850:	0f b6 00             	movzbl (%eax),%eax
    1853:	84 c0                	test   %al,%al
    1855:	75 da                	jne    1831 <printf+0xe7>
    1857:	eb 65                	jmp    18be <printf+0x174>
        }
      } else if(c == 'c'){
    1859:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    185d:	75 1d                	jne    187c <printf+0x132>
        putc(fd, *ap);
    185f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1862:	8b 00                	mov    (%eax),%eax
    1864:	0f be c0             	movsbl %al,%eax
    1867:	83 ec 08             	sub    $0x8,%esp
    186a:	50                   	push   %eax
    186b:	ff 75 08             	pushl  0x8(%ebp)
    186e:	e8 fb fd ff ff       	call   166e <putc>
    1873:	83 c4 10             	add    $0x10,%esp
        ap++;
    1876:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    187a:	eb 42                	jmp    18be <printf+0x174>
      } else if(c == '%'){
    187c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1880:	75 17                	jne    1899 <printf+0x14f>
        putc(fd, c);
    1882:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1885:	0f be c0             	movsbl %al,%eax
    1888:	83 ec 08             	sub    $0x8,%esp
    188b:	50                   	push   %eax
    188c:	ff 75 08             	pushl  0x8(%ebp)
    188f:	e8 da fd ff ff       	call   166e <putc>
    1894:	83 c4 10             	add    $0x10,%esp
    1897:	eb 25                	jmp    18be <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1899:	83 ec 08             	sub    $0x8,%esp
    189c:	6a 25                	push   $0x25
    189e:	ff 75 08             	pushl  0x8(%ebp)
    18a1:	e8 c8 fd ff ff       	call   166e <putc>
    18a6:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    18a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18ac:	0f be c0             	movsbl %al,%eax
    18af:	83 ec 08             	sub    $0x8,%esp
    18b2:	50                   	push   %eax
    18b3:	ff 75 08             	pushl  0x8(%ebp)
    18b6:	e8 b3 fd ff ff       	call   166e <putc>
    18bb:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    18be:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    18c5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    18c9:	8b 55 0c             	mov    0xc(%ebp),%edx
    18cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18cf:	01 d0                	add    %edx,%eax
    18d1:	0f b6 00             	movzbl (%eax),%eax
    18d4:	84 c0                	test   %al,%al
    18d6:	0f 85 94 fe ff ff    	jne    1770 <printf+0x26>
    }
  }
}
    18dc:	90                   	nop
    18dd:	90                   	nop
    18de:	c9                   	leave  
    18df:	c3                   	ret    

000018e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18e0:	f3 0f 1e fb          	endbr32 
    18e4:	55                   	push   %ebp
    18e5:	89 e5                	mov    %esp,%ebp
    18e7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    18ea:	8b 45 08             	mov    0x8(%ebp),%eax
    18ed:	83 e8 08             	sub    $0x8,%eax
    18f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18f3:	a1 48 1e 00 00       	mov    0x1e48,%eax
    18f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    18fb:	eb 24                	jmp    1921 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1900:	8b 00                	mov    (%eax),%eax
    1902:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1905:	72 12                	jb     1919 <free+0x39>
    1907:	8b 45 f8             	mov    -0x8(%ebp),%eax
    190a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    190d:	77 24                	ja     1933 <free+0x53>
    190f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1912:	8b 00                	mov    (%eax),%eax
    1914:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1917:	72 1a                	jb     1933 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1919:	8b 45 fc             	mov    -0x4(%ebp),%eax
    191c:	8b 00                	mov    (%eax),%eax
    191e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1921:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1924:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1927:	76 d4                	jbe    18fd <free+0x1d>
    1929:	8b 45 fc             	mov    -0x4(%ebp),%eax
    192c:	8b 00                	mov    (%eax),%eax
    192e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1931:	73 ca                	jae    18fd <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1933:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1936:	8b 40 04             	mov    0x4(%eax),%eax
    1939:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1940:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1943:	01 c2                	add    %eax,%edx
    1945:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1948:	8b 00                	mov    (%eax),%eax
    194a:	39 c2                	cmp    %eax,%edx
    194c:	75 24                	jne    1972 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    194e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1951:	8b 50 04             	mov    0x4(%eax),%edx
    1954:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1957:	8b 00                	mov    (%eax),%eax
    1959:	8b 40 04             	mov    0x4(%eax),%eax
    195c:	01 c2                	add    %eax,%edx
    195e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1961:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1964:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1967:	8b 00                	mov    (%eax),%eax
    1969:	8b 10                	mov    (%eax),%edx
    196b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    196e:	89 10                	mov    %edx,(%eax)
    1970:	eb 0a                	jmp    197c <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    1972:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1975:	8b 10                	mov    (%eax),%edx
    1977:	8b 45 f8             	mov    -0x8(%ebp),%eax
    197a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    197c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    197f:	8b 40 04             	mov    0x4(%eax),%eax
    1982:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1989:	8b 45 fc             	mov    -0x4(%ebp),%eax
    198c:	01 d0                	add    %edx,%eax
    198e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1991:	75 20                	jne    19b3 <free+0xd3>
    p->s.size += bp->s.size;
    1993:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1996:	8b 50 04             	mov    0x4(%eax),%edx
    1999:	8b 45 f8             	mov    -0x8(%ebp),%eax
    199c:	8b 40 04             	mov    0x4(%eax),%eax
    199f:	01 c2                	add    %eax,%edx
    19a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19a4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    19a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19aa:	8b 10                	mov    (%eax),%edx
    19ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19af:	89 10                	mov    %edx,(%eax)
    19b1:	eb 08                	jmp    19bb <free+0xdb>
  } else
    p->s.ptr = bp;
    19b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19b6:	8b 55 f8             	mov    -0x8(%ebp),%edx
    19b9:	89 10                	mov    %edx,(%eax)
  freep = p;
    19bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19be:	a3 48 1e 00 00       	mov    %eax,0x1e48
}
    19c3:	90                   	nop
    19c4:	c9                   	leave  
    19c5:	c3                   	ret    

000019c6 <morecore>:

static Header*
morecore(uint nu)
{
    19c6:	f3 0f 1e fb          	endbr32 
    19ca:	55                   	push   %ebp
    19cb:	89 e5                	mov    %esp,%ebp
    19cd:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    19d0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    19d7:	77 07                	ja     19e0 <morecore+0x1a>
    nu = 4096;
    19d9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    19e0:	8b 45 08             	mov    0x8(%ebp),%eax
    19e3:	c1 e0 03             	shl    $0x3,%eax
    19e6:	83 ec 0c             	sub    $0xc,%esp
    19e9:	50                   	push   %eax
    19ea:	e8 57 fc ff ff       	call   1646 <sbrk>
    19ef:	83 c4 10             	add    $0x10,%esp
    19f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    19f5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    19f9:	75 07                	jne    1a02 <morecore+0x3c>
    return 0;
    19fb:	b8 00 00 00 00       	mov    $0x0,%eax
    1a00:	eb 26                	jmp    1a28 <morecore+0x62>
  hp = (Header*)p;
    1a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a05:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1a08:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a0b:	8b 55 08             	mov    0x8(%ebp),%edx
    1a0e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1a11:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a14:	83 c0 08             	add    $0x8,%eax
    1a17:	83 ec 0c             	sub    $0xc,%esp
    1a1a:	50                   	push   %eax
    1a1b:	e8 c0 fe ff ff       	call   18e0 <free>
    1a20:	83 c4 10             	add    $0x10,%esp
  return freep;
    1a23:	a1 48 1e 00 00       	mov    0x1e48,%eax
}
    1a28:	c9                   	leave  
    1a29:	c3                   	ret    

00001a2a <malloc>:

void*
malloc(uint nbytes)
{
    1a2a:	f3 0f 1e fb          	endbr32 
    1a2e:	55                   	push   %ebp
    1a2f:	89 e5                	mov    %esp,%ebp
    1a31:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1a34:	8b 45 08             	mov    0x8(%ebp),%eax
    1a37:	83 c0 07             	add    $0x7,%eax
    1a3a:	c1 e8 03             	shr    $0x3,%eax
    1a3d:	83 c0 01             	add    $0x1,%eax
    1a40:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1a43:	a1 48 1e 00 00       	mov    0x1e48,%eax
    1a48:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a4b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a4f:	75 23                	jne    1a74 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1a51:	c7 45 f0 40 1e 00 00 	movl   $0x1e40,-0x10(%ebp)
    1a58:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a5b:	a3 48 1e 00 00       	mov    %eax,0x1e48
    1a60:	a1 48 1e 00 00       	mov    0x1e48,%eax
    1a65:	a3 40 1e 00 00       	mov    %eax,0x1e40
    base.s.size = 0;
    1a6a:	c7 05 44 1e 00 00 00 	movl   $0x0,0x1e44
    1a71:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a74:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a77:	8b 00                	mov    (%eax),%eax
    1a79:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1a7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a7f:	8b 40 04             	mov    0x4(%eax),%eax
    1a82:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1a85:	77 4d                	ja     1ad4 <malloc+0xaa>
      if(p->s.size == nunits)
    1a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a8a:	8b 40 04             	mov    0x4(%eax),%eax
    1a8d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1a90:	75 0c                	jne    1a9e <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    1a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a95:	8b 10                	mov    (%eax),%edx
    1a97:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a9a:	89 10                	mov    %edx,(%eax)
    1a9c:	eb 26                	jmp    1ac4 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    1a9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aa1:	8b 40 04             	mov    0x4(%eax),%eax
    1aa4:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1aa7:	89 c2                	mov    %eax,%edx
    1aa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aac:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1aaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ab2:	8b 40 04             	mov    0x4(%eax),%eax
    1ab5:	c1 e0 03             	shl    $0x3,%eax
    1ab8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1abb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1abe:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1ac1:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1ac4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ac7:	a3 48 1e 00 00       	mov    %eax,0x1e48
      return (void*)(p + 1);
    1acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1acf:	83 c0 08             	add    $0x8,%eax
    1ad2:	eb 3b                	jmp    1b0f <malloc+0xe5>
    }
    if(p == freep)
    1ad4:	a1 48 1e 00 00       	mov    0x1e48,%eax
    1ad9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1adc:	75 1e                	jne    1afc <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1ade:	83 ec 0c             	sub    $0xc,%esp
    1ae1:	ff 75 ec             	pushl  -0x14(%ebp)
    1ae4:	e8 dd fe ff ff       	call   19c6 <morecore>
    1ae9:	83 c4 10             	add    $0x10,%esp
    1aec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1aef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1af3:	75 07                	jne    1afc <malloc+0xd2>
        return 0;
    1af5:	b8 00 00 00 00       	mov    $0x0,%eax
    1afa:	eb 13                	jmp    1b0f <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1afc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b05:	8b 00                	mov    (%eax),%eax
    1b07:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1b0a:	e9 6d ff ff ff       	jmp    1a7c <malloc+0x52>
  }
}
    1b0f:	c9                   	leave  
    1b10:	c3                   	ret    
