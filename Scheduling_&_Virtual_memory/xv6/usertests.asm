
_usertests:     file format elf32-i386


Disassembly of section .text:

00001000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
    1000:	f3 0f 1e fb          	endbr32 
    1004:	55                   	push   %ebp
    1005:	89 e5                	mov    %esp,%ebp
    1007:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "iput test\n");
    100a:	a1 58 75 00 00       	mov    0x7558,%eax
    100f:	83 ec 08             	sub    $0x8,%esp
    1012:	68 1a 56 00 00       	push   $0x561a
    1017:	50                   	push   %eax
    1018:	e8 1e 42 00 00       	call   523b <printf>
    101d:	83 c4 10             	add    $0x10,%esp

  if(mkdir("iputdir") < 0){
    1020:	83 ec 0c             	sub    $0xc,%esp
    1023:	68 25 56 00 00       	push   $0x5625
    1028:	e8 ea 40 00 00       	call   5117 <mkdir>
    102d:	83 c4 10             	add    $0x10,%esp
    1030:	85 c0                	test   %eax,%eax
    1032:	79 1b                	jns    104f <iputtest+0x4f>
    printf(stdout, "mkdir failed\n");
    1034:	a1 58 75 00 00       	mov    0x7558,%eax
    1039:	83 ec 08             	sub    $0x8,%esp
    103c:	68 2d 56 00 00       	push   $0x562d
    1041:	50                   	push   %eax
    1042:	e8 f4 41 00 00       	call   523b <printf>
    1047:	83 c4 10             	add    $0x10,%esp
    exit();
    104a:	e8 60 40 00 00       	call   50af <exit>
  }
  if(chdir("iputdir") < 0){
    104f:	83 ec 0c             	sub    $0xc,%esp
    1052:	68 25 56 00 00       	push   $0x5625
    1057:	e8 c3 40 00 00       	call   511f <chdir>
    105c:	83 c4 10             	add    $0x10,%esp
    105f:	85 c0                	test   %eax,%eax
    1061:	79 1b                	jns    107e <iputtest+0x7e>
    printf(stdout, "chdir iputdir failed\n");
    1063:	a1 58 75 00 00       	mov    0x7558,%eax
    1068:	83 ec 08             	sub    $0x8,%esp
    106b:	68 3b 56 00 00       	push   $0x563b
    1070:	50                   	push   %eax
    1071:	e8 c5 41 00 00       	call   523b <printf>
    1076:	83 c4 10             	add    $0x10,%esp
    exit();
    1079:	e8 31 40 00 00       	call   50af <exit>
  }
  if(unlink("../iputdir") < 0){
    107e:	83 ec 0c             	sub    $0xc,%esp
    1081:	68 51 56 00 00       	push   $0x5651
    1086:	e8 74 40 00 00       	call   50ff <unlink>
    108b:	83 c4 10             	add    $0x10,%esp
    108e:	85 c0                	test   %eax,%eax
    1090:	79 1b                	jns    10ad <iputtest+0xad>
    printf(stdout, "unlink ../iputdir failed\n");
    1092:	a1 58 75 00 00       	mov    0x7558,%eax
    1097:	83 ec 08             	sub    $0x8,%esp
    109a:	68 5c 56 00 00       	push   $0x565c
    109f:	50                   	push   %eax
    10a0:	e8 96 41 00 00       	call   523b <printf>
    10a5:	83 c4 10             	add    $0x10,%esp
    exit();
    10a8:	e8 02 40 00 00       	call   50af <exit>
  }
  if(chdir("/") < 0){
    10ad:	83 ec 0c             	sub    $0xc,%esp
    10b0:	68 76 56 00 00       	push   $0x5676
    10b5:	e8 65 40 00 00       	call   511f <chdir>
    10ba:	83 c4 10             	add    $0x10,%esp
    10bd:	85 c0                	test   %eax,%eax
    10bf:	79 1b                	jns    10dc <iputtest+0xdc>
    printf(stdout, "chdir / failed\n");
    10c1:	a1 58 75 00 00       	mov    0x7558,%eax
    10c6:	83 ec 08             	sub    $0x8,%esp
    10c9:	68 78 56 00 00       	push   $0x5678
    10ce:	50                   	push   %eax
    10cf:	e8 67 41 00 00       	call   523b <printf>
    10d4:	83 c4 10             	add    $0x10,%esp
    exit();
    10d7:	e8 d3 3f 00 00       	call   50af <exit>
  }
  printf(stdout, "iput test ok\n");
    10dc:	a1 58 75 00 00       	mov    0x7558,%eax
    10e1:	83 ec 08             	sub    $0x8,%esp
    10e4:	68 88 56 00 00       	push   $0x5688
    10e9:	50                   	push   %eax
    10ea:	e8 4c 41 00 00       	call   523b <printf>
    10ef:	83 c4 10             	add    $0x10,%esp
}
    10f2:	90                   	nop
    10f3:	c9                   	leave  
    10f4:	c3                   	ret    

000010f5 <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
    10f5:	f3 0f 1e fb          	endbr32 
    10f9:	55                   	push   %ebp
    10fa:	89 e5                	mov    %esp,%ebp
    10fc:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "exitiput test\n");
    10ff:	a1 58 75 00 00       	mov    0x7558,%eax
    1104:	83 ec 08             	sub    $0x8,%esp
    1107:	68 96 56 00 00       	push   $0x5696
    110c:	50                   	push   %eax
    110d:	e8 29 41 00 00       	call   523b <printf>
    1112:	83 c4 10             	add    $0x10,%esp

  pid = fork();
    1115:	e8 8d 3f 00 00       	call   50a7 <fork>
    111a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
    111d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1121:	79 1b                	jns    113e <exitiputtest+0x49>
    printf(stdout, "fork failed\n");
    1123:	a1 58 75 00 00       	mov    0x7558,%eax
    1128:	83 ec 08             	sub    $0x8,%esp
    112b:	68 a5 56 00 00       	push   $0x56a5
    1130:	50                   	push   %eax
    1131:	e8 05 41 00 00       	call   523b <printf>
    1136:	83 c4 10             	add    $0x10,%esp
    exit();
    1139:	e8 71 3f 00 00       	call   50af <exit>
  }
  if(pid == 0){
    113e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1142:	0f 85 92 00 00 00    	jne    11da <exitiputtest+0xe5>
    if(mkdir("iputdir") < 0){
    1148:	83 ec 0c             	sub    $0xc,%esp
    114b:	68 25 56 00 00       	push   $0x5625
    1150:	e8 c2 3f 00 00       	call   5117 <mkdir>
    1155:	83 c4 10             	add    $0x10,%esp
    1158:	85 c0                	test   %eax,%eax
    115a:	79 1b                	jns    1177 <exitiputtest+0x82>
      printf(stdout, "mkdir failed\n");
    115c:	a1 58 75 00 00       	mov    0x7558,%eax
    1161:	83 ec 08             	sub    $0x8,%esp
    1164:	68 2d 56 00 00       	push   $0x562d
    1169:	50                   	push   %eax
    116a:	e8 cc 40 00 00       	call   523b <printf>
    116f:	83 c4 10             	add    $0x10,%esp
      exit();
    1172:	e8 38 3f 00 00       	call   50af <exit>
    }
    if(chdir("iputdir") < 0){
    1177:	83 ec 0c             	sub    $0xc,%esp
    117a:	68 25 56 00 00       	push   $0x5625
    117f:	e8 9b 3f 00 00       	call   511f <chdir>
    1184:	83 c4 10             	add    $0x10,%esp
    1187:	85 c0                	test   %eax,%eax
    1189:	79 1b                	jns    11a6 <exitiputtest+0xb1>
      printf(stdout, "child chdir failed\n");
    118b:	a1 58 75 00 00       	mov    0x7558,%eax
    1190:	83 ec 08             	sub    $0x8,%esp
    1193:	68 b2 56 00 00       	push   $0x56b2
    1198:	50                   	push   %eax
    1199:	e8 9d 40 00 00       	call   523b <printf>
    119e:	83 c4 10             	add    $0x10,%esp
      exit();
    11a1:	e8 09 3f 00 00       	call   50af <exit>
    }
    if(unlink("../iputdir") < 0){
    11a6:	83 ec 0c             	sub    $0xc,%esp
    11a9:	68 51 56 00 00       	push   $0x5651
    11ae:	e8 4c 3f 00 00       	call   50ff <unlink>
    11b3:	83 c4 10             	add    $0x10,%esp
    11b6:	85 c0                	test   %eax,%eax
    11b8:	79 1b                	jns    11d5 <exitiputtest+0xe0>
      printf(stdout, "unlink ../iputdir failed\n");
    11ba:	a1 58 75 00 00       	mov    0x7558,%eax
    11bf:	83 ec 08             	sub    $0x8,%esp
    11c2:	68 5c 56 00 00       	push   $0x565c
    11c7:	50                   	push   %eax
    11c8:	e8 6e 40 00 00       	call   523b <printf>
    11cd:	83 c4 10             	add    $0x10,%esp
      exit();
    11d0:	e8 da 3e 00 00       	call   50af <exit>
    }
    exit();
    11d5:	e8 d5 3e 00 00       	call   50af <exit>
  }
  wait();
    11da:	e8 d8 3e 00 00       	call   50b7 <wait>
  printf(stdout, "exitiput test ok\n");
    11df:	a1 58 75 00 00       	mov    0x7558,%eax
    11e4:	83 ec 08             	sub    $0x8,%esp
    11e7:	68 c6 56 00 00       	push   $0x56c6
    11ec:	50                   	push   %eax
    11ed:	e8 49 40 00 00       	call   523b <printf>
    11f2:	83 c4 10             	add    $0x10,%esp
}
    11f5:	90                   	nop
    11f6:	c9                   	leave  
    11f7:	c3                   	ret    

000011f8 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
    11f8:	f3 0f 1e fb          	endbr32 
    11fc:	55                   	push   %ebp
    11fd:	89 e5                	mov    %esp,%ebp
    11ff:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "openiput test\n");
    1202:	a1 58 75 00 00       	mov    0x7558,%eax
    1207:	83 ec 08             	sub    $0x8,%esp
    120a:	68 d8 56 00 00       	push   $0x56d8
    120f:	50                   	push   %eax
    1210:	e8 26 40 00 00       	call   523b <printf>
    1215:	83 c4 10             	add    $0x10,%esp
  if(mkdir("oidir") < 0){
    1218:	83 ec 0c             	sub    $0xc,%esp
    121b:	68 e7 56 00 00       	push   $0x56e7
    1220:	e8 f2 3e 00 00       	call   5117 <mkdir>
    1225:	83 c4 10             	add    $0x10,%esp
    1228:	85 c0                	test   %eax,%eax
    122a:	79 1b                	jns    1247 <openiputtest+0x4f>
    printf(stdout, "mkdir oidir failed\n");
    122c:	a1 58 75 00 00       	mov    0x7558,%eax
    1231:	83 ec 08             	sub    $0x8,%esp
    1234:	68 ed 56 00 00       	push   $0x56ed
    1239:	50                   	push   %eax
    123a:	e8 fc 3f 00 00       	call   523b <printf>
    123f:	83 c4 10             	add    $0x10,%esp
    exit();
    1242:	e8 68 3e 00 00       	call   50af <exit>
  }
  pid = fork();
    1247:	e8 5b 3e 00 00       	call   50a7 <fork>
    124c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
    124f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1253:	79 1b                	jns    1270 <openiputtest+0x78>
    printf(stdout, "fork failed\n");
    1255:	a1 58 75 00 00       	mov    0x7558,%eax
    125a:	83 ec 08             	sub    $0x8,%esp
    125d:	68 a5 56 00 00       	push   $0x56a5
    1262:	50                   	push   %eax
    1263:	e8 d3 3f 00 00       	call   523b <printf>
    1268:	83 c4 10             	add    $0x10,%esp
    exit();
    126b:	e8 3f 3e 00 00       	call   50af <exit>
  }
  if(pid == 0){
    1270:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1274:	75 3b                	jne    12b1 <openiputtest+0xb9>
    int fd = open("oidir", O_RDWR);
    1276:	83 ec 08             	sub    $0x8,%esp
    1279:	6a 02                	push   $0x2
    127b:	68 e7 56 00 00       	push   $0x56e7
    1280:	e8 6a 3e 00 00       	call   50ef <open>
    1285:	83 c4 10             	add    $0x10,%esp
    1288:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0){
    128b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    128f:	78 1b                	js     12ac <openiputtest+0xb4>
      printf(stdout, "open directory for write succeeded\n");
    1291:	a1 58 75 00 00       	mov    0x7558,%eax
    1296:	83 ec 08             	sub    $0x8,%esp
    1299:	68 04 57 00 00       	push   $0x5704
    129e:	50                   	push   %eax
    129f:	e8 97 3f 00 00       	call   523b <printf>
    12a4:	83 c4 10             	add    $0x10,%esp
      exit();
    12a7:	e8 03 3e 00 00       	call   50af <exit>
    }
    exit();
    12ac:	e8 fe 3d 00 00       	call   50af <exit>
  }
  sleep(1);
    12b1:	83 ec 0c             	sub    $0xc,%esp
    12b4:	6a 01                	push   $0x1
    12b6:	e8 84 3e 00 00       	call   513f <sleep>
    12bb:	83 c4 10             	add    $0x10,%esp
  if(unlink("oidir") != 0){
    12be:	83 ec 0c             	sub    $0xc,%esp
    12c1:	68 e7 56 00 00       	push   $0x56e7
    12c6:	e8 34 3e 00 00       	call   50ff <unlink>
    12cb:	83 c4 10             	add    $0x10,%esp
    12ce:	85 c0                	test   %eax,%eax
    12d0:	74 1b                	je     12ed <openiputtest+0xf5>
    printf(stdout, "unlink failed\n");
    12d2:	a1 58 75 00 00       	mov    0x7558,%eax
    12d7:	83 ec 08             	sub    $0x8,%esp
    12da:	68 28 57 00 00       	push   $0x5728
    12df:	50                   	push   %eax
    12e0:	e8 56 3f 00 00       	call   523b <printf>
    12e5:	83 c4 10             	add    $0x10,%esp
    exit();
    12e8:	e8 c2 3d 00 00       	call   50af <exit>
  }
  wait();
    12ed:	e8 c5 3d 00 00       	call   50b7 <wait>
  printf(stdout, "openiput test ok\n");
    12f2:	a1 58 75 00 00       	mov    0x7558,%eax
    12f7:	83 ec 08             	sub    $0x8,%esp
    12fa:	68 37 57 00 00       	push   $0x5737
    12ff:	50                   	push   %eax
    1300:	e8 36 3f 00 00       	call   523b <printf>
    1305:	83 c4 10             	add    $0x10,%esp
}
    1308:	90                   	nop
    1309:	c9                   	leave  
    130a:	c3                   	ret    

0000130b <opentest>:

// simple file system tests

void
opentest(void)
{
    130b:	f3 0f 1e fb          	endbr32 
    130f:	55                   	push   %ebp
    1310:	89 e5                	mov    %esp,%ebp
    1312:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
    1315:	a1 58 75 00 00       	mov    0x7558,%eax
    131a:	83 ec 08             	sub    $0x8,%esp
    131d:	68 49 57 00 00       	push   $0x5749
    1322:	50                   	push   %eax
    1323:	e8 13 3f 00 00       	call   523b <printf>
    1328:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
    132b:	83 ec 08             	sub    $0x8,%esp
    132e:	6a 00                	push   $0x0
    1330:	68 04 56 00 00       	push   $0x5604
    1335:	e8 b5 3d 00 00       	call   50ef <open>
    133a:	83 c4 10             	add    $0x10,%esp
    133d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1340:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1344:	79 1b                	jns    1361 <opentest+0x56>
    printf(stdout, "open echo failed!\n");
    1346:	a1 58 75 00 00       	mov    0x7558,%eax
    134b:	83 ec 08             	sub    $0x8,%esp
    134e:	68 54 57 00 00       	push   $0x5754
    1353:	50                   	push   %eax
    1354:	e8 e2 3e 00 00       	call   523b <printf>
    1359:	83 c4 10             	add    $0x10,%esp
    exit();
    135c:	e8 4e 3d 00 00       	call   50af <exit>
  }
  close(fd);
    1361:	83 ec 0c             	sub    $0xc,%esp
    1364:	ff 75 f4             	pushl  -0xc(%ebp)
    1367:	e8 6b 3d 00 00       	call   50d7 <close>
    136c:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
    136f:	83 ec 08             	sub    $0x8,%esp
    1372:	6a 00                	push   $0x0
    1374:	68 67 57 00 00       	push   $0x5767
    1379:	e8 71 3d 00 00       	call   50ef <open>
    137e:	83 c4 10             	add    $0x10,%esp
    1381:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    1384:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1388:	78 1b                	js     13a5 <opentest+0x9a>
    printf(stdout, "open doesnotexist succeeded!\n");
    138a:	a1 58 75 00 00       	mov    0x7558,%eax
    138f:	83 ec 08             	sub    $0x8,%esp
    1392:	68 74 57 00 00       	push   $0x5774
    1397:	50                   	push   %eax
    1398:	e8 9e 3e 00 00       	call   523b <printf>
    139d:	83 c4 10             	add    $0x10,%esp
    exit();
    13a0:	e8 0a 3d 00 00       	call   50af <exit>
  }
  printf(stdout, "open test ok\n");
    13a5:	a1 58 75 00 00       	mov    0x7558,%eax
    13aa:	83 ec 08             	sub    $0x8,%esp
    13ad:	68 92 57 00 00       	push   $0x5792
    13b2:	50                   	push   %eax
    13b3:	e8 83 3e 00 00       	call   523b <printf>
    13b8:	83 c4 10             	add    $0x10,%esp
}
    13bb:	90                   	nop
    13bc:	c9                   	leave  
    13bd:	c3                   	ret    

000013be <writetest>:

void
writetest(void)
{
    13be:	f3 0f 1e fb          	endbr32 
    13c2:	55                   	push   %ebp
    13c3:	89 e5                	mov    %esp,%ebp
    13c5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
    13c8:	a1 58 75 00 00       	mov    0x7558,%eax
    13cd:	83 ec 08             	sub    $0x8,%esp
    13d0:	68 a0 57 00 00       	push   $0x57a0
    13d5:	50                   	push   %eax
    13d6:	e8 60 3e 00 00       	call   523b <printf>
    13db:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
    13de:	83 ec 08             	sub    $0x8,%esp
    13e1:	68 02 02 00 00       	push   $0x202
    13e6:	68 b1 57 00 00       	push   $0x57b1
    13eb:	e8 ff 3c 00 00       	call   50ef <open>
    13f0:	83 c4 10             	add    $0x10,%esp
    13f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
    13f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13fa:	78 22                	js     141e <writetest+0x60>
    printf(stdout, "creat small succeeded; ok\n");
    13fc:	a1 58 75 00 00       	mov    0x7558,%eax
    1401:	83 ec 08             	sub    $0x8,%esp
    1404:	68 b7 57 00 00       	push   $0x57b7
    1409:	50                   	push   %eax
    140a:	e8 2c 3e 00 00       	call   523b <printf>
    140f:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    1412:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1419:	e9 8f 00 00 00       	jmp    14ad <writetest+0xef>
    printf(stdout, "error: creat small failed!\n");
    141e:	a1 58 75 00 00       	mov    0x7558,%eax
    1423:	83 ec 08             	sub    $0x8,%esp
    1426:	68 d2 57 00 00       	push   $0x57d2
    142b:	50                   	push   %eax
    142c:	e8 0a 3e 00 00       	call   523b <printf>
    1431:	83 c4 10             	add    $0x10,%esp
    exit();
    1434:	e8 76 3c 00 00       	call   50af <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
    1439:	83 ec 04             	sub    $0x4,%esp
    143c:	6a 0a                	push   $0xa
    143e:	68 ee 57 00 00       	push   $0x57ee
    1443:	ff 75 f0             	pushl  -0x10(%ebp)
    1446:	e8 84 3c 00 00       	call   50cf <write>
    144b:	83 c4 10             	add    $0x10,%esp
    144e:	83 f8 0a             	cmp    $0xa,%eax
    1451:	74 1e                	je     1471 <writetest+0xb3>
      printf(stdout, "error: write aa %d new file failed\n", i);
    1453:	a1 58 75 00 00       	mov    0x7558,%eax
    1458:	83 ec 04             	sub    $0x4,%esp
    145b:	ff 75 f4             	pushl  -0xc(%ebp)
    145e:	68 fc 57 00 00       	push   $0x57fc
    1463:	50                   	push   %eax
    1464:	e8 d2 3d 00 00       	call   523b <printf>
    1469:	83 c4 10             	add    $0x10,%esp
      exit();
    146c:	e8 3e 3c 00 00       	call   50af <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
    1471:	83 ec 04             	sub    $0x4,%esp
    1474:	6a 0a                	push   $0xa
    1476:	68 20 58 00 00       	push   $0x5820
    147b:	ff 75 f0             	pushl  -0x10(%ebp)
    147e:	e8 4c 3c 00 00       	call   50cf <write>
    1483:	83 c4 10             	add    $0x10,%esp
    1486:	83 f8 0a             	cmp    $0xa,%eax
    1489:	74 1e                	je     14a9 <writetest+0xeb>
      printf(stdout, "error: write bb %d new file failed\n", i);
    148b:	a1 58 75 00 00       	mov    0x7558,%eax
    1490:	83 ec 04             	sub    $0x4,%esp
    1493:	ff 75 f4             	pushl  -0xc(%ebp)
    1496:	68 2c 58 00 00       	push   $0x582c
    149b:	50                   	push   %eax
    149c:	e8 9a 3d 00 00       	call   523b <printf>
    14a1:	83 c4 10             	add    $0x10,%esp
      exit();
    14a4:	e8 06 3c 00 00       	call   50af <exit>
  for(i = 0; i < 100; i++){
    14a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14ad:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    14b1:	7e 86                	jle    1439 <writetest+0x7b>
    }
  }
  printf(stdout, "writes ok\n");
    14b3:	a1 58 75 00 00       	mov    0x7558,%eax
    14b8:	83 ec 08             	sub    $0x8,%esp
    14bb:	68 50 58 00 00       	push   $0x5850
    14c0:	50                   	push   %eax
    14c1:	e8 75 3d 00 00       	call   523b <printf>
    14c6:	83 c4 10             	add    $0x10,%esp
  close(fd);
    14c9:	83 ec 0c             	sub    $0xc,%esp
    14cc:	ff 75 f0             	pushl  -0x10(%ebp)
    14cf:	e8 03 3c 00 00       	call   50d7 <close>
    14d4:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
    14d7:	83 ec 08             	sub    $0x8,%esp
    14da:	6a 00                	push   $0x0
    14dc:	68 b1 57 00 00       	push   $0x57b1
    14e1:	e8 09 3c 00 00       	call   50ef <open>
    14e6:	83 c4 10             	add    $0x10,%esp
    14e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
    14ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14f0:	78 3c                	js     152e <writetest+0x170>
    printf(stdout, "open small succeeded ok\n");
    14f2:	a1 58 75 00 00       	mov    0x7558,%eax
    14f7:	83 ec 08             	sub    $0x8,%esp
    14fa:	68 5b 58 00 00       	push   $0x585b
    14ff:	50                   	push   %eax
    1500:	e8 36 3d 00 00       	call   523b <printf>
    1505:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
    1508:	83 ec 04             	sub    $0x4,%esp
    150b:	68 d0 07 00 00       	push   $0x7d0
    1510:	68 40 9d 00 00       	push   $0x9d40
    1515:	ff 75 f0             	pushl  -0x10(%ebp)
    1518:	e8 aa 3b 00 00       	call   50c7 <read>
    151d:	83 c4 10             	add    $0x10,%esp
    1520:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
    1523:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
    152a:	75 57                	jne    1583 <writetest+0x1c5>
    152c:	eb 1b                	jmp    1549 <writetest+0x18b>
    printf(stdout, "error: open small failed!\n");
    152e:	a1 58 75 00 00       	mov    0x7558,%eax
    1533:	83 ec 08             	sub    $0x8,%esp
    1536:	68 74 58 00 00       	push   $0x5874
    153b:	50                   	push   %eax
    153c:	e8 fa 3c 00 00       	call   523b <printf>
    1541:	83 c4 10             	add    $0x10,%esp
    exit();
    1544:	e8 66 3b 00 00       	call   50af <exit>
    printf(stdout, "read succeeded ok\n");
    1549:	a1 58 75 00 00       	mov    0x7558,%eax
    154e:	83 ec 08             	sub    $0x8,%esp
    1551:	68 8f 58 00 00       	push   $0x588f
    1556:	50                   	push   %eax
    1557:	e8 df 3c 00 00       	call   523b <printf>
    155c:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
    155f:	83 ec 0c             	sub    $0xc,%esp
    1562:	ff 75 f0             	pushl  -0x10(%ebp)
    1565:	e8 6d 3b 00 00       	call   50d7 <close>
    156a:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
    156d:	83 ec 0c             	sub    $0xc,%esp
    1570:	68 b1 57 00 00       	push   $0x57b1
    1575:	e8 85 3b 00 00       	call   50ff <unlink>
    157a:	83 c4 10             	add    $0x10,%esp
    157d:	85 c0                	test   %eax,%eax
    157f:	79 38                	jns    15b9 <writetest+0x1fb>
    1581:	eb 1b                	jmp    159e <writetest+0x1e0>
    printf(stdout, "read failed\n");
    1583:	a1 58 75 00 00       	mov    0x7558,%eax
    1588:	83 ec 08             	sub    $0x8,%esp
    158b:	68 a2 58 00 00       	push   $0x58a2
    1590:	50                   	push   %eax
    1591:	e8 a5 3c 00 00       	call   523b <printf>
    1596:	83 c4 10             	add    $0x10,%esp
    exit();
    1599:	e8 11 3b 00 00       	call   50af <exit>
    printf(stdout, "unlink small failed\n");
    159e:	a1 58 75 00 00       	mov    0x7558,%eax
    15a3:	83 ec 08             	sub    $0x8,%esp
    15a6:	68 af 58 00 00       	push   $0x58af
    15ab:	50                   	push   %eax
    15ac:	e8 8a 3c 00 00       	call   523b <printf>
    15b1:	83 c4 10             	add    $0x10,%esp
    exit();
    15b4:	e8 f6 3a 00 00       	call   50af <exit>
  }
  printf(stdout, "small file test ok\n");
    15b9:	a1 58 75 00 00       	mov    0x7558,%eax
    15be:	83 ec 08             	sub    $0x8,%esp
    15c1:	68 c4 58 00 00       	push   $0x58c4
    15c6:	50                   	push   %eax
    15c7:	e8 6f 3c 00 00       	call   523b <printf>
    15cc:	83 c4 10             	add    $0x10,%esp
}
    15cf:	90                   	nop
    15d0:	c9                   	leave  
    15d1:	c3                   	ret    

000015d2 <writetest1>:

void
writetest1(void)
{
    15d2:	f3 0f 1e fb          	endbr32 
    15d6:	55                   	push   %ebp
    15d7:	89 e5                	mov    %esp,%ebp
    15d9:	83 ec 18             	sub    $0x18,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
    15dc:	a1 58 75 00 00       	mov    0x7558,%eax
    15e1:	83 ec 08             	sub    $0x8,%esp
    15e4:	68 d8 58 00 00       	push   $0x58d8
    15e9:	50                   	push   %eax
    15ea:	e8 4c 3c 00 00       	call   523b <printf>
    15ef:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
    15f2:	83 ec 08             	sub    $0x8,%esp
    15f5:	68 02 02 00 00       	push   $0x202
    15fa:	68 e8 58 00 00       	push   $0x58e8
    15ff:	e8 eb 3a 00 00       	call   50ef <open>
    1604:	83 c4 10             	add    $0x10,%esp
    1607:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    160a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    160e:	79 1b                	jns    162b <writetest1+0x59>
    printf(stdout, "error: creat big failed!\n");
    1610:	a1 58 75 00 00       	mov    0x7558,%eax
    1615:	83 ec 08             	sub    $0x8,%esp
    1618:	68 ec 58 00 00       	push   $0x58ec
    161d:	50                   	push   %eax
    161e:	e8 18 3c 00 00       	call   523b <printf>
    1623:	83 c4 10             	add    $0x10,%esp
    exit();
    1626:	e8 84 3a 00 00       	call   50af <exit>
  }

  for(i = 0; i < MAXFILE; i++){
    162b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1632:	eb 4b                	jmp    167f <writetest1+0xad>
    ((int*)buf)[0] = i;
    1634:	ba 40 9d 00 00       	mov    $0x9d40,%edx
    1639:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163c:	89 02                	mov    %eax,(%edx)
    if(write(fd, buf, 512) != 512){
    163e:	83 ec 04             	sub    $0x4,%esp
    1641:	68 00 02 00 00       	push   $0x200
    1646:	68 40 9d 00 00       	push   $0x9d40
    164b:	ff 75 ec             	pushl  -0x14(%ebp)
    164e:	e8 7c 3a 00 00       	call   50cf <write>
    1653:	83 c4 10             	add    $0x10,%esp
    1656:	3d 00 02 00 00       	cmp    $0x200,%eax
    165b:	74 1e                	je     167b <writetest1+0xa9>
      printf(stdout, "error: write big file failed\n", i);
    165d:	a1 58 75 00 00       	mov    0x7558,%eax
    1662:	83 ec 04             	sub    $0x4,%esp
    1665:	ff 75 f4             	pushl  -0xc(%ebp)
    1668:	68 06 59 00 00       	push   $0x5906
    166d:	50                   	push   %eax
    166e:	e8 c8 3b 00 00       	call   523b <printf>
    1673:	83 c4 10             	add    $0x10,%esp
      exit();
    1676:	e8 34 3a 00 00       	call   50af <exit>
  for(i = 0; i < MAXFILE; i++){
    167b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    167f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1682:	3d 8b 00 00 00       	cmp    $0x8b,%eax
    1687:	76 ab                	jbe    1634 <writetest1+0x62>
    }
  }

  close(fd);
    1689:	83 ec 0c             	sub    $0xc,%esp
    168c:	ff 75 ec             	pushl  -0x14(%ebp)
    168f:	e8 43 3a 00 00       	call   50d7 <close>
    1694:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
    1697:	83 ec 08             	sub    $0x8,%esp
    169a:	6a 00                	push   $0x0
    169c:	68 e8 58 00 00       	push   $0x58e8
    16a1:	e8 49 3a 00 00       	call   50ef <open>
    16a6:	83 c4 10             	add    $0x10,%esp
    16a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    16ac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16b0:	79 1b                	jns    16cd <writetest1+0xfb>
    printf(stdout, "error: open big failed!\n");
    16b2:	a1 58 75 00 00       	mov    0x7558,%eax
    16b7:	83 ec 08             	sub    $0x8,%esp
    16ba:	68 24 59 00 00       	push   $0x5924
    16bf:	50                   	push   %eax
    16c0:	e8 76 3b 00 00       	call   523b <printf>
    16c5:	83 c4 10             	add    $0x10,%esp
    exit();
    16c8:	e8 e2 39 00 00       	call   50af <exit>
  }

  n = 0;
    16cd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
    16d4:	83 ec 04             	sub    $0x4,%esp
    16d7:	68 00 02 00 00       	push   $0x200
    16dc:	68 40 9d 00 00       	push   $0x9d40
    16e1:	ff 75 ec             	pushl  -0x14(%ebp)
    16e4:	e8 de 39 00 00       	call   50c7 <read>
    16e9:	83 c4 10             	add    $0x10,%esp
    16ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
    16ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16f3:	75 27                	jne    171c <writetest1+0x14a>
      if(n == MAXFILE - 1){
    16f5:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
    16fc:	75 7d                	jne    177b <writetest1+0x1a9>
        printf(stdout, "read only %d blocks from big", n);
    16fe:	a1 58 75 00 00       	mov    0x7558,%eax
    1703:	83 ec 04             	sub    $0x4,%esp
    1706:	ff 75 f0             	pushl  -0x10(%ebp)
    1709:	68 3d 59 00 00       	push   $0x593d
    170e:	50                   	push   %eax
    170f:	e8 27 3b 00 00       	call   523b <printf>
    1714:	83 c4 10             	add    $0x10,%esp
        exit();
    1717:	e8 93 39 00 00       	call   50af <exit>
      }
      break;
    } else if(i != 512){
    171c:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
    1723:	74 1e                	je     1743 <writetest1+0x171>
      printf(stdout, "read failed %d\n", i);
    1725:	a1 58 75 00 00       	mov    0x7558,%eax
    172a:	83 ec 04             	sub    $0x4,%esp
    172d:	ff 75 f4             	pushl  -0xc(%ebp)
    1730:	68 5a 59 00 00       	push   $0x595a
    1735:	50                   	push   %eax
    1736:	e8 00 3b 00 00       	call   523b <printf>
    173b:	83 c4 10             	add    $0x10,%esp
      exit();
    173e:	e8 6c 39 00 00       	call   50af <exit>
    }
    if(((int*)buf)[0] != n){
    1743:	b8 40 9d 00 00       	mov    $0x9d40,%eax
    1748:	8b 00                	mov    (%eax),%eax
    174a:	39 45 f0             	cmp    %eax,-0x10(%ebp)
    174d:	74 23                	je     1772 <writetest1+0x1a0>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
    174f:	b8 40 9d 00 00       	mov    $0x9d40,%eax
      printf(stdout, "read content of block %d is %d\n",
    1754:	8b 10                	mov    (%eax),%edx
    1756:	a1 58 75 00 00       	mov    0x7558,%eax
    175b:	52                   	push   %edx
    175c:	ff 75 f0             	pushl  -0x10(%ebp)
    175f:	68 6c 59 00 00       	push   $0x596c
    1764:	50                   	push   %eax
    1765:	e8 d1 3a 00 00       	call   523b <printf>
    176a:	83 c4 10             	add    $0x10,%esp
      exit();
    176d:	e8 3d 39 00 00       	call   50af <exit>
    }
    n++;
    1772:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    i = read(fd, buf, 512);
    1776:	e9 59 ff ff ff       	jmp    16d4 <writetest1+0x102>
      break;
    177b:	90                   	nop
  }
  close(fd);
    177c:	83 ec 0c             	sub    $0xc,%esp
    177f:	ff 75 ec             	pushl  -0x14(%ebp)
    1782:	e8 50 39 00 00       	call   50d7 <close>
    1787:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
    178a:	83 ec 0c             	sub    $0xc,%esp
    178d:	68 e8 58 00 00       	push   $0x58e8
    1792:	e8 68 39 00 00       	call   50ff <unlink>
    1797:	83 c4 10             	add    $0x10,%esp
    179a:	85 c0                	test   %eax,%eax
    179c:	79 1b                	jns    17b9 <writetest1+0x1e7>
    printf(stdout, "unlink big failed\n");
    179e:	a1 58 75 00 00       	mov    0x7558,%eax
    17a3:	83 ec 08             	sub    $0x8,%esp
    17a6:	68 8c 59 00 00       	push   $0x598c
    17ab:	50                   	push   %eax
    17ac:	e8 8a 3a 00 00       	call   523b <printf>
    17b1:	83 c4 10             	add    $0x10,%esp
    exit();
    17b4:	e8 f6 38 00 00       	call   50af <exit>
  }
  printf(stdout, "big files ok\n");
    17b9:	a1 58 75 00 00       	mov    0x7558,%eax
    17be:	83 ec 08             	sub    $0x8,%esp
    17c1:	68 9f 59 00 00       	push   $0x599f
    17c6:	50                   	push   %eax
    17c7:	e8 6f 3a 00 00       	call   523b <printf>
    17cc:	83 c4 10             	add    $0x10,%esp
}
    17cf:	90                   	nop
    17d0:	c9                   	leave  
    17d1:	c3                   	ret    

000017d2 <createtest>:

