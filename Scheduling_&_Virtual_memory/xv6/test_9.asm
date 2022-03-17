
_test_9:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"
#include "pstat.h"

int
main(int argc, char *argv[]){
    1000:	f3 0f 1e fb          	endbr32 
    1004:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1008:	83 e4 f0             	and    $0xfffffff0,%esp
    100b:	ff 71 fc             	pushl  -0x4(%ecx)
    100e:	55                   	push   %ebp
    100f:	89 e5                	mov    %esp,%ebp
    1011:	51                   	push   %ecx
    1012:	81 ec 24 04 00 00    	sub    $0x424,%esp
	int pid_par = getpid();
    1018:	e8 2e 04 00 00       	call   144b <getpid>
    101d:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int tickets = 10;
    1020:	c7 45 e4 0a 00 00 00 	movl   $0xa,-0x1c(%ebp)
	
	if(settickets(tickets) == 0)
    1027:	83 ec 0c             	sub    $0xc,%esp
    102a:	ff 75 e4             	pushl  -0x1c(%ebp)
    102d:	e8 39 04 00 00       	call   146b <settickets>
    1032:	83 c4 10             	add    $0x10,%esp
    1035:	85 c0                	test   %eax,%eax
    1037:	74 17                	je     1050 <main+0x50>
	{
	}
	else
	{
	 printf(1, "XV6_SCHEDULER\t FAILED\n");
    1039:	83 ec 08             	sub    $0x8,%esp
    103c:	68 1e 19 00 00       	push   $0x191e
    1041:	6a 01                	push   $0x1
    1043:	e8 0f 05 00 00       	call   1557 <printf>
    1048:	83 c4 10             	add    $0x10,%esp
	 exit();
    104b:	e8 7b 03 00 00       	call   13cb <exit>
	}
	
	if(fork() == 0){
    1050:	e8 6e 03 00 00       	call   13c3 <fork>
    1055:	85 c0                	test   %eax,%eax
    1057:	0f 85 e4 00 00 00    	jne    1141 <main+0x141>
		int pid_chd = getpid();
    105d:	e8 e9 03 00 00       	call   144b <getpid>
    1062:	89 45 e0             	mov    %eax,-0x20(%ebp)
		struct pstat st;
		if(getpinfo(&st) == 0)
    1065:	83 ec 0c             	sub    $0xc,%esp
    1068:	8d 85 e0 fb ff ff    	lea    -0x420(%ebp),%eax
    106e:	50                   	push   %eax
    106f:	e8 ff 03 00 00       	call   1473 <getpinfo>
    1074:	83 c4 10             	add    $0x10,%esp
    1077:	85 c0                	test   %eax,%eax
    1079:	74 17                	je     1092 <main+0x92>
		{
		}
		else
		{
		 printf(1, "XV6_SCHEDULER\t FAILED\n");
    107b:	83 ec 08             	sub    $0x8,%esp
    107e:	68 1e 19 00 00       	push   $0x191e
    1083:	6a 01                	push   $0x1
    1085:	e8 cd 04 00 00       	call   1557 <printf>
    108a:	83 c4 10             	add    $0x10,%esp
		 exit();
    108d:	e8 39 03 00 00       	call   13cb <exit>
		}
		int tickets_par = -1,tickets_chd = -1;
    1092:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    1099:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
		for(int i = 0; i < NPROC; i++){
    10a0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    10a7:	eb 4a                	jmp    10f3 <main+0xf3>
      			if (st.pid[i] == pid_par){
    10a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10ac:	83 e8 80             	sub    $0xffffff80,%eax
    10af:	8b 84 85 e0 fb ff ff 	mov    -0x420(%ebp,%eax,4),%eax
    10b6:	39 45 e8             	cmp    %eax,-0x18(%ebp)
    10b9:	75 12                	jne    10cd <main+0xcd>
				tickets_par = st.tickets[i];
    10bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10be:	83 c0 40             	add    $0x40,%eax
    10c1:	8b 84 85 e0 fb ff ff 	mov    -0x420(%ebp,%eax,4),%eax
    10c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    10cb:	eb 22                	jmp    10ef <main+0xef>
			}
			else if (st.pid[i] == pid_chd){
    10cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10d0:	83 e8 80             	sub    $0xffffff80,%eax
    10d3:	8b 84 85 e0 fb ff ff 	mov    -0x420(%ebp,%eax,4),%eax
    10da:	39 45 e0             	cmp    %eax,-0x20(%ebp)
    10dd:	75 10                	jne    10ef <main+0xef>
				tickets_chd = st.tickets[i];
    10df:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10e2:	83 c0 40             	add    $0x40,%eax
    10e5:	8b 84 85 e0 fb ff ff 	mov    -0x420(%ebp,%eax,4),%eax
    10ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
		for(int i = 0; i < NPROC; i++){
    10ef:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    10f3:	83 7d ec 3f          	cmpl   $0x3f,-0x14(%ebp)
    10f7:	7e b0                	jle    10a9 <main+0xa9>
			}
		}

		printf(1, "parent: %d, child: %d\n", tickets_par, tickets_chd);
    10f9:	ff 75 f0             	pushl  -0x10(%ebp)
    10fc:	ff 75 f4             	pushl  -0xc(%ebp)
    10ff:	68 35 19 00 00       	push   $0x1935
    1104:	6a 01                	push   $0x1
    1106:	e8 4c 04 00 00       	call   1557 <printf>
    110b:	83 c4 10             	add    $0x10,%esp

		if(tickets_chd == tickets)
    110e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1111:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1114:	75 14                	jne    112a <main+0x12a>
		{
		 printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    1116:	83 ec 08             	sub    $0x8,%esp
    1119:	68 4c 19 00 00       	push   $0x194c
    111e:	6a 01                	push   $0x1
    1120:	e8 32 04 00 00       	call   1557 <printf>
    1125:	83 c4 10             	add    $0x10,%esp
    1128:	eb 12                	jmp    113c <main+0x13c>
		}
		else
		{
		 printf(1, "XV6_SCHEDULER\t FAILED\n");
    112a:	83 ec 08             	sub    $0x8,%esp
    112d:	68 1e 19 00 00       	push   $0x191e
    1132:	6a 01                	push   $0x1
    1134:	e8 1e 04 00 00       	call   1557 <printf>
    1139:	83 c4 10             	add    $0x10,%esp
		}

    exit();
    113c:	e8 8a 02 00 00       	call   13cb <exit>
	}
  	while(wait() > 0);
    1141:	90                   	nop
    1142:	e8 8c 02 00 00       	call   13d3 <wait>
    1147:	85 c0                	test   %eax,%eax
    1149:	7f f7                	jg     1142 <main+0x142>
	exit();
    114b:	e8 7b 02 00 00       	call   13cb <exit>

00001150 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	57                   	push   %edi
    1154:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1155:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1158:	8b 55 10             	mov    0x10(%ebp),%edx
    115b:	8b 45 0c             	mov    0xc(%ebp),%eax
    115e:	89 cb                	mov    %ecx,%ebx
    1160:	89 df                	mov    %ebx,%edi
    1162:	89 d1                	mov    %edx,%ecx
    1164:	fc                   	cld    
    1165:	f3 aa                	rep stos %al,%es:(%edi)
    1167:	89 ca                	mov    %ecx,%edx
    1169:	89 fb                	mov    %edi,%ebx
    116b:	89 5d 08             	mov    %ebx,0x8(%ebp)
    116e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1171:	90                   	nop
    1172:	5b                   	pop    %ebx
    1173:	5f                   	pop    %edi
    1174:	5d                   	pop    %ebp
    1175:	c3                   	ret    

00001176 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1176:	f3 0f 1e fb          	endbr32 
    117a:	55                   	push   %ebp
    117b:	89 e5                	mov    %esp,%ebp
    117d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1180:	8b 45 08             	mov    0x8(%ebp),%eax
    1183:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1186:	90                   	nop
    1187:	8b 55 0c             	mov    0xc(%ebp),%edx
    118a:	8d 42 01             	lea    0x1(%edx),%eax
    118d:	89 45 0c             	mov    %eax,0xc(%ebp)
    1190:	8b 45 08             	mov    0x8(%ebp),%eax
    1193:	8d 48 01             	lea    0x1(%eax),%ecx
    1196:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1199:	0f b6 12             	movzbl (%edx),%edx
    119c:	88 10                	mov    %dl,(%eax)
    119e:	0f b6 00             	movzbl (%eax),%eax
    11a1:	84 c0                	test   %al,%al
    11a3:	75 e2                	jne    1187 <strcpy+0x11>
    ;
  return os;
    11a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    11a8:	c9                   	leave  
    11a9:	c3                   	ret    

000011aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11aa:	f3 0f 1e fb          	endbr32 
    11ae:	55                   	push   %ebp
    11af:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    11b1:	eb 08                	jmp    11bb <strcmp+0x11>
    p++, q++;
    11b3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11b7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    11bb:	8b 45 08             	mov    0x8(%ebp),%eax
    11be:	0f b6 00             	movzbl (%eax),%eax
    11c1:	84 c0                	test   %al,%al
    11c3:	74 10                	je     11d5 <strcmp+0x2b>
    11c5:	8b 45 08             	mov    0x8(%ebp),%eax
    11c8:	0f b6 10             	movzbl (%eax),%edx
    11cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ce:	0f b6 00             	movzbl (%eax),%eax
    11d1:	38 c2                	cmp    %al,%dl
    11d3:	74 de                	je     11b3 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    11d5:	8b 45 08             	mov    0x8(%ebp),%eax
    11d8:	0f b6 00             	movzbl (%eax),%eax
    11db:	0f b6 d0             	movzbl %al,%edx
    11de:	8b 45 0c             	mov    0xc(%ebp),%eax
    11e1:	0f b6 00             	movzbl (%eax),%eax
    11e4:	0f b6 c0             	movzbl %al,%eax
    11e7:	29 c2                	sub    %eax,%edx
    11e9:	89 d0                	mov    %edx,%eax
}
    11eb:	5d                   	pop    %ebp
    11ec:	c3                   	ret    

000011ed <strlen>:

uint
strlen(const char *s)
{
    11ed:	f3 0f 1e fb          	endbr32 
    11f1:	55                   	push   %ebp
    11f2:	89 e5                	mov    %esp,%ebp
    11f4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    11f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    11fe:	eb 04                	jmp    1204 <strlen+0x17>
    1200:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1204:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1207:	8b 45 08             	mov    0x8(%ebp),%eax
    120a:	01 d0                	add    %edx,%eax
    120c:	0f b6 00             	movzbl (%eax),%eax
    120f:	84 c0                	test   %al,%al
    1211:	75 ed                	jne    1200 <strlen+0x13>
    ;
  return n;
    1213:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1216:	c9                   	leave  
    1217:	c3                   	ret    

00001218 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1218:	f3 0f 1e fb          	endbr32 
    121c:	55                   	push   %ebp
    121d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    121f:	8b 45 10             	mov    0x10(%ebp),%eax
    1222:	50                   	push   %eax
    1223:	ff 75 0c             	pushl  0xc(%ebp)
    1226:	ff 75 08             	pushl  0x8(%ebp)
    1229:	e8 22 ff ff ff       	call   1150 <stosb>
    122e:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1231:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1234:	c9                   	leave  
    1235:	c3                   	ret    

00001236 <strchr>:

char*
strchr(const char *s, char c)
{
    1236:	f3 0f 1e fb          	endbr32 
    123a:	55                   	push   %ebp
    123b:	89 e5                	mov    %esp,%ebp
    123d:	83 ec 04             	sub    $0x4,%esp
    1240:	8b 45 0c             	mov    0xc(%ebp),%eax
    1243:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1246:	eb 14                	jmp    125c <strchr+0x26>
    if(*s == c)
    1248:	8b 45 08             	mov    0x8(%ebp),%eax
    124b:	0f b6 00             	movzbl (%eax),%eax
    124e:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1251:	75 05                	jne    1258 <strchr+0x22>
      return (char*)s;
    1253:	8b 45 08             	mov    0x8(%ebp),%eax
    1256:	eb 13                	jmp    126b <strchr+0x35>
  for(; *s; s++)
    1258:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    125c:	8b 45 08             	mov    0x8(%ebp),%eax
    125f:	0f b6 00             	movzbl (%eax),%eax
    1262:	84 c0                	test   %al,%al
    1264:	75 e2                	jne    1248 <strchr+0x12>
  return 0;
    1266:	b8 00 00 00 00       	mov    $0x0,%eax
}
    126b:	c9                   	leave  
    126c:	c3                   	ret    

0000126d <gets>:

char*
gets(char *buf, int max)
{
    126d:	f3 0f 1e fb          	endbr32 
    1271:	55                   	push   %ebp
    1272:	89 e5                	mov    %esp,%ebp
    1274:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1277:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    127e:	eb 42                	jmp    12c2 <gets+0x55>
    cc = read(0, &c, 1);
    1280:	83 ec 04             	sub    $0x4,%esp
    1283:	6a 01                	push   $0x1
    1285:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1288:	50                   	push   %eax
    1289:	6a 00                	push   $0x0
    128b:	e8 53 01 00 00       	call   13e3 <read>
    1290:	83 c4 10             	add    $0x10,%esp
    1293:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1296:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    129a:	7e 33                	jle    12cf <gets+0x62>
      break;
    buf[i++] = c;
    129c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    129f:	8d 50 01             	lea    0x1(%eax),%edx
    12a2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    12a5:	89 c2                	mov    %eax,%edx
    12a7:	8b 45 08             	mov    0x8(%ebp),%eax
    12aa:	01 c2                	add    %eax,%edx
    12ac:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12b0:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    12b2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12b6:	3c 0a                	cmp    $0xa,%al
    12b8:	74 16                	je     12d0 <gets+0x63>
    12ba:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12be:	3c 0d                	cmp    $0xd,%al
    12c0:	74 0e                	je     12d0 <gets+0x63>
  for(i=0; i+1 < max; ){
    12c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12c5:	83 c0 01             	add    $0x1,%eax
    12c8:	39 45 0c             	cmp    %eax,0xc(%ebp)
    12cb:	7f b3                	jg     1280 <gets+0x13>
    12cd:	eb 01                	jmp    12d0 <gets+0x63>
      break;
    12cf:	90                   	nop
      break;
  }
  buf[i] = '\0';
    12d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12d3:	8b 45 08             	mov    0x8(%ebp),%eax
    12d6:	01 d0                	add    %edx,%eax
    12d8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    12db:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12de:	c9                   	leave  
    12df:	c3                   	ret    

000012e0 <stat>:

int
stat(const char *n, struct stat *st)
{
    12e0:	f3 0f 1e fb          	endbr32 
    12e4:	55                   	push   %ebp
    12e5:	89 e5                	mov    %esp,%ebp
    12e7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12ea:	83 ec 08             	sub    $0x8,%esp
    12ed:	6a 00                	push   $0x0
    12ef:	ff 75 08             	pushl  0x8(%ebp)
    12f2:	e8 14 01 00 00       	call   140b <open>
    12f7:	83 c4 10             	add    $0x10,%esp
    12fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    12fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1301:	79 07                	jns    130a <stat+0x2a>
    return -1;
    1303:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1308:	eb 25                	jmp    132f <stat+0x4f>
  r = fstat(fd, st);
    130a:	83 ec 08             	sub    $0x8,%esp
    130d:	ff 75 0c             	pushl  0xc(%ebp)
    1310:	ff 75 f4             	pushl  -0xc(%ebp)
    1313:	e8 0b 01 00 00       	call   1423 <fstat>
    1318:	83 c4 10             	add    $0x10,%esp
    131b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    131e:	83 ec 0c             	sub    $0xc,%esp
    1321:	ff 75 f4             	pushl  -0xc(%ebp)
    1324:	e8 ca 00 00 00       	call   13f3 <close>
    1329:	83 c4 10             	add    $0x10,%esp
  return r;
    132c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    132f:	c9                   	leave  
    1330:	c3                   	ret    

00001331 <atoi>:

int
atoi(const char *s)
{
    1331:	f3 0f 1e fb          	endbr32 
    1335:	55                   	push   %ebp
    1336:	89 e5                	mov    %esp,%ebp
    1338:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    133b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1342:	eb 25                	jmp    1369 <atoi+0x38>
    n = n*10 + *s++ - '0';
    1344:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1347:	89 d0                	mov    %edx,%eax
    1349:	c1 e0 02             	shl    $0x2,%eax
    134c:	01 d0                	add    %edx,%eax
    134e:	01 c0                	add    %eax,%eax
    1350:	89 c1                	mov    %eax,%ecx
    1352:	8b 45 08             	mov    0x8(%ebp),%eax
    1355:	8d 50 01             	lea    0x1(%eax),%edx
    1358:	89 55 08             	mov    %edx,0x8(%ebp)
    135b:	0f b6 00             	movzbl (%eax),%eax
    135e:	0f be c0             	movsbl %al,%eax
    1361:	01 c8                	add    %ecx,%eax
    1363:	83 e8 30             	sub    $0x30,%eax
    1366:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1369:	8b 45 08             	mov    0x8(%ebp),%eax
    136c:	0f b6 00             	movzbl (%eax),%eax
    136f:	3c 2f                	cmp    $0x2f,%al
    1371:	7e 0a                	jle    137d <atoi+0x4c>
    1373:	8b 45 08             	mov    0x8(%ebp),%eax
    1376:	0f b6 00             	movzbl (%eax),%eax
    1379:	3c 39                	cmp    $0x39,%al
    137b:	7e c7                	jle    1344 <atoi+0x13>
  return n;
    137d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1380:	c9                   	leave  
    1381:	c3                   	ret    

00001382 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1382:	f3 0f 1e fb          	endbr32 
    1386:	55                   	push   %ebp
    1387:	89 e5                	mov    %esp,%ebp
    1389:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    138c:	8b 45 08             	mov    0x8(%ebp),%eax
    138f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1392:	8b 45 0c             	mov    0xc(%ebp),%eax
    1395:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1398:	eb 17                	jmp    13b1 <memmove+0x2f>
    *dst++ = *src++;
    139a:	8b 55 f8             	mov    -0x8(%ebp),%edx
    139d:	8d 42 01             	lea    0x1(%edx),%eax
    13a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    13a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13a6:	8d 48 01             	lea    0x1(%eax),%ecx
    13a9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    13ac:	0f b6 12             	movzbl (%edx),%edx
    13af:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    13b1:	8b 45 10             	mov    0x10(%ebp),%eax
    13b4:	8d 50 ff             	lea    -0x1(%eax),%edx
    13b7:	89 55 10             	mov    %edx,0x10(%ebp)
    13ba:	85 c0                	test   %eax,%eax
    13bc:	7f dc                	jg     139a <memmove+0x18>
  return vdst;
    13be:	8b 45 08             	mov    0x8(%ebp),%eax
}
    13c1:	c9                   	leave  
    13c2:	c3                   	ret    

000013c3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13c3:	b8 01 00 00 00       	mov    $0x1,%eax
    13c8:	cd 40                	int    $0x40
    13ca:	c3                   	ret    

000013cb <exit>:
SYSCALL(exit)
    13cb:	b8 02 00 00 00       	mov    $0x2,%eax
    13d0:	cd 40                	int    $0x40
    13d2:	c3                   	ret    

000013d3 <wait>:
SYSCALL(wait)
    13d3:	b8 03 00 00 00       	mov    $0x3,%eax
    13d8:	cd 40                	int    $0x40
    13da:	c3                   	ret    

000013db <pipe>:
SYSCALL(pipe)
    13db:	b8 04 00 00 00       	mov    $0x4,%eax
    13e0:	cd 40                	int    $0x40
    13e2:	c3                   	ret    

000013e3 <read>:
SYSCALL(read)
    13e3:	b8 05 00 00 00       	mov    $0x5,%eax
    13e8:	cd 40                	int    $0x40
    13ea:	c3                   	ret    

000013eb <write>:
SYSCALL(write)
    13eb:	b8 10 00 00 00       	mov    $0x10,%eax
    13f0:	cd 40                	int    $0x40
    13f2:	c3                   	ret    

000013f3 <close>:
SYSCALL(close)
    13f3:	b8 15 00 00 00       	mov    $0x15,%eax
    13f8:	cd 40                	int    $0x40
    13fa:	c3                   	ret    

000013fb <kill>:
SYSCALL(kill)
    13fb:	b8 06 00 00 00       	mov    $0x6,%eax
    1400:	cd 40                	int    $0x40
    1402:	c3                   	ret    

00001403 <exec>:
SYSCALL(exec)
    1403:	b8 07 00 00 00       	mov    $0x7,%eax
    1408:	cd 40                	int    $0x40
    140a:	c3                   	ret    

0000140b <open>:
SYSCALL(open)
    140b:	b8 0f 00 00 00       	mov    $0xf,%eax
    1410:	cd 40                	int    $0x40
    1412:	c3                   	ret    

00001413 <mknod>:
SYSCALL(mknod)
    1413:	b8 11 00 00 00       	mov    $0x11,%eax
    1418:	cd 40                	int    $0x40
    141a:	c3                   	ret    

0000141b <unlink>:
SYSCALL(unlink)
    141b:	b8 12 00 00 00       	mov    $0x12,%eax
    1420:	cd 40                	int    $0x40
    1422:	c3                   	ret    

00001423 <fstat>:
SYSCALL(fstat)
    1423:	b8 08 00 00 00       	mov    $0x8,%eax
    1428:	cd 40                	int    $0x40
    142a:	c3                   	ret    

0000142b <link>:
SYSCALL(link)
    142b:	b8 13 00 00 00       	mov    $0x13,%eax
    1430:	cd 40                	int    $0x40
    1432:	c3                   	ret    

00001433 <mkdir>:
SYSCALL(mkdir)
    1433:	b8 14 00 00 00       	mov    $0x14,%eax
    1438:	cd 40                	int    $0x40
    143a:	c3                   	ret    

0000143b <chdir>:
SYSCALL(chdir)
    143b:	b8 09 00 00 00       	mov    $0x9,%eax
    1440:	cd 40                	int    $0x40
    1442:	c3                   	ret    

00001443 <dup>:
SYSCALL(dup)
    1443:	b8 0a 00 00 00       	mov    $0xa,%eax
    1448:	cd 40                	int    $0x40
    144a:	c3                   	ret    

0000144b <getpid>:
SYSCALL(getpid)
    144b:	b8 0b 00 00 00       	mov    $0xb,%eax
    1450:	cd 40                	int    $0x40
    1452:	c3                   	ret    

00001453 <sbrk>:
SYSCALL(sbrk)
    1453:	b8 0c 00 00 00       	mov    $0xc,%eax
    1458:	cd 40                	int    $0x40
    145a:	c3                   	ret    

0000145b <sleep>:
SYSCALL(sleep)
    145b:	b8 0d 00 00 00       	mov    $0xd,%eax
    1460:	cd 40                	int    $0x40
    1462:	c3                   	ret    

00001463 <uptime>:
SYSCALL(uptime)
    1463:	b8 0e 00 00 00       	mov    $0xe,%eax
    1468:	cd 40                	int    $0x40
    146a:	c3                   	ret    

0000146b <settickets>:
SYSCALL(settickets)
    146b:	b8 16 00 00 00       	mov    $0x16,%eax
    1470:	cd 40                	int    $0x40
    1472:	c3                   	ret    

00001473 <getpinfo>:
SYSCALL(getpinfo)
    1473:	b8 17 00 00 00       	mov    $0x17,%eax
    1478:	cd 40                	int    $0x40
    147a:	c3                   	ret    

0000147b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    147b:	f3 0f 1e fb          	endbr32 
    147f:	55                   	push   %ebp
    1480:	89 e5                	mov    %esp,%ebp
    1482:	83 ec 18             	sub    $0x18,%esp
    1485:	8b 45 0c             	mov    0xc(%ebp),%eax
    1488:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    148b:	83 ec 04             	sub    $0x4,%esp
    148e:	6a 01                	push   $0x1
    1490:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1493:	50                   	push   %eax
    1494:	ff 75 08             	pushl  0x8(%ebp)
    1497:	e8 4f ff ff ff       	call   13eb <write>
    149c:	83 c4 10             	add    $0x10,%esp
}
    149f:	90                   	nop
    14a0:	c9                   	leave  
    14a1:	c3                   	ret    

000014a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    14a2:	f3 0f 1e fb          	endbr32 
    14a6:	55                   	push   %ebp
    14a7:	89 e5                	mov    %esp,%ebp
    14a9:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    14ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    14b3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    14b7:	74 17                	je     14d0 <printint+0x2e>
    14b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14bd:	79 11                	jns    14d0 <printint+0x2e>
    neg = 1;
    14bf:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    14c6:	8b 45 0c             	mov    0xc(%ebp),%eax
    14c9:	f7 d8                	neg    %eax
    14cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14ce:	eb 06                	jmp    14d6 <printint+0x34>
  } else {
    x = xx;
    14d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    14d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    14d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    14dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
    14e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14e3:	ba 00 00 00 00       	mov    $0x0,%edx
    14e8:	f7 f1                	div    %ecx
    14ea:	89 d1                	mov    %edx,%ecx
    14ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ef:	8d 50 01             	lea    0x1(%eax),%edx
    14f2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14f5:	0f b6 91 b0 1b 00 00 	movzbl 0x1bb0(%ecx),%edx
    14fc:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1500:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1503:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1506:	ba 00 00 00 00       	mov    $0x0,%edx
    150b:	f7 f1                	div    %ecx
    150d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1510:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1514:	75 c7                	jne    14dd <printint+0x3b>
  if(neg)
    1516:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    151a:	74 2d                	je     1549 <printint+0xa7>
    buf[i++] = '-';
    151c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151f:	8d 50 01             	lea    0x1(%eax),%edx
    1522:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1525:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    152a:	eb 1d                	jmp    1549 <printint+0xa7>
    putc(fd, buf[i]);
    152c:	8d 55 dc             	lea    -0x24(%ebp),%edx
    152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1532:	01 d0                	add    %edx,%eax
    1534:	0f b6 00             	movzbl (%eax),%eax
    1537:	0f be c0             	movsbl %al,%eax
    153a:	83 ec 08             	sub    $0x8,%esp
    153d:	50                   	push   %eax
    153e:	ff 75 08             	pushl  0x8(%ebp)
    1541:	e8 35 ff ff ff       	call   147b <putc>
    1546:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    1549:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    154d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1551:	79 d9                	jns    152c <printint+0x8a>
}
    1553:	90                   	nop
    1554:	90                   	nop
    1555:	c9                   	leave  
    1556:	c3                   	ret    

00001557 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1557:	f3 0f 1e fb          	endbr32 
    155b:	55                   	push   %ebp
    155c:	89 e5                	mov    %esp,%ebp
    155e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1561:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1568:	8d 45 0c             	lea    0xc(%ebp),%eax
    156b:	83 c0 04             	add    $0x4,%eax
    156e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1571:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1578:	e9 59 01 00 00       	jmp    16d6 <printf+0x17f>
    c = fmt[i] & 0xff;
    157d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1580:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1583:	01 d0                	add    %edx,%eax
    1585:	0f b6 00             	movzbl (%eax),%eax
    1588:	0f be c0             	movsbl %al,%eax
    158b:	25 ff 00 00 00       	and    $0xff,%eax
    1590:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1593:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1597:	75 2c                	jne    15c5 <printf+0x6e>
      if(c == '%'){
    1599:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    159d:	75 0c                	jne    15ab <printf+0x54>
        state = '%';
    159f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    15a6:	e9 27 01 00 00       	jmp    16d2 <printf+0x17b>
      } else {
        putc(fd, c);
    15ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ae:	0f be c0             	movsbl %al,%eax
    15b1:	83 ec 08             	sub    $0x8,%esp
    15b4:	50                   	push   %eax
    15b5:	ff 75 08             	pushl  0x8(%ebp)
    15b8:	e8 be fe ff ff       	call   147b <putc>
    15bd:	83 c4 10             	add    $0x10,%esp
    15c0:	e9 0d 01 00 00       	jmp    16d2 <printf+0x17b>
      }
    } else if(state == '%'){
    15c5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    15c9:	0f 85 03 01 00 00    	jne    16d2 <printf+0x17b>
      if(c == 'd'){
    15cf:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    15d3:	75 1e                	jne    15f3 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    15d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15d8:	8b 00                	mov    (%eax),%eax
    15da:	6a 01                	push   $0x1
    15dc:	6a 0a                	push   $0xa
    15de:	50                   	push   %eax
    15df:	ff 75 08             	pushl  0x8(%ebp)
    15e2:	e8 bb fe ff ff       	call   14a2 <printint>
    15e7:	83 c4 10             	add    $0x10,%esp
        ap++;
    15ea:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    15ee:	e9 d8 00 00 00       	jmp    16cb <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    15f3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    15f7:	74 06                	je     15ff <printf+0xa8>
    15f9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    15fd:	75 1e                	jne    161d <printf+0xc6>
        printint(fd, *ap, 16, 0);
    15ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1602:	8b 00                	mov    (%eax),%eax
    1604:	6a 00                	push   $0x0
    1606:	6a 10                	push   $0x10
    1608:	50                   	push   %eax
    1609:	ff 75 08             	pushl  0x8(%ebp)
    160c:	e8 91 fe ff ff       	call   14a2 <printint>
    1611:	83 c4 10             	add    $0x10,%esp
        ap++;
    1614:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1618:	e9 ae 00 00 00       	jmp    16cb <printf+0x174>
      } else if(c == 's'){
    161d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1621:	75 43                	jne    1666 <printf+0x10f>
        s = (char*)*ap;
    1623:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1626:	8b 00                	mov    (%eax),%eax
    1628:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    162b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    162f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1633:	75 25                	jne    165a <printf+0x103>
          s = "(null)";
    1635:	c7 45 f4 64 19 00 00 	movl   $0x1964,-0xc(%ebp)
        while(*s != 0){
    163c:	eb 1c                	jmp    165a <printf+0x103>
          putc(fd, *s);
    163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1641:	0f b6 00             	movzbl (%eax),%eax
    1644:	0f be c0             	movsbl %al,%eax
    1647:	83 ec 08             	sub    $0x8,%esp
    164a:	50                   	push   %eax
    164b:	ff 75 08             	pushl  0x8(%ebp)
    164e:	e8 28 fe ff ff       	call   147b <putc>
    1653:	83 c4 10             	add    $0x10,%esp
          s++;
    1656:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    165a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165d:	0f b6 00             	movzbl (%eax),%eax
    1660:	84 c0                	test   %al,%al
    1662:	75 da                	jne    163e <printf+0xe7>
    1664:	eb 65                	jmp    16cb <printf+0x174>
        }
      } else if(c == 'c'){
    1666:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    166a:	75 1d                	jne    1689 <printf+0x132>
        putc(fd, *ap);
    166c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    166f:	8b 00                	mov    (%eax),%eax
    1671:	0f be c0             	movsbl %al,%eax
    1674:	83 ec 08             	sub    $0x8,%esp
    1677:	50                   	push   %eax
    1678:	ff 75 08             	pushl  0x8(%ebp)
    167b:	e8 fb fd ff ff       	call   147b <putc>
    1680:	83 c4 10             	add    $0x10,%esp
        ap++;
    1683:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1687:	eb 42                	jmp    16cb <printf+0x174>
      } else if(c == '%'){
    1689:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    168d:	75 17                	jne    16a6 <printf+0x14f>
        putc(fd, c);
    168f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1692:	0f be c0             	movsbl %al,%eax
    1695:	83 ec 08             	sub    $0x8,%esp
    1698:	50                   	push   %eax
    1699:	ff 75 08             	pushl  0x8(%ebp)
    169c:	e8 da fd ff ff       	call   147b <putc>
    16a1:	83 c4 10             	add    $0x10,%esp
    16a4:	eb 25                	jmp    16cb <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    16a6:	83 ec 08             	sub    $0x8,%esp
    16a9:	6a 25                	push   $0x25
    16ab:	ff 75 08             	pushl  0x8(%ebp)
    16ae:	e8 c8 fd ff ff       	call   147b <putc>
    16b3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    16b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16b9:	0f be c0             	movsbl %al,%eax
    16bc:	83 ec 08             	sub    $0x8,%esp
    16bf:	50                   	push   %eax
    16c0:	ff 75 08             	pushl  0x8(%ebp)
    16c3:	e8 b3 fd ff ff       	call   147b <putc>
    16c8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    16cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    16d2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16d6:	8b 55 0c             	mov    0xc(%ebp),%edx
    16d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16dc:	01 d0                	add    %edx,%eax
    16de:	0f b6 00             	movzbl (%eax),%eax
    16e1:	84 c0                	test   %al,%al
    16e3:	0f 85 94 fe ff ff    	jne    157d <printf+0x26>
    }
  }
}
    16e9:	90                   	nop
    16ea:	90                   	nop
    16eb:	c9                   	leave  
    16ec:	c3                   	ret    

