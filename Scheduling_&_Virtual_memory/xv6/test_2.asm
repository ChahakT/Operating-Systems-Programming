
_test_2:     file format elf32-i386


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
    1012:	81 ec 14 04 00 00    	sub    $0x414,%esp
   struct pstat st;
   int pid = getpid();
    1018:	e8 a8 03 00 00       	call   13c5 <getpid>
    101d:	89 45 ec             	mov    %eax,-0x14(%ebp)
   int defaulttickets = 0;
    1020:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
   
   if(getpinfo(&st) == 0)
    1027:	83 ec 0c             	sub    $0xc,%esp
    102a:	8d 85 ec fb ff ff    	lea    -0x414(%ebp),%eax
    1030:	50                   	push   %eax
    1031:	e8 b7 03 00 00       	call   13ed <getpinfo>
    1036:	83 c4 10             	add    $0x10,%esp
    1039:	85 c0                	test   %eax,%eax
    103b:	75 45                	jne    1082 <main+0x82>
   {
    for(int i = 0; i < NPROC; i++) {
    103d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1044:	eb 34                	jmp    107a <main+0x7a>
      if (st.inuse[i]) {
    1046:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1049:	8b 84 85 ec fb ff ff 	mov    -0x414(%ebp,%eax,4),%eax
    1050:	85 c0                	test   %eax,%eax
    1052:	74 22                	je     1076 <main+0x76>
        if(st.pid[i] == pid) {
    1054:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1057:	83 e8 80             	sub    $0xffffff80,%eax
    105a:	8b 84 85 ec fb ff ff 	mov    -0x414(%ebp,%eax,4),%eax
    1061:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1064:	75 10                	jne    1076 <main+0x76>
          defaulttickets = st.tickets[i];
    1066:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1069:	83 c0 40             	add    $0x40,%eax
    106c:	8b 84 85 ec fb ff ff 	mov    -0x414(%ebp,%eax,4),%eax
    1073:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for(int i = 0; i < NPROC; i++) {
    1076:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    107a:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    107e:	7e c6                	jle    1046 <main+0x46>
    1080:	eb 17                	jmp    1099 <main+0x99>
      }
   }
   }
  else
  {
   printf(1, "XV6_SCHEDULER\t FAILED\n");
    1082:	83 ec 08             	sub    $0x8,%esp
    1085:	68 98 18 00 00       	push   $0x1898
    108a:	6a 01                	push   $0x1
    108c:	e8 40 04 00 00       	call   14d1 <printf>
    1091:	83 c4 10             	add    $0x10,%esp
   exit();
    1094:	e8 ac 02 00 00       	call   1345 <exit>
  }

  
  if(defaulttickets == 1)
    1099:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
    109d:	75 14                	jne    10b3 <main+0xb3>
  {
   printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    109f:	83 ec 08             	sub    $0x8,%esp
    10a2:	68 af 18 00 00       	push   $0x18af
    10a7:	6a 01                	push   $0x1
    10a9:	e8 23 04 00 00       	call   14d1 <printf>
    10ae:	83 c4 10             	add    $0x10,%esp
    10b1:	eb 12                	jmp    10c5 <main+0xc5>
  }
  else
  {
   printf(1, "XV6_SCHEDULER\t FAILED\n");
    10b3:	83 ec 08             	sub    $0x8,%esp
    10b6:	68 98 18 00 00       	push   $0x1898
    10bb:	6a 01                	push   $0x1
    10bd:	e8 0f 04 00 00       	call   14d1 <printf>
    10c2:	83 c4 10             	add    $0x10,%esp
  }
   exit();
    10c5:	e8 7b 02 00 00       	call   1345 <exit>

000010ca <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    10ca:	55                   	push   %ebp
    10cb:	89 e5                	mov    %esp,%ebp
    10cd:	57                   	push   %edi
    10ce:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    10cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10d2:	8b 55 10             	mov    0x10(%ebp),%edx
    10d5:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d8:	89 cb                	mov    %ecx,%ebx
    10da:	89 df                	mov    %ebx,%edi
    10dc:	89 d1                	mov    %edx,%ecx
    10de:	fc                   	cld    
    10df:	f3 aa                	rep stos %al,%es:(%edi)
    10e1:	89 ca                	mov    %ecx,%edx
    10e3:	89 fb                	mov    %edi,%ebx
    10e5:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10e8:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10eb:	90                   	nop
    10ec:	5b                   	pop    %ebx
    10ed:	5f                   	pop    %edi
    10ee:	5d                   	pop    %ebp
    10ef:	c3                   	ret    

000010f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    10f0:	f3 0f 1e fb          	endbr32 
    10f4:	55                   	push   %ebp
    10f5:	89 e5                	mov    %esp,%ebp
    10f7:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10fa:	8b 45 08             	mov    0x8(%ebp),%eax
    10fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1100:	90                   	nop
    1101:	8b 55 0c             	mov    0xc(%ebp),%edx
    1104:	8d 42 01             	lea    0x1(%edx),%eax
    1107:	89 45 0c             	mov    %eax,0xc(%ebp)
    110a:	8b 45 08             	mov    0x8(%ebp),%eax
    110d:	8d 48 01             	lea    0x1(%eax),%ecx
    1110:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1113:	0f b6 12             	movzbl (%edx),%edx
    1116:	88 10                	mov    %dl,(%eax)
    1118:	0f b6 00             	movzbl (%eax),%eax
    111b:	84 c0                	test   %al,%al
    111d:	75 e2                	jne    1101 <strcpy+0x11>
    ;
  return os;
    111f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1122:	c9                   	leave  
    1123:	c3                   	ret    

00001124 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1124:	f3 0f 1e fb          	endbr32 
    1128:	55                   	push   %ebp
    1129:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    112b:	eb 08                	jmp    1135 <strcmp+0x11>
    p++, q++;
    112d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1131:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    1135:	8b 45 08             	mov    0x8(%ebp),%eax
    1138:	0f b6 00             	movzbl (%eax),%eax
    113b:	84 c0                	test   %al,%al
    113d:	74 10                	je     114f <strcmp+0x2b>
    113f:	8b 45 08             	mov    0x8(%ebp),%eax
    1142:	0f b6 10             	movzbl (%eax),%edx
    1145:	8b 45 0c             	mov    0xc(%ebp),%eax
    1148:	0f b6 00             	movzbl (%eax),%eax
    114b:	38 c2                	cmp    %al,%dl
    114d:	74 de                	je     112d <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    114f:	8b 45 08             	mov    0x8(%ebp),%eax
    1152:	0f b6 00             	movzbl (%eax),%eax
    1155:	0f b6 d0             	movzbl %al,%edx
    1158:	8b 45 0c             	mov    0xc(%ebp),%eax
    115b:	0f b6 00             	movzbl (%eax),%eax
    115e:	0f b6 c0             	movzbl %al,%eax
    1161:	29 c2                	sub    %eax,%edx
    1163:	89 d0                	mov    %edx,%eax
}
    1165:	5d                   	pop    %ebp
    1166:	c3                   	ret    

00001167 <strlen>:

uint
strlen(const char *s)
{
    1167:	f3 0f 1e fb          	endbr32 
    116b:	55                   	push   %ebp
    116c:	89 e5                	mov    %esp,%ebp
    116e:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1171:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1178:	eb 04                	jmp    117e <strlen+0x17>
    117a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    117e:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1181:	8b 45 08             	mov    0x8(%ebp),%eax
    1184:	01 d0                	add    %edx,%eax
    1186:	0f b6 00             	movzbl (%eax),%eax
    1189:	84 c0                	test   %al,%al
    118b:	75 ed                	jne    117a <strlen+0x13>
    ;
  return n;
    118d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1190:	c9                   	leave  
    1191:	c3                   	ret    

00001192 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1192:	f3 0f 1e fb          	endbr32 
    1196:	55                   	push   %ebp
    1197:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1199:	8b 45 10             	mov    0x10(%ebp),%eax
    119c:	50                   	push   %eax
    119d:	ff 75 0c             	pushl  0xc(%ebp)
    11a0:	ff 75 08             	pushl  0x8(%ebp)
    11a3:	e8 22 ff ff ff       	call   10ca <stosb>
    11a8:	83 c4 0c             	add    $0xc,%esp
  return dst;
    11ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11ae:	c9                   	leave  
    11af:	c3                   	ret    

000011b0 <strchr>:

char*
strchr(const char *s, char c)
{
    11b0:	f3 0f 1e fb          	endbr32 
    11b4:	55                   	push   %ebp
    11b5:	89 e5                	mov    %esp,%ebp
    11b7:	83 ec 04             	sub    $0x4,%esp
    11ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    11bd:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    11c0:	eb 14                	jmp    11d6 <strchr+0x26>
    if(*s == c)
    11c2:	8b 45 08             	mov    0x8(%ebp),%eax
    11c5:	0f b6 00             	movzbl (%eax),%eax
    11c8:	38 45 fc             	cmp    %al,-0x4(%ebp)
    11cb:	75 05                	jne    11d2 <strchr+0x22>
      return (char*)s;
    11cd:	8b 45 08             	mov    0x8(%ebp),%eax
    11d0:	eb 13                	jmp    11e5 <strchr+0x35>
  for(; *s; s++)
    11d2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11d6:	8b 45 08             	mov    0x8(%ebp),%eax
    11d9:	0f b6 00             	movzbl (%eax),%eax
    11dc:	84 c0                	test   %al,%al
    11de:	75 e2                	jne    11c2 <strchr+0x12>
  return 0;
    11e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11e5:	c9                   	leave  
    11e6:	c3                   	ret    

000011e7 <gets>:

char*
gets(char *buf, int max)
{
    11e7:	f3 0f 1e fb          	endbr32 
    11eb:	55                   	push   %ebp
    11ec:	89 e5                	mov    %esp,%ebp
    11ee:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11f8:	eb 42                	jmp    123c <gets+0x55>
    cc = read(0, &c, 1);
    11fa:	83 ec 04             	sub    $0x4,%esp
    11fd:	6a 01                	push   $0x1
    11ff:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1202:	50                   	push   %eax
    1203:	6a 00                	push   $0x0
    1205:	e8 53 01 00 00       	call   135d <read>
    120a:	83 c4 10             	add    $0x10,%esp
    120d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1210:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1214:	7e 33                	jle    1249 <gets+0x62>
      break;
    buf[i++] = c;
    1216:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1219:	8d 50 01             	lea    0x1(%eax),%edx
    121c:	89 55 f4             	mov    %edx,-0xc(%ebp)
    121f:	89 c2                	mov    %eax,%edx
    1221:	8b 45 08             	mov    0x8(%ebp),%eax
    1224:	01 c2                	add    %eax,%edx
    1226:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    122a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    122c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1230:	3c 0a                	cmp    $0xa,%al
    1232:	74 16                	je     124a <gets+0x63>
    1234:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1238:	3c 0d                	cmp    $0xd,%al
    123a:	74 0e                	je     124a <gets+0x63>
  for(i=0; i+1 < max; ){
    123c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    123f:	83 c0 01             	add    $0x1,%eax
    1242:	39 45 0c             	cmp    %eax,0xc(%ebp)
    1245:	7f b3                	jg     11fa <gets+0x13>
    1247:	eb 01                	jmp    124a <gets+0x63>
      break;
    1249:	90                   	nop
      break;
  }
  buf[i] = '\0';
    124a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	01 d0                	add    %edx,%eax
    1252:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1255:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1258:	c9                   	leave  
    1259:	c3                   	ret    

0000125a <stat>:

int
stat(const char *n, struct stat *st)
{
    125a:	f3 0f 1e fb          	endbr32 
    125e:	55                   	push   %ebp
    125f:	89 e5                	mov    %esp,%ebp
    1261:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1264:	83 ec 08             	sub    $0x8,%esp
    1267:	6a 00                	push   $0x0
    1269:	ff 75 08             	pushl  0x8(%ebp)
    126c:	e8 14 01 00 00       	call   1385 <open>
    1271:	83 c4 10             	add    $0x10,%esp
    1274:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1277:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    127b:	79 07                	jns    1284 <stat+0x2a>
    return -1;
    127d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1282:	eb 25                	jmp    12a9 <stat+0x4f>
  r = fstat(fd, st);
    1284:	83 ec 08             	sub    $0x8,%esp
    1287:	ff 75 0c             	pushl  0xc(%ebp)
    128a:	ff 75 f4             	pushl  -0xc(%ebp)
    128d:	e8 0b 01 00 00       	call   139d <fstat>
    1292:	83 c4 10             	add    $0x10,%esp
    1295:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1298:	83 ec 0c             	sub    $0xc,%esp
    129b:	ff 75 f4             	pushl  -0xc(%ebp)
    129e:	e8 ca 00 00 00       	call   136d <close>
    12a3:	83 c4 10             	add    $0x10,%esp
  return r;
    12a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    12a9:	c9                   	leave  
    12aa:	c3                   	ret    

000012ab <atoi>:

int
atoi(const char *s)
{
    12ab:	f3 0f 1e fb          	endbr32 
    12af:	55                   	push   %ebp
    12b0:	89 e5                	mov    %esp,%ebp
    12b2:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    12b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12bc:	eb 25                	jmp    12e3 <atoi+0x38>
    n = n*10 + *s++ - '0';
    12be:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12c1:	89 d0                	mov    %edx,%eax
    12c3:	c1 e0 02             	shl    $0x2,%eax
    12c6:	01 d0                	add    %edx,%eax
    12c8:	01 c0                	add    %eax,%eax
    12ca:	89 c1                	mov    %eax,%ecx
    12cc:	8b 45 08             	mov    0x8(%ebp),%eax
    12cf:	8d 50 01             	lea    0x1(%eax),%edx
    12d2:	89 55 08             	mov    %edx,0x8(%ebp)
    12d5:	0f b6 00             	movzbl (%eax),%eax
    12d8:	0f be c0             	movsbl %al,%eax
    12db:	01 c8                	add    %ecx,%eax
    12dd:	83 e8 30             	sub    $0x30,%eax
    12e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12e3:	8b 45 08             	mov    0x8(%ebp),%eax
    12e6:	0f b6 00             	movzbl (%eax),%eax
    12e9:	3c 2f                	cmp    $0x2f,%al
    12eb:	7e 0a                	jle    12f7 <atoi+0x4c>
    12ed:	8b 45 08             	mov    0x8(%ebp),%eax
    12f0:	0f b6 00             	movzbl (%eax),%eax
    12f3:	3c 39                	cmp    $0x39,%al
    12f5:	7e c7                	jle    12be <atoi+0x13>
  return n;
    12f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12fa:	c9                   	leave  
    12fb:	c3                   	ret    

000012fc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12fc:	f3 0f 1e fb          	endbr32 
    1300:	55                   	push   %ebp
    1301:	89 e5                	mov    %esp,%ebp
    1303:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    1306:	8b 45 08             	mov    0x8(%ebp),%eax
    1309:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    130c:	8b 45 0c             	mov    0xc(%ebp),%eax
    130f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1312:	eb 17                	jmp    132b <memmove+0x2f>
    *dst++ = *src++;
    1314:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1317:	8d 42 01             	lea    0x1(%edx),%eax
    131a:	89 45 f8             	mov    %eax,-0x8(%ebp)
    131d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1320:	8d 48 01             	lea    0x1(%eax),%ecx
    1323:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    1326:	0f b6 12             	movzbl (%edx),%edx
    1329:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    132b:	8b 45 10             	mov    0x10(%ebp),%eax
    132e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1331:	89 55 10             	mov    %edx,0x10(%ebp)
    1334:	85 c0                	test   %eax,%eax
    1336:	7f dc                	jg     1314 <memmove+0x18>
  return vdst;
    1338:	8b 45 08             	mov    0x8(%ebp),%eax
}
    133b:	c9                   	leave  
    133c:	c3                   	ret    

0000133d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    133d:	b8 01 00 00 00       	mov    $0x1,%eax
    1342:	cd 40                	int    $0x40
    1344:	c3                   	ret    

00001345 <exit>:
SYSCALL(exit)
    1345:	b8 02 00 00 00       	mov    $0x2,%eax
    134a:	cd 40                	int    $0x40
    134c:	c3                   	ret    

0000134d <wait>:
SYSCALL(wait)
    134d:	b8 03 00 00 00       	mov    $0x3,%eax
    1352:	cd 40                	int    $0x40
    1354:	c3                   	ret    

00001355 <pipe>:
SYSCALL(pipe)
    1355:	b8 04 00 00 00       	mov    $0x4,%eax
    135a:	cd 40                	int    $0x40
    135c:	c3                   	ret    

0000135d <read>:
SYSCALL(read)
    135d:	b8 05 00 00 00       	mov    $0x5,%eax
    1362:	cd 40                	int    $0x40
    1364:	c3                   	ret    

00001365 <write>:
SYSCALL(write)
    1365:	b8 10 00 00 00       	mov    $0x10,%eax
    136a:	cd 40                	int    $0x40
    136c:	c3                   	ret    

0000136d <close>:
SYSCALL(close)
    136d:	b8 15 00 00 00       	mov    $0x15,%eax
    1372:	cd 40                	int    $0x40
    1374:	c3                   	ret    

00001375 <kill>:
SYSCALL(kill)
    1375:	b8 06 00 00 00       	mov    $0x6,%eax
    137a:	cd 40                	int    $0x40
    137c:	c3                   	ret    

0000137d <exec>:
SYSCALL(exec)
    137d:	b8 07 00 00 00       	mov    $0x7,%eax
    1382:	cd 40                	int    $0x40
    1384:	c3                   	ret    

00001385 <open>:
SYSCALL(open)
    1385:	b8 0f 00 00 00       	mov    $0xf,%eax
    138a:	cd 40                	int    $0x40
    138c:	c3                   	ret    

0000138d <mknod>:
SYSCALL(mknod)
    138d:	b8 11 00 00 00       	mov    $0x11,%eax
    1392:	cd 40                	int    $0x40
    1394:	c3                   	ret    

00001395 <unlink>:
SYSCALL(unlink)
    1395:	b8 12 00 00 00       	mov    $0x12,%eax
    139a:	cd 40                	int    $0x40
    139c:	c3                   	ret    

0000139d <fstat>:
SYSCALL(fstat)
    139d:	b8 08 00 00 00       	mov    $0x8,%eax
    13a2:	cd 40                	int    $0x40
    13a4:	c3                   	ret    

000013a5 <link>:
SYSCALL(link)
    13a5:	b8 13 00 00 00       	mov    $0x13,%eax
    13aa:	cd 40                	int    $0x40
    13ac:	c3                   	ret    

000013ad <mkdir>:
SYSCALL(mkdir)
    13ad:	b8 14 00 00 00       	mov    $0x14,%eax
    13b2:	cd 40                	int    $0x40
    13b4:	c3                   	ret    

000013b5 <chdir>:
SYSCALL(chdir)
    13b5:	b8 09 00 00 00       	mov    $0x9,%eax
    13ba:	cd 40                	int    $0x40
    13bc:	c3                   	ret    

000013bd <dup>:
SYSCALL(dup)
    13bd:	b8 0a 00 00 00       	mov    $0xa,%eax
    13c2:	cd 40                	int    $0x40
    13c4:	c3                   	ret    

000013c5 <getpid>:
SYSCALL(getpid)
    13c5:	b8 0b 00 00 00       	mov    $0xb,%eax
    13ca:	cd 40                	int    $0x40
    13cc:	c3                   	ret    

000013cd <sbrk>:
SYSCALL(sbrk)
    13cd:	b8 0c 00 00 00       	mov    $0xc,%eax
    13d2:	cd 40                	int    $0x40
    13d4:	c3                   	ret    

000013d5 <sleep>:
SYSCALL(sleep)
    13d5:	b8 0d 00 00 00       	mov    $0xd,%eax
    13da:	cd 40                	int    $0x40
    13dc:	c3                   	ret    

000013dd <uptime>:
SYSCALL(uptime)
    13dd:	b8 0e 00 00 00       	mov    $0xe,%eax
    13e2:	cd 40                	int    $0x40
    13e4:	c3                   	ret    

000013e5 <settickets>:
SYSCALL(settickets)
    13e5:	b8 16 00 00 00       	mov    $0x16,%eax
    13ea:	cd 40                	int    $0x40
    13ec:	c3                   	ret    

000013ed <getpinfo>:
SYSCALL(getpinfo)
    13ed:	b8 17 00 00 00       	mov    $0x17,%eax
    13f2:	cd 40                	int    $0x40
    13f4:	c3                   	ret    

000013f5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13f5:	f3 0f 1e fb          	endbr32 
    13f9:	55                   	push   %ebp
    13fa:	89 e5                	mov    %esp,%ebp
    13fc:	83 ec 18             	sub    $0x18,%esp
    13ff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1402:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1405:	83 ec 04             	sub    $0x4,%esp
    1408:	6a 01                	push   $0x1
    140a:	8d 45 f4             	lea    -0xc(%ebp),%eax
    140d:	50                   	push   %eax
    140e:	ff 75 08             	pushl  0x8(%ebp)
    1411:	e8 4f ff ff ff       	call   1365 <write>
    1416:	83 c4 10             	add    $0x10,%esp
}
    1419:	90                   	nop
    141a:	c9                   	leave  
    141b:	c3                   	ret    

0000141c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    141c:	f3 0f 1e fb          	endbr32 
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1426:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    142d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1431:	74 17                	je     144a <printint+0x2e>
    1433:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1437:	79 11                	jns    144a <printint+0x2e>
    neg = 1;
    1439:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1440:	8b 45 0c             	mov    0xc(%ebp),%eax
    1443:	f7 d8                	neg    %eax
    1445:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1448:	eb 06                	jmp    1450 <printint+0x34>
  } else {
    x = xx;
    144a:	8b 45 0c             	mov    0xc(%ebp),%eax
    144d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1450:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1457:	8b 4d 10             	mov    0x10(%ebp),%ecx
    145a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    145d:	ba 00 00 00 00       	mov    $0x0,%edx
    1462:	f7 f1                	div    %ecx
    1464:	89 d1                	mov    %edx,%ecx
    1466:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1469:	8d 50 01             	lea    0x1(%eax),%edx
    146c:	89 55 f4             	mov    %edx,-0xc(%ebp)
    146f:	0f b6 91 14 1b 00 00 	movzbl 0x1b14(%ecx),%edx
    1476:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    147a:	8b 4d 10             	mov    0x10(%ebp),%ecx
    147d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1480:	ba 00 00 00 00       	mov    $0x0,%edx
    1485:	f7 f1                	div    %ecx
    1487:	89 45 ec             	mov    %eax,-0x14(%ebp)
    148a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    148e:	75 c7                	jne    1457 <printint+0x3b>
  if(neg)
    1490:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1494:	74 2d                	je     14c3 <printint+0xa7>
    buf[i++] = '-';
    1496:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1499:	8d 50 01             	lea    0x1(%eax),%edx
    149c:	89 55 f4             	mov    %edx,-0xc(%ebp)
    149f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    14a4:	eb 1d                	jmp    14c3 <printint+0xa7>
    putc(fd, buf[i]);
    14a6:	8d 55 dc             	lea    -0x24(%ebp),%edx
    14a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ac:	01 d0                	add    %edx,%eax
    14ae:	0f b6 00             	movzbl (%eax),%eax
    14b1:	0f be c0             	movsbl %al,%eax
    14b4:	83 ec 08             	sub    $0x8,%esp
    14b7:	50                   	push   %eax
    14b8:	ff 75 08             	pushl  0x8(%ebp)
    14bb:	e8 35 ff ff ff       	call   13f5 <putc>
    14c0:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    14c3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    14c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14cb:	79 d9                	jns    14a6 <printint+0x8a>
}
    14cd:	90                   	nop
    14ce:	90                   	nop
    14cf:	c9                   	leave  
    14d0:	c3                   	ret    

000014d1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    14d1:	f3 0f 1e fb          	endbr32 
    14d5:	55                   	push   %ebp
    14d6:	89 e5                	mov    %esp,%ebp
    14d8:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    14db:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    14e2:	8d 45 0c             	lea    0xc(%ebp),%eax
    14e5:	83 c0 04             	add    $0x4,%eax
    14e8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    14eb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14f2:	e9 59 01 00 00       	jmp    1650 <printf+0x17f>
    c = fmt[i] & 0xff;
    14f7:	8b 55 0c             	mov    0xc(%ebp),%edx
    14fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14fd:	01 d0                	add    %edx,%eax
    14ff:	0f b6 00             	movzbl (%eax),%eax
    1502:	0f be c0             	movsbl %al,%eax
    1505:	25 ff 00 00 00       	and    $0xff,%eax
    150a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    150d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1511:	75 2c                	jne    153f <printf+0x6e>
      if(c == '%'){
    1513:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1517:	75 0c                	jne    1525 <printf+0x54>
        state = '%';
    1519:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1520:	e9 27 01 00 00       	jmp    164c <printf+0x17b>
      } else {
        putc(fd, c);
    1525:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1528:	0f be c0             	movsbl %al,%eax
    152b:	83 ec 08             	sub    $0x8,%esp
    152e:	50                   	push   %eax
    152f:	ff 75 08             	pushl  0x8(%ebp)
    1532:	e8 be fe ff ff       	call   13f5 <putc>
    1537:	83 c4 10             	add    $0x10,%esp
    153a:	e9 0d 01 00 00       	jmp    164c <printf+0x17b>
      }
    } else if(state == '%'){
    153f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1543:	0f 85 03 01 00 00    	jne    164c <printf+0x17b>
      if(c == 'd'){
    1549:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    154d:	75 1e                	jne    156d <printf+0x9c>
        printint(fd, *ap, 10, 1);
    154f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1552:	8b 00                	mov    (%eax),%eax
    1554:	6a 01                	push   $0x1
    1556:	6a 0a                	push   $0xa
    1558:	50                   	push   %eax
    1559:	ff 75 08             	pushl  0x8(%ebp)
    155c:	e8 bb fe ff ff       	call   141c <printint>
    1561:	83 c4 10             	add    $0x10,%esp
        ap++;
    1564:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1568:	e9 d8 00 00 00       	jmp    1645 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    156d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1571:	74 06                	je     1579 <printf+0xa8>
    1573:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1577:	75 1e                	jne    1597 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1579:	8b 45 e8             	mov    -0x18(%ebp),%eax
    157c:	8b 00                	mov    (%eax),%eax
    157e:	6a 00                	push   $0x0
    1580:	6a 10                	push   $0x10
    1582:	50                   	push   %eax
    1583:	ff 75 08             	pushl  0x8(%ebp)
    1586:	e8 91 fe ff ff       	call   141c <printint>
    158b:	83 c4 10             	add    $0x10,%esp
        ap++;
    158e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1592:	e9 ae 00 00 00       	jmp    1645 <printf+0x174>
      } else if(c == 's'){
    1597:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    159b:	75 43                	jne    15e0 <printf+0x10f>
        s = (char*)*ap;
    159d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15a0:	8b 00                	mov    (%eax),%eax
    15a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    15a5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    15a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15ad:	75 25                	jne    15d4 <printf+0x103>
          s = "(null)";
    15af:	c7 45 f4 c7 18 00 00 	movl   $0x18c7,-0xc(%ebp)
        while(*s != 0){
    15b6:	eb 1c                	jmp    15d4 <printf+0x103>
          putc(fd, *s);
    15b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bb:	0f b6 00             	movzbl (%eax),%eax
    15be:	0f be c0             	movsbl %al,%eax
    15c1:	83 ec 08             	sub    $0x8,%esp
    15c4:	50                   	push   %eax
    15c5:	ff 75 08             	pushl  0x8(%ebp)
    15c8:	e8 28 fe ff ff       	call   13f5 <putc>
    15cd:	83 c4 10             	add    $0x10,%esp
          s++;
    15d0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    15d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d7:	0f b6 00             	movzbl (%eax),%eax
    15da:	84 c0                	test   %al,%al
    15dc:	75 da                	jne    15b8 <printf+0xe7>
    15de:	eb 65                	jmp    1645 <printf+0x174>
        }
      } else if(c == 'c'){
    15e0:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    15e4:	75 1d                	jne    1603 <printf+0x132>
        putc(fd, *ap);
    15e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15e9:	8b 00                	mov    (%eax),%eax
    15eb:	0f be c0             	movsbl %al,%eax
    15ee:	83 ec 08             	sub    $0x8,%esp
    15f1:	50                   	push   %eax
    15f2:	ff 75 08             	pushl  0x8(%ebp)
    15f5:	e8 fb fd ff ff       	call   13f5 <putc>
    15fa:	83 c4 10             	add    $0x10,%esp
        ap++;
    15fd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1601:	eb 42                	jmp    1645 <printf+0x174>
      } else if(c == '%'){
    1603:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1607:	75 17                	jne    1620 <printf+0x14f>
        putc(fd, c);
    1609:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    160c:	0f be c0             	movsbl %al,%eax
    160f:	83 ec 08             	sub    $0x8,%esp
    1612:	50                   	push   %eax
    1613:	ff 75 08             	pushl  0x8(%ebp)
    1616:	e8 da fd ff ff       	call   13f5 <putc>
    161b:	83 c4 10             	add    $0x10,%esp
    161e:	eb 25                	jmp    1645 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1620:	83 ec 08             	sub    $0x8,%esp
    1623:	6a 25                	push   $0x25
    1625:	ff 75 08             	pushl  0x8(%ebp)
    1628:	e8 c8 fd ff ff       	call   13f5 <putc>
    162d:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1630:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1633:	0f be c0             	movsbl %al,%eax
    1636:	83 ec 08             	sub    $0x8,%esp
    1639:	50                   	push   %eax
    163a:	ff 75 08             	pushl  0x8(%ebp)
    163d:	e8 b3 fd ff ff       	call   13f5 <putc>
    1642:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1645:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    164c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1650:	8b 55 0c             	mov    0xc(%ebp),%edx
    1653:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1656:	01 d0                	add    %edx,%eax
    1658:	0f b6 00             	movzbl (%eax),%eax
    165b:	84 c0                	test   %al,%al
    165d:	0f 85 94 fe ff ff    	jne    14f7 <printf+0x26>
    }
  }
}
    1663:	90                   	nop
    1664:	90                   	nop
    1665:	c9                   	leave  
    1666:	c3                   	ret    

00001667 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1667:	f3 0f 1e fb          	endbr32 
    166b:	55                   	push   %ebp
    166c:	89 e5                	mov    %esp,%ebp
    166e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1671:	8b 45 08             	mov    0x8(%ebp),%eax
    1674:	83 e8 08             	sub    $0x8,%eax
    1677:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    167a:	a1 30 1b 00 00       	mov    0x1b30,%eax
    167f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1682:	eb 24                	jmp    16a8 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1684:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1687:	8b 00                	mov    (%eax),%eax
    1689:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    168c:	72 12                	jb     16a0 <free+0x39>
    168e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1691:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1694:	77 24                	ja     16ba <free+0x53>
    1696:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1699:	8b 00                	mov    (%eax),%eax
    169b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    169e:	72 1a                	jb     16ba <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a3:	8b 00                	mov    (%eax),%eax
    16a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16ae:	76 d4                	jbe    1684 <free+0x1d>
    16b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b3:	8b 00                	mov    (%eax),%eax
    16b5:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    16b8:	73 ca                	jae    1684 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16bd:	8b 40 04             	mov    0x4(%eax),%eax
    16c0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ca:	01 c2                	add    %eax,%edx
    16cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cf:	8b 00                	mov    (%eax),%eax
    16d1:	39 c2                	cmp    %eax,%edx
    16d3:	75 24                	jne    16f9 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    16d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16d8:	8b 50 04             	mov    0x4(%eax),%edx
    16db:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16de:	8b 00                	mov    (%eax),%eax
    16e0:	8b 40 04             	mov    0x4(%eax),%eax
    16e3:	01 c2                	add    %eax,%edx
    16e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e8:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    16eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ee:	8b 00                	mov    (%eax),%eax
    16f0:	8b 10                	mov    (%eax),%edx
    16f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16f5:	89 10                	mov    %edx,(%eax)
    16f7:	eb 0a                	jmp    1703 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    16f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16fc:	8b 10                	mov    (%eax),%edx
    16fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1701:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1703:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1706:	8b 40 04             	mov    0x4(%eax),%eax
    1709:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1710:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1713:	01 d0                	add    %edx,%eax
    1715:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1718:	75 20                	jne    173a <free+0xd3>
    p->s.size += bp->s.size;
    171a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171d:	8b 50 04             	mov    0x4(%eax),%edx
    1720:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1723:	8b 40 04             	mov    0x4(%eax),%eax
    1726:	01 c2                	add    %eax,%edx
    1728:	8b 45 fc             	mov    -0x4(%ebp),%eax
    172b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    172e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1731:	8b 10                	mov    (%eax),%edx
    1733:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1736:	89 10                	mov    %edx,(%eax)
    1738:	eb 08                	jmp    1742 <free+0xdb>
  } else
    p->s.ptr = bp;
    173a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    173d:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1740:	89 10                	mov    %edx,(%eax)
  freep = p;
    1742:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1745:	a3 30 1b 00 00       	mov    %eax,0x1b30
}
    174a:	90                   	nop
    174b:	c9                   	leave  
    174c:	c3                   	ret    