void
createtest(void)
{
    17d2:	f3 0f 1e fb          	endbr32 
    17d6:	55                   	push   %ebp
    17d7:	89 e5                	mov    %esp,%ebp
    17d9:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
    17dc:	a1 58 75 00 00       	mov    0x7558,%eax
    17e1:	83 ec 08             	sub    $0x8,%esp
    17e4:	68 b0 59 00 00       	push   $0x59b0
    17e9:	50                   	push   %eax
    17ea:	e8 4c 3a 00 00       	call   523b <printf>
    17ef:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
    17f2:	c6 05 40 bd 00 00 61 	movb   $0x61,0xbd40
  name[2] = '\0';
    17f9:	c6 05 42 bd 00 00 00 	movb   $0x0,0xbd42
  for(i = 0; i < 52; i++){
    1800:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1807:	eb 35                	jmp    183e <createtest+0x6c>
    name[1] = '0' + i;
    1809:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180c:	83 c0 30             	add    $0x30,%eax
    180f:	a2 41 bd 00 00       	mov    %al,0xbd41
    fd = open(name, O_CREATE|O_RDWR);
    1814:	83 ec 08             	sub    $0x8,%esp
    1817:	68 02 02 00 00       	push   $0x202
    181c:	68 40 bd 00 00       	push   $0xbd40
    1821:	e8 c9 38 00 00       	call   50ef <open>
    1826:	83 c4 10             	add    $0x10,%esp
    1829:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
    182c:	83 ec 0c             	sub    $0xc,%esp
    182f:	ff 75 f0             	pushl  -0x10(%ebp)
    1832:	e8 a0 38 00 00       	call   50d7 <close>
    1837:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
    183a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    183e:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
    1842:	7e c5                	jle    1809 <createtest+0x37>
  }
  name[0] = 'a';
    1844:	c6 05 40 bd 00 00 61 	movb   $0x61,0xbd40
  name[2] = '\0';
    184b:	c6 05 42 bd 00 00 00 	movb   $0x0,0xbd42
  for(i = 0; i < 52; i++){
    1852:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1859:	eb 1f                	jmp    187a <createtest+0xa8>
    name[1] = '0' + i;
    185b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185e:	83 c0 30             	add    $0x30,%eax
    1861:	a2 41 bd 00 00       	mov    %al,0xbd41
    unlink(name);
    1866:	83 ec 0c             	sub    $0xc,%esp
    1869:	68 40 bd 00 00       	push   $0xbd40
    186e:	e8 8c 38 00 00       	call   50ff <unlink>
    1873:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
    1876:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    187a:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
    187e:	7e db                	jle    185b <createtest+0x89>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
    1880:	a1 58 75 00 00       	mov    0x7558,%eax
    1885:	83 ec 08             	sub    $0x8,%esp
    1888:	68 d8 59 00 00       	push   $0x59d8
    188d:	50                   	push   %eax
    188e:	e8 a8 39 00 00       	call   523b <printf>
    1893:	83 c4 10             	add    $0x10,%esp
}
    1896:	90                   	nop
    1897:	c9                   	leave  
    1898:	c3                   	ret    

00001899 <dirtest>:

void dirtest(void)
{
    1899:	f3 0f 1e fb          	endbr32 
    189d:	55                   	push   %ebp
    189e:	89 e5                	mov    %esp,%ebp
    18a0:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
    18a3:	a1 58 75 00 00       	mov    0x7558,%eax
    18a8:	83 ec 08             	sub    $0x8,%esp
    18ab:	68 fe 59 00 00       	push   $0x59fe
    18b0:	50                   	push   %eax
    18b1:	e8 85 39 00 00       	call   523b <printf>
    18b6:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
    18b9:	83 ec 0c             	sub    $0xc,%esp
    18bc:	68 0a 5a 00 00       	push   $0x5a0a
    18c1:	e8 51 38 00 00       	call   5117 <mkdir>
    18c6:	83 c4 10             	add    $0x10,%esp
    18c9:	85 c0                	test   %eax,%eax
    18cb:	79 1b                	jns    18e8 <dirtest+0x4f>
    printf(stdout, "mkdir failed\n");
    18cd:	a1 58 75 00 00       	mov    0x7558,%eax
    18d2:	83 ec 08             	sub    $0x8,%esp
    18d5:	68 2d 56 00 00       	push   $0x562d
    18da:	50                   	push   %eax
    18db:	e8 5b 39 00 00       	call   523b <printf>
    18e0:	83 c4 10             	add    $0x10,%esp
    exit();
    18e3:	e8 c7 37 00 00       	call   50af <exit>
  }

  if(chdir("dir0") < 0){
    18e8:	83 ec 0c             	sub    $0xc,%esp
    18eb:	68 0a 5a 00 00       	push   $0x5a0a
    18f0:	e8 2a 38 00 00       	call   511f <chdir>
    18f5:	83 c4 10             	add    $0x10,%esp
    18f8:	85 c0                	test   %eax,%eax
    18fa:	79 1b                	jns    1917 <dirtest+0x7e>
    printf(stdout, "chdir dir0 failed\n");
    18fc:	a1 58 75 00 00       	mov    0x7558,%eax
    1901:	83 ec 08             	sub    $0x8,%esp
    1904:	68 0f 5a 00 00       	push   $0x5a0f
    1909:	50                   	push   %eax
    190a:	e8 2c 39 00 00       	call   523b <printf>
    190f:	83 c4 10             	add    $0x10,%esp
    exit();
    1912:	e8 98 37 00 00       	call   50af <exit>
  }

  if(chdir("..") < 0){
    1917:	83 ec 0c             	sub    $0xc,%esp
    191a:	68 22 5a 00 00       	push   $0x5a22
    191f:	e8 fb 37 00 00       	call   511f <chdir>
    1924:	83 c4 10             	add    $0x10,%esp
    1927:	85 c0                	test   %eax,%eax
    1929:	79 1b                	jns    1946 <dirtest+0xad>
    printf(stdout, "chdir .. failed\n");
    192b:	a1 58 75 00 00       	mov    0x7558,%eax
    1930:	83 ec 08             	sub    $0x8,%esp
    1933:	68 25 5a 00 00       	push   $0x5a25
    1938:	50                   	push   %eax
    1939:	e8 fd 38 00 00       	call   523b <printf>
    193e:	83 c4 10             	add    $0x10,%esp
    exit();
    1941:	e8 69 37 00 00       	call   50af <exit>
  }

  if(unlink("dir0") < 0){
    1946:	83 ec 0c             	sub    $0xc,%esp
    1949:	68 0a 5a 00 00       	push   $0x5a0a
    194e:	e8 ac 37 00 00       	call   50ff <unlink>
    1953:	83 c4 10             	add    $0x10,%esp
    1956:	85 c0                	test   %eax,%eax
    1958:	79 1b                	jns    1975 <dirtest+0xdc>
    printf(stdout, "unlink dir0 failed\n");
    195a:	a1 58 75 00 00       	mov    0x7558,%eax
    195f:	83 ec 08             	sub    $0x8,%esp
    1962:	68 36 5a 00 00       	push   $0x5a36
    1967:	50                   	push   %eax
    1968:	e8 ce 38 00 00       	call   523b <printf>
    196d:	83 c4 10             	add    $0x10,%esp
    exit();
    1970:	e8 3a 37 00 00       	call   50af <exit>
  }
  printf(stdout, "mkdir test ok\n");
    1975:	a1 58 75 00 00       	mov    0x7558,%eax
    197a:	83 ec 08             	sub    $0x8,%esp
    197d:	68 4a 5a 00 00       	push   $0x5a4a
    1982:	50                   	push   %eax
    1983:	e8 b3 38 00 00       	call   523b <printf>
    1988:	83 c4 10             	add    $0x10,%esp
}
    198b:	90                   	nop
    198c:	c9                   	leave  
    198d:	c3                   	ret    

0000198e <exectest>:

void
exectest(void)
{
    198e:	f3 0f 1e fb          	endbr32 
    1992:	55                   	push   %ebp
    1993:	89 e5                	mov    %esp,%ebp
    1995:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
    1998:	a1 58 75 00 00       	mov    0x7558,%eax
    199d:	83 ec 08             	sub    $0x8,%esp
    19a0:	68 59 5a 00 00       	push   $0x5a59
    19a5:	50                   	push   %eax
    19a6:	e8 90 38 00 00       	call   523b <printf>
    19ab:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
    19ae:	83 ec 08             	sub    $0x8,%esp
    19b1:	68 44 75 00 00       	push   $0x7544
    19b6:	68 04 56 00 00       	push   $0x5604
    19bb:	e8 27 37 00 00       	call   50e7 <exec>
    19c0:	83 c4 10             	add    $0x10,%esp
    19c3:	85 c0                	test   %eax,%eax
    19c5:	79 1b                	jns    19e2 <exectest+0x54>
    printf(stdout, "exec echo failed\n");
    19c7:	a1 58 75 00 00       	mov    0x7558,%eax
    19cc:	83 ec 08             	sub    $0x8,%esp
    19cf:	68 64 5a 00 00       	push   $0x5a64
    19d4:	50                   	push   %eax
    19d5:	e8 61 38 00 00       	call   523b <printf>
    19da:	83 c4 10             	add    $0x10,%esp
    exit();
    19dd:	e8 cd 36 00 00       	call   50af <exit>
  }
}
    19e2:	90                   	nop
    19e3:	c9                   	leave  
    19e4:	c3                   	ret    

000019e5 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
    19e5:	f3 0f 1e fb          	endbr32 
    19e9:	55                   	push   %ebp
    19ea:	89 e5                	mov    %esp,%ebp
    19ec:	83 ec 28             	sub    $0x28,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    19ef:	83 ec 0c             	sub    $0xc,%esp
    19f2:	8d 45 d8             	lea    -0x28(%ebp),%eax
    19f5:	50                   	push   %eax
    19f6:	e8 c4 36 00 00       	call   50bf <pipe>
    19fb:	83 c4 10             	add    $0x10,%esp
    19fe:	85 c0                	test   %eax,%eax
    1a00:	74 17                	je     1a19 <pipe1+0x34>
    printf(1, "pipe() failed\n");
    1a02:	83 ec 08             	sub    $0x8,%esp
    1a05:	68 76 5a 00 00       	push   $0x5a76
    1a0a:	6a 01                	push   $0x1
    1a0c:	e8 2a 38 00 00       	call   523b <printf>
    1a11:	83 c4 10             	add    $0x10,%esp
    exit();
    1a14:	e8 96 36 00 00       	call   50af <exit>
  }
  pid = fork();
    1a19:	e8 89 36 00 00       	call   50a7 <fork>
    1a1e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
    1a21:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
    1a28:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    1a2c:	0f 85 89 00 00 00    	jne    1abb <pipe1+0xd6>
    close(fds[0]);
    1a32:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a35:	83 ec 0c             	sub    $0xc,%esp
    1a38:	50                   	push   %eax
    1a39:	e8 99 36 00 00       	call   50d7 <close>
    1a3e:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
    1a41:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1a48:	eb 66                	jmp    1ab0 <pipe1+0xcb>
      for(i = 0; i < 1033; i++)
    1a4a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1a51:	eb 19                	jmp    1a6c <pipe1+0x87>
        buf[i] = seq++;
    1a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a56:	8d 50 01             	lea    0x1(%eax),%edx
    1a59:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1a5c:	89 c2                	mov    %eax,%edx
    1a5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a61:	05 40 9d 00 00       	add    $0x9d40,%eax
    1a66:	88 10                	mov    %dl,(%eax)
      for(i = 0; i < 1033; i++)
    1a68:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1a6c:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
    1a73:	7e de                	jle    1a53 <pipe1+0x6e>
      if(write(fds[1], buf, 1033) != 1033){
    1a75:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a78:	83 ec 04             	sub    $0x4,%esp
    1a7b:	68 09 04 00 00       	push   $0x409
    1a80:	68 40 9d 00 00       	push   $0x9d40
    1a85:	50                   	push   %eax
    1a86:	e8 44 36 00 00       	call   50cf <write>
    1a8b:	83 c4 10             	add    $0x10,%esp
    1a8e:	3d 09 04 00 00       	cmp    $0x409,%eax
    1a93:	74 17                	je     1aac <pipe1+0xc7>
        printf(1, "pipe1 oops 1\n");
    1a95:	83 ec 08             	sub    $0x8,%esp
    1a98:	68 85 5a 00 00       	push   $0x5a85
    1a9d:	6a 01                	push   $0x1
    1a9f:	e8 97 37 00 00       	call   523b <printf>
    1aa4:	83 c4 10             	add    $0x10,%esp
        exit();
    1aa7:	e8 03 36 00 00       	call   50af <exit>
    for(n = 0; n < 5; n++){
    1aac:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1ab0:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
    1ab4:	7e 94                	jle    1a4a <pipe1+0x65>
      }
    }
    exit();
    1ab6:	e8 f4 35 00 00       	call   50af <exit>
  } else if(pid > 0){
    1abb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    1abf:	0f 8e f4 00 00 00    	jle    1bb9 <pipe1+0x1d4>
    close(fds[1]);
    1ac5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ac8:	83 ec 0c             	sub    $0xc,%esp
    1acb:	50                   	push   %eax
    1acc:	e8 06 36 00 00       	call   50d7 <close>
    1ad1:	83 c4 10             	add    $0x10,%esp
    total = 0;
    1ad4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
    1adb:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
    1ae2:	eb 66                	jmp    1b4a <pipe1+0x165>
      for(i = 0; i < n; i++){
    1ae4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1aeb:	eb 3b                	jmp    1b28 <pipe1+0x143>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1aed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1af0:	05 40 9d 00 00       	add    $0x9d40,%eax
    1af5:	0f b6 00             	movzbl (%eax),%eax
    1af8:	0f be c8             	movsbl %al,%ecx
    1afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1afe:	8d 50 01             	lea    0x1(%eax),%edx
    1b01:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1b04:	31 c8                	xor    %ecx,%eax
    1b06:	0f b6 c0             	movzbl %al,%eax
    1b09:	85 c0                	test   %eax,%eax
    1b0b:	74 17                	je     1b24 <pipe1+0x13f>
          printf(1, "pipe1 oops 2\n");
    1b0d:	83 ec 08             	sub    $0x8,%esp
    1b10:	68 93 5a 00 00       	push   $0x5a93
    1b15:	6a 01                	push   $0x1
    1b17:	e8 1f 37 00 00       	call   523b <printf>
    1b1c:	83 c4 10             	add    $0x10,%esp
    1b1f:	e9 ac 00 00 00       	jmp    1bd0 <pipe1+0x1eb>
      for(i = 0; i < n; i++){
    1b24:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1b28:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b2b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1b2e:	7c bd                	jl     1aed <pipe1+0x108>
          return;
        }
      }
      total += n;
    1b30:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b33:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
    1b36:	d1 65 e8             	shll   -0x18(%ebp)
      if(cc > sizeof(buf))
    1b39:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1b3c:	3d 00 20 00 00       	cmp    $0x2000,%eax
    1b41:	76 07                	jbe    1b4a <pipe1+0x165>
        cc = sizeof(buf);
    1b43:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
    1b4a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b4d:	83 ec 04             	sub    $0x4,%esp
    1b50:	ff 75 e8             	pushl  -0x18(%ebp)
    1b53:	68 40 9d 00 00       	push   $0x9d40
    1b58:	50                   	push   %eax
    1b59:	e8 69 35 00 00       	call   50c7 <read>
    1b5e:	83 c4 10             	add    $0x10,%esp
    1b61:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b64:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b68:	0f 8f 76 ff ff ff    	jg     1ae4 <pipe1+0xff>
    }
    if(total != 5 * 1033){
    1b6e:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
    1b75:	74 1a                	je     1b91 <pipe1+0x1ac>
      printf(1, "pipe1 oops 3 total %d\n", total);
    1b77:	83 ec 04             	sub    $0x4,%esp
    1b7a:	ff 75 e4             	pushl  -0x1c(%ebp)
    1b7d:	68 a1 5a 00 00       	push   $0x5aa1
    1b82:	6a 01                	push   $0x1
    1b84:	e8 b2 36 00 00       	call   523b <printf>
    1b89:	83 c4 10             	add    $0x10,%esp
      exit();
    1b8c:	e8 1e 35 00 00       	call   50af <exit>
    }
    close(fds[0]);
    1b91:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b94:	83 ec 0c             	sub    $0xc,%esp
    1b97:	50                   	push   %eax
    1b98:	e8 3a 35 00 00       	call   50d7 <close>
    1b9d:	83 c4 10             	add    $0x10,%esp
    wait();
    1ba0:	e8 12 35 00 00       	call   50b7 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
    1ba5:	83 ec 08             	sub    $0x8,%esp
    1ba8:	68 c7 5a 00 00       	push   $0x5ac7
    1bad:	6a 01                	push   $0x1
    1baf:	e8 87 36 00 00       	call   523b <printf>
    1bb4:	83 c4 10             	add    $0x10,%esp
    1bb7:	eb 17                	jmp    1bd0 <pipe1+0x1eb>
    printf(1, "fork() failed\n");
    1bb9:	83 ec 08             	sub    $0x8,%esp
    1bbc:	68 b8 5a 00 00       	push   $0x5ab8
    1bc1:	6a 01                	push   $0x1
    1bc3:	e8 73 36 00 00       	call   523b <printf>
    1bc8:	83 c4 10             	add    $0x10,%esp
    exit();
    1bcb:	e8 df 34 00 00       	call   50af <exit>
}
    1bd0:	c9                   	leave  
    1bd1:	c3                   	ret    

00001bd2 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
    1bd2:	f3 0f 1e fb          	endbr32 
    1bd6:	55                   	push   %ebp
    1bd7:	89 e5                	mov    %esp,%ebp
    1bd9:	83 ec 28             	sub    $0x28,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
    1bdc:	83 ec 08             	sub    $0x8,%esp
    1bdf:	68 d1 5a 00 00       	push   $0x5ad1
    1be4:	6a 01                	push   $0x1
    1be6:	e8 50 36 00 00       	call   523b <printf>
    1beb:	83 c4 10             	add    $0x10,%esp
  pid1 = fork();
    1bee:	e8 b4 34 00 00       	call   50a7 <fork>
    1bf3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
    1bf6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1bfa:	75 02                	jne    1bfe <preempt+0x2c>
    for(;;)
    1bfc:	eb fe                	jmp    1bfc <preempt+0x2a>
      ;

  pid2 = fork();
    1bfe:	e8 a4 34 00 00       	call   50a7 <fork>
    1c03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
    1c06:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c0a:	75 02                	jne    1c0e <preempt+0x3c>
    for(;;)
    1c0c:	eb fe                	jmp    1c0c <preempt+0x3a>
      ;

  pipe(pfds);
    1c0e:	83 ec 0c             	sub    $0xc,%esp
    1c11:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1c14:	50                   	push   %eax
    1c15:	e8 a5 34 00 00       	call   50bf <pipe>
    1c1a:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
    1c1d:	e8 85 34 00 00       	call   50a7 <fork>
    1c22:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
    1c25:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c29:	75 4d                	jne    1c78 <preempt+0xa6>
    close(pfds[0]);
    1c2b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c2e:	83 ec 0c             	sub    $0xc,%esp
    1c31:	50                   	push   %eax
    1c32:	e8 a0 34 00 00       	call   50d7 <close>
    1c37:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
    1c3a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c3d:	83 ec 04             	sub    $0x4,%esp
    1c40:	6a 01                	push   $0x1
    1c42:	68 db 5a 00 00       	push   $0x5adb
    1c47:	50                   	push   %eax
    1c48:	e8 82 34 00 00       	call   50cf <write>
    1c4d:	83 c4 10             	add    $0x10,%esp
    1c50:	83 f8 01             	cmp    $0x1,%eax
    1c53:	74 12                	je     1c67 <preempt+0x95>
      printf(1, "preempt write error");
    1c55:	83 ec 08             	sub    $0x8,%esp
    1c58:	68 dd 5a 00 00       	push   $0x5add
    1c5d:	6a 01                	push   $0x1
    1c5f:	e8 d7 35 00 00       	call   523b <printf>
    1c64:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
    1c67:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c6a:	83 ec 0c             	sub    $0xc,%esp
    1c6d:	50                   	push   %eax
    1c6e:	e8 64 34 00 00       	call   50d7 <close>
    1c73:	83 c4 10             	add    $0x10,%esp
    for(;;)
    1c76:	eb fe                	jmp    1c76 <preempt+0xa4>
      ;
  }

  close(pfds[1]);
    1c78:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c7b:	83 ec 0c             	sub    $0xc,%esp
    1c7e:	50                   	push   %eax
    1c7f:	e8 53 34 00 00       	call   50d7 <close>
    1c84:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    1c87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c8a:	83 ec 04             	sub    $0x4,%esp
    1c8d:	68 00 20 00 00       	push   $0x2000
    1c92:	68 40 9d 00 00       	push   $0x9d40
    1c97:	50                   	push   %eax
    1c98:	e8 2a 34 00 00       	call   50c7 <read>
    1c9d:	83 c4 10             	add    $0x10,%esp
    1ca0:	83 f8 01             	cmp    $0x1,%eax
    1ca3:	74 14                	je     1cb9 <preempt+0xe7>
    printf(1, "preempt read error");
    1ca5:	83 ec 08             	sub    $0x8,%esp
    1ca8:	68 f1 5a 00 00       	push   $0x5af1
    1cad:	6a 01                	push   $0x1
    1caf:	e8 87 35 00 00       	call   523b <printf>
    1cb4:	83 c4 10             	add    $0x10,%esp
    1cb7:	eb 7e                	jmp    1d37 <preempt+0x165>
    return;
  }
  close(pfds[0]);
    1cb9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cbc:	83 ec 0c             	sub    $0xc,%esp
    1cbf:	50                   	push   %eax
    1cc0:	e8 12 34 00 00       	call   50d7 <close>
    1cc5:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
    1cc8:	83 ec 08             	sub    $0x8,%esp
    1ccb:	68 04 5b 00 00       	push   $0x5b04
    1cd0:	6a 01                	push   $0x1
    1cd2:	e8 64 35 00 00       	call   523b <printf>
    1cd7:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
    1cda:	83 ec 0c             	sub    $0xc,%esp
    1cdd:	ff 75 f4             	pushl  -0xc(%ebp)
    1ce0:	e8 fa 33 00 00       	call   50df <kill>
    1ce5:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
    1ce8:	83 ec 0c             	sub    $0xc,%esp
    1ceb:	ff 75 f0             	pushl  -0x10(%ebp)
    1cee:	e8 ec 33 00 00       	call   50df <kill>
    1cf3:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
    1cf6:	83 ec 0c             	sub    $0xc,%esp
    1cf9:	ff 75 ec             	pushl  -0x14(%ebp)
    1cfc:	e8 de 33 00 00       	call   50df <kill>
    1d01:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
    1d04:	83 ec 08             	sub    $0x8,%esp
    1d07:	68 0d 5b 00 00       	push   $0x5b0d
    1d0c:	6a 01                	push   $0x1
    1d0e:	e8 28 35 00 00       	call   523b <printf>
    1d13:	83 c4 10             	add    $0x10,%esp
  wait();
    1d16:	e8 9c 33 00 00       	call   50b7 <wait>
  wait();
    1d1b:	e8 97 33 00 00       	call   50b7 <wait>
  wait();
    1d20:	e8 92 33 00 00       	call   50b7 <wait>
  printf(1, "preempt ok\n");
    1d25:	83 ec 08             	sub    $0x8,%esp
    1d28:	68 16 5b 00 00       	push   $0x5b16
    1d2d:	6a 01                	push   $0x1
    1d2f:	e8 07 35 00 00       	call   523b <printf>
    1d34:	83 c4 10             	add    $0x10,%esp
}
    1d37:	c9                   	leave  
    1d38:	c3                   	ret    

00001d39 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
    1d39:	f3 0f 1e fb          	endbr32 
    1d3d:	55                   	push   %ebp
    1d3e:	89 e5                	mov    %esp,%ebp
    1d40:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
    1d43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d4a:	eb 4f                	jmp    1d9b <exitwait+0x62>
    pid = fork();
    1d4c:	e8 56 33 00 00       	call   50a7 <fork>
    1d51:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
    1d54:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d58:	79 14                	jns    1d6e <exitwait+0x35>
      printf(1, "fork failed\n");
    1d5a:	83 ec 08             	sub    $0x8,%esp
    1d5d:	68 a5 56 00 00       	push   $0x56a5
    1d62:	6a 01                	push   $0x1
    1d64:	e8 d2 34 00 00       	call   523b <printf>
    1d69:	83 c4 10             	add    $0x10,%esp
      return;
    1d6c:	eb 45                	jmp    1db3 <exitwait+0x7a>
    }
    if(pid){
    1d6e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d72:	74 1e                	je     1d92 <exitwait+0x59>
      if(wait() != pid){
    1d74:	e8 3e 33 00 00       	call   50b7 <wait>
    1d79:	39 45 f0             	cmp    %eax,-0x10(%ebp)
    1d7c:	74 19                	je     1d97 <exitwait+0x5e>
        printf(1, "wait wrong pid\n");
    1d7e:	83 ec 08             	sub    $0x8,%esp
    1d81:	68 22 5b 00 00       	push   $0x5b22
    1d86:	6a 01                	push   $0x1
    1d88:	e8 ae 34 00 00       	call   523b <printf>
    1d8d:	83 c4 10             	add    $0x10,%esp
        return;
    1d90:	eb 21                	jmp    1db3 <exitwait+0x7a>
      }
    } else {
      exit();
    1d92:	e8 18 33 00 00       	call   50af <exit>
  for(i = 0; i < 100; i++){
    1d97:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1d9b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1d9f:	7e ab                	jle    1d4c <exitwait+0x13>
    }
  }
  printf(1, "exitwait ok\n");
    1da1:	83 ec 08             	sub    $0x8,%esp
    1da4:	68 32 5b 00 00       	push   $0x5b32
    1da9:	6a 01                	push   $0x1
    1dab:	e8 8b 34 00 00       	call   523b <printf>
    1db0:	83 c4 10             	add    $0x10,%esp
}
    1db3:	c9                   	leave  
    1db4:	c3                   	ret    

00001db5 <mem>:

void
mem(void)
{
    1db5:	f3 0f 1e fb          	endbr32 
    1db9:	55                   	push   %ebp
    1dba:	89 e5                	mov    %esp,%ebp
    1dbc:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
    1dbf:	83 ec 08             	sub    $0x8,%esp
    1dc2:	68 3f 5b 00 00       	push   $0x5b3f
    1dc7:	6a 01                	push   $0x1
    1dc9:	e8 6d 34 00 00       	call   523b <printf>
    1dce:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
    1dd1:	e8 59 33 00 00       	call   512f <getpid>
    1dd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
    1dd9:	e8 c9 32 00 00       	call   50a7 <fork>
    1dde:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1de1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1de5:	0f 85 b7 00 00 00    	jne    1ea2 <mem+0xed>
    m1 = 0;
    1deb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
    1df2:	eb 0e                	jmp    1e02 <mem+0x4d>
      *(char**)m2 = m1;
    1df4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1df7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1dfa:	89 10                	mov    %edx,(%eax)
      m1 = m2;
    1dfc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1dff:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
    1e02:	83 ec 0c             	sub    $0xc,%esp
    1e05:	68 11 27 00 00       	push   $0x2711
    1e0a:	e8 0c 37 00 00       	call   551b <malloc>
    1e0f:	83 c4 10             	add    $0x10,%esp
    1e12:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1e15:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1e19:	75 d9                	jne    1df4 <mem+0x3f>
    }
    while(m1){
    1e1b:	eb 1c                	jmp    1e39 <mem+0x84>
      m2 = *(char**)m1;
    1e1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e20:	8b 00                	mov    (%eax),%eax
    1e22:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
    1e25:	83 ec 0c             	sub    $0xc,%esp
    1e28:	ff 75 f4             	pushl  -0xc(%ebp)
    1e2b:	e8 a1 35 00 00       	call   53d1 <free>
    1e30:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
    1e33:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1e36:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(m1){
    1e39:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e3d:	75 de                	jne    1e1d <mem+0x68>
    }
    m1 = malloc(1024*20);
    1e3f:	83 ec 0c             	sub    $0xc,%esp
    1e42:	68 00 50 00 00       	push   $0x5000
    1e47:	e8 cf 36 00 00       	call   551b <malloc>
    1e4c:	83 c4 10             	add    $0x10,%esp
    1e4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
    1e52:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e56:	75 25                	jne    1e7d <mem+0xc8>
      printf(1, "couldn't allocate mem?!!\n");
    1e58:	83 ec 08             	sub    $0x8,%esp
    1e5b:	68 49 5b 00 00       	push   $0x5b49
    1e60:	6a 01                	push   $0x1
    1e62:	e8 d4 33 00 00       	call   523b <printf>
    1e67:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    1e6a:	83 ec 0c             	sub    $0xc,%esp
    1e6d:	ff 75 f0             	pushl  -0x10(%ebp)
    1e70:	e8 6a 32 00 00       	call   50df <kill>
    1e75:	83 c4 10             	add    $0x10,%esp
      exit();
    1e78:	e8 32 32 00 00       	call   50af <exit>
    }
    free(m1);
    1e7d:	83 ec 0c             	sub    $0xc,%esp
    1e80:	ff 75 f4             	pushl  -0xc(%ebp)
    1e83:	e8 49 35 00 00       	call   53d1 <free>
    1e88:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
    1e8b:	83 ec 08             	sub    $0x8,%esp
    1e8e:	68 63 5b 00 00       	push   $0x5b63
    1e93:	6a 01                	push   $0x1
    1e95:	e8 a1 33 00 00       	call   523b <printf>
    1e9a:	83 c4 10             	add    $0x10,%esp
    exit();
    1e9d:	e8 0d 32 00 00       	call   50af <exit>
  } else {
    wait();
    1ea2:	e8 10 32 00 00       	call   50b7 <wait>
  }
}
    1ea7:	90                   	nop
    1ea8:	c9                   	leave  
    1ea9:	c3                   	ret    

00001eaa <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    1eaa:	f3 0f 1e fb          	endbr32 
    1eae:	55                   	push   %ebp
    1eaf:	89 e5                	mov    %esp,%ebp
    1eb1:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
    1eb4:	83 ec 08             	sub    $0x8,%esp
    1eb7:	68 6b 5b 00 00       	push   $0x5b6b
    1ebc:	6a 01                	push   $0x1
    1ebe:	e8 78 33 00 00       	call   523b <printf>
    1ec3:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
    1ec6:	83 ec 0c             	sub    $0xc,%esp
    1ec9:	68 7a 5b 00 00       	push   $0x5b7a
    1ece:	e8 2c 32 00 00       	call   50ff <unlink>
    1ed3:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
    1ed6:	83 ec 08             	sub    $0x8,%esp
    1ed9:	68 02 02 00 00       	push   $0x202
    1ede:	68 7a 5b 00 00       	push   $0x5b7a
    1ee3:	e8 07 32 00 00       	call   50ef <open>
    1ee8:	83 c4 10             	add    $0x10,%esp
    1eeb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
    1eee:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1ef2:	79 17                	jns    1f0b <sharedfd+0x61>
    printf(1, "fstests: cannot open sharedfd for writing");
    1ef4:	83 ec 08             	sub    $0x8,%esp
    1ef7:	68 84 5b 00 00       	push   $0x5b84
    1efc:	6a 01                	push   $0x1
    1efe:	e8 38 33 00 00       	call   523b <printf>
    1f03:	83 c4 10             	add    $0x10,%esp
    return;
    1f06:	e9 84 01 00 00       	jmp    208f <sharedfd+0x1e5>
  }
  pid = fork();
    1f0b:	e8 97 31 00 00       	call   50a7 <fork>
    1f10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1f13:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1f17:	75 07                	jne    1f20 <sharedfd+0x76>
    1f19:	b8 63 00 00 00       	mov    $0x63,%eax
    1f1e:	eb 05                	jmp    1f25 <sharedfd+0x7b>
    1f20:	b8 70 00 00 00       	mov    $0x70,%eax
    1f25:	83 ec 04             	sub    $0x4,%esp
    1f28:	6a 0a                	push   $0xa
    1f2a:	50                   	push   %eax
    1f2b:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    1f2e:	50                   	push   %eax
    1f2f:	e8 c8 2f 00 00       	call   4efc <memset>
    1f34:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
    1f37:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1f3e:	eb 31                	jmp    1f71 <sharedfd+0xc7>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    1f40:	83 ec 04             	sub    $0x4,%esp
    1f43:	6a 0a                	push   $0xa
    1f45:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    1f48:	50                   	push   %eax
    1f49:	ff 75 e8             	pushl  -0x18(%ebp)
    1f4c:	e8 7e 31 00 00       	call   50cf <write>
    1f51:	83 c4 10             	add    $0x10,%esp
    1f54:	83 f8 0a             	cmp    $0xa,%eax
    1f57:	74 14                	je     1f6d <sharedfd+0xc3>
      printf(1, "fstests: write sharedfd failed\n");
    1f59:	83 ec 08             	sub    $0x8,%esp
    1f5c:	68 b0 5b 00 00       	push   $0x5bb0
    1f61:	6a 01                	push   $0x1
    1f63:	e8 d3 32 00 00       	call   523b <printf>
    1f68:	83 c4 10             	add    $0x10,%esp
      break;
    1f6b:	eb 0d                	jmp    1f7a <sharedfd+0xd0>
  for(i = 0; i < 1000; i++){
    1f6d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f71:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    1f78:	7e c6                	jle    1f40 <sharedfd+0x96>
    }
  }
  if(pid == 0)
    1f7a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1f7e:	75 05                	jne    1f85 <sharedfd+0xdb>
    exit();
    1f80:	e8 2a 31 00 00       	call   50af <exit>
  else
    wait();
    1f85:	e8 2d 31 00 00       	call   50b7 <wait>
  close(fd);
    1f8a:	83 ec 0c             	sub    $0xc,%esp
    1f8d:	ff 75 e8             	pushl  -0x18(%ebp)
    1f90:	e8 42 31 00 00       	call   50d7 <close>
    1f95:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
    1f98:	83 ec 08             	sub    $0x8,%esp
    1f9b:	6a 00                	push   $0x0
    1f9d:	68 7a 5b 00 00       	push   $0x5b7a
    1fa2:	e8 48 31 00 00       	call   50ef <open>
    1fa7:	83 c4 10             	add    $0x10,%esp
    1faa:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
    1fad:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1fb1:	79 17                	jns    1fca <sharedfd+0x120>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    1fb3:	83 ec 08             	sub    $0x8,%esp
    1fb6:	68 d0 5b 00 00       	push   $0x5bd0
    1fbb:	6a 01                	push   $0x1
    1fbd:	e8 79 32 00 00       	call   523b <printf>
    1fc2:	83 c4 10             	add    $0x10,%esp
    return;
    1fc5:	e9 c5 00 00 00       	jmp    208f <sharedfd+0x1e5>
  }
  nc = np = 0;
    1fca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1fd1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1fd7:	eb 3b                	jmp    2014 <sharedfd+0x16a>
    for(i = 0; i < sizeof(buf); i++){
    1fd9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1fe0:	eb 2a                	jmp    200c <sharedfd+0x162>
      if(buf[i] == 'c')
    1fe2:	8d 55 d6             	lea    -0x2a(%ebp),%edx
    1fe5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fe8:	01 d0                	add    %edx,%eax
    1fea:	0f b6 00             	movzbl (%eax),%eax
    1fed:	3c 63                	cmp    $0x63,%al
    1fef:	75 04                	jne    1ff5 <sharedfd+0x14b>
        nc++;
    1ff1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(buf[i] == 'p')
    1ff5:	8d 55 d6             	lea    -0x2a(%ebp),%edx
    1ff8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ffb:	01 d0                	add    %edx,%eax
    1ffd:	0f b6 00             	movzbl (%eax),%eax
    2000:	3c 70                	cmp    $0x70,%al
    2002:	75 04                	jne    2008 <sharedfd+0x15e>
        np++;
    2004:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    for(i = 0; i < sizeof(buf); i++){
    2008:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    200c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    200f:	83 f8 09             	cmp    $0x9,%eax
    2012:	76 ce                	jbe    1fe2 <sharedfd+0x138>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2014:	83 ec 04             	sub    $0x4,%esp
    2017:	6a 0a                	push   $0xa
    2019:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    201c:	50                   	push   %eax
    201d:	ff 75 e8             	pushl  -0x18(%ebp)
    2020:	e8 a2 30 00 00       	call   50c7 <read>
    2025:	83 c4 10             	add    $0x10,%esp
    2028:	89 45 e0             	mov    %eax,-0x20(%ebp)
    202b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    202f:	7f a8                	jg     1fd9 <sharedfd+0x12f>
    }
  }
  close(fd);
    2031:	83 ec 0c             	sub    $0xc,%esp
    2034:	ff 75 e8             	pushl  -0x18(%ebp)
    2037:	e8 9b 30 00 00       	call   50d7 <close>
    203c:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
    203f:	83 ec 0c             	sub    $0xc,%esp
    2042:	68 7a 5b 00 00       	push   $0x5b7a
    2047:	e8 b3 30 00 00       	call   50ff <unlink>
    204c:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
    204f:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
    2056:	75 1d                	jne    2075 <sharedfd+0x1cb>
    2058:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
    205f:	75 14                	jne    2075 <sharedfd+0x1cb>
    printf(1, "sharedfd ok\n");
    2061:	83 ec 08             	sub    $0x8,%esp
    2064:	68 fb 5b 00 00       	push   $0x5bfb
    2069:	6a 01                	push   $0x1
    206b:	e8 cb 31 00 00       	call   523b <printf>
    2070:	83 c4 10             	add    $0x10,%esp
    2073:	eb 1a                	jmp    208f <sharedfd+0x1e5>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    2075:	ff 75 ec             	pushl  -0x14(%ebp)
    2078:	ff 75 f0             	pushl  -0x10(%ebp)
    207b:	68 08 5c 00 00       	push   $0x5c08
    2080:	6a 01                	push   $0x1
    2082:	e8 b4 31 00 00       	call   523b <printf>
    2087:	83 c4 10             	add    $0x10,%esp
    exit();
    208a:	e8 20 30 00 00       	call   50af <exit>
  }
}
    208f:	c9                   	leave  
    2090:	c3                   	ret    

