
_ls:     file format elf32-i386


Disassembly of section .text:

00001000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
    1000:	f3 0f 1e fb          	endbr32 
    1004:	55                   	push   %ebp
    1005:	89 e5                	mov    %esp,%ebp
    1007:	53                   	push   %ebx
    1008:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    100b:	83 ec 0c             	sub    $0xc,%esp
    100e:	ff 75 08             	pushl  0x8(%ebp)
    1011:	e8 d5 03 00 00       	call   13eb <strlen>
    1016:	83 c4 10             	add    $0x10,%esp
    1019:	8b 55 08             	mov    0x8(%ebp),%edx
    101c:	01 d0                	add    %edx,%eax
    101e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1021:	eb 04                	jmp    1027 <fmtname+0x27>
    1023:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1027:	8b 45 f4             	mov    -0xc(%ebp),%eax
    102a:	3b 45 08             	cmp    0x8(%ebp),%eax
    102d:	72 0a                	jb     1039 <fmtname+0x39>
    102f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1032:	0f b6 00             	movzbl (%eax),%eax
    1035:	3c 2f                	cmp    $0x2f,%al
    1037:	75 ea                	jne    1023 <fmtname+0x23>
    ;
  p++;
    1039:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    103d:	83 ec 0c             	sub    $0xc,%esp
    1040:	ff 75 f4             	pushl  -0xc(%ebp)
    1043:	e8 a3 03 00 00       	call   13eb <strlen>
    1048:	83 c4 10             	add    $0x10,%esp
    104b:	83 f8 0d             	cmp    $0xd,%eax
    104e:	76 05                	jbe    1055 <fmtname+0x55>
    return p;
    1050:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1053:	eb 60                	jmp    10b5 <fmtname+0xb5>
  memmove(buf, p, strlen(p));
    1055:	83 ec 0c             	sub    $0xc,%esp
    1058:	ff 75 f4             	pushl  -0xc(%ebp)
    105b:	e8 8b 03 00 00       	call   13eb <strlen>
    1060:	83 c4 10             	add    $0x10,%esp
    1063:	83 ec 04             	sub    $0x4,%esp
    1066:	50                   	push   %eax
    1067:	ff 75 f4             	pushl  -0xc(%ebp)
    106a:	68 20 1e 00 00       	push   $0x1e20
    106f:	e8 0c 05 00 00       	call   1580 <memmove>
    1074:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    1077:	83 ec 0c             	sub    $0xc,%esp
    107a:	ff 75 f4             	pushl  -0xc(%ebp)
    107d:	e8 69 03 00 00       	call   13eb <strlen>
    1082:	83 c4 10             	add    $0x10,%esp
    1085:	ba 0e 00 00 00       	mov    $0xe,%edx
    108a:	89 d3                	mov    %edx,%ebx
    108c:	29 c3                	sub    %eax,%ebx
    108e:	83 ec 0c             	sub    $0xc,%esp
    1091:	ff 75 f4             	pushl  -0xc(%ebp)
    1094:	e8 52 03 00 00       	call   13eb <strlen>
    1099:	83 c4 10             	add    $0x10,%esp
    109c:	05 20 1e 00 00       	add    $0x1e20,%eax
    10a1:	83 ec 04             	sub    $0x4,%esp
    10a4:	53                   	push   %ebx
    10a5:	6a 20                	push   $0x20
    10a7:	50                   	push   %eax
    10a8:	e8 69 03 00 00       	call   1416 <memset>
    10ad:	83 c4 10             	add    $0x10,%esp
  return buf;
    10b0:	b8 20 1e 00 00       	mov    $0x1e20,%eax
}
    10b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10b8:	c9                   	leave  
    10b9:	c3                   	ret    

000010ba <ls>:

void
ls(char *path)
{
    10ba:	f3 0f 1e fb          	endbr32 
    10be:	55                   	push   %ebp
    10bf:	89 e5                	mov    %esp,%ebp
    10c1:	57                   	push   %edi
    10c2:	56                   	push   %esi
    10c3:	53                   	push   %ebx
    10c4:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    10ca:	83 ec 08             	sub    $0x8,%esp
    10cd:	6a 00                	push   $0x0
    10cf:	ff 75 08             	pushl  0x8(%ebp)
    10d2:	e8 32 05 00 00       	call   1609 <open>
    10d7:	83 c4 10             	add    $0x10,%esp
    10da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    10dd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    10e1:	79 1a                	jns    10fd <ls+0x43>
    printf(2, "ls: cannot open %s\n", path);
    10e3:	83 ec 04             	sub    $0x4,%esp
    10e6:	ff 75 08             	pushl  0x8(%ebp)
    10e9:	68 1c 1b 00 00       	push   $0x1b1c
    10ee:	6a 02                	push   $0x2
    10f0:	e8 60 06 00 00       	call   1755 <printf>
    10f5:	83 c4 10             	add    $0x10,%esp
    return;
    10f8:	e9 e1 01 00 00       	jmp    12de <ls+0x224>
  }

  if(fstat(fd, &st) < 0){
    10fd:	83 ec 08             	sub    $0x8,%esp
    1100:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
    1106:	50                   	push   %eax
    1107:	ff 75 e4             	pushl  -0x1c(%ebp)
    110a:	e8 12 05 00 00       	call   1621 <fstat>
    110f:	83 c4 10             	add    $0x10,%esp
    1112:	85 c0                	test   %eax,%eax
    1114:	79 28                	jns    113e <ls+0x84>
    printf(2, "ls: cannot stat %s\n", path);
    1116:	83 ec 04             	sub    $0x4,%esp
    1119:	ff 75 08             	pushl  0x8(%ebp)
    111c:	68 30 1b 00 00       	push   $0x1b30
    1121:	6a 02                	push   $0x2
    1123:	e8 2d 06 00 00       	call   1755 <printf>
    1128:	83 c4 10             	add    $0x10,%esp
    close(fd);
    112b:	83 ec 0c             	sub    $0xc,%esp
    112e:	ff 75 e4             	pushl  -0x1c(%ebp)
    1131:	e8 bb 04 00 00       	call   15f1 <close>
    1136:	83 c4 10             	add    $0x10,%esp
    return;
    1139:	e9 a0 01 00 00       	jmp    12de <ls+0x224>
  }

  switch(st.type){
    113e:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
    1145:	98                   	cwtl   
    1146:	83 f8 01             	cmp    $0x1,%eax
    1149:	74 48                	je     1193 <ls+0xd9>
    114b:	83 f8 02             	cmp    $0x2,%eax
    114e:	0f 85 7c 01 00 00    	jne    12d0 <ls+0x216>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    1154:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
    115a:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
    1160:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
    1167:	0f bf d8             	movswl %ax,%ebx
    116a:	83 ec 0c             	sub    $0xc,%esp
    116d:	ff 75 08             	pushl  0x8(%ebp)
    1170:	e8 8b fe ff ff       	call   1000 <fmtname>
    1175:	83 c4 10             	add    $0x10,%esp
    1178:	83 ec 08             	sub    $0x8,%esp
    117b:	57                   	push   %edi
    117c:	56                   	push   %esi
    117d:	53                   	push   %ebx
    117e:	50                   	push   %eax
    117f:	68 44 1b 00 00       	push   $0x1b44
    1184:	6a 01                	push   $0x1
    1186:	e8 ca 05 00 00       	call   1755 <printf>
    118b:	83 c4 20             	add    $0x20,%esp
    break;
    118e:	e9 3d 01 00 00       	jmp    12d0 <ls+0x216>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
    1193:	83 ec 0c             	sub    $0xc,%esp
    1196:	ff 75 08             	pushl  0x8(%ebp)
    1199:	e8 4d 02 00 00       	call   13eb <strlen>
    119e:	83 c4 10             	add    $0x10,%esp
    11a1:	83 c0 10             	add    $0x10,%eax
    11a4:	3d 00 02 00 00       	cmp    $0x200,%eax
    11a9:	76 17                	jbe    11c2 <ls+0x108>
      printf(1, "ls: path too long\n");
    11ab:	83 ec 08             	sub    $0x8,%esp
    11ae:	68 51 1b 00 00       	push   $0x1b51
    11b3:	6a 01                	push   $0x1
    11b5:	e8 9b 05 00 00       	call   1755 <printf>
    11ba:	83 c4 10             	add    $0x10,%esp
      break;
    11bd:	e9 0e 01 00 00       	jmp    12d0 <ls+0x216>
    }
    strcpy(buf, path);
    11c2:	83 ec 08             	sub    $0x8,%esp
    11c5:	ff 75 08             	pushl  0x8(%ebp)
    11c8:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    11ce:	50                   	push   %eax
    11cf:	e8 a0 01 00 00       	call   1374 <strcpy>
    11d4:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
    11d7:	83 ec 0c             	sub    $0xc,%esp
    11da:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    11e0:	50                   	push   %eax
    11e1:	e8 05 02 00 00       	call   13eb <strlen>
    11e6:	83 c4 10             	add    $0x10,%esp
    11e9:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
    11ef:	01 d0                	add    %edx,%eax
    11f1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
    11f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11f7:	8d 50 01             	lea    0x1(%eax),%edx
    11fa:	89 55 e0             	mov    %edx,-0x20(%ebp)
    11fd:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    1200:	e9 aa 00 00 00       	jmp    12af <ls+0x1f5>
      if(de.inum == 0)
    1205:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
    120c:	66 85 c0             	test   %ax,%ax
    120f:	75 05                	jne    1216 <ls+0x15c>
        continue;
    1211:	e9 99 00 00 00       	jmp    12af <ls+0x1f5>
      memmove(p, de.name, DIRSIZ);
    1216:	83 ec 04             	sub    $0x4,%esp
    1219:	6a 0e                	push   $0xe
    121b:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
    1221:	83 c0 02             	add    $0x2,%eax
    1224:	50                   	push   %eax
    1225:	ff 75 e0             	pushl  -0x20(%ebp)
    1228:	e8 53 03 00 00       	call   1580 <memmove>
    122d:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
    1230:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1233:	83 c0 0e             	add    $0xe,%eax
    1236:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
    1239:	83 ec 08             	sub    $0x8,%esp
    123c:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
    1242:	50                   	push   %eax
    1243:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    1249:	50                   	push   %eax
    124a:	e8 8f 02 00 00       	call   14de <stat>
    124f:	83 c4 10             	add    $0x10,%esp
    1252:	85 c0                	test   %eax,%eax
    1254:	79 1b                	jns    1271 <ls+0x1b7>
        printf(1, "ls: cannot stat %s\n", buf);
    1256:	83 ec 04             	sub    $0x4,%esp
    1259:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    125f:	50                   	push   %eax
    1260:	68 30 1b 00 00       	push   $0x1b30
    1265:	6a 01                	push   $0x1
    1267:	e8 e9 04 00 00       	call   1755 <printf>
    126c:	83 c4 10             	add    $0x10,%esp
        continue;
    126f:	eb 3e                	jmp    12af <ls+0x1f5>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    1271:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
    1277:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
    127d:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
    1284:	0f bf d8             	movswl %ax,%ebx
    1287:	83 ec 0c             	sub    $0xc,%esp
    128a:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    1290:	50                   	push   %eax
    1291:	e8 6a fd ff ff       	call   1000 <fmtname>
    1296:	83 c4 10             	add    $0x10,%esp
    1299:	83 ec 08             	sub    $0x8,%esp
    129c:	57                   	push   %edi
    129d:	56                   	push   %esi
    129e:	53                   	push   %ebx
    129f:	50                   	push   %eax
    12a0:	68 44 1b 00 00       	push   $0x1b44
    12a5:	6a 01                	push   $0x1
    12a7:	e8 a9 04 00 00       	call   1755 <printf>
    12ac:	83 c4 20             	add    $0x20,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    12af:	83 ec 04             	sub    $0x4,%esp
    12b2:	6a 10                	push   $0x10
    12b4:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
    12ba:	50                   	push   %eax
    12bb:	ff 75 e4             	pushl  -0x1c(%ebp)
    12be:	e8 1e 03 00 00       	call   15e1 <read>
    12c3:	83 c4 10             	add    $0x10,%esp
    12c6:	83 f8 10             	cmp    $0x10,%eax
    12c9:	0f 84 36 ff ff ff    	je     1205 <ls+0x14b>
    }
    break;
    12cf:	90                   	nop
  }
  close(fd);
    12d0:	83 ec 0c             	sub    $0xc,%esp
    12d3:	ff 75 e4             	pushl  -0x1c(%ebp)
    12d6:	e8 16 03 00 00       	call   15f1 <close>
    12db:	83 c4 10             	add    $0x10,%esp
}
    12de:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12e1:	5b                   	pop    %ebx
    12e2:	5e                   	pop    %esi
    12e3:	5f                   	pop    %edi
    12e4:	5d                   	pop    %ebp
    12e5:	c3                   	ret    