0000174d <morecore>:

static Header*
morecore(uint nu)
{
    174d:	f3 0f 1e fb          	endbr32 
    1751:	55                   	push   %ebp
    1752:	89 e5                	mov    %esp,%ebp
    1754:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1757:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    175e:	77 07                	ja     1767 <morecore+0x1a>
    nu = 4096;
    1760:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1767:	8b 45 08             	mov    0x8(%ebp),%eax
    176a:	c1 e0 03             	shl    $0x3,%eax
    176d:	83 ec 0c             	sub    $0xc,%esp
    1770:	50                   	push   %eax
    1771:	e8 57 fc ff ff       	call   13cd <sbrk>
    1776:	83 c4 10             	add    $0x10,%esp
    1779:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    177c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1780:	75 07                	jne    1789 <morecore+0x3c>
    return 0;
    1782:	b8 00 00 00 00       	mov    $0x0,%eax
    1787:	eb 26                	jmp    17af <morecore+0x62>
  hp = (Header*)p;
    1789:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    178f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1792:	8b 55 08             	mov    0x8(%ebp),%edx
    1795:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1798:	8b 45 f0             	mov    -0x10(%ebp),%eax
    179b:	83 c0 08             	add    $0x8,%eax
    179e:	83 ec 0c             	sub    $0xc,%esp
    17a1:	50                   	push   %eax
    17a2:	e8 c0 fe ff ff       	call   1667 <free>
    17a7:	83 c4 10             	add    $0x10,%esp
  return freep;
    17aa:	a1 30 1b 00 00       	mov    0x1b30,%eax
}
    17af:	c9                   	leave  
    17b0:	c3                   	ret    