00002091 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    2091:	f3 0f 1e fb          	endbr32 
    2095:	55                   	push   %ebp
    2096:	89 e5                	mov    %esp,%ebp
    2098:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    209b:	c7 45 c8 1d 5c 00 00 	movl   $0x5c1d,-0x38(%ebp)
    20a2:	c7 45 cc 20 5c 00 00 	movl   $0x5c20,-0x34(%ebp)
    20a9:	c7 45 d0 23 5c 00 00 	movl   $0x5c23,-0x30(%ebp)
    20b0:	c7 45 d4 26 5c 00 00 	movl   $0x5c26,-0x2c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    20b7:	83 ec 08             	sub    $0x8,%esp
    20ba:	68 29 5c 00 00       	push   $0x5c29
    20bf:	6a 01                	push   $0x1
    20c1:	e8 75 31 00 00       	call   523b <printf>
    20c6:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    20c9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    20d0:	e9 f0 00 00 00       	jmp    21c5 <fourfiles+0x134>
    fname = names[pi];
    20d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    20d8:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    20dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    unlink(fname);
    20df:	83 ec 0c             	sub    $0xc,%esp
    20e2:	ff 75 e4             	pushl  -0x1c(%ebp)
    20e5:	e8 15 30 00 00       	call   50ff <unlink>
    20ea:	83 c4 10             	add    $0x10,%esp

    pid = fork();
    20ed:	e8 b5 2f 00 00       	call   50a7 <fork>
    20f2:	89 45 d8             	mov    %eax,-0x28(%ebp)
    if(pid < 0){
    20f5:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    20f9:	79 17                	jns    2112 <fourfiles+0x81>
      printf(1, "fork failed\n");
    20fb:	83 ec 08             	sub    $0x8,%esp
    20fe:	68 a5 56 00 00       	push   $0x56a5
    2103:	6a 01                	push   $0x1
    2105:	e8 31 31 00 00       	call   523b <printf>
    210a:	83 c4 10             	add    $0x10,%esp
      exit();
    210d:	e8 9d 2f 00 00       	call   50af <exit>
    }

    if(pid == 0){
    2112:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    2116:	0f 85 a5 00 00 00    	jne    21c1 <fourfiles+0x130>
      fd = open(fname, O_CREATE | O_RDWR);
    211c:	83 ec 08             	sub    $0x8,%esp
    211f:	68 02 02 00 00       	push   $0x202
    2124:	ff 75 e4             	pushl  -0x1c(%ebp)
    2127:	e8 c3 2f 00 00       	call   50ef <open>
    212c:	83 c4 10             	add    $0x10,%esp
    212f:	89 45 e0             	mov    %eax,-0x20(%ebp)
      if(fd < 0){
    2132:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    2136:	79 17                	jns    214f <fourfiles+0xbe>
        printf(1, "create failed\n");
    2138:	83 ec 08             	sub    $0x8,%esp
    213b:	68 39 5c 00 00       	push   $0x5c39
    2140:	6a 01                	push   $0x1
    2142:	e8 f4 30 00 00       	call   523b <printf>
    2147:	83 c4 10             	add    $0x10,%esp
        exit();
    214a:	e8 60 2f 00 00       	call   50af <exit>
      }

      memset(buf, '0'+pi, 512);
    214f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2152:	83 c0 30             	add    $0x30,%eax
    2155:	83 ec 04             	sub    $0x4,%esp
    2158:	68 00 02 00 00       	push   $0x200
    215d:	50                   	push   %eax
    215e:	68 40 9d 00 00       	push   $0x9d40
    2163:	e8 94 2d 00 00       	call   4efc <memset>
    2168:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
    216b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2172:	eb 42                	jmp    21b6 <fourfiles+0x125>
        if((n = write(fd, buf, 500)) != 500){
    2174:	83 ec 04             	sub    $0x4,%esp
    2177:	68 f4 01 00 00       	push   $0x1f4
    217c:	68 40 9d 00 00       	push   $0x9d40
    2181:	ff 75 e0             	pushl  -0x20(%ebp)
    2184:	e8 46 2f 00 00       	call   50cf <write>
    2189:	83 c4 10             	add    $0x10,%esp
    218c:	89 45 dc             	mov    %eax,-0x24(%ebp)
    218f:	81 7d dc f4 01 00 00 	cmpl   $0x1f4,-0x24(%ebp)
    2196:	74 1a                	je     21b2 <fourfiles+0x121>
          printf(1, "write failed %d\n", n);
    2198:	83 ec 04             	sub    $0x4,%esp
    219b:	ff 75 dc             	pushl  -0x24(%ebp)
    219e:	68 48 5c 00 00       	push   $0x5c48
    21a3:	6a 01                	push   $0x1
    21a5:	e8 91 30 00 00       	call   523b <printf>
    21aa:	83 c4 10             	add    $0x10,%esp
          exit();
    21ad:	e8 fd 2e 00 00       	call   50af <exit>
      for(i = 0; i < 12; i++){
    21b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    21b6:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    21ba:	7e b8                	jle    2174 <fourfiles+0xe3>
        }
      }
      exit();
    21bc:	e8 ee 2e 00 00       	call   50af <exit>
  for(pi = 0; pi < 4; pi++){
    21c1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    21c5:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    21c9:	0f 8e 06 ff ff ff    	jle    20d5 <fourfiles+0x44>
    }
  }

  for(pi = 0; pi < 4; pi++){
    21cf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    21d6:	eb 09                	jmp    21e1 <fourfiles+0x150>
    wait();
    21d8:	e8 da 2e 00 00       	call   50b7 <wait>
  for(pi = 0; pi < 4; pi++){
    21dd:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    21e1:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    21e5:	7e f1                	jle    21d8 <fourfiles+0x147>
  }

  for(i = 0; i < 2; i++){
    21e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    21ee:	e9 d4 00 00 00       	jmp    22c7 <fourfiles+0x236>
    fname = names[i];
    21f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21f6:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    21fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    fd = open(fname, 0);
    21fd:	83 ec 08             	sub    $0x8,%esp
    2200:	6a 00                	push   $0x0
    2202:	ff 75 e4             	pushl  -0x1c(%ebp)
    2205:	e8 e5 2e 00 00       	call   50ef <open>
    220a:	83 c4 10             	add    $0x10,%esp
    220d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    total = 0;
    2210:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2217:	eb 4a                	jmp    2263 <fourfiles+0x1d2>
      for(j = 0; j < n; j++){
    2219:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2220:	eb 33                	jmp    2255 <fourfiles+0x1c4>
        if(buf[j] != '0'+i){
    2222:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2225:	05 40 9d 00 00       	add    $0x9d40,%eax
    222a:	0f b6 00             	movzbl (%eax),%eax
    222d:	0f be c0             	movsbl %al,%eax
    2230:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2233:	83 c2 30             	add    $0x30,%edx
    2236:	39 d0                	cmp    %edx,%eax
    2238:	74 17                	je     2251 <fourfiles+0x1c0>
          printf(1, "wrong char\n");
    223a:	83 ec 08             	sub    $0x8,%esp
    223d:	68 59 5c 00 00       	push   $0x5c59
    2242:	6a 01                	push   $0x1
    2244:	e8 f2 2f 00 00       	call   523b <printf>
    2249:	83 c4 10             	add    $0x10,%esp
          exit();
    224c:	e8 5e 2e 00 00       	call   50af <exit>
      for(j = 0; j < n; j++){
    2251:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2255:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2258:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    225b:	7c c5                	jl     2222 <fourfiles+0x191>
        }
      }
      total += n;
    225d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2260:	01 45 ec             	add    %eax,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2263:	83 ec 04             	sub    $0x4,%esp
    2266:	68 00 20 00 00       	push   $0x2000
    226b:	68 40 9d 00 00       	push   $0x9d40
    2270:	ff 75 e0             	pushl  -0x20(%ebp)
    2273:	e8 4f 2e 00 00       	call   50c7 <read>
    2278:	83 c4 10             	add    $0x10,%esp
    227b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    227e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
    2282:	7f 95                	jg     2219 <fourfiles+0x188>
    }
    close(fd);
    2284:	83 ec 0c             	sub    $0xc,%esp
    2287:	ff 75 e0             	pushl  -0x20(%ebp)
    228a:	e8 48 2e 00 00       	call   50d7 <close>
    228f:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
    2292:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
    2299:	74 1a                	je     22b5 <fourfiles+0x224>
      printf(1, "wrong length %d\n", total);
    229b:	83 ec 04             	sub    $0x4,%esp
    229e:	ff 75 ec             	pushl  -0x14(%ebp)
    22a1:	68 65 5c 00 00       	push   $0x5c65
    22a6:	6a 01                	push   $0x1
    22a8:	e8 8e 2f 00 00       	call   523b <printf>
    22ad:	83 c4 10             	add    $0x10,%esp
      exit();
    22b0:	e8 fa 2d 00 00       	call   50af <exit>
    }
    unlink(fname);
    22b5:	83 ec 0c             	sub    $0xc,%esp
    22b8:	ff 75 e4             	pushl  -0x1c(%ebp)
    22bb:	e8 3f 2e 00 00       	call   50ff <unlink>
    22c0:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 2; i++){
    22c3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    22c7:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
    22cb:	0f 8e 22 ff ff ff    	jle    21f3 <fourfiles+0x162>
  }

  printf(1, "fourfiles ok\n");
    22d1:	83 ec 08             	sub    $0x8,%esp
    22d4:	68 76 5c 00 00       	push   $0x5c76
    22d9:	6a 01                	push   $0x1
    22db:	e8 5b 2f 00 00       	call   523b <printf>
    22e0:	83 c4 10             	add    $0x10,%esp
}
    22e3:	90                   	nop
    22e4:	c9                   	leave  
    22e5:	c3                   	ret    

000022e6 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    22e6:	f3 0f 1e fb          	endbr32 
    22ea:	55                   	push   %ebp
    22eb:	89 e5                	mov    %esp,%ebp
    22ed:	83 ec 38             	sub    $0x38,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    22f0:	83 ec 08             	sub    $0x8,%esp
    22f3:	68 84 5c 00 00       	push   $0x5c84
    22f8:	6a 01                	push   $0x1
    22fa:	e8 3c 2f 00 00       	call   523b <printf>
    22ff:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    2302:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2309:	e9 f6 00 00 00       	jmp    2404 <createdelete+0x11e>
    pid = fork();
    230e:	e8 94 2d 00 00       	call   50a7 <fork>
    2313:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    2316:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    231a:	79 17                	jns    2333 <createdelete+0x4d>
      printf(1, "fork failed\n");
    231c:	83 ec 08             	sub    $0x8,%esp
    231f:	68 a5 56 00 00       	push   $0x56a5
    2324:	6a 01                	push   $0x1
    2326:	e8 10 2f 00 00       	call   523b <printf>
    232b:	83 c4 10             	add    $0x10,%esp
      exit();
    232e:	e8 7c 2d 00 00       	call   50af <exit>
    }

    if(pid == 0){
    2333:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2337:	0f 85 c3 00 00 00    	jne    2400 <createdelete+0x11a>
      name[0] = 'p' + pi;
    233d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2340:	83 c0 70             	add    $0x70,%eax
    2343:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[2] = '\0';
    2346:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
      for(i = 0; i < N; i++){
    234a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2351:	e9 9b 00 00 00       	jmp    23f1 <createdelete+0x10b>
        name[1] = '0' + i;
    2356:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2359:	83 c0 30             	add    $0x30,%eax
    235c:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    235f:	83 ec 08             	sub    $0x8,%esp
    2362:	68 02 02 00 00       	push   $0x202
    2367:	8d 45 c8             	lea    -0x38(%ebp),%eax
    236a:	50                   	push   %eax
    236b:	e8 7f 2d 00 00       	call   50ef <open>
    2370:	83 c4 10             	add    $0x10,%esp
    2373:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if(fd < 0){
    2376:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    237a:	79 17                	jns    2393 <createdelete+0xad>
          printf(1, "create failed\n");
    237c:	83 ec 08             	sub    $0x8,%esp
    237f:	68 39 5c 00 00       	push   $0x5c39
    2384:	6a 01                	push   $0x1
    2386:	e8 b0 2e 00 00       	call   523b <printf>
    238b:	83 c4 10             	add    $0x10,%esp
          exit();
    238e:	e8 1c 2d 00 00       	call   50af <exit>
        }
        close(fd);
    2393:	83 ec 0c             	sub    $0xc,%esp
    2396:	ff 75 ec             	pushl  -0x14(%ebp)
    2399:	e8 39 2d 00 00       	call   50d7 <close>
    239e:	83 c4 10             	add    $0x10,%esp
        if(i > 0 && (i % 2 ) == 0){
    23a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23a5:	7e 46                	jle    23ed <createdelete+0x107>
    23a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23aa:	83 e0 01             	and    $0x1,%eax
    23ad:	85 c0                	test   %eax,%eax
    23af:	75 3c                	jne    23ed <createdelete+0x107>
          name[1] = '0' + (i / 2);
    23b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23b4:	89 c2                	mov    %eax,%edx
    23b6:	c1 ea 1f             	shr    $0x1f,%edx
    23b9:	01 d0                	add    %edx,%eax
    23bb:	d1 f8                	sar    %eax
    23bd:	83 c0 30             	add    $0x30,%eax
    23c0:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    23c3:	83 ec 0c             	sub    $0xc,%esp
    23c6:	8d 45 c8             	lea    -0x38(%ebp),%eax
    23c9:	50                   	push   %eax
    23ca:	e8 30 2d 00 00       	call   50ff <unlink>
    23cf:	83 c4 10             	add    $0x10,%esp
    23d2:	85 c0                	test   %eax,%eax
    23d4:	79 17                	jns    23ed <createdelete+0x107>
            printf(1, "unlink failed\n");
    23d6:	83 ec 08             	sub    $0x8,%esp
    23d9:	68 28 57 00 00       	push   $0x5728
    23de:	6a 01                	push   $0x1
    23e0:	e8 56 2e 00 00       	call   523b <printf>
    23e5:	83 c4 10             	add    $0x10,%esp
            exit();
    23e8:	e8 c2 2c 00 00       	call   50af <exit>
      for(i = 0; i < N; i++){
    23ed:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    23f1:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    23f5:	0f 8e 5b ff ff ff    	jle    2356 <createdelete+0x70>
          }
        }
      }
      exit();
    23fb:	e8 af 2c 00 00       	call   50af <exit>
  for(pi = 0; pi < 4; pi++){
    2400:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2404:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    2408:	0f 8e 00 ff ff ff    	jle    230e <createdelete+0x28>
    }
  }

  for(pi = 0; pi < 4; pi++){
    240e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2415:	eb 09                	jmp    2420 <createdelete+0x13a>
    wait();
    2417:	e8 9b 2c 00 00       	call   50b7 <wait>
  for(pi = 0; pi < 4; pi++){
    241c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2420:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    2424:	7e f1                	jle    2417 <createdelete+0x131>
  }

  name[0] = name[1] = name[2] = 0;
    2426:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    242a:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
    242e:	88 45 c9             	mov    %al,-0x37(%ebp)
    2431:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
    2435:	88 45 c8             	mov    %al,-0x38(%ebp)
  for(i = 0; i < N; i++){
    2438:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    243f:	e9 b2 00 00 00       	jmp    24f6 <createdelete+0x210>
    for(pi = 0; pi < 4; pi++){
    2444:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    244b:	e9 98 00 00 00       	jmp    24e8 <createdelete+0x202>
      name[0] = 'p' + pi;
    2450:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2453:	83 c0 70             	add    $0x70,%eax
    2456:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    2459:	8b 45 f4             	mov    -0xc(%ebp),%eax
    245c:	83 c0 30             	add    $0x30,%eax
    245f:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    2462:	83 ec 08             	sub    $0x8,%esp
    2465:	6a 00                	push   $0x0
    2467:	8d 45 c8             	lea    -0x38(%ebp),%eax
    246a:	50                   	push   %eax
    246b:	e8 7f 2c 00 00       	call   50ef <open>
    2470:	83 c4 10             	add    $0x10,%esp
    2473:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    2476:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    247a:	74 06                	je     2482 <createdelete+0x19c>
    247c:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    2480:	7e 21                	jle    24a3 <createdelete+0x1bd>
    2482:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2486:	79 1b                	jns    24a3 <createdelete+0x1bd>
        printf(1, "oops createdelete %s didn't exist\n", name);
    2488:	83 ec 04             	sub    $0x4,%esp
    248b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    248e:	50                   	push   %eax
    248f:	68 98 5c 00 00       	push   $0x5c98
    2494:	6a 01                	push   $0x1
    2496:	e8 a0 2d 00 00       	call   523b <printf>
    249b:	83 c4 10             	add    $0x10,%esp
        exit();
    249e:	e8 0c 2c 00 00       	call   50af <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    24a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    24a7:	7e 27                	jle    24d0 <createdelete+0x1ea>
    24a9:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    24ad:	7f 21                	jg     24d0 <createdelete+0x1ea>
    24af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24b3:	78 1b                	js     24d0 <createdelete+0x1ea>
        printf(1, "oops createdelete %s did exist\n", name);
    24b5:	83 ec 04             	sub    $0x4,%esp
    24b8:	8d 45 c8             	lea    -0x38(%ebp),%eax
    24bb:	50                   	push   %eax
    24bc:	68 bc 5c 00 00       	push   $0x5cbc
    24c1:	6a 01                	push   $0x1
    24c3:	e8 73 2d 00 00       	call   523b <printf>
    24c8:	83 c4 10             	add    $0x10,%esp
        exit();
    24cb:	e8 df 2b 00 00       	call   50af <exit>
      }
      if(fd >= 0)
    24d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24d4:	78 0e                	js     24e4 <createdelete+0x1fe>
        close(fd);
    24d6:	83 ec 0c             	sub    $0xc,%esp
    24d9:	ff 75 ec             	pushl  -0x14(%ebp)
    24dc:	e8 f6 2b 00 00       	call   50d7 <close>
    24e1:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    24e4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    24e8:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    24ec:	0f 8e 5e ff ff ff    	jle    2450 <createdelete+0x16a>
  for(i = 0; i < N; i++){
    24f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    24f6:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    24fa:	0f 8e 44 ff ff ff    	jle    2444 <createdelete+0x15e>
    }
  }

  for(i = 0; i < N; i++){
    2500:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2507:	eb 38                	jmp    2541 <createdelete+0x25b>
    for(pi = 0; pi < 4; pi++){
    2509:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2510:	eb 25                	jmp    2537 <createdelete+0x251>
      name[0] = 'p' + i;
    2512:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2515:	83 c0 70             	add    $0x70,%eax
    2518:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    251b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    251e:	83 c0 30             	add    $0x30,%eax
    2521:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    2524:	83 ec 0c             	sub    $0xc,%esp
    2527:	8d 45 c8             	lea    -0x38(%ebp),%eax
    252a:	50                   	push   %eax
    252b:	e8 cf 2b 00 00       	call   50ff <unlink>
    2530:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    2533:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2537:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    253b:	7e d5                	jle    2512 <createdelete+0x22c>
  for(i = 0; i < N; i++){
    253d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2541:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    2545:	7e c2                	jle    2509 <createdelete+0x223>
    }
  }

  printf(1, "createdelete ok\n");
    2547:	83 ec 08             	sub    $0x8,%esp
    254a:	68 dc 5c 00 00       	push   $0x5cdc
    254f:	6a 01                	push   $0x1
    2551:	e8 e5 2c 00 00       	call   523b <printf>
    2556:	83 c4 10             	add    $0x10,%esp
}
    2559:	90                   	nop
    255a:	c9                   	leave  
    255b:	c3                   	ret    

0000255c <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    255c:	f3 0f 1e fb          	endbr32 
    2560:	55                   	push   %ebp
    2561:	89 e5                	mov    %esp,%ebp
    2563:	83 ec 18             	sub    $0x18,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    2566:	83 ec 08             	sub    $0x8,%esp
    2569:	68 ed 5c 00 00       	push   $0x5ced
    256e:	6a 01                	push   $0x1
    2570:	e8 c6 2c 00 00       	call   523b <printf>
    2575:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    2578:	83 ec 08             	sub    $0x8,%esp
    257b:	68 02 02 00 00       	push   $0x202
    2580:	68 fe 5c 00 00       	push   $0x5cfe
    2585:	e8 65 2b 00 00       	call   50ef <open>
    258a:	83 c4 10             	add    $0x10,%esp
    258d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2590:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2594:	79 17                	jns    25ad <unlinkread+0x51>
    printf(1, "create unlinkread failed\n");
    2596:	83 ec 08             	sub    $0x8,%esp
    2599:	68 09 5d 00 00       	push   $0x5d09
    259e:	6a 01                	push   $0x1
    25a0:	e8 96 2c 00 00       	call   523b <printf>
    25a5:	83 c4 10             	add    $0x10,%esp
    exit();
    25a8:	e8 02 2b 00 00       	call   50af <exit>
  }
  write(fd, "hello", 5);
    25ad:	83 ec 04             	sub    $0x4,%esp
    25b0:	6a 05                	push   $0x5
    25b2:	68 23 5d 00 00       	push   $0x5d23
    25b7:	ff 75 f4             	pushl  -0xc(%ebp)
    25ba:	e8 10 2b 00 00       	call   50cf <write>
    25bf:	83 c4 10             	add    $0x10,%esp
  close(fd);
    25c2:	83 ec 0c             	sub    $0xc,%esp
    25c5:	ff 75 f4             	pushl  -0xc(%ebp)
    25c8:	e8 0a 2b 00 00       	call   50d7 <close>
    25cd:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    25d0:	83 ec 08             	sub    $0x8,%esp
    25d3:	6a 02                	push   $0x2
    25d5:	68 fe 5c 00 00       	push   $0x5cfe
    25da:	e8 10 2b 00 00       	call   50ef <open>
    25df:	83 c4 10             	add    $0x10,%esp
    25e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    25e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    25e9:	79 17                	jns    2602 <unlinkread+0xa6>
    printf(1, "open unlinkread failed\n");
    25eb:	83 ec 08             	sub    $0x8,%esp
    25ee:	68 29 5d 00 00       	push   $0x5d29
    25f3:	6a 01                	push   $0x1
    25f5:	e8 41 2c 00 00       	call   523b <printf>
    25fa:	83 c4 10             	add    $0x10,%esp
    exit();
    25fd:	e8 ad 2a 00 00       	call   50af <exit>
  }
  if(unlink("unlinkread") != 0){
    2602:	83 ec 0c             	sub    $0xc,%esp
    2605:	68 fe 5c 00 00       	push   $0x5cfe
    260a:	e8 f0 2a 00 00       	call   50ff <unlink>
    260f:	83 c4 10             	add    $0x10,%esp
    2612:	85 c0                	test   %eax,%eax
    2614:	74 17                	je     262d <unlinkread+0xd1>
    printf(1, "unlink unlinkread failed\n");
    2616:	83 ec 08             	sub    $0x8,%esp
    2619:	68 41 5d 00 00       	push   $0x5d41
    261e:	6a 01                	push   $0x1
    2620:	e8 16 2c 00 00       	call   523b <printf>
    2625:	83 c4 10             	add    $0x10,%esp
    exit();
    2628:	e8 82 2a 00 00       	call   50af <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    262d:	83 ec 08             	sub    $0x8,%esp
    2630:	68 02 02 00 00       	push   $0x202
    2635:	68 fe 5c 00 00       	push   $0x5cfe
    263a:	e8 b0 2a 00 00       	call   50ef <open>
    263f:	83 c4 10             	add    $0x10,%esp
    2642:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    2645:	83 ec 04             	sub    $0x4,%esp
    2648:	6a 03                	push   $0x3
    264a:	68 5b 5d 00 00       	push   $0x5d5b
    264f:	ff 75 f0             	pushl  -0x10(%ebp)
    2652:	e8 78 2a 00 00       	call   50cf <write>
    2657:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    265a:	83 ec 0c             	sub    $0xc,%esp
    265d:	ff 75 f0             	pushl  -0x10(%ebp)
    2660:	e8 72 2a 00 00       	call   50d7 <close>
    2665:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    2668:	83 ec 04             	sub    $0x4,%esp
    266b:	68 00 20 00 00       	push   $0x2000
    2670:	68 40 9d 00 00       	push   $0x9d40
    2675:	ff 75 f4             	pushl  -0xc(%ebp)
    2678:	e8 4a 2a 00 00       	call   50c7 <read>
    267d:	83 c4 10             	add    $0x10,%esp
    2680:	83 f8 05             	cmp    $0x5,%eax
    2683:	74 17                	je     269c <unlinkread+0x140>
    printf(1, "unlinkread read failed");
    2685:	83 ec 08             	sub    $0x8,%esp
    2688:	68 5f 5d 00 00       	push   $0x5d5f
    268d:	6a 01                	push   $0x1
    268f:	e8 a7 2b 00 00       	call   523b <printf>
    2694:	83 c4 10             	add    $0x10,%esp
    exit();
    2697:	e8 13 2a 00 00       	call   50af <exit>
  }
  if(buf[0] != 'h'){
    269c:	0f b6 05 40 9d 00 00 	movzbl 0x9d40,%eax
    26a3:	3c 68                	cmp    $0x68,%al
    26a5:	74 17                	je     26be <unlinkread+0x162>
    printf(1, "unlinkread wrong data\n");
    26a7:	83 ec 08             	sub    $0x8,%esp
    26aa:	68 76 5d 00 00       	push   $0x5d76
    26af:	6a 01                	push   $0x1
    26b1:	e8 85 2b 00 00       	call   523b <printf>
    26b6:	83 c4 10             	add    $0x10,%esp
    exit();
    26b9:	e8 f1 29 00 00       	call   50af <exit>
  }
  if(write(fd, buf, 10) != 10){
    26be:	83 ec 04             	sub    $0x4,%esp
    26c1:	6a 0a                	push   $0xa
    26c3:	68 40 9d 00 00       	push   $0x9d40
    26c8:	ff 75 f4             	pushl  -0xc(%ebp)
    26cb:	e8 ff 29 00 00       	call   50cf <write>
    26d0:	83 c4 10             	add    $0x10,%esp
    26d3:	83 f8 0a             	cmp    $0xa,%eax
    26d6:	74 17                	je     26ef <unlinkread+0x193>
    printf(1, "unlinkread write failed\n");
    26d8:	83 ec 08             	sub    $0x8,%esp
    26db:	68 8d 5d 00 00       	push   $0x5d8d
    26e0:	6a 01                	push   $0x1
    26e2:	e8 54 2b 00 00       	call   523b <printf>
    26e7:	83 c4 10             	add    $0x10,%esp
    exit();
    26ea:	e8 c0 29 00 00       	call   50af <exit>
  }
  close(fd);
    26ef:	83 ec 0c             	sub    $0xc,%esp
    26f2:	ff 75 f4             	pushl  -0xc(%ebp)
    26f5:	e8 dd 29 00 00       	call   50d7 <close>
    26fa:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    26fd:	83 ec 0c             	sub    $0xc,%esp
    2700:	68 fe 5c 00 00       	push   $0x5cfe
    2705:	e8 f5 29 00 00       	call   50ff <unlink>
    270a:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    270d:	83 ec 08             	sub    $0x8,%esp
    2710:	68 a6 5d 00 00       	push   $0x5da6
    2715:	6a 01                	push   $0x1
    2717:	e8 1f 2b 00 00       	call   523b <printf>
    271c:	83 c4 10             	add    $0x10,%esp
}
    271f:	90                   	nop
    2720:	c9                   	leave  
    2721:	c3                   	ret    

00002722 <linktest>:

void
linktest(void)
{
    2722:	f3 0f 1e fb          	endbr32 
    2726:	55                   	push   %ebp
    2727:	89 e5                	mov    %esp,%ebp
    2729:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "linktest\n");
    272c:	83 ec 08             	sub    $0x8,%esp
    272f:	68 b5 5d 00 00       	push   $0x5db5
    2734:	6a 01                	push   $0x1
    2736:	e8 00 2b 00 00       	call   523b <printf>
    273b:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    273e:	83 ec 0c             	sub    $0xc,%esp
    2741:	68 bf 5d 00 00       	push   $0x5dbf
    2746:	e8 b4 29 00 00       	call   50ff <unlink>
    274b:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    274e:	83 ec 0c             	sub    $0xc,%esp
    2751:	68 c3 5d 00 00       	push   $0x5dc3
    2756:	e8 a4 29 00 00       	call   50ff <unlink>
    275b:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    275e:	83 ec 08             	sub    $0x8,%esp
    2761:	68 02 02 00 00       	push   $0x202
    2766:	68 bf 5d 00 00       	push   $0x5dbf
    276b:	e8 7f 29 00 00       	call   50ef <open>
    2770:	83 c4 10             	add    $0x10,%esp
    2773:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2776:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    277a:	79 17                	jns    2793 <linktest+0x71>
    printf(1, "create lf1 failed\n");
    277c:	83 ec 08             	sub    $0x8,%esp
    277f:	68 c7 5d 00 00       	push   $0x5dc7
    2784:	6a 01                	push   $0x1
    2786:	e8 b0 2a 00 00       	call   523b <printf>
    278b:	83 c4 10             	add    $0x10,%esp
    exit();
    278e:	e8 1c 29 00 00       	call   50af <exit>
  }
  if(write(fd, "hello", 5) != 5){
    2793:	83 ec 04             	sub    $0x4,%esp
    2796:	6a 05                	push   $0x5
    2798:	68 23 5d 00 00       	push   $0x5d23
    279d:	ff 75 f4             	pushl  -0xc(%ebp)
    27a0:	e8 2a 29 00 00       	call   50cf <write>
    27a5:	83 c4 10             	add    $0x10,%esp
    27a8:	83 f8 05             	cmp    $0x5,%eax
    27ab:	74 17                	je     27c4 <linktest+0xa2>
    printf(1, "write lf1 failed\n");
    27ad:	83 ec 08             	sub    $0x8,%esp
    27b0:	68 da 5d 00 00       	push   $0x5dda
    27b5:	6a 01                	push   $0x1
    27b7:	e8 7f 2a 00 00       	call   523b <printf>
    27bc:	83 c4 10             	add    $0x10,%esp
    exit();
    27bf:	e8 eb 28 00 00       	call   50af <exit>
  }
  close(fd);
    27c4:	83 ec 0c             	sub    $0xc,%esp
    27c7:	ff 75 f4             	pushl  -0xc(%ebp)
    27ca:	e8 08 29 00 00       	call   50d7 <close>
    27cf:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    27d2:	83 ec 08             	sub    $0x8,%esp
    27d5:	68 c3 5d 00 00       	push   $0x5dc3
    27da:	68 bf 5d 00 00       	push   $0x5dbf
    27df:	e8 2b 29 00 00       	call   510f <link>
    27e4:	83 c4 10             	add    $0x10,%esp
    27e7:	85 c0                	test   %eax,%eax
    27e9:	79 17                	jns    2802 <linktest+0xe0>
    printf(1, "link lf1 lf2 failed\n");
    27eb:	83 ec 08             	sub    $0x8,%esp
    27ee:	68 ec 5d 00 00       	push   $0x5dec
    27f3:	6a 01                	push   $0x1
    27f5:	e8 41 2a 00 00       	call   523b <printf>
    27fa:	83 c4 10             	add    $0x10,%esp
    exit();
    27fd:	e8 ad 28 00 00       	call   50af <exit>
  }
  unlink("lf1");
    2802:	83 ec 0c             	sub    $0xc,%esp
    2805:	68 bf 5d 00 00       	push   $0x5dbf
    280a:	e8 f0 28 00 00       	call   50ff <unlink>
    280f:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    2812:	83 ec 08             	sub    $0x8,%esp
    2815:	6a 00                	push   $0x0
    2817:	68 bf 5d 00 00       	push   $0x5dbf
    281c:	e8 ce 28 00 00       	call   50ef <open>
    2821:	83 c4 10             	add    $0x10,%esp
    2824:	85 c0                	test   %eax,%eax
    2826:	78 17                	js     283f <linktest+0x11d>
    printf(1, "unlinked lf1 but it is still there!\n");
    2828:	83 ec 08             	sub    $0x8,%esp
    282b:	68 04 5e 00 00       	push   $0x5e04
    2830:	6a 01                	push   $0x1
    2832:	e8 04 2a 00 00       	call   523b <printf>
    2837:	83 c4 10             	add    $0x10,%esp
    exit();
    283a:	e8 70 28 00 00       	call   50af <exit>
  }

  fd = open("lf2", 0);
    283f:	83 ec 08             	sub    $0x8,%esp
    2842:	6a 00                	push   $0x0
    2844:	68 c3 5d 00 00       	push   $0x5dc3
    2849:	e8 a1 28 00 00       	call   50ef <open>
    284e:	83 c4 10             	add    $0x10,%esp
    2851:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2854:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2858:	79 17                	jns    2871 <linktest+0x14f>
    printf(1, "open lf2 failed\n");
    285a:	83 ec 08             	sub    $0x8,%esp
    285d:	68 29 5e 00 00       	push   $0x5e29
    2862:	6a 01                	push   $0x1
    2864:	e8 d2 29 00 00       	call   523b <printf>
    2869:	83 c4 10             	add    $0x10,%esp
    exit();
    286c:	e8 3e 28 00 00       	call   50af <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    2871:	83 ec 04             	sub    $0x4,%esp
    2874:	68 00 20 00 00       	push   $0x2000
    2879:	68 40 9d 00 00       	push   $0x9d40
    287e:	ff 75 f4             	pushl  -0xc(%ebp)
    2881:	e8 41 28 00 00       	call   50c7 <read>
    2886:	83 c4 10             	add    $0x10,%esp
    2889:	83 f8 05             	cmp    $0x5,%eax
    288c:	74 17                	je     28a5 <linktest+0x183>
    printf(1, "read lf2 failed\n");
    288e:	83 ec 08             	sub    $0x8,%esp
    2891:	68 3a 5e 00 00       	push   $0x5e3a
    2896:	6a 01                	push   $0x1
    2898:	e8 9e 29 00 00       	call   523b <printf>
    289d:	83 c4 10             	add    $0x10,%esp
    exit();
    28a0:	e8 0a 28 00 00       	call   50af <exit>
  }
  close(fd);
    28a5:	83 ec 0c             	sub    $0xc,%esp
    28a8:	ff 75 f4             	pushl  -0xc(%ebp)
    28ab:	e8 27 28 00 00       	call   50d7 <close>
    28b0:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    28b3:	83 ec 08             	sub    $0x8,%esp
    28b6:	68 c3 5d 00 00       	push   $0x5dc3
    28bb:	68 c3 5d 00 00       	push   $0x5dc3
    28c0:	e8 4a 28 00 00       	call   510f <link>
    28c5:	83 c4 10             	add    $0x10,%esp
    28c8:	85 c0                	test   %eax,%eax
    28ca:	78 17                	js     28e3 <linktest+0x1c1>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    28cc:	83 ec 08             	sub    $0x8,%esp
    28cf:	68 4b 5e 00 00       	push   $0x5e4b
    28d4:	6a 01                	push   $0x1
    28d6:	e8 60 29 00 00       	call   523b <printf>
    28db:	83 c4 10             	add    $0x10,%esp
    exit();
    28de:	e8 cc 27 00 00       	call   50af <exit>
  }

  unlink("lf2");
    28e3:	83 ec 0c             	sub    $0xc,%esp
    28e6:	68 c3 5d 00 00       	push   $0x5dc3
    28eb:	e8 0f 28 00 00       	call   50ff <unlink>
    28f0:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    28f3:	83 ec 08             	sub    $0x8,%esp
    28f6:	68 bf 5d 00 00       	push   $0x5dbf
    28fb:	68 c3 5d 00 00       	push   $0x5dc3
    2900:	e8 0a 28 00 00       	call   510f <link>
    2905:	83 c4 10             	add    $0x10,%esp
    2908:	85 c0                	test   %eax,%eax
    290a:	78 17                	js     2923 <linktest+0x201>
    printf(1, "link non-existant succeeded! oops\n");
    290c:	83 ec 08             	sub    $0x8,%esp
    290f:	68 6c 5e 00 00       	push   $0x5e6c
    2914:	6a 01                	push   $0x1
    2916:	e8 20 29 00 00       	call   523b <printf>
    291b:	83 c4 10             	add    $0x10,%esp
    exit();
    291e:	e8 8c 27 00 00       	call   50af <exit>
  }

  if(link(".", "lf1") >= 0){
    2923:	83 ec 08             	sub    $0x8,%esp
    2926:	68 bf 5d 00 00       	push   $0x5dbf
    292b:	68 8f 5e 00 00       	push   $0x5e8f
    2930:	e8 da 27 00 00       	call   510f <link>
    2935:	83 c4 10             	add    $0x10,%esp
    2938:	85 c0                	test   %eax,%eax
    293a:	78 17                	js     2953 <linktest+0x231>
    printf(1, "link . lf1 succeeded! oops\n");
    293c:	83 ec 08             	sub    $0x8,%esp
    293f:	68 91 5e 00 00       	push   $0x5e91
    2944:	6a 01                	push   $0x1
    2946:	e8 f0 28 00 00       	call   523b <printf>
    294b:	83 c4 10             	add    $0x10,%esp
    exit();
    294e:	e8 5c 27 00 00       	call   50af <exit>
  }

  printf(1, "linktest ok\n");
    2953:	83 ec 08             	sub    $0x8,%esp
    2956:	68 ad 5e 00 00       	push   $0x5ead
    295b:	6a 01                	push   $0x1
    295d:	e8 d9 28 00 00       	call   523b <printf>
    2962:	83 c4 10             	add    $0x10,%esp
}
    2965:	90                   	nop
    2966:	c9                   	leave  
    2967:	c3                   	ret    

