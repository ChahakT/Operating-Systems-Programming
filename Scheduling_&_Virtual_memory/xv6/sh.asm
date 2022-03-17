
_sh:     file format elf32-i386


Disassembly of section .text:

00001000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
    1000:	f3 0f 1e fb          	endbr32 
    1004:	55                   	push   %ebp
    1005:	89 e5                	mov    %esp,%ebp
    1007:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    100a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    100e:	75 05                	jne    1015 <runcmd+0x15>
    exit();
    1010:	e8 35 0f 00 00       	call   1f4a <exit>

  switch(cmd->type){
    1015:	8b 45 08             	mov    0x8(%ebp),%eax
    1018:	8b 00                	mov    (%eax),%eax
    101a:	83 f8 05             	cmp    $0x5,%eax
    101d:	77 0a                	ja     1029 <runcmd+0x29>
    101f:	8b 04 85 cc 24 00 00 	mov    0x24cc(,%eax,4),%eax
    1026:	3e ff e0             	notrack jmp *%eax
  default:
    panic("runcmd");
    1029:	83 ec 0c             	sub    $0xc,%esp
    102c:	68 a0 24 00 00       	push   $0x24a0
    1031:	e8 73 03 00 00       	call   13a9 <panic>
    1036:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    1039:	8b 45 08             	mov    0x8(%ebp),%eax
    103c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(ecmd->argv[0] == 0)
    103f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1042:	8b 40 04             	mov    0x4(%eax),%eax
    1045:	85 c0                	test   %eax,%eax
    1047:	75 05                	jne    104e <runcmd+0x4e>
      exit();
    1049:	e8 fc 0e 00 00       	call   1f4a <exit>
    exec(ecmd->argv[0], ecmd->argv);
    104e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1051:	8d 50 04             	lea    0x4(%eax),%edx
    1054:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1057:	8b 40 04             	mov    0x4(%eax),%eax
    105a:	83 ec 08             	sub    $0x8,%esp
    105d:	52                   	push   %edx
    105e:	50                   	push   %eax
    105f:	e8 1e 0f 00 00       	call   1f82 <exec>
    1064:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    1067:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    106a:	8b 40 04             	mov    0x4(%eax),%eax
    106d:	83 ec 04             	sub    $0x4,%esp
    1070:	50                   	push   %eax
    1071:	68 a7 24 00 00       	push   $0x24a7
    1076:	6a 02                	push   $0x2
    1078:	e8 59 10 00 00       	call   20d6 <printf>
    107d:	83 c4 10             	add    $0x10,%esp
    break;
    1080:	e9 c6 01 00 00       	jmp    124b <runcmd+0x24b>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    1085:	8b 45 08             	mov    0x8(%ebp),%eax
    1088:	89 45 e8             	mov    %eax,-0x18(%ebp)
    close(rcmd->fd);
    108b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    108e:	8b 40 14             	mov    0x14(%eax),%eax
    1091:	83 ec 0c             	sub    $0xc,%esp
    1094:	50                   	push   %eax
    1095:	e8 d8 0e 00 00       	call   1f72 <close>
    109a:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
    109d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10a0:	8b 50 10             	mov    0x10(%eax),%edx
    10a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10a6:	8b 40 08             	mov    0x8(%eax),%eax
    10a9:	83 ec 08             	sub    $0x8,%esp
    10ac:	52                   	push   %edx
    10ad:	50                   	push   %eax
    10ae:	e8 d7 0e 00 00       	call   1f8a <open>
    10b3:	83 c4 10             	add    $0x10,%esp
    10b6:	85 c0                	test   %eax,%eax
    10b8:	79 1e                	jns    10d8 <runcmd+0xd8>
      printf(2, "open %s failed\n", rcmd->file);
    10ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10bd:	8b 40 08             	mov    0x8(%eax),%eax
    10c0:	83 ec 04             	sub    $0x4,%esp
    10c3:	50                   	push   %eax
    10c4:	68 b7 24 00 00       	push   $0x24b7
    10c9:	6a 02                	push   $0x2
    10cb:	e8 06 10 00 00       	call   20d6 <printf>
    10d0:	83 c4 10             	add    $0x10,%esp
      exit();
    10d3:	e8 72 0e 00 00       	call   1f4a <exit>
    }
    runcmd(rcmd->cmd);
    10d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10db:	8b 40 04             	mov    0x4(%eax),%eax
    10de:	83 ec 0c             	sub    $0xc,%esp
    10e1:	50                   	push   %eax
    10e2:	e8 19 ff ff ff       	call   1000 <runcmd>
    10e7:	83 c4 10             	add    $0x10,%esp
    break;
    10ea:	e9 5c 01 00 00       	jmp    124b <runcmd+0x24b>

  case LIST:
    lcmd = (struct listcmd*)cmd;
    10ef:	8b 45 08             	mov    0x8(%ebp),%eax
    10f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fork1() == 0)
    10f5:	e8 d3 02 00 00       	call   13cd <fork1>
    10fa:	85 c0                	test   %eax,%eax
    10fc:	75 12                	jne    1110 <runcmd+0x110>
      runcmd(lcmd->left);
    10fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1101:	8b 40 04             	mov    0x4(%eax),%eax
    1104:	83 ec 0c             	sub    $0xc,%esp
    1107:	50                   	push   %eax
    1108:	e8 f3 fe ff ff       	call   1000 <runcmd>
    110d:	83 c4 10             	add    $0x10,%esp
    wait();
    1110:	e8 3d 0e 00 00       	call   1f52 <wait>
    runcmd(lcmd->right);
    1115:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1118:	8b 40 08             	mov    0x8(%eax),%eax
    111b:	83 ec 0c             	sub    $0xc,%esp
    111e:	50                   	push   %eax
    111f:	e8 dc fe ff ff       	call   1000 <runcmd>
    1124:	83 c4 10             	add    $0x10,%esp
    break;
    1127:	e9 1f 01 00 00       	jmp    124b <runcmd+0x24b>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    112c:	8b 45 08             	mov    0x8(%ebp),%eax
    112f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pipe(p) < 0)
    1132:	83 ec 0c             	sub    $0xc,%esp
    1135:	8d 45 dc             	lea    -0x24(%ebp),%eax
    1138:	50                   	push   %eax
    1139:	e8 1c 0e 00 00       	call   1f5a <pipe>
    113e:	83 c4 10             	add    $0x10,%esp
    1141:	85 c0                	test   %eax,%eax
    1143:	79 10                	jns    1155 <runcmd+0x155>
      panic("pipe");
    1145:	83 ec 0c             	sub    $0xc,%esp
    1148:	68 c7 24 00 00       	push   $0x24c7
    114d:	e8 57 02 00 00       	call   13a9 <panic>
    1152:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
    1155:	e8 73 02 00 00       	call   13cd <fork1>
    115a:	85 c0                	test   %eax,%eax
    115c:	75 4c                	jne    11aa <runcmd+0x1aa>
      close(1);
    115e:	83 ec 0c             	sub    $0xc,%esp
    1161:	6a 01                	push   $0x1
    1163:	e8 0a 0e 00 00       	call   1f72 <close>
    1168:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
    116b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    116e:	83 ec 0c             	sub    $0xc,%esp
    1171:	50                   	push   %eax
    1172:	e8 4b 0e 00 00       	call   1fc2 <dup>
    1177:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
    117a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    117d:	83 ec 0c             	sub    $0xc,%esp
    1180:	50                   	push   %eax
    1181:	e8 ec 0d 00 00       	call   1f72 <close>
    1186:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
    1189:	8b 45 e0             	mov    -0x20(%ebp),%eax
    118c:	83 ec 0c             	sub    $0xc,%esp
    118f:	50                   	push   %eax
    1190:	e8 dd 0d 00 00       	call   1f72 <close>
    1195:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
    1198:	8b 45 ec             	mov    -0x14(%ebp),%eax
    119b:	8b 40 04             	mov    0x4(%eax),%eax
    119e:	83 ec 0c             	sub    $0xc,%esp
    11a1:	50                   	push   %eax
    11a2:	e8 59 fe ff ff       	call   1000 <runcmd>
    11a7:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
    11aa:	e8 1e 02 00 00       	call   13cd <fork1>
    11af:	85 c0                	test   %eax,%eax
    11b1:	75 4c                	jne    11ff <runcmd+0x1ff>
      close(0);
    11b3:	83 ec 0c             	sub    $0xc,%esp
    11b6:	6a 00                	push   $0x0
    11b8:	e8 b5 0d 00 00       	call   1f72 <close>
    11bd:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
    11c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
    11c3:	83 ec 0c             	sub    $0xc,%esp
    11c6:	50                   	push   %eax
    11c7:	e8 f6 0d 00 00       	call   1fc2 <dup>
    11cc:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
    11cf:	8b 45 dc             	mov    -0x24(%ebp),%eax
    11d2:	83 ec 0c             	sub    $0xc,%esp
    11d5:	50                   	push   %eax
    11d6:	e8 97 0d 00 00       	call   1f72 <close>
    11db:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
    11de:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11e1:	83 ec 0c             	sub    $0xc,%esp
    11e4:	50                   	push   %eax
    11e5:	e8 88 0d 00 00       	call   1f72 <close>
    11ea:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
    11ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11f0:	8b 40 08             	mov    0x8(%eax),%eax
    11f3:	83 ec 0c             	sub    $0xc,%esp
    11f6:	50                   	push   %eax
    11f7:	e8 04 fe ff ff       	call   1000 <runcmd>
    11fc:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
    11ff:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1202:	83 ec 0c             	sub    $0xc,%esp
    1205:	50                   	push   %eax
    1206:	e8 67 0d 00 00       	call   1f72 <close>
    120b:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
    120e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1211:	83 ec 0c             	sub    $0xc,%esp
    1214:	50                   	push   %eax
    1215:	e8 58 0d 00 00       	call   1f72 <close>
    121a:	83 c4 10             	add    $0x10,%esp
    wait();
    121d:	e8 30 0d 00 00       	call   1f52 <wait>
    wait();
    1222:	e8 2b 0d 00 00       	call   1f52 <wait>
    break;
    1227:	eb 22                	jmp    124b <runcmd+0x24b>

  case BACK:
    bcmd = (struct backcmd*)cmd;
    1229:	8b 45 08             	mov    0x8(%ebp),%eax
    122c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(fork1() == 0)
    122f:	e8 99 01 00 00       	call   13cd <fork1>
    1234:	85 c0                	test   %eax,%eax
    1236:	75 12                	jne    124a <runcmd+0x24a>
      runcmd(bcmd->cmd);
    1238:	8b 45 f4             	mov    -0xc(%ebp),%eax
    123b:	8b 40 04             	mov    0x4(%eax),%eax
    123e:	83 ec 0c             	sub    $0xc,%esp
    1241:	50                   	push   %eax
    1242:	e8 b9 fd ff ff       	call   1000 <runcmd>
    1247:	83 c4 10             	add    $0x10,%esp
    break;
    124a:	90                   	nop
  }
  exit();
    124b:	e8 fa 0c 00 00       	call   1f4a <exit>