000016ed <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16ed:	f3 0f 1e fb          	endbr32 
    16f1:	55                   	push   %ebp
    16f2:	89 e5                	mov    %esp,%ebp
    16f4:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16f7:	8b 45 08             	mov    0x8(%ebp),%eax
    16fa:	83 e8 08             	sub    $0x8,%eax
    16fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1700:	a1 cc 1b 00 00       	mov    0x1bcc,%eax
    1705:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1708:	eb 24                	jmp    172e <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    170a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    170d:	8b 00                	mov    (%eax),%eax
    170f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1712:	72 12                	jb     1726 <free+0x39>
    1714:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1717:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    171a:	77 24                	ja     1740 <free+0x53>
    171c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171f:	8b 00                	mov    (%eax),%eax
    1721:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1724:	72 1a                	jb     1740 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1726:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1729:	8b 00                	mov    (%eax),%eax
    172b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    172e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1731:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1734:	76 d4                	jbe    170a <free+0x1d>
    1736:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1739:	8b 00                	mov    (%eax),%eax
    173b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    173e:	73 ca                	jae    170a <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1740:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1743:	8b 40 04             	mov    0x4(%eax),%eax
    1746:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    174d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1750:	01 c2                	add    %eax,%edx
    1752:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1755:	8b 00                	mov    (%eax),%eax
    1757:	39 c2                	cmp    %eax,%edx
    1759:	75 24                	jne    177f <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    175b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    175e:	8b 50 04             	mov    0x4(%eax),%edx
    1761:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1764:	8b 00                	mov    (%eax),%eax
    1766:	8b 40 04             	mov    0x4(%eax),%eax
    1769:	01 c2                	add    %eax,%edx
    176b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    176e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1771:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1774:	8b 00                	mov    (%eax),%eax
    1776:	8b 10                	mov    (%eax),%edx
    1778:	8b 45 f8             	mov    -0x8(%ebp),%eax
    177b:	89 10                	mov    %edx,(%eax)
    177d:	eb 0a                	jmp    1789 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    177f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1782:	8b 10                	mov    (%eax),%edx
    1784:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1787:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1789:	8b 45 fc             	mov    -0x4(%ebp),%eax
    178c:	8b 40 04             	mov    0x4(%eax),%eax
    178f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1796:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1799:	01 d0                	add    %edx,%eax
    179b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    179e:	75 20                	jne    17c0 <free+0xd3>
    p->s.size += bp->s.size;
    17a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a3:	8b 50 04             	mov    0x4(%eax),%edx
    17a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17a9:	8b 40 04             	mov    0x4(%eax),%eax
    17ac:	01 c2                	add    %eax,%edx
    17ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    17b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b7:	8b 10                	mov    (%eax),%edx
    17b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17bc:	89 10                	mov    %edx,(%eax)
    17be:	eb 08                	jmp    17c8 <free+0xdb>
  } else
    p->s.ptr = bp;
    17c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    17c6:	89 10                	mov    %edx,(%eax)
  freep = p;
    17c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17cb:	a3 cc 1b 00 00       	mov    %eax,0x1bcc
}
    17d0:	90                   	nop
    17d1:	c9                   	leave  
    17d2:	c3                   	ret    