00002968 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    2968:	f3 0f 1e fb          	endbr32 
    296c:	55                   	push   %ebp
    296d:	89 e5                	mov    %esp,%ebp
    296f:	83 ec 58             	sub    $0x58,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    2972:	83 ec 08             	sub    $0x8,%esp
    2975:	68 ba 5e 00 00       	push   $0x5eba
    297a:	6a 01                	push   $0x1
    297c:	e8 ba 28 00 00       	call   523b <printf>
    2981:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    2984:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    2988:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    298c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2993:	e9 fc 00 00 00       	jmp    2a94 <concreate+0x12c>
    file[1] = '0' + i;
    2998:	8b 45 f4             	mov    -0xc(%ebp),%eax
    299b:	83 c0 30             	add    $0x30,%eax
    299e:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    29a1:	83 ec 0c             	sub    $0xc,%esp
    29a4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    29a7:	50                   	push   %eax
    29a8:	e8 52 27 00 00       	call   50ff <unlink>
    29ad:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    29b0:	e8 f2 26 00 00       	call   50a7 <fork>
    29b5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid && (i % 3) == 1){
    29b8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    29bc:	74 3b                	je     29f9 <concreate+0x91>
    29be:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    29c1:	ba 56 55 55 55       	mov    $0x55555556,%edx
    29c6:	89 c8                	mov    %ecx,%eax
    29c8:	f7 ea                	imul   %edx
    29ca:	89 c8                	mov    %ecx,%eax
    29cc:	c1 f8 1f             	sar    $0x1f,%eax
    29cf:	29 c2                	sub    %eax,%edx
    29d1:	89 d0                	mov    %edx,%eax
    29d3:	01 c0                	add    %eax,%eax
    29d5:	01 d0                	add    %edx,%eax
    29d7:	29 c1                	sub    %eax,%ecx
    29d9:	89 ca                	mov    %ecx,%edx
    29db:	83 fa 01             	cmp    $0x1,%edx
    29de:	75 19                	jne    29f9 <concreate+0x91>
      link("C0", file);
    29e0:	83 ec 08             	sub    $0x8,%esp
    29e3:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    29e6:	50                   	push   %eax
    29e7:	68 ca 5e 00 00       	push   $0x5eca
    29ec:	e8 1e 27 00 00       	call   510f <link>
    29f1:	83 c4 10             	add    $0x10,%esp
    29f4:	e9 87 00 00 00       	jmp    2a80 <concreate+0x118>
    } else if(pid == 0 && (i % 5) == 1){
    29f9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    29fd:	75 3b                	jne    2a3a <concreate+0xd2>
    29ff:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2a02:	ba 67 66 66 66       	mov    $0x66666667,%edx
    2a07:	89 c8                	mov    %ecx,%eax
    2a09:	f7 ea                	imul   %edx
    2a0b:	d1 fa                	sar    %edx
    2a0d:	89 c8                	mov    %ecx,%eax
    2a0f:	c1 f8 1f             	sar    $0x1f,%eax
    2a12:	29 c2                	sub    %eax,%edx
    2a14:	89 d0                	mov    %edx,%eax
    2a16:	c1 e0 02             	shl    $0x2,%eax
    2a19:	01 d0                	add    %edx,%eax
    2a1b:	29 c1                	sub    %eax,%ecx
    2a1d:	89 ca                	mov    %ecx,%edx
    2a1f:	83 fa 01             	cmp    $0x1,%edx
    2a22:	75 16                	jne    2a3a <concreate+0xd2>
      link("C0", file);
    2a24:	83 ec 08             	sub    $0x8,%esp
    2a27:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2a2a:	50                   	push   %eax
    2a2b:	68 ca 5e 00 00       	push   $0x5eca
    2a30:	e8 da 26 00 00       	call   510f <link>
    2a35:	83 c4 10             	add    $0x10,%esp
    2a38:	eb 46                	jmp    2a80 <concreate+0x118>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    2a3a:	83 ec 08             	sub    $0x8,%esp
    2a3d:	68 02 02 00 00       	push   $0x202
    2a42:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2a45:	50                   	push   %eax
    2a46:	e8 a4 26 00 00       	call   50ef <open>
    2a4b:	83 c4 10             	add    $0x10,%esp
    2a4e:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(fd < 0){
    2a51:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2a55:	79 1b                	jns    2a72 <concreate+0x10a>
        printf(1, "concreate create %s failed\n", file);
    2a57:	83 ec 04             	sub    $0x4,%esp
    2a5a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2a5d:	50                   	push   %eax
    2a5e:	68 cd 5e 00 00       	push   $0x5ecd
    2a63:	6a 01                	push   $0x1
    2a65:	e8 d1 27 00 00       	call   523b <printf>
    2a6a:	83 c4 10             	add    $0x10,%esp
        exit();
    2a6d:	e8 3d 26 00 00       	call   50af <exit>
      }
      close(fd);
    2a72:	83 ec 0c             	sub    $0xc,%esp
    2a75:	ff 75 ec             	pushl  -0x14(%ebp)
    2a78:	e8 5a 26 00 00       	call   50d7 <close>
    2a7d:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    2a80:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2a84:	75 05                	jne    2a8b <concreate+0x123>
      exit();
    2a86:	e8 24 26 00 00       	call   50af <exit>
    else
      wait();
    2a8b:	e8 27 26 00 00       	call   50b7 <wait>
  for(i = 0; i < 40; i++){
    2a90:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2a94:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    2a98:	0f 8e fa fe ff ff    	jle    2998 <concreate+0x30>
  }

  memset(fa, 0, sizeof(fa));
    2a9e:	83 ec 04             	sub    $0x4,%esp
    2aa1:	6a 28                	push   $0x28
    2aa3:	6a 00                	push   $0x0
    2aa5:	8d 45 bd             	lea    -0x43(%ebp),%eax
    2aa8:	50                   	push   %eax
    2aa9:	e8 4e 24 00 00       	call   4efc <memset>
    2aae:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    2ab1:	83 ec 08             	sub    $0x8,%esp
    2ab4:	6a 00                	push   $0x0
    2ab6:	68 8f 5e 00 00       	push   $0x5e8f
    2abb:	e8 2f 26 00 00       	call   50ef <open>
    2ac0:	83 c4 10             	add    $0x10,%esp
    2ac3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  n = 0;
    2ac6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    2acd:	e9 93 00 00 00       	jmp    2b65 <concreate+0x1fd>
    if(de.inum == 0)
    2ad2:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    2ad6:	66 85 c0             	test   %ax,%ax
    2ad9:	75 05                	jne    2ae0 <concreate+0x178>
      continue;
    2adb:	e9 85 00 00 00       	jmp    2b65 <concreate+0x1fd>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    2ae0:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    2ae4:	3c 43                	cmp    $0x43,%al
    2ae6:	75 7d                	jne    2b65 <concreate+0x1fd>
    2ae8:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    2aec:	84 c0                	test   %al,%al
    2aee:	75 75                	jne    2b65 <concreate+0x1fd>
      i = de.name[1] - '0';
    2af0:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    2af4:	0f be c0             	movsbl %al,%eax
    2af7:	83 e8 30             	sub    $0x30,%eax
    2afa:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    2afd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2b01:	78 08                	js     2b0b <concreate+0x1a3>
    2b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2b06:	83 f8 27             	cmp    $0x27,%eax
    2b09:	76 1e                	jbe    2b29 <concreate+0x1c1>
        printf(1, "concreate weird file %s\n", de.name);
    2b0b:	83 ec 04             	sub    $0x4,%esp
    2b0e:	8d 45 ac             	lea    -0x54(%ebp),%eax
    2b11:	83 c0 02             	add    $0x2,%eax
    2b14:	50                   	push   %eax
    2b15:	68 e9 5e 00 00       	push   $0x5ee9
    2b1a:	6a 01                	push   $0x1
    2b1c:	e8 1a 27 00 00       	call   523b <printf>
    2b21:	83 c4 10             	add    $0x10,%esp
        exit();
    2b24:	e8 86 25 00 00       	call   50af <exit>
      }
      if(fa[i]){
    2b29:	8d 55 bd             	lea    -0x43(%ebp),%edx
    2b2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2b2f:	01 d0                	add    %edx,%eax
    2b31:	0f b6 00             	movzbl (%eax),%eax
    2b34:	84 c0                	test   %al,%al
    2b36:	74 1e                	je     2b56 <concreate+0x1ee>
        printf(1, "concreate duplicate file %s\n", de.name);
    2b38:	83 ec 04             	sub    $0x4,%esp
    2b3b:	8d 45 ac             	lea    -0x54(%ebp),%eax
    2b3e:	83 c0 02             	add    $0x2,%eax
    2b41:	50                   	push   %eax
    2b42:	68 02 5f 00 00       	push   $0x5f02
    2b47:	6a 01                	push   $0x1
    2b49:	e8 ed 26 00 00       	call   523b <printf>
    2b4e:	83 c4 10             	add    $0x10,%esp
        exit();
    2b51:	e8 59 25 00 00       	call   50af <exit>
      }
      fa[i] = 1;
    2b56:	8d 55 bd             	lea    -0x43(%ebp),%edx
    2b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2b5c:	01 d0                	add    %edx,%eax
    2b5e:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    2b61:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    2b65:	83 ec 04             	sub    $0x4,%esp
    2b68:	6a 10                	push   $0x10
    2b6a:	8d 45 ac             	lea    -0x54(%ebp),%eax
    2b6d:	50                   	push   %eax
    2b6e:	ff 75 ec             	pushl  -0x14(%ebp)
    2b71:	e8 51 25 00 00       	call   50c7 <read>
    2b76:	83 c4 10             	add    $0x10,%esp
    2b79:	85 c0                	test   %eax,%eax
    2b7b:	0f 8f 51 ff ff ff    	jg     2ad2 <concreate+0x16a>
    }
  }
  close(fd);
    2b81:	83 ec 0c             	sub    $0xc,%esp
    2b84:	ff 75 ec             	pushl  -0x14(%ebp)
    2b87:	e8 4b 25 00 00       	call   50d7 <close>
    2b8c:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    2b8f:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    2b93:	74 17                	je     2bac <concreate+0x244>
    printf(1, "concreate not enough files in directory listing\n");
    2b95:	83 ec 08             	sub    $0x8,%esp
    2b98:	68 20 5f 00 00       	push   $0x5f20
    2b9d:	6a 01                	push   $0x1
    2b9f:	e8 97 26 00 00       	call   523b <printf>
    2ba4:	83 c4 10             	add    $0x10,%esp
    exit();
    2ba7:	e8 03 25 00 00       	call   50af <exit>
  }

  for(i = 0; i < 40; i++){
    2bac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2bb3:	e9 45 01 00 00       	jmp    2cfd <concreate+0x395>
    file[1] = '0' + i;
    2bb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bbb:	83 c0 30             	add    $0x30,%eax
    2bbe:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    2bc1:	e8 e1 24 00 00       	call   50a7 <fork>
    2bc6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    2bc9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2bcd:	79 17                	jns    2be6 <concreate+0x27e>
      printf(1, "fork failed\n");
    2bcf:	83 ec 08             	sub    $0x8,%esp
    2bd2:	68 a5 56 00 00       	push   $0x56a5
    2bd7:	6a 01                	push   $0x1
    2bd9:	e8 5d 26 00 00       	call   523b <printf>
    2bde:	83 c4 10             	add    $0x10,%esp
      exit();
    2be1:	e8 c9 24 00 00       	call   50af <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    2be6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2be9:	ba 56 55 55 55       	mov    $0x55555556,%edx
    2bee:	89 c8                	mov    %ecx,%eax
    2bf0:	f7 ea                	imul   %edx
    2bf2:	89 c8                	mov    %ecx,%eax
    2bf4:	c1 f8 1f             	sar    $0x1f,%eax
    2bf7:	29 c2                	sub    %eax,%edx
    2bf9:	89 d0                	mov    %edx,%eax
    2bfb:	89 c2                	mov    %eax,%edx
    2bfd:	01 d2                	add    %edx,%edx
    2bff:	01 c2                	add    %eax,%edx
    2c01:	89 c8                	mov    %ecx,%eax
    2c03:	29 d0                	sub    %edx,%eax
    2c05:	85 c0                	test   %eax,%eax
    2c07:	75 06                	jne    2c0f <concreate+0x2a7>
    2c09:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2c0d:	74 28                	je     2c37 <concreate+0x2cf>
       ((i % 3) == 1 && pid != 0)){
    2c0f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2c12:	ba 56 55 55 55       	mov    $0x55555556,%edx
    2c17:	89 c8                	mov    %ecx,%eax
    2c19:	f7 ea                	imul   %edx
    2c1b:	89 c8                	mov    %ecx,%eax
    2c1d:	c1 f8 1f             	sar    $0x1f,%eax
    2c20:	29 c2                	sub    %eax,%edx
    2c22:	89 d0                	mov    %edx,%eax
    2c24:	01 c0                	add    %eax,%eax
    2c26:	01 d0                	add    %edx,%eax
    2c28:	29 c1                	sub    %eax,%ecx
    2c2a:	89 ca                	mov    %ecx,%edx
    if(((i % 3) == 0 && pid == 0) ||
    2c2c:	83 fa 01             	cmp    $0x1,%edx
    2c2f:	75 7c                	jne    2cad <concreate+0x345>
       ((i % 3) == 1 && pid != 0)){
    2c31:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2c35:	74 76                	je     2cad <concreate+0x345>
      close(open(file, 0));
    2c37:	83 ec 08             	sub    $0x8,%esp
    2c3a:	6a 00                	push   $0x0
    2c3c:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2c3f:	50                   	push   %eax
    2c40:	e8 aa 24 00 00       	call   50ef <open>
    2c45:	83 c4 10             	add    $0x10,%esp
    2c48:	83 ec 0c             	sub    $0xc,%esp
    2c4b:	50                   	push   %eax
    2c4c:	e8 86 24 00 00       	call   50d7 <close>
    2c51:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    2c54:	83 ec 08             	sub    $0x8,%esp
    2c57:	6a 00                	push   $0x0
    2c59:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2c5c:	50                   	push   %eax
    2c5d:	e8 8d 24 00 00       	call   50ef <open>
    2c62:	83 c4 10             	add    $0x10,%esp
    2c65:	83 ec 0c             	sub    $0xc,%esp
    2c68:	50                   	push   %eax
    2c69:	e8 69 24 00 00       	call   50d7 <close>
    2c6e:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    2c71:	83 ec 08             	sub    $0x8,%esp
    2c74:	6a 00                	push   $0x0
    2c76:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2c79:	50                   	push   %eax
    2c7a:	e8 70 24 00 00       	call   50ef <open>
    2c7f:	83 c4 10             	add    $0x10,%esp
    2c82:	83 ec 0c             	sub    $0xc,%esp
    2c85:	50                   	push   %eax
    2c86:	e8 4c 24 00 00       	call   50d7 <close>
    2c8b:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    2c8e:	83 ec 08             	sub    $0x8,%esp
    2c91:	6a 00                	push   $0x0
    2c93:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2c96:	50                   	push   %eax
    2c97:	e8 53 24 00 00       	call   50ef <open>
    2c9c:	83 c4 10             	add    $0x10,%esp
    2c9f:	83 ec 0c             	sub    $0xc,%esp
    2ca2:	50                   	push   %eax
    2ca3:	e8 2f 24 00 00       	call   50d7 <close>
    2ca8:	83 c4 10             	add    $0x10,%esp
    2cab:	eb 3c                	jmp    2ce9 <concreate+0x381>
    } else {
      unlink(file);
    2cad:	83 ec 0c             	sub    $0xc,%esp
    2cb0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2cb3:	50                   	push   %eax
    2cb4:	e8 46 24 00 00       	call   50ff <unlink>
    2cb9:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    2cbc:	83 ec 0c             	sub    $0xc,%esp
    2cbf:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2cc2:	50                   	push   %eax
    2cc3:	e8 37 24 00 00       	call   50ff <unlink>
    2cc8:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    2ccb:	83 ec 0c             	sub    $0xc,%esp
    2cce:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2cd1:	50                   	push   %eax
    2cd2:	e8 28 24 00 00       	call   50ff <unlink>
    2cd7:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    2cda:	83 ec 0c             	sub    $0xc,%esp
    2cdd:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2ce0:	50                   	push   %eax
    2ce1:	e8 19 24 00 00       	call   50ff <unlink>
    2ce6:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    2ce9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2ced:	75 05                	jne    2cf4 <concreate+0x38c>
      exit();
    2cef:	e8 bb 23 00 00       	call   50af <exit>
    else
      wait();
    2cf4:	e8 be 23 00 00       	call   50b7 <wait>
  for(i = 0; i < 40; i++){
    2cf9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2cfd:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    2d01:	0f 8e b1 fe ff ff    	jle    2bb8 <concreate+0x250>
  }

  printf(1, "concreate ok\n");
    2d07:	83 ec 08             	sub    $0x8,%esp
    2d0a:	68 51 5f 00 00       	push   $0x5f51
    2d0f:	6a 01                	push   $0x1
    2d11:	e8 25 25 00 00       	call   523b <printf>
    2d16:	83 c4 10             	add    $0x10,%esp
}
    2d19:	90                   	nop
    2d1a:	c9                   	leave  
    2d1b:	c3                   	ret    

00002d1c <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    2d1c:	f3 0f 1e fb          	endbr32 
    2d20:	55                   	push   %ebp
    2d21:	89 e5                	mov    %esp,%ebp
    2d23:	83 ec 18             	sub    $0x18,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    2d26:	83 ec 08             	sub    $0x8,%esp
    2d29:	68 5f 5f 00 00       	push   $0x5f5f
    2d2e:	6a 01                	push   $0x1
    2d30:	e8 06 25 00 00       	call   523b <printf>
    2d35:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    2d38:	83 ec 0c             	sub    $0xc,%esp
    2d3b:	68 db 5a 00 00       	push   $0x5adb
    2d40:	e8 ba 23 00 00       	call   50ff <unlink>
    2d45:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    2d48:	e8 5a 23 00 00       	call   50a7 <fork>
    2d4d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    2d50:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2d54:	79 17                	jns    2d6d <linkunlink+0x51>
    printf(1, "fork failed\n");
    2d56:	83 ec 08             	sub    $0x8,%esp
    2d59:	68 a5 56 00 00       	push   $0x56a5
    2d5e:	6a 01                	push   $0x1
    2d60:	e8 d6 24 00 00       	call   523b <printf>
    2d65:	83 c4 10             	add    $0x10,%esp
    exit();
    2d68:	e8 42 23 00 00       	call   50af <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    2d6d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2d71:	74 07                	je     2d7a <linkunlink+0x5e>
    2d73:	b8 01 00 00 00       	mov    $0x1,%eax
    2d78:	eb 05                	jmp    2d7f <linkunlink+0x63>
    2d7a:	b8 61 00 00 00       	mov    $0x61,%eax
    2d7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    2d82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2d89:	e9 9a 00 00 00       	jmp    2e28 <linkunlink+0x10c>
    x = x * 1103515245 + 12345;
    2d8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2d91:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    2d97:	05 39 30 00 00       	add    $0x3039,%eax
    2d9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    2d9f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    2da2:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    2da7:	89 c8                	mov    %ecx,%eax
    2da9:	f7 e2                	mul    %edx
    2dab:	89 d0                	mov    %edx,%eax
    2dad:	d1 e8                	shr    %eax
    2daf:	89 c2                	mov    %eax,%edx
    2db1:	01 d2                	add    %edx,%edx
    2db3:	01 c2                	add    %eax,%edx
    2db5:	89 c8                	mov    %ecx,%eax
    2db7:	29 d0                	sub    %edx,%eax
    2db9:	85 c0                	test   %eax,%eax
    2dbb:	75 23                	jne    2de0 <linkunlink+0xc4>
      close(open("x", O_RDWR | O_CREATE));
    2dbd:	83 ec 08             	sub    $0x8,%esp
    2dc0:	68 02 02 00 00       	push   $0x202
    2dc5:	68 db 5a 00 00       	push   $0x5adb
    2dca:	e8 20 23 00 00       	call   50ef <open>
    2dcf:	83 c4 10             	add    $0x10,%esp
    2dd2:	83 ec 0c             	sub    $0xc,%esp
    2dd5:	50                   	push   %eax
    2dd6:	e8 fc 22 00 00       	call   50d7 <close>
    2ddb:	83 c4 10             	add    $0x10,%esp
    2dde:	eb 44                	jmp    2e24 <linkunlink+0x108>
    } else if((x % 3) == 1){
    2de0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    2de3:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    2de8:	89 c8                	mov    %ecx,%eax
    2dea:	f7 e2                	mul    %edx
    2dec:	d1 ea                	shr    %edx
    2dee:	89 d0                	mov    %edx,%eax
    2df0:	01 c0                	add    %eax,%eax
    2df2:	01 d0                	add    %edx,%eax
    2df4:	29 c1                	sub    %eax,%ecx
    2df6:	89 ca                	mov    %ecx,%edx
    2df8:	83 fa 01             	cmp    $0x1,%edx
    2dfb:	75 17                	jne    2e14 <linkunlink+0xf8>
      link("cat", "x");
    2dfd:	83 ec 08             	sub    $0x8,%esp
    2e00:	68 db 5a 00 00       	push   $0x5adb
    2e05:	68 70 5f 00 00       	push   $0x5f70
    2e0a:	e8 00 23 00 00       	call   510f <link>
    2e0f:	83 c4 10             	add    $0x10,%esp
    2e12:	eb 10                	jmp    2e24 <linkunlink+0x108>
    } else {
      unlink("x");
    2e14:	83 ec 0c             	sub    $0xc,%esp
    2e17:	68 db 5a 00 00       	push   $0x5adb
    2e1c:	e8 de 22 00 00       	call   50ff <unlink>
    2e21:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    2e24:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2e28:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    2e2c:	0f 8e 5c ff ff ff    	jle    2d8e <linkunlink+0x72>
    }
  }

  if(pid)
    2e32:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2e36:	74 07                	je     2e3f <linkunlink+0x123>
    wait();
    2e38:	e8 7a 22 00 00       	call   50b7 <wait>
    2e3d:	eb 05                	jmp    2e44 <linkunlink+0x128>
  else
    exit();
    2e3f:	e8 6b 22 00 00       	call   50af <exit>

  printf(1, "linkunlink ok\n");
    2e44:	83 ec 08             	sub    $0x8,%esp
    2e47:	68 74 5f 00 00       	push   $0x5f74
    2e4c:	6a 01                	push   $0x1
    2e4e:	e8 e8 23 00 00       	call   523b <printf>
    2e53:	83 c4 10             	add    $0x10,%esp
}
    2e56:	90                   	nop
    2e57:	c9                   	leave  
    2e58:	c3                   	ret    

00002e59 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    2e59:	f3 0f 1e fb          	endbr32 
    2e5d:	55                   	push   %ebp
    2e5e:	89 e5                	mov    %esp,%ebp
    2e60:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    2e63:	83 ec 08             	sub    $0x8,%esp
    2e66:	68 83 5f 00 00       	push   $0x5f83
    2e6b:	6a 01                	push   $0x1
    2e6d:	e8 c9 23 00 00       	call   523b <printf>
    2e72:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    2e75:	83 ec 0c             	sub    $0xc,%esp
    2e78:	68 90 5f 00 00       	push   $0x5f90
    2e7d:	e8 7d 22 00 00       	call   50ff <unlink>
    2e82:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    2e85:	83 ec 08             	sub    $0x8,%esp
    2e88:	68 00 02 00 00       	push   $0x200
    2e8d:	68 90 5f 00 00       	push   $0x5f90
    2e92:	e8 58 22 00 00       	call   50ef <open>
    2e97:	83 c4 10             	add    $0x10,%esp
    2e9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    2e9d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2ea1:	79 17                	jns    2eba <bigdir+0x61>
    printf(1, "bigdir create failed\n");
    2ea3:	83 ec 08             	sub    $0x8,%esp
    2ea6:	68 93 5f 00 00       	push   $0x5f93
    2eab:	6a 01                	push   $0x1
    2ead:	e8 89 23 00 00       	call   523b <printf>
    2eb2:	83 c4 10             	add    $0x10,%esp
    exit();
    2eb5:	e8 f5 21 00 00       	call   50af <exit>
  }
  close(fd);
    2eba:	83 ec 0c             	sub    $0xc,%esp
    2ebd:	ff 75 f0             	pushl  -0x10(%ebp)
    2ec0:	e8 12 22 00 00       	call   50d7 <close>
    2ec5:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    2ec8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2ecf:	eb 63                	jmp    2f34 <bigdir+0xdb>
    name[0] = 'x';
    2ed1:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    2ed5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2ed8:	8d 50 3f             	lea    0x3f(%eax),%edx
    2edb:	85 c0                	test   %eax,%eax
    2edd:	0f 48 c2             	cmovs  %edx,%eax
    2ee0:	c1 f8 06             	sar    $0x6,%eax
    2ee3:	83 c0 30             	add    $0x30,%eax
    2ee6:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    2ee9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2eec:	99                   	cltd   
    2eed:	c1 ea 1a             	shr    $0x1a,%edx
    2ef0:	01 d0                	add    %edx,%eax
    2ef2:	83 e0 3f             	and    $0x3f,%eax
    2ef5:	29 d0                	sub    %edx,%eax
    2ef7:	83 c0 30             	add    $0x30,%eax
    2efa:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    2efd:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    2f01:	83 ec 08             	sub    $0x8,%esp
    2f04:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    2f07:	50                   	push   %eax
    2f08:	68 90 5f 00 00       	push   $0x5f90
    2f0d:	e8 fd 21 00 00       	call   510f <link>
    2f12:	83 c4 10             	add    $0x10,%esp
    2f15:	85 c0                	test   %eax,%eax
    2f17:	74 17                	je     2f30 <bigdir+0xd7>
      printf(1, "bigdir link failed\n");
    2f19:	83 ec 08             	sub    $0x8,%esp
    2f1c:	68 a9 5f 00 00       	push   $0x5fa9
    2f21:	6a 01                	push   $0x1
    2f23:	e8 13 23 00 00       	call   523b <printf>
    2f28:	83 c4 10             	add    $0x10,%esp
      exit();
    2f2b:	e8 7f 21 00 00       	call   50af <exit>
  for(i = 0; i < 500; i++){
    2f30:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2f34:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    2f3b:	7e 94                	jle    2ed1 <bigdir+0x78>
    }
  }

  unlink("bd");
    2f3d:	83 ec 0c             	sub    $0xc,%esp
    2f40:	68 90 5f 00 00       	push   $0x5f90
    2f45:	e8 b5 21 00 00       	call   50ff <unlink>
    2f4a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    2f4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2f54:	eb 5e                	jmp    2fb4 <bigdir+0x15b>
    name[0] = 'x';
    2f56:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    2f5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f5d:	8d 50 3f             	lea    0x3f(%eax),%edx
    2f60:	85 c0                	test   %eax,%eax
    2f62:	0f 48 c2             	cmovs  %edx,%eax
    2f65:	c1 f8 06             	sar    $0x6,%eax
    2f68:	83 c0 30             	add    $0x30,%eax
    2f6b:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    2f6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f71:	99                   	cltd   
    2f72:	c1 ea 1a             	shr    $0x1a,%edx
    2f75:	01 d0                	add    %edx,%eax
    2f77:	83 e0 3f             	and    $0x3f,%eax
    2f7a:	29 d0                	sub    %edx,%eax
    2f7c:	83 c0 30             	add    $0x30,%eax
    2f7f:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    2f82:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    2f86:	83 ec 0c             	sub    $0xc,%esp
    2f89:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    2f8c:	50                   	push   %eax
    2f8d:	e8 6d 21 00 00       	call   50ff <unlink>
    2f92:	83 c4 10             	add    $0x10,%esp
    2f95:	85 c0                	test   %eax,%eax
    2f97:	74 17                	je     2fb0 <bigdir+0x157>
      printf(1, "bigdir unlink failed");
    2f99:	83 ec 08             	sub    $0x8,%esp
    2f9c:	68 bd 5f 00 00       	push   $0x5fbd
    2fa1:	6a 01                	push   $0x1
    2fa3:	e8 93 22 00 00       	call   523b <printf>
    2fa8:	83 c4 10             	add    $0x10,%esp
      exit();
    2fab:	e8 ff 20 00 00       	call   50af <exit>
  for(i = 0; i < 500; i++){
    2fb0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2fb4:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    2fbb:	7e 99                	jle    2f56 <bigdir+0xfd>
    }
  }

  printf(1, "bigdir ok\n");
    2fbd:	83 ec 08             	sub    $0x8,%esp
    2fc0:	68 d2 5f 00 00       	push   $0x5fd2
    2fc5:	6a 01                	push   $0x1
    2fc7:	e8 6f 22 00 00       	call   523b <printf>
    2fcc:	83 c4 10             	add    $0x10,%esp
}
    2fcf:	90                   	nop
    2fd0:	c9                   	leave  
    2fd1:	c3                   	ret    

00002fd2 <subdir>:

void
subdir(void)
{
    2fd2:	f3 0f 1e fb          	endbr32 
    2fd6:	55                   	push   %ebp
    2fd7:	89 e5                	mov    %esp,%ebp
    2fd9:	83 ec 18             	sub    $0x18,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    2fdc:	83 ec 08             	sub    $0x8,%esp
    2fdf:	68 dd 5f 00 00       	push   $0x5fdd
    2fe4:	6a 01                	push   $0x1
    2fe6:	e8 50 22 00 00       	call   523b <printf>
    2feb:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    2fee:	83 ec 0c             	sub    $0xc,%esp
    2ff1:	68 ea 5f 00 00       	push   $0x5fea
    2ff6:	e8 04 21 00 00       	call   50ff <unlink>
    2ffb:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    2ffe:	83 ec 0c             	sub    $0xc,%esp
    3001:	68 ed 5f 00 00       	push   $0x5fed
    3006:	e8 0c 21 00 00       	call   5117 <mkdir>
    300b:	83 c4 10             	add    $0x10,%esp
    300e:	85 c0                	test   %eax,%eax
    3010:	74 17                	je     3029 <subdir+0x57>
    printf(1, "subdir mkdir dd failed\n");
    3012:	83 ec 08             	sub    $0x8,%esp
    3015:	68 f0 5f 00 00       	push   $0x5ff0
    301a:	6a 01                	push   $0x1
    301c:	e8 1a 22 00 00       	call   523b <printf>
    3021:	83 c4 10             	add    $0x10,%esp
    exit();
    3024:	e8 86 20 00 00       	call   50af <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    3029:	83 ec 08             	sub    $0x8,%esp
    302c:	68 02 02 00 00       	push   $0x202
    3031:	68 08 60 00 00       	push   $0x6008
    3036:	e8 b4 20 00 00       	call   50ef <open>
    303b:	83 c4 10             	add    $0x10,%esp
    303e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    3041:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3045:	79 17                	jns    305e <subdir+0x8c>
    printf(1, "create dd/ff failed\n");
    3047:	83 ec 08             	sub    $0x8,%esp
    304a:	68 0e 60 00 00       	push   $0x600e
    304f:	6a 01                	push   $0x1
    3051:	e8 e5 21 00 00       	call   523b <printf>
    3056:	83 c4 10             	add    $0x10,%esp
    exit();
    3059:	e8 51 20 00 00       	call   50af <exit>
  }
  write(fd, "ff", 2);
    305e:	83 ec 04             	sub    $0x4,%esp
    3061:	6a 02                	push   $0x2
    3063:	68 ea 5f 00 00       	push   $0x5fea
    3068:	ff 75 f4             	pushl  -0xc(%ebp)
    306b:	e8 5f 20 00 00       	call   50cf <write>
    3070:	83 c4 10             	add    $0x10,%esp
  close(fd);
    3073:	83 ec 0c             	sub    $0xc,%esp
    3076:	ff 75 f4             	pushl  -0xc(%ebp)
    3079:	e8 59 20 00 00       	call   50d7 <close>
    307e:	83 c4 10             	add    $0x10,%esp

  if(unlink("dd") >= 0){
    3081:	83 ec 0c             	sub    $0xc,%esp
    3084:	68 ed 5f 00 00       	push   $0x5fed
    3089:	e8 71 20 00 00       	call   50ff <unlink>
    308e:	83 c4 10             	add    $0x10,%esp
    3091:	85 c0                	test   %eax,%eax
    3093:	78 17                	js     30ac <subdir+0xda>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    3095:	83 ec 08             	sub    $0x8,%esp
    3098:	68 24 60 00 00       	push   $0x6024
    309d:	6a 01                	push   $0x1
    309f:	e8 97 21 00 00       	call   523b <printf>
    30a4:	83 c4 10             	add    $0x10,%esp
    exit();
    30a7:	e8 03 20 00 00       	call   50af <exit>
  }

  if(mkdir("/dd/dd") != 0){
    30ac:	83 ec 0c             	sub    $0xc,%esp
    30af:	68 4a 60 00 00       	push   $0x604a
    30b4:	e8 5e 20 00 00       	call   5117 <mkdir>
    30b9:	83 c4 10             	add    $0x10,%esp
    30bc:	85 c0                	test   %eax,%eax
    30be:	74 17                	je     30d7 <subdir+0x105>
    printf(1, "subdir mkdir dd/dd failed\n");
    30c0:	83 ec 08             	sub    $0x8,%esp
    30c3:	68 51 60 00 00       	push   $0x6051
    30c8:	6a 01                	push   $0x1
    30ca:	e8 6c 21 00 00       	call   523b <printf>
    30cf:	83 c4 10             	add    $0x10,%esp
    exit();
    30d2:	e8 d8 1f 00 00       	call   50af <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    30d7:	83 ec 08             	sub    $0x8,%esp
    30da:	68 02 02 00 00       	push   $0x202
    30df:	68 6c 60 00 00       	push   $0x606c
    30e4:	e8 06 20 00 00       	call   50ef <open>
    30e9:	83 c4 10             	add    $0x10,%esp
    30ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    30ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    30f3:	79 17                	jns    310c <subdir+0x13a>
    printf(1, "create dd/dd/ff failed\n");
    30f5:	83 ec 08             	sub    $0x8,%esp
    30f8:	68 75 60 00 00       	push   $0x6075
    30fd:	6a 01                	push   $0x1
    30ff:	e8 37 21 00 00       	call   523b <printf>
    3104:	83 c4 10             	add    $0x10,%esp
    exit();
    3107:	e8 a3 1f 00 00       	call   50af <exit>
  }
  write(fd, "FF", 2);
    310c:	83 ec 04             	sub    $0x4,%esp
    310f:	6a 02                	push   $0x2
    3111:	68 8d 60 00 00       	push   $0x608d
    3116:	ff 75 f4             	pushl  -0xc(%ebp)
    3119:	e8 b1 1f 00 00       	call   50cf <write>
    311e:	83 c4 10             	add    $0x10,%esp
  close(fd);
    3121:	83 ec 0c             	sub    $0xc,%esp
    3124:	ff 75 f4             	pushl  -0xc(%ebp)
    3127:	e8 ab 1f 00 00       	call   50d7 <close>
    312c:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    312f:	83 ec 08             	sub    $0x8,%esp
    3132:	6a 00                	push   $0x0
    3134:	68 90 60 00 00       	push   $0x6090
    3139:	e8 b1 1f 00 00       	call   50ef <open>
    313e:	83 c4 10             	add    $0x10,%esp
    3141:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    3144:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3148:	79 17                	jns    3161 <subdir+0x18f>
    printf(1, "open dd/dd/../ff failed\n");
    314a:	83 ec 08             	sub    $0x8,%esp
    314d:	68 9c 60 00 00       	push   $0x609c
    3152:	6a 01                	push   $0x1
    3154:	e8 e2 20 00 00       	call   523b <printf>
    3159:	83 c4 10             	add    $0x10,%esp
    exit();
    315c:	e8 4e 1f 00 00       	call   50af <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    3161:	83 ec 04             	sub    $0x4,%esp
    3164:	68 00 20 00 00       	push   $0x2000
    3169:	68 40 9d 00 00       	push   $0x9d40
    316e:	ff 75 f4             	pushl  -0xc(%ebp)
    3171:	e8 51 1f 00 00       	call   50c7 <read>
    3176:	83 c4 10             	add    $0x10,%esp
    3179:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    317c:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    3180:	75 0b                	jne    318d <subdir+0x1bb>
    3182:	0f b6 05 40 9d 00 00 	movzbl 0x9d40,%eax
    3189:	3c 66                	cmp    $0x66,%al
    318b:	74 17                	je     31a4 <subdir+0x1d2>
    printf(1, "dd/dd/../ff wrong content\n");
    318d:	83 ec 08             	sub    $0x8,%esp
    3190:	68 b5 60 00 00       	push   $0x60b5
    3195:	6a 01                	push   $0x1
    3197:	e8 9f 20 00 00       	call   523b <printf>
    319c:	83 c4 10             	add    $0x10,%esp
    exit();
    319f:	e8 0b 1f 00 00       	call   50af <exit>
  }
  close(fd);
    31a4:	83 ec 0c             	sub    $0xc,%esp
    31a7:	ff 75 f4             	pushl  -0xc(%ebp)
    31aa:	e8 28 1f 00 00       	call   50d7 <close>
    31af:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    31b2:	83 ec 08             	sub    $0x8,%esp
    31b5:	68 d0 60 00 00       	push   $0x60d0
    31ba:	68 6c 60 00 00       	push   $0x606c
    31bf:	e8 4b 1f 00 00       	call   510f <link>
    31c4:	83 c4 10             	add    $0x10,%esp
    31c7:	85 c0                	test   %eax,%eax
    31c9:	74 17                	je     31e2 <subdir+0x210>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    31cb:	83 ec 08             	sub    $0x8,%esp
    31ce:	68 dc 60 00 00       	push   $0x60dc
    31d3:	6a 01                	push   $0x1
    31d5:	e8 61 20 00 00       	call   523b <printf>
    31da:	83 c4 10             	add    $0x10,%esp
    exit();
    31dd:	e8 cd 1e 00 00       	call   50af <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    31e2:	83 ec 0c             	sub    $0xc,%esp
    31e5:	68 6c 60 00 00       	push   $0x606c
    31ea:	e8 10 1f 00 00       	call   50ff <unlink>
    31ef:	83 c4 10             	add    $0x10,%esp
    31f2:	85 c0                	test   %eax,%eax
    31f4:	74 17                	je     320d <subdir+0x23b>
    printf(1, "unlink dd/dd/ff failed\n");
    31f6:	83 ec 08             	sub    $0x8,%esp
    31f9:	68 fd 60 00 00       	push   $0x60fd
    31fe:	6a 01                	push   $0x1
    3200:	e8 36 20 00 00       	call   523b <printf>
    3205:	83 c4 10             	add    $0x10,%esp
    exit();
    3208:	e8 a2 1e 00 00       	call   50af <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    320d:	83 ec 08             	sub    $0x8,%esp
    3210:	6a 00                	push   $0x0
    3212:	68 6c 60 00 00       	push   $0x606c
    3217:	e8 d3 1e 00 00       	call   50ef <open>
    321c:	83 c4 10             	add    $0x10,%esp
    321f:	85 c0                	test   %eax,%eax
    3221:	78 17                	js     323a <subdir+0x268>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    3223:	83 ec 08             	sub    $0x8,%esp
    3226:	68 18 61 00 00       	push   $0x6118
    322b:	6a 01                	push   $0x1
    322d:	e8 09 20 00 00       	call   523b <printf>
    3232:	83 c4 10             	add    $0x10,%esp
    exit();
    3235:	e8 75 1e 00 00       	call   50af <exit>
  }

  if(chdir("dd") != 0){
    323a:	83 ec 0c             	sub    $0xc,%esp
    323d:	68 ed 5f 00 00       	push   $0x5fed
    3242:	e8 d8 1e 00 00       	call   511f <chdir>
    3247:	83 c4 10             	add    $0x10,%esp
    324a:	85 c0                	test   %eax,%eax
    324c:	74 17                	je     3265 <subdir+0x293>
    printf(1, "chdir dd failed\n");
    324e:	83 ec 08             	sub    $0x8,%esp
    3251:	68 3c 61 00 00       	push   $0x613c
    3256:	6a 01                	push   $0x1
    3258:	e8 de 1f 00 00       	call   523b <printf>
    325d:	83 c4 10             	add    $0x10,%esp
    exit();
    3260:	e8 4a 1e 00 00       	call   50af <exit>
  }
  if(chdir("dd/../../dd") != 0){
    3265:	83 ec 0c             	sub    $0xc,%esp
    3268:	68 4d 61 00 00       	push   $0x614d
    326d:	e8 ad 1e 00 00       	call   511f <chdir>
    3272:	83 c4 10             	add    $0x10,%esp
    3275:	85 c0                	test   %eax,%eax
    3277:	74 17                	je     3290 <subdir+0x2be>
    printf(1, "chdir dd/../../dd failed\n");
    3279:	83 ec 08             	sub    $0x8,%esp
    327c:	68 59 61 00 00       	push   $0x6159
    3281:	6a 01                	push   $0x1
    3283:	e8 b3 1f 00 00       	call   523b <printf>
    3288:	83 c4 10             	add    $0x10,%esp
    exit();
    328b:	e8 1f 1e 00 00       	call   50af <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    3290:	83 ec 0c             	sub    $0xc,%esp
    3293:	68 73 61 00 00       	push   $0x6173
    3298:	e8 82 1e 00 00       	call   511f <chdir>
    329d:	83 c4 10             	add    $0x10,%esp
    32a0:	85 c0                	test   %eax,%eax
    32a2:	74 17                	je     32bb <subdir+0x2e9>
    printf(1, "chdir dd/../../dd failed\n");
    32a4:	83 ec 08             	sub    $0x8,%esp
    32a7:	68 59 61 00 00       	push   $0x6159
    32ac:	6a 01                	push   $0x1
    32ae:	e8 88 1f 00 00       	call   523b <printf>
    32b3:	83 c4 10             	add    $0x10,%esp
    exit();
    32b6:	e8 f4 1d 00 00       	call   50af <exit>
  }
  if(chdir("./..") != 0){
    32bb:	83 ec 0c             	sub    $0xc,%esp
    32be:	68 82 61 00 00       	push   $0x6182
    32c3:	e8 57 1e 00 00       	call   511f <chdir>
    32c8:	83 c4 10             	add    $0x10,%esp
    32cb:	85 c0                	test   %eax,%eax
    32cd:	74 17                	je     32e6 <subdir+0x314>
    printf(1, "chdir ./.. failed\n");
    32cf:	83 ec 08             	sub    $0x8,%esp
    32d2:	68 87 61 00 00       	push   $0x6187
    32d7:	6a 01                	push   $0x1
    32d9:	e8 5d 1f 00 00       	call   523b <printf>
    32de:	83 c4 10             	add    $0x10,%esp
    exit();
    32e1:	e8 c9 1d 00 00       	call   50af <exit>
  }

  fd = open("dd/dd/ffff", 0);
    32e6:	83 ec 08             	sub    $0x8,%esp
    32e9:	6a 00                	push   $0x0
    32eb:	68 d0 60 00 00       	push   $0x60d0
    32f0:	e8 fa 1d 00 00       	call   50ef <open>
    32f5:	83 c4 10             	add    $0x10,%esp
    32f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    32fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    32ff:	79 17                	jns    3318 <subdir+0x346>
    printf(1, "open dd/dd/ffff failed\n");
    3301:	83 ec 08             	sub    $0x8,%esp
    3304:	68 9a 61 00 00       	push   $0x619a
    3309:	6a 01                	push   $0x1
    330b:	e8 2b 1f 00 00       	call   523b <printf>
    3310:	83 c4 10             	add    $0x10,%esp
    exit();
    3313:	e8 97 1d 00 00       	call   50af <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    3318:	83 ec 04             	sub    $0x4,%esp
    331b:	68 00 20 00 00       	push   $0x2000
    3320:	68 40 9d 00 00       	push   $0x9d40
    3325:	ff 75 f4             	pushl  -0xc(%ebp)
    3328:	e8 9a 1d 00 00       	call   50c7 <read>
    332d:	83 c4 10             	add    $0x10,%esp
    3330:	83 f8 02             	cmp    $0x2,%eax
    3333:	74 17                	je     334c <subdir+0x37a>
    printf(1, "read dd/dd/ffff wrong len\n");
    3335:	83 ec 08             	sub    $0x8,%esp
    3338:	68 b2 61 00 00       	push   $0x61b2
    333d:	6a 01                	push   $0x1
    333f:	e8 f7 1e 00 00       	call   523b <printf>
    3344:	83 c4 10             	add    $0x10,%esp
    exit();
    3347:	e8 63 1d 00 00       	call   50af <exit>
  }
  close(fd);
    334c:	83 ec 0c             	sub    $0xc,%esp
    334f:	ff 75 f4             	pushl  -0xc(%ebp)
    3352:	e8 80 1d 00 00       	call   50d7 <close>
    3357:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    335a:	83 ec 08             	sub    $0x8,%esp
    335d:	6a 00                	push   $0x0
    335f:	68 6c 60 00 00       	push   $0x606c
    3364:	e8 86 1d 00 00       	call   50ef <open>
    3369:	83 c4 10             	add    $0x10,%esp
    336c:	85 c0                	test   %eax,%eax
    336e:	78 17                	js     3387 <subdir+0x3b5>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    3370:	83 ec 08             	sub    $0x8,%esp
    3373:	68 d0 61 00 00       	push   $0x61d0
    3378:	6a 01                	push   $0x1
    337a:	e8 bc 1e 00 00       	call   523b <printf>
    337f:	83 c4 10             	add    $0x10,%esp
    exit();
    3382:	e8 28 1d 00 00       	call   50af <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    3387:	83 ec 08             	sub    $0x8,%esp
    338a:	68 02 02 00 00       	push   $0x202
    338f:	68 f5 61 00 00       	push   $0x61f5
    3394:	e8 56 1d 00 00       	call   50ef <open>
    3399:	83 c4 10             	add    $0x10,%esp
    339c:	85 c0                	test   %eax,%eax
    339e:	78 17                	js     33b7 <subdir+0x3e5>
    printf(1, "create dd/ff/ff succeeded!\n");
    33a0:	83 ec 08             	sub    $0x8,%esp
    33a3:	68 fe 61 00 00       	push   $0x61fe
    33a8:	6a 01                	push   $0x1
    33aa:	e8 8c 1e 00 00       	call   523b <printf>
    33af:	83 c4 10             	add    $0x10,%esp
    exit();
    33b2:	e8 f8 1c 00 00       	call   50af <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    33b7:	83 ec 08             	sub    $0x8,%esp
    33ba:	68 02 02 00 00       	push   $0x202
    33bf:	68 1a 62 00 00       	push   $0x621a
    33c4:	e8 26 1d 00 00       	call   50ef <open>
    33c9:	83 c4 10             	add    $0x10,%esp
    33cc:	85 c0                	test   %eax,%eax
    33ce:	78 17                	js     33e7 <subdir+0x415>
    printf(1, "create dd/xx/ff succeeded!\n");
    33d0:	83 ec 08             	sub    $0x8,%esp
    33d3:	68 23 62 00 00       	push   $0x6223
    33d8:	6a 01                	push   $0x1
    33da:	e8 5c 1e 00 00       	call   523b <printf>
    33df:	83 c4 10             	add    $0x10,%esp
    exit();
    33e2:	e8 c8 1c 00 00       	call   50af <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    33e7:	83 ec 08             	sub    $0x8,%esp
    33ea:	68 00 02 00 00       	push   $0x200
    33ef:	68 ed 5f 00 00       	push   $0x5fed
    33f4:	e8 f6 1c 00 00       	call   50ef <open>
    33f9:	83 c4 10             	add    $0x10,%esp
    33fc:	85 c0                	test   %eax,%eax
    33fe:	78 17                	js     3417 <subdir+0x445>
    printf(1, "create dd succeeded!\n");
    3400:	83 ec 08             	sub    $0x8,%esp
    3403:	68 3f 62 00 00       	push   $0x623f
    3408:	6a 01                	push   $0x1
    340a:	e8 2c 1e 00 00       	call   523b <printf>
    340f:	83 c4 10             	add    $0x10,%esp
    exit();
    3412:	e8 98 1c 00 00       	call   50af <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    3417:	83 ec 08             	sub    $0x8,%esp
    341a:	6a 02                	push   $0x2
    341c:	68 ed 5f 00 00       	push   $0x5fed
    3421:	e8 c9 1c 00 00       	call   50ef <open>
    3426:	83 c4 10             	add    $0x10,%esp
    3429:	85 c0                	test   %eax,%eax
    342b:	78 17                	js     3444 <subdir+0x472>
    printf(1, "open dd rdwr succeeded!\n");
    342d:	83 ec 08             	sub    $0x8,%esp
    3430:	68 55 62 00 00       	push   $0x6255
    3435:	6a 01                	push   $0x1
    3437:	e8 ff 1d 00 00       	call   523b <printf>
    343c:	83 c4 10             	add    $0x10,%esp
    exit();
    343f:	e8 6b 1c 00 00       	call   50af <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    3444:	83 ec 08             	sub    $0x8,%esp
    3447:	6a 01                	push   $0x1
    3449:	68 ed 5f 00 00       	push   $0x5fed
    344e:	e8 9c 1c 00 00       	call   50ef <open>
    3453:	83 c4 10             	add    $0x10,%esp
    3456:	85 c0                	test   %eax,%eax
    3458:	78 17                	js     3471 <subdir+0x49f>
    printf(1, "open dd wronly succeeded!\n");
    345a:	83 ec 08             	sub    $0x8,%esp
    345d:	68 6e 62 00 00       	push   $0x626e
    3462:	6a 01                	push   $0x1
    3464:	e8 d2 1d 00 00       	call   523b <printf>
    3469:	83 c4 10             	add    $0x10,%esp
    exit();
    346c:	e8 3e 1c 00 00       	call   50af <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3471:	83 ec 08             	sub    $0x8,%esp
    3474:	68 89 62 00 00       	push   $0x6289
    3479:	68 f5 61 00 00       	push   $0x61f5
    347e:	e8 8c 1c 00 00       	call   510f <link>
    3483:	83 c4 10             	add    $0x10,%esp
    3486:	85 c0                	test   %eax,%eax
    3488:	75 17                	jne    34a1 <subdir+0x4cf>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    348a:	83 ec 08             	sub    $0x8,%esp
    348d:	68 94 62 00 00       	push   $0x6294
    3492:	6a 01                	push   $0x1
    3494:	e8 a2 1d 00 00       	call   523b <printf>
    3499:	83 c4 10             	add    $0x10,%esp
    exit();
    349c:	e8 0e 1c 00 00       	call   50af <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    34a1:	83 ec 08             	sub    $0x8,%esp
    34a4:	68 89 62 00 00       	push   $0x6289
    34a9:	68 1a 62 00 00       	push   $0x621a
    34ae:	e8 5c 1c 00 00       	call   510f <link>
    34b3:	83 c4 10             	add    $0x10,%esp
    34b6:	85 c0                	test   %eax,%eax
    34b8:	75 17                	jne    34d1 <subdir+0x4ff>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    34ba:	83 ec 08             	sub    $0x8,%esp
    34bd:	68 b8 62 00 00       	push   $0x62b8
    34c2:	6a 01                	push   $0x1
    34c4:	e8 72 1d 00 00       	call   523b <printf>
    34c9:	83 c4 10             	add    $0x10,%esp
    exit();
    34cc:	e8 de 1b 00 00       	call   50af <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    34d1:	83 ec 08             	sub    $0x8,%esp
    34d4:	68 d0 60 00 00       	push   $0x60d0
    34d9:	68 08 60 00 00       	push   $0x6008
    34de:	e8 2c 1c 00 00       	call   510f <link>
    34e3:	83 c4 10             	add    $0x10,%esp
    34e6:	85 c0                	test   %eax,%eax
    34e8:	75 17                	jne    3501 <subdir+0x52f>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    34ea:	83 ec 08             	sub    $0x8,%esp
    34ed:	68 dc 62 00 00       	push   $0x62dc
    34f2:	6a 01                	push   $0x1
    34f4:	e8 42 1d 00 00       	call   523b <printf>
    34f9:	83 c4 10             	add    $0x10,%esp
    exit();
    34fc:	e8 ae 1b 00 00       	call   50af <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    3501:	83 ec 0c             	sub    $0xc,%esp
    3504:	68 f5 61 00 00       	push   $0x61f5
    3509:	e8 09 1c 00 00       	call   5117 <mkdir>
    350e:	83 c4 10             	add    $0x10,%esp
    3511:	85 c0                	test   %eax,%eax
    3513:	75 17                	jne    352c <subdir+0x55a>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    3515:	83 ec 08             	sub    $0x8,%esp
    3518:	68 fe 62 00 00       	push   $0x62fe
    351d:	6a 01                	push   $0x1
    351f:	e8 17 1d 00 00       	call   523b <printf>
    3524:	83 c4 10             	add    $0x10,%esp
    exit();
    3527:	e8 83 1b 00 00       	call   50af <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    352c:	83 ec 0c             	sub    $0xc,%esp
    352f:	68 1a 62 00 00       	push   $0x621a
    3534:	e8 de 1b 00 00       	call   5117 <mkdir>
    3539:	83 c4 10             	add    $0x10,%esp
    353c:	85 c0                	test   %eax,%eax
    353e:	75 17                	jne    3557 <subdir+0x585>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    3540:	83 ec 08             	sub    $0x8,%esp
    3543:	68 19 63 00 00       	push   $0x6319
    3548:	6a 01                	push   $0x1
    354a:	e8 ec 1c 00 00       	call   523b <printf>
    354f:	83 c4 10             	add    $0x10,%esp
    exit();
    3552:	e8 58 1b 00 00       	call   50af <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    3557:	83 ec 0c             	sub    $0xc,%esp
    355a:	68 d0 60 00 00       	push   $0x60d0
    355f:	e8 b3 1b 00 00       	call   5117 <mkdir>
    3564:	83 c4 10             	add    $0x10,%esp
    3567:	85 c0                	test   %eax,%eax
    3569:	75 17                	jne    3582 <subdir+0x5b0>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    356b:	83 ec 08             	sub    $0x8,%esp
    356e:	68 34 63 00 00       	push   $0x6334
    3573:	6a 01                	push   $0x1
    3575:	e8 c1 1c 00 00       	call   523b <printf>
    357a:	83 c4 10             	add    $0x10,%esp
    exit();
    357d:	e8 2d 1b 00 00       	call   50af <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    3582:	83 ec 0c             	sub    $0xc,%esp
    3585:	68 1a 62 00 00       	push   $0x621a
    358a:	e8 70 1b 00 00       	call   50ff <unlink>
    358f:	83 c4 10             	add    $0x10,%esp
    3592:	85 c0                	test   %eax,%eax
    3594:	75 17                	jne    35ad <subdir+0x5db>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    3596:	83 ec 08             	sub    $0x8,%esp
    3599:	68 51 63 00 00       	push   $0x6351
    359e:	6a 01                	push   $0x1
    35a0:	e8 96 1c 00 00       	call   523b <printf>
    35a5:	83 c4 10             	add    $0x10,%esp
    exit();
    35a8:	e8 02 1b 00 00       	call   50af <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    35ad:	83 ec 0c             	sub    $0xc,%esp
    35b0:	68 f5 61 00 00       	push   $0x61f5
    35b5:	e8 45 1b 00 00       	call   50ff <unlink>
    35ba:	83 c4 10             	add    $0x10,%esp
    35bd:	85 c0                	test   %eax,%eax
    35bf:	75 17                	jne    35d8 <subdir+0x606>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    35c1:	83 ec 08             	sub    $0x8,%esp
    35c4:	68 6d 63 00 00       	push   $0x636d
    35c9:	6a 01                	push   $0x1
    35cb:	e8 6b 1c 00 00       	call   523b <printf>
    35d0:	83 c4 10             	add    $0x10,%esp
    exit();
    35d3:	e8 d7 1a 00 00       	call   50af <exit>
  }
  if(chdir("dd/ff") == 0){
    35d8:	83 ec 0c             	sub    $0xc,%esp
    35db:	68 08 60 00 00       	push   $0x6008
    35e0:	e8 3a 1b 00 00       	call   511f <chdir>
    35e5:	83 c4 10             	add    $0x10,%esp
    35e8:	85 c0                	test   %eax,%eax
    35ea:	75 17                	jne    3603 <subdir+0x631>
    printf(1, "chdir dd/ff succeeded!\n");
    35ec:	83 ec 08             	sub    $0x8,%esp
    35ef:	68 89 63 00 00       	push   $0x6389
    35f4:	6a 01                	push   $0x1
    35f6:	e8 40 1c 00 00       	call   523b <printf>
    35fb:	83 c4 10             	add    $0x10,%esp
    exit();
    35fe:	e8 ac 1a 00 00       	call   50af <exit>
  }
  if(chdir("dd/xx") == 0){
    3603:	83 ec 0c             	sub    $0xc,%esp
    3606:	68 a1 63 00 00       	push   $0x63a1
    360b:	e8 0f 1b 00 00       	call   511f <chdir>
    3610:	83 c4 10             	add    $0x10,%esp
    3613:	85 c0                	test   %eax,%eax
    3615:	75 17                	jne    362e <subdir+0x65c>
    printf(1, "chdir dd/xx succeeded!\n");
    3617:	83 ec 08             	sub    $0x8,%esp
    361a:	68 a7 63 00 00       	push   $0x63a7
    361f:	6a 01                	push   $0x1
    3621:	e8 15 1c 00 00       	call   523b <printf>
    3626:	83 c4 10             	add    $0x10,%esp
    exit();
    3629:	e8 81 1a 00 00       	call   50af <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    362e:	83 ec 0c             	sub    $0xc,%esp
    3631:	68 d0 60 00 00       	push   $0x60d0
    3636:	e8 c4 1a 00 00       	call   50ff <unlink>
    363b:	83 c4 10             	add    $0x10,%esp
    363e:	85 c0                	test   %eax,%eax
    3640:	74 17                	je     3659 <subdir+0x687>
    printf(1, "unlink dd/dd/ff failed\n");
    3642:	83 ec 08             	sub    $0x8,%esp
    3645:	68 fd 60 00 00       	push   $0x60fd
    364a:	6a 01                	push   $0x1
    364c:	e8 ea 1b 00 00       	call   523b <printf>
    3651:	83 c4 10             	add    $0x10,%esp
    exit();
    3654:	e8 56 1a 00 00       	call   50af <exit>
  }
  if(unlink("dd/ff") != 0){
    3659:	83 ec 0c             	sub    $0xc,%esp
    365c:	68 08 60 00 00       	push   $0x6008
    3661:	e8 99 1a 00 00       	call   50ff <unlink>
    3666:	83 c4 10             	add    $0x10,%esp
    3669:	85 c0                	test   %eax,%eax
    366b:	74 17                	je     3684 <subdir+0x6b2>
    printf(1, "unlink dd/ff failed\n");
    366d:	83 ec 08             	sub    $0x8,%esp
    3670:	68 bf 63 00 00       	push   $0x63bf
    3675:	6a 01                	push   $0x1
    3677:	e8 bf 1b 00 00       	call   523b <printf>
    367c:	83 c4 10             	add    $0x10,%esp
    exit();
    367f:	e8 2b 1a 00 00       	call   50af <exit>
  }
  if(unlink("dd") == 0){
    3684:	83 ec 0c             	sub    $0xc,%esp
    3687:	68 ed 5f 00 00       	push   $0x5fed
    368c:	e8 6e 1a 00 00       	call   50ff <unlink>
    3691:	83 c4 10             	add    $0x10,%esp
    3694:	85 c0                	test   %eax,%eax
    3696:	75 17                	jne    36af <subdir+0x6dd>
    printf(1, "unlink non-empty dd succeeded!\n");
    3698:	83 ec 08             	sub    $0x8,%esp
    369b:	68 d4 63 00 00       	push   $0x63d4
    36a0:	6a 01                	push   $0x1
    36a2:	e8 94 1b 00 00       	call   523b <printf>
    36a7:	83 c4 10             	add    $0x10,%esp
    exit();
    36aa:	e8 00 1a 00 00       	call   50af <exit>
  }
  if(unlink("dd/dd") < 0){
    36af:	83 ec 0c             	sub    $0xc,%esp
    36b2:	68 f4 63 00 00       	push   $0x63f4
    36b7:	e8 43 1a 00 00       	call   50ff <unlink>
    36bc:	83 c4 10             	add    $0x10,%esp
    36bf:	85 c0                	test   %eax,%eax
    36c1:	79 17                	jns    36da <subdir+0x708>
    printf(1, "unlink dd/dd failed\n");
    36c3:	83 ec 08             	sub    $0x8,%esp
    36c6:	68 fa 63 00 00       	push   $0x63fa
    36cb:	6a 01                	push   $0x1
    36cd:	e8 69 1b 00 00       	call   523b <printf>
    36d2:	83 c4 10             	add    $0x10,%esp
    exit();
    36d5:	e8 d5 19 00 00       	call   50af <exit>
  }
  if(unlink("dd") < 0){
    36da:	83 ec 0c             	sub    $0xc,%esp
    36dd:	68 ed 5f 00 00       	push   $0x5fed
    36e2:	e8 18 1a 00 00       	call   50ff <unlink>
    36e7:	83 c4 10             	add    $0x10,%esp
    36ea:	85 c0                	test   %eax,%eax
    36ec:	79 17                	jns    3705 <subdir+0x733>
    printf(1, "unlink dd failed\n");
    36ee:	83 ec 08             	sub    $0x8,%esp
    36f1:	68 0f 64 00 00       	push   $0x640f
    36f6:	6a 01                	push   $0x1
    36f8:	e8 3e 1b 00 00       	call   523b <printf>
    36fd:	83 c4 10             	add    $0x10,%esp
    exit();
    3700:	e8 aa 19 00 00       	call   50af <exit>
  }

  printf(1, "subdir ok\n");
    3705:	83 ec 08             	sub    $0x8,%esp
    3708:	68 21 64 00 00       	push   $0x6421
    370d:	6a 01                	push   $0x1
    370f:	e8 27 1b 00 00       	call   523b <printf>
    3714:	83 c4 10             	add    $0x10,%esp
}
    3717:	90                   	nop
    3718:	c9                   	leave  
    3719:	c3                   	ret    

0000371a <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    371a:	f3 0f 1e fb          	endbr32 
    371e:	55                   	push   %ebp
    371f:	89 e5                	mov    %esp,%ebp
    3721:	83 ec 18             	sub    $0x18,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    3724:	83 ec 08             	sub    $0x8,%esp
    3727:	68 2c 64 00 00       	push   $0x642c
    372c:	6a 01                	push   $0x1
    372e:	e8 08 1b 00 00       	call   523b <printf>
    3733:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    3736:	83 ec 0c             	sub    $0xc,%esp
    3739:	68 3b 64 00 00       	push   $0x643b
    373e:	e8 bc 19 00 00       	call   50ff <unlink>
    3743:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    3746:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    374d:	e9 a8 00 00 00       	jmp    37fa <bigwrite+0xe0>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    3752:	83 ec 08             	sub    $0x8,%esp
    3755:	68 02 02 00 00       	push   $0x202
    375a:	68 3b 64 00 00       	push   $0x643b
    375f:	e8 8b 19 00 00       	call   50ef <open>
    3764:	83 c4 10             	add    $0x10,%esp
    3767:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    376a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    376e:	79 17                	jns    3787 <bigwrite+0x6d>
      printf(1, "cannot create bigwrite\n");
    3770:	83 ec 08             	sub    $0x8,%esp
    3773:	68 44 64 00 00       	push   $0x6444
    3778:	6a 01                	push   $0x1
    377a:	e8 bc 1a 00 00       	call   523b <printf>
    377f:	83 c4 10             	add    $0x10,%esp
      exit();
    3782:	e8 28 19 00 00       	call   50af <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    3787:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    378e:	eb 3f                	jmp    37cf <bigwrite+0xb5>
      int cc = write(fd, buf, sz);
    3790:	83 ec 04             	sub    $0x4,%esp
    3793:	ff 75 f4             	pushl  -0xc(%ebp)
    3796:	68 40 9d 00 00       	push   $0x9d40
    379b:	ff 75 ec             	pushl  -0x14(%ebp)
    379e:	e8 2c 19 00 00       	call   50cf <write>
    37a3:	83 c4 10             	add    $0x10,%esp
    37a6:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    37a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    37ac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    37af:	74 1a                	je     37cb <bigwrite+0xb1>
        printf(1, "write(%d) ret %d\n", sz, cc);
    37b1:	ff 75 e8             	pushl  -0x18(%ebp)
    37b4:	ff 75 f4             	pushl  -0xc(%ebp)
    37b7:	68 5c 64 00 00       	push   $0x645c
    37bc:	6a 01                	push   $0x1
    37be:	e8 78 1a 00 00       	call   523b <printf>
    37c3:	83 c4 10             	add    $0x10,%esp
        exit();
    37c6:	e8 e4 18 00 00       	call   50af <exit>
    for(i = 0; i < 2; i++){
    37cb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    37cf:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    37d3:	7e bb                	jle    3790 <bigwrite+0x76>
      }
    }
    close(fd);
    37d5:	83 ec 0c             	sub    $0xc,%esp
    37d8:	ff 75 ec             	pushl  -0x14(%ebp)
    37db:	e8 f7 18 00 00       	call   50d7 <close>
    37e0:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    37e3:	83 ec 0c             	sub    $0xc,%esp
    37e6:	68 3b 64 00 00       	push   $0x643b
    37eb:	e8 0f 19 00 00       	call   50ff <unlink>
    37f0:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    37f3:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    37fa:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    3801:	0f 8e 4b ff ff ff    	jle    3752 <bigwrite+0x38>
  }

  printf(1, "bigwrite ok\n");
    3807:	83 ec 08             	sub    $0x8,%esp
    380a:	68 6e 64 00 00       	push   $0x646e
    380f:	6a 01                	push   $0x1
    3811:	e8 25 1a 00 00       	call   523b <printf>
    3816:	83 c4 10             	add    $0x10,%esp
}
    3819:	90                   	nop
    381a:	c9                   	leave  
    381b:	c3                   	ret    

0000381c <bigfile>:

void
bigfile(void)
{
    381c:	f3 0f 1e fb          	endbr32 
    3820:	55                   	push   %ebp
    3821:	89 e5                	mov    %esp,%ebp
    3823:	83 ec 18             	sub    $0x18,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    3826:	83 ec 08             	sub    $0x8,%esp
    3829:	68 7b 64 00 00       	push   $0x647b
    382e:	6a 01                	push   $0x1
    3830:	e8 06 1a 00 00       	call   523b <printf>
    3835:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    3838:	83 ec 0c             	sub    $0xc,%esp
    383b:	68 89 64 00 00       	push   $0x6489
    3840:	e8 ba 18 00 00       	call   50ff <unlink>
    3845:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    3848:	83 ec 08             	sub    $0x8,%esp
    384b:	68 02 02 00 00       	push   $0x202
    3850:	68 89 64 00 00       	push   $0x6489
    3855:	e8 95 18 00 00       	call   50ef <open>
    385a:	83 c4 10             	add    $0x10,%esp
    385d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    3860:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3864:	79 17                	jns    387d <bigfile+0x61>
    printf(1, "cannot create bigfile");
    3866:	83 ec 08             	sub    $0x8,%esp
    3869:	68 91 64 00 00       	push   $0x6491
    386e:	6a 01                	push   $0x1
    3870:	e8 c6 19 00 00       	call   523b <printf>
    3875:	83 c4 10             	add    $0x10,%esp
    exit();
    3878:	e8 32 18 00 00       	call   50af <exit>
  }
  for(i = 0; i < 20; i++){
    387d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3884:	eb 52                	jmp    38d8 <bigfile+0xbc>
    memset(buf, i, 600);
    3886:	83 ec 04             	sub    $0x4,%esp
    3889:	68 58 02 00 00       	push   $0x258
    388e:	ff 75 f4             	pushl  -0xc(%ebp)
    3891:	68 40 9d 00 00       	push   $0x9d40
    3896:	e8 61 16 00 00       	call   4efc <memset>
    389b:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    389e:	83 ec 04             	sub    $0x4,%esp
    38a1:	68 58 02 00 00       	push   $0x258
    38a6:	68 40 9d 00 00       	push   $0x9d40
    38ab:	ff 75 ec             	pushl  -0x14(%ebp)
    38ae:	e8 1c 18 00 00       	call   50cf <write>
    38b3:	83 c4 10             	add    $0x10,%esp
    38b6:	3d 58 02 00 00       	cmp    $0x258,%eax
    38bb:	74 17                	je     38d4 <bigfile+0xb8>
      printf(1, "write bigfile failed\n");
    38bd:	83 ec 08             	sub    $0x8,%esp
    38c0:	68 a7 64 00 00       	push   $0x64a7
    38c5:	6a 01                	push   $0x1
    38c7:	e8 6f 19 00 00       	call   523b <printf>
    38cc:	83 c4 10             	add    $0x10,%esp
      exit();
    38cf:	e8 db 17 00 00       	call   50af <exit>
  for(i = 0; i < 20; i++){
    38d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    38d8:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    38dc:	7e a8                	jle    3886 <bigfile+0x6a>
    }
  }
  close(fd);
    38de:	83 ec 0c             	sub    $0xc,%esp
    38e1:	ff 75 ec             	pushl  -0x14(%ebp)
    38e4:	e8 ee 17 00 00       	call   50d7 <close>
    38e9:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    38ec:	83 ec 08             	sub    $0x8,%esp
    38ef:	6a 00                	push   $0x0
    38f1:	68 89 64 00 00       	push   $0x6489
    38f6:	e8 f4 17 00 00       	call   50ef <open>
    38fb:	83 c4 10             	add    $0x10,%esp
    38fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    3901:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3905:	79 17                	jns    391e <bigfile+0x102>
    printf(1, "cannot open bigfile\n");
    3907:	83 ec 08             	sub    $0x8,%esp
    390a:	68 bd 64 00 00       	push   $0x64bd
    390f:	6a 01                	push   $0x1
    3911:	e8 25 19 00 00       	call   523b <printf>
    3916:	83 c4 10             	add    $0x10,%esp
    exit();
    3919:	e8 91 17 00 00       	call   50af <exit>
  }
  total = 0;
    391e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    3925:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    392c:	83 ec 04             	sub    $0x4,%esp
    392f:	68 2c 01 00 00       	push   $0x12c
    3934:	68 40 9d 00 00       	push   $0x9d40
    3939:	ff 75 ec             	pushl  -0x14(%ebp)
    393c:	e8 86 17 00 00       	call   50c7 <read>
    3941:	83 c4 10             	add    $0x10,%esp
    3944:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    3947:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    394b:	79 17                	jns    3964 <bigfile+0x148>
      printf(1, "read bigfile failed\n");
    394d:	83 ec 08             	sub    $0x8,%esp
    3950:	68 d2 64 00 00       	push   $0x64d2
    3955:	6a 01                	push   $0x1
    3957:	e8 df 18 00 00       	call   523b <printf>
    395c:	83 c4 10             	add    $0x10,%esp
      exit();
    395f:	e8 4b 17 00 00       	call   50af <exit>
    }
    if(cc == 0)
    3964:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3968:	74 7a                	je     39e4 <bigfile+0x1c8>
      break;
    if(cc != 300){
    396a:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    3971:	74 17                	je     398a <bigfile+0x16e>
      printf(1, "short read bigfile\n");
    3973:	83 ec 08             	sub    $0x8,%esp
    3976:	68 e7 64 00 00       	push   $0x64e7
    397b:	6a 01                	push   $0x1
    397d:	e8 b9 18 00 00       	call   523b <printf>
    3982:	83 c4 10             	add    $0x10,%esp
      exit();
    3985:	e8 25 17 00 00       	call   50af <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    398a:	0f b6 05 40 9d 00 00 	movzbl 0x9d40,%eax
    3991:	0f be d0             	movsbl %al,%edx
    3994:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3997:	89 c1                	mov    %eax,%ecx
    3999:	c1 e9 1f             	shr    $0x1f,%ecx
    399c:	01 c8                	add    %ecx,%eax
    399e:	d1 f8                	sar    %eax
    39a0:	39 c2                	cmp    %eax,%edx
    39a2:	75 1a                	jne    39be <bigfile+0x1a2>
    39a4:	0f b6 05 6b 9e 00 00 	movzbl 0x9e6b,%eax
    39ab:	0f be d0             	movsbl %al,%edx
    39ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    39b1:	89 c1                	mov    %eax,%ecx
    39b3:	c1 e9 1f             	shr    $0x1f,%ecx
    39b6:	01 c8                	add    %ecx,%eax
    39b8:	d1 f8                	sar    %eax
    39ba:	39 c2                	cmp    %eax,%edx
    39bc:	74 17                	je     39d5 <bigfile+0x1b9>
      printf(1, "read bigfile wrong data\n");
    39be:	83 ec 08             	sub    $0x8,%esp
    39c1:	68 fb 64 00 00       	push   $0x64fb
    39c6:	6a 01                	push   $0x1
    39c8:	e8 6e 18 00 00       	call   523b <printf>
    39cd:	83 c4 10             	add    $0x10,%esp
      exit();
    39d0:	e8 da 16 00 00       	call   50af <exit>
    }
    total += cc;
    39d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    39d8:	01 45 f0             	add    %eax,-0x10(%ebp)
  for(i = 0; ; i++){
    39db:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    cc = read(fd, buf, 300);
    39df:	e9 48 ff ff ff       	jmp    392c <bigfile+0x110>
      break;
    39e4:	90                   	nop
  }
  close(fd);
    39e5:	83 ec 0c             	sub    $0xc,%esp
    39e8:	ff 75 ec             	pushl  -0x14(%ebp)
    39eb:	e8 e7 16 00 00       	call   50d7 <close>
    39f0:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    39f3:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    39fa:	74 17                	je     3a13 <bigfile+0x1f7>
    printf(1, "read bigfile wrong total\n");
    39fc:	83 ec 08             	sub    $0x8,%esp
    39ff:	68 14 65 00 00       	push   $0x6514
    3a04:	6a 01                	push   $0x1
    3a06:	e8 30 18 00 00       	call   523b <printf>
    3a0b:	83 c4 10             	add    $0x10,%esp
    exit();
    3a0e:	e8 9c 16 00 00       	call   50af <exit>
  }
  unlink("bigfile");
    3a13:	83 ec 0c             	sub    $0xc,%esp
    3a16:	68 89 64 00 00       	push   $0x6489
    3a1b:	e8 df 16 00 00       	call   50ff <unlink>
    3a20:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    3a23:	83 ec 08             	sub    $0x8,%esp
    3a26:	68 2e 65 00 00       	push   $0x652e
    3a2b:	6a 01                	push   $0x1
    3a2d:	e8 09 18 00 00       	call   523b <printf>
    3a32:	83 c4 10             	add    $0x10,%esp
}
    3a35:	90                   	nop
    3a36:	c9                   	leave  
    3a37:	c3                   	ret    

00003a38 <fourteen>:

void
fourteen(void)
{
    3a38:	f3 0f 1e fb          	endbr32 
    3a3c:	55                   	push   %ebp
    3a3d:	89 e5                	mov    %esp,%ebp
    3a3f:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    3a42:	83 ec 08             	sub    $0x8,%esp
    3a45:	68 3f 65 00 00       	push   $0x653f
    3a4a:	6a 01                	push   $0x1
    3a4c:	e8 ea 17 00 00       	call   523b <printf>
    3a51:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    3a54:	83 ec 0c             	sub    $0xc,%esp
    3a57:	68 4e 65 00 00       	push   $0x654e
    3a5c:	e8 b6 16 00 00       	call   5117 <mkdir>
    3a61:	83 c4 10             	add    $0x10,%esp
    3a64:	85 c0                	test   %eax,%eax
    3a66:	74 17                	je     3a7f <fourteen+0x47>
    printf(1, "mkdir 12345678901234 failed\n");
    3a68:	83 ec 08             	sub    $0x8,%esp
    3a6b:	68 5d 65 00 00       	push   $0x655d
    3a70:	6a 01                	push   $0x1
    3a72:	e8 c4 17 00 00       	call   523b <printf>
    3a77:	83 c4 10             	add    $0x10,%esp
    exit();
    3a7a:	e8 30 16 00 00       	call   50af <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    3a7f:	83 ec 0c             	sub    $0xc,%esp
    3a82:	68 7c 65 00 00       	push   $0x657c
    3a87:	e8 8b 16 00 00       	call   5117 <mkdir>
    3a8c:	83 c4 10             	add    $0x10,%esp
    3a8f:	85 c0                	test   %eax,%eax
    3a91:	74 17                	je     3aaa <fourteen+0x72>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    3a93:	83 ec 08             	sub    $0x8,%esp
    3a96:	68 9c 65 00 00       	push   $0x659c
    3a9b:	6a 01                	push   $0x1
    3a9d:	e8 99 17 00 00       	call   523b <printf>
    3aa2:	83 c4 10             	add    $0x10,%esp
    exit();
    3aa5:	e8 05 16 00 00       	call   50af <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    3aaa:	83 ec 08             	sub    $0x8,%esp
    3aad:	68 00 02 00 00       	push   $0x200
    3ab2:	68 cc 65 00 00       	push   $0x65cc
    3ab7:	e8 33 16 00 00       	call   50ef <open>
    3abc:	83 c4 10             	add    $0x10,%esp
    3abf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    3ac2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3ac6:	79 17                	jns    3adf <fourteen+0xa7>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    3ac8:	83 ec 08             	sub    $0x8,%esp
    3acb:	68 fc 65 00 00       	push   $0x65fc
    3ad0:	6a 01                	push   $0x1
    3ad2:	e8 64 17 00 00       	call   523b <printf>
    3ad7:	83 c4 10             	add    $0x10,%esp
    exit();
    3ada:	e8 d0 15 00 00       	call   50af <exit>
  }
  close(fd);
    3adf:	83 ec 0c             	sub    $0xc,%esp
    3ae2:	ff 75 f4             	pushl  -0xc(%ebp)
    3ae5:	e8 ed 15 00 00       	call   50d7 <close>
    3aea:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    3aed:	83 ec 08             	sub    $0x8,%esp
    3af0:	6a 00                	push   $0x0
    3af2:	68 3c 66 00 00       	push   $0x663c
    3af7:	e8 f3 15 00 00       	call   50ef <open>
    3afc:	83 c4 10             	add    $0x10,%esp
    3aff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    3b02:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3b06:	79 17                	jns    3b1f <fourteen+0xe7>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    3b08:	83 ec 08             	sub    $0x8,%esp
    3b0b:	68 6c 66 00 00       	push   $0x666c
    3b10:	6a 01                	push   $0x1
    3b12:	e8 24 17 00 00       	call   523b <printf>
    3b17:	83 c4 10             	add    $0x10,%esp
    exit();
    3b1a:	e8 90 15 00 00       	call   50af <exit>
  }
  close(fd);
    3b1f:	83 ec 0c             	sub    $0xc,%esp
    3b22:	ff 75 f4             	pushl  -0xc(%ebp)
    3b25:	e8 ad 15 00 00       	call   50d7 <close>
    3b2a:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    3b2d:	83 ec 0c             	sub    $0xc,%esp
    3b30:	68 a6 66 00 00       	push   $0x66a6
    3b35:	e8 dd 15 00 00       	call   5117 <mkdir>
    3b3a:	83 c4 10             	add    $0x10,%esp
    3b3d:	85 c0                	test   %eax,%eax
    3b3f:	75 17                	jne    3b58 <fourteen+0x120>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    3b41:	83 ec 08             	sub    $0x8,%esp
    3b44:	68 c4 66 00 00       	push   $0x66c4
    3b49:	6a 01                	push   $0x1
    3b4b:	e8 eb 16 00 00       	call   523b <printf>
    3b50:	83 c4 10             	add    $0x10,%esp
    exit();
    3b53:	e8 57 15 00 00       	call   50af <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    3b58:	83 ec 0c             	sub    $0xc,%esp
    3b5b:	68 f4 66 00 00       	push   $0x66f4
    3b60:	e8 b2 15 00 00       	call   5117 <mkdir>
    3b65:	83 c4 10             	add    $0x10,%esp
    3b68:	85 c0                	test   %eax,%eax
    3b6a:	75 17                	jne    3b83 <fourteen+0x14b>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    3b6c:	83 ec 08             	sub    $0x8,%esp
    3b6f:	68 14 67 00 00       	push   $0x6714
    3b74:	6a 01                	push   $0x1
    3b76:	e8 c0 16 00 00       	call   523b <printf>
    3b7b:	83 c4 10             	add    $0x10,%esp
    exit();
    3b7e:	e8 2c 15 00 00       	call   50af <exit>
  }

  printf(1, "fourteen ok\n");
    3b83:	83 ec 08             	sub    $0x8,%esp
    3b86:	68 45 67 00 00       	push   $0x6745
    3b8b:	6a 01                	push   $0x1
    3b8d:	e8 a9 16 00 00       	call   523b <printf>
    3b92:	83 c4 10             	add    $0x10,%esp
}
    3b95:	90                   	nop
    3b96:	c9                   	leave  
    3b97:	c3                   	ret    

00003b98 <rmdot>:

void
rmdot(void)
{
    3b98:	f3 0f 1e fb          	endbr32 
    3b9c:	55                   	push   %ebp
    3b9d:	89 e5                	mov    %esp,%ebp
    3b9f:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    3ba2:	83 ec 08             	sub    $0x8,%esp
    3ba5:	68 52 67 00 00       	push   $0x6752
    3baa:	6a 01                	push   $0x1
    3bac:	e8 8a 16 00 00       	call   523b <printf>
    3bb1:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    3bb4:	83 ec 0c             	sub    $0xc,%esp
    3bb7:	68 5e 67 00 00       	push   $0x675e
    3bbc:	e8 56 15 00 00       	call   5117 <mkdir>
    3bc1:	83 c4 10             	add    $0x10,%esp
    3bc4:	85 c0                	test   %eax,%eax
    3bc6:	74 17                	je     3bdf <rmdot+0x47>
    printf(1, "mkdir dots failed\n");
    3bc8:	83 ec 08             	sub    $0x8,%esp
    3bcb:	68 63 67 00 00       	push   $0x6763
    3bd0:	6a 01                	push   $0x1
    3bd2:	e8 64 16 00 00       	call   523b <printf>
    3bd7:	83 c4 10             	add    $0x10,%esp
    exit();
    3bda:	e8 d0 14 00 00       	call   50af <exit>
  }
  if(chdir("dots") != 0){
    3bdf:	83 ec 0c             	sub    $0xc,%esp
    3be2:	68 5e 67 00 00       	push   $0x675e
    3be7:	e8 33 15 00 00       	call   511f <chdir>
    3bec:	83 c4 10             	add    $0x10,%esp
    3bef:	85 c0                	test   %eax,%eax
    3bf1:	74 17                	je     3c0a <rmdot+0x72>
    printf(1, "chdir dots failed\n");
    3bf3:	83 ec 08             	sub    $0x8,%esp
    3bf6:	68 76 67 00 00       	push   $0x6776
    3bfb:	6a 01                	push   $0x1
    3bfd:	e8 39 16 00 00       	call   523b <printf>
    3c02:	83 c4 10             	add    $0x10,%esp
    exit();
    3c05:	e8 a5 14 00 00       	call   50af <exit>
  }
  if(unlink(".") == 0){
    3c0a:	83 ec 0c             	sub    $0xc,%esp
    3c0d:	68 8f 5e 00 00       	push   $0x5e8f
    3c12:	e8 e8 14 00 00       	call   50ff <unlink>
    3c17:	83 c4 10             	add    $0x10,%esp
    3c1a:	85 c0                	test   %eax,%eax
    3c1c:	75 17                	jne    3c35 <rmdot+0x9d>
    printf(1, "rm . worked!\n");
    3c1e:	83 ec 08             	sub    $0x8,%esp
    3c21:	68 89 67 00 00       	push   $0x6789
    3c26:	6a 01                	push   $0x1
    3c28:	e8 0e 16 00 00       	call   523b <printf>
    3c2d:	83 c4 10             	add    $0x10,%esp
    exit();
    3c30:	e8 7a 14 00 00       	call   50af <exit>
  }
  if(unlink("..") == 0){
    3c35:	83 ec 0c             	sub    $0xc,%esp
    3c38:	68 22 5a 00 00       	push   $0x5a22
    3c3d:	e8 bd 14 00 00       	call   50ff <unlink>
    3c42:	83 c4 10             	add    $0x10,%esp
    3c45:	85 c0                	test   %eax,%eax
    3c47:	75 17                	jne    3c60 <rmdot+0xc8>
    printf(1, "rm .. worked!\n");
    3c49:	83 ec 08             	sub    $0x8,%esp
    3c4c:	68 97 67 00 00       	push   $0x6797
    3c51:	6a 01                	push   $0x1
    3c53:	e8 e3 15 00 00       	call   523b <printf>
    3c58:	83 c4 10             	add    $0x10,%esp
    exit();
    3c5b:	e8 4f 14 00 00       	call   50af <exit>
  }
  if(chdir("/") != 0){
    3c60:	83 ec 0c             	sub    $0xc,%esp
    3c63:	68 76 56 00 00       	push   $0x5676
    3c68:	e8 b2 14 00 00       	call   511f <chdir>
    3c6d:	83 c4 10             	add    $0x10,%esp
    3c70:	85 c0                	test   %eax,%eax
    3c72:	74 17                	je     3c8b <rmdot+0xf3>
    printf(1, "chdir / failed\n");
    3c74:	83 ec 08             	sub    $0x8,%esp
    3c77:	68 78 56 00 00       	push   $0x5678
    3c7c:	6a 01                	push   $0x1
    3c7e:	e8 b8 15 00 00       	call   523b <printf>
    3c83:	83 c4 10             	add    $0x10,%esp
    exit();
    3c86:	e8 24 14 00 00       	call   50af <exit>
  }
  if(unlink("dots/.") == 0){
    3c8b:	83 ec 0c             	sub    $0xc,%esp
    3c8e:	68 a6 67 00 00       	push   $0x67a6
    3c93:	e8 67 14 00 00       	call   50ff <unlink>
    3c98:	83 c4 10             	add    $0x10,%esp
    3c9b:	85 c0                	test   %eax,%eax
    3c9d:	75 17                	jne    3cb6 <rmdot+0x11e>
    printf(1, "unlink dots/. worked!\n");
    3c9f:	83 ec 08             	sub    $0x8,%esp
    3ca2:	68 ad 67 00 00       	push   $0x67ad
    3ca7:	6a 01                	push   $0x1
    3ca9:	e8 8d 15 00 00       	call   523b <printf>
    3cae:	83 c4 10             	add    $0x10,%esp
    exit();
    3cb1:	e8 f9 13 00 00       	call   50af <exit>
  }
  if(unlink("dots/..") == 0){
    3cb6:	83 ec 0c             	sub    $0xc,%esp
    3cb9:	68 c4 67 00 00       	push   $0x67c4
    3cbe:	e8 3c 14 00 00       	call   50ff <unlink>
    3cc3:	83 c4 10             	add    $0x10,%esp
    3cc6:	85 c0                	test   %eax,%eax
    3cc8:	75 17                	jne    3ce1 <rmdot+0x149>
    printf(1, "unlink dots/.. worked!\n");
    3cca:	83 ec 08             	sub    $0x8,%esp
    3ccd:	68 cc 67 00 00       	push   $0x67cc
    3cd2:	6a 01                	push   $0x1
    3cd4:	e8 62 15 00 00       	call   523b <printf>
    3cd9:	83 c4 10             	add    $0x10,%esp
    exit();
    3cdc:	e8 ce 13 00 00       	call   50af <exit>
  }
  if(unlink("dots") != 0){
    3ce1:	83 ec 0c             	sub    $0xc,%esp
    3ce4:	68 5e 67 00 00       	push   $0x675e
    3ce9:	e8 11 14 00 00       	call   50ff <unlink>
    3cee:	83 c4 10             	add    $0x10,%esp
    3cf1:	85 c0                	test   %eax,%eax
    3cf3:	74 17                	je     3d0c <rmdot+0x174>
    printf(1, "unlink dots failed!\n");
    3cf5:	83 ec 08             	sub    $0x8,%esp
    3cf8:	68 e4 67 00 00       	push   $0x67e4
    3cfd:	6a 01                	push   $0x1
    3cff:	e8 37 15 00 00       	call   523b <printf>
    3d04:	83 c4 10             	add    $0x10,%esp
    exit();
    3d07:	e8 a3 13 00 00       	call   50af <exit>
  }
  printf(1, "rmdot ok\n");
    3d0c:	83 ec 08             	sub    $0x8,%esp
    3d0f:	68 f9 67 00 00       	push   $0x67f9
    3d14:	6a 01                	push   $0x1
    3d16:	e8 20 15 00 00       	call   523b <printf>
    3d1b:	83 c4 10             	add    $0x10,%esp
}
    3d1e:	90                   	nop
    3d1f:	c9                   	leave  
    3d20:	c3                   	ret    

00003d21 <dirfile>:

void
dirfile(void)
{
    3d21:	f3 0f 1e fb          	endbr32 
    3d25:	55                   	push   %ebp
    3d26:	89 e5                	mov    %esp,%ebp
    3d28:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "dir vs file\n");
    3d2b:	83 ec 08             	sub    $0x8,%esp
    3d2e:	68 03 68 00 00       	push   $0x6803
    3d33:	6a 01                	push   $0x1
    3d35:	e8 01 15 00 00       	call   523b <printf>
    3d3a:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    3d3d:	83 ec 08             	sub    $0x8,%esp
    3d40:	68 00 02 00 00       	push   $0x200
    3d45:	68 10 68 00 00       	push   $0x6810
    3d4a:	e8 a0 13 00 00       	call   50ef <open>
    3d4f:	83 c4 10             	add    $0x10,%esp
    3d52:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    3d55:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3d59:	79 17                	jns    3d72 <dirfile+0x51>
    printf(1, "create dirfile failed\n");
    3d5b:	83 ec 08             	sub    $0x8,%esp
    3d5e:	68 18 68 00 00       	push   $0x6818
    3d63:	6a 01                	push   $0x1
    3d65:	e8 d1 14 00 00       	call   523b <printf>
    3d6a:	83 c4 10             	add    $0x10,%esp
    exit();
    3d6d:	e8 3d 13 00 00       	call   50af <exit>
  }
  close(fd);
    3d72:	83 ec 0c             	sub    $0xc,%esp
    3d75:	ff 75 f4             	pushl  -0xc(%ebp)
    3d78:	e8 5a 13 00 00       	call   50d7 <close>
    3d7d:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    3d80:	83 ec 0c             	sub    $0xc,%esp
    3d83:	68 10 68 00 00       	push   $0x6810
    3d88:	e8 92 13 00 00       	call   511f <chdir>
    3d8d:	83 c4 10             	add    $0x10,%esp
    3d90:	85 c0                	test   %eax,%eax
    3d92:	75 17                	jne    3dab <dirfile+0x8a>
    printf(1, "chdir dirfile succeeded!\n");
    3d94:	83 ec 08             	sub    $0x8,%esp
    3d97:	68 2f 68 00 00       	push   $0x682f
    3d9c:	6a 01                	push   $0x1
    3d9e:	e8 98 14 00 00       	call   523b <printf>
    3da3:	83 c4 10             	add    $0x10,%esp
    exit();
    3da6:	e8 04 13 00 00       	call   50af <exit>
  }
  fd = open("dirfile/xx", 0);
    3dab:	83 ec 08             	sub    $0x8,%esp
    3dae:	6a 00                	push   $0x0
    3db0:	68 49 68 00 00       	push   $0x6849
    3db5:	e8 35 13 00 00       	call   50ef <open>
    3dba:	83 c4 10             	add    $0x10,%esp
    3dbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    3dc0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3dc4:	78 17                	js     3ddd <dirfile+0xbc>
    printf(1, "create dirfile/xx succeeded!\n");
    3dc6:	83 ec 08             	sub    $0x8,%esp
    3dc9:	68 54 68 00 00       	push   $0x6854
    3dce:	6a 01                	push   $0x1
    3dd0:	e8 66 14 00 00       	call   523b <printf>
    3dd5:	83 c4 10             	add    $0x10,%esp
    exit();
    3dd8:	e8 d2 12 00 00       	call   50af <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    3ddd:	83 ec 08             	sub    $0x8,%esp
    3de0:	68 00 02 00 00       	push   $0x200
    3de5:	68 49 68 00 00       	push   $0x6849
    3dea:	e8 00 13 00 00       	call   50ef <open>
    3def:	83 c4 10             	add    $0x10,%esp
    3df2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    3df5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3df9:	78 17                	js     3e12 <dirfile+0xf1>
    printf(1, "create dirfile/xx succeeded!\n");
    3dfb:	83 ec 08             	sub    $0x8,%esp
    3dfe:	68 54 68 00 00       	push   $0x6854
    3e03:	6a 01                	push   $0x1
    3e05:	e8 31 14 00 00       	call   523b <printf>
    3e0a:	83 c4 10             	add    $0x10,%esp
    exit();
    3e0d:	e8 9d 12 00 00       	call   50af <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    3e12:	83 ec 0c             	sub    $0xc,%esp
    3e15:	68 49 68 00 00       	push   $0x6849
    3e1a:	e8 f8 12 00 00       	call   5117 <mkdir>
    3e1f:	83 c4 10             	add    $0x10,%esp
    3e22:	85 c0                	test   %eax,%eax
    3e24:	75 17                	jne    3e3d <dirfile+0x11c>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    3e26:	83 ec 08             	sub    $0x8,%esp
    3e29:	68 72 68 00 00       	push   $0x6872
    3e2e:	6a 01                	push   $0x1
    3e30:	e8 06 14 00 00       	call   523b <printf>
    3e35:	83 c4 10             	add    $0x10,%esp
    exit();
    3e38:	e8 72 12 00 00       	call   50af <exit>
  }
  if(unlink("dirfile/xx") == 0){
    3e3d:	83 ec 0c             	sub    $0xc,%esp
    3e40:	68 49 68 00 00       	push   $0x6849
    3e45:	e8 b5 12 00 00       	call   50ff <unlink>
    3e4a:	83 c4 10             	add    $0x10,%esp
    3e4d:	85 c0                	test   %eax,%eax
    3e4f:	75 17                	jne    3e68 <dirfile+0x147>
    printf(1, "unlink dirfile/xx succeeded!\n");
    3e51:	83 ec 08             	sub    $0x8,%esp
    3e54:	68 8f 68 00 00       	push   $0x688f
    3e59:	6a 01                	push   $0x1
    3e5b:	e8 db 13 00 00       	call   523b <printf>
    3e60:	83 c4 10             	add    $0x10,%esp
    exit();
    3e63:	e8 47 12 00 00       	call   50af <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    3e68:	83 ec 08             	sub    $0x8,%esp
    3e6b:	68 49 68 00 00       	push   $0x6849
    3e70:	68 ad 68 00 00       	push   $0x68ad
    3e75:	e8 95 12 00 00       	call   510f <link>
    3e7a:	83 c4 10             	add    $0x10,%esp
    3e7d:	85 c0                	test   %eax,%eax
    3e7f:	75 17                	jne    3e98 <dirfile+0x177>
    printf(1, "link to dirfile/xx succeeded!\n");
    3e81:	83 ec 08             	sub    $0x8,%esp
    3e84:	68 b4 68 00 00       	push   $0x68b4
    3e89:	6a 01                	push   $0x1
    3e8b:	e8 ab 13 00 00       	call   523b <printf>
    3e90:	83 c4 10             	add    $0x10,%esp
    exit();
    3e93:	e8 17 12 00 00       	call   50af <exit>
  }
  if(unlink("dirfile") != 0){
    3e98:	83 ec 0c             	sub    $0xc,%esp
    3e9b:	68 10 68 00 00       	push   $0x6810
    3ea0:	e8 5a 12 00 00       	call   50ff <unlink>
    3ea5:	83 c4 10             	add    $0x10,%esp
    3ea8:	85 c0                	test   %eax,%eax
    3eaa:	74 17                	je     3ec3 <dirfile+0x1a2>
    printf(1, "unlink dirfile failed!\n");
    3eac:	83 ec 08             	sub    $0x8,%esp
    3eaf:	68 d3 68 00 00       	push   $0x68d3
    3eb4:	6a 01                	push   $0x1
    3eb6:	e8 80 13 00 00       	call   523b <printf>
    3ebb:	83 c4 10             	add    $0x10,%esp
    exit();
    3ebe:	e8 ec 11 00 00       	call   50af <exit>
  }

  fd = open(".", O_RDWR);
    3ec3:	83 ec 08             	sub    $0x8,%esp
    3ec6:	6a 02                	push   $0x2
    3ec8:	68 8f 5e 00 00       	push   $0x5e8f
    3ecd:	e8 1d 12 00 00       	call   50ef <open>
    3ed2:	83 c4 10             	add    $0x10,%esp
    3ed5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    3ed8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3edc:	78 17                	js     3ef5 <dirfile+0x1d4>
    printf(1, "open . for writing succeeded!\n");
    3ede:	83 ec 08             	sub    $0x8,%esp
    3ee1:	68 ec 68 00 00       	push   $0x68ec
    3ee6:	6a 01                	push   $0x1
    3ee8:	e8 4e 13 00 00       	call   523b <printf>
    3eed:	83 c4 10             	add    $0x10,%esp
    exit();
    3ef0:	e8 ba 11 00 00       	call   50af <exit>
  }
  fd = open(".", 0);
    3ef5:	83 ec 08             	sub    $0x8,%esp
    3ef8:	6a 00                	push   $0x0
    3efa:	68 8f 5e 00 00       	push   $0x5e8f
    3eff:	e8 eb 11 00 00       	call   50ef <open>
    3f04:	83 c4 10             	add    $0x10,%esp
    3f07:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    3f0a:	83 ec 04             	sub    $0x4,%esp
    3f0d:	6a 01                	push   $0x1
    3f0f:	68 db 5a 00 00       	push   $0x5adb
    3f14:	ff 75 f4             	pushl  -0xc(%ebp)
    3f17:	e8 b3 11 00 00       	call   50cf <write>
    3f1c:	83 c4 10             	add    $0x10,%esp
    3f1f:	85 c0                	test   %eax,%eax
    3f21:	7e 17                	jle    3f3a <dirfile+0x219>
    printf(1, "write . succeeded!\n");
    3f23:	83 ec 08             	sub    $0x8,%esp
    3f26:	68 0b 69 00 00       	push   $0x690b
    3f2b:	6a 01                	push   $0x1
    3f2d:	e8 09 13 00 00       	call   523b <printf>
    3f32:	83 c4 10             	add    $0x10,%esp
    exit();
    3f35:	e8 75 11 00 00       	call   50af <exit>
  }
  close(fd);
    3f3a:	83 ec 0c             	sub    $0xc,%esp
    3f3d:	ff 75 f4             	pushl  -0xc(%ebp)
    3f40:	e8 92 11 00 00       	call   50d7 <close>
    3f45:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    3f48:	83 ec 08             	sub    $0x8,%esp
    3f4b:	68 1f 69 00 00       	push   $0x691f
    3f50:	6a 01                	push   $0x1
    3f52:	e8 e4 12 00 00       	call   523b <printf>
    3f57:	83 c4 10             	add    $0x10,%esp
}
    3f5a:	90                   	nop
    3f5b:	c9                   	leave  
    3f5c:	c3                   	ret    

00003f5d <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    3f5d:	f3 0f 1e fb          	endbr32 
    3f61:	55                   	push   %ebp
    3f62:	89 e5                	mov    %esp,%ebp
    3f64:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    3f67:	83 ec 08             	sub    $0x8,%esp
    3f6a:	68 2f 69 00 00       	push   $0x692f
    3f6f:	6a 01                	push   $0x1
    3f71:	e8 c5 12 00 00       	call   523b <printf>
    3f76:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    3f79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3f80:	e9 e7 00 00 00       	jmp    406c <iref+0x10f>
    if(mkdir("irefd") != 0){
    3f85:	83 ec 0c             	sub    $0xc,%esp
    3f88:	68 40 69 00 00       	push   $0x6940
    3f8d:	e8 85 11 00 00       	call   5117 <mkdir>
    3f92:	83 c4 10             	add    $0x10,%esp
    3f95:	85 c0                	test   %eax,%eax
    3f97:	74 17                	je     3fb0 <iref+0x53>
      printf(1, "mkdir irefd failed\n");
    3f99:	83 ec 08             	sub    $0x8,%esp
    3f9c:	68 46 69 00 00       	push   $0x6946
    3fa1:	6a 01                	push   $0x1
    3fa3:	e8 93 12 00 00       	call   523b <printf>
    3fa8:	83 c4 10             	add    $0x10,%esp
      exit();
    3fab:	e8 ff 10 00 00       	call   50af <exit>
    }
    if(chdir("irefd") != 0){
    3fb0:	83 ec 0c             	sub    $0xc,%esp
    3fb3:	68 40 69 00 00       	push   $0x6940
    3fb8:	e8 62 11 00 00       	call   511f <chdir>
    3fbd:	83 c4 10             	add    $0x10,%esp
    3fc0:	85 c0                	test   %eax,%eax
    3fc2:	74 17                	je     3fdb <iref+0x7e>
      printf(1, "chdir irefd failed\n");
    3fc4:	83 ec 08             	sub    $0x8,%esp
    3fc7:	68 5a 69 00 00       	push   $0x695a
    3fcc:	6a 01                	push   $0x1
    3fce:	e8 68 12 00 00       	call   523b <printf>
    3fd3:	83 c4 10             	add    $0x10,%esp
      exit();
    3fd6:	e8 d4 10 00 00       	call   50af <exit>
    }

    mkdir("");
    3fdb:	83 ec 0c             	sub    $0xc,%esp
    3fde:	68 6e 69 00 00       	push   $0x696e
    3fe3:	e8 2f 11 00 00       	call   5117 <mkdir>
    3fe8:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    3feb:	83 ec 08             	sub    $0x8,%esp
    3fee:	68 6e 69 00 00       	push   $0x696e
    3ff3:	68 ad 68 00 00       	push   $0x68ad
    3ff8:	e8 12 11 00 00       	call   510f <link>
    3ffd:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    4000:	83 ec 08             	sub    $0x8,%esp
    4003:	68 00 02 00 00       	push   $0x200
    4008:	68 6e 69 00 00       	push   $0x696e
    400d:	e8 dd 10 00 00       	call   50ef <open>
    4012:	83 c4 10             	add    $0x10,%esp
    4015:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    4018:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    401c:	78 0e                	js     402c <iref+0xcf>
      close(fd);
    401e:	83 ec 0c             	sub    $0xc,%esp
    4021:	ff 75 f0             	pushl  -0x10(%ebp)
    4024:	e8 ae 10 00 00       	call   50d7 <close>
    4029:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    402c:	83 ec 08             	sub    $0x8,%esp
    402f:	68 00 02 00 00       	push   $0x200
    4034:	68 6f 69 00 00       	push   $0x696f
    4039:	e8 b1 10 00 00       	call   50ef <open>
    403e:	83 c4 10             	add    $0x10,%esp
    4041:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    4044:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4048:	78 0e                	js     4058 <iref+0xfb>
      close(fd);
    404a:	83 ec 0c             	sub    $0xc,%esp
    404d:	ff 75 f0             	pushl  -0x10(%ebp)
    4050:	e8 82 10 00 00       	call   50d7 <close>
    4055:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    4058:	83 ec 0c             	sub    $0xc,%esp
    405b:	68 6f 69 00 00       	push   $0x696f
    4060:	e8 9a 10 00 00       	call   50ff <unlink>
    4065:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 50 + 1; i++){
    4068:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    406c:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    4070:	0f 8e 0f ff ff ff    	jle    3f85 <iref+0x28>
  }

  chdir("/");
    4076:	83 ec 0c             	sub    $0xc,%esp
    4079:	68 76 56 00 00       	push   $0x5676
    407e:	e8 9c 10 00 00       	call   511f <chdir>
    4083:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    4086:	83 ec 08             	sub    $0x8,%esp
    4089:	68 72 69 00 00       	push   $0x6972
    408e:	6a 01                	push   $0x1
    4090:	e8 a6 11 00 00       	call   523b <printf>
    4095:	83 c4 10             	add    $0x10,%esp
}
    4098:	90                   	nop
    4099:	c9                   	leave  
    409a:	c3                   	ret    

0000409b <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    409b:	f3 0f 1e fb          	endbr32 
    409f:	55                   	push   %ebp
    40a0:	89 e5                	mov    %esp,%ebp
    40a2:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    40a5:	83 ec 08             	sub    $0x8,%esp
    40a8:	68 86 69 00 00       	push   $0x6986
    40ad:	6a 01                	push   $0x1
    40af:	e8 87 11 00 00       	call   523b <printf>
    40b4:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    40b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    40be:	eb 1d                	jmp    40dd <forktest+0x42>
    pid = fork();
    40c0:	e8 e2 0f 00 00       	call   50a7 <fork>
    40c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    40c8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    40cc:	78 1a                	js     40e8 <forktest+0x4d>
      break;
    if(pid == 0)
    40ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    40d2:	75 05                	jne    40d9 <forktest+0x3e>
      exit();
    40d4:	e8 d6 0f 00 00       	call   50af <exit>
  for(n=0; n<1000; n++){
    40d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    40dd:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    40e4:	7e da                	jle    40c0 <forktest+0x25>
    40e6:	eb 01                	jmp    40e9 <forktest+0x4e>
      break;
    40e8:	90                   	nop
  }

  if(n == 1000){
    40e9:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    40f0:	75 3b                	jne    412d <forktest+0x92>
    printf(1, "fork claimed to work 1000 times!\n");
    40f2:	83 ec 08             	sub    $0x8,%esp
    40f5:	68 94 69 00 00       	push   $0x6994
    40fa:	6a 01                	push   $0x1
    40fc:	e8 3a 11 00 00       	call   523b <printf>
    4101:	83 c4 10             	add    $0x10,%esp
    exit();
    4104:	e8 a6 0f 00 00       	call   50af <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
    4109:	e8 a9 0f 00 00       	call   50b7 <wait>
    410e:	85 c0                	test   %eax,%eax
    4110:	79 17                	jns    4129 <forktest+0x8e>
      printf(1, "wait stopped early\n");
    4112:	83 ec 08             	sub    $0x8,%esp
    4115:	68 b6 69 00 00       	push   $0x69b6
    411a:	6a 01                	push   $0x1
    411c:	e8 1a 11 00 00       	call   523b <printf>
    4121:	83 c4 10             	add    $0x10,%esp
      exit();
    4124:	e8 86 0f 00 00       	call   50af <exit>
  for(; n > 0; n--){
    4129:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    412d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4131:	7f d6                	jg     4109 <forktest+0x6e>
    }
  }

  if(wait() != -1){
    4133:	e8 7f 0f 00 00       	call   50b7 <wait>
    4138:	83 f8 ff             	cmp    $0xffffffff,%eax
    413b:	74 17                	je     4154 <forktest+0xb9>
    printf(1, "wait got too many\n");
    413d:	83 ec 08             	sub    $0x8,%esp
    4140:	68 ca 69 00 00       	push   $0x69ca
    4145:	6a 01                	push   $0x1
    4147:	e8 ef 10 00 00       	call   523b <printf>
    414c:	83 c4 10             	add    $0x10,%esp
    exit();
    414f:	e8 5b 0f 00 00       	call   50af <exit>
  }

  printf(1, "fork test OK\n");
    4154:	83 ec 08             	sub    $0x8,%esp
    4157:	68 dd 69 00 00       	push   $0x69dd
    415c:	6a 01                	push   $0x1
    415e:	e8 d8 10 00 00       	call   523b <printf>
    4163:	83 c4 10             	add    $0x10,%esp
}
    4166:	90                   	nop
    4167:	c9                   	leave  
    4168:	c3                   	ret    

00004169 <sbrktest>:

void
sbrktest(void)
{
    4169:	f3 0f 1e fb          	endbr32 
    416d:	55                   	push   %ebp
    416e:	89 e5                	mov    %esp,%ebp
    4170:	83 ec 68             	sub    $0x68,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    4173:	a1 58 75 00 00       	mov    0x7558,%eax
    4178:	83 ec 08             	sub    $0x8,%esp
    417b:	68 eb 69 00 00       	push   $0x69eb
    4180:	50                   	push   %eax
    4181:	e8 b5 10 00 00       	call   523b <printf>
    4186:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    4189:	83 ec 0c             	sub    $0xc,%esp
    418c:	6a 00                	push   $0x0
    418e:	e8 a4 0f 00 00       	call   5137 <sbrk>
    4193:	83 c4 10             	add    $0x10,%esp
    4196:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    4199:	83 ec 0c             	sub    $0xc,%esp
    419c:	6a 00                	push   $0x0
    419e:	e8 94 0f 00 00       	call   5137 <sbrk>
    41a3:	83 c4 10             	add    $0x10,%esp
    41a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){
    41a9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    41b0:	eb 4f                	jmp    4201 <sbrktest+0x98>
    b = sbrk(1);
    41b2:	83 ec 0c             	sub    $0xc,%esp
    41b5:	6a 01                	push   $0x1
    41b7:	e8 7b 0f 00 00       	call   5137 <sbrk>
    41bc:	83 c4 10             	add    $0x10,%esp
    41bf:	89 45 d0             	mov    %eax,-0x30(%ebp)
    if(b != a){
    41c2:	8b 45 d0             	mov    -0x30(%ebp),%eax
    41c5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    41c8:	74 24                	je     41ee <sbrktest+0x85>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    41ca:	a1 58 75 00 00       	mov    0x7558,%eax
    41cf:	83 ec 0c             	sub    $0xc,%esp
    41d2:	ff 75 d0             	pushl  -0x30(%ebp)
    41d5:	ff 75 f4             	pushl  -0xc(%ebp)
    41d8:	ff 75 f0             	pushl  -0x10(%ebp)
    41db:	68 f6 69 00 00       	push   $0x69f6
    41e0:	50                   	push   %eax
    41e1:	e8 55 10 00 00       	call   523b <printf>
    41e6:	83 c4 20             	add    $0x20,%esp
      exit();
    41e9:	e8 c1 0e 00 00       	call   50af <exit>
    }
    *b = 1;
    41ee:	8b 45 d0             	mov    -0x30(%ebp),%eax
    41f1:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    41f4:	8b 45 d0             	mov    -0x30(%ebp),%eax
    41f7:	83 c0 01             	add    $0x1,%eax
    41fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; i < 5000; i++){
    41fd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    4201:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    4208:	7e a8                	jle    41b2 <sbrktest+0x49>
  }
  pid = fork();
    420a:	e8 98 0e 00 00       	call   50a7 <fork>
    420f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(pid < 0){
    4212:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    4216:	79 1b                	jns    4233 <sbrktest+0xca>
    printf(stdout, "sbrk test fork failed\n");
    4218:	a1 58 75 00 00       	mov    0x7558,%eax
    421d:	83 ec 08             	sub    $0x8,%esp
    4220:	68 11 6a 00 00       	push   $0x6a11
    4225:	50                   	push   %eax
    4226:	e8 10 10 00 00       	call   523b <printf>
    422b:	83 c4 10             	add    $0x10,%esp
    exit();
    422e:	e8 7c 0e 00 00       	call   50af <exit>
  }
  c = sbrk(1);
    4233:	83 ec 0c             	sub    $0xc,%esp
    4236:	6a 01                	push   $0x1
    4238:	e8 fa 0e 00 00       	call   5137 <sbrk>
    423d:	83 c4 10             	add    $0x10,%esp
    4240:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  c = sbrk(1);
    4243:	83 ec 0c             	sub    $0xc,%esp
    4246:	6a 01                	push   $0x1
    4248:	e8 ea 0e 00 00       	call   5137 <sbrk>
    424d:	83 c4 10             	add    $0x10,%esp
    4250:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a + 1){
    4253:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4256:	83 c0 01             	add    $0x1,%eax
    4259:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    425c:	74 1b                	je     4279 <sbrktest+0x110>
    printf(stdout, "sbrk test failed post-fork\n");
    425e:	a1 58 75 00 00       	mov    0x7558,%eax
    4263:	83 ec 08             	sub    $0x8,%esp
    4266:	68 28 6a 00 00       	push   $0x6a28
    426b:	50                   	push   %eax
    426c:	e8 ca 0f 00 00       	call   523b <printf>
    4271:	83 c4 10             	add    $0x10,%esp
    exit();
    4274:	e8 36 0e 00 00       	call   50af <exit>
  }
  if(pid == 0)
    4279:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    427d:	75 05                	jne    4284 <sbrktest+0x11b>
    exit();
    427f:	e8 2b 0e 00 00       	call   50af <exit>
  wait();
    4284:	e8 2e 0e 00 00       	call   50b7 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    4289:	83 ec 0c             	sub    $0xc,%esp
    428c:	6a 00                	push   $0x0
    428e:	e8 a4 0e 00 00       	call   5137 <sbrk>
    4293:	83 c4 10             	add    $0x10,%esp
    4296:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    4299:	8b 45 f4             	mov    -0xc(%ebp),%eax
    429c:	ba 00 00 40 06       	mov    $0x6400000,%edx
    42a1:	29 c2                	sub    %eax,%edx
    42a3:	89 d0                	mov    %edx,%eax
    42a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  p = sbrk(amt);
    42a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    42ab:	83 ec 0c             	sub    $0xc,%esp
    42ae:	50                   	push   %eax
    42af:	e8 83 0e 00 00       	call   5137 <sbrk>
    42b4:	83 c4 10             	add    $0x10,%esp
    42b7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if (p != a) {
    42ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
    42bd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    42c0:	74 1b                	je     42dd <sbrktest+0x174>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    42c2:	a1 58 75 00 00       	mov    0x7558,%eax
    42c7:	83 ec 08             	sub    $0x8,%esp
    42ca:	68 44 6a 00 00       	push   $0x6a44
    42cf:	50                   	push   %eax
    42d0:	e8 66 0f 00 00       	call   523b <printf>
    42d5:	83 c4 10             	add    $0x10,%esp
    exit();
    42d8:	e8 d2 0d 00 00       	call   50af <exit>
  }
  lastaddr = (char*) (BIG-1);
    42dd:	c7 45 d8 ff ff 3f 06 	movl   $0x63fffff,-0x28(%ebp)
  *lastaddr = 99;
    42e4:	8b 45 d8             	mov    -0x28(%ebp),%eax
    42e7:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    42ea:	83 ec 0c             	sub    $0xc,%esp
    42ed:	6a 00                	push   $0x0
    42ef:	e8 43 0e 00 00       	call   5137 <sbrk>
    42f4:	83 c4 10             	add    $0x10,%esp
    42f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    42fa:	83 ec 0c             	sub    $0xc,%esp
    42fd:	68 00 f0 ff ff       	push   $0xfffff000
    4302:	e8 30 0e 00 00       	call   5137 <sbrk>
    4307:	83 c4 10             	add    $0x10,%esp
    430a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c == (char*)0xffffffff){
    430d:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
    4311:	75 1b                	jne    432e <sbrktest+0x1c5>
    printf(stdout, "sbrk could not deallocate\n");
    4313:	a1 58 75 00 00       	mov    0x7558,%eax
    4318:	83 ec 08             	sub    $0x8,%esp
    431b:	68 82 6a 00 00       	push   $0x6a82
    4320:	50                   	push   %eax
    4321:	e8 15 0f 00 00       	call   523b <printf>
    4326:	83 c4 10             	add    $0x10,%esp
    exit();
    4329:	e8 81 0d 00 00       	call   50af <exit>
  }
  c = sbrk(0);
    432e:	83 ec 0c             	sub    $0xc,%esp
    4331:	6a 00                	push   $0x0
    4333:	e8 ff 0d 00 00       	call   5137 <sbrk>
    4338:	83 c4 10             	add    $0x10,%esp
    433b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a - 4096){
    433e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4341:	2d 00 10 00 00       	sub    $0x1000,%eax
    4346:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    4349:	74 1e                	je     4369 <sbrktest+0x200>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    434b:	a1 58 75 00 00       	mov    0x7558,%eax
    4350:	ff 75 e4             	pushl  -0x1c(%ebp)
    4353:	ff 75 f4             	pushl  -0xc(%ebp)
    4356:	68 a0 6a 00 00       	push   $0x6aa0
    435b:	50                   	push   %eax
    435c:	e8 da 0e 00 00       	call   523b <printf>
    4361:	83 c4 10             	add    $0x10,%esp
    exit();
    4364:	e8 46 0d 00 00       	call   50af <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    4369:	83 ec 0c             	sub    $0xc,%esp
    436c:	6a 00                	push   $0x0
    436e:	e8 c4 0d 00 00       	call   5137 <sbrk>
    4373:	83 c4 10             	add    $0x10,%esp
    4376:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    4379:	83 ec 0c             	sub    $0xc,%esp
    437c:	68 00 10 00 00       	push   $0x1000
    4381:	e8 b1 0d 00 00       	call   5137 <sbrk>
    4386:	83 c4 10             	add    $0x10,%esp
    4389:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    438c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    438f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    4392:	75 1a                	jne    43ae <sbrktest+0x245>
    4394:	83 ec 0c             	sub    $0xc,%esp
    4397:	6a 00                	push   $0x0
    4399:	e8 99 0d 00 00       	call   5137 <sbrk>
    439e:	83 c4 10             	add    $0x10,%esp
    43a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    43a4:	81 c2 00 10 00 00    	add    $0x1000,%edx
    43aa:	39 d0                	cmp    %edx,%eax
    43ac:	74 1e                	je     43cc <sbrktest+0x263>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    43ae:	a1 58 75 00 00       	mov    0x7558,%eax
    43b3:	ff 75 e4             	pushl  -0x1c(%ebp)
    43b6:	ff 75 f4             	pushl  -0xc(%ebp)
    43b9:	68 d8 6a 00 00       	push   $0x6ad8
    43be:	50                   	push   %eax
    43bf:	e8 77 0e 00 00       	call   523b <printf>
    43c4:	83 c4 10             	add    $0x10,%esp
    exit();
    43c7:	e8 e3 0c 00 00       	call   50af <exit>
  }
  if(*lastaddr == 99){
    43cc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    43cf:	0f b6 00             	movzbl (%eax),%eax
    43d2:	3c 63                	cmp    $0x63,%al
    43d4:	75 1b                	jne    43f1 <sbrktest+0x288>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    43d6:	a1 58 75 00 00       	mov    0x7558,%eax
    43db:	83 ec 08             	sub    $0x8,%esp
    43de:	68 00 6b 00 00       	push   $0x6b00
    43e3:	50                   	push   %eax
    43e4:	e8 52 0e 00 00       	call   523b <printf>
    43e9:	83 c4 10             	add    $0x10,%esp
    exit();
    43ec:	e8 be 0c 00 00       	call   50af <exit>
  }

  a = sbrk(0);
    43f1:	83 ec 0c             	sub    $0xc,%esp
    43f4:	6a 00                	push   $0x0
    43f6:	e8 3c 0d 00 00       	call   5137 <sbrk>
    43fb:	83 c4 10             	add    $0x10,%esp
    43fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    4401:	83 ec 0c             	sub    $0xc,%esp
    4404:	6a 00                	push   $0x0
    4406:	e8 2c 0d 00 00       	call   5137 <sbrk>
    440b:	83 c4 10             	add    $0x10,%esp
    440e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4411:	29 c2                	sub    %eax,%edx
    4413:	89 d0                	mov    %edx,%eax
    4415:	83 ec 0c             	sub    $0xc,%esp
    4418:	50                   	push   %eax
    4419:	e8 19 0d 00 00       	call   5137 <sbrk>
    441e:	83 c4 10             	add    $0x10,%esp
    4421:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a){
    4424:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4427:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    442a:	74 1e                	je     444a <sbrktest+0x2e1>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    442c:	a1 58 75 00 00       	mov    0x7558,%eax
    4431:	ff 75 e4             	pushl  -0x1c(%ebp)
    4434:	ff 75 f4             	pushl  -0xc(%ebp)
    4437:	68 30 6b 00 00       	push   $0x6b30
    443c:	50                   	push   %eax
    443d:	e8 f9 0d 00 00       	call   523b <printf>
    4442:	83 c4 10             	add    $0x10,%esp
    exit();
    4445:	e8 65 0c 00 00       	call   50af <exit>
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    444a:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    4451:	eb 76                	jmp    44c9 <sbrktest+0x360>
    ppid = getpid();
    4453:	e8 d7 0c 00 00       	call   512f <getpid>
    4458:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    pid = fork();
    445b:	e8 47 0c 00 00       	call   50a7 <fork>
    4460:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    4463:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    4467:	79 1b                	jns    4484 <sbrktest+0x31b>
      printf(stdout, "fork failed\n");
    4469:	a1 58 75 00 00       	mov    0x7558,%eax
    446e:	83 ec 08             	sub    $0x8,%esp
    4471:	68 a5 56 00 00       	push   $0x56a5
    4476:	50                   	push   %eax
    4477:	e8 bf 0d 00 00       	call   523b <printf>
    447c:	83 c4 10             	add    $0x10,%esp
      exit();
    447f:	e8 2b 0c 00 00       	call   50af <exit>
    }
    if(pid == 0){
    4484:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    4488:	75 33                	jne    44bd <sbrktest+0x354>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    448a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    448d:	0f b6 00             	movzbl (%eax),%eax
    4490:	0f be d0             	movsbl %al,%edx
    4493:	a1 58 75 00 00       	mov    0x7558,%eax
    4498:	52                   	push   %edx
    4499:	ff 75 f4             	pushl  -0xc(%ebp)
    449c:	68 51 6b 00 00       	push   $0x6b51
    44a1:	50                   	push   %eax
    44a2:	e8 94 0d 00 00       	call   523b <printf>
    44a7:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    44aa:	83 ec 0c             	sub    $0xc,%esp
    44ad:	ff 75 d4             	pushl  -0x2c(%ebp)
    44b0:	e8 2a 0c 00 00       	call   50df <kill>
    44b5:	83 c4 10             	add    $0x10,%esp
      exit();
    44b8:	e8 f2 0b 00 00       	call   50af <exit>
    }
    wait();
    44bd:	e8 f5 0b 00 00       	call   50b7 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    44c2:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    44c9:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    44d0:	76 81                	jbe    4453 <sbrktest+0x2ea>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    44d2:	83 ec 0c             	sub    $0xc,%esp
    44d5:	8d 45 c8             	lea    -0x38(%ebp),%eax
    44d8:	50                   	push   %eax
    44d9:	e8 e1 0b 00 00       	call   50bf <pipe>
    44de:	83 c4 10             	add    $0x10,%esp
    44e1:	85 c0                	test   %eax,%eax
    44e3:	74 17                	je     44fc <sbrktest+0x393>
    printf(1, "pipe() failed\n");
    44e5:	83 ec 08             	sub    $0x8,%esp
    44e8:	68 76 5a 00 00       	push   $0x5a76
    44ed:	6a 01                	push   $0x1
    44ef:	e8 47 0d 00 00       	call   523b <printf>
    44f4:	83 c4 10             	add    $0x10,%esp
    exit();
    44f7:	e8 b3 0b 00 00       	call   50af <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    44fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4503:	e9 86 00 00 00       	jmp    458e <sbrktest+0x425>
    if((pids[i] = fork()) == 0){
    4508:	e8 9a 0b 00 00       	call   50a7 <fork>
    450d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    4510:	89 44 95 a0          	mov    %eax,-0x60(%ebp,%edx,4)
    4514:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4517:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    451b:	85 c0                	test   %eax,%eax
    451d:	75 4a                	jne    4569 <sbrktest+0x400>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    451f:	83 ec 0c             	sub    $0xc,%esp
    4522:	6a 00                	push   $0x0
    4524:	e8 0e 0c 00 00       	call   5137 <sbrk>
    4529:	83 c4 10             	add    $0x10,%esp
    452c:	ba 00 00 40 06       	mov    $0x6400000,%edx
    4531:	29 c2                	sub    %eax,%edx
    4533:	89 d0                	mov    %edx,%eax
    4535:	83 ec 0c             	sub    $0xc,%esp
    4538:	50                   	push   %eax
    4539:	e8 f9 0b 00 00       	call   5137 <sbrk>
    453e:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    4541:	8b 45 cc             	mov    -0x34(%ebp),%eax
    4544:	83 ec 04             	sub    $0x4,%esp
    4547:	6a 01                	push   $0x1
    4549:	68 db 5a 00 00       	push   $0x5adb
    454e:	50                   	push   %eax
    454f:	e8 7b 0b 00 00       	call   50cf <write>
    4554:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    4557:	83 ec 0c             	sub    $0xc,%esp
    455a:	68 e8 03 00 00       	push   $0x3e8
    455f:	e8 db 0b 00 00       	call   513f <sleep>
    4564:	83 c4 10             	add    $0x10,%esp
    4567:	eb ee                	jmp    4557 <sbrktest+0x3ee>
    }
    if(pids[i] != -1)
    4569:	8b 45 f0             	mov    -0x10(%ebp),%eax
    456c:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    4570:	83 f8 ff             	cmp    $0xffffffff,%eax
    4573:	74 15                	je     458a <sbrktest+0x421>
      read(fds[0], &scratch, 1);
    4575:	8b 45 c8             	mov    -0x38(%ebp),%eax
    4578:	83 ec 04             	sub    $0x4,%esp
    457b:	6a 01                	push   $0x1
    457d:	8d 55 9f             	lea    -0x61(%ebp),%edx
    4580:	52                   	push   %edx
    4581:	50                   	push   %eax
    4582:	e8 40 0b 00 00       	call   50c7 <read>
    4587:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    458a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    458e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4591:	83 f8 09             	cmp    $0x9,%eax
    4594:	0f 86 6e ff ff ff    	jbe    4508 <sbrktest+0x39f>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    459a:	83 ec 0c             	sub    $0xc,%esp
    459d:	68 00 10 00 00       	push   $0x1000
    45a2:	e8 90 0b 00 00       	call   5137 <sbrk>
    45a7:	83 c4 10             	add    $0x10,%esp
    45aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    45ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    45b4:	eb 2b                	jmp    45e1 <sbrktest+0x478>
    if(pids[i] == -1)
    45b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    45b9:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    45bd:	83 f8 ff             	cmp    $0xffffffff,%eax
    45c0:	74 1a                	je     45dc <sbrktest+0x473>
      continue;
    kill(pids[i]);
    45c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    45c5:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    45c9:	83 ec 0c             	sub    $0xc,%esp
    45cc:	50                   	push   %eax
    45cd:	e8 0d 0b 00 00       	call   50df <kill>
    45d2:	83 c4 10             	add    $0x10,%esp
    wait();
    45d5:	e8 dd 0a 00 00       	call   50b7 <wait>
    45da:	eb 01                	jmp    45dd <sbrktest+0x474>
      continue;
    45dc:	90                   	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    45dd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    45e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    45e4:	83 f8 09             	cmp    $0x9,%eax
    45e7:	76 cd                	jbe    45b6 <sbrktest+0x44d>
  }
  if(c == (char*)0xffffffff){
    45e9:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
    45ed:	75 1b                	jne    460a <sbrktest+0x4a1>
    printf(stdout, "failed sbrk leaked memory\n");
    45ef:	a1 58 75 00 00       	mov    0x7558,%eax
    45f4:	83 ec 08             	sub    $0x8,%esp
    45f7:	68 6a 6b 00 00       	push   $0x6b6a
    45fc:	50                   	push   %eax
    45fd:	e8 39 0c 00 00       	call   523b <printf>
    4602:	83 c4 10             	add    $0x10,%esp
    exit();
    4605:	e8 a5 0a 00 00       	call   50af <exit>
  }

  if(sbrk(0) > oldbrk)
    460a:	83 ec 0c             	sub    $0xc,%esp
    460d:	6a 00                	push   $0x0
    460f:	e8 23 0b 00 00       	call   5137 <sbrk>
    4614:	83 c4 10             	add    $0x10,%esp
    4617:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    461a:	73 20                	jae    463c <sbrktest+0x4d3>
    sbrk(-(sbrk(0) - oldbrk));
    461c:	83 ec 0c             	sub    $0xc,%esp
    461f:	6a 00                	push   $0x0
    4621:	e8 11 0b 00 00       	call   5137 <sbrk>
    4626:	83 c4 10             	add    $0x10,%esp
    4629:	8b 55 ec             	mov    -0x14(%ebp),%edx
    462c:	29 c2                	sub    %eax,%edx
    462e:	89 d0                	mov    %edx,%eax
    4630:	83 ec 0c             	sub    $0xc,%esp
    4633:	50                   	push   %eax
    4634:	e8 fe 0a 00 00       	call   5137 <sbrk>
    4639:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    463c:	a1 58 75 00 00       	mov    0x7558,%eax
    4641:	83 ec 08             	sub    $0x8,%esp
    4644:	68 85 6b 00 00       	push   $0x6b85
    4649:	50                   	push   %eax
    464a:	e8 ec 0b 00 00       	call   523b <printf>
    464f:	83 c4 10             	add    $0x10,%esp
}
    4652:	90                   	nop
    4653:	c9                   	leave  
    4654:	c3                   	ret    