000012e6 <main>:

int
main(int argc, char *argv[])
{
    12e6:	f3 0f 1e fb          	endbr32 
    12ea:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    12ee:	83 e4 f0             	and    $0xfffffff0,%esp
    12f1:	ff 71 fc             	pushl  -0x4(%ecx)
    12f4:	55                   	push   %ebp
    12f5:	89 e5                	mov    %esp,%ebp
    12f7:	53                   	push   %ebx
    12f8:	51                   	push   %ecx
    12f9:	83 ec 10             	sub    $0x10,%esp
    12fc:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
    12fe:	83 3b 01             	cmpl   $0x1,(%ebx)
    1301:	7f 15                	jg     1318 <main+0x32>
    ls(".");
    1303:	83 ec 0c             	sub    $0xc,%esp
    1306:	68 64 1b 00 00       	push   $0x1b64
    130b:	e8 aa fd ff ff       	call   10ba <ls>
    1310:	83 c4 10             	add    $0x10,%esp
    exit();
    1313:	e8 b1 02 00 00       	call   15c9 <exit>
  }
  for(i=1; i<argc; i++)
    1318:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    131f:	eb 21                	jmp    1342 <main+0x5c>
    ls(argv[i]);
    1321:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1324:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    132b:	8b 43 04             	mov    0x4(%ebx),%eax
    132e:	01 d0                	add    %edx,%eax
    1330:	8b 00                	mov    (%eax),%eax
    1332:	83 ec 0c             	sub    $0xc,%esp
    1335:	50                   	push   %eax
    1336:	e8 7f fd ff ff       	call   10ba <ls>
    133b:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
    133e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1342:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1345:	3b 03                	cmp    (%ebx),%eax
    1347:	7c d8                	jl     1321 <main+0x3b>
  exit();
    1349:	e8 7b 02 00 00       	call   15c9 <exit>

0000134e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    134e:	55                   	push   %ebp
    134f:	89 e5                	mov    %esp,%ebp
    1351:	57                   	push   %edi
    1352:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1353:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1356:	8b 55 10             	mov    0x10(%ebp),%edx
    1359:	8b 45 0c             	mov    0xc(%ebp),%eax
    135c:	89 cb                	mov    %ecx,%ebx
    135e:	89 df                	mov    %ebx,%edi
    1360:	89 d1                	mov    %edx,%ecx
    1362:	fc                   	cld    
    1363:	f3 aa                	rep stos %al,%es:(%edi)
    1365:	89 ca                	mov    %ecx,%edx
    1367:	89 fb                	mov    %edi,%ebx
    1369:	89 5d 08             	mov    %ebx,0x8(%ebp)
    136c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    136f:	90                   	nop
    1370:	5b                   	pop    %ebx
    1371:	5f                   	pop    %edi
    1372:	5d                   	pop    %ebp
    1373:	c3                   	ret    

00001374 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1374:	f3 0f 1e fb          	endbr32 
    1378:	55                   	push   %ebp
    1379:	89 e5                	mov    %esp,%ebp
    137b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    137e:	8b 45 08             	mov    0x8(%ebp),%eax
    1381:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1384:	90                   	nop
    1385:	8b 55 0c             	mov    0xc(%ebp),%edx
    1388:	8d 42 01             	lea    0x1(%edx),%eax
    138b:	89 45 0c             	mov    %eax,0xc(%ebp)
    138e:	8b 45 08             	mov    0x8(%ebp),%eax
    1391:	8d 48 01             	lea    0x1(%eax),%ecx
    1394:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1397:	0f b6 12             	movzbl (%edx),%edx
    139a:	88 10                	mov    %dl,(%eax)
    139c:	0f b6 00             	movzbl (%eax),%eax
    139f:	84 c0                	test   %al,%al
    13a1:	75 e2                	jne    1385 <strcpy+0x11>
    ;
  return os;
    13a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13a6:	c9                   	leave  
    13a7:	c3                   	ret    

000013a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    13a8:	f3 0f 1e fb          	endbr32 
    13ac:	55                   	push   %ebp
    13ad:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    13af:	eb 08                	jmp    13b9 <strcmp+0x11>
    p++, q++;
    13b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13b5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    13b9:	8b 45 08             	mov    0x8(%ebp),%eax
    13bc:	0f b6 00             	movzbl (%eax),%eax
    13bf:	84 c0                	test   %al,%al
    13c1:	74 10                	je     13d3 <strcmp+0x2b>
    13c3:	8b 45 08             	mov    0x8(%ebp),%eax
    13c6:	0f b6 10             	movzbl (%eax),%edx
    13c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cc:	0f b6 00             	movzbl (%eax),%eax
    13cf:	38 c2                	cmp    %al,%dl
    13d1:	74 de                	je     13b1 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    13d3:	8b 45 08             	mov    0x8(%ebp),%eax
    13d6:	0f b6 00             	movzbl (%eax),%eax
    13d9:	0f b6 d0             	movzbl %al,%edx
    13dc:	8b 45 0c             	mov    0xc(%ebp),%eax
    13df:	0f b6 00             	movzbl (%eax),%eax
    13e2:	0f b6 c0             	movzbl %al,%eax
    13e5:	29 c2                	sub    %eax,%edx
    13e7:	89 d0                	mov    %edx,%eax
}
    13e9:	5d                   	pop    %ebp
    13ea:	c3                   	ret    

000013eb <strlen>:

uint
strlen(const char *s)
{
    13eb:	f3 0f 1e fb          	endbr32 
    13ef:	55                   	push   %ebp
    13f0:	89 e5                	mov    %esp,%ebp
    13f2:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    13f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    13fc:	eb 04                	jmp    1402 <strlen+0x17>
    13fe:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1402:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1405:	8b 45 08             	mov    0x8(%ebp),%eax
    1408:	01 d0                	add    %edx,%eax
    140a:	0f b6 00             	movzbl (%eax),%eax
    140d:	84 c0                	test   %al,%al
    140f:	75 ed                	jne    13fe <strlen+0x13>
    ;
  return n;
    1411:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1414:	c9                   	leave  
    1415:	c3                   	ret    

00001416 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1416:	f3 0f 1e fb          	endbr32 
    141a:	55                   	push   %ebp
    141b:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    141d:	8b 45 10             	mov    0x10(%ebp),%eax
    1420:	50                   	push   %eax
    1421:	ff 75 0c             	pushl  0xc(%ebp)
    1424:	ff 75 08             	pushl  0x8(%ebp)
    1427:	e8 22 ff ff ff       	call   134e <stosb>
    142c:	83 c4 0c             	add    $0xc,%esp
  return dst;
    142f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1432:	c9                   	leave  
    1433:	c3                   	ret    

00001434 <strchr>:

char*
strchr(const char *s, char c)
{
    1434:	f3 0f 1e fb          	endbr32 
    1438:	55                   	push   %ebp
    1439:	89 e5                	mov    %esp,%ebp
    143b:	83 ec 04             	sub    $0x4,%esp
    143e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1441:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1444:	eb 14                	jmp    145a <strchr+0x26>
    if(*s == c)
    1446:	8b 45 08             	mov    0x8(%ebp),%eax
    1449:	0f b6 00             	movzbl (%eax),%eax
    144c:	38 45 fc             	cmp    %al,-0x4(%ebp)
    144f:	75 05                	jne    1456 <strchr+0x22>
      return (char*)s;
    1451:	8b 45 08             	mov    0x8(%ebp),%eax
    1454:	eb 13                	jmp    1469 <strchr+0x35>
  for(; *s; s++)
    1456:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    145a:	8b 45 08             	mov    0x8(%ebp),%eax
    145d:	0f b6 00             	movzbl (%eax),%eax
    1460:	84 c0                	test   %al,%al
    1462:	75 e2                	jne    1446 <strchr+0x12>
  return 0;
    1464:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1469:	c9                   	leave  
    146a:	c3                   	ret    

0000146b <gets>:

char*
gets(char *buf, int max)
{
    146b:	f3 0f 1e fb          	endbr32 
    146f:	55                   	push   %ebp
    1470:	89 e5                	mov    %esp,%ebp
    1472:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1475:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    147c:	eb 42                	jmp    14c0 <gets+0x55>
    cc = read(0, &c, 1);
    147e:	83 ec 04             	sub    $0x4,%esp
    1481:	6a 01                	push   $0x1
    1483:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1486:	50                   	push   %eax
    1487:	6a 00                	push   $0x0
    1489:	e8 53 01 00 00       	call   15e1 <read>
    148e:	83 c4 10             	add    $0x10,%esp
    1491:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1494:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1498:	7e 33                	jle    14cd <gets+0x62>
      break;
    buf[i++] = c;
    149a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149d:	8d 50 01             	lea    0x1(%eax),%edx
    14a0:	89 55 f4             	mov    %edx,-0xc(%ebp)
    14a3:	89 c2                	mov    %eax,%edx
    14a5:	8b 45 08             	mov    0x8(%ebp),%eax
    14a8:	01 c2                	add    %eax,%edx
    14aa:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14ae:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    14b0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14b4:	3c 0a                	cmp    $0xa,%al
    14b6:	74 16                	je     14ce <gets+0x63>
    14b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14bc:	3c 0d                	cmp    $0xd,%al
    14be:	74 0e                	je     14ce <gets+0x63>
  for(i=0; i+1 < max; ){
    14c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c3:	83 c0 01             	add    $0x1,%eax
    14c6:	39 45 0c             	cmp    %eax,0xc(%ebp)
    14c9:	7f b3                	jg     147e <gets+0x13>
    14cb:	eb 01                	jmp    14ce <gets+0x63>
      break;
    14cd:	90                   	nop
      break;
  }
  buf[i] = '\0';
    14ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
    14d1:	8b 45 08             	mov    0x8(%ebp),%eax
    14d4:	01 d0                	add    %edx,%eax
    14d6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    14d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14dc:	c9                   	leave  
    14dd:	c3                   	ret    

000014de <stat>:

int
stat(const char *n, struct stat *st)
{
    14de:	f3 0f 1e fb          	endbr32 
    14e2:	55                   	push   %ebp
    14e3:	89 e5                	mov    %esp,%ebp
    14e5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14e8:	83 ec 08             	sub    $0x8,%esp
    14eb:	6a 00                	push   $0x0
    14ed:	ff 75 08             	pushl  0x8(%ebp)
    14f0:	e8 14 01 00 00       	call   1609 <open>
    14f5:	83 c4 10             	add    $0x10,%esp
    14f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    14fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14ff:	79 07                	jns    1508 <stat+0x2a>
    return -1;
    1501:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1506:	eb 25                	jmp    152d <stat+0x4f>
  r = fstat(fd, st);
    1508:	83 ec 08             	sub    $0x8,%esp
    150b:	ff 75 0c             	pushl  0xc(%ebp)
    150e:	ff 75 f4             	pushl  -0xc(%ebp)
    1511:	e8 0b 01 00 00       	call   1621 <fstat>
    1516:	83 c4 10             	add    $0x10,%esp
    1519:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    151c:	83 ec 0c             	sub    $0xc,%esp
    151f:	ff 75 f4             	pushl  -0xc(%ebp)
    1522:	e8 ca 00 00 00       	call   15f1 <close>
    1527:	83 c4 10             	add    $0x10,%esp
  return r;
    152a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    152d:	c9                   	leave  
    152e:	c3                   	ret    

0000152f <atoi>:

int
atoi(const char *s)
{
    152f:	f3 0f 1e fb          	endbr32 
    1533:	55                   	push   %ebp
    1534:	89 e5                	mov    %esp,%ebp
    1536:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1539:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1540:	eb 25                	jmp    1567 <atoi+0x38>
    n = n*10 + *s++ - '0';
    1542:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1545:	89 d0                	mov    %edx,%eax
    1547:	c1 e0 02             	shl    $0x2,%eax
    154a:	01 d0                	add    %edx,%eax
    154c:	01 c0                	add    %eax,%eax
    154e:	89 c1                	mov    %eax,%ecx
    1550:	8b 45 08             	mov    0x8(%ebp),%eax
    1553:	8d 50 01             	lea    0x1(%eax),%edx
    1556:	89 55 08             	mov    %edx,0x8(%ebp)
    1559:	0f b6 00             	movzbl (%eax),%eax
    155c:	0f be c0             	movsbl %al,%eax
    155f:	01 c8                	add    %ecx,%eax
    1561:	83 e8 30             	sub    $0x30,%eax
    1564:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1567:	8b 45 08             	mov    0x8(%ebp),%eax
    156a:	0f b6 00             	movzbl (%eax),%eax
    156d:	3c 2f                	cmp    $0x2f,%al
    156f:	7e 0a                	jle    157b <atoi+0x4c>
    1571:	8b 45 08             	mov    0x8(%ebp),%eax
    1574:	0f b6 00             	movzbl (%eax),%eax
    1577:	3c 39                	cmp    $0x39,%al
    1579:	7e c7                	jle    1542 <atoi+0x13>
  return n;
    157b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    157e:	c9                   	leave  
    157f:	c3                   	ret    

00001580 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1580:	f3 0f 1e fb          	endbr32 
    1584:	55                   	push   %ebp
    1585:	89 e5                	mov    %esp,%ebp
    1587:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    158a:	8b 45 08             	mov    0x8(%ebp),%eax
    158d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1590:	8b 45 0c             	mov    0xc(%ebp),%eax
    1593:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1596:	eb 17                	jmp    15af <memmove+0x2f>
    *dst++ = *src++;
    1598:	8b 55 f8             	mov    -0x8(%ebp),%edx
    159b:	8d 42 01             	lea    0x1(%edx),%eax
    159e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    15a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15a4:	8d 48 01             	lea    0x1(%eax),%ecx
    15a7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    15aa:	0f b6 12             	movzbl (%edx),%edx
    15ad:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    15af:	8b 45 10             	mov    0x10(%ebp),%eax
    15b2:	8d 50 ff             	lea    -0x1(%eax),%edx
    15b5:	89 55 10             	mov    %edx,0x10(%ebp)
    15b8:	85 c0                	test   %eax,%eax
    15ba:	7f dc                	jg     1598 <memmove+0x18>
  return vdst;
    15bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15bf:	c9                   	leave  
    15c0:	c3                   	ret    

000015c1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    15c1:	b8 01 00 00 00       	mov    $0x1,%eax
    15c6:	cd 40                	int    $0x40
    15c8:	c3                   	ret    

000015c9 <exit>:
SYSCALL(exit)
    15c9:	b8 02 00 00 00       	mov    $0x2,%eax
    15ce:	cd 40                	int    $0x40
    15d0:	c3                   	ret    

000015d1 <wait>:
SYSCALL(wait)
    15d1:	b8 03 00 00 00       	mov    $0x3,%eax
    15d6:	cd 40                	int    $0x40
    15d8:	c3                   	ret    

000015d9 <pipe>:
SYSCALL(pipe)
    15d9:	b8 04 00 00 00       	mov    $0x4,%eax
    15de:	cd 40                	int    $0x40
    15e0:	c3                   	ret    

000015e1 <read>:
SYSCALL(read)
    15e1:	b8 05 00 00 00       	mov    $0x5,%eax
    15e6:	cd 40                	int    $0x40
    15e8:	c3                   	ret    

000015e9 <write>:
SYSCALL(write)
    15e9:	b8 10 00 00 00       	mov    $0x10,%eax
    15ee:	cd 40                	int    $0x40
    15f0:	c3                   	ret    

000015f1 <close>:
SYSCALL(close)
    15f1:	b8 15 00 00 00       	mov    $0x15,%eax
    15f6:	cd 40                	int    $0x40
    15f8:	c3                   	ret    

000015f9 <kill>:
SYSCALL(kill)
    15f9:	b8 06 00 00 00       	mov    $0x6,%eax
    15fe:	cd 40                	int    $0x40
    1600:	c3                   	ret    

00001601 <exec>:
SYSCALL(exec)
    1601:	b8 07 00 00 00       	mov    $0x7,%eax
    1606:	cd 40                	int    $0x40
    1608:	c3                   	ret    

00001609 <open>:
SYSCALL(open)
    1609:	b8 0f 00 00 00       	mov    $0xf,%eax
    160e:	cd 40                	int    $0x40
    1610:	c3                   	ret    

00001611 <mknod>:
SYSCALL(mknod)
    1611:	b8 11 00 00 00       	mov    $0x11,%eax
    1616:	cd 40                	int    $0x40
    1618:	c3                   	ret    

00001619 <unlink>:
SYSCALL(unlink)
    1619:	b8 12 00 00 00       	mov    $0x12,%eax
    161e:	cd 40                	int    $0x40
    1620:	c3                   	ret    

00001621 <fstat>:
SYSCALL(fstat)
    1621:	b8 08 00 00 00       	mov    $0x8,%eax
    1626:	cd 40                	int    $0x40
    1628:	c3                   	ret    

00001629 <link>:
SYSCALL(link)
    1629:	b8 13 00 00 00       	mov    $0x13,%eax
    162e:	cd 40                	int    $0x40
    1630:	c3                   	ret    

00001631 <mkdir>:
SYSCALL(mkdir)
    1631:	b8 14 00 00 00       	mov    $0x14,%eax
    1636:	cd 40                	int    $0x40
    1638:	c3                   	ret    

00001639 <chdir>:
SYSCALL(chdir)
    1639:	b8 09 00 00 00       	mov    $0x9,%eax
    163e:	cd 40                	int    $0x40
    1640:	c3                   	ret    

00001641 <dup>:
SYSCALL(dup)
    1641:	b8 0a 00 00 00       	mov    $0xa,%eax
    1646:	cd 40                	int    $0x40
    1648:	c3                   	ret    

00001649 <getpid>:
SYSCALL(getpid)
    1649:	b8 0b 00 00 00       	mov    $0xb,%eax
    164e:	cd 40                	int    $0x40
    1650:	c3                   	ret    

00001651 <sbrk>:
SYSCALL(sbrk)
    1651:	b8 0c 00 00 00       	mov    $0xc,%eax
    1656:	cd 40                	int    $0x40
    1658:	c3                   	ret    

00001659 <sleep>:
SYSCALL(sleep)
    1659:	b8 0d 00 00 00       	mov    $0xd,%eax
    165e:	cd 40                	int    $0x40
    1660:	c3                   	ret    

00001661 <uptime>:
SYSCALL(uptime)
    1661:	b8 0e 00 00 00       	mov    $0xe,%eax
    1666:	cd 40                	int    $0x40
    1668:	c3                   	ret    

00001669 <settickets>:
SYSCALL(settickets)
    1669:	b8 16 00 00 00       	mov    $0x16,%eax
    166e:	cd 40                	int    $0x40
    1670:	c3                   	ret    

00001671 <getpinfo>:
SYSCALL(getpinfo)
    1671:	b8 17 00 00 00       	mov    $0x17,%eax
    1676:	cd 40                	int    $0x40
    1678:	c3                   	ret    

00001679 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1679:	f3 0f 1e fb          	endbr32 
    167d:	55                   	push   %ebp
    167e:	89 e5                	mov    %esp,%ebp
    1680:	83 ec 18             	sub    $0x18,%esp
    1683:	8b 45 0c             	mov    0xc(%ebp),%eax
    1686:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1689:	83 ec 04             	sub    $0x4,%esp
    168c:	6a 01                	push   $0x1
    168e:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1691:	50                   	push   %eax
    1692:	ff 75 08             	pushl  0x8(%ebp)
    1695:	e8 4f ff ff ff       	call   15e9 <write>
    169a:	83 c4 10             	add    $0x10,%esp
}
    169d:	90                   	nop
    169e:	c9                   	leave  
    169f:	c3                   	ret    

000016a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    16a0:	f3 0f 1e fb          	endbr32 
    16a4:	55                   	push   %ebp
    16a5:	89 e5                	mov    %esp,%ebp
    16a7:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    16aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    16b1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    16b5:	74 17                	je     16ce <printint+0x2e>
    16b7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16bb:	79 11                	jns    16ce <printint+0x2e>
    neg = 1;
    16bd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    16c4:	8b 45 0c             	mov    0xc(%ebp),%eax
    16c7:	f7 d8                	neg    %eax
    16c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    16cc:	eb 06                	jmp    16d4 <printint+0x34>
  } else {
    x = xx;
    16ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    16d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    16d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    16db:	8b 4d 10             	mov    0x10(%ebp),%ecx
    16de:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16e1:	ba 00 00 00 00       	mov    $0x0,%edx
    16e6:	f7 f1                	div    %ecx
    16e8:	89 d1                	mov    %edx,%ecx
    16ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ed:	8d 50 01             	lea    0x1(%eax),%edx
    16f0:	89 55 f4             	mov    %edx,-0xc(%ebp)
    16f3:	0f b6 91 0c 1e 00 00 	movzbl 0x1e0c(%ecx),%edx
    16fa:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    16fe:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1701:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1704:	ba 00 00 00 00       	mov    $0x0,%edx
    1709:	f7 f1                	div    %ecx
    170b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    170e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1712:	75 c7                	jne    16db <printint+0x3b>
  if(neg)
    1714:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1718:	74 2d                	je     1747 <printint+0xa7>
    buf[i++] = '-';
    171a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171d:	8d 50 01             	lea    0x1(%eax),%edx
    1720:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1723:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1728:	eb 1d                	jmp    1747 <printint+0xa7>
    putc(fd, buf[i]);
    172a:	8d 55 dc             	lea    -0x24(%ebp),%edx
    172d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1730:	01 d0                	add    %edx,%eax
    1732:	0f b6 00             	movzbl (%eax),%eax
    1735:	0f be c0             	movsbl %al,%eax
    1738:	83 ec 08             	sub    $0x8,%esp
    173b:	50                   	push   %eax
    173c:	ff 75 08             	pushl  0x8(%ebp)
    173f:	e8 35 ff ff ff       	call   1679 <putc>
    1744:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    1747:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    174b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    174f:	79 d9                	jns    172a <printint+0x8a>
}
    1751:	90                   	nop
    1752:	90                   	nop
    1753:	c9                   	leave  
    1754:	c3                   	ret    

00001755 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1755:	f3 0f 1e fb          	endbr32 
    1759:	55                   	push   %ebp
    175a:	89 e5                	mov    %esp,%ebp
    175c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    175f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1766:	8d 45 0c             	lea    0xc(%ebp),%eax
    1769:	83 c0 04             	add    $0x4,%eax
    176c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    176f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1776:	e9 59 01 00 00       	jmp    18d4 <printf+0x17f>
    c = fmt[i] & 0xff;
    177b:	8b 55 0c             	mov    0xc(%ebp),%edx
    177e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1781:	01 d0                	add    %edx,%eax
    1783:	0f b6 00             	movzbl (%eax),%eax
    1786:	0f be c0             	movsbl %al,%eax
    1789:	25 ff 00 00 00       	and    $0xff,%eax
    178e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1791:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1795:	75 2c                	jne    17c3 <printf+0x6e>
      if(c == '%'){
    1797:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    179b:	75 0c                	jne    17a9 <printf+0x54>
        state = '%';
    179d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    17a4:	e9 27 01 00 00       	jmp    18d0 <printf+0x17b>
      } else {
        putc(fd, c);
    17a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17ac:	0f be c0             	movsbl %al,%eax
    17af:	83 ec 08             	sub    $0x8,%esp
    17b2:	50                   	push   %eax
    17b3:	ff 75 08             	pushl  0x8(%ebp)
    17b6:	e8 be fe ff ff       	call   1679 <putc>
    17bb:	83 c4 10             	add    $0x10,%esp
    17be:	e9 0d 01 00 00       	jmp    18d0 <printf+0x17b>
      }
    } else if(state == '%'){
    17c3:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    17c7:	0f 85 03 01 00 00    	jne    18d0 <printf+0x17b>
      if(c == 'd'){
    17cd:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    17d1:	75 1e                	jne    17f1 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    17d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17d6:	8b 00                	mov    (%eax),%eax
    17d8:	6a 01                	push   $0x1
    17da:	6a 0a                	push   $0xa
    17dc:	50                   	push   %eax
    17dd:	ff 75 08             	pushl  0x8(%ebp)
    17e0:	e8 bb fe ff ff       	call   16a0 <printint>
    17e5:	83 c4 10             	add    $0x10,%esp
        ap++;
    17e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    17ec:	e9 d8 00 00 00       	jmp    18c9 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    17f1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    17f5:	74 06                	je     17fd <printf+0xa8>
    17f7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    17fb:	75 1e                	jne    181b <printf+0xc6>
        printint(fd, *ap, 16, 0);
    17fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1800:	8b 00                	mov    (%eax),%eax
    1802:	6a 00                	push   $0x0
    1804:	6a 10                	push   $0x10
    1806:	50                   	push   %eax
    1807:	ff 75 08             	pushl  0x8(%ebp)
    180a:	e8 91 fe ff ff       	call   16a0 <printint>
    180f:	83 c4 10             	add    $0x10,%esp
        ap++;
    1812:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1816:	e9 ae 00 00 00       	jmp    18c9 <printf+0x174>
      } else if(c == 's'){
    181b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    181f:	75 43                	jne    1864 <printf+0x10f>
        s = (char*)*ap;
    1821:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1824:	8b 00                	mov    (%eax),%eax
    1826:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1829:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    182d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1831:	75 25                	jne    1858 <printf+0x103>
          s = "(null)";
    1833:	c7 45 f4 66 1b 00 00 	movl   $0x1b66,-0xc(%ebp)
        while(*s != 0){
    183a:	eb 1c                	jmp    1858 <printf+0x103>
          putc(fd, *s);
    183c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183f:	0f b6 00             	movzbl (%eax),%eax
    1842:	0f be c0             	movsbl %al,%eax
    1845:	83 ec 08             	sub    $0x8,%esp
    1848:	50                   	push   %eax
    1849:	ff 75 08             	pushl  0x8(%ebp)
    184c:	e8 28 fe ff ff       	call   1679 <putc>
    1851:	83 c4 10             	add    $0x10,%esp
          s++;
    1854:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1858:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185b:	0f b6 00             	movzbl (%eax),%eax
    185e:	84 c0                	test   %al,%al
    1860:	75 da                	jne    183c <printf+0xe7>
    1862:	eb 65                	jmp    18c9 <printf+0x174>
        }
      } else if(c == 'c'){
    1864:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1868:	75 1d                	jne    1887 <printf+0x132>
        putc(fd, *ap);
    186a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    186d:	8b 00                	mov    (%eax),%eax
    186f:	0f be c0             	movsbl %al,%eax
    1872:	83 ec 08             	sub    $0x8,%esp
    1875:	50                   	push   %eax
    1876:	ff 75 08             	pushl  0x8(%ebp)
    1879:	e8 fb fd ff ff       	call   1679 <putc>
    187e:	83 c4 10             	add    $0x10,%esp
        ap++;
    1881:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1885:	eb 42                	jmp    18c9 <printf+0x174>
      } else if(c == '%'){
    1887:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    188b:	75 17                	jne    18a4 <printf+0x14f>
        putc(fd, c);
    188d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1890:	0f be c0             	movsbl %al,%eax
    1893:	83 ec 08             	sub    $0x8,%esp
    1896:	50                   	push   %eax
    1897:	ff 75 08             	pushl  0x8(%ebp)
    189a:	e8 da fd ff ff       	call   1679 <putc>
    189f:	83 c4 10             	add    $0x10,%esp
    18a2:	eb 25                	jmp    18c9 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    18a4:	83 ec 08             	sub    $0x8,%esp
    18a7:	6a 25                	push   $0x25
    18a9:	ff 75 08             	pushl  0x8(%ebp)
    18ac:	e8 c8 fd ff ff       	call   1679 <putc>
    18b1:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    18b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18b7:	0f be c0             	movsbl %al,%eax
    18ba:	83 ec 08             	sub    $0x8,%esp
    18bd:	50                   	push   %eax
    18be:	ff 75 08             	pushl  0x8(%ebp)
    18c1:	e8 b3 fd ff ff       	call   1679 <putc>
    18c6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    18c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    18d0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    18d4:	8b 55 0c             	mov    0xc(%ebp),%edx
    18d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18da:	01 d0                	add    %edx,%eax
    18dc:	0f b6 00             	movzbl (%eax),%eax
    18df:	84 c0                	test   %al,%al
    18e1:	0f 85 94 fe ff ff    	jne    177b <printf+0x26>
    }
  }
}
    18e7:	90                   	nop
    18e8:	90                   	nop
    18e9:	c9                   	leave  
    18ea:	c3                   	ret    

000018eb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18eb:	f3 0f 1e fb          	endbr32 
    18ef:	55                   	push   %ebp
    18f0:	89 e5                	mov    %esp,%ebp
    18f2:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    18f5:	8b 45 08             	mov    0x8(%ebp),%eax
    18f8:	83 e8 08             	sub    $0x8,%eax
    18fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18fe:	a1 38 1e 00 00       	mov    0x1e38,%eax
    1903:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1906:	eb 24                	jmp    192c <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1908:	8b 45 fc             	mov    -0x4(%ebp),%eax
    190b:	8b 00                	mov    (%eax),%eax
    190d:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1910:	72 12                	jb     1924 <free+0x39>
    1912:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1915:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1918:	77 24                	ja     193e <free+0x53>
    191a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    191d:	8b 00                	mov    (%eax),%eax
    191f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1922:	72 1a                	jb     193e <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1924:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1927:	8b 00                	mov    (%eax),%eax
    1929:	89 45 fc             	mov    %eax,-0x4(%ebp)
    192c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    192f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1932:	76 d4                	jbe    1908 <free+0x1d>
    1934:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1937:	8b 00                	mov    (%eax),%eax
    1939:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    193c:	73 ca                	jae    1908 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    193e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1941:	8b 40 04             	mov    0x4(%eax),%eax
    1944:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    194b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    194e:	01 c2                	add    %eax,%edx
    1950:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1953:	8b 00                	mov    (%eax),%eax
    1955:	39 c2                	cmp    %eax,%edx
    1957:	75 24                	jne    197d <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1959:	8b 45 f8             	mov    -0x8(%ebp),%eax
    195c:	8b 50 04             	mov    0x4(%eax),%edx
    195f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1962:	8b 00                	mov    (%eax),%eax
    1964:	8b 40 04             	mov    0x4(%eax),%eax
    1967:	01 c2                	add    %eax,%edx
    1969:	8b 45 f8             	mov    -0x8(%ebp),%eax
    196c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    196f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1972:	8b 00                	mov    (%eax),%eax
    1974:	8b 10                	mov    (%eax),%edx
    1976:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1979:	89 10                	mov    %edx,(%eax)
    197b:	eb 0a                	jmp    1987 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    197d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1980:	8b 10                	mov    (%eax),%edx
    1982:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1985:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1987:	8b 45 fc             	mov    -0x4(%ebp),%eax
    198a:	8b 40 04             	mov    0x4(%eax),%eax
    198d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1994:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1997:	01 d0                	add    %edx,%eax
    1999:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    199c:	75 20                	jne    19be <free+0xd3>
    p->s.size += bp->s.size;
    199e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19a1:	8b 50 04             	mov    0x4(%eax),%edx
    19a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19a7:	8b 40 04             	mov    0x4(%eax),%eax
    19aa:	01 c2                	add    %eax,%edx
    19ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    19b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19b5:	8b 10                	mov    (%eax),%edx
    19b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19ba:	89 10                	mov    %edx,(%eax)
    19bc:	eb 08                	jmp    19c6 <free+0xdb>
  } else
    p->s.ptr = bp;
    19be:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19c1:	8b 55 f8             	mov    -0x8(%ebp),%edx
    19c4:	89 10                	mov    %edx,(%eax)
  freep = p;
    19c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19c9:	a3 38 1e 00 00       	mov    %eax,0x1e38
}
    19ce:	90                   	nop
    19cf:	c9                   	leave  
    19d0:	c3                   	ret    