000017d3 <morecore>:

static Header*
morecore(uint nu)
{
    17d3:	f3 0f 1e fb          	endbr32 
    17d7:	55                   	push   %ebp
    17d8:	89 e5                	mov    %esp,%ebp
    17da:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    17dd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    17e4:	77 07                	ja     17ed <morecore+0x1a>
    nu = 4096;
    17e6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    17ed:	8b 45 08             	mov    0x8(%ebp),%eax
    17f0:	c1 e0 03             	shl    $0x3,%eax
    17f3:	83 ec 0c             	sub    $0xc,%esp
    17f6:	50                   	push   %eax
    17f7:	e8 57 fc ff ff       	call   1453 <sbrk>
    17fc:	83 c4 10             	add    $0x10,%esp
    17ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1802:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1806:	75 07                	jne    180f <morecore+0x3c>
    return 0;
    1808:	b8 00 00 00 00       	mov    $0x0,%eax
    180d:	eb 26                	jmp    1835 <morecore+0x62>
  hp = (Header*)p;
    180f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1812:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1815:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1818:	8b 55 08             	mov    0x8(%ebp),%edx
    181b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    181e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1821:	83 c0 08             	add    $0x8,%eax
    1824:	83 ec 0c             	sub    $0xc,%esp
    1827:	50                   	push   %eax
    1828:	e8 c0 fe ff ff       	call   16ed <free>
    182d:	83 c4 10             	add    $0x10,%esp
  return freep;
    1830:	a1 cc 1b 00 00       	mov    0x1bcc,%eax
}
    1835:	c9                   	leave  
    1836:	c3                   	ret    