00001250 <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
    1250:	f3 0f 1e fb          	endbr32 
    1254:	55                   	push   %ebp
    1255:	89 e5                	mov    %esp,%ebp
    1257:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
    125a:	83 ec 08             	sub    $0x8,%esp
    125d:	68 e4 24 00 00       	push   $0x24e4
    1262:	6a 02                	push   $0x2
    1264:	e8 6d 0e 00 00       	call   20d6 <printf>
    1269:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
    126c:	8b 45 0c             	mov    0xc(%ebp),%eax
    126f:	83 ec 04             	sub    $0x4,%esp
    1272:	50                   	push   %eax
    1273:	6a 00                	push   $0x0
    1275:	ff 75 08             	pushl  0x8(%ebp)
    1278:	e8 1a 0b 00 00       	call   1d97 <memset>
    127d:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
    1280:	83 ec 08             	sub    $0x8,%esp
    1283:	ff 75 0c             	pushl  0xc(%ebp)
    1286:	ff 75 08             	pushl  0x8(%ebp)
    1289:	e8 5e 0b 00 00       	call   1dec <gets>
    128e:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	0f b6 00             	movzbl (%eax),%eax
    1297:	84 c0                	test   %al,%al
    1299:	75 07                	jne    12a2 <getcmd+0x52>
    return -1;
    129b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12a0:	eb 05                	jmp    12a7 <getcmd+0x57>
  return 0;
    12a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12a7:	c9                   	leave  
    12a8:	c3                   	ret    

000012a9 <main>:

int
main(void)
{
    12a9:	f3 0f 1e fb          	endbr32 
    12ad:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    12b1:	83 e4 f0             	and    $0xfffffff0,%esp
    12b4:	ff 71 fc             	pushl  -0x4(%ecx)
    12b7:	55                   	push   %ebp
    12b8:	89 e5                	mov    %esp,%ebp
    12ba:	51                   	push   %ecx
    12bb:	83 ec 14             	sub    $0x14,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    12be:	eb 16                	jmp    12d6 <main+0x2d>
    if(fd >= 3){
    12c0:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    12c4:	7e 10                	jle    12d6 <main+0x2d>
      close(fd);
    12c6:	83 ec 0c             	sub    $0xc,%esp
    12c9:	ff 75 f4             	pushl  -0xc(%ebp)
    12cc:	e8 a1 0c 00 00       	call   1f72 <close>
    12d1:	83 c4 10             	add    $0x10,%esp
      break;
    12d4:	eb 1b                	jmp    12f1 <main+0x48>
  while((fd = open("console", O_RDWR)) >= 0){
    12d6:	83 ec 08             	sub    $0x8,%esp
    12d9:	6a 02                	push   $0x2
    12db:	68 e7 24 00 00       	push   $0x24e7
    12e0:	e8 a5 0c 00 00       	call   1f8a <open>
    12e5:	83 c4 10             	add    $0x10,%esp
    12e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12ef:	79 cf                	jns    12c0 <main+0x17>
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    12f1:	e9 94 00 00 00       	jmp    138a <main+0xe1>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    12f6:	0f b6 05 40 2a 00 00 	movzbl 0x2a40,%eax
    12fd:	3c 63                	cmp    $0x63,%al
    12ff:	75 5f                	jne    1360 <main+0xb7>
    1301:	0f b6 05 41 2a 00 00 	movzbl 0x2a41,%eax
    1308:	3c 64                	cmp    $0x64,%al
    130a:	75 54                	jne    1360 <main+0xb7>
    130c:	0f b6 05 42 2a 00 00 	movzbl 0x2a42,%eax
    1313:	3c 20                	cmp    $0x20,%al
    1315:	75 49                	jne    1360 <main+0xb7>
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
    1317:	83 ec 0c             	sub    $0xc,%esp
    131a:	68 40 2a 00 00       	push   $0x2a40
    131f:	e8 48 0a 00 00       	call   1d6c <strlen>
    1324:	83 c4 10             	add    $0x10,%esp
    1327:	83 e8 01             	sub    $0x1,%eax
    132a:	c6 80 40 2a 00 00 00 	movb   $0x0,0x2a40(%eax)
      if(chdir(buf+3) < 0)
    1331:	b8 43 2a 00 00       	mov    $0x2a43,%eax
    1336:	83 ec 0c             	sub    $0xc,%esp
    1339:	50                   	push   %eax
    133a:	e8 7b 0c 00 00       	call   1fba <chdir>
    133f:	83 c4 10             	add    $0x10,%esp
    1342:	85 c0                	test   %eax,%eax
    1344:	79 44                	jns    138a <main+0xe1>
        printf(2, "cannot cd %s\n", buf+3);
    1346:	b8 43 2a 00 00       	mov    $0x2a43,%eax
    134b:	83 ec 04             	sub    $0x4,%esp
    134e:	50                   	push   %eax
    134f:	68 ef 24 00 00       	push   $0x24ef
    1354:	6a 02                	push   $0x2
    1356:	e8 7b 0d 00 00       	call   20d6 <printf>
    135b:	83 c4 10             	add    $0x10,%esp
      continue;
    135e:	eb 2a                	jmp    138a <main+0xe1>
    }
    if(fork1() == 0)
    1360:	e8 68 00 00 00       	call   13cd <fork1>
    1365:	85 c0                	test   %eax,%eax
    1367:	75 1c                	jne    1385 <main+0xdc>
      runcmd(parsecmd(buf));
    1369:	83 ec 0c             	sub    $0xc,%esp
    136c:	68 40 2a 00 00       	push   $0x2a40
    1371:	e8 ce 03 00 00       	call   1744 <parsecmd>
    1376:	83 c4 10             	add    $0x10,%esp
    1379:	83 ec 0c             	sub    $0xc,%esp
    137c:	50                   	push   %eax
    137d:	e8 7e fc ff ff       	call   1000 <runcmd>
    1382:	83 c4 10             	add    $0x10,%esp
    wait();
    1385:	e8 c8 0b 00 00       	call   1f52 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
    138a:	83 ec 08             	sub    $0x8,%esp
    138d:	6a 64                	push   $0x64
    138f:	68 40 2a 00 00       	push   $0x2a40
    1394:	e8 b7 fe ff ff       	call   1250 <getcmd>
    1399:	83 c4 10             	add    $0x10,%esp
    139c:	85 c0                	test   %eax,%eax
    139e:	0f 89 52 ff ff ff    	jns    12f6 <main+0x4d>
  }
  exit();
    13a4:	e8 a1 0b 00 00       	call   1f4a <exit>

000013a9 <panic>:
}

void
panic(char *s)
{
    13a9:	f3 0f 1e fb          	endbr32 
    13ad:	55                   	push   %ebp
    13ae:	89 e5                	mov    %esp,%ebp
    13b0:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
    13b3:	83 ec 04             	sub    $0x4,%esp
    13b6:	ff 75 08             	pushl  0x8(%ebp)
    13b9:	68 fd 24 00 00       	push   $0x24fd
    13be:	6a 02                	push   $0x2
    13c0:	e8 11 0d 00 00       	call   20d6 <printf>
    13c5:	83 c4 10             	add    $0x10,%esp
  exit();
    13c8:	e8 7d 0b 00 00       	call   1f4a <exit>

000013cd <fork1>:
}