00004655 <validateint>:

void
validateint(int *p)
{
    4655:	f3 0f 1e fb          	endbr32 
    4659:	55                   	push   %ebp
    465a:	89 e5                	mov    %esp,%ebp
    465c:	53                   	push   %ebx
    465d:	83 ec 10             	sub    $0x10,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    4660:	b8 0d 00 00 00       	mov    $0xd,%eax
    4665:	8b 55 08             	mov    0x8(%ebp),%edx
    4668:	89 d1                	mov    %edx,%ecx
    466a:	89 e3                	mov    %esp,%ebx
    466c:	89 cc                	mov    %ecx,%esp
    466e:	cd 40                	int    $0x40
    4670:	89 dc                	mov    %ebx,%esp
    4672:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    4675:	90                   	nop
    4676:	83 c4 10             	add    $0x10,%esp
    4679:	5b                   	pop    %ebx
    467a:	5d                   	pop    %ebp
    467b:	c3                   	ret    

0000467c <validatetest>:

void
validatetest(void)
{
    467c:	f3 0f 1e fb          	endbr32 
    4680:	55                   	push   %ebp
    4681:	89 e5                	mov    %esp,%ebp
    4683:	83 ec 18             	sub    $0x18,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    4686:	a1 58 75 00 00       	mov    0x7558,%eax
    468b:	83 ec 08             	sub    $0x8,%esp
    468e:	68 93 6b 00 00       	push   $0x6b93
    4693:	50                   	push   %eax
    4694:	e8 a2 0b 00 00       	call   523b <printf>
    4699:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    469c:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    46a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    46aa:	e9 8a 00 00 00       	jmp    4739 <validatetest+0xbd>
    if((pid = fork()) == 0){
    46af:	e8 f3 09 00 00       	call   50a7 <fork>
    46b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    46b7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    46bb:	75 14                	jne    46d1 <validatetest+0x55>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    46bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    46c0:	83 ec 0c             	sub    $0xc,%esp
    46c3:	50                   	push   %eax
    46c4:	e8 8c ff ff ff       	call   4655 <validateint>
    46c9:	83 c4 10             	add    $0x10,%esp
      exit();
    46cc:	e8 de 09 00 00       	call   50af <exit>
    }
    sleep(0);
    46d1:	83 ec 0c             	sub    $0xc,%esp
    46d4:	6a 00                	push   $0x0
    46d6:	e8 64 0a 00 00       	call   513f <sleep>
    46db:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    46de:	83 ec 0c             	sub    $0xc,%esp
    46e1:	6a 00                	push   $0x0
    46e3:	e8 57 0a 00 00       	call   513f <sleep>
    46e8:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    46eb:	83 ec 0c             	sub    $0xc,%esp
    46ee:	ff 75 ec             	pushl  -0x14(%ebp)
    46f1:	e8 e9 09 00 00       	call   50df <kill>
    46f6:	83 c4 10             	add    $0x10,%esp
    wait();
    46f9:	e8 b9 09 00 00       	call   50b7 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    46fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4701:	83 ec 08             	sub    $0x8,%esp
    4704:	50                   	push   %eax
    4705:	68 a2 6b 00 00       	push   $0x6ba2
    470a:	e8 00 0a 00 00       	call   510f <link>
    470f:	83 c4 10             	add    $0x10,%esp
    4712:	83 f8 ff             	cmp    $0xffffffff,%eax
    4715:	74 1b                	je     4732 <validatetest+0xb6>
      printf(stdout, "link should not succeed\n");
    4717:	a1 58 75 00 00       	mov    0x7558,%eax
    471c:	83 ec 08             	sub    $0x8,%esp
    471f:	68 ad 6b 00 00       	push   $0x6bad
    4724:	50                   	push   %eax
    4725:	e8 11 0b 00 00       	call   523b <printf>
    472a:	83 c4 10             	add    $0x10,%esp
      exit();
    472d:	e8 7d 09 00 00       	call   50af <exit>
  for(p = 0; p <= (uint)hi; p += 4096){
    4732:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    4739:	8b 45 f0             	mov    -0x10(%ebp),%eax
    473c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    473f:	0f 86 6a ff ff ff    	jbe    46af <validatetest+0x33>
    }
  }

  printf(stdout, "validate ok\n");
    4745:	a1 58 75 00 00       	mov    0x7558,%eax
    474a:	83 ec 08             	sub    $0x8,%esp
    474d:	68 c6 6b 00 00       	push   $0x6bc6
    4752:	50                   	push   %eax
    4753:	e8 e3 0a 00 00       	call   523b <printf>
    4758:	83 c4 10             	add    $0x10,%esp
}
    475b:	90                   	nop
    475c:	c9                   	leave  
    475d:	c3                   	ret    

0000475e <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    475e:	f3 0f 1e fb          	endbr32 
    4762:	55                   	push   %ebp
    4763:	89 e5                	mov    %esp,%ebp
    4765:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    4768:	a1 58 75 00 00       	mov    0x7558,%eax
    476d:	83 ec 08             	sub    $0x8,%esp
    4770:	68 d3 6b 00 00       	push   $0x6bd3
    4775:	50                   	push   %eax
    4776:	e8 c0 0a 00 00       	call   523b <printf>
    477b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    477e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    4785:	eb 2e                	jmp    47b5 <bsstest+0x57>
    if(uninit[i] != '\0'){
    4787:	8b 45 f4             	mov    -0xc(%ebp),%eax
    478a:	05 20 76 00 00       	add    $0x7620,%eax
    478f:	0f b6 00             	movzbl (%eax),%eax
    4792:	84 c0                	test   %al,%al
    4794:	74 1b                	je     47b1 <bsstest+0x53>
      printf(stdout, "bss test failed\n");
    4796:	a1 58 75 00 00       	mov    0x7558,%eax
    479b:	83 ec 08             	sub    $0x8,%esp
    479e:	68 dd 6b 00 00       	push   $0x6bdd
    47a3:	50                   	push   %eax
    47a4:	e8 92 0a 00 00       	call   523b <printf>
    47a9:	83 c4 10             	add    $0x10,%esp
      exit();
    47ac:	e8 fe 08 00 00       	call   50af <exit>
  for(i = 0; i < sizeof(uninit); i++){
    47b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    47b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47b8:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    47bd:	76 c8                	jbe    4787 <bsstest+0x29>
    }
  }
  printf(stdout, "bss test ok\n");
    47bf:	a1 58 75 00 00       	mov    0x7558,%eax
    47c4:	83 ec 08             	sub    $0x8,%esp
    47c7:	68 ee 6b 00 00       	push   $0x6bee
    47cc:	50                   	push   %eax
    47cd:	e8 69 0a 00 00       	call   523b <printf>
    47d2:	83 c4 10             	add    $0x10,%esp
}
    47d5:	90                   	nop
    47d6:	c9                   	leave  
    47d7:	c3                   	ret    

000047d8 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    47d8:	f3 0f 1e fb          	endbr32 
    47dc:	55                   	push   %ebp
    47dd:	89 e5                	mov    %esp,%ebp
    47df:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    47e2:	83 ec 0c             	sub    $0xc,%esp
    47e5:	68 fb 6b 00 00       	push   $0x6bfb
    47ea:	e8 10 09 00 00       	call   50ff <unlink>
    47ef:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    47f2:	e8 b0 08 00 00       	call   50a7 <fork>
    47f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    47fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    47fe:	0f 85 97 00 00 00    	jne    489b <bigargtest+0xc3>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    4804:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    480b:	eb 12                	jmp    481f <bigargtest+0x47>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    480d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4810:	c7 04 85 80 75 00 00 	movl   $0x6c08,0x7580(,%eax,4)
    4817:	08 6c 00 00 
    for(i = 0; i < MAXARG-1; i++)
    481b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    481f:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    4823:	7e e8                	jle    480d <bigargtest+0x35>
    args[MAXARG-1] = 0;
    4825:	c7 05 fc 75 00 00 00 	movl   $0x0,0x75fc
    482c:	00 00 00 
    printf(stdout, "bigarg test\n");
    482f:	a1 58 75 00 00       	mov    0x7558,%eax
    4834:	83 ec 08             	sub    $0x8,%esp
    4837:	68 e5 6c 00 00       	push   $0x6ce5
    483c:	50                   	push   %eax
    483d:	e8 f9 09 00 00       	call   523b <printf>
    4842:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    4845:	83 ec 08             	sub    $0x8,%esp
    4848:	68 80 75 00 00       	push   $0x7580
    484d:	68 04 56 00 00       	push   $0x5604
    4852:	e8 90 08 00 00       	call   50e7 <exec>
    4857:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    485a:	a1 58 75 00 00       	mov    0x7558,%eax
    485f:	83 ec 08             	sub    $0x8,%esp
    4862:	68 f2 6c 00 00       	push   $0x6cf2
    4867:	50                   	push   %eax
    4868:	e8 ce 09 00 00       	call   523b <printf>
    486d:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    4870:	83 ec 08             	sub    $0x8,%esp
    4873:	68 00 02 00 00       	push   $0x200
    4878:	68 fb 6b 00 00       	push   $0x6bfb
    487d:	e8 6d 08 00 00       	call   50ef <open>
    4882:	83 c4 10             	add    $0x10,%esp
    4885:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    4888:	83 ec 0c             	sub    $0xc,%esp
    488b:	ff 75 ec             	pushl  -0x14(%ebp)
    488e:	e8 44 08 00 00       	call   50d7 <close>
    4893:	83 c4 10             	add    $0x10,%esp
    exit();
    4896:	e8 14 08 00 00       	call   50af <exit>
  } else if(pid < 0){
    489b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    489f:	79 1b                	jns    48bc <bigargtest+0xe4>
    printf(stdout, "bigargtest: fork failed\n");
    48a1:	a1 58 75 00 00       	mov    0x7558,%eax
    48a6:	83 ec 08             	sub    $0x8,%esp
    48a9:	68 02 6d 00 00       	push   $0x6d02
    48ae:	50                   	push   %eax
    48af:	e8 87 09 00 00       	call   523b <printf>
    48b4:	83 c4 10             	add    $0x10,%esp
    exit();
    48b7:	e8 f3 07 00 00       	call   50af <exit>
  }
  wait();
    48bc:	e8 f6 07 00 00       	call   50b7 <wait>
  fd = open("bigarg-ok", 0);
    48c1:	83 ec 08             	sub    $0x8,%esp
    48c4:	6a 00                	push   $0x0
    48c6:	68 fb 6b 00 00       	push   $0x6bfb
    48cb:	e8 1f 08 00 00       	call   50ef <open>
    48d0:	83 c4 10             	add    $0x10,%esp
    48d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    48d6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    48da:	79 1b                	jns    48f7 <bigargtest+0x11f>
    printf(stdout, "bigarg test failed!\n");
    48dc:	a1 58 75 00 00       	mov    0x7558,%eax
    48e1:	83 ec 08             	sub    $0x8,%esp
    48e4:	68 1b 6d 00 00       	push   $0x6d1b
    48e9:	50                   	push   %eax
    48ea:	e8 4c 09 00 00       	call   523b <printf>
    48ef:	83 c4 10             	add    $0x10,%esp
    exit();
    48f2:	e8 b8 07 00 00       	call   50af <exit>
  }
  close(fd);
    48f7:	83 ec 0c             	sub    $0xc,%esp
    48fa:	ff 75 ec             	pushl  -0x14(%ebp)
    48fd:	e8 d5 07 00 00       	call   50d7 <close>
    4902:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    4905:	83 ec 0c             	sub    $0xc,%esp
    4908:	68 fb 6b 00 00       	push   $0x6bfb
    490d:	e8 ed 07 00 00       	call   50ff <unlink>
    4912:	83 c4 10             	add    $0x10,%esp
}
    4915:	90                   	nop
    4916:	c9                   	leave  
    4917:	c3                   	ret    

00004918 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    4918:	f3 0f 1e fb          	endbr32 
    491c:	55                   	push   %ebp
    491d:	89 e5                	mov    %esp,%ebp
    491f:	53                   	push   %ebx
    4920:	83 ec 64             	sub    $0x64,%esp
  int nfiles;
  int fsblocks = 0;
    4923:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    492a:	83 ec 08             	sub    $0x8,%esp
    492d:	68 30 6d 00 00       	push   $0x6d30
    4932:	6a 01                	push   $0x1
    4934:	e8 02 09 00 00       	call   523b <printf>
    4939:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    493c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    4943:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    4947:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    494a:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    494f:	89 c8                	mov    %ecx,%eax
    4951:	f7 ea                	imul   %edx
    4953:	c1 fa 06             	sar    $0x6,%edx
    4956:	89 c8                	mov    %ecx,%eax
    4958:	c1 f8 1f             	sar    $0x1f,%eax
    495b:	29 c2                	sub    %eax,%edx
    495d:	89 d0                	mov    %edx,%eax
    495f:	83 c0 30             	add    $0x30,%eax
    4962:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    4965:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    4968:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    496d:	89 d8                	mov    %ebx,%eax
    496f:	f7 ea                	imul   %edx
    4971:	c1 fa 06             	sar    $0x6,%edx
    4974:	89 d8                	mov    %ebx,%eax
    4976:	c1 f8 1f             	sar    $0x1f,%eax
    4979:	89 d1                	mov    %edx,%ecx
    497b:	29 c1                	sub    %eax,%ecx
    497d:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    4983:	29 c3                	sub    %eax,%ebx
    4985:	89 d9                	mov    %ebx,%ecx
    4987:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    498c:	89 c8                	mov    %ecx,%eax
    498e:	f7 ea                	imul   %edx
    4990:	c1 fa 05             	sar    $0x5,%edx
    4993:	89 c8                	mov    %ecx,%eax
    4995:	c1 f8 1f             	sar    $0x1f,%eax
    4998:	29 c2                	sub    %eax,%edx
    499a:	89 d0                	mov    %edx,%eax
    499c:	83 c0 30             	add    $0x30,%eax
    499f:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    49a2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    49a5:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    49aa:	89 d8                	mov    %ebx,%eax
    49ac:	f7 ea                	imul   %edx
    49ae:	c1 fa 05             	sar    $0x5,%edx
    49b1:	89 d8                	mov    %ebx,%eax
    49b3:	c1 f8 1f             	sar    $0x1f,%eax
    49b6:	89 d1                	mov    %edx,%ecx
    49b8:	29 c1                	sub    %eax,%ecx
    49ba:	6b c1 64             	imul   $0x64,%ecx,%eax
    49bd:	29 c3                	sub    %eax,%ebx
    49bf:	89 d9                	mov    %ebx,%ecx
    49c1:	ba 67 66 66 66       	mov    $0x66666667,%edx
    49c6:	89 c8                	mov    %ecx,%eax
    49c8:	f7 ea                	imul   %edx
    49ca:	c1 fa 02             	sar    $0x2,%edx
    49cd:	89 c8                	mov    %ecx,%eax
    49cf:	c1 f8 1f             	sar    $0x1f,%eax
    49d2:	29 c2                	sub    %eax,%edx
    49d4:	89 d0                	mov    %edx,%eax
    49d6:	83 c0 30             	add    $0x30,%eax
    49d9:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    49dc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    49df:	ba 67 66 66 66       	mov    $0x66666667,%edx
    49e4:	89 c8                	mov    %ecx,%eax
    49e6:	f7 ea                	imul   %edx
    49e8:	c1 fa 02             	sar    $0x2,%edx
    49eb:	89 c8                	mov    %ecx,%eax
    49ed:	c1 f8 1f             	sar    $0x1f,%eax
    49f0:	29 c2                	sub    %eax,%edx
    49f2:	89 d0                	mov    %edx,%eax
    49f4:	c1 e0 02             	shl    $0x2,%eax
    49f7:	01 d0                	add    %edx,%eax
    49f9:	01 c0                	add    %eax,%eax
    49fb:	29 c1                	sub    %eax,%ecx
    49fd:	89 ca                	mov    %ecx,%edx
    49ff:	89 d0                	mov    %edx,%eax
    4a01:	83 c0 30             	add    $0x30,%eax
    4a04:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    4a07:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    4a0b:	83 ec 04             	sub    $0x4,%esp
    4a0e:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    4a11:	50                   	push   %eax
    4a12:	68 3d 6d 00 00       	push   $0x6d3d
    4a17:	6a 01                	push   $0x1
    4a19:	e8 1d 08 00 00       	call   523b <printf>
    4a1e:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    4a21:	83 ec 08             	sub    $0x8,%esp
    4a24:	68 02 02 00 00       	push   $0x202
    4a29:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    4a2c:	50                   	push   %eax
    4a2d:	e8 bd 06 00 00       	call   50ef <open>
    4a32:	83 c4 10             	add    $0x10,%esp
    4a35:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    4a38:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    4a3c:	79 18                	jns    4a56 <fsfull+0x13e>
      printf(1, "open %s failed\n", name);
    4a3e:	83 ec 04             	sub    $0x4,%esp
    4a41:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    4a44:	50                   	push   %eax
    4a45:	68 49 6d 00 00       	push   $0x6d49
    4a4a:	6a 01                	push   $0x1
    4a4c:	e8 ea 07 00 00       	call   523b <printf>
    4a51:	83 c4 10             	add    $0x10,%esp
      break;
    4a54:	eb 6b                	jmp    4ac1 <fsfull+0x1a9>
    }
    int total = 0;
    4a56:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    4a5d:	83 ec 04             	sub    $0x4,%esp
    4a60:	68 00 02 00 00       	push   $0x200
    4a65:	68 40 9d 00 00       	push   $0x9d40
    4a6a:	ff 75 e8             	pushl  -0x18(%ebp)
    4a6d:	e8 5d 06 00 00       	call   50cf <write>
    4a72:	83 c4 10             	add    $0x10,%esp
    4a75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    4a78:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    4a7f:	7e 0c                	jle    4a8d <fsfull+0x175>
        break;
      total += cc;
    4a81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4a84:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    4a87:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    while(1){
    4a8b:	eb d0                	jmp    4a5d <fsfull+0x145>
        break;
    4a8d:	90                   	nop
    }
    printf(1, "wrote %d bytes\n", total);
    4a8e:	83 ec 04             	sub    $0x4,%esp
    4a91:	ff 75 ec             	pushl  -0x14(%ebp)
    4a94:	68 59 6d 00 00       	push   $0x6d59
    4a99:	6a 01                	push   $0x1
    4a9b:	e8 9b 07 00 00       	call   523b <printf>
    4aa0:	83 c4 10             	add    $0x10,%esp
    close(fd);
    4aa3:	83 ec 0c             	sub    $0xc,%esp
    4aa6:	ff 75 e8             	pushl  -0x18(%ebp)
    4aa9:	e8 29 06 00 00       	call   50d7 <close>
    4aae:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    4ab1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4ab5:	74 09                	je     4ac0 <fsfull+0x1a8>
  for(nfiles = 0; ; nfiles++){
    4ab7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    4abb:	e9 83 fe ff ff       	jmp    4943 <fsfull+0x2b>
      break;
    4ac0:	90                   	nop
  }

  while(nfiles >= 0){
    4ac1:	e9 db 00 00 00       	jmp    4ba1 <fsfull+0x289>
    char name[64];
    name[0] = 'f';
    4ac6:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    4aca:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    4acd:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    4ad2:	89 c8                	mov    %ecx,%eax
    4ad4:	f7 ea                	imul   %edx
    4ad6:	c1 fa 06             	sar    $0x6,%edx
    4ad9:	89 c8                	mov    %ecx,%eax
    4adb:	c1 f8 1f             	sar    $0x1f,%eax
    4ade:	29 c2                	sub    %eax,%edx
    4ae0:	89 d0                	mov    %edx,%eax
    4ae2:	83 c0 30             	add    $0x30,%eax
    4ae5:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    4ae8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    4aeb:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    4af0:	89 d8                	mov    %ebx,%eax
    4af2:	f7 ea                	imul   %edx
    4af4:	c1 fa 06             	sar    $0x6,%edx
    4af7:	89 d8                	mov    %ebx,%eax
    4af9:	c1 f8 1f             	sar    $0x1f,%eax
    4afc:	89 d1                	mov    %edx,%ecx
    4afe:	29 c1                	sub    %eax,%ecx
    4b00:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    4b06:	29 c3                	sub    %eax,%ebx
    4b08:	89 d9                	mov    %ebx,%ecx
    4b0a:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    4b0f:	89 c8                	mov    %ecx,%eax
    4b11:	f7 ea                	imul   %edx
    4b13:	c1 fa 05             	sar    $0x5,%edx
    4b16:	89 c8                	mov    %ecx,%eax
    4b18:	c1 f8 1f             	sar    $0x1f,%eax
    4b1b:	29 c2                	sub    %eax,%edx
    4b1d:	89 d0                	mov    %edx,%eax
    4b1f:	83 c0 30             	add    $0x30,%eax
    4b22:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    4b25:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    4b28:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    4b2d:	89 d8                	mov    %ebx,%eax
    4b2f:	f7 ea                	imul   %edx
    4b31:	c1 fa 05             	sar    $0x5,%edx
    4b34:	89 d8                	mov    %ebx,%eax
    4b36:	c1 f8 1f             	sar    $0x1f,%eax
    4b39:	89 d1                	mov    %edx,%ecx
    4b3b:	29 c1                	sub    %eax,%ecx
    4b3d:	6b c1 64             	imul   $0x64,%ecx,%eax
    4b40:	29 c3                	sub    %eax,%ebx
    4b42:	89 d9                	mov    %ebx,%ecx
    4b44:	ba 67 66 66 66       	mov    $0x66666667,%edx
    4b49:	89 c8                	mov    %ecx,%eax
    4b4b:	f7 ea                	imul   %edx
    4b4d:	c1 fa 02             	sar    $0x2,%edx
    4b50:	89 c8                	mov    %ecx,%eax
    4b52:	c1 f8 1f             	sar    $0x1f,%eax
    4b55:	29 c2                	sub    %eax,%edx
    4b57:	89 d0                	mov    %edx,%eax
    4b59:	83 c0 30             	add    $0x30,%eax
    4b5c:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    4b5f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    4b62:	ba 67 66 66 66       	mov    $0x66666667,%edx
    4b67:	89 c8                	mov    %ecx,%eax
    4b69:	f7 ea                	imul   %edx
    4b6b:	c1 fa 02             	sar    $0x2,%edx
    4b6e:	89 c8                	mov    %ecx,%eax
    4b70:	c1 f8 1f             	sar    $0x1f,%eax
    4b73:	29 c2                	sub    %eax,%edx
    4b75:	89 d0                	mov    %edx,%eax
    4b77:	c1 e0 02             	shl    $0x2,%eax
    4b7a:	01 d0                	add    %edx,%eax
    4b7c:	01 c0                	add    %eax,%eax
    4b7e:	29 c1                	sub    %eax,%ecx
    4b80:	89 ca                	mov    %ecx,%edx
    4b82:	89 d0                	mov    %edx,%eax
    4b84:	83 c0 30             	add    $0x30,%eax
    4b87:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    4b8a:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    4b8e:	83 ec 0c             	sub    $0xc,%esp
    4b91:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    4b94:	50                   	push   %eax
    4b95:	e8 65 05 00 00       	call   50ff <unlink>
    4b9a:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    4b9d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  while(nfiles >= 0){
    4ba1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4ba5:	0f 89 1b ff ff ff    	jns    4ac6 <fsfull+0x1ae>
  }

  printf(1, "fsfull test finished\n");
    4bab:	83 ec 08             	sub    $0x8,%esp
    4bae:	68 69 6d 00 00       	push   $0x6d69
    4bb3:	6a 01                	push   $0x1
    4bb5:	e8 81 06 00 00       	call   523b <printf>
    4bba:	83 c4 10             	add    $0x10,%esp
}
    4bbd:	90                   	nop
    4bbe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4bc1:	c9                   	leave  
    4bc2:	c3                   	ret    

00004bc3 <uio>:

void
uio()
{
    4bc3:	f3 0f 1e fb          	endbr32 
    4bc7:	55                   	push   %ebp
    4bc8:	89 e5                	mov    %esp,%ebp
    4bca:	83 ec 18             	sub    $0x18,%esp
  #define RTC_ADDR 0x70
  #define RTC_DATA 0x71

  ushort port = 0;
    4bcd:	66 c7 45 f6 00 00    	movw   $0x0,-0xa(%ebp)
  uchar val = 0;
    4bd3:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
  int pid;

  printf(1, "uio test\n");
    4bd7:	83 ec 08             	sub    $0x8,%esp
    4bda:	68 7f 6d 00 00       	push   $0x6d7f
    4bdf:	6a 01                	push   $0x1
    4be1:	e8 55 06 00 00       	call   523b <printf>
    4be6:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    4be9:	e8 b9 04 00 00       	call   50a7 <fork>
    4bee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    4bf1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4bf5:	75 3a                	jne    4c31 <uio+0x6e>
    port = RTC_ADDR;
    4bf7:	66 c7 45 f6 70 00    	movw   $0x70,-0xa(%ebp)
    val = 0x09;  /* year */
    4bfd:	c6 45 f5 09          	movb   $0x9,-0xb(%ebp)
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    4c01:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    4c05:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
    4c09:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    4c0a:	66 c7 45 f6 71 00    	movw   $0x71,-0xa(%ebp)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    4c10:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
    4c14:	89 c2                	mov    %eax,%edx
    4c16:	ec                   	in     (%dx),%al
    4c17:	88 45 f5             	mov    %al,-0xb(%ebp)
    printf(1, "uio: uio succeeded; test FAILED\n");
    4c1a:	83 ec 08             	sub    $0x8,%esp
    4c1d:	68 8c 6d 00 00       	push   $0x6d8c
    4c22:	6a 01                	push   $0x1
    4c24:	e8 12 06 00 00       	call   523b <printf>
    4c29:	83 c4 10             	add    $0x10,%esp
    exit();
    4c2c:	e8 7e 04 00 00       	call   50af <exit>
  } else if(pid < 0){
    4c31:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4c35:	79 17                	jns    4c4e <uio+0x8b>
    printf (1, "fork failed\n");
    4c37:	83 ec 08             	sub    $0x8,%esp
    4c3a:	68 a5 56 00 00       	push   $0x56a5
    4c3f:	6a 01                	push   $0x1
    4c41:	e8 f5 05 00 00       	call   523b <printf>
    4c46:	83 c4 10             	add    $0x10,%esp
    exit();
    4c49:	e8 61 04 00 00       	call   50af <exit>
  }
  wait();
    4c4e:	e8 64 04 00 00       	call   50b7 <wait>
  printf(1, "uio test done\n");
    4c53:	83 ec 08             	sub    $0x8,%esp
    4c56:	68 ad 6d 00 00       	push   $0x6dad
    4c5b:	6a 01                	push   $0x1
    4c5d:	e8 d9 05 00 00       	call   523b <printf>
    4c62:	83 c4 10             	add    $0x10,%esp
}
    4c65:	90                   	nop
    4c66:	c9                   	leave  
    4c67:	c3                   	ret    

00004c68 <argptest>:

void argptest()
{
    4c68:	f3 0f 1e fb          	endbr32 
    4c6c:	55                   	push   %ebp
    4c6d:	89 e5                	mov    %esp,%ebp
    4c6f:	83 ec 18             	sub    $0x18,%esp
  int fd;
  fd = open("init", O_RDONLY);
    4c72:	83 ec 08             	sub    $0x8,%esp
    4c75:	6a 00                	push   $0x0
    4c77:	68 bc 6d 00 00       	push   $0x6dbc
    4c7c:	e8 6e 04 00 00       	call   50ef <open>
    4c81:	83 c4 10             	add    $0x10,%esp
    4c84:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (fd < 0) {
    4c87:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4c8b:	79 17                	jns    4ca4 <argptest+0x3c>
    printf(2, "open failed\n");
    4c8d:	83 ec 08             	sub    $0x8,%esp
    4c90:	68 c1 6d 00 00       	push   $0x6dc1
    4c95:	6a 02                	push   $0x2
    4c97:	e8 9f 05 00 00       	call   523b <printf>
    4c9c:	83 c4 10             	add    $0x10,%esp
    exit();
    4c9f:	e8 0b 04 00 00       	call   50af <exit>
  }
  read(fd, sbrk(0) - 1, -1);
    4ca4:	83 ec 0c             	sub    $0xc,%esp
    4ca7:	6a 00                	push   $0x0
    4ca9:	e8 89 04 00 00       	call   5137 <sbrk>
    4cae:	83 c4 10             	add    $0x10,%esp
    4cb1:	83 e8 01             	sub    $0x1,%eax
    4cb4:	83 ec 04             	sub    $0x4,%esp
    4cb7:	6a ff                	push   $0xffffffff
    4cb9:	50                   	push   %eax
    4cba:	ff 75 f4             	pushl  -0xc(%ebp)
    4cbd:	e8 05 04 00 00       	call   50c7 <read>
    4cc2:	83 c4 10             	add    $0x10,%esp
  close(fd);
    4cc5:	83 ec 0c             	sub    $0xc,%esp
    4cc8:	ff 75 f4             	pushl  -0xc(%ebp)
    4ccb:	e8 07 04 00 00       	call   50d7 <close>
    4cd0:	83 c4 10             	add    $0x10,%esp
  printf(1, "arg test passed\n");
    4cd3:	83 ec 08             	sub    $0x8,%esp
    4cd6:	68 ce 6d 00 00       	push   $0x6dce
    4cdb:	6a 01                	push   $0x1
    4cdd:	e8 59 05 00 00       	call   523b <printf>
    4ce2:	83 c4 10             	add    $0x10,%esp
}
    4ce5:	90                   	nop
    4ce6:	c9                   	leave  
    4ce7:	c3                   	ret    

00004ce8 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    4ce8:	f3 0f 1e fb          	endbr32 
    4cec:	55                   	push   %ebp
    4ced:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    4cef:	a1 5c 75 00 00       	mov    0x755c,%eax
    4cf4:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    4cfa:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    4cff:	a3 5c 75 00 00       	mov    %eax,0x755c
  return randstate;
    4d04:	a1 5c 75 00 00       	mov    0x755c,%eax
}
    4d09:	5d                   	pop    %ebp
    4d0a:	c3                   	ret    

00004d0b <main>:

int
main(int argc, char *argv[])
{
    4d0b:	f3 0f 1e fb          	endbr32 
    4d0f:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    4d13:	83 e4 f0             	and    $0xfffffff0,%esp
    4d16:	ff 71 fc             	pushl  -0x4(%ecx)
    4d19:	55                   	push   %ebp
    4d1a:	89 e5                	mov    %esp,%ebp
    4d1c:	51                   	push   %ecx
    4d1d:	83 ec 04             	sub    $0x4,%esp
  printf(1, "usertests starting\n");
    4d20:	83 ec 08             	sub    $0x8,%esp
    4d23:	68 df 6d 00 00       	push   $0x6ddf
    4d28:	6a 01                	push   $0x1
    4d2a:	e8 0c 05 00 00       	call   523b <printf>
    4d2f:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    4d32:	83 ec 08             	sub    $0x8,%esp
    4d35:	6a 00                	push   $0x0
    4d37:	68 f3 6d 00 00       	push   $0x6df3
    4d3c:	e8 ae 03 00 00       	call   50ef <open>
    4d41:	83 c4 10             	add    $0x10,%esp
    4d44:	85 c0                	test   %eax,%eax
    4d46:	78 17                	js     4d5f <main+0x54>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    4d48:	83 ec 08             	sub    $0x8,%esp
    4d4b:	68 04 6e 00 00       	push   $0x6e04
    4d50:	6a 01                	push   $0x1
    4d52:	e8 e4 04 00 00       	call   523b <printf>
    4d57:	83 c4 10             	add    $0x10,%esp
    exit();
    4d5a:	e8 50 03 00 00       	call   50af <exit>
  }
  close(open("usertests.ran", O_CREATE));
    4d5f:	83 ec 08             	sub    $0x8,%esp
    4d62:	68 00 02 00 00       	push   $0x200
    4d67:	68 f3 6d 00 00       	push   $0x6df3
    4d6c:	e8 7e 03 00 00       	call   50ef <open>
    4d71:	83 c4 10             	add    $0x10,%esp
    4d74:	83 ec 0c             	sub    $0xc,%esp
    4d77:	50                   	push   %eax
    4d78:	e8 5a 03 00 00       	call   50d7 <close>
    4d7d:	83 c4 10             	add    $0x10,%esp

  argptest();
    4d80:	e8 e3 fe ff ff       	call   4c68 <argptest>
  createdelete();
    4d85:	e8 5c d5 ff ff       	call   22e6 <createdelete>
  linkunlink();
    4d8a:	e8 8d df ff ff       	call   2d1c <linkunlink>
  concreate();
    4d8f:	e8 d4 db ff ff       	call   2968 <concreate>
  fourfiles();
    4d94:	e8 f8 d2 ff ff       	call   2091 <fourfiles>
  sharedfd();
    4d99:	e8 0c d1 ff ff       	call   1eaa <sharedfd>

  bigargtest();
    4d9e:	e8 35 fa ff ff       	call   47d8 <bigargtest>
  bigwrite();
    4da3:	e8 72 e9 ff ff       	call   371a <bigwrite>
  bigargtest();
    4da8:	e8 2b fa ff ff       	call   47d8 <bigargtest>
  bsstest();
    4dad:	e8 ac f9 ff ff       	call   475e <bsstest>
  sbrktest();
    4db2:	e8 b2 f3 ff ff       	call   4169 <sbrktest>
  validatetest();
    4db7:	e8 c0 f8 ff ff       	call   467c <validatetest>

  opentest();
    4dbc:	e8 4a c5 ff ff       	call   130b <opentest>
  writetest();
    4dc1:	e8 f8 c5 ff ff       	call   13be <writetest>
  writetest1();
    4dc6:	e8 07 c8 ff ff       	call   15d2 <writetest1>
  createtest();
    4dcb:	e8 02 ca ff ff       	call   17d2 <createtest>

  openiputtest();
    4dd0:	e8 23 c4 ff ff       	call   11f8 <openiputtest>
  exitiputtest();
    4dd5:	e8 1b c3 ff ff       	call   10f5 <exitiputtest>
  iputtest();
    4dda:	e8 21 c2 ff ff       	call   1000 <iputtest>

  mem();
    4ddf:	e8 d1 cf ff ff       	call   1db5 <mem>
  pipe1();
    4de4:	e8 fc cb ff ff       	call   19e5 <pipe1>
  preempt();
    4de9:	e8 e4 cd ff ff       	call   1bd2 <preempt>
  exitwait();
    4dee:	e8 46 cf ff ff       	call   1d39 <exitwait>

  rmdot();
    4df3:	e8 a0 ed ff ff       	call   3b98 <rmdot>
  fourteen();
    4df8:	e8 3b ec ff ff       	call   3a38 <fourteen>
  bigfile();
    4dfd:	e8 1a ea ff ff       	call   381c <bigfile>
  subdir();
    4e02:	e8 cb e1 ff ff       	call   2fd2 <subdir>
  linktest();
    4e07:	e8 16 d9 ff ff       	call   2722 <linktest>
  unlinkread();
    4e0c:	e8 4b d7 ff ff       	call   255c <unlinkread>
  dirfile();
    4e11:	e8 0b ef ff ff       	call   3d21 <dirfile>
  iref();
    4e16:	e8 42 f1 ff ff       	call   3f5d <iref>
  forktest();
    4e1b:	e8 7b f2 ff ff       	call   409b <forktest>
  bigdir(); // slow
    4e20:	e8 34 e0 ff ff       	call   2e59 <bigdir>

  uio();
    4e25:	e8 99 fd ff ff       	call   4bc3 <uio>

  exectest();
    4e2a:	e8 5f cb ff ff       	call   198e <exectest>

  exit();
    4e2f:	e8 7b 02 00 00       	call   50af <exit>