000017b1 <malloc>:

void*
malloc(uint nbytes)
{
    17b1:	f3 0f 1e fb          	endbr32 
    17b5:	55                   	push   %ebp
    17b6:	89 e5                	mov    %esp,%ebp
    17b8:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17bb:	8b 45 08             	mov    0x8(%ebp),%eax
    17be:	83 c0 07             	add    $0x7,%eax
    17c1:	c1 e8 03             	shr    $0x3,%eax
    17c4:	83 c0 01             	add    $0x1,%eax
    17c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    17ca:	a1 30 1b 00 00       	mov    0x1b30,%eax
    17cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17d6:	75 23                	jne    17fb <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    17d8:	c7 45 f0 28 1b 00 00 	movl   $0x1b28,-0x10(%ebp)
    17df:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17e2:	a3 30 1b 00 00       	mov    %eax,0x1b30
    17e7:	a1 30 1b 00 00       	mov    0x1b30,%eax
    17ec:	a3 28 1b 00 00       	mov    %eax,0x1b28
    base.s.size = 0;
    17f1:	c7 05 2c 1b 00 00 00 	movl   $0x0,0x1b2c
    17f8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17fe:	8b 00                	mov    (%eax),%eax
    1800:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1803:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1806:	8b 40 04             	mov    0x4(%eax),%eax
    1809:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    180c:	77 4d                	ja     185b <malloc+0xaa>
      if(p->s.size == nunits)
    180e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1811:	8b 40 04             	mov    0x4(%eax),%eax
    1814:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1817:	75 0c                	jne    1825 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    1819:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181c:	8b 10                	mov    (%eax),%edx
    181e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1821:	89 10                	mov    %edx,(%eax)
    1823:	eb 26                	jmp    184b <malloc+0x9a>
      else {
        p->s.size -= nunits;
    1825:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1828:	8b 40 04             	mov    0x4(%eax),%eax
    182b:	2b 45 ec             	sub    -0x14(%ebp),%eax
    182e:	89 c2                	mov    %eax,%edx
    1830:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1833:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1836:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1839:	8b 40 04             	mov    0x4(%eax),%eax
    183c:	c1 e0 03             	shl    $0x3,%eax
    183f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1842:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1845:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1848:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    184b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    184e:	a3 30 1b 00 00       	mov    %eax,0x1b30
      return (void*)(p + 1);
    1853:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1856:	83 c0 08             	add    $0x8,%eax
    1859:	eb 3b                	jmp    1896 <malloc+0xe5>
    }
    if(p == freep)
    185b:	a1 30 1b 00 00       	mov    0x1b30,%eax
    1860:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1863:	75 1e                	jne    1883 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1865:	83 ec 0c             	sub    $0xc,%esp
    1868:	ff 75 ec             	pushl  -0x14(%ebp)
    186b:	e8 dd fe ff ff       	call   174d <morecore>
    1870:	83 c4 10             	add    $0x10,%esp
    1873:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1876:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    187a:	75 07                	jne    1883 <malloc+0xd2>
        return 0;
    187c:	b8 00 00 00 00       	mov    $0x0,%eax
    1881:	eb 13                	jmp    1896 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1883:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1886:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1889:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188c:	8b 00                	mov    (%eax),%eax
    188e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1891:	e9 6d ff ff ff       	jmp    1803 <malloc+0x52>
  }
}
    1896:	c9                   	leave  
    1897:	c3                   	ret    