int
fork1(void)
{
    13cd:	f3 0f 1e fb          	endbr32 
    13d1:	55                   	push   %ebp
    13d2:	89 e5                	mov    %esp,%ebp
    13d4:	83 ec 18             	sub    $0x18,%esp
  int pid;

  pid = fork();
    13d7:	e8 66 0b 00 00       	call   1f42 <fork>
    13dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
    13df:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    13e3:	75 10                	jne    13f5 <fork1+0x28>
    panic("fork");
    13e5:	83 ec 0c             	sub    $0xc,%esp
    13e8:	68 01 25 00 00       	push   $0x2501
    13ed:	e8 b7 ff ff ff       	call   13a9 <panic>
    13f2:	83 c4 10             	add    $0x10,%esp
  return pid;
    13f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    13f8:	c9                   	leave  
    13f9:	c3                   	ret    

000013fa <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
    13fa:	f3 0f 1e fb          	endbr32 
    13fe:	55                   	push   %ebp
    13ff:	89 e5                	mov    %esp,%ebp
    1401:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1404:	83 ec 0c             	sub    $0xc,%esp
    1407:	6a 54                	push   $0x54
    1409:	e8 a8 0f 00 00       	call   23b6 <malloc>
    140e:	83 c4 10             	add    $0x10,%esp
    1411:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
    1414:	83 ec 04             	sub    $0x4,%esp
    1417:	6a 54                	push   $0x54
    1419:	6a 00                	push   $0x0
    141b:	ff 75 f4             	pushl  -0xc(%ebp)
    141e:	e8 74 09 00 00       	call   1d97 <memset>
    1423:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
    1426:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1429:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
    142f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1432:	c9                   	leave  
    1433:	c3                   	ret    

00001434 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
    1434:	f3 0f 1e fb          	endbr32 
    1438:	55                   	push   %ebp
    1439:	89 e5                	mov    %esp,%ebp
    143b:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
    143e:	83 ec 0c             	sub    $0xc,%esp
    1441:	6a 18                	push   $0x18
    1443:	e8 6e 0f 00 00       	call   23b6 <malloc>
    1448:	83 c4 10             	add    $0x10,%esp
    144b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
    144e:	83 ec 04             	sub    $0x4,%esp
    1451:	6a 18                	push   $0x18
    1453:	6a 00                	push   $0x0
    1455:	ff 75 f4             	pushl  -0xc(%ebp)
    1458:	e8 3a 09 00 00       	call   1d97 <memset>
    145d:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
    1460:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1463:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
    1469:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146c:	8b 55 08             	mov    0x8(%ebp),%edx
    146f:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
    1472:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1475:	8b 55 0c             	mov    0xc(%ebp),%edx
    1478:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
    147b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147e:	8b 55 10             	mov    0x10(%ebp),%edx
    1481:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
    1484:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1487:	8b 55 14             	mov    0x14(%ebp),%edx
    148a:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
    148d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1490:	8b 55 18             	mov    0x18(%ebp),%edx
    1493:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
    1496:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1499:	c9                   	leave  
    149a:	c3                   	ret    

0000149b <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
    149b:	f3 0f 1e fb          	endbr32 
    149f:	55                   	push   %ebp
    14a0:	89 e5                	mov    %esp,%ebp
    14a2:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
    14a5:	83 ec 0c             	sub    $0xc,%esp
    14a8:	6a 0c                	push   $0xc
    14aa:	e8 07 0f 00 00       	call   23b6 <malloc>
    14af:	83 c4 10             	add    $0x10,%esp
    14b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
    14b5:	83 ec 04             	sub    $0x4,%esp
    14b8:	6a 0c                	push   $0xc
    14ba:	6a 00                	push   $0x0
    14bc:	ff 75 f4             	pushl  -0xc(%ebp)
    14bf:	e8 d3 08 00 00       	call   1d97 <memset>
    14c4:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
    14c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ca:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
    14d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d3:	8b 55 08             	mov    0x8(%ebp),%edx
    14d6:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
    14d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14dc:	8b 55 0c             	mov    0xc(%ebp),%edx
    14df:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
    14e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    14e5:	c9                   	leave  
    14e6:	c3                   	ret    

000014e7 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
    14e7:	f3 0f 1e fb          	endbr32 
    14eb:	55                   	push   %ebp
    14ec:	89 e5                	mov    %esp,%ebp
    14ee:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    14f1:	83 ec 0c             	sub    $0xc,%esp
    14f4:	6a 0c                	push   $0xc
    14f6:	e8 bb 0e 00 00       	call   23b6 <malloc>
    14fb:	83 c4 10             	add    $0x10,%esp
    14fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
    1501:	83 ec 04             	sub    $0x4,%esp
    1504:	6a 0c                	push   $0xc
    1506:	6a 00                	push   $0x0
    1508:	ff 75 f4             	pushl  -0xc(%ebp)
    150b:	e8 87 08 00 00       	call   1d97 <memset>
    1510:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
    1513:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1516:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
    151c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151f:	8b 55 08             	mov    0x8(%ebp),%edx
    1522:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
    1525:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1528:	8b 55 0c             	mov    0xc(%ebp),%edx
    152b:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
    152e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1531:	c9                   	leave  
    1532:	c3                   	ret    

00001533 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
    1533:	f3 0f 1e fb          	endbr32 
    1537:	55                   	push   %ebp
    1538:	89 e5                	mov    %esp,%ebp
    153a:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    153d:	83 ec 0c             	sub    $0xc,%esp
    1540:	6a 08                	push   $0x8
    1542:	e8 6f 0e 00 00       	call   23b6 <malloc>
    1547:	83 c4 10             	add    $0x10,%esp
    154a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
    154d:	83 ec 04             	sub    $0x4,%esp
    1550:	6a 08                	push   $0x8
    1552:	6a 00                	push   $0x0
    1554:	ff 75 f4             	pushl  -0xc(%ebp)
    1557:	e8 3b 08 00 00       	call   1d97 <memset>
    155c:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
    155f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1562:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
    1568:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156b:	8b 55 08             	mov    0x8(%ebp),%edx
    156e:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
    1571:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1574:	c9                   	leave  
    1575:	c3                   	ret    

00001576 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
    1576:	f3 0f 1e fb          	endbr32 
    157a:	55                   	push   %ebp
    157b:	89 e5                	mov    %esp,%ebp
    157d:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;

  s = *ps;
    1580:	8b 45 08             	mov    0x8(%ebp),%eax
    1583:	8b 00                	mov    (%eax),%eax
    1585:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
    1588:	eb 04                	jmp    158e <gettoken+0x18>
    s++;
    158a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
    158e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1591:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1594:	73 1e                	jae    15b4 <gettoken+0x3e>
    1596:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1599:	0f b6 00             	movzbl (%eax),%eax
    159c:	0f be c0             	movsbl %al,%eax
    159f:	83 ec 08             	sub    $0x8,%esp
    15a2:	50                   	push   %eax
    15a3:	68 18 2a 00 00       	push   $0x2a18
    15a8:	e8 08 08 00 00       	call   1db5 <strchr>
    15ad:	83 c4 10             	add    $0x10,%esp
    15b0:	85 c0                	test   %eax,%eax
    15b2:	75 d6                	jne    158a <gettoken+0x14>
  if(q)
    15b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    15b8:	74 08                	je     15c2 <gettoken+0x4c>
    *q = s;
    15ba:	8b 45 10             	mov    0x10(%ebp),%eax
    15bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    15c0:	89 10                	mov    %edx,(%eax)
  ret = *s;
    15c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c5:	0f b6 00             	movzbl (%eax),%eax
    15c8:	0f be c0             	movsbl %al,%eax
    15cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
    15ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d1:	0f b6 00             	movzbl (%eax),%eax
    15d4:	0f be c0             	movsbl %al,%eax
    15d7:	83 f8 7c             	cmp    $0x7c,%eax
    15da:	74 2c                	je     1608 <gettoken+0x92>
    15dc:	83 f8 7c             	cmp    $0x7c,%eax
    15df:	7f 48                	jg     1629 <gettoken+0xb3>
    15e1:	83 f8 3e             	cmp    $0x3e,%eax
    15e4:	74 28                	je     160e <gettoken+0x98>
    15e6:	83 f8 3e             	cmp    $0x3e,%eax
    15e9:	7f 3e                	jg     1629 <gettoken+0xb3>
    15eb:	83 f8 3c             	cmp    $0x3c,%eax
    15ee:	7f 39                	jg     1629 <gettoken+0xb3>
    15f0:	83 f8 3b             	cmp    $0x3b,%eax
    15f3:	7d 13                	jge    1608 <gettoken+0x92>
    15f5:	83 f8 29             	cmp    $0x29,%eax
    15f8:	7f 2f                	jg     1629 <gettoken+0xb3>
    15fa:	83 f8 28             	cmp    $0x28,%eax
    15fd:	7d 09                	jge    1608 <gettoken+0x92>
    15ff:	85 c0                	test   %eax,%eax
    1601:	74 79                	je     167c <gettoken+0x106>
    1603:	83 f8 26             	cmp    $0x26,%eax
    1606:	75 21                	jne    1629 <gettoken+0xb3>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    1608:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
    160c:	eb 75                	jmp    1683 <gettoken+0x10d>
  case '>':
    s++;
    160e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
    1612:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1615:	0f b6 00             	movzbl (%eax),%eax
    1618:	3c 3e                	cmp    $0x3e,%al
    161a:	75 63                	jne    167f <gettoken+0x109>
      ret = '+';
    161c:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
    1623:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
    1627:	eb 56                	jmp    167f <gettoken+0x109>
  default:
    ret = 'a';
    1629:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    1630:	eb 04                	jmp    1636 <gettoken+0xc0>
      s++;
    1632:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    1636:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1639:	3b 45 0c             	cmp    0xc(%ebp),%eax
    163c:	73 44                	jae    1682 <gettoken+0x10c>
    163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1641:	0f b6 00             	movzbl (%eax),%eax
    1644:	0f be c0             	movsbl %al,%eax
    1647:	83 ec 08             	sub    $0x8,%esp
    164a:	50                   	push   %eax
    164b:	68 18 2a 00 00       	push   $0x2a18
    1650:	e8 60 07 00 00       	call   1db5 <strchr>
    1655:	83 c4 10             	add    $0x10,%esp
    1658:	85 c0                	test   %eax,%eax
    165a:	75 26                	jne    1682 <gettoken+0x10c>
    165c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165f:	0f b6 00             	movzbl (%eax),%eax
    1662:	0f be c0             	movsbl %al,%eax
    1665:	83 ec 08             	sub    $0x8,%esp
    1668:	50                   	push   %eax
    1669:	68 20 2a 00 00       	push   $0x2a20
    166e:	e8 42 07 00 00       	call   1db5 <strchr>
    1673:	83 c4 10             	add    $0x10,%esp
    1676:	85 c0                	test   %eax,%eax
    1678:	74 b8                	je     1632 <gettoken+0xbc>
    break;
    167a:	eb 06                	jmp    1682 <gettoken+0x10c>
    break;
    167c:	90                   	nop
    167d:	eb 04                	jmp    1683 <gettoken+0x10d>
    break;
    167f:	90                   	nop
    1680:	eb 01                	jmp    1683 <gettoken+0x10d>
    break;
    1682:	90                   	nop
  }
  if(eq)
    1683:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1687:	74 0e                	je     1697 <gettoken+0x121>
    *eq = s;
    1689:	8b 45 14             	mov    0x14(%ebp),%eax
    168c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    168f:	89 10                	mov    %edx,(%eax)

  while(s < es && strchr(whitespace, *s))
    1691:	eb 04                	jmp    1697 <gettoken+0x121>
    s++;
    1693:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
    1697:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    169d:	73 1e                	jae    16bd <gettoken+0x147>
    169f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a2:	0f b6 00             	movzbl (%eax),%eax
    16a5:	0f be c0             	movsbl %al,%eax
    16a8:	83 ec 08             	sub    $0x8,%esp
    16ab:	50                   	push   %eax
    16ac:	68 18 2a 00 00       	push   $0x2a18
    16b1:	e8 ff 06 00 00       	call   1db5 <strchr>
    16b6:	83 c4 10             	add    $0x10,%esp
    16b9:	85 c0                	test   %eax,%eax
    16bb:	75 d6                	jne    1693 <gettoken+0x11d>
  *ps = s;
    16bd:	8b 45 08             	mov    0x8(%ebp),%eax
    16c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    16c3:	89 10                	mov    %edx,(%eax)
  return ret;
    16c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    16c8:	c9                   	leave  
    16c9:	c3                   	ret    

000016ca <peek>:

int
peek(char **ps, char *es, char *toks)
{
    16ca:	f3 0f 1e fb          	endbr32 
    16ce:	55                   	push   %ebp
    16cf:	89 e5                	mov    %esp,%ebp
    16d1:	83 ec 18             	sub    $0x18,%esp
  char *s;

  s = *ps;
    16d4:	8b 45 08             	mov    0x8(%ebp),%eax
    16d7:	8b 00                	mov    (%eax),%eax
    16d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
    16dc:	eb 04                	jmp    16e2 <peek+0x18>
    s++;
    16de:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
    16e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    16e8:	73 1e                	jae    1708 <peek+0x3e>
    16ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ed:	0f b6 00             	movzbl (%eax),%eax
    16f0:	0f be c0             	movsbl %al,%eax
    16f3:	83 ec 08             	sub    $0x8,%esp
    16f6:	50                   	push   %eax
    16f7:	68 18 2a 00 00       	push   $0x2a18
    16fc:	e8 b4 06 00 00       	call   1db5 <strchr>
    1701:	83 c4 10             	add    $0x10,%esp
    1704:	85 c0                	test   %eax,%eax
    1706:	75 d6                	jne    16de <peek+0x14>
  *ps = s;
    1708:	8b 45 08             	mov    0x8(%ebp),%eax
    170b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    170e:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
    1710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1713:	0f b6 00             	movzbl (%eax),%eax
    1716:	84 c0                	test   %al,%al
    1718:	74 23                	je     173d <peek+0x73>
    171a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171d:	0f b6 00             	movzbl (%eax),%eax
    1720:	0f be c0             	movsbl %al,%eax
    1723:	83 ec 08             	sub    $0x8,%esp
    1726:	50                   	push   %eax
    1727:	ff 75 10             	pushl  0x10(%ebp)
    172a:	e8 86 06 00 00       	call   1db5 <strchr>
    172f:	83 c4 10             	add    $0x10,%esp
    1732:	85 c0                	test   %eax,%eax
    1734:	74 07                	je     173d <peek+0x73>
    1736:	b8 01 00 00 00       	mov    $0x1,%eax
    173b:	eb 05                	jmp    1742 <peek+0x78>
    173d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1742:	c9                   	leave  
    1743:	c3                   	ret    

00001744 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
    1744:	f3 0f 1e fb          	endbr32 
    1748:	55                   	push   %ebp
    1749:	89 e5                	mov    %esp,%ebp
    174b:	53                   	push   %ebx
    174c:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
    174f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1752:	8b 45 08             	mov    0x8(%ebp),%eax
    1755:	83 ec 0c             	sub    $0xc,%esp
    1758:	50                   	push   %eax
    1759:	e8 0e 06 00 00       	call   1d6c <strlen>
    175e:	83 c4 10             	add    $0x10,%esp
    1761:	01 d8                	add    %ebx,%eax
    1763:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
    1766:	83 ec 08             	sub    $0x8,%esp
    1769:	ff 75 f4             	pushl  -0xc(%ebp)
    176c:	8d 45 08             	lea    0x8(%ebp),%eax
    176f:	50                   	push   %eax
    1770:	e8 61 00 00 00       	call   17d6 <parseline>
    1775:	83 c4 10             	add    $0x10,%esp
    1778:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
    177b:	83 ec 04             	sub    $0x4,%esp
    177e:	68 06 25 00 00       	push   $0x2506
    1783:	ff 75 f4             	pushl  -0xc(%ebp)
    1786:	8d 45 08             	lea    0x8(%ebp),%eax
    1789:	50                   	push   %eax
    178a:	e8 3b ff ff ff       	call   16ca <peek>
    178f:	83 c4 10             	add    $0x10,%esp
  if(s != es){
    1792:	8b 45 08             	mov    0x8(%ebp),%eax
    1795:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1798:	74 26                	je     17c0 <parsecmd+0x7c>
    printf(2, "leftovers: %s\n", s);
    179a:	8b 45 08             	mov    0x8(%ebp),%eax
    179d:	83 ec 04             	sub    $0x4,%esp
    17a0:	50                   	push   %eax
    17a1:	68 07 25 00 00       	push   $0x2507
    17a6:	6a 02                	push   $0x2
    17a8:	e8 29 09 00 00       	call   20d6 <printf>
    17ad:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
    17b0:	83 ec 0c             	sub    $0xc,%esp
    17b3:	68 16 25 00 00       	push   $0x2516
    17b8:	e8 ec fb ff ff       	call   13a9 <panic>
    17bd:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
    17c0:	83 ec 0c             	sub    $0xc,%esp
    17c3:	ff 75 f0             	pushl  -0x10(%ebp)
    17c6:	e8 03 04 00 00       	call   1bce <nulterminate>
    17cb:	83 c4 10             	add    $0x10,%esp
  return cmd;
    17ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    17d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    17d4:	c9                   	leave  
    17d5:	c3                   	ret    

000017d6 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
    17d6:	f3 0f 1e fb          	endbr32 
    17da:	55                   	push   %ebp
    17db:	89 e5                	mov    %esp,%ebp
    17dd:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
    17e0:	83 ec 08             	sub    $0x8,%esp
    17e3:	ff 75 0c             	pushl  0xc(%ebp)
    17e6:	ff 75 08             	pushl  0x8(%ebp)
    17e9:	e8 99 00 00 00       	call   1887 <parsepipe>
    17ee:	83 c4 10             	add    $0x10,%esp
    17f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
    17f4:	eb 23                	jmp    1819 <parseline+0x43>
    gettoken(ps, es, 0, 0);
    17f6:	6a 00                	push   $0x0
    17f8:	6a 00                	push   $0x0
    17fa:	ff 75 0c             	pushl  0xc(%ebp)
    17fd:	ff 75 08             	pushl  0x8(%ebp)
    1800:	e8 71 fd ff ff       	call   1576 <gettoken>
    1805:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
    1808:	83 ec 0c             	sub    $0xc,%esp
    180b:	ff 75 f4             	pushl  -0xc(%ebp)
    180e:	e8 20 fd ff ff       	call   1533 <backcmd>
    1813:	83 c4 10             	add    $0x10,%esp
    1816:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
    1819:	83 ec 04             	sub    $0x4,%esp
    181c:	68 1d 25 00 00       	push   $0x251d
    1821:	ff 75 0c             	pushl  0xc(%ebp)
    1824:	ff 75 08             	pushl  0x8(%ebp)
    1827:	e8 9e fe ff ff       	call   16ca <peek>
    182c:	83 c4 10             	add    $0x10,%esp
    182f:	85 c0                	test   %eax,%eax
    1831:	75 c3                	jne    17f6 <parseline+0x20>
  }
  if(peek(ps, es, ";")){
    1833:	83 ec 04             	sub    $0x4,%esp
    1836:	68 1f 25 00 00       	push   $0x251f
    183b:	ff 75 0c             	pushl  0xc(%ebp)
    183e:	ff 75 08             	pushl  0x8(%ebp)
    1841:	e8 84 fe ff ff       	call   16ca <peek>
    1846:	83 c4 10             	add    $0x10,%esp
    1849:	85 c0                	test   %eax,%eax
    184b:	74 35                	je     1882 <parseline+0xac>
    gettoken(ps, es, 0, 0);
    184d:	6a 00                	push   $0x0
    184f:	6a 00                	push   $0x0
    1851:	ff 75 0c             	pushl  0xc(%ebp)
    1854:	ff 75 08             	pushl  0x8(%ebp)
    1857:	e8 1a fd ff ff       	call   1576 <gettoken>
    185c:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
    185f:	83 ec 08             	sub    $0x8,%esp
    1862:	ff 75 0c             	pushl  0xc(%ebp)
    1865:	ff 75 08             	pushl  0x8(%ebp)
    1868:	e8 69 ff ff ff       	call   17d6 <parseline>
    186d:	83 c4 10             	add    $0x10,%esp
    1870:	83 ec 08             	sub    $0x8,%esp
    1873:	50                   	push   %eax
    1874:	ff 75 f4             	pushl  -0xc(%ebp)
    1877:	e8 6b fc ff ff       	call   14e7 <listcmd>
    187c:	83 c4 10             	add    $0x10,%esp
    187f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
    1882:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1885:	c9                   	leave  
    1886:	c3                   	ret    

00001887 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
    1887:	f3 0f 1e fb          	endbr32 
    188b:	55                   	push   %ebp
    188c:	89 e5                	mov    %esp,%ebp
    188e:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
    1891:	83 ec 08             	sub    $0x8,%esp
    1894:	ff 75 0c             	pushl  0xc(%ebp)
    1897:	ff 75 08             	pushl  0x8(%ebp)
    189a:	e8 f8 01 00 00       	call   1a97 <parseexec>
    189f:	83 c4 10             	add    $0x10,%esp
    18a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
    18a5:	83 ec 04             	sub    $0x4,%esp
    18a8:	68 21 25 00 00       	push   $0x2521
    18ad:	ff 75 0c             	pushl  0xc(%ebp)
    18b0:	ff 75 08             	pushl  0x8(%ebp)
    18b3:	e8 12 fe ff ff       	call   16ca <peek>
    18b8:	83 c4 10             	add    $0x10,%esp
    18bb:	85 c0                	test   %eax,%eax
    18bd:	74 35                	je     18f4 <parsepipe+0x6d>
    gettoken(ps, es, 0, 0);
    18bf:	6a 00                	push   $0x0
    18c1:	6a 00                	push   $0x0
    18c3:	ff 75 0c             	pushl  0xc(%ebp)
    18c6:	ff 75 08             	pushl  0x8(%ebp)
    18c9:	e8 a8 fc ff ff       	call   1576 <gettoken>
    18ce:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
    18d1:	83 ec 08             	sub    $0x8,%esp
    18d4:	ff 75 0c             	pushl  0xc(%ebp)
    18d7:	ff 75 08             	pushl  0x8(%ebp)
    18da:	e8 a8 ff ff ff       	call   1887 <parsepipe>
    18df:	83 c4 10             	add    $0x10,%esp
    18e2:	83 ec 08             	sub    $0x8,%esp
    18e5:	50                   	push   %eax
    18e6:	ff 75 f4             	pushl  -0xc(%ebp)
    18e9:	e8 ad fb ff ff       	call   149b <pipecmd>
    18ee:	83 c4 10             	add    $0x10,%esp
    18f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
    18f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    18f7:	c9                   	leave  
    18f8:	c3                   	ret    

000018f9 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
    18f9:	f3 0f 1e fb          	endbr32 
    18fd:	55                   	push   %ebp
    18fe:	89 e5                	mov    %esp,%ebp
    1900:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    1903:	e9 ba 00 00 00       	jmp    19c2 <parseredirs+0xc9>
    tok = gettoken(ps, es, 0, 0);
    1908:	6a 00                	push   $0x0
    190a:	6a 00                	push   $0x0
    190c:	ff 75 10             	pushl  0x10(%ebp)
    190f:	ff 75 0c             	pushl  0xc(%ebp)
    1912:	e8 5f fc ff ff       	call   1576 <gettoken>
    1917:	83 c4 10             	add    $0x10,%esp
    191a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
    191d:	8d 45 ec             	lea    -0x14(%ebp),%eax
    1920:	50                   	push   %eax
    1921:	8d 45 f0             	lea    -0x10(%ebp),%eax
    1924:	50                   	push   %eax
    1925:	ff 75 10             	pushl  0x10(%ebp)
    1928:	ff 75 0c             	pushl  0xc(%ebp)
    192b:	e8 46 fc ff ff       	call   1576 <gettoken>
    1930:	83 c4 10             	add    $0x10,%esp
    1933:	83 f8 61             	cmp    $0x61,%eax
    1936:	74 10                	je     1948 <parseredirs+0x4f>
      panic("missing file for redirection");
    1938:	83 ec 0c             	sub    $0xc,%esp
    193b:	68 23 25 00 00       	push   $0x2523
    1940:	e8 64 fa ff ff       	call   13a9 <panic>
    1945:	83 c4 10             	add    $0x10,%esp
    switch(tok){
    1948:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
    194c:	74 31                	je     197f <parseredirs+0x86>
    194e:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
    1952:	7f 6e                	jg     19c2 <parseredirs+0xc9>
    1954:	83 7d f4 2b          	cmpl   $0x2b,-0xc(%ebp)
    1958:	74 47                	je     19a1 <parseredirs+0xa8>
    195a:	83 7d f4 3c          	cmpl   $0x3c,-0xc(%ebp)
    195e:	75 62                	jne    19c2 <parseredirs+0xc9>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    1960:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1963:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1966:	83 ec 0c             	sub    $0xc,%esp
    1969:	6a 00                	push   $0x0
    196b:	6a 00                	push   $0x0
    196d:	52                   	push   %edx
    196e:	50                   	push   %eax
    196f:	ff 75 08             	pushl  0x8(%ebp)
    1972:	e8 bd fa ff ff       	call   1434 <redircmd>
    1977:	83 c4 20             	add    $0x20,%esp
    197a:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    197d:	eb 43                	jmp    19c2 <parseredirs+0xc9>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    197f:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1982:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1985:	83 ec 0c             	sub    $0xc,%esp
    1988:	6a 01                	push   $0x1
    198a:	68 01 02 00 00       	push   $0x201
    198f:	52                   	push   %edx
    1990:	50                   	push   %eax
    1991:	ff 75 08             	pushl  0x8(%ebp)
    1994:	e8 9b fa ff ff       	call   1434 <redircmd>
    1999:	83 c4 20             	add    $0x20,%esp
    199c:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    199f:	eb 21                	jmp    19c2 <parseredirs+0xc9>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    19a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    19a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19a7:	83 ec 0c             	sub    $0xc,%esp
    19aa:	6a 01                	push   $0x1
    19ac:	68 01 02 00 00       	push   $0x201
    19b1:	52                   	push   %edx
    19b2:	50                   	push   %eax
    19b3:	ff 75 08             	pushl  0x8(%ebp)
    19b6:	e8 79 fa ff ff       	call   1434 <redircmd>
    19bb:	83 c4 20             	add    $0x20,%esp
    19be:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    19c1:	90                   	nop
  while(peek(ps, es, "<>")){
    19c2:	83 ec 04             	sub    $0x4,%esp
    19c5:	68 40 25 00 00       	push   $0x2540
    19ca:	ff 75 10             	pushl  0x10(%ebp)
    19cd:	ff 75 0c             	pushl  0xc(%ebp)
    19d0:	e8 f5 fc ff ff       	call   16ca <peek>
    19d5:	83 c4 10             	add    $0x10,%esp
    19d8:	85 c0                	test   %eax,%eax
    19da:	0f 85 28 ff ff ff    	jne    1908 <parseredirs+0xf>
    }
  }
  return cmd;
    19e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
    19e3:	c9                   	leave  
    19e4:	c3                   	ret    

000019e5 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
    19e5:	f3 0f 1e fb          	endbr32 
    19e9:	55                   	push   %ebp
    19ea:	89 e5                	mov    %esp,%ebp
    19ec:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    19ef:	83 ec 04             	sub    $0x4,%esp
    19f2:	68 43 25 00 00       	push   $0x2543
    19f7:	ff 75 0c             	pushl  0xc(%ebp)
    19fa:	ff 75 08             	pushl  0x8(%ebp)
    19fd:	e8 c8 fc ff ff       	call   16ca <peek>
    1a02:	83 c4 10             	add    $0x10,%esp
    1a05:	85 c0                	test   %eax,%eax
    1a07:	75 10                	jne    1a19 <parseblock+0x34>
    panic("parseblock");
    1a09:	83 ec 0c             	sub    $0xc,%esp
    1a0c:	68 45 25 00 00       	push   $0x2545
    1a11:	e8 93 f9 ff ff       	call   13a9 <panic>
    1a16:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    1a19:	6a 00                	push   $0x0
    1a1b:	6a 00                	push   $0x0
    1a1d:	ff 75 0c             	pushl  0xc(%ebp)
    1a20:	ff 75 08             	pushl  0x8(%ebp)
    1a23:	e8 4e fb ff ff       	call   1576 <gettoken>
    1a28:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
    1a2b:	83 ec 08             	sub    $0x8,%esp
    1a2e:	ff 75 0c             	pushl  0xc(%ebp)
    1a31:	ff 75 08             	pushl  0x8(%ebp)
    1a34:	e8 9d fd ff ff       	call   17d6 <parseline>
    1a39:	83 c4 10             	add    $0x10,%esp
    1a3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
    1a3f:	83 ec 04             	sub    $0x4,%esp
    1a42:	68 50 25 00 00       	push   $0x2550
    1a47:	ff 75 0c             	pushl  0xc(%ebp)
    1a4a:	ff 75 08             	pushl  0x8(%ebp)
    1a4d:	e8 78 fc ff ff       	call   16ca <peek>
    1a52:	83 c4 10             	add    $0x10,%esp
    1a55:	85 c0                	test   %eax,%eax
    1a57:	75 10                	jne    1a69 <parseblock+0x84>
    panic("syntax - missing )");
    1a59:	83 ec 0c             	sub    $0xc,%esp
    1a5c:	68 52 25 00 00       	push   $0x2552
    1a61:	e8 43 f9 ff ff       	call   13a9 <panic>
    1a66:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    1a69:	6a 00                	push   $0x0
    1a6b:	6a 00                	push   $0x0
    1a6d:	ff 75 0c             	pushl  0xc(%ebp)
    1a70:	ff 75 08             	pushl  0x8(%ebp)
    1a73:	e8 fe fa ff ff       	call   1576 <gettoken>
    1a78:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
    1a7b:	83 ec 04             	sub    $0x4,%esp
    1a7e:	ff 75 0c             	pushl  0xc(%ebp)
    1a81:	ff 75 08             	pushl  0x8(%ebp)
    1a84:	ff 75 f4             	pushl  -0xc(%ebp)
    1a87:	e8 6d fe ff ff       	call   18f9 <parseredirs>
    1a8c:	83 c4 10             	add    $0x10,%esp
    1a8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
    1a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1a95:	c9                   	leave  
    1a96:	c3                   	ret    

00001a97 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
    1a97:	f3 0f 1e fb          	endbr32 
    1a9b:	55                   	push   %ebp
    1a9c:	89 e5                	mov    %esp,%ebp
    1a9e:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    1aa1:	83 ec 04             	sub    $0x4,%esp
    1aa4:	68 43 25 00 00       	push   $0x2543
    1aa9:	ff 75 0c             	pushl  0xc(%ebp)
    1aac:	ff 75 08             	pushl  0x8(%ebp)
    1aaf:	e8 16 fc ff ff       	call   16ca <peek>
    1ab4:	83 c4 10             	add    $0x10,%esp
    1ab7:	85 c0                	test   %eax,%eax
    1ab9:	74 16                	je     1ad1 <parseexec+0x3a>
    return parseblock(ps, es);
    1abb:	83 ec 08             	sub    $0x8,%esp
    1abe:	ff 75 0c             	pushl  0xc(%ebp)
    1ac1:	ff 75 08             	pushl  0x8(%ebp)
    1ac4:	e8 1c ff ff ff       	call   19e5 <parseblock>
    1ac9:	83 c4 10             	add    $0x10,%esp
    1acc:	e9 fb 00 00 00       	jmp    1bcc <parseexec+0x135>

  ret = execcmd();
    1ad1:	e8 24 f9 ff ff       	call   13fa <execcmd>
    1ad6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
    1ad9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1adc:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
    1adf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
    1ae6:	83 ec 04             	sub    $0x4,%esp
    1ae9:	ff 75 0c             	pushl  0xc(%ebp)
    1aec:	ff 75 08             	pushl  0x8(%ebp)
    1aef:	ff 75 f0             	pushl  -0x10(%ebp)
    1af2:	e8 02 fe ff ff       	call   18f9 <parseredirs>
    1af7:	83 c4 10             	add    $0x10,%esp
    1afa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
    1afd:	e9 87 00 00 00       	jmp    1b89 <parseexec+0xf2>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    1b02:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1b05:	50                   	push   %eax
    1b06:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1b09:	50                   	push   %eax
    1b0a:	ff 75 0c             	pushl  0xc(%ebp)
    1b0d:	ff 75 08             	pushl  0x8(%ebp)
    1b10:	e8 61 fa ff ff       	call   1576 <gettoken>
    1b15:	83 c4 10             	add    $0x10,%esp
    1b18:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1b1b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1b1f:	0f 84 84 00 00 00    	je     1ba9 <parseexec+0x112>
      break;
    if(tok != 'a')
    1b25:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
    1b29:	74 10                	je     1b3b <parseexec+0xa4>
      panic("syntax");
    1b2b:	83 ec 0c             	sub    $0xc,%esp
    1b2e:	68 16 25 00 00       	push   $0x2516
    1b33:	e8 71 f8 ff ff       	call   13a9 <panic>
    1b38:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
    1b3b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1b3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b41:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b44:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
    1b48:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1b4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b4e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1b51:	83 c1 08             	add    $0x8,%ecx
    1b54:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
    1b58:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
    1b5c:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1b60:	7e 10                	jle    1b72 <parseexec+0xdb>
      panic("too many args");
    1b62:	83 ec 0c             	sub    $0xc,%esp
    1b65:	68 65 25 00 00       	push   $0x2565
    1b6a:	e8 3a f8 ff ff       	call   13a9 <panic>
    1b6f:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
    1b72:	83 ec 04             	sub    $0x4,%esp
    1b75:	ff 75 0c             	pushl  0xc(%ebp)
    1b78:	ff 75 08             	pushl  0x8(%ebp)
    1b7b:	ff 75 f0             	pushl  -0x10(%ebp)
    1b7e:	e8 76 fd ff ff       	call   18f9 <parseredirs>
    1b83:	83 c4 10             	add    $0x10,%esp
    1b86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
    1b89:	83 ec 04             	sub    $0x4,%esp
    1b8c:	68 73 25 00 00       	push   $0x2573
    1b91:	ff 75 0c             	pushl  0xc(%ebp)
    1b94:	ff 75 08             	pushl  0x8(%ebp)
    1b97:	e8 2e fb ff ff       	call   16ca <peek>
    1b9c:	83 c4 10             	add    $0x10,%esp
    1b9f:	85 c0                	test   %eax,%eax
    1ba1:	0f 84 5b ff ff ff    	je     1b02 <parseexec+0x6b>
    1ba7:	eb 01                	jmp    1baa <parseexec+0x113>
      break;
    1ba9:	90                   	nop
  }
  cmd->argv[argc] = 0;
    1baa:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bad:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1bb0:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
    1bb7:	00 
  cmd->eargv[argc] = 0;
    1bb8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bbb:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1bbe:	83 c2 08             	add    $0x8,%edx
    1bc1:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
    1bc8:	00 
  return ret;
    1bc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1bcc:	c9                   	leave  
    1bcd:	c3                   	ret    

00001bce <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    1bce:	f3 0f 1e fb          	endbr32 
    1bd2:	55                   	push   %ebp
    1bd3:	89 e5                	mov    %esp,%ebp
    1bd5:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    1bd8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1bdc:	75 0a                	jne    1be8 <nulterminate+0x1a>
    return 0;
    1bde:	b8 00 00 00 00       	mov    $0x0,%eax
    1be3:	e9 e5 00 00 00       	jmp    1ccd <nulterminate+0xff>

  switch(cmd->type){
    1be8:	8b 45 08             	mov    0x8(%ebp),%eax
    1beb:	8b 00                	mov    (%eax),%eax
    1bed:	83 f8 05             	cmp    $0x5,%eax
    1bf0:	0f 87 d4 00 00 00    	ja     1cca <nulterminate+0xfc>
    1bf6:	8b 04 85 78 25 00 00 	mov    0x2578(,%eax,4),%eax
    1bfd:	3e ff e0             	notrack jmp *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    1c00:	8b 45 08             	mov    0x8(%ebp),%eax
    1c03:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(i=0; ecmd->argv[i]; i++)
    1c06:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c0d:	eb 14                	jmp    1c23 <nulterminate+0x55>
      *ecmd->eargv[i] = 0;
    1c0f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c12:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c15:	83 c2 08             	add    $0x8,%edx
    1c18:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
    1c1c:	c6 00 00             	movb   $0x0,(%eax)
    for(i=0; ecmd->argv[i]; i++)
    1c1f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c23:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c26:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c29:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
    1c2d:	85 c0                	test   %eax,%eax
    1c2f:	75 de                	jne    1c0f <nulterminate+0x41>
    break;
    1c31:	e9 94 00 00 00       	jmp    1cca <nulterminate+0xfc>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    1c36:	8b 45 08             	mov    0x8(%ebp),%eax
    1c39:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(rcmd->cmd);
    1c3c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c3f:	8b 40 04             	mov    0x4(%eax),%eax
    1c42:	83 ec 0c             	sub    $0xc,%esp
    1c45:	50                   	push   %eax
    1c46:	e8 83 ff ff ff       	call   1bce <nulterminate>
    1c4b:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
    1c4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c51:	8b 40 0c             	mov    0xc(%eax),%eax
    1c54:	c6 00 00             	movb   $0x0,(%eax)
    break;
    1c57:	eb 71                	jmp    1cca <nulterminate+0xfc>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    1c59:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
    1c5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c62:	8b 40 04             	mov    0x4(%eax),%eax
    1c65:	83 ec 0c             	sub    $0xc,%esp
    1c68:	50                   	push   %eax
    1c69:	e8 60 ff ff ff       	call   1bce <nulterminate>
    1c6e:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
    1c71:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c74:	8b 40 08             	mov    0x8(%eax),%eax
    1c77:	83 ec 0c             	sub    $0xc,%esp
    1c7a:	50                   	push   %eax
    1c7b:	e8 4e ff ff ff       	call   1bce <nulterminate>
    1c80:	83 c4 10             	add    $0x10,%esp
    break;
    1c83:	eb 45                	jmp    1cca <nulterminate+0xfc>

  case LIST:
    lcmd = (struct listcmd*)cmd;
    1c85:	8b 45 08             	mov    0x8(%ebp),%eax
    1c88:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(lcmd->left);
    1c8b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c8e:	8b 40 04             	mov    0x4(%eax),%eax
    1c91:	83 ec 0c             	sub    $0xc,%esp
    1c94:	50                   	push   %eax
    1c95:	e8 34 ff ff ff       	call   1bce <nulterminate>
    1c9a:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
    1c9d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ca0:	8b 40 08             	mov    0x8(%eax),%eax
    1ca3:	83 ec 0c             	sub    $0xc,%esp
    1ca6:	50                   	push   %eax
    1ca7:	e8 22 ff ff ff       	call   1bce <nulterminate>
    1cac:	83 c4 10             	add    $0x10,%esp
    break;
    1caf:	eb 19                	jmp    1cca <nulterminate+0xfc>

  case BACK:
    bcmd = (struct backcmd*)cmd;
    1cb1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    nulterminate(bcmd->cmd);
    1cb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cba:	8b 40 04             	mov    0x4(%eax),%eax
    1cbd:	83 ec 0c             	sub    $0xc,%esp
    1cc0:	50                   	push   %eax
    1cc1:	e8 08 ff ff ff       	call   1bce <nulterminate>
    1cc6:	83 c4 10             	add    $0x10,%esp
    break;
    1cc9:	90                   	nop
  }
  return cmd;
    1cca:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1ccd:	c9                   	leave  
    1cce:	c3                   	ret    

00001ccf <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1ccf:	55                   	push   %ebp
    1cd0:	89 e5                	mov    %esp,%ebp
    1cd2:	57                   	push   %edi
    1cd3:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1cd4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cd7:	8b 55 10             	mov    0x10(%ebp),%edx
    1cda:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cdd:	89 cb                	mov    %ecx,%ebx
    1cdf:	89 df                	mov    %ebx,%edi
    1ce1:	89 d1                	mov    %edx,%ecx
    1ce3:	fc                   	cld    
    1ce4:	f3 aa                	rep stos %al,%es:(%edi)
    1ce6:	89 ca                	mov    %ecx,%edx
    1ce8:	89 fb                	mov    %edi,%ebx
    1cea:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1ced:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1cf0:	90                   	nop
    1cf1:	5b                   	pop    %ebx
    1cf2:	5f                   	pop    %edi
    1cf3:	5d                   	pop    %ebp
    1cf4:	c3                   	ret    

00001cf5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1cf5:	f3 0f 1e fb          	endbr32 
    1cf9:	55                   	push   %ebp
    1cfa:	89 e5                	mov    %esp,%ebp
    1cfc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1cff:	8b 45 08             	mov    0x8(%ebp),%eax
    1d02:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1d05:	90                   	nop
    1d06:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d09:	8d 42 01             	lea    0x1(%edx),%eax
    1d0c:	89 45 0c             	mov    %eax,0xc(%ebp)
    1d0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d12:	8d 48 01             	lea    0x1(%eax),%ecx
    1d15:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1d18:	0f b6 12             	movzbl (%edx),%edx
    1d1b:	88 10                	mov    %dl,(%eax)
    1d1d:	0f b6 00             	movzbl (%eax),%eax
    1d20:	84 c0                	test   %al,%al
    1d22:	75 e2                	jne    1d06 <strcpy+0x11>
    ;
  return os;
    1d24:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1d27:	c9                   	leave  
    1d28:	c3                   	ret    

00001d29 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1d29:	f3 0f 1e fb          	endbr32 
    1d2d:	55                   	push   %ebp
    1d2e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1d30:	eb 08                	jmp    1d3a <strcmp+0x11>
    p++, q++;
    1d32:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1d36:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    1d3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3d:	0f b6 00             	movzbl (%eax),%eax
    1d40:	84 c0                	test   %al,%al
    1d42:	74 10                	je     1d54 <strcmp+0x2b>
    1d44:	8b 45 08             	mov    0x8(%ebp),%eax
    1d47:	0f b6 10             	movzbl (%eax),%edx
    1d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d4d:	0f b6 00             	movzbl (%eax),%eax
    1d50:	38 c2                	cmp    %al,%dl
    1d52:	74 de                	je     1d32 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    1d54:	8b 45 08             	mov    0x8(%ebp),%eax
    1d57:	0f b6 00             	movzbl (%eax),%eax
    1d5a:	0f b6 d0             	movzbl %al,%edx
    1d5d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d60:	0f b6 00             	movzbl (%eax),%eax
    1d63:	0f b6 c0             	movzbl %al,%eax
    1d66:	29 c2                	sub    %eax,%edx
    1d68:	89 d0                	mov    %edx,%eax
}
    1d6a:	5d                   	pop    %ebp
    1d6b:	c3                   	ret    