00001837 <malloc>:

void*
malloc(uint nbytes)
{
    1837:	f3 0f 1e fb          	endbr32 
    183b:	55                   	push   %ebp
    183c:	89 e5                	mov    %esp,%ebp
    183e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1841:	8b 45 08             	mov    0x8(%ebp),%eax
    1844:	83 c0 07             	add    $0x7,%eax
    1847:	c1 e8 03             	shr    $0x3,%eax
    184a:	83 c0 01             	add    $0x1,%eax
    184d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1850:	a1 cc 1b 00 00       	mov    0x1bcc,%eax
    1855:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1858:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    185c:	75 23                	jne    1881 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    185e:	c7 45 f0 c4 1b 00 00 	movl   $0x1bc4,-0x10(%ebp)
    1865:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1868:	a3 cc 1b 00 00       	mov    %eax,0x1bcc
    186d:	a1 cc 1b 00 00       	mov    0x1bcc,%eax
    1872:	a3 c4 1b 00 00       	mov    %eax,0x1bc4
    base.s.size = 0;
    1877:	c7 05 c8 1b 00 00 00 	movl   $0x0,0x1bc8
    187e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1881:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1884:	8b 00                	mov    (%eax),%eax
    1886:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1889:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188c:	8b 40 04             	mov    0x4(%eax),%eax
    188f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1892:	77 4d                	ja     18e1 <malloc+0xaa>
      if(p->s.size == nunits)
    1894:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1897:	8b 40 04             	mov    0x4(%eax),%eax
    189a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    189d:	75 0c                	jne    18ab <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    189f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a2:	8b 10                	mov    (%eax),%edx
    18a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18a7:	89 10                	mov    %edx,(%eax)
    18a9:	eb 26                	jmp    18d1 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    18ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ae:	8b 40 04             	mov    0x4(%eax),%eax
    18b1:	2b 45 ec             	sub    -0x14(%ebp),%eax
    18b4:	89 c2                	mov    %eax,%edx
    18b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    18bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18bf:	8b 40 04             	mov    0x4(%eax),%eax
    18c2:	c1 e0 03             	shl    $0x3,%eax
    18c5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    18c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cb:	8b 55 ec             	mov    -0x14(%ebp),%edx
    18ce:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    18d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18d4:	a3 cc 1b 00 00       	mov    %eax,0x1bcc
      return (void*)(p + 1);
    18d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18dc:	83 c0 08             	add    $0x8,%eax
    18df:	eb 3b                	jmp    191c <malloc+0xe5>
    }
    if(p == freep)
    18e1:	a1 cc 1b 00 00       	mov    0x1bcc,%eax
    18e6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    18e9:	75 1e                	jne    1909 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    18eb:	83 ec 0c             	sub    $0xc,%esp
    18ee:	ff 75 ec             	pushl  -0x14(%ebp)
    18f1:	e8 dd fe ff ff       	call   17d3 <morecore>
    18f6:	83 c4 10             	add    $0x10,%esp
    18f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1900:	75 07                	jne    1909 <malloc+0xd2>
        return 0;
    1902:	b8 00 00 00 00       	mov    $0x0,%eax
    1907:	eb 13                	jmp    191c <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1909:	8b 45 f4             	mov    -0xc(%ebp),%eax
    190c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    190f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1912:	8b 00                	mov    (%eax),%eax
    1914:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1917:	e9 6d ff ff ff       	jmp    1889 <malloc+0x52>
  }
}
    191c:	c9                   	leave  
    191d:	c3                   	ret    