00004e34 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    4e34:	55                   	push   %ebp
    4e35:	89 e5                	mov    %esp,%ebp
    4e37:	57                   	push   %edi
    4e38:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    4e39:	8b 4d 08             	mov    0x8(%ebp),%ecx
    4e3c:	8b 55 10             	mov    0x10(%ebp),%edx
    4e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
    4e42:	89 cb                	mov    %ecx,%ebx
    4e44:	89 df                	mov    %ebx,%edi
    4e46:	89 d1                	mov    %edx,%ecx
    4e48:	fc                   	cld    
    4e49:	f3 aa                	rep stos %al,%es:(%edi)
    4e4b:	89 ca                	mov    %ecx,%edx
    4e4d:	89 fb                	mov    %edi,%ebx
    4e4f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    4e52:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    4e55:	90                   	nop
    4e56:	5b                   	pop    %ebx
    4e57:	5f                   	pop    %edi
    4e58:	5d                   	pop    %ebp
    4e59:	c3                   	ret    

00004e5a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    4e5a:	f3 0f 1e fb          	endbr32 
    4e5e:	55                   	push   %ebp
    4e5f:	89 e5                	mov    %esp,%ebp
    4e61:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    4e64:	8b 45 08             	mov    0x8(%ebp),%eax
    4e67:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    4e6a:	90                   	nop
    4e6b:	8b 55 0c             	mov    0xc(%ebp),%edx
    4e6e:	8d 42 01             	lea    0x1(%edx),%eax
    4e71:	89 45 0c             	mov    %eax,0xc(%ebp)
    4e74:	8b 45 08             	mov    0x8(%ebp),%eax
    4e77:	8d 48 01             	lea    0x1(%eax),%ecx
    4e7a:	89 4d 08             	mov    %ecx,0x8(%ebp)
    4e7d:	0f b6 12             	movzbl (%edx),%edx
    4e80:	88 10                	mov    %dl,(%eax)
    4e82:	0f b6 00             	movzbl (%eax),%eax
    4e85:	84 c0                	test   %al,%al
    4e87:	75 e2                	jne    4e6b <strcpy+0x11>
    ;
  return os;
    4e89:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    4e8c:	c9                   	leave  
    4e8d:	c3                   	ret    

00004e8e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4e8e:	f3 0f 1e fb          	endbr32 
    4e92:	55                   	push   %ebp
    4e93:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    4e95:	eb 08                	jmp    4e9f <strcmp+0x11>
    p++, q++;
    4e97:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    4e9b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    4e9f:	8b 45 08             	mov    0x8(%ebp),%eax
    4ea2:	0f b6 00             	movzbl (%eax),%eax
    4ea5:	84 c0                	test   %al,%al
    4ea7:	74 10                	je     4eb9 <strcmp+0x2b>
    4ea9:	8b 45 08             	mov    0x8(%ebp),%eax
    4eac:	0f b6 10             	movzbl (%eax),%edx
    4eaf:	8b 45 0c             	mov    0xc(%ebp),%eax
    4eb2:	0f b6 00             	movzbl (%eax),%eax
    4eb5:	38 c2                	cmp    %al,%dl
    4eb7:	74 de                	je     4e97 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    4eb9:	8b 45 08             	mov    0x8(%ebp),%eax
    4ebc:	0f b6 00             	movzbl (%eax),%eax
    4ebf:	0f b6 d0             	movzbl %al,%edx
    4ec2:	8b 45 0c             	mov    0xc(%ebp),%eax
    4ec5:	0f b6 00             	movzbl (%eax),%eax
    4ec8:	0f b6 c0             	movzbl %al,%eax
    4ecb:	29 c2                	sub    %eax,%edx
    4ecd:	89 d0                	mov    %edx,%eax
}
    4ecf:	5d                   	pop    %ebp
    4ed0:	c3                   	ret    

00004ed1 <strlen>:

uint
strlen(const char *s)
{
    4ed1:	f3 0f 1e fb          	endbr32 
    4ed5:	55                   	push   %ebp
    4ed6:	89 e5                	mov    %esp,%ebp
    4ed8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    4edb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    4ee2:	eb 04                	jmp    4ee8 <strlen+0x17>
    4ee4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    4ee8:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4eeb:	8b 45 08             	mov    0x8(%ebp),%eax
    4eee:	01 d0                	add    %edx,%eax
    4ef0:	0f b6 00             	movzbl (%eax),%eax
    4ef3:	84 c0                	test   %al,%al
    4ef5:	75 ed                	jne    4ee4 <strlen+0x13>
    ;
  return n;
    4ef7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    4efa:	c9                   	leave  
    4efb:	c3                   	ret    

00004efc <memset>:

void*
memset(void *dst, int c, uint n)
{
    4efc:	f3 0f 1e fb          	endbr32 
    4f00:	55                   	push   %ebp
    4f01:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    4f03:	8b 45 10             	mov    0x10(%ebp),%eax
    4f06:	50                   	push   %eax
    4f07:	ff 75 0c             	pushl  0xc(%ebp)
    4f0a:	ff 75 08             	pushl  0x8(%ebp)
    4f0d:	e8 22 ff ff ff       	call   4e34 <stosb>
    4f12:	83 c4 0c             	add    $0xc,%esp
  return dst;
    4f15:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4f18:	c9                   	leave  
    4f19:	c3                   	ret    

00004f1a <strchr>:

char*
strchr(const char *s, char c)
{
    4f1a:	f3 0f 1e fb          	endbr32 
    4f1e:	55                   	push   %ebp
    4f1f:	89 e5                	mov    %esp,%ebp
    4f21:	83 ec 04             	sub    $0x4,%esp
    4f24:	8b 45 0c             	mov    0xc(%ebp),%eax
    4f27:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    4f2a:	eb 14                	jmp    4f40 <strchr+0x26>
    if(*s == c)
    4f2c:	8b 45 08             	mov    0x8(%ebp),%eax
    4f2f:	0f b6 00             	movzbl (%eax),%eax
    4f32:	38 45 fc             	cmp    %al,-0x4(%ebp)
    4f35:	75 05                	jne    4f3c <strchr+0x22>
      return (char*)s;
    4f37:	8b 45 08             	mov    0x8(%ebp),%eax
    4f3a:	eb 13                	jmp    4f4f <strchr+0x35>
  for(; *s; s++)
    4f3c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    4f40:	8b 45 08             	mov    0x8(%ebp),%eax
    4f43:	0f b6 00             	movzbl (%eax),%eax
    4f46:	84 c0                	test   %al,%al
    4f48:	75 e2                	jne    4f2c <strchr+0x12>
  return 0;
    4f4a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    4f4f:	c9                   	leave  
    4f50:	c3                   	ret    

00004f51 <gets>:

char*
gets(char *buf, int max)
{
    4f51:	f3 0f 1e fb          	endbr32 
    4f55:	55                   	push   %ebp
    4f56:	89 e5                	mov    %esp,%ebp
    4f58:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4f5b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    4f62:	eb 42                	jmp    4fa6 <gets+0x55>
    cc = read(0, &c, 1);
    4f64:	83 ec 04             	sub    $0x4,%esp
    4f67:	6a 01                	push   $0x1
    4f69:	8d 45 ef             	lea    -0x11(%ebp),%eax
    4f6c:	50                   	push   %eax
    4f6d:	6a 00                	push   $0x0
    4f6f:	e8 53 01 00 00       	call   50c7 <read>
    4f74:	83 c4 10             	add    $0x10,%esp
    4f77:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    4f7a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4f7e:	7e 33                	jle    4fb3 <gets+0x62>
      break;
    buf[i++] = c;
    4f80:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f83:	8d 50 01             	lea    0x1(%eax),%edx
    4f86:	89 55 f4             	mov    %edx,-0xc(%ebp)
    4f89:	89 c2                	mov    %eax,%edx
    4f8b:	8b 45 08             	mov    0x8(%ebp),%eax
    4f8e:	01 c2                	add    %eax,%edx
    4f90:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    4f94:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    4f96:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    4f9a:	3c 0a                	cmp    $0xa,%al
    4f9c:	74 16                	je     4fb4 <gets+0x63>
    4f9e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    4fa2:	3c 0d                	cmp    $0xd,%al
    4fa4:	74 0e                	je     4fb4 <gets+0x63>
  for(i=0; i+1 < max; ){
    4fa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4fa9:	83 c0 01             	add    $0x1,%eax
    4fac:	39 45 0c             	cmp    %eax,0xc(%ebp)
    4faf:	7f b3                	jg     4f64 <gets+0x13>
    4fb1:	eb 01                	jmp    4fb4 <gets+0x63>
      break;
    4fb3:	90                   	nop
      break;
  }
  buf[i] = '\0';
    4fb4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    4fb7:	8b 45 08             	mov    0x8(%ebp),%eax
    4fba:	01 d0                	add    %edx,%eax
    4fbc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    4fbf:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4fc2:	c9                   	leave  
    4fc3:	c3                   	ret    

00004fc4 <stat>:

int
stat(const char *n, struct stat *st)
{
    4fc4:	f3 0f 1e fb          	endbr32 
    4fc8:	55                   	push   %ebp
    4fc9:	89 e5                	mov    %esp,%ebp
    4fcb:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4fce:	83 ec 08             	sub    $0x8,%esp
    4fd1:	6a 00                	push   $0x0
    4fd3:	ff 75 08             	pushl  0x8(%ebp)
    4fd6:	e8 14 01 00 00       	call   50ef <open>
    4fdb:	83 c4 10             	add    $0x10,%esp
    4fde:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    4fe1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4fe5:	79 07                	jns    4fee <stat+0x2a>
    return -1;
    4fe7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    4fec:	eb 25                	jmp    5013 <stat+0x4f>
  r = fstat(fd, st);
    4fee:	83 ec 08             	sub    $0x8,%esp
    4ff1:	ff 75 0c             	pushl  0xc(%ebp)
    4ff4:	ff 75 f4             	pushl  -0xc(%ebp)
    4ff7:	e8 0b 01 00 00       	call   5107 <fstat>
    4ffc:	83 c4 10             	add    $0x10,%esp
    4fff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    5002:	83 ec 0c             	sub    $0xc,%esp
    5005:	ff 75 f4             	pushl  -0xc(%ebp)
    5008:	e8 ca 00 00 00       	call   50d7 <close>
    500d:	83 c4 10             	add    $0x10,%esp
  return r;
    5010:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    5013:	c9                   	leave  
    5014:	c3                   	ret    

00005015 <atoi>:

int
atoi(const char *s)
{
    5015:	f3 0f 1e fb          	endbr32 
    5019:	55                   	push   %ebp
    501a:	89 e5                	mov    %esp,%ebp
    501c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    501f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    5026:	eb 25                	jmp    504d <atoi+0x38>
    n = n*10 + *s++ - '0';
    5028:	8b 55 fc             	mov    -0x4(%ebp),%edx
    502b:	89 d0                	mov    %edx,%eax
    502d:	c1 e0 02             	shl    $0x2,%eax
    5030:	01 d0                	add    %edx,%eax
    5032:	01 c0                	add    %eax,%eax
    5034:	89 c1                	mov    %eax,%ecx
    5036:	8b 45 08             	mov    0x8(%ebp),%eax
    5039:	8d 50 01             	lea    0x1(%eax),%edx
    503c:	89 55 08             	mov    %edx,0x8(%ebp)
    503f:	0f b6 00             	movzbl (%eax),%eax
    5042:	0f be c0             	movsbl %al,%eax
    5045:	01 c8                	add    %ecx,%eax
    5047:	83 e8 30             	sub    $0x30,%eax
    504a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    504d:	8b 45 08             	mov    0x8(%ebp),%eax
    5050:	0f b6 00             	movzbl (%eax),%eax
    5053:	3c 2f                	cmp    $0x2f,%al
    5055:	7e 0a                	jle    5061 <atoi+0x4c>
    5057:	8b 45 08             	mov    0x8(%ebp),%eax
    505a:	0f b6 00             	movzbl (%eax),%eax
    505d:	3c 39                	cmp    $0x39,%al
    505f:	7e c7                	jle    5028 <atoi+0x13>
  return n;
    5061:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    5064:	c9                   	leave  
    5065:	c3                   	ret    

00005066 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5066:	f3 0f 1e fb          	endbr32 
    506a:	55                   	push   %ebp
    506b:	89 e5                	mov    %esp,%ebp
    506d:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    5070:	8b 45 08             	mov    0x8(%ebp),%eax
    5073:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    5076:	8b 45 0c             	mov    0xc(%ebp),%eax
    5079:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    507c:	eb 17                	jmp    5095 <memmove+0x2f>
    *dst++ = *src++;
    507e:	8b 55 f8             	mov    -0x8(%ebp),%edx
    5081:	8d 42 01             	lea    0x1(%edx),%eax
    5084:	89 45 f8             	mov    %eax,-0x8(%ebp)
    5087:	8b 45 fc             	mov    -0x4(%ebp),%eax
    508a:	8d 48 01             	lea    0x1(%eax),%ecx
    508d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    5090:	0f b6 12             	movzbl (%edx),%edx
    5093:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    5095:	8b 45 10             	mov    0x10(%ebp),%eax
    5098:	8d 50 ff             	lea    -0x1(%eax),%edx
    509b:	89 55 10             	mov    %edx,0x10(%ebp)
    509e:	85 c0                	test   %eax,%eax
    50a0:	7f dc                	jg     507e <memmove+0x18>
  return vdst;
    50a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
    50a5:	c9                   	leave  
    50a6:	c3                   	ret    

000050a7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    50a7:	b8 01 00 00 00       	mov    $0x1,%eax
    50ac:	cd 40                	int    $0x40
    50ae:	c3                   	ret    

000050af <exit>:
SYSCALL(exit)
    50af:	b8 02 00 00 00       	mov    $0x2,%eax
    50b4:	cd 40                	int    $0x40
    50b6:	c3                   	ret    

000050b7 <wait>:
SYSCALL(wait)
    50b7:	b8 03 00 00 00       	mov    $0x3,%eax
    50bc:	cd 40                	int    $0x40
    50be:	c3                   	ret    

000050bf <pipe>:
SYSCALL(pipe)
    50bf:	b8 04 00 00 00       	mov    $0x4,%eax
    50c4:	cd 40                	int    $0x40
    50c6:	c3                   	ret    

000050c7 <read>:
SYSCALL(read)
    50c7:	b8 05 00 00 00       	mov    $0x5,%eax
    50cc:	cd 40                	int    $0x40
    50ce:	c3                   	ret    

000050cf <write>:
SYSCALL(write)
    50cf:	b8 10 00 00 00       	mov    $0x10,%eax
    50d4:	cd 40                	int    $0x40
    50d6:	c3                   	ret    

000050d7 <close>:
SYSCALL(close)
    50d7:	b8 15 00 00 00       	mov    $0x15,%eax
    50dc:	cd 40                	int    $0x40
    50de:	c3                   	ret    

000050df <kill>:
SYSCALL(kill)
    50df:	b8 06 00 00 00       	mov    $0x6,%eax
    50e4:	cd 40                	int    $0x40
    50e6:	c3                   	ret    

000050e7 <exec>:
SYSCALL(exec)
    50e7:	b8 07 00 00 00       	mov    $0x7,%eax
    50ec:	cd 40                	int    $0x40
    50ee:	c3                   	ret    

000050ef <open>:
SYSCALL(open)
    50ef:	b8 0f 00 00 00       	mov    $0xf,%eax
    50f4:	cd 40                	int    $0x40
    50f6:	c3                   	ret    

000050f7 <mknod>:
SYSCALL(mknod)
    50f7:	b8 11 00 00 00       	mov    $0x11,%eax
    50fc:	cd 40                	int    $0x40
    50fe:	c3                   	ret    

000050ff <unlink>:
SYSCALL(unlink)
    50ff:	b8 12 00 00 00       	mov    $0x12,%eax
    5104:	cd 40                	int    $0x40
    5106:	c3                   	ret    

00005107 <fstat>:
SYSCALL(fstat)
    5107:	b8 08 00 00 00       	mov    $0x8,%eax
    510c:	cd 40                	int    $0x40
    510e:	c3                   	ret    

0000510f <link>:
SYSCALL(link)
    510f:	b8 13 00 00 00       	mov    $0x13,%eax
    5114:	cd 40                	int    $0x40
    5116:	c3                   	ret    

00005117 <mkdir>:
SYSCALL(mkdir)
    5117:	b8 14 00 00 00       	mov    $0x14,%eax
    511c:	cd 40                	int    $0x40
    511e:	c3                   	ret    

0000511f <chdir>:
SYSCALL(chdir)
    511f:	b8 09 00 00 00       	mov    $0x9,%eax
    5124:	cd 40                	int    $0x40
    5126:	c3                   	ret    

00005127 <dup>:
SYSCALL(dup)
    5127:	b8 0a 00 00 00       	mov    $0xa,%eax
    512c:	cd 40                	int    $0x40
    512e:	c3                   	ret    

0000512f <getpid>:
SYSCALL(getpid)
    512f:	b8 0b 00 00 00       	mov    $0xb,%eax
    5134:	cd 40                	int    $0x40
    5136:	c3                   	ret    

00005137 <sbrk>:
SYSCALL(sbrk)
    5137:	b8 0c 00 00 00       	mov    $0xc,%eax
    513c:	cd 40                	int    $0x40
    513e:	c3                   	ret    

0000513f <sleep>:
SYSCALL(sleep)
    513f:	b8 0d 00 00 00       	mov    $0xd,%eax
    5144:	cd 40                	int    $0x40
    5146:	c3                   	ret    

00005147 <uptime>:
SYSCALL(uptime)
    5147:	b8 0e 00 00 00       	mov    $0xe,%eax
    514c:	cd 40                	int    $0x40
    514e:	c3                   	ret    

0000514f <settickets>:
SYSCALL(settickets)
    514f:	b8 16 00 00 00       	mov    $0x16,%eax
    5154:	cd 40                	int    $0x40
    5156:	c3                   	ret    

00005157 <getpinfo>:
SYSCALL(getpinfo)
    5157:	b8 17 00 00 00       	mov    $0x17,%eax
    515c:	cd 40                	int    $0x40
    515e:	c3                   	ret    

0000515f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    515f:	f3 0f 1e fb          	endbr32 
    5163:	55                   	push   %ebp
    5164:	89 e5                	mov    %esp,%ebp
    5166:	83 ec 18             	sub    $0x18,%esp
    5169:	8b 45 0c             	mov    0xc(%ebp),%eax
    516c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    516f:	83 ec 04             	sub    $0x4,%esp
    5172:	6a 01                	push   $0x1
    5174:	8d 45 f4             	lea    -0xc(%ebp),%eax
    5177:	50                   	push   %eax
    5178:	ff 75 08             	pushl  0x8(%ebp)
    517b:	e8 4f ff ff ff       	call   50cf <write>
    5180:	83 c4 10             	add    $0x10,%esp
}
    5183:	90                   	nop
    5184:	c9                   	leave  
    5185:	c3                   	ret    

00005186 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5186:	f3 0f 1e fb          	endbr32 
    518a:	55                   	push   %ebp
    518b:	89 e5                	mov    %esp,%ebp
    518d:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    5190:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    5197:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    519b:	74 17                	je     51b4 <printint+0x2e>
    519d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    51a1:	79 11                	jns    51b4 <printint+0x2e>
    neg = 1;
    51a3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    51aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    51ad:	f7 d8                	neg    %eax
    51af:	89 45 ec             	mov    %eax,-0x14(%ebp)
    51b2:	eb 06                	jmp    51ba <printint+0x34>
  } else {
    x = xx;
    51b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    51b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    51ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    51c1:	8b 4d 10             	mov    0x10(%ebp),%ecx
    51c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    51c7:	ba 00 00 00 00       	mov    $0x0,%edx
    51cc:	f7 f1                	div    %ecx
    51ce:	89 d1                	mov    %edx,%ecx
    51d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    51d3:	8d 50 01             	lea    0x1(%eax),%edx
    51d6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    51d9:	0f b6 91 60 75 00 00 	movzbl 0x7560(%ecx),%edx
    51e0:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    51e4:	8b 4d 10             	mov    0x10(%ebp),%ecx
    51e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    51ea:	ba 00 00 00 00       	mov    $0x0,%edx
    51ef:	f7 f1                	div    %ecx
    51f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    51f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    51f8:	75 c7                	jne    51c1 <printint+0x3b>
  if(neg)
    51fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    51fe:	74 2d                	je     522d <printint+0xa7>
    buf[i++] = '-';
    5200:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5203:	8d 50 01             	lea    0x1(%eax),%edx
    5206:	89 55 f4             	mov    %edx,-0xc(%ebp)
    5209:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    520e:	eb 1d                	jmp    522d <printint+0xa7>
    putc(fd, buf[i]);
    5210:	8d 55 dc             	lea    -0x24(%ebp),%edx
    5213:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5216:	01 d0                	add    %edx,%eax
    5218:	0f b6 00             	movzbl (%eax),%eax
    521b:	0f be c0             	movsbl %al,%eax
    521e:	83 ec 08             	sub    $0x8,%esp
    5221:	50                   	push   %eax
    5222:	ff 75 08             	pushl  0x8(%ebp)
    5225:	e8 35 ff ff ff       	call   515f <putc>
    522a:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    522d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    5231:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    5235:	79 d9                	jns    5210 <printint+0x8a>
}
    5237:	90                   	nop
    5238:	90                   	nop
    5239:	c9                   	leave  
    523a:	c3                   	ret    

0000523b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    523b:	f3 0f 1e fb          	endbr32 
    523f:	55                   	push   %ebp
    5240:	89 e5                	mov    %esp,%ebp
    5242:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    5245:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    524c:	8d 45 0c             	lea    0xc(%ebp),%eax
    524f:	83 c0 04             	add    $0x4,%eax
    5252:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    5255:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    525c:	e9 59 01 00 00       	jmp    53ba <printf+0x17f>
    c = fmt[i] & 0xff;
    5261:	8b 55 0c             	mov    0xc(%ebp),%edx
    5264:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5267:	01 d0                	add    %edx,%eax
    5269:	0f b6 00             	movzbl (%eax),%eax
    526c:	0f be c0             	movsbl %al,%eax
    526f:	25 ff 00 00 00       	and    $0xff,%eax
    5274:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    5277:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    527b:	75 2c                	jne    52a9 <printf+0x6e>
      if(c == '%'){
    527d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    5281:	75 0c                	jne    528f <printf+0x54>
        state = '%';
    5283:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    528a:	e9 27 01 00 00       	jmp    53b6 <printf+0x17b>
      } else {
        putc(fd, c);
    528f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5292:	0f be c0             	movsbl %al,%eax
    5295:	83 ec 08             	sub    $0x8,%esp
    5298:	50                   	push   %eax
    5299:	ff 75 08             	pushl  0x8(%ebp)
    529c:	e8 be fe ff ff       	call   515f <putc>
    52a1:	83 c4 10             	add    $0x10,%esp
    52a4:	e9 0d 01 00 00       	jmp    53b6 <printf+0x17b>
      }
    } else if(state == '%'){
    52a9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    52ad:	0f 85 03 01 00 00    	jne    53b6 <printf+0x17b>
      if(c == 'd'){
    52b3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    52b7:	75 1e                	jne    52d7 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    52b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    52bc:	8b 00                	mov    (%eax),%eax
    52be:	6a 01                	push   $0x1
    52c0:	6a 0a                	push   $0xa
    52c2:	50                   	push   %eax
    52c3:	ff 75 08             	pushl  0x8(%ebp)
    52c6:	e8 bb fe ff ff       	call   5186 <printint>
    52cb:	83 c4 10             	add    $0x10,%esp
        ap++;
    52ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    52d2:	e9 d8 00 00 00       	jmp    53af <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    52d7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    52db:	74 06                	je     52e3 <printf+0xa8>
    52dd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    52e1:	75 1e                	jne    5301 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    52e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    52e6:	8b 00                	mov    (%eax),%eax
    52e8:	6a 00                	push   $0x0
    52ea:	6a 10                	push   $0x10
    52ec:	50                   	push   %eax
    52ed:	ff 75 08             	pushl  0x8(%ebp)
    52f0:	e8 91 fe ff ff       	call   5186 <printint>
    52f5:	83 c4 10             	add    $0x10,%esp
        ap++;
    52f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    52fc:	e9 ae 00 00 00       	jmp    53af <printf+0x174>
      } else if(c == 's'){
    5301:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    5305:	75 43                	jne    534a <printf+0x10f>
        s = (char*)*ap;
    5307:	8b 45 e8             	mov    -0x18(%ebp),%eax
    530a:	8b 00                	mov    (%eax),%eax
    530c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    530f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    5313:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    5317:	75 25                	jne    533e <printf+0x103>
          s = "(null)";
    5319:	c7 45 f4 2e 6e 00 00 	movl   $0x6e2e,-0xc(%ebp)
        while(*s != 0){
    5320:	eb 1c                	jmp    533e <printf+0x103>
          putc(fd, *s);
    5322:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5325:	0f b6 00             	movzbl (%eax),%eax
    5328:	0f be c0             	movsbl %al,%eax
    532b:	83 ec 08             	sub    $0x8,%esp
    532e:	50                   	push   %eax
    532f:	ff 75 08             	pushl  0x8(%ebp)
    5332:	e8 28 fe ff ff       	call   515f <putc>
    5337:	83 c4 10             	add    $0x10,%esp
          s++;
    533a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    533e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5341:	0f b6 00             	movzbl (%eax),%eax
    5344:	84 c0                	test   %al,%al
    5346:	75 da                	jne    5322 <printf+0xe7>
    5348:	eb 65                	jmp    53af <printf+0x174>
        }
      } else if(c == 'c'){
    534a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    534e:	75 1d                	jne    536d <printf+0x132>
        putc(fd, *ap);
    5350:	8b 45 e8             	mov    -0x18(%ebp),%eax
    5353:	8b 00                	mov    (%eax),%eax
    5355:	0f be c0             	movsbl %al,%eax
    5358:	83 ec 08             	sub    $0x8,%esp
    535b:	50                   	push   %eax
    535c:	ff 75 08             	pushl  0x8(%ebp)
    535f:	e8 fb fd ff ff       	call   515f <putc>
    5364:	83 c4 10             	add    $0x10,%esp
        ap++;
    5367:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    536b:	eb 42                	jmp    53af <printf+0x174>
      } else if(c == '%'){
    536d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    5371:	75 17                	jne    538a <printf+0x14f>
        putc(fd, c);
    5373:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5376:	0f be c0             	movsbl %al,%eax
    5379:	83 ec 08             	sub    $0x8,%esp
    537c:	50                   	push   %eax
    537d:	ff 75 08             	pushl  0x8(%ebp)
    5380:	e8 da fd ff ff       	call   515f <putc>
    5385:	83 c4 10             	add    $0x10,%esp
    5388:	eb 25                	jmp    53af <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    538a:	83 ec 08             	sub    $0x8,%esp
    538d:	6a 25                	push   $0x25
    538f:	ff 75 08             	pushl  0x8(%ebp)
    5392:	e8 c8 fd ff ff       	call   515f <putc>
    5397:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    539a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    539d:	0f be c0             	movsbl %al,%eax
    53a0:	83 ec 08             	sub    $0x8,%esp
    53a3:	50                   	push   %eax
    53a4:	ff 75 08             	pushl  0x8(%ebp)
    53a7:	e8 b3 fd ff ff       	call   515f <putc>
    53ac:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    53af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    53b6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    53ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    53bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    53c0:	01 d0                	add    %edx,%eax
    53c2:	0f b6 00             	movzbl (%eax),%eax
    53c5:	84 c0                	test   %al,%al
    53c7:	0f 85 94 fe ff ff    	jne    5261 <printf+0x26>
    }
  }
}
    53cd:	90                   	nop
    53ce:	90                   	nop
    53cf:	c9                   	leave  
    53d0:	c3                   	ret    

000053d1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    53d1:	f3 0f 1e fb          	endbr32 
    53d5:	55                   	push   %ebp
    53d6:	89 e5                	mov    %esp,%ebp
    53d8:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    53db:	8b 45 08             	mov    0x8(%ebp),%eax
    53de:	83 e8 08             	sub    $0x8,%eax
    53e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    53e4:	a1 08 76 00 00       	mov    0x7608,%eax
    53e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    53ec:	eb 24                	jmp    5412 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    53ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
    53f1:	8b 00                	mov    (%eax),%eax
    53f3:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    53f6:	72 12                	jb     540a <free+0x39>
    53f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    53fb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    53fe:	77 24                	ja     5424 <free+0x53>
    5400:	8b 45 fc             	mov    -0x4(%ebp),%eax
    5403:	8b 00                	mov    (%eax),%eax
    5405:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    5408:	72 1a                	jb     5424 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    540a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    540d:	8b 00                	mov    (%eax),%eax
    540f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    5412:	8b 45 f8             	mov    -0x8(%ebp),%eax
    5415:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    5418:	76 d4                	jbe    53ee <free+0x1d>
    541a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    541d:	8b 00                	mov    (%eax),%eax
    541f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    5422:	73 ca                	jae    53ee <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    5424:	8b 45 f8             	mov    -0x8(%ebp),%eax
    5427:	8b 40 04             	mov    0x4(%eax),%eax
    542a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    5431:	8b 45 f8             	mov    -0x8(%ebp),%eax
    5434:	01 c2                	add    %eax,%edx
    5436:	8b 45 fc             	mov    -0x4(%ebp),%eax
    5439:	8b 00                	mov    (%eax),%eax
    543b:	39 c2                	cmp    %eax,%edx
    543d:	75 24                	jne    5463 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    543f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    5442:	8b 50 04             	mov    0x4(%eax),%edx
    5445:	8b 45 fc             	mov    -0x4(%ebp),%eax
    5448:	8b 00                	mov    (%eax),%eax
    544a:	8b 40 04             	mov    0x4(%eax),%eax
    544d:	01 c2                	add    %eax,%edx
    544f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    5452:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    5455:	8b 45 fc             	mov    -0x4(%ebp),%eax
    5458:	8b 00                	mov    (%eax),%eax
    545a:	8b 10                	mov    (%eax),%edx
    545c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    545f:	89 10                	mov    %edx,(%eax)
    5461:	eb 0a                	jmp    546d <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    5463:	8b 45 fc             	mov    -0x4(%ebp),%eax
    5466:	8b 10                	mov    (%eax),%edx
    5468:	8b 45 f8             	mov    -0x8(%ebp),%eax
    546b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    546d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    5470:	8b 40 04             	mov    0x4(%eax),%eax
    5473:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    547a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    547d:	01 d0                	add    %edx,%eax
    547f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    5482:	75 20                	jne    54a4 <free+0xd3>
    p->s.size += bp->s.size;
    5484:	8b 45 fc             	mov    -0x4(%ebp),%eax
    5487:	8b 50 04             	mov    0x4(%eax),%edx
    548a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    548d:	8b 40 04             	mov    0x4(%eax),%eax
    5490:	01 c2                	add    %eax,%edx
    5492:	8b 45 fc             	mov    -0x4(%ebp),%eax
    5495:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    5498:	8b 45 f8             	mov    -0x8(%ebp),%eax
    549b:	8b 10                	mov    (%eax),%edx
    549d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    54a0:	89 10                	mov    %edx,(%eax)
    54a2:	eb 08                	jmp    54ac <free+0xdb>
  } else
    p->s.ptr = bp;
    54a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    54a7:	8b 55 f8             	mov    -0x8(%ebp),%edx
    54aa:	89 10                	mov    %edx,(%eax)
  freep = p;
    54ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    54af:	a3 08 76 00 00       	mov    %eax,0x7608
}
    54b4:	90                   	nop
    54b5:	c9                   	leave  
    54b6:	c3                   	ret    

000054b7 <morecore>:

static Header*
morecore(uint nu)
{
    54b7:	f3 0f 1e fb          	endbr32 
    54bb:	55                   	push   %ebp
    54bc:	89 e5                	mov    %esp,%ebp
    54be:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    54c1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    54c8:	77 07                	ja     54d1 <morecore+0x1a>
    nu = 4096;
    54ca:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    54d1:	8b 45 08             	mov    0x8(%ebp),%eax
    54d4:	c1 e0 03             	shl    $0x3,%eax
    54d7:	83 ec 0c             	sub    $0xc,%esp
    54da:	50                   	push   %eax
    54db:	e8 57 fc ff ff       	call   5137 <sbrk>
    54e0:	83 c4 10             	add    $0x10,%esp
    54e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    54e6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    54ea:	75 07                	jne    54f3 <morecore+0x3c>
    return 0;
    54ec:	b8 00 00 00 00       	mov    $0x0,%eax
    54f1:	eb 26                	jmp    5519 <morecore+0x62>
  hp = (Header*)p;
    54f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    54f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    54f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    54fc:	8b 55 08             	mov    0x8(%ebp),%edx
    54ff:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    5502:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5505:	83 c0 08             	add    $0x8,%eax
    5508:	83 ec 0c             	sub    $0xc,%esp
    550b:	50                   	push   %eax
    550c:	e8 c0 fe ff ff       	call   53d1 <free>
    5511:	83 c4 10             	add    $0x10,%esp
  return freep;
    5514:	a1 08 76 00 00       	mov    0x7608,%eax
}
    5519:	c9                   	leave  
    551a:	c3                   	ret    

0000551b <malloc>:

void*
malloc(uint nbytes)
{
    551b:	f3 0f 1e fb          	endbr32 
    551f:	55                   	push   %ebp
    5520:	89 e5                	mov    %esp,%ebp
    5522:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5525:	8b 45 08             	mov    0x8(%ebp),%eax
    5528:	83 c0 07             	add    $0x7,%eax
    552b:	c1 e8 03             	shr    $0x3,%eax
    552e:	83 c0 01             	add    $0x1,%eax
    5531:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    5534:	a1 08 76 00 00       	mov    0x7608,%eax
    5539:	89 45 f0             	mov    %eax,-0x10(%ebp)
    553c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    5540:	75 23                	jne    5565 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    5542:	c7 45 f0 00 76 00 00 	movl   $0x7600,-0x10(%ebp)
    5549:	8b 45 f0             	mov    -0x10(%ebp),%eax
    554c:	a3 08 76 00 00       	mov    %eax,0x7608
    5551:	a1 08 76 00 00       	mov    0x7608,%eax
    5556:	a3 00 76 00 00       	mov    %eax,0x7600
    base.s.size = 0;
    555b:	c7 05 04 76 00 00 00 	movl   $0x0,0x7604
    5562:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5565:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5568:	8b 00                	mov    (%eax),%eax
    556a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    556d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5570:	8b 40 04             	mov    0x4(%eax),%eax
    5573:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    5576:	77 4d                	ja     55c5 <malloc+0xaa>
      if(p->s.size == nunits)
    5578:	8b 45 f4             	mov    -0xc(%ebp),%eax
    557b:	8b 40 04             	mov    0x4(%eax),%eax
    557e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    5581:	75 0c                	jne    558f <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    5583:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5586:	8b 10                	mov    (%eax),%edx
    5588:	8b 45 f0             	mov    -0x10(%ebp),%eax
    558b:	89 10                	mov    %edx,(%eax)
    558d:	eb 26                	jmp    55b5 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    558f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5592:	8b 40 04             	mov    0x4(%eax),%eax
    5595:	2b 45 ec             	sub    -0x14(%ebp),%eax
    5598:	89 c2                	mov    %eax,%edx
    559a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    559d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    55a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    55a3:	8b 40 04             	mov    0x4(%eax),%eax
    55a6:	c1 e0 03             	shl    $0x3,%eax
    55a9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    55ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    55af:	8b 55 ec             	mov    -0x14(%ebp),%edx
    55b2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    55b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    55b8:	a3 08 76 00 00       	mov    %eax,0x7608
      return (void*)(p + 1);
    55bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    55c0:	83 c0 08             	add    $0x8,%eax
    55c3:	eb 3b                	jmp    5600 <malloc+0xe5>
    }
    if(p == freep)
    55c5:	a1 08 76 00 00       	mov    0x7608,%eax
    55ca:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    55cd:	75 1e                	jne    55ed <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    55cf:	83 ec 0c             	sub    $0xc,%esp
    55d2:	ff 75 ec             	pushl  -0x14(%ebp)
    55d5:	e8 dd fe ff ff       	call   54b7 <morecore>
    55da:	83 c4 10             	add    $0x10,%esp
    55dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    55e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    55e4:	75 07                	jne    55ed <malloc+0xd2>
        return 0;
    55e6:	b8 00 00 00 00       	mov    $0x0,%eax
    55eb:	eb 13                	jmp    5600 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    55ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    55f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    55f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    55f6:	8b 00                	mov    (%eax),%eax
    55f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    55fb:	e9 6d ff ff ff       	jmp    556d <malloc+0x52>
  }
}
    5600:	c9                   	leave  
    5601:	c3                   	ret    