00001d6c <strlen>:

uint
strlen(const char *s)
{
    1d6c:	f3 0f 1e fb          	endbr32 
    1d70:	55                   	push   %ebp
    1d71:	89 e5                	mov    %esp,%ebp
    1d73:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1d76:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1d7d:	eb 04                	jmp    1d83 <strlen+0x17>
    1d7f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1d83:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1d86:	8b 45 08             	mov    0x8(%ebp),%eax
    1d89:	01 d0                	add    %edx,%eax
    1d8b:	0f b6 00             	movzbl (%eax),%eax
    1d8e:	84 c0                	test   %al,%al
    1d90:	75 ed                	jne    1d7f <strlen+0x13>
    ;
  return n;
    1d92:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1d95:	c9                   	leave  
    1d96:	c3                   	ret    

00001d97 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1d97:	f3 0f 1e fb          	endbr32 
    1d9b:	55                   	push   %ebp
    1d9c:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1d9e:	8b 45 10             	mov    0x10(%ebp),%eax
    1da1:	50                   	push   %eax
    1da2:	ff 75 0c             	pushl  0xc(%ebp)
    1da5:	ff 75 08             	pushl  0x8(%ebp)
    1da8:	e8 22 ff ff ff       	call   1ccf <stosb>
    1dad:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1db0:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1db3:	c9                   	leave  
    1db4:	c3                   	ret    

00001db5 <strchr>:

char*
strchr(const char *s, char c)
{
    1db5:	f3 0f 1e fb          	endbr32 
    1db9:	55                   	push   %ebp
    1dba:	89 e5                	mov    %esp,%ebp
    1dbc:	83 ec 04             	sub    $0x4,%esp
    1dbf:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dc2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1dc5:	eb 14                	jmp    1ddb <strchr+0x26>
    if(*s == c)
    1dc7:	8b 45 08             	mov    0x8(%ebp),%eax
    1dca:	0f b6 00             	movzbl (%eax),%eax
    1dcd:	38 45 fc             	cmp    %al,-0x4(%ebp)
    1dd0:	75 05                	jne    1dd7 <strchr+0x22>
      return (char*)s;
    1dd2:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd5:	eb 13                	jmp    1dea <strchr+0x35>
  for(; *s; s++)
    1dd7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1ddb:	8b 45 08             	mov    0x8(%ebp),%eax
    1dde:	0f b6 00             	movzbl (%eax),%eax
    1de1:	84 c0                	test   %al,%al
    1de3:	75 e2                	jne    1dc7 <strchr+0x12>
  return 0;
    1de5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1dea:	c9                   	leave  
    1deb:	c3                   	ret    

00001dec <gets>:

char*
gets(char *buf, int max)
{
    1dec:	f3 0f 1e fb          	endbr32 
    1df0:	55                   	push   %ebp
    1df1:	89 e5                	mov    %esp,%ebp
    1df3:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1df6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1dfd:	eb 42                	jmp    1e41 <gets+0x55>
    cc = read(0, &c, 1);
    1dff:	83 ec 04             	sub    $0x4,%esp
    1e02:	6a 01                	push   $0x1
    1e04:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1e07:	50                   	push   %eax
    1e08:	6a 00                	push   $0x0
    1e0a:	e8 53 01 00 00       	call   1f62 <read>
    1e0f:	83 c4 10             	add    $0x10,%esp
    1e12:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1e15:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e19:	7e 33                	jle    1e4e <gets+0x62>
      break;
    buf[i++] = c;
    1e1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e1e:	8d 50 01             	lea    0x1(%eax),%edx
    1e21:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1e24:	89 c2                	mov    %eax,%edx
    1e26:	8b 45 08             	mov    0x8(%ebp),%eax
    1e29:	01 c2                	add    %eax,%edx
    1e2b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1e2f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1e31:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1e35:	3c 0a                	cmp    $0xa,%al
    1e37:	74 16                	je     1e4f <gets+0x63>
    1e39:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1e3d:	3c 0d                	cmp    $0xd,%al
    1e3f:	74 0e                	je     1e4f <gets+0x63>
  for(i=0; i+1 < max; ){
    1e41:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e44:	83 c0 01             	add    $0x1,%eax
    1e47:	39 45 0c             	cmp    %eax,0xc(%ebp)
    1e4a:	7f b3                	jg     1dff <gets+0x13>
    1e4c:	eb 01                	jmp    1e4f <gets+0x63>
      break;
    1e4e:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1e4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e52:	8b 45 08             	mov    0x8(%ebp),%eax
    1e55:	01 d0                	add    %edx,%eax
    1e57:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1e5a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1e5d:	c9                   	leave  
    1e5e:	c3                   	ret    

00001e5f <stat>:

int
stat(const char *n, struct stat *st)
{
    1e5f:	f3 0f 1e fb          	endbr32 
    1e63:	55                   	push   %ebp
    1e64:	89 e5                	mov    %esp,%ebp
    1e66:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1e69:	83 ec 08             	sub    $0x8,%esp
    1e6c:	6a 00                	push   $0x0
    1e6e:	ff 75 08             	pushl  0x8(%ebp)
    1e71:	e8 14 01 00 00       	call   1f8a <open>
    1e76:	83 c4 10             	add    $0x10,%esp
    1e79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1e7c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e80:	79 07                	jns    1e89 <stat+0x2a>
    return -1;
    1e82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1e87:	eb 25                	jmp    1eae <stat+0x4f>
  r = fstat(fd, st);
    1e89:	83 ec 08             	sub    $0x8,%esp
    1e8c:	ff 75 0c             	pushl  0xc(%ebp)
    1e8f:	ff 75 f4             	pushl  -0xc(%ebp)
    1e92:	e8 0b 01 00 00       	call   1fa2 <fstat>
    1e97:	83 c4 10             	add    $0x10,%esp
    1e9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1e9d:	83 ec 0c             	sub    $0xc,%esp
    1ea0:	ff 75 f4             	pushl  -0xc(%ebp)
    1ea3:	e8 ca 00 00 00       	call   1f72 <close>
    1ea8:	83 c4 10             	add    $0x10,%esp
  return r;
    1eab:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1eae:	c9                   	leave  
    1eaf:	c3                   	ret    

00001eb0 <atoi>:

int
atoi(const char *s)
{
    1eb0:	f3 0f 1e fb          	endbr32 
    1eb4:	55                   	push   %ebp
    1eb5:	89 e5                	mov    %esp,%ebp
    1eb7:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1eba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1ec1:	eb 25                	jmp    1ee8 <atoi+0x38>
    n = n*10 + *s++ - '0';
    1ec3:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1ec6:	89 d0                	mov    %edx,%eax
    1ec8:	c1 e0 02             	shl    $0x2,%eax
    1ecb:	01 d0                	add    %edx,%eax
    1ecd:	01 c0                	add    %eax,%eax
    1ecf:	89 c1                	mov    %eax,%ecx
    1ed1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed4:	8d 50 01             	lea    0x1(%eax),%edx
    1ed7:	89 55 08             	mov    %edx,0x8(%ebp)
    1eda:	0f b6 00             	movzbl (%eax),%eax
    1edd:	0f be c0             	movsbl %al,%eax
    1ee0:	01 c8                	add    %ecx,%eax
    1ee2:	83 e8 30             	sub    $0x30,%eax
    1ee5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1ee8:	8b 45 08             	mov    0x8(%ebp),%eax
    1eeb:	0f b6 00             	movzbl (%eax),%eax
    1eee:	3c 2f                	cmp    $0x2f,%al
    1ef0:	7e 0a                	jle    1efc <atoi+0x4c>
    1ef2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef5:	0f b6 00             	movzbl (%eax),%eax
    1ef8:	3c 39                	cmp    $0x39,%al
    1efa:	7e c7                	jle    1ec3 <atoi+0x13>
  return n;
    1efc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1eff:	c9                   	leave  
    1f00:	c3                   	ret    

00001f01 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1f01:	f3 0f 1e fb          	endbr32 
    1f05:	55                   	push   %ebp
    1f06:	89 e5                	mov    %esp,%ebp
    1f08:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    1f0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1f11:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f14:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1f17:	eb 17                	jmp    1f30 <memmove+0x2f>
    *dst++ = *src++;
    1f19:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1f1c:	8d 42 01             	lea    0x1(%edx),%eax
    1f1f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f22:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1f25:	8d 48 01             	lea    0x1(%eax),%ecx
    1f28:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    1f2b:	0f b6 12             	movzbl (%edx),%edx
    1f2e:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    1f30:	8b 45 10             	mov    0x10(%ebp),%eax
    1f33:	8d 50 ff             	lea    -0x1(%eax),%edx
    1f36:	89 55 10             	mov    %edx,0x10(%ebp)
    1f39:	85 c0                	test   %eax,%eax
    1f3b:	7f dc                	jg     1f19 <memmove+0x18>
  return vdst;
    1f3d:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1f40:	c9                   	leave  
    1f41:	c3                   	ret    

00001f42 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1f42:	b8 01 00 00 00       	mov    $0x1,%eax
    1f47:	cd 40                	int    $0x40
    1f49:	c3                   	ret    

00001f4a <exit>:
SYSCALL(exit)
    1f4a:	b8 02 00 00 00       	mov    $0x2,%eax
    1f4f:	cd 40                	int    $0x40
    1f51:	c3                   	ret    

00001f52 <wait>:
SYSCALL(wait)
    1f52:	b8 03 00 00 00       	mov    $0x3,%eax
    1f57:	cd 40                	int    $0x40
    1f59:	c3                   	ret    

00001f5a <pipe>:
SYSCALL(pipe)
    1f5a:	b8 04 00 00 00       	mov    $0x4,%eax
    1f5f:	cd 40                	int    $0x40
    1f61:	c3                   	ret    

00001f62 <read>:
SYSCALL(read)
    1f62:	b8 05 00 00 00       	mov    $0x5,%eax
    1f67:	cd 40                	int    $0x40
    1f69:	c3                   	ret    

00001f6a <write>:
SYSCALL(write)
    1f6a:	b8 10 00 00 00       	mov    $0x10,%eax
    1f6f:	cd 40                	int    $0x40
    1f71:	c3                   	ret    

00001f72 <close>:
SYSCALL(close)
    1f72:	b8 15 00 00 00       	mov    $0x15,%eax
    1f77:	cd 40                	int    $0x40
    1f79:	c3                   	ret    

00001f7a <kill>:
SYSCALL(kill)
    1f7a:	b8 06 00 00 00       	mov    $0x6,%eax
    1f7f:	cd 40                	int    $0x40
    1f81:	c3                   	ret    

00001f82 <exec>:
SYSCALL(exec)
    1f82:	b8 07 00 00 00       	mov    $0x7,%eax
    1f87:	cd 40                	int    $0x40
    1f89:	c3                   	ret    

00001f8a <open>:
SYSCALL(open)
    1f8a:	b8 0f 00 00 00       	mov    $0xf,%eax
    1f8f:	cd 40                	int    $0x40
    1f91:	c3                   	ret    

00001f92 <mknod>:
SYSCALL(mknod)
    1f92:	b8 11 00 00 00       	mov    $0x11,%eax
    1f97:	cd 40                	int    $0x40
    1f99:	c3                   	ret    

00001f9a <unlink>:
SYSCALL(unlink)
    1f9a:	b8 12 00 00 00       	mov    $0x12,%eax
    1f9f:	cd 40                	int    $0x40
    1fa1:	c3                   	ret    

00001fa2 <fstat>:
SYSCALL(fstat)
    1fa2:	b8 08 00 00 00       	mov    $0x8,%eax
    1fa7:	cd 40                	int    $0x40
    1fa9:	c3                   	ret    

00001faa <link>:
SYSCALL(link)
    1faa:	b8 13 00 00 00       	mov    $0x13,%eax
    1faf:	cd 40                	int    $0x40
    1fb1:	c3                   	ret    

00001fb2 <mkdir>:
SYSCALL(mkdir)
    1fb2:	b8 14 00 00 00       	mov    $0x14,%eax
    1fb7:	cd 40                	int    $0x40
    1fb9:	c3                   	ret    

00001fba <chdir>:
SYSCALL(chdir)
    1fba:	b8 09 00 00 00       	mov    $0x9,%eax
    1fbf:	cd 40                	int    $0x40
    1fc1:	c3                   	ret    

00001fc2 <dup>:
SYSCALL(dup)
    1fc2:	b8 0a 00 00 00       	mov    $0xa,%eax
    1fc7:	cd 40                	int    $0x40
    1fc9:	c3                   	ret    

00001fca <getpid>:
SYSCALL(getpid)
    1fca:	b8 0b 00 00 00       	mov    $0xb,%eax
    1fcf:	cd 40                	int    $0x40
    1fd1:	c3                   	ret    

00001fd2 <sbrk>:
SYSCALL(sbrk)
    1fd2:	b8 0c 00 00 00       	mov    $0xc,%eax
    1fd7:	cd 40                	int    $0x40
    1fd9:	c3                   	ret    

00001fda <sleep>:
SYSCALL(sleep)
    1fda:	b8 0d 00 00 00       	mov    $0xd,%eax
    1fdf:	cd 40                	int    $0x40
    1fe1:	c3                   	ret    

00001fe2 <uptime>:
SYSCALL(uptime)
    1fe2:	b8 0e 00 00 00       	mov    $0xe,%eax
    1fe7:	cd 40                	int    $0x40
    1fe9:	c3                   	ret    

00001fea <settickets>:
SYSCALL(settickets)
    1fea:	b8 16 00 00 00       	mov    $0x16,%eax
    1fef:	cd 40                	int    $0x40
    1ff1:	c3                   	ret    

00001ff2 <getpinfo>:
SYSCALL(getpinfo)
    1ff2:	b8 17 00 00 00       	mov    $0x17,%eax
    1ff7:	cd 40                	int    $0x40
    1ff9:	c3                   	ret    

00001ffa <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1ffa:	f3 0f 1e fb          	endbr32 
    1ffe:	55                   	push   %ebp
    1fff:	89 e5                	mov    %esp,%ebp
    2001:	83 ec 18             	sub    $0x18,%esp
    2004:	8b 45 0c             	mov    0xc(%ebp),%eax
    2007:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    200a:	83 ec 04             	sub    $0x4,%esp
    200d:	6a 01                	push   $0x1
    200f:	8d 45 f4             	lea    -0xc(%ebp),%eax
    2012:	50                   	push   %eax
    2013:	ff 75 08             	pushl  0x8(%ebp)
    2016:	e8 4f ff ff ff       	call   1f6a <write>
    201b:	83 c4 10             	add    $0x10,%esp
}
    201e:	90                   	nop
    201f:	c9                   	leave  
    2020:	c3                   	ret    

00002021 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    2021:	f3 0f 1e fb          	endbr32 
    2025:	55                   	push   %ebp
    2026:	89 e5                	mov    %esp,%ebp
    2028:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    202b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    2032:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    2036:	74 17                	je     204f <printint+0x2e>
    2038:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    203c:	79 11                	jns    204f <printint+0x2e>
    neg = 1;
    203e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    2045:	8b 45 0c             	mov    0xc(%ebp),%eax
    2048:	f7 d8                	neg    %eax
    204a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    204d:	eb 06                	jmp    2055 <printint+0x34>
  } else {
    x = xx;
    204f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2052:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    2055:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    205c:	8b 4d 10             	mov    0x10(%ebp),%ecx
    205f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2062:	ba 00 00 00 00       	mov    $0x0,%edx
    2067:	f7 f1                	div    %ecx
    2069:	89 d1                	mov    %edx,%ecx
    206b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    206e:	8d 50 01             	lea    0x1(%eax),%edx
    2071:	89 55 f4             	mov    %edx,-0xc(%ebp)
    2074:	0f b6 91 28 2a 00 00 	movzbl 0x2a28(%ecx),%edx
    207b:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    207f:	8b 4d 10             	mov    0x10(%ebp),%ecx
    2082:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2085:	ba 00 00 00 00       	mov    $0x0,%edx
    208a:	f7 f1                	div    %ecx
    208c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    208f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2093:	75 c7                	jne    205c <printint+0x3b>
  if(neg)
    2095:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2099:	74 2d                	je     20c8 <printint+0xa7>
    buf[i++] = '-';
    209b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    209e:	8d 50 01             	lea    0x1(%eax),%edx
    20a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
    20a4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    20a9:	eb 1d                	jmp    20c8 <printint+0xa7>
    putc(fd, buf[i]);
    20ab:	8d 55 dc             	lea    -0x24(%ebp),%edx
    20ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20b1:	01 d0                	add    %edx,%eax
    20b3:	0f b6 00             	movzbl (%eax),%eax
    20b6:	0f be c0             	movsbl %al,%eax
    20b9:	83 ec 08             	sub    $0x8,%esp
    20bc:	50                   	push   %eax
    20bd:	ff 75 08             	pushl  0x8(%ebp)
    20c0:	e8 35 ff ff ff       	call   1ffa <putc>
    20c5:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    20c8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    20cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20d0:	79 d9                	jns    20ab <printint+0x8a>
}
    20d2:	90                   	nop
    20d3:	90                   	nop
    20d4:	c9                   	leave  
    20d5:	c3                   	ret    

000020d6 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    20d6:	f3 0f 1e fb          	endbr32 
    20da:	55                   	push   %ebp
    20db:	89 e5                	mov    %esp,%ebp
    20dd:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    20e0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    20e7:	8d 45 0c             	lea    0xc(%ebp),%eax
    20ea:	83 c0 04             	add    $0x4,%eax
    20ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    20f0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    20f7:	e9 59 01 00 00       	jmp    2255 <printf+0x17f>
    c = fmt[i] & 0xff;
    20fc:	8b 55 0c             	mov    0xc(%ebp),%edx
    20ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2102:	01 d0                	add    %edx,%eax
    2104:	0f b6 00             	movzbl (%eax),%eax
    2107:	0f be c0             	movsbl %al,%eax
    210a:	25 ff 00 00 00       	and    $0xff,%eax
    210f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    2112:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2116:	75 2c                	jne    2144 <printf+0x6e>
      if(c == '%'){
    2118:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    211c:	75 0c                	jne    212a <printf+0x54>
        state = '%';
    211e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    2125:	e9 27 01 00 00       	jmp    2251 <printf+0x17b>
      } else {
        putc(fd, c);
    212a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    212d:	0f be c0             	movsbl %al,%eax
    2130:	83 ec 08             	sub    $0x8,%esp
    2133:	50                   	push   %eax
    2134:	ff 75 08             	pushl  0x8(%ebp)
    2137:	e8 be fe ff ff       	call   1ffa <putc>
    213c:	83 c4 10             	add    $0x10,%esp
    213f:	e9 0d 01 00 00       	jmp    2251 <printf+0x17b>
      }
    } else if(state == '%'){
    2144:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    2148:	0f 85 03 01 00 00    	jne    2251 <printf+0x17b>
      if(c == 'd'){
    214e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    2152:	75 1e                	jne    2172 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    2154:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2157:	8b 00                	mov    (%eax),%eax
    2159:	6a 01                	push   $0x1
    215b:	6a 0a                	push   $0xa
    215d:	50                   	push   %eax
    215e:	ff 75 08             	pushl  0x8(%ebp)
    2161:	e8 bb fe ff ff       	call   2021 <printint>
    2166:	83 c4 10             	add    $0x10,%esp
        ap++;
    2169:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    216d:	e9 d8 00 00 00       	jmp    224a <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    2172:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    2176:	74 06                	je     217e <printf+0xa8>
    2178:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    217c:	75 1e                	jne    219c <printf+0xc6>
        printint(fd, *ap, 16, 0);
    217e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2181:	8b 00                	mov    (%eax),%eax
    2183:	6a 00                	push   $0x0
    2185:	6a 10                	push   $0x10
    2187:	50                   	push   %eax
    2188:	ff 75 08             	pushl  0x8(%ebp)
    218b:	e8 91 fe ff ff       	call   2021 <printint>
    2190:	83 c4 10             	add    $0x10,%esp
        ap++;
    2193:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2197:	e9 ae 00 00 00       	jmp    224a <printf+0x174>
      } else if(c == 's'){
    219c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    21a0:	75 43                	jne    21e5 <printf+0x10f>
        s = (char*)*ap;
    21a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    21a5:	8b 00                	mov    (%eax),%eax
    21a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    21aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    21ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    21b2:	75 25                	jne    21d9 <printf+0x103>
          s = "(null)";
    21b4:	c7 45 f4 90 25 00 00 	movl   $0x2590,-0xc(%ebp)
        while(*s != 0){
    21bb:	eb 1c                	jmp    21d9 <printf+0x103>
          putc(fd, *s);
    21bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21c0:	0f b6 00             	movzbl (%eax),%eax
    21c3:	0f be c0             	movsbl %al,%eax
    21c6:	83 ec 08             	sub    $0x8,%esp
    21c9:	50                   	push   %eax
    21ca:	ff 75 08             	pushl  0x8(%ebp)
    21cd:	e8 28 fe ff ff       	call   1ffa <putc>
    21d2:	83 c4 10             	add    $0x10,%esp
          s++;
    21d5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    21d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21dc:	0f b6 00             	movzbl (%eax),%eax
    21df:	84 c0                	test   %al,%al
    21e1:	75 da                	jne    21bd <printf+0xe7>
    21e3:	eb 65                	jmp    224a <printf+0x174>
        }
      } else if(c == 'c'){
    21e5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    21e9:	75 1d                	jne    2208 <printf+0x132>
        putc(fd, *ap);
    21eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    21ee:	8b 00                	mov    (%eax),%eax
    21f0:	0f be c0             	movsbl %al,%eax
    21f3:	83 ec 08             	sub    $0x8,%esp
    21f6:	50                   	push   %eax
    21f7:	ff 75 08             	pushl  0x8(%ebp)
    21fa:	e8 fb fd ff ff       	call   1ffa <putc>
    21ff:	83 c4 10             	add    $0x10,%esp
        ap++;
    2202:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2206:	eb 42                	jmp    224a <printf+0x174>
      } else if(c == '%'){
    2208:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    220c:	75 17                	jne    2225 <printf+0x14f>
        putc(fd, c);
    220e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2211:	0f be c0             	movsbl %al,%eax
    2214:	83 ec 08             	sub    $0x8,%esp
    2217:	50                   	push   %eax
    2218:	ff 75 08             	pushl  0x8(%ebp)
    221b:	e8 da fd ff ff       	call   1ffa <putc>
    2220:	83 c4 10             	add    $0x10,%esp
    2223:	eb 25                	jmp    224a <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    2225:	83 ec 08             	sub    $0x8,%esp
    2228:	6a 25                	push   $0x25
    222a:	ff 75 08             	pushl  0x8(%ebp)
    222d:	e8 c8 fd ff ff       	call   1ffa <putc>
    2232:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    2235:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2238:	0f be c0             	movsbl %al,%eax
    223b:	83 ec 08             	sub    $0x8,%esp
    223e:	50                   	push   %eax
    223f:	ff 75 08             	pushl  0x8(%ebp)
    2242:	e8 b3 fd ff ff       	call   1ffa <putc>
    2247:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    224a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    2251:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2255:	8b 55 0c             	mov    0xc(%ebp),%edx
    2258:	8b 45 f0             	mov    -0x10(%ebp),%eax
    225b:	01 d0                	add    %edx,%eax
    225d:	0f b6 00             	movzbl (%eax),%eax
    2260:	84 c0                	test   %al,%al
    2262:	0f 85 94 fe ff ff    	jne    20fc <printf+0x26>
    }
  }
}
    2268:	90                   	nop
    2269:	90                   	nop
    226a:	c9                   	leave  
    226b:	c3                   	ret    

0000226c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    226c:	f3 0f 1e fb          	endbr32 
    2270:	55                   	push   %ebp
    2271:	89 e5                	mov    %esp,%ebp
    2273:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    2276:	8b 45 08             	mov    0x8(%ebp),%eax
    2279:	83 e8 08             	sub    $0x8,%eax
    227c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    227f:	a1 ac 2a 00 00       	mov    0x2aac,%eax
    2284:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2287:	eb 24                	jmp    22ad <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2289:	8b 45 fc             	mov    -0x4(%ebp),%eax
    228c:	8b 00                	mov    (%eax),%eax
    228e:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    2291:	72 12                	jb     22a5 <free+0x39>
    2293:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2296:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2299:	77 24                	ja     22bf <free+0x53>
    229b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    229e:	8b 00                	mov    (%eax),%eax
    22a0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    22a3:	72 1a                	jb     22bf <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    22a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    22a8:	8b 00                	mov    (%eax),%eax
    22aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    22ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22b0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    22b3:	76 d4                	jbe    2289 <free+0x1d>
    22b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    22b8:	8b 00                	mov    (%eax),%eax
    22ba:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    22bd:	73 ca                	jae    2289 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    22bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22c2:	8b 40 04             	mov    0x4(%eax),%eax
    22c5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    22cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22cf:	01 c2                	add    %eax,%edx
    22d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    22d4:	8b 00                	mov    (%eax),%eax
    22d6:	39 c2                	cmp    %eax,%edx
    22d8:	75 24                	jne    22fe <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    22da:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22dd:	8b 50 04             	mov    0x4(%eax),%edx
    22e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    22e3:	8b 00                	mov    (%eax),%eax
    22e5:	8b 40 04             	mov    0x4(%eax),%eax
    22e8:	01 c2                	add    %eax,%edx
    22ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22ed:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    22f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    22f3:	8b 00                	mov    (%eax),%eax
    22f5:	8b 10                	mov    (%eax),%edx
    22f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22fa:	89 10                	mov    %edx,(%eax)
    22fc:	eb 0a                	jmp    2308 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    22fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2301:	8b 10                	mov    (%eax),%edx
    2303:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2306:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    2308:	8b 45 fc             	mov    -0x4(%ebp),%eax
    230b:	8b 40 04             	mov    0x4(%eax),%eax
    230e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    2315:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2318:	01 d0                	add    %edx,%eax
    231a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    231d:	75 20                	jne    233f <free+0xd3>
    p->s.size += bp->s.size;
    231f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2322:	8b 50 04             	mov    0x4(%eax),%edx
    2325:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2328:	8b 40 04             	mov    0x4(%eax),%eax
    232b:	01 c2                	add    %eax,%edx
    232d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2330:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2333:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2336:	8b 10                	mov    (%eax),%edx
    2338:	8b 45 fc             	mov    -0x4(%ebp),%eax
    233b:	89 10                	mov    %edx,(%eax)
    233d:	eb 08                	jmp    2347 <free+0xdb>
  } else
    p->s.ptr = bp;
    233f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2342:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2345:	89 10                	mov    %edx,(%eax)
  freep = p;
    2347:	8b 45 fc             	mov    -0x4(%ebp),%eax
    234a:	a3 ac 2a 00 00       	mov    %eax,0x2aac
}
    234f:	90                   	nop
    2350:	c9                   	leave  
    2351:	c3                   	ret    