000019d1 <morecore>:

static Header*
morecore(uint nu)
{
    19d1:	f3 0f 1e fb          	endbr32 
    19d5:	55                   	push   %ebp
    19d6:	89 e5                	mov    %esp,%ebp
    19d8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    19db:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    19e2:	77 07                	ja     19eb <morecore+0x1a>
    nu = 4096;
    19e4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    19eb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ee:	c1 e0 03             	shl    $0x3,%eax
    19f1:	83 ec 0c             	sub    $0xc,%esp
    19f4:	50                   	push   %eax
    19f5:	e8 57 fc ff ff       	call   1651 <sbrk>
    19fa:	83 c4 10             	add    $0x10,%esp
    19fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1a00:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1a04:	75 07                	jne    1a0d <morecore+0x3c>
    return 0;
    1a06:	b8 00 00 00 00       	mov    $0x0,%eax
    1a0b:	eb 26                	jmp    1a33 <morecore+0x62>
  hp = (Header*)p;
    1a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a16:	8b 55 08             	mov    0x8(%ebp),%edx
    1a19:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1a1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a1f:	83 c0 08             	add    $0x8,%eax
    1a22:	83 ec 0c             	sub    $0xc,%esp
    1a25:	50                   	push   %eax
    1a26:	e8 c0 fe ff ff       	call   18eb <free>
    1a2b:	83 c4 10             	add    $0x10,%esp
  return freep;
    1a2e:	a1 38 1e 00 00       	mov    0x1e38,%eax
}
    1a33:	c9                   	leave  
    1a34:	c3                   	ret    