00002352 <morecore>:

static Header*
morecore(uint nu)
{
    2352:	f3 0f 1e fb          	endbr32 
    2356:	55                   	push   %ebp
    2357:	89 e5                	mov    %esp,%ebp
    2359:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    235c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    2363:	77 07                	ja     236c <morecore+0x1a>
    nu = 4096;
    2365:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    236c:	8b 45 08             	mov    0x8(%ebp),%eax
    236f:	c1 e0 03             	shl    $0x3,%eax
    2372:	83 ec 0c             	sub    $0xc,%esp
    2375:	50                   	push   %eax
    2376:	e8 57 fc ff ff       	call   1fd2 <sbrk>
    237b:	83 c4 10             	add    $0x10,%esp
    237e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    2381:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    2385:	75 07                	jne    238e <morecore+0x3c>
    return 0;
    2387:	b8 00 00 00 00       	mov    $0x0,%eax
    238c:	eb 26                	jmp    23b4 <morecore+0x62>
  hp = (Header*)p;
    238e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2391:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    2394:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2397:	8b 55 08             	mov    0x8(%ebp),%edx
    239a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    239d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23a0:	83 c0 08             	add    $0x8,%eax
    23a3:	83 ec 0c             	sub    $0xc,%esp
    23a6:	50                   	push   %eax
    23a7:	e8 c0 fe ff ff       	call   226c <free>
    23ac:	83 c4 10             	add    $0x10,%esp
  return freep;
    23af:	a1 ac 2a 00 00       	mov    0x2aac,%eax
}
    23b4:	c9                   	leave  
    23b5:	c3                   	ret    