00001a35 <malloc>:

void*
malloc(uint nbytes)
{
    1a35:	f3 0f 1e fb          	endbr32 
    1a39:	55                   	push   %ebp
    1a3a:	89 e5                	mov    %esp,%ebp
    1a3c:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1a3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a42:	83 c0 07             	add    $0x7,%eax
    1a45:	c1 e8 03             	shr    $0x3,%eax
    1a48:	83 c0 01             	add    $0x1,%eax
    1a4b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1a4e:	a1 38 1e 00 00       	mov    0x1e38,%eax
    1a53:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a56:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a5a:	75 23                	jne    1a7f <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1a5c:	c7 45 f0 30 1e 00 00 	movl   $0x1e30,-0x10(%ebp)
    1a63:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a66:	a3 38 1e 00 00       	mov    %eax,0x1e38
    1a6b:	a1 38 1e 00 00       	mov    0x1e38,%eax
    1a70:	a3 30 1e 00 00       	mov    %eax,0x1e30
    base.s.size = 0;
    1a75:	c7 05 34 1e 00 00 00 	movl   $0x0,0x1e34
    1a7c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a82:	8b 00                	mov    (%eax),%eax
    1a84:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a8a:	8b 40 04             	mov    0x4(%eax),%eax
    1a8d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1a90:	77 4d                	ja     1adf <malloc+0xaa>
      if(p->s.size == nunits)
    1a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a95:	8b 40 04             	mov    0x4(%eax),%eax
    1a98:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1a9b:	75 0c                	jne    1aa9 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    1a9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aa0:	8b 10                	mov    (%eax),%edx
    1aa2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aa5:	89 10                	mov    %edx,(%eax)
    1aa7:	eb 26                	jmp    1acf <malloc+0x9a>
      else {
        p->s.size -= nunits;
    1aa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aac:	8b 40 04             	mov    0x4(%eax),%eax
    1aaf:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1ab2:	89 c2                	mov    %eax,%edx
    1ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ab7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1abd:	8b 40 04             	mov    0x4(%eax),%eax
    1ac0:	c1 e0 03             	shl    $0x3,%eax
    1ac3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ac9:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1acc:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1acf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ad2:	a3 38 1e 00 00       	mov    %eax,0x1e38
      return (void*)(p + 1);
    1ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ada:	83 c0 08             	add    $0x8,%eax
    1add:	eb 3b                	jmp    1b1a <malloc+0xe5>
    }
    if(p == freep)
    1adf:	a1 38 1e 00 00       	mov    0x1e38,%eax
    1ae4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1ae7:	75 1e                	jne    1b07 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1ae9:	83 ec 0c             	sub    $0xc,%esp
    1aec:	ff 75 ec             	pushl  -0x14(%ebp)
    1aef:	e8 dd fe ff ff       	call   19d1 <morecore>
    1af4:	83 c4 10             	add    $0x10,%esp
    1af7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1afa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1afe:	75 07                	jne    1b07 <malloc+0xd2>
        return 0;
    1b00:	b8 00 00 00 00       	mov    $0x0,%eax
    1b05:	eb 13                	jmp    1b1a <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b10:	8b 00                	mov    (%eax),%eax
    1b12:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1b15:	e9 6d ff ff ff       	jmp    1a87 <malloc+0x52>
  }
}
    1b1a:	c9                   	leave  
    1b1b:	c3                   	ret    