000023b6 <malloc>:

void*
malloc(uint nbytes)
{
    23b6:	f3 0f 1e fb          	endbr32 
    23ba:	55                   	push   %ebp
    23bb:	89 e5                	mov    %esp,%ebp
    23bd:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    23c0:	8b 45 08             	mov    0x8(%ebp),%eax
    23c3:	83 c0 07             	add    $0x7,%eax
    23c6:	c1 e8 03             	shr    $0x3,%eax
    23c9:	83 c0 01             	add    $0x1,%eax
    23cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    23cf:	a1 ac 2a 00 00       	mov    0x2aac,%eax
    23d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    23d7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    23db:	75 23                	jne    2400 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    23dd:	c7 45 f0 a4 2a 00 00 	movl   $0x2aa4,-0x10(%ebp)
    23e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23e7:	a3 ac 2a 00 00       	mov    %eax,0x2aac
    23ec:	a1 ac 2a 00 00       	mov    0x2aac,%eax
    23f1:	a3 a4 2a 00 00       	mov    %eax,0x2aa4
    base.s.size = 0;
    23f6:	c7 05 a8 2a 00 00 00 	movl   $0x0,0x2aa8
    23fd:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2400:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2403:	8b 00                	mov    (%eax),%eax
    2405:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    2408:	8b 45 f4             	mov    -0xc(%ebp),%eax
    240b:	8b 40 04             	mov    0x4(%eax),%eax
    240e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    2411:	77 4d                	ja     2460 <malloc+0xaa>
      if(p->s.size == nunits)
    2413:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2416:	8b 40 04             	mov    0x4(%eax),%eax
    2419:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    241c:	75 0c                	jne    242a <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    241e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2421:	8b 10                	mov    (%eax),%edx
    2423:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2426:	89 10                	mov    %edx,(%eax)
    2428:	eb 26                	jmp    2450 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    242a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    242d:	8b 40 04             	mov    0x4(%eax),%eax
    2430:	2b 45 ec             	sub    -0x14(%ebp),%eax
    2433:	89 c2                	mov    %eax,%edx
    2435:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2438:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    243b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    243e:	8b 40 04             	mov    0x4(%eax),%eax
    2441:	c1 e0 03             	shl    $0x3,%eax
    2444:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    2447:	8b 45 f4             	mov    -0xc(%ebp),%eax
    244a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    244d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    2450:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2453:	a3 ac 2a 00 00       	mov    %eax,0x2aac
      return (void*)(p + 1);
    2458:	8b 45 f4             	mov    -0xc(%ebp),%eax
    245b:	83 c0 08             	add    $0x8,%eax
    245e:	eb 3b                	jmp    249b <malloc+0xe5>
    }
    if(p == freep)
    2460:	a1 ac 2a 00 00       	mov    0x2aac,%eax
    2465:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    2468:	75 1e                	jne    2488 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    246a:	83 ec 0c             	sub    $0xc,%esp
    246d:	ff 75 ec             	pushl  -0x14(%ebp)
    2470:	e8 dd fe ff ff       	call   2352 <morecore>
    2475:	83 c4 10             	add    $0x10,%esp
    2478:	89 45 f4             	mov    %eax,-0xc(%ebp)
    247b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    247f:	75 07                	jne    2488 <malloc+0xd2>
        return 0;
    2481:	b8 00 00 00 00       	mov    $0x0,%eax
    2486:	eb 13                	jmp    249b <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2488:	8b 45 f4             	mov    -0xc(%ebp),%eax
    248b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    248e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2491:	8b 00                	mov    (%eax),%eax
    2493:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    2496:	e9 6d ff ff ff       	jmp    2408 <malloc+0x52>
  }
}
    249b:	c9                   	leave  
    249c:	c3                   	ret    
