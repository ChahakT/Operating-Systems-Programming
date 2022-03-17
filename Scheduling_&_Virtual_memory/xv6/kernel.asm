
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 30 c6 10 80       	mov    $0x8010c630,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 b5 39 10 80       	mov    $0x801039b5,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	f3 0f 1e fb          	endbr32 
80100038:	55                   	push   %ebp
80100039:	89 e5                	mov    %esp,%ebp
8010003b:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003e:	83 ec 08             	sub    $0x8,%esp
80100041:	68 08 88 10 80       	push   $0x80108808
80100046:	68 40 c6 10 80       	push   $0x8010c640
8010004b:	e8 48 52 00 00       	call   80105298 <initlock>
80100050:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100053:	c7 05 8c 0d 11 80 3c 	movl   $0x80110d3c,0x80110d8c
8010005a:	0d 11 80 
  bcache.head.next = &bcache.head;
8010005d:	c7 05 90 0d 11 80 3c 	movl   $0x80110d3c,0x80110d90
80100064:	0d 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100067:	c7 45 f4 74 c6 10 80 	movl   $0x8010c674,-0xc(%ebp)
8010006e:	eb 47                	jmp    801000b7 <binit+0x83>
    b->next = bcache.head.next;
80100070:	8b 15 90 0d 11 80    	mov    0x80110d90,%edx
80100076:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100079:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
8010007c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007f:	c7 40 50 3c 0d 11 80 	movl   $0x80110d3c,0x50(%eax)
    initsleeplock(&b->lock, "buffer");
80100086:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100089:	83 c0 0c             	add    $0xc,%eax
8010008c:	83 ec 08             	sub    $0x8,%esp
8010008f:	68 0f 88 10 80       	push   $0x8010880f
80100094:	50                   	push   %eax
80100095:	e8 6b 50 00 00       	call   80105105 <initsleeplock>
8010009a:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
8010009d:	a1 90 0d 11 80       	mov    0x80110d90,%eax
801000a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801000a5:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801000a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ab:	a3 90 0d 11 80       	mov    %eax,0x80110d90
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b0:	81 45 f4 5c 02 00 00 	addl   $0x25c,-0xc(%ebp)
801000b7:	b8 3c 0d 11 80       	mov    $0x80110d3c,%eax
801000bc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000bf:	72 af                	jb     80100070 <binit+0x3c>
  }
}
801000c1:	90                   	nop
801000c2:	90                   	nop
801000c3:	c9                   	leave  
801000c4:	c3                   	ret    

801000c5 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000c5:	f3 0f 1e fb          	endbr32 
801000c9:	55                   	push   %ebp
801000ca:	89 e5                	mov    %esp,%ebp
801000cc:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000cf:	83 ec 0c             	sub    $0xc,%esp
801000d2:	68 40 c6 10 80       	push   $0x8010c640
801000d7:	e8 e2 51 00 00       	call   801052be <acquire>
801000dc:	83 c4 10             	add    $0x10,%esp

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000df:	a1 90 0d 11 80       	mov    0x80110d90,%eax
801000e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000e7:	eb 58                	jmp    80100141 <bget+0x7c>
    if(b->dev == dev && b->blockno == blockno){
801000e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ec:	8b 40 04             	mov    0x4(%eax),%eax
801000ef:	39 45 08             	cmp    %eax,0x8(%ebp)
801000f2:	75 44                	jne    80100138 <bget+0x73>
801000f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f7:	8b 40 08             	mov    0x8(%eax),%eax
801000fa:	39 45 0c             	cmp    %eax,0xc(%ebp)
801000fd:	75 39                	jne    80100138 <bget+0x73>
      b->refcnt++;
801000ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100102:	8b 40 4c             	mov    0x4c(%eax),%eax
80100105:	8d 50 01             	lea    0x1(%eax),%edx
80100108:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010b:	89 50 4c             	mov    %edx,0x4c(%eax)
      release(&bcache.lock);
8010010e:	83 ec 0c             	sub    $0xc,%esp
80100111:	68 40 c6 10 80       	push   $0x8010c640
80100116:	e8 15 52 00 00       	call   80105330 <release>
8010011b:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
8010011e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100121:	83 c0 0c             	add    $0xc,%eax
80100124:	83 ec 0c             	sub    $0xc,%esp
80100127:	50                   	push   %eax
80100128:	e8 18 50 00 00       	call   80105145 <acquiresleep>
8010012d:	83 c4 10             	add    $0x10,%esp
      return b;
80100130:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100133:	e9 9d 00 00 00       	jmp    801001d5 <bget+0x110>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100138:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010013b:	8b 40 54             	mov    0x54(%eax),%eax
8010013e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100141:	81 7d f4 3c 0d 11 80 	cmpl   $0x80110d3c,-0xc(%ebp)
80100148:	75 9f                	jne    801000e9 <bget+0x24>
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
8010014a:	a1 8c 0d 11 80       	mov    0x80110d8c,%eax
8010014f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100152:	eb 6b                	jmp    801001bf <bget+0xfa>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
80100154:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100157:	8b 40 4c             	mov    0x4c(%eax),%eax
8010015a:	85 c0                	test   %eax,%eax
8010015c:	75 58                	jne    801001b6 <bget+0xf1>
8010015e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100161:	8b 00                	mov    (%eax),%eax
80100163:	83 e0 04             	and    $0x4,%eax
80100166:	85 c0                	test   %eax,%eax
80100168:	75 4c                	jne    801001b6 <bget+0xf1>
      b->dev = dev;
8010016a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016d:	8b 55 08             	mov    0x8(%ebp),%edx
80100170:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
80100173:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100176:	8b 55 0c             	mov    0xc(%ebp),%edx
80100179:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = 0;
8010017c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
      b->refcnt = 1;
80100185:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100188:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
      release(&bcache.lock);
8010018f:	83 ec 0c             	sub    $0xc,%esp
80100192:	68 40 c6 10 80       	push   $0x8010c640
80100197:	e8 94 51 00 00       	call   80105330 <release>
8010019c:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
8010019f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001a2:	83 c0 0c             	add    $0xc,%eax
801001a5:	83 ec 0c             	sub    $0xc,%esp
801001a8:	50                   	push   %eax
801001a9:	e8 97 4f 00 00       	call   80105145 <acquiresleep>
801001ae:	83 c4 10             	add    $0x10,%esp
      return b;
801001b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001b4:	eb 1f                	jmp    801001d5 <bget+0x110>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801001b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001b9:	8b 40 50             	mov    0x50(%eax),%eax
801001bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001bf:	81 7d f4 3c 0d 11 80 	cmpl   $0x80110d3c,-0xc(%ebp)
801001c6:	75 8c                	jne    80100154 <bget+0x8f>
    }
  }
  panic("bget: no buffers");
801001c8:	83 ec 0c             	sub    $0xc,%esp
801001cb:	68 16 88 10 80       	push   $0x80108816
801001d0:	e8 fc 03 00 00       	call   801005d1 <panic>
}
801001d5:	c9                   	leave  
801001d6:	c3                   	ret    

801001d7 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801001d7:	f3 0f 1e fb          	endbr32 
801001db:	55                   	push   %ebp
801001dc:	89 e5                	mov    %esp,%ebp
801001de:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
801001e1:	83 ec 08             	sub    $0x8,%esp
801001e4:	ff 75 0c             	pushl  0xc(%ebp)
801001e7:	ff 75 08             	pushl  0x8(%ebp)
801001ea:	e8 d6 fe ff ff       	call   801000c5 <bget>
801001ef:	83 c4 10             	add    $0x10,%esp
801001f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((b->flags & B_VALID) == 0) {
801001f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001f8:	8b 00                	mov    (%eax),%eax
801001fa:	83 e0 02             	and    $0x2,%eax
801001fd:	85 c0                	test   %eax,%eax
801001ff:	75 0e                	jne    8010020f <bread+0x38>
    iderw(b);
80100201:	83 ec 0c             	sub    $0xc,%esp
80100204:	ff 75 f4             	pushl  -0xc(%ebp)
80100207:	e8 2e 28 00 00       	call   80102a3a <iderw>
8010020c:	83 c4 10             	add    $0x10,%esp
  }
  return b;
8010020f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80100212:	c9                   	leave  
80100213:	c3                   	ret    

80100214 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100214:	f3 0f 1e fb          	endbr32 
80100218:	55                   	push   %ebp
80100219:	89 e5                	mov    %esp,%ebp
8010021b:	83 ec 08             	sub    $0x8,%esp
  if(!holdingsleep(&b->lock))
8010021e:	8b 45 08             	mov    0x8(%ebp),%eax
80100221:	83 c0 0c             	add    $0xc,%eax
80100224:	83 ec 0c             	sub    $0xc,%esp
80100227:	50                   	push   %eax
80100228:	e8 d2 4f 00 00       	call   801051ff <holdingsleep>
8010022d:	83 c4 10             	add    $0x10,%esp
80100230:	85 c0                	test   %eax,%eax
80100232:	75 0d                	jne    80100241 <bwrite+0x2d>
    panic("bwrite");
80100234:	83 ec 0c             	sub    $0xc,%esp
80100237:	68 27 88 10 80       	push   $0x80108827
8010023c:	e8 90 03 00 00       	call   801005d1 <panic>
  b->flags |= B_DIRTY;
80100241:	8b 45 08             	mov    0x8(%ebp),%eax
80100244:	8b 00                	mov    (%eax),%eax
80100246:	83 c8 04             	or     $0x4,%eax
80100249:	89 c2                	mov    %eax,%edx
8010024b:	8b 45 08             	mov    0x8(%ebp),%eax
8010024e:	89 10                	mov    %edx,(%eax)
  iderw(b);
80100250:	83 ec 0c             	sub    $0xc,%esp
80100253:	ff 75 08             	pushl  0x8(%ebp)
80100256:	e8 df 27 00 00       	call   80102a3a <iderw>
8010025b:	83 c4 10             	add    $0x10,%esp
}
8010025e:	90                   	nop
8010025f:	c9                   	leave  
80100260:	c3                   	ret    

80100261 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100261:	f3 0f 1e fb          	endbr32 
80100265:	55                   	push   %ebp
80100266:	89 e5                	mov    %esp,%ebp
80100268:	83 ec 08             	sub    $0x8,%esp
  if(!holdingsleep(&b->lock))
8010026b:	8b 45 08             	mov    0x8(%ebp),%eax
8010026e:	83 c0 0c             	add    $0xc,%eax
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	50                   	push   %eax
80100275:	e8 85 4f 00 00       	call   801051ff <holdingsleep>
8010027a:	83 c4 10             	add    $0x10,%esp
8010027d:	85 c0                	test   %eax,%eax
8010027f:	75 0d                	jne    8010028e <brelse+0x2d>
    panic("brelse");
80100281:	83 ec 0c             	sub    $0xc,%esp
80100284:	68 2e 88 10 80       	push   $0x8010882e
80100289:	e8 43 03 00 00       	call   801005d1 <panic>

  releasesleep(&b->lock);
8010028e:	8b 45 08             	mov    0x8(%ebp),%eax
80100291:	83 c0 0c             	add    $0xc,%eax
80100294:	83 ec 0c             	sub    $0xc,%esp
80100297:	50                   	push   %eax
80100298:	e8 10 4f 00 00       	call   801051ad <releasesleep>
8010029d:	83 c4 10             	add    $0x10,%esp

  acquire(&bcache.lock);
801002a0:	83 ec 0c             	sub    $0xc,%esp
801002a3:	68 40 c6 10 80       	push   $0x8010c640
801002a8:	e8 11 50 00 00       	call   801052be <acquire>
801002ad:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
801002b0:	8b 45 08             	mov    0x8(%ebp),%eax
801002b3:	8b 40 4c             	mov    0x4c(%eax),%eax
801002b6:	8d 50 ff             	lea    -0x1(%eax),%edx
801002b9:	8b 45 08             	mov    0x8(%ebp),%eax
801002bc:	89 50 4c             	mov    %edx,0x4c(%eax)
  if (b->refcnt == 0) {
801002bf:	8b 45 08             	mov    0x8(%ebp),%eax
801002c2:	8b 40 4c             	mov    0x4c(%eax),%eax
801002c5:	85 c0                	test   %eax,%eax
801002c7:	75 47                	jne    80100310 <brelse+0xaf>
    // no one is waiting for it.
    b->next->prev = b->prev;
801002c9:	8b 45 08             	mov    0x8(%ebp),%eax
801002cc:	8b 40 54             	mov    0x54(%eax),%eax
801002cf:	8b 55 08             	mov    0x8(%ebp),%edx
801002d2:	8b 52 50             	mov    0x50(%edx),%edx
801002d5:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
801002d8:	8b 45 08             	mov    0x8(%ebp),%eax
801002db:	8b 40 50             	mov    0x50(%eax),%eax
801002de:	8b 55 08             	mov    0x8(%ebp),%edx
801002e1:	8b 52 54             	mov    0x54(%edx),%edx
801002e4:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
801002e7:	8b 15 90 0d 11 80    	mov    0x80110d90,%edx
801002ed:	8b 45 08             	mov    0x8(%ebp),%eax
801002f0:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
801002f3:	8b 45 08             	mov    0x8(%ebp),%eax
801002f6:	c7 40 50 3c 0d 11 80 	movl   $0x80110d3c,0x50(%eax)
    bcache.head.next->prev = b;
801002fd:	a1 90 0d 11 80       	mov    0x80110d90,%eax
80100302:	8b 55 08             	mov    0x8(%ebp),%edx
80100305:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
80100308:	8b 45 08             	mov    0x8(%ebp),%eax
8010030b:	a3 90 0d 11 80       	mov    %eax,0x80110d90
  }
  
  release(&bcache.lock);
80100310:	83 ec 0c             	sub    $0xc,%esp
80100313:	68 40 c6 10 80       	push   $0x8010c640
80100318:	e8 13 50 00 00       	call   80105330 <release>
8010031d:	83 c4 10             	add    $0x10,%esp
}
80100320:	90                   	nop
80100321:	c9                   	leave  
80100322:	c3                   	ret    

80100323 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80100323:	55                   	push   %ebp
80100324:	89 e5                	mov    %esp,%ebp
80100326:	83 ec 14             	sub    $0x14,%esp
80100329:	8b 45 08             	mov    0x8(%ebp),%eax
8010032c:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100330:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80100334:	89 c2                	mov    %eax,%edx
80100336:	ec                   	in     (%dx),%al
80100337:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010033a:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010033e:	c9                   	leave  
8010033f:	c3                   	ret    

80100340 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80100340:	55                   	push   %ebp
80100341:	89 e5                	mov    %esp,%ebp
80100343:	83 ec 08             	sub    $0x8,%esp
80100346:	8b 45 08             	mov    0x8(%ebp),%eax
80100349:	8b 55 0c             	mov    0xc(%ebp),%edx
8010034c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80100350:	89 d0                	mov    %edx,%eax
80100352:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100355:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100359:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010035d:	ee                   	out    %al,(%dx)
}
8010035e:	90                   	nop
8010035f:	c9                   	leave  
80100360:	c3                   	ret    

80100361 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100361:	55                   	push   %ebp
80100362:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80100364:	fa                   	cli    
}
80100365:	90                   	nop
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    

80100368 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100368:	f3 0f 1e fb          	endbr32 
8010036c:	55                   	push   %ebp
8010036d:	89 e5                	mov    %esp,%ebp
8010036f:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100372:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100376:	74 1c                	je     80100394 <printint+0x2c>
80100378:	8b 45 08             	mov    0x8(%ebp),%eax
8010037b:	c1 e8 1f             	shr    $0x1f,%eax
8010037e:	0f b6 c0             	movzbl %al,%eax
80100381:	89 45 10             	mov    %eax,0x10(%ebp)
80100384:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100388:	74 0a                	je     80100394 <printint+0x2c>
    x = -xx;
8010038a:	8b 45 08             	mov    0x8(%ebp),%eax
8010038d:	f7 d8                	neg    %eax
8010038f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100392:	eb 06                	jmp    8010039a <printint+0x32>
  else
    x = xx;
80100394:	8b 45 08             	mov    0x8(%ebp),%eax
80100397:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
8010039a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
801003a1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801003a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801003a7:	ba 00 00 00 00       	mov    $0x0,%edx
801003ac:	f7 f1                	div    %ecx
801003ae:	89 d1                	mov    %edx,%ecx
801003b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003b3:	8d 50 01             	lea    0x1(%eax),%edx
801003b6:	89 55 f4             	mov    %edx,-0xc(%ebp)
801003b9:	0f b6 91 04 90 10 80 	movzbl -0x7fef6ffc(%ecx),%edx
801003c0:	88 54 05 e0          	mov    %dl,-0x20(%ebp,%eax,1)
  }while((x /= base) != 0);
801003c4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801003c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801003ca:	ba 00 00 00 00       	mov    $0x0,%edx
801003cf:	f7 f1                	div    %ecx
801003d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
801003d4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801003d8:	75 c7                	jne    801003a1 <printint+0x39>

  if(sign)
801003da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801003de:	74 2a                	je     8010040a <printint+0xa2>
    buf[i++] = '-';
801003e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003e3:	8d 50 01             	lea    0x1(%eax),%edx
801003e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
801003e9:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
801003ee:	eb 1a                	jmp    8010040a <printint+0xa2>
    consputc(buf[i]);
801003f0:	8d 55 e0             	lea    -0x20(%ebp),%edx
801003f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003f6:	01 d0                	add    %edx,%eax
801003f8:	0f b6 00             	movzbl (%eax),%eax
801003fb:	0f be c0             	movsbl %al,%eax
801003fe:	83 ec 0c             	sub    $0xc,%esp
80100401:	50                   	push   %eax
80100402:	e8 ff 03 00 00       	call   80100806 <consputc>
80100407:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
8010040a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
8010040e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100412:	79 dc                	jns    801003f0 <printint+0x88>
}
80100414:	90                   	nop
80100415:	90                   	nop
80100416:	c9                   	leave  
80100417:	c3                   	ret    

80100418 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100418:	f3 0f 1e fb          	endbr32 
8010041c:	55                   	push   %ebp
8010041d:	89 e5                	mov    %esp,%ebp
8010041f:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100422:	a1 d4 b5 10 80       	mov    0x8010b5d4,%eax
80100427:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
8010042a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010042e:	74 10                	je     80100440 <cprintf+0x28>
    acquire(&cons.lock);
80100430:	83 ec 0c             	sub    $0xc,%esp
80100433:	68 a0 b5 10 80       	push   $0x8010b5a0
80100438:	e8 81 4e 00 00       	call   801052be <acquire>
8010043d:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
80100440:	8b 45 08             	mov    0x8(%ebp),%eax
80100443:	85 c0                	test   %eax,%eax
80100445:	75 0d                	jne    80100454 <cprintf+0x3c>
    panic("null fmt");
80100447:	83 ec 0c             	sub    $0xc,%esp
8010044a:	68 35 88 10 80       	push   $0x80108835
8010044f:	e8 7d 01 00 00       	call   801005d1 <panic>

  argp = (uint*)(void*)(&fmt + 1);
80100454:	8d 45 0c             	lea    0xc(%ebp),%eax
80100457:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010045a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100461:	e9 2f 01 00 00       	jmp    80100595 <cprintf+0x17d>
    if(c != '%'){
80100466:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
8010046a:	74 13                	je     8010047f <cprintf+0x67>
      consputc(c);
8010046c:	83 ec 0c             	sub    $0xc,%esp
8010046f:	ff 75 e4             	pushl  -0x1c(%ebp)
80100472:	e8 8f 03 00 00       	call   80100806 <consputc>
80100477:	83 c4 10             	add    $0x10,%esp
      continue;
8010047a:	e9 12 01 00 00       	jmp    80100591 <cprintf+0x179>
    }
    c = fmt[++i] & 0xff;
8010047f:	8b 55 08             	mov    0x8(%ebp),%edx
80100482:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100486:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100489:	01 d0                	add    %edx,%eax
8010048b:	0f b6 00             	movzbl (%eax),%eax
8010048e:	0f be c0             	movsbl %al,%eax
80100491:	25 ff 00 00 00       	and    $0xff,%eax
80100496:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100499:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010049d:	0f 84 14 01 00 00    	je     801005b7 <cprintf+0x19f>
      break;
    switch(c){
801004a3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
801004a7:	74 5e                	je     80100507 <cprintf+0xef>
801004a9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
801004ad:	0f 8f c2 00 00 00    	jg     80100575 <cprintf+0x15d>
801004b3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
801004b7:	74 6b                	je     80100524 <cprintf+0x10c>
801004b9:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
801004bd:	0f 8f b2 00 00 00    	jg     80100575 <cprintf+0x15d>
801004c3:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
801004c7:	74 3e                	je     80100507 <cprintf+0xef>
801004c9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
801004cd:	0f 8f a2 00 00 00    	jg     80100575 <cprintf+0x15d>
801004d3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
801004d7:	0f 84 89 00 00 00    	je     80100566 <cprintf+0x14e>
801004dd:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
801004e1:	0f 85 8e 00 00 00    	jne    80100575 <cprintf+0x15d>
    case 'd':
      printint(*argp++, 10, 1);
801004e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004ea:	8d 50 04             	lea    0x4(%eax),%edx
801004ed:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004f0:	8b 00                	mov    (%eax),%eax
801004f2:	83 ec 04             	sub    $0x4,%esp
801004f5:	6a 01                	push   $0x1
801004f7:	6a 0a                	push   $0xa
801004f9:	50                   	push   %eax
801004fa:	e8 69 fe ff ff       	call   80100368 <printint>
801004ff:	83 c4 10             	add    $0x10,%esp
      break;
80100502:	e9 8a 00 00 00       	jmp    80100591 <cprintf+0x179>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100507:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010050a:	8d 50 04             	lea    0x4(%eax),%edx
8010050d:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100510:	8b 00                	mov    (%eax),%eax
80100512:	83 ec 04             	sub    $0x4,%esp
80100515:	6a 00                	push   $0x0
80100517:	6a 10                	push   $0x10
80100519:	50                   	push   %eax
8010051a:	e8 49 fe ff ff       	call   80100368 <printint>
8010051f:	83 c4 10             	add    $0x10,%esp
      break;
80100522:	eb 6d                	jmp    80100591 <cprintf+0x179>
    case 's':
      if((s = (char*)*argp++) == 0)
80100524:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100527:	8d 50 04             	lea    0x4(%eax),%edx
8010052a:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010052d:	8b 00                	mov    (%eax),%eax
8010052f:	89 45 ec             	mov    %eax,-0x14(%ebp)
80100532:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100536:	75 22                	jne    8010055a <cprintf+0x142>
        s = "(null)";
80100538:	c7 45 ec 3e 88 10 80 	movl   $0x8010883e,-0x14(%ebp)
      for(; *s; s++)
8010053f:	eb 19                	jmp    8010055a <cprintf+0x142>
        consputc(*s);
80100541:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100544:	0f b6 00             	movzbl (%eax),%eax
80100547:	0f be c0             	movsbl %al,%eax
8010054a:	83 ec 0c             	sub    $0xc,%esp
8010054d:	50                   	push   %eax
8010054e:	e8 b3 02 00 00       	call   80100806 <consputc>
80100553:	83 c4 10             	add    $0x10,%esp
      for(; *s; s++)
80100556:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010055a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010055d:	0f b6 00             	movzbl (%eax),%eax
80100560:	84 c0                	test   %al,%al
80100562:	75 dd                	jne    80100541 <cprintf+0x129>
      break;
80100564:	eb 2b                	jmp    80100591 <cprintf+0x179>
    case '%':
      consputc('%');
80100566:	83 ec 0c             	sub    $0xc,%esp
80100569:	6a 25                	push   $0x25
8010056b:	e8 96 02 00 00       	call   80100806 <consputc>
80100570:	83 c4 10             	add    $0x10,%esp
      break;
80100573:	eb 1c                	jmp    80100591 <cprintf+0x179>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100575:	83 ec 0c             	sub    $0xc,%esp
80100578:	6a 25                	push   $0x25
8010057a:	e8 87 02 00 00       	call   80100806 <consputc>
8010057f:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100582:	83 ec 0c             	sub    $0xc,%esp
80100585:	ff 75 e4             	pushl  -0x1c(%ebp)
80100588:	e8 79 02 00 00       	call   80100806 <consputc>
8010058d:	83 c4 10             	add    $0x10,%esp
      break;
80100590:	90                   	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100591:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100595:	8b 55 08             	mov    0x8(%ebp),%edx
80100598:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010059b:	01 d0                	add    %edx,%eax
8010059d:	0f b6 00             	movzbl (%eax),%eax
801005a0:	0f be c0             	movsbl %al,%eax
801005a3:	25 ff 00 00 00       	and    $0xff,%eax
801005a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801005ab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
801005af:	0f 85 b1 fe ff ff    	jne    80100466 <cprintf+0x4e>
801005b5:	eb 01                	jmp    801005b8 <cprintf+0x1a0>
      break;
801005b7:	90                   	nop
    }
  }

  if(locking)
801005b8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801005bc:	74 10                	je     801005ce <cprintf+0x1b6>
    release(&cons.lock);
801005be:	83 ec 0c             	sub    $0xc,%esp
801005c1:	68 a0 b5 10 80       	push   $0x8010b5a0
801005c6:	e8 65 4d 00 00       	call   80105330 <release>
801005cb:	83 c4 10             	add    $0x10,%esp
}
801005ce:	90                   	nop
801005cf:	c9                   	leave  
801005d0:	c3                   	ret    

801005d1 <panic>:

void
panic(char *s)
{
801005d1:	f3 0f 1e fb          	endbr32 
801005d5:	55                   	push   %ebp
801005d6:	89 e5                	mov    %esp,%ebp
801005d8:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];

  cli();
801005db:	e8 81 fd ff ff       	call   80100361 <cli>
  cons.locking = 0;
801005e0:	c7 05 d4 b5 10 80 00 	movl   $0x0,0x8010b5d4
801005e7:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
801005ea:	e8 17 2b 00 00       	call   80103106 <lapicid>
801005ef:	83 ec 08             	sub    $0x8,%esp
801005f2:	50                   	push   %eax
801005f3:	68 45 88 10 80       	push   $0x80108845
801005f8:	e8 1b fe ff ff       	call   80100418 <cprintf>
801005fd:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
80100600:	8b 45 08             	mov    0x8(%ebp),%eax
80100603:	83 ec 0c             	sub    $0xc,%esp
80100606:	50                   	push   %eax
80100607:	e8 0c fe ff ff       	call   80100418 <cprintf>
8010060c:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
8010060f:	83 ec 0c             	sub    $0xc,%esp
80100612:	68 59 88 10 80       	push   $0x80108859
80100617:	e8 fc fd ff ff       	call   80100418 <cprintf>
8010061c:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
8010061f:	83 ec 08             	sub    $0x8,%esp
80100622:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100625:	50                   	push   %eax
80100626:	8d 45 08             	lea    0x8(%ebp),%eax
80100629:	50                   	push   %eax
8010062a:	e8 57 4d 00 00       	call   80105386 <getcallerpcs>
8010062f:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100632:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100639:	eb 1c                	jmp    80100657 <panic+0x86>
    cprintf(" %p", pcs[i]);
8010063b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010063e:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
80100642:	83 ec 08             	sub    $0x8,%esp
80100645:	50                   	push   %eax
80100646:	68 5b 88 10 80       	push   $0x8010885b
8010064b:	e8 c8 fd ff ff       	call   80100418 <cprintf>
80100650:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100653:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100657:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010065b:	7e de                	jle    8010063b <panic+0x6a>
  panicked = 1; // freeze other CPU
8010065d:	c7 05 80 b5 10 80 01 	movl   $0x1,0x8010b580
80100664:	00 00 00 
  for(;;)
80100667:	eb fe                	jmp    80100667 <panic+0x96>

80100669 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
80100669:	f3 0f 1e fb          	endbr32 
8010066d:	55                   	push   %ebp
8010066e:	89 e5                	mov    %esp,%ebp
80100670:	53                   	push   %ebx
80100671:	83 ec 14             	sub    $0x14,%esp
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100674:	6a 0e                	push   $0xe
80100676:	68 d4 03 00 00       	push   $0x3d4
8010067b:	e8 c0 fc ff ff       	call   80100340 <outb>
80100680:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100683:	68 d5 03 00 00       	push   $0x3d5
80100688:	e8 96 fc ff ff       	call   80100323 <inb>
8010068d:	83 c4 04             	add    $0x4,%esp
80100690:	0f b6 c0             	movzbl %al,%eax
80100693:	c1 e0 08             	shl    $0x8,%eax
80100696:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100699:	6a 0f                	push   $0xf
8010069b:	68 d4 03 00 00       	push   $0x3d4
801006a0:	e8 9b fc ff ff       	call   80100340 <outb>
801006a5:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
801006a8:	68 d5 03 00 00       	push   $0x3d5
801006ad:	e8 71 fc ff ff       	call   80100323 <inb>
801006b2:	83 c4 04             	add    $0x4,%esp
801006b5:	0f b6 c0             	movzbl %al,%eax
801006b8:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
801006bb:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
801006bf:	75 30                	jne    801006f1 <cgaputc+0x88>
    pos += 80 - pos%80;
801006c1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006c4:	ba 67 66 66 66       	mov    $0x66666667,%edx
801006c9:	89 c8                	mov    %ecx,%eax
801006cb:	f7 ea                	imul   %edx
801006cd:	c1 fa 05             	sar    $0x5,%edx
801006d0:	89 c8                	mov    %ecx,%eax
801006d2:	c1 f8 1f             	sar    $0x1f,%eax
801006d5:	29 c2                	sub    %eax,%edx
801006d7:	89 d0                	mov    %edx,%eax
801006d9:	c1 e0 02             	shl    $0x2,%eax
801006dc:	01 d0                	add    %edx,%eax
801006de:	c1 e0 04             	shl    $0x4,%eax
801006e1:	29 c1                	sub    %eax,%ecx
801006e3:	89 ca                	mov    %ecx,%edx
801006e5:	b8 50 00 00 00       	mov    $0x50,%eax
801006ea:	29 d0                	sub    %edx,%eax
801006ec:	01 45 f4             	add    %eax,-0xc(%ebp)
801006ef:	eb 38                	jmp    80100729 <cgaputc+0xc0>
  else if(c == BACKSPACE){
801006f1:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801006f8:	75 0c                	jne    80100706 <cgaputc+0x9d>
    if(pos > 0) --pos;
801006fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006fe:	7e 29                	jle    80100729 <cgaputc+0xc0>
80100700:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100704:	eb 23                	jmp    80100729 <cgaputc+0xc0>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100706:	8b 45 08             	mov    0x8(%ebp),%eax
80100709:	0f b6 c0             	movzbl %al,%eax
8010070c:	80 cc 07             	or     $0x7,%ah
8010070f:	89 c3                	mov    %eax,%ebx
80100711:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
80100717:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010071a:	8d 50 01             	lea    0x1(%eax),%edx
8010071d:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100720:	01 c0                	add    %eax,%eax
80100722:	01 c8                	add    %ecx,%eax
80100724:	89 da                	mov    %ebx,%edx
80100726:	66 89 10             	mov    %dx,(%eax)

  if(pos < 0 || pos > 25*80)
80100729:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010072d:	78 09                	js     80100738 <cgaputc+0xcf>
8010072f:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
80100736:	7e 0d                	jle    80100745 <cgaputc+0xdc>
    panic("pos under/overflow");
80100738:	83 ec 0c             	sub    $0xc,%esp
8010073b:	68 5f 88 10 80       	push   $0x8010885f
80100740:	e8 8c fe ff ff       	call   801005d1 <panic>

  if((pos/80) >= 24){  // Scroll up.
80100745:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
8010074c:	7e 4c                	jle    8010079a <cgaputc+0x131>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010074e:	a1 00 90 10 80       	mov    0x80109000,%eax
80100753:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
80100759:	a1 00 90 10 80       	mov    0x80109000,%eax
8010075e:	83 ec 04             	sub    $0x4,%esp
80100761:	68 60 0e 00 00       	push   $0xe60
80100766:	52                   	push   %edx
80100767:	50                   	push   %eax
80100768:	e8 b7 4e 00 00       	call   80105624 <memmove>
8010076d:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
80100770:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100774:	b8 80 07 00 00       	mov    $0x780,%eax
80100779:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010077c:	8d 14 00             	lea    (%eax,%eax,1),%edx
8010077f:	a1 00 90 10 80       	mov    0x80109000,%eax
80100784:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100787:	01 c9                	add    %ecx,%ecx
80100789:	01 c8                	add    %ecx,%eax
8010078b:	83 ec 04             	sub    $0x4,%esp
8010078e:	52                   	push   %edx
8010078f:	6a 00                	push   $0x0
80100791:	50                   	push   %eax
80100792:	e8 c6 4d 00 00       	call   8010555d <memset>
80100797:	83 c4 10             	add    $0x10,%esp
  }

  outb(CRTPORT, 14);
8010079a:	83 ec 08             	sub    $0x8,%esp
8010079d:	6a 0e                	push   $0xe
8010079f:	68 d4 03 00 00       	push   $0x3d4
801007a4:	e8 97 fb ff ff       	call   80100340 <outb>
801007a9:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
801007ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007af:	c1 f8 08             	sar    $0x8,%eax
801007b2:	0f b6 c0             	movzbl %al,%eax
801007b5:	83 ec 08             	sub    $0x8,%esp
801007b8:	50                   	push   %eax
801007b9:	68 d5 03 00 00       	push   $0x3d5
801007be:	e8 7d fb ff ff       	call   80100340 <outb>
801007c3:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
801007c6:	83 ec 08             	sub    $0x8,%esp
801007c9:	6a 0f                	push   $0xf
801007cb:	68 d4 03 00 00       	push   $0x3d4
801007d0:	e8 6b fb ff ff       	call   80100340 <outb>
801007d5:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
801007d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007db:	0f b6 c0             	movzbl %al,%eax
801007de:	83 ec 08             	sub    $0x8,%esp
801007e1:	50                   	push   %eax
801007e2:	68 d5 03 00 00       	push   $0x3d5
801007e7:	e8 54 fb ff ff       	call   80100340 <outb>
801007ec:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
801007ef:	a1 00 90 10 80       	mov    0x80109000,%eax
801007f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801007f7:	01 d2                	add    %edx,%edx
801007f9:	01 d0                	add    %edx,%eax
801007fb:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100800:	90                   	nop
80100801:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100804:	c9                   	leave  
80100805:	c3                   	ret    

80100806 <consputc>:

void
consputc(int c)
{
80100806:	f3 0f 1e fb          	endbr32 
8010080a:	55                   	push   %ebp
8010080b:	89 e5                	mov    %esp,%ebp
8010080d:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
80100810:	a1 80 b5 10 80       	mov    0x8010b580,%eax
80100815:	85 c0                	test   %eax,%eax
80100817:	74 07                	je     80100820 <consputc+0x1a>
    cli();
80100819:	e8 43 fb ff ff       	call   80100361 <cli>
    for(;;)
8010081e:	eb fe                	jmp    8010081e <consputc+0x18>
      ;
  }

  if(c == BACKSPACE){
80100820:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100827:	75 29                	jne    80100852 <consputc+0x4c>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100829:	83 ec 0c             	sub    $0xc,%esp
8010082c:	6a 08                	push   $0x8
8010082e:	e8 3a 67 00 00       	call   80106f6d <uartputc>
80100833:	83 c4 10             	add    $0x10,%esp
80100836:	83 ec 0c             	sub    $0xc,%esp
80100839:	6a 20                	push   $0x20
8010083b:	e8 2d 67 00 00       	call   80106f6d <uartputc>
80100840:	83 c4 10             	add    $0x10,%esp
80100843:	83 ec 0c             	sub    $0xc,%esp
80100846:	6a 08                	push   $0x8
80100848:	e8 20 67 00 00       	call   80106f6d <uartputc>
8010084d:	83 c4 10             	add    $0x10,%esp
80100850:	eb 0e                	jmp    80100860 <consputc+0x5a>
  } else
    uartputc(c);
80100852:	83 ec 0c             	sub    $0xc,%esp
80100855:	ff 75 08             	pushl  0x8(%ebp)
80100858:	e8 10 67 00 00       	call   80106f6d <uartputc>
8010085d:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	ff 75 08             	pushl  0x8(%ebp)
80100866:	e8 fe fd ff ff       	call   80100669 <cgaputc>
8010086b:	83 c4 10             	add    $0x10,%esp
}
8010086e:	90                   	nop
8010086f:	c9                   	leave  
80100870:	c3                   	ret    

80100871 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100871:	f3 0f 1e fb          	endbr32 
80100875:	55                   	push   %ebp
80100876:	89 e5                	mov    %esp,%ebp
80100878:	83 ec 18             	sub    $0x18,%esp
  int c, doprocdump = 0;
8010087b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
80100882:	83 ec 0c             	sub    $0xc,%esp
80100885:	68 a0 b5 10 80       	push   $0x8010b5a0
8010088a:	e8 2f 4a 00 00       	call   801052be <acquire>
8010088f:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
80100892:	e9 52 01 00 00       	jmp    801009e9 <consoleintr+0x178>
    switch(c){
80100897:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
8010089b:	0f 84 81 00 00 00    	je     80100922 <consoleintr+0xb1>
801008a1:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
801008a5:	0f 8f ac 00 00 00    	jg     80100957 <consoleintr+0xe6>
801008ab:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
801008af:	74 43                	je     801008f4 <consoleintr+0x83>
801008b1:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
801008b5:	0f 8f 9c 00 00 00    	jg     80100957 <consoleintr+0xe6>
801008bb:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
801008bf:	74 61                	je     80100922 <consoleintr+0xb1>
801008c1:	83 7d f0 10          	cmpl   $0x10,-0x10(%ebp)
801008c5:	0f 85 8c 00 00 00    	jne    80100957 <consoleintr+0xe6>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
801008cb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
801008d2:	e9 12 01 00 00       	jmp    801009e9 <consoleintr+0x178>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801008d7:	a1 28 10 11 80       	mov    0x80111028,%eax
801008dc:	83 e8 01             	sub    $0x1,%eax
801008df:	a3 28 10 11 80       	mov    %eax,0x80111028
        consputc(BACKSPACE);
801008e4:	83 ec 0c             	sub    $0xc,%esp
801008e7:	68 00 01 00 00       	push   $0x100
801008ec:	e8 15 ff ff ff       	call   80100806 <consputc>
801008f1:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
801008f4:	8b 15 28 10 11 80    	mov    0x80111028,%edx
801008fa:	a1 24 10 11 80       	mov    0x80111024,%eax
801008ff:	39 c2                	cmp    %eax,%edx
80100901:	0f 84 e2 00 00 00    	je     801009e9 <consoleintr+0x178>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100907:	a1 28 10 11 80       	mov    0x80111028,%eax
8010090c:	83 e8 01             	sub    $0x1,%eax
8010090f:	83 e0 7f             	and    $0x7f,%eax
80100912:	0f b6 80 a0 0f 11 80 	movzbl -0x7feef060(%eax),%eax
      while(input.e != input.w &&
80100919:	3c 0a                	cmp    $0xa,%al
8010091b:	75 ba                	jne    801008d7 <consoleintr+0x66>
      }
      break;
8010091d:	e9 c7 00 00 00       	jmp    801009e9 <consoleintr+0x178>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100922:	8b 15 28 10 11 80    	mov    0x80111028,%edx
80100928:	a1 24 10 11 80       	mov    0x80111024,%eax
8010092d:	39 c2                	cmp    %eax,%edx
8010092f:	0f 84 b4 00 00 00    	je     801009e9 <consoleintr+0x178>
        input.e--;
80100935:	a1 28 10 11 80       	mov    0x80111028,%eax
8010093a:	83 e8 01             	sub    $0x1,%eax
8010093d:	a3 28 10 11 80       	mov    %eax,0x80111028
        consputc(BACKSPACE);
80100942:	83 ec 0c             	sub    $0xc,%esp
80100945:	68 00 01 00 00       	push   $0x100
8010094a:	e8 b7 fe ff ff       	call   80100806 <consputc>
8010094f:	83 c4 10             	add    $0x10,%esp
      }
      break;
80100952:	e9 92 00 00 00       	jmp    801009e9 <consoleintr+0x178>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100957:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010095b:	0f 84 87 00 00 00    	je     801009e8 <consoleintr+0x177>
80100961:	8b 15 28 10 11 80    	mov    0x80111028,%edx
80100967:	a1 20 10 11 80       	mov    0x80111020,%eax
8010096c:	29 c2                	sub    %eax,%edx
8010096e:	89 d0                	mov    %edx,%eax
80100970:	83 f8 7f             	cmp    $0x7f,%eax
80100973:	77 73                	ja     801009e8 <consoleintr+0x177>
        c = (c == '\r') ? '\n' : c;
80100975:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80100979:	74 05                	je     80100980 <consoleintr+0x10f>
8010097b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010097e:	eb 05                	jmp    80100985 <consoleintr+0x114>
80100980:	b8 0a 00 00 00       	mov    $0xa,%eax
80100985:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
80100988:	a1 28 10 11 80       	mov    0x80111028,%eax
8010098d:	8d 50 01             	lea    0x1(%eax),%edx
80100990:	89 15 28 10 11 80    	mov    %edx,0x80111028
80100996:	83 e0 7f             	and    $0x7f,%eax
80100999:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010099c:	88 90 a0 0f 11 80    	mov    %dl,-0x7feef060(%eax)
        consputc(c);
801009a2:	83 ec 0c             	sub    $0xc,%esp
801009a5:	ff 75 f0             	pushl  -0x10(%ebp)
801009a8:	e8 59 fe ff ff       	call   80100806 <consputc>
801009ad:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009b0:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
801009b4:	74 18                	je     801009ce <consoleintr+0x15d>
801009b6:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801009ba:	74 12                	je     801009ce <consoleintr+0x15d>
801009bc:	a1 28 10 11 80       	mov    0x80111028,%eax
801009c1:	8b 15 20 10 11 80    	mov    0x80111020,%edx
801009c7:	83 ea 80             	sub    $0xffffff80,%edx
801009ca:	39 d0                	cmp    %edx,%eax
801009cc:	75 1a                	jne    801009e8 <consoleintr+0x177>
          input.w = input.e;
801009ce:	a1 28 10 11 80       	mov    0x80111028,%eax
801009d3:	a3 24 10 11 80       	mov    %eax,0x80111024
          wakeup(&input.r);
801009d8:	83 ec 0c             	sub    $0xc,%esp
801009db:	68 20 10 11 80       	push   $0x80111020
801009e0:	e8 59 45 00 00       	call   80104f3e <wakeup>
801009e5:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
801009e8:	90                   	nop
  while((c = getc()) >= 0){
801009e9:	8b 45 08             	mov    0x8(%ebp),%eax
801009ec:	ff d0                	call   *%eax
801009ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
801009f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801009f5:	0f 89 9c fe ff ff    	jns    80100897 <consoleintr+0x26>
    }
  }
  release(&cons.lock);
801009fb:	83 ec 0c             	sub    $0xc,%esp
801009fe:	68 a0 b5 10 80       	push   $0x8010b5a0
80100a03:	e8 28 49 00 00       	call   80105330 <release>
80100a08:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
80100a0b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100a0f:	74 05                	je     80100a16 <consoleintr+0x1a5>
    procdump();  // now call procdump() wo. cons.lock held
80100a11:	e8 ee 45 00 00       	call   80105004 <procdump>
  }
}
80100a16:	90                   	nop
80100a17:	c9                   	leave  
80100a18:	c3                   	ret    

80100a19 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100a19:	f3 0f 1e fb          	endbr32 
80100a1d:	55                   	push   %ebp
80100a1e:	89 e5                	mov    %esp,%ebp
80100a20:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100a23:	83 ec 0c             	sub    $0xc,%esp
80100a26:	ff 75 08             	pushl  0x8(%ebp)
80100a29:	e8 92 11 00 00       	call   80101bc0 <iunlock>
80100a2e:	83 c4 10             	add    $0x10,%esp
  target = n;
80100a31:	8b 45 10             	mov    0x10(%ebp),%eax
80100a34:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
80100a37:	83 ec 0c             	sub    $0xc,%esp
80100a3a:	68 a0 b5 10 80       	push   $0x8010b5a0
80100a3f:	e8 7a 48 00 00       	call   801052be <acquire>
80100a44:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
80100a47:	e9 ab 00 00 00       	jmp    80100af7 <consoleread+0xde>
    while(input.r == input.w){
      if(myproc()->killed){
80100a4c:	e8 e6 39 00 00       	call   80104437 <myproc>
80100a51:	8b 40 24             	mov    0x24(%eax),%eax
80100a54:	85 c0                	test   %eax,%eax
80100a56:	74 28                	je     80100a80 <consoleread+0x67>
        release(&cons.lock);
80100a58:	83 ec 0c             	sub    $0xc,%esp
80100a5b:	68 a0 b5 10 80       	push   $0x8010b5a0
80100a60:	e8 cb 48 00 00       	call   80105330 <release>
80100a65:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
80100a68:	83 ec 0c             	sub    $0xc,%esp
80100a6b:	ff 75 08             	pushl  0x8(%ebp)
80100a6e:	e8 36 10 00 00       	call   80101aa9 <ilock>
80100a73:	83 c4 10             	add    $0x10,%esp
        return -1;
80100a76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100a7b:	e9 ab 00 00 00       	jmp    80100b2b <consoleread+0x112>
      }
      sleep(&input.r, &cons.lock);
80100a80:	83 ec 08             	sub    $0x8,%esp
80100a83:	68 a0 b5 10 80       	push   $0x8010b5a0
80100a88:	68 20 10 11 80       	push   $0x80111020
80100a8d:	e8 ba 43 00 00       	call   80104e4c <sleep>
80100a92:	83 c4 10             	add    $0x10,%esp
    while(input.r == input.w){
80100a95:	8b 15 20 10 11 80    	mov    0x80111020,%edx
80100a9b:	a1 24 10 11 80       	mov    0x80111024,%eax
80100aa0:	39 c2                	cmp    %eax,%edx
80100aa2:	74 a8                	je     80100a4c <consoleread+0x33>
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100aa4:	a1 20 10 11 80       	mov    0x80111020,%eax
80100aa9:	8d 50 01             	lea    0x1(%eax),%edx
80100aac:	89 15 20 10 11 80    	mov    %edx,0x80111020
80100ab2:	83 e0 7f             	and    $0x7f,%eax
80100ab5:	0f b6 80 a0 0f 11 80 	movzbl -0x7feef060(%eax),%eax
80100abc:	0f be c0             	movsbl %al,%eax
80100abf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100ac2:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100ac6:	75 17                	jne    80100adf <consoleread+0xc6>
      if(n < target){
80100ac8:	8b 45 10             	mov    0x10(%ebp),%eax
80100acb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100ace:	76 2f                	jbe    80100aff <consoleread+0xe6>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100ad0:	a1 20 10 11 80       	mov    0x80111020,%eax
80100ad5:	83 e8 01             	sub    $0x1,%eax
80100ad8:	a3 20 10 11 80       	mov    %eax,0x80111020
      }
      break;
80100add:	eb 20                	jmp    80100aff <consoleread+0xe6>
    }
    *dst++ = c;
80100adf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ae2:	8d 50 01             	lea    0x1(%eax),%edx
80100ae5:	89 55 0c             	mov    %edx,0xc(%ebp)
80100ae8:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100aeb:	88 10                	mov    %dl,(%eax)
    --n;
80100aed:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100af1:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100af5:	74 0b                	je     80100b02 <consoleread+0xe9>
  while(n > 0){
80100af7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100afb:	7f 98                	jg     80100a95 <consoleread+0x7c>
80100afd:	eb 04                	jmp    80100b03 <consoleread+0xea>
      break;
80100aff:	90                   	nop
80100b00:	eb 01                	jmp    80100b03 <consoleread+0xea>
      break;
80100b02:	90                   	nop
  }
  release(&cons.lock);
80100b03:	83 ec 0c             	sub    $0xc,%esp
80100b06:	68 a0 b5 10 80       	push   $0x8010b5a0
80100b0b:	e8 20 48 00 00       	call   80105330 <release>
80100b10:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100b13:	83 ec 0c             	sub    $0xc,%esp
80100b16:	ff 75 08             	pushl  0x8(%ebp)
80100b19:	e8 8b 0f 00 00       	call   80101aa9 <ilock>
80100b1e:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100b21:	8b 45 10             	mov    0x10(%ebp),%eax
80100b24:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100b27:	29 c2                	sub    %eax,%edx
80100b29:	89 d0                	mov    %edx,%eax
}
80100b2b:	c9                   	leave  
80100b2c:	c3                   	ret    

80100b2d <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100b2d:	f3 0f 1e fb          	endbr32 
80100b31:	55                   	push   %ebp
80100b32:	89 e5                	mov    %esp,%ebp
80100b34:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100b37:	83 ec 0c             	sub    $0xc,%esp
80100b3a:	ff 75 08             	pushl  0x8(%ebp)
80100b3d:	e8 7e 10 00 00       	call   80101bc0 <iunlock>
80100b42:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100b45:	83 ec 0c             	sub    $0xc,%esp
80100b48:	68 a0 b5 10 80       	push   $0x8010b5a0
80100b4d:	e8 6c 47 00 00       	call   801052be <acquire>
80100b52:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100b55:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100b5c:	eb 21                	jmp    80100b7f <consolewrite+0x52>
    consputc(buf[i] & 0xff);
80100b5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100b61:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b64:	01 d0                	add    %edx,%eax
80100b66:	0f b6 00             	movzbl (%eax),%eax
80100b69:	0f be c0             	movsbl %al,%eax
80100b6c:	0f b6 c0             	movzbl %al,%eax
80100b6f:	83 ec 0c             	sub    $0xc,%esp
80100b72:	50                   	push   %eax
80100b73:	e8 8e fc ff ff       	call   80100806 <consputc>
80100b78:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100b7b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100b7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b82:	3b 45 10             	cmp    0x10(%ebp),%eax
80100b85:	7c d7                	jl     80100b5e <consolewrite+0x31>
  release(&cons.lock);
80100b87:	83 ec 0c             	sub    $0xc,%esp
80100b8a:	68 a0 b5 10 80       	push   $0x8010b5a0
80100b8f:	e8 9c 47 00 00       	call   80105330 <release>
80100b94:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100b97:	83 ec 0c             	sub    $0xc,%esp
80100b9a:	ff 75 08             	pushl  0x8(%ebp)
80100b9d:	e8 07 0f 00 00       	call   80101aa9 <ilock>
80100ba2:	83 c4 10             	add    $0x10,%esp

  return n;
80100ba5:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ba8:	c9                   	leave  
80100ba9:	c3                   	ret    

80100baa <consoleinit>:

void
consoleinit(void)
{
80100baa:	f3 0f 1e fb          	endbr32 
80100bae:	55                   	push   %ebp
80100baf:	89 e5                	mov    %esp,%ebp
80100bb1:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100bb4:	83 ec 08             	sub    $0x8,%esp
80100bb7:	68 72 88 10 80       	push   $0x80108872
80100bbc:	68 a0 b5 10 80       	push   $0x8010b5a0
80100bc1:	e8 d2 46 00 00       	call   80105298 <initlock>
80100bc6:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100bc9:	c7 05 ec 19 11 80 2d 	movl   $0x80100b2d,0x801119ec
80100bd0:	0b 10 80 
  devsw[CONSOLE].read = consoleread;
80100bd3:	c7 05 e8 19 11 80 19 	movl   $0x80100a19,0x801119e8
80100bda:	0a 10 80 
  cons.locking = 1;
80100bdd:	c7 05 d4 b5 10 80 01 	movl   $0x1,0x8010b5d4
80100be4:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100be7:	83 ec 08             	sub    $0x8,%esp
80100bea:	6a 00                	push   $0x0
80100bec:	6a 01                	push   $0x1
80100bee:	e8 20 20 00 00       	call   80102c13 <ioapicenable>
80100bf3:	83 c4 10             	add    $0x10,%esp
}
80100bf6:	90                   	nop
80100bf7:	c9                   	leave  
80100bf8:	c3                   	ret    

80100bf9 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100bf9:	f3 0f 1e fb          	endbr32 
80100bfd:	55                   	push   %ebp
80100bfe:	89 e5                	mov    %esp,%ebp
80100c00:	81 ec 18 01 00 00    	sub    $0x118,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100c06:	e8 2c 38 00 00       	call   80104437 <myproc>
80100c0b:	89 45 d0             	mov    %eax,-0x30(%ebp)

  begin_op();
80100c0e:	e8 65 2a 00 00       	call   80103678 <begin_op>

  if((ip = namei(path)) == 0){
80100c13:	83 ec 0c             	sub    $0xc,%esp
80100c16:	ff 75 08             	pushl  0x8(%ebp)
80100c19:	e8 f6 19 00 00       	call   80102614 <namei>
80100c1e:	83 c4 10             	add    $0x10,%esp
80100c21:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100c24:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100c28:	75 1f                	jne    80100c49 <exec+0x50>
    end_op();
80100c2a:	e8 d9 2a 00 00       	call   80103708 <end_op>
    cprintf("exec: fail\n");
80100c2f:	83 ec 0c             	sub    $0xc,%esp
80100c32:	68 7a 88 10 80       	push   $0x8010887a
80100c37:	e8 dc f7 ff ff       	call   80100418 <cprintf>
80100c3c:	83 c4 10             	add    $0x10,%esp
    return -1;
80100c3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c44:	e9 f6 03 00 00       	jmp    8010103f <exec+0x446>
  }
  ilock(ip);
80100c49:	83 ec 0c             	sub    $0xc,%esp
80100c4c:	ff 75 d8             	pushl  -0x28(%ebp)
80100c4f:	e8 55 0e 00 00       	call   80101aa9 <ilock>
80100c54:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100c57:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100c5e:	6a 34                	push   $0x34
80100c60:	6a 00                	push   $0x0
80100c62:	8d 85 08 ff ff ff    	lea    -0xf8(%ebp),%eax
80100c68:	50                   	push   %eax
80100c69:	ff 75 d8             	pushl  -0x28(%ebp)
80100c6c:	e8 40 13 00 00       	call   80101fb1 <readi>
80100c71:	83 c4 10             	add    $0x10,%esp
80100c74:	83 f8 34             	cmp    $0x34,%eax
80100c77:	0f 85 6b 03 00 00    	jne    80100fe8 <exec+0x3ef>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100c7d:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
80100c83:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100c88:	0f 85 5d 03 00 00    	jne    80100feb <exec+0x3f2>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100c8e:	e8 ee 72 00 00       	call   80107f81 <setupkvm>
80100c93:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100c96:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100c9a:	0f 84 4e 03 00 00    	je     80100fee <exec+0x3f5>
    goto bad;

  // Load program into memory.
  sz = PGSIZE;
80100ca0:	c7 45 e0 00 10 00 00 	movl   $0x1000,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ca7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100cae:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
80100cb4:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100cb7:	e9 e3 00 00 00       	jmp    80100d9f <exec+0x1a6>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100cbc:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100cbf:	6a 20                	push   $0x20
80100cc1:	50                   	push   %eax
80100cc2:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
80100cc8:	50                   	push   %eax
80100cc9:	ff 75 d8             	pushl  -0x28(%ebp)
80100ccc:	e8 e0 12 00 00       	call   80101fb1 <readi>
80100cd1:	83 c4 10             	add    $0x10,%esp
80100cd4:	83 f8 20             	cmp    $0x20,%eax
80100cd7:	0f 85 14 03 00 00    	jne    80100ff1 <exec+0x3f8>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100cdd:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
80100ce3:	83 f8 01             	cmp    $0x1,%eax
80100ce6:	0f 85 a5 00 00 00    	jne    80100d91 <exec+0x198>
      continue;
    if(ph.memsz < ph.filesz)
80100cec:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100cf2:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
80100cf8:	39 c2                	cmp    %eax,%edx
80100cfa:	0f 82 f4 02 00 00    	jb     80100ff4 <exec+0x3fb>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100d00:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100d06:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100d0c:	01 c2                	add    %eax,%edx
80100d0e:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d14:	39 c2                	cmp    %eax,%edx
80100d16:	0f 82 db 02 00 00    	jb     80100ff7 <exec+0x3fe>
      goto bad;
    if((sz = allocuvm(pgdir, sz, sz + ph.vaddr + ph.memsz)) == 0)
80100d1c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100d22:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d25:	01 c2                	add    %eax,%edx
80100d27:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100d2d:	01 d0                	add    %edx,%eax
80100d2f:	83 ec 04             	sub    $0x4,%esp
80100d32:	50                   	push   %eax
80100d33:	ff 75 e0             	pushl  -0x20(%ebp)
80100d36:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d39:	e8 01 76 00 00       	call   8010833f <allocuvm>
80100d3e:	83 c4 10             	add    $0x10,%esp
80100d41:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d44:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d48:	0f 84 ac 02 00 00    	je     80100ffa <exec+0x401>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100d4e:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d54:	25 ff 0f 00 00       	and    $0xfff,%eax
80100d59:	85 c0                	test   %eax,%eax
80100d5b:	0f 85 9c 02 00 00    	jne    80100ffd <exec+0x404>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100d61:	8b 95 f8 fe ff ff    	mov    -0x108(%ebp),%edx
80100d67:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100d6d:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100d73:	83 ec 0c             	sub    $0xc,%esp
80100d76:	52                   	push   %edx
80100d77:	50                   	push   %eax
80100d78:	ff 75 d8             	pushl  -0x28(%ebp)
80100d7b:	51                   	push   %ecx
80100d7c:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d7f:	e8 ea 74 00 00       	call   8010826e <loaduvm>
80100d84:	83 c4 20             	add    $0x20,%esp
80100d87:	85 c0                	test   %eax,%eax
80100d89:	0f 88 71 02 00 00    	js     80101000 <exec+0x407>
80100d8f:	eb 01                	jmp    80100d92 <exec+0x199>
      continue;
80100d91:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d92:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100d96:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100d99:	83 c0 20             	add    $0x20,%eax
80100d9c:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100d9f:	0f b7 85 34 ff ff ff 	movzwl -0xcc(%ebp),%eax
80100da6:	0f b7 c0             	movzwl %ax,%eax
80100da9:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80100dac:	0f 8c 0a ff ff ff    	jl     80100cbc <exec+0xc3>
      goto bad;
  }
  iunlockput(ip);
80100db2:	83 ec 0c             	sub    $0xc,%esp
80100db5:	ff 75 d8             	pushl  -0x28(%ebp)
80100db8:	e8 29 0f 00 00       	call   80101ce6 <iunlockput>
80100dbd:	83 c4 10             	add    $0x10,%esp
  end_op();
80100dc0:	e8 43 29 00 00       	call   80103708 <end_op>
  ip = 0;
80100dc5:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100dcc:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100dcf:	05 ff 0f 00 00       	add    $0xfff,%eax
80100dd4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100dd9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ddc:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ddf:	05 00 20 00 00       	add    $0x2000,%eax
80100de4:	83 ec 04             	sub    $0x4,%esp
80100de7:	50                   	push   %eax
80100de8:	ff 75 e0             	pushl  -0x20(%ebp)
80100deb:	ff 75 d4             	pushl  -0x2c(%ebp)
80100dee:	e8 4c 75 00 00       	call   8010833f <allocuvm>
80100df3:	83 c4 10             	add    $0x10,%esp
80100df6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100df9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100dfd:	0f 84 00 02 00 00    	je     80101003 <exec+0x40a>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100e03:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100e06:	2d 00 20 00 00       	sub    $0x2000,%eax
80100e0b:	83 ec 08             	sub    $0x8,%esp
80100e0e:	50                   	push   %eax
80100e0f:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e12:	e8 96 77 00 00       	call   801085ad <clearpteu>
80100e17:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100e1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100e1d:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e20:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100e27:	e9 96 00 00 00       	jmp    80100ec2 <exec+0x2c9>
    if(argc >= MAXARG)
80100e2c:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100e30:	0f 87 d0 01 00 00    	ja     80101006 <exec+0x40d>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e39:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e40:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e43:	01 d0                	add    %edx,%eax
80100e45:	8b 00                	mov    (%eax),%eax
80100e47:	83 ec 0c             	sub    $0xc,%esp
80100e4a:	50                   	push   %eax
80100e4b:	e8 76 49 00 00       	call   801057c6 <strlen>
80100e50:	83 c4 10             	add    $0x10,%esp
80100e53:	89 c2                	mov    %eax,%edx
80100e55:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e58:	29 d0                	sub    %edx,%eax
80100e5a:	83 e8 01             	sub    $0x1,%eax
80100e5d:	83 e0 fc             	and    $0xfffffffc,%eax
80100e60:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e66:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e6d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e70:	01 d0                	add    %edx,%eax
80100e72:	8b 00                	mov    (%eax),%eax
80100e74:	83 ec 0c             	sub    $0xc,%esp
80100e77:	50                   	push   %eax
80100e78:	e8 49 49 00 00       	call   801057c6 <strlen>
80100e7d:	83 c4 10             	add    $0x10,%esp
80100e80:	83 c0 01             	add    $0x1,%eax
80100e83:	89 c1                	mov    %eax,%ecx
80100e85:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e88:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e8f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e92:	01 d0                	add    %edx,%eax
80100e94:	8b 00                	mov    (%eax),%eax
80100e96:	51                   	push   %ecx
80100e97:	50                   	push   %eax
80100e98:	ff 75 dc             	pushl  -0x24(%ebp)
80100e9b:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e9e:	e8 c2 78 00 00       	call   80108765 <copyout>
80100ea3:	83 c4 10             	add    $0x10,%esp
80100ea6:	85 c0                	test   %eax,%eax
80100ea8:	0f 88 5b 01 00 00    	js     80101009 <exec+0x410>
      goto bad;
    ustack[3+argc] = sp;
80100eae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100eb1:	8d 50 03             	lea    0x3(%eax),%edx
80100eb4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100eb7:	89 84 95 3c ff ff ff 	mov    %eax,-0xc4(%ebp,%edx,4)
  for(argc = 0; argv[argc]; argc++) {
80100ebe:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100ec2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ec5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ecf:	01 d0                	add    %edx,%eax
80100ed1:	8b 00                	mov    (%eax),%eax
80100ed3:	85 c0                	test   %eax,%eax
80100ed5:	0f 85 51 ff ff ff    	jne    80100e2c <exec+0x233>
  }
  ustack[3+argc] = 0;
80100edb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ede:	83 c0 03             	add    $0x3,%eax
80100ee1:	c7 84 85 3c ff ff ff 	movl   $0x0,-0xc4(%ebp,%eax,4)
80100ee8:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100eec:	c7 85 3c ff ff ff ff 	movl   $0xffffffff,-0xc4(%ebp)
80100ef3:	ff ff ff 
  ustack[1] = argc;
80100ef6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ef9:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100eff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f02:	83 c0 01             	add    $0x1,%eax
80100f05:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100f0c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100f0f:	29 d0                	sub    %edx,%eax
80100f11:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)

  sp -= (3+argc+1) * 4;
80100f17:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f1a:	83 c0 04             	add    $0x4,%eax
80100f1d:	c1 e0 02             	shl    $0x2,%eax
80100f20:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100f23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f26:	83 c0 04             	add    $0x4,%eax
80100f29:	c1 e0 02             	shl    $0x2,%eax
80100f2c:	50                   	push   %eax
80100f2d:	8d 85 3c ff ff ff    	lea    -0xc4(%ebp),%eax
80100f33:	50                   	push   %eax
80100f34:	ff 75 dc             	pushl  -0x24(%ebp)
80100f37:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f3a:	e8 26 78 00 00       	call   80108765 <copyout>
80100f3f:	83 c4 10             	add    $0x10,%esp
80100f42:	85 c0                	test   %eax,%eax
80100f44:	0f 88 c2 00 00 00    	js     8010100c <exec+0x413>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100f4a:	8b 45 08             	mov    0x8(%ebp),%eax
80100f4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100f50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f53:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100f56:	eb 17                	jmp    80100f6f <exec+0x376>
    if(*s == '/')
80100f58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f5b:	0f b6 00             	movzbl (%eax),%eax
80100f5e:	3c 2f                	cmp    $0x2f,%al
80100f60:	75 09                	jne    80100f6b <exec+0x372>
      last = s+1;
80100f62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f65:	83 c0 01             	add    $0x1,%eax
80100f68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(last=s=path; *s; s++)
80100f6b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100f6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f72:	0f b6 00             	movzbl (%eax),%eax
80100f75:	84 c0                	test   %al,%al
80100f77:	75 df                	jne    80100f58 <exec+0x35f>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100f79:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f7c:	83 c0 6c             	add    $0x6c,%eax
80100f7f:	83 ec 04             	sub    $0x4,%esp
80100f82:	6a 10                	push   $0x10
80100f84:	ff 75 f0             	pushl  -0x10(%ebp)
80100f87:	50                   	push   %eax
80100f88:	e8 eb 47 00 00       	call   80105778 <safestrcpy>
80100f8d:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100f90:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f93:	8b 40 04             	mov    0x4(%eax),%eax
80100f96:	89 45 cc             	mov    %eax,-0x34(%ebp)
  curproc->pgdir = pgdir;
80100f99:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f9c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100f9f:	89 50 04             	mov    %edx,0x4(%eax)
  curproc->sz = sz;
80100fa2:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100fa5:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100fa8:	89 10                	mov    %edx,(%eax)
  curproc->tf->eip = elf.entry;  // main
80100faa:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100fad:	8b 40 18             	mov    0x18(%eax),%eax
80100fb0:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
80100fb6:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100fb9:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100fbc:	8b 40 18             	mov    0x18(%eax),%eax
80100fbf:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100fc2:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(curproc);
80100fc5:	83 ec 0c             	sub    $0xc,%esp
80100fc8:	ff 75 d0             	pushl  -0x30(%ebp)
80100fcb:	e8 87 70 00 00       	call   80108057 <switchuvm>
80100fd0:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100fd3:	83 ec 0c             	sub    $0xc,%esp
80100fd6:	ff 75 cc             	pushl  -0x34(%ebp)
80100fd9:	e8 32 75 00 00       	call   80108510 <freevm>
80100fde:	83 c4 10             	add    $0x10,%esp
  return 0;
80100fe1:	b8 00 00 00 00       	mov    $0x0,%eax
80100fe6:	eb 57                	jmp    8010103f <exec+0x446>
    goto bad;
80100fe8:	90                   	nop
80100fe9:	eb 22                	jmp    8010100d <exec+0x414>
    goto bad;
80100feb:	90                   	nop
80100fec:	eb 1f                	jmp    8010100d <exec+0x414>
    goto bad;
80100fee:	90                   	nop
80100fef:	eb 1c                	jmp    8010100d <exec+0x414>
      goto bad;
80100ff1:	90                   	nop
80100ff2:	eb 19                	jmp    8010100d <exec+0x414>
      goto bad;
80100ff4:	90                   	nop
80100ff5:	eb 16                	jmp    8010100d <exec+0x414>
      goto bad;
80100ff7:	90                   	nop
80100ff8:	eb 13                	jmp    8010100d <exec+0x414>
      goto bad;
80100ffa:	90                   	nop
80100ffb:	eb 10                	jmp    8010100d <exec+0x414>
      goto bad;
80100ffd:	90                   	nop
80100ffe:	eb 0d                	jmp    8010100d <exec+0x414>
      goto bad;
80101000:	90                   	nop
80101001:	eb 0a                	jmp    8010100d <exec+0x414>
    goto bad;
80101003:	90                   	nop
80101004:	eb 07                	jmp    8010100d <exec+0x414>
      goto bad;
80101006:	90                   	nop
80101007:	eb 04                	jmp    8010100d <exec+0x414>
      goto bad;
80101009:	90                   	nop
8010100a:	eb 01                	jmp    8010100d <exec+0x414>
    goto bad;
8010100c:	90                   	nop

 bad:
  if(pgdir)
8010100d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80101011:	74 0e                	je     80101021 <exec+0x428>
    freevm(pgdir);
80101013:	83 ec 0c             	sub    $0xc,%esp
80101016:	ff 75 d4             	pushl  -0x2c(%ebp)
80101019:	e8 f2 74 00 00       	call   80108510 <freevm>
8010101e:	83 c4 10             	add    $0x10,%esp
  if(ip){
80101021:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80101025:	74 13                	je     8010103a <exec+0x441>
    iunlockput(ip);
80101027:	83 ec 0c             	sub    $0xc,%esp
8010102a:	ff 75 d8             	pushl  -0x28(%ebp)
8010102d:	e8 b4 0c 00 00       	call   80101ce6 <iunlockput>
80101032:	83 c4 10             	add    $0x10,%esp
    end_op();
80101035:	e8 ce 26 00 00       	call   80103708 <end_op>
  }
  return -1;
8010103a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010103f:	c9                   	leave  
80101040:	c3                   	ret    

80101041 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101041:	f3 0f 1e fb          	endbr32 
80101045:	55                   	push   %ebp
80101046:	89 e5                	mov    %esp,%ebp
80101048:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
8010104b:	83 ec 08             	sub    $0x8,%esp
8010104e:	68 86 88 10 80       	push   $0x80108886
80101053:	68 40 10 11 80       	push   $0x80111040
80101058:	e8 3b 42 00 00       	call   80105298 <initlock>
8010105d:	83 c4 10             	add    $0x10,%esp
}
80101060:	90                   	nop
80101061:	c9                   	leave  
80101062:	c3                   	ret    

80101063 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101063:	f3 0f 1e fb          	endbr32 
80101067:	55                   	push   %ebp
80101068:	89 e5                	mov    %esp,%ebp
8010106a:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
8010106d:	83 ec 0c             	sub    $0xc,%esp
80101070:	68 40 10 11 80       	push   $0x80111040
80101075:	e8 44 42 00 00       	call   801052be <acquire>
8010107a:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
8010107d:	c7 45 f4 74 10 11 80 	movl   $0x80111074,-0xc(%ebp)
80101084:	eb 2d                	jmp    801010b3 <filealloc+0x50>
    if(f->ref == 0){
80101086:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101089:	8b 40 04             	mov    0x4(%eax),%eax
8010108c:	85 c0                	test   %eax,%eax
8010108e:	75 1f                	jne    801010af <filealloc+0x4c>
      f->ref = 1;
80101090:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101093:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
8010109a:	83 ec 0c             	sub    $0xc,%esp
8010109d:	68 40 10 11 80       	push   $0x80111040
801010a2:	e8 89 42 00 00       	call   80105330 <release>
801010a7:	83 c4 10             	add    $0x10,%esp
      return f;
801010aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801010ad:	eb 23                	jmp    801010d2 <filealloc+0x6f>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801010af:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
801010b3:	b8 d4 19 11 80       	mov    $0x801119d4,%eax
801010b8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801010bb:	72 c9                	jb     80101086 <filealloc+0x23>
    }
  }
  release(&ftable.lock);
801010bd:	83 ec 0c             	sub    $0xc,%esp
801010c0:	68 40 10 11 80       	push   $0x80111040
801010c5:	e8 66 42 00 00       	call   80105330 <release>
801010ca:	83 c4 10             	add    $0x10,%esp
  return 0;
801010cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
801010d2:	c9                   	leave  
801010d3:	c3                   	ret    

801010d4 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
801010d4:	f3 0f 1e fb          	endbr32 
801010d8:	55                   	push   %ebp
801010d9:	89 e5                	mov    %esp,%ebp
801010db:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
801010de:	83 ec 0c             	sub    $0xc,%esp
801010e1:	68 40 10 11 80       	push   $0x80111040
801010e6:	e8 d3 41 00 00       	call   801052be <acquire>
801010eb:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801010ee:	8b 45 08             	mov    0x8(%ebp),%eax
801010f1:	8b 40 04             	mov    0x4(%eax),%eax
801010f4:	85 c0                	test   %eax,%eax
801010f6:	7f 0d                	jg     80101105 <filedup+0x31>
    panic("filedup");
801010f8:	83 ec 0c             	sub    $0xc,%esp
801010fb:	68 8d 88 10 80       	push   $0x8010888d
80101100:	e8 cc f4 ff ff       	call   801005d1 <panic>
  f->ref++;
80101105:	8b 45 08             	mov    0x8(%ebp),%eax
80101108:	8b 40 04             	mov    0x4(%eax),%eax
8010110b:	8d 50 01             	lea    0x1(%eax),%edx
8010110e:	8b 45 08             	mov    0x8(%ebp),%eax
80101111:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80101114:	83 ec 0c             	sub    $0xc,%esp
80101117:	68 40 10 11 80       	push   $0x80111040
8010111c:	e8 0f 42 00 00       	call   80105330 <release>
80101121:	83 c4 10             	add    $0x10,%esp
  return f;
80101124:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101127:	c9                   	leave  
80101128:	c3                   	ret    

80101129 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101129:	f3 0f 1e fb          	endbr32 
8010112d:	55                   	push   %ebp
8010112e:	89 e5                	mov    %esp,%ebp
80101130:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
80101133:	83 ec 0c             	sub    $0xc,%esp
80101136:	68 40 10 11 80       	push   $0x80111040
8010113b:	e8 7e 41 00 00       	call   801052be <acquire>
80101140:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101143:	8b 45 08             	mov    0x8(%ebp),%eax
80101146:	8b 40 04             	mov    0x4(%eax),%eax
80101149:	85 c0                	test   %eax,%eax
8010114b:	7f 0d                	jg     8010115a <fileclose+0x31>
    panic("fileclose");
8010114d:	83 ec 0c             	sub    $0xc,%esp
80101150:	68 95 88 10 80       	push   $0x80108895
80101155:	e8 77 f4 ff ff       	call   801005d1 <panic>
  if(--f->ref > 0){
8010115a:	8b 45 08             	mov    0x8(%ebp),%eax
8010115d:	8b 40 04             	mov    0x4(%eax),%eax
80101160:	8d 50 ff             	lea    -0x1(%eax),%edx
80101163:	8b 45 08             	mov    0x8(%ebp),%eax
80101166:	89 50 04             	mov    %edx,0x4(%eax)
80101169:	8b 45 08             	mov    0x8(%ebp),%eax
8010116c:	8b 40 04             	mov    0x4(%eax),%eax
8010116f:	85 c0                	test   %eax,%eax
80101171:	7e 15                	jle    80101188 <fileclose+0x5f>
    release(&ftable.lock);
80101173:	83 ec 0c             	sub    $0xc,%esp
80101176:	68 40 10 11 80       	push   $0x80111040
8010117b:	e8 b0 41 00 00       	call   80105330 <release>
80101180:	83 c4 10             	add    $0x10,%esp
80101183:	e9 8b 00 00 00       	jmp    80101213 <fileclose+0xea>
    return;
  }
  ff = *f;
80101188:	8b 45 08             	mov    0x8(%ebp),%eax
8010118b:	8b 10                	mov    (%eax),%edx
8010118d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101190:	8b 50 04             	mov    0x4(%eax),%edx
80101193:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101196:	8b 50 08             	mov    0x8(%eax),%edx
80101199:	89 55 e8             	mov    %edx,-0x18(%ebp)
8010119c:	8b 50 0c             	mov    0xc(%eax),%edx
8010119f:	89 55 ec             	mov    %edx,-0x14(%ebp)
801011a2:	8b 50 10             	mov    0x10(%eax),%edx
801011a5:	89 55 f0             	mov    %edx,-0x10(%ebp)
801011a8:	8b 40 14             	mov    0x14(%eax),%eax
801011ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
801011ae:	8b 45 08             	mov    0x8(%ebp),%eax
801011b1:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
801011b8:	8b 45 08             	mov    0x8(%ebp),%eax
801011bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
801011c1:	83 ec 0c             	sub    $0xc,%esp
801011c4:	68 40 10 11 80       	push   $0x80111040
801011c9:	e8 62 41 00 00       	call   80105330 <release>
801011ce:	83 c4 10             	add    $0x10,%esp

  if(ff.type == FD_PIPE)
801011d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011d4:	83 f8 01             	cmp    $0x1,%eax
801011d7:	75 19                	jne    801011f2 <fileclose+0xc9>
    pipeclose(ff.pipe, ff.writable);
801011d9:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
801011dd:	0f be d0             	movsbl %al,%edx
801011e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801011e3:	83 ec 08             	sub    $0x8,%esp
801011e6:	52                   	push   %edx
801011e7:	50                   	push   %eax
801011e8:	e8 c1 2e 00 00       	call   801040ae <pipeclose>
801011ed:	83 c4 10             	add    $0x10,%esp
801011f0:	eb 21                	jmp    80101213 <fileclose+0xea>
  else if(ff.type == FD_INODE){
801011f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011f5:	83 f8 02             	cmp    $0x2,%eax
801011f8:	75 19                	jne    80101213 <fileclose+0xea>
    begin_op();
801011fa:	e8 79 24 00 00       	call   80103678 <begin_op>
    iput(ff.ip);
801011ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101202:	83 ec 0c             	sub    $0xc,%esp
80101205:	50                   	push   %eax
80101206:	e8 07 0a 00 00       	call   80101c12 <iput>
8010120b:	83 c4 10             	add    $0x10,%esp
    end_op();
8010120e:	e8 f5 24 00 00       	call   80103708 <end_op>
  }
}
80101213:	c9                   	leave  
80101214:	c3                   	ret    

80101215 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101215:	f3 0f 1e fb          	endbr32 
80101219:	55                   	push   %ebp
8010121a:	89 e5                	mov    %esp,%ebp
8010121c:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
8010121f:	8b 45 08             	mov    0x8(%ebp),%eax
80101222:	8b 00                	mov    (%eax),%eax
80101224:	83 f8 02             	cmp    $0x2,%eax
80101227:	75 40                	jne    80101269 <filestat+0x54>
    ilock(f->ip);
80101229:	8b 45 08             	mov    0x8(%ebp),%eax
8010122c:	8b 40 10             	mov    0x10(%eax),%eax
8010122f:	83 ec 0c             	sub    $0xc,%esp
80101232:	50                   	push   %eax
80101233:	e8 71 08 00 00       	call   80101aa9 <ilock>
80101238:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
8010123b:	8b 45 08             	mov    0x8(%ebp),%eax
8010123e:	8b 40 10             	mov    0x10(%eax),%eax
80101241:	83 ec 08             	sub    $0x8,%esp
80101244:	ff 75 0c             	pushl  0xc(%ebp)
80101247:	50                   	push   %eax
80101248:	e8 1a 0d 00 00       	call   80101f67 <stati>
8010124d:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
80101250:	8b 45 08             	mov    0x8(%ebp),%eax
80101253:	8b 40 10             	mov    0x10(%eax),%eax
80101256:	83 ec 0c             	sub    $0xc,%esp
80101259:	50                   	push   %eax
8010125a:	e8 61 09 00 00       	call   80101bc0 <iunlock>
8010125f:	83 c4 10             	add    $0x10,%esp
    return 0;
80101262:	b8 00 00 00 00       	mov    $0x0,%eax
80101267:	eb 05                	jmp    8010126e <filestat+0x59>
  }
  return -1;
80101269:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010126e:	c9                   	leave  
8010126f:	c3                   	ret    

80101270 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101270:	f3 0f 1e fb          	endbr32 
80101274:	55                   	push   %ebp
80101275:	89 e5                	mov    %esp,%ebp
80101277:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
8010127a:	8b 45 08             	mov    0x8(%ebp),%eax
8010127d:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101281:	84 c0                	test   %al,%al
80101283:	75 0a                	jne    8010128f <fileread+0x1f>
    return -1;
80101285:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010128a:	e9 9b 00 00 00       	jmp    8010132a <fileread+0xba>
  if(f->type == FD_PIPE)
8010128f:	8b 45 08             	mov    0x8(%ebp),%eax
80101292:	8b 00                	mov    (%eax),%eax
80101294:	83 f8 01             	cmp    $0x1,%eax
80101297:	75 1a                	jne    801012b3 <fileread+0x43>
    return piperead(f->pipe, addr, n);
80101299:	8b 45 08             	mov    0x8(%ebp),%eax
8010129c:	8b 40 0c             	mov    0xc(%eax),%eax
8010129f:	83 ec 04             	sub    $0x4,%esp
801012a2:	ff 75 10             	pushl  0x10(%ebp)
801012a5:	ff 75 0c             	pushl  0xc(%ebp)
801012a8:	50                   	push   %eax
801012a9:	e8 b5 2f 00 00       	call   80104263 <piperead>
801012ae:	83 c4 10             	add    $0x10,%esp
801012b1:	eb 77                	jmp    8010132a <fileread+0xba>
  if(f->type == FD_INODE){
801012b3:	8b 45 08             	mov    0x8(%ebp),%eax
801012b6:	8b 00                	mov    (%eax),%eax
801012b8:	83 f8 02             	cmp    $0x2,%eax
801012bb:	75 60                	jne    8010131d <fileread+0xad>
    ilock(f->ip);
801012bd:	8b 45 08             	mov    0x8(%ebp),%eax
801012c0:	8b 40 10             	mov    0x10(%eax),%eax
801012c3:	83 ec 0c             	sub    $0xc,%esp
801012c6:	50                   	push   %eax
801012c7:	e8 dd 07 00 00       	call   80101aa9 <ilock>
801012cc:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801012cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
801012d2:	8b 45 08             	mov    0x8(%ebp),%eax
801012d5:	8b 50 14             	mov    0x14(%eax),%edx
801012d8:	8b 45 08             	mov    0x8(%ebp),%eax
801012db:	8b 40 10             	mov    0x10(%eax),%eax
801012de:	51                   	push   %ecx
801012df:	52                   	push   %edx
801012e0:	ff 75 0c             	pushl  0xc(%ebp)
801012e3:	50                   	push   %eax
801012e4:	e8 c8 0c 00 00       	call   80101fb1 <readi>
801012e9:	83 c4 10             	add    $0x10,%esp
801012ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
801012ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801012f3:	7e 11                	jle    80101306 <fileread+0x96>
      f->off += r;
801012f5:	8b 45 08             	mov    0x8(%ebp),%eax
801012f8:	8b 50 14             	mov    0x14(%eax),%edx
801012fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012fe:	01 c2                	add    %eax,%edx
80101300:	8b 45 08             	mov    0x8(%ebp),%eax
80101303:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101306:	8b 45 08             	mov    0x8(%ebp),%eax
80101309:	8b 40 10             	mov    0x10(%eax),%eax
8010130c:	83 ec 0c             	sub    $0xc,%esp
8010130f:	50                   	push   %eax
80101310:	e8 ab 08 00 00       	call   80101bc0 <iunlock>
80101315:	83 c4 10             	add    $0x10,%esp
    return r;
80101318:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010131b:	eb 0d                	jmp    8010132a <fileread+0xba>
  }
  panic("fileread");
8010131d:	83 ec 0c             	sub    $0xc,%esp
80101320:	68 9f 88 10 80       	push   $0x8010889f
80101325:	e8 a7 f2 ff ff       	call   801005d1 <panic>
}
8010132a:	c9                   	leave  
8010132b:	c3                   	ret    

8010132c <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
8010132c:	f3 0f 1e fb          	endbr32 
80101330:	55                   	push   %ebp
80101331:	89 e5                	mov    %esp,%ebp
80101333:	53                   	push   %ebx
80101334:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
80101337:	8b 45 08             	mov    0x8(%ebp),%eax
8010133a:	0f b6 40 09          	movzbl 0x9(%eax),%eax
8010133e:	84 c0                	test   %al,%al
80101340:	75 0a                	jne    8010134c <filewrite+0x20>
    return -1;
80101342:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101347:	e9 1b 01 00 00       	jmp    80101467 <filewrite+0x13b>
  if(f->type == FD_PIPE)
8010134c:	8b 45 08             	mov    0x8(%ebp),%eax
8010134f:	8b 00                	mov    (%eax),%eax
80101351:	83 f8 01             	cmp    $0x1,%eax
80101354:	75 1d                	jne    80101373 <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
80101356:	8b 45 08             	mov    0x8(%ebp),%eax
80101359:	8b 40 0c             	mov    0xc(%eax),%eax
8010135c:	83 ec 04             	sub    $0x4,%esp
8010135f:	ff 75 10             	pushl  0x10(%ebp)
80101362:	ff 75 0c             	pushl  0xc(%ebp)
80101365:	50                   	push   %eax
80101366:	e8 f2 2d 00 00       	call   8010415d <pipewrite>
8010136b:	83 c4 10             	add    $0x10,%esp
8010136e:	e9 f4 00 00 00       	jmp    80101467 <filewrite+0x13b>
  if(f->type == FD_INODE){
80101373:	8b 45 08             	mov    0x8(%ebp),%eax
80101376:	8b 00                	mov    (%eax),%eax
80101378:	83 f8 02             	cmp    $0x2,%eax
8010137b:	0f 85 d9 00 00 00    	jne    8010145a <filewrite+0x12e>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
80101381:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
80101388:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
8010138f:	e9 a3 00 00 00       	jmp    80101437 <filewrite+0x10b>
      int n1 = n - i;
80101394:	8b 45 10             	mov    0x10(%ebp),%eax
80101397:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010139a:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
8010139d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801013a0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801013a3:	7e 06                	jle    801013ab <filewrite+0x7f>
        n1 = max;
801013a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801013a8:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
801013ab:	e8 c8 22 00 00       	call   80103678 <begin_op>
      ilock(f->ip);
801013b0:	8b 45 08             	mov    0x8(%ebp),%eax
801013b3:	8b 40 10             	mov    0x10(%eax),%eax
801013b6:	83 ec 0c             	sub    $0xc,%esp
801013b9:	50                   	push   %eax
801013ba:	e8 ea 06 00 00       	call   80101aa9 <ilock>
801013bf:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801013c2:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801013c5:	8b 45 08             	mov    0x8(%ebp),%eax
801013c8:	8b 50 14             	mov    0x14(%eax),%edx
801013cb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801013ce:	8b 45 0c             	mov    0xc(%ebp),%eax
801013d1:	01 c3                	add    %eax,%ebx
801013d3:	8b 45 08             	mov    0x8(%ebp),%eax
801013d6:	8b 40 10             	mov    0x10(%eax),%eax
801013d9:	51                   	push   %ecx
801013da:	52                   	push   %edx
801013db:	53                   	push   %ebx
801013dc:	50                   	push   %eax
801013dd:	e8 28 0d 00 00       	call   8010210a <writei>
801013e2:	83 c4 10             	add    $0x10,%esp
801013e5:	89 45 e8             	mov    %eax,-0x18(%ebp)
801013e8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801013ec:	7e 11                	jle    801013ff <filewrite+0xd3>
        f->off += r;
801013ee:	8b 45 08             	mov    0x8(%ebp),%eax
801013f1:	8b 50 14             	mov    0x14(%eax),%edx
801013f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
801013f7:	01 c2                	add    %eax,%edx
801013f9:	8b 45 08             	mov    0x8(%ebp),%eax
801013fc:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801013ff:	8b 45 08             	mov    0x8(%ebp),%eax
80101402:	8b 40 10             	mov    0x10(%eax),%eax
80101405:	83 ec 0c             	sub    $0xc,%esp
80101408:	50                   	push   %eax
80101409:	e8 b2 07 00 00       	call   80101bc0 <iunlock>
8010140e:	83 c4 10             	add    $0x10,%esp
      end_op();
80101411:	e8 f2 22 00 00       	call   80103708 <end_op>

      if(r < 0)
80101416:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010141a:	78 29                	js     80101445 <filewrite+0x119>
        break;
      if(r != n1)
8010141c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010141f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80101422:	74 0d                	je     80101431 <filewrite+0x105>
        panic("short filewrite");
80101424:	83 ec 0c             	sub    $0xc,%esp
80101427:	68 a8 88 10 80       	push   $0x801088a8
8010142c:	e8 a0 f1 ff ff       	call   801005d1 <panic>
      i += r;
80101431:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101434:	01 45 f4             	add    %eax,-0xc(%ebp)
    while(i < n){
80101437:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010143a:	3b 45 10             	cmp    0x10(%ebp),%eax
8010143d:	0f 8c 51 ff ff ff    	jl     80101394 <filewrite+0x68>
80101443:	eb 01                	jmp    80101446 <filewrite+0x11a>
        break;
80101445:	90                   	nop
    }
    return i == n ? n : -1;
80101446:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101449:	3b 45 10             	cmp    0x10(%ebp),%eax
8010144c:	75 05                	jne    80101453 <filewrite+0x127>
8010144e:	8b 45 10             	mov    0x10(%ebp),%eax
80101451:	eb 14                	jmp    80101467 <filewrite+0x13b>
80101453:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101458:	eb 0d                	jmp    80101467 <filewrite+0x13b>
  }
  panic("filewrite");
8010145a:	83 ec 0c             	sub    $0xc,%esp
8010145d:	68 b8 88 10 80       	push   $0x801088b8
80101462:	e8 6a f1 ff ff       	call   801005d1 <panic>
}
80101467:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010146a:	c9                   	leave  
8010146b:	c3                   	ret    

8010146c <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
8010146c:	f3 0f 1e fb          	endbr32 
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
80101476:	8b 45 08             	mov    0x8(%ebp),%eax
80101479:	83 ec 08             	sub    $0x8,%esp
8010147c:	6a 01                	push   $0x1
8010147e:	50                   	push   %eax
8010147f:	e8 53 ed ff ff       	call   801001d7 <bread>
80101484:	83 c4 10             	add    $0x10,%esp
80101487:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
8010148a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010148d:	83 c0 5c             	add    $0x5c,%eax
80101490:	83 ec 04             	sub    $0x4,%esp
80101493:	6a 1c                	push   $0x1c
80101495:	50                   	push   %eax
80101496:	ff 75 0c             	pushl  0xc(%ebp)
80101499:	e8 86 41 00 00       	call   80105624 <memmove>
8010149e:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801014a1:	83 ec 0c             	sub    $0xc,%esp
801014a4:	ff 75 f4             	pushl  -0xc(%ebp)
801014a7:	e8 b5 ed ff ff       	call   80100261 <brelse>
801014ac:	83 c4 10             	add    $0x10,%esp
}
801014af:	90                   	nop
801014b0:	c9                   	leave  
801014b1:	c3                   	ret    

801014b2 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
801014b2:	f3 0f 1e fb          	endbr32 
801014b6:	55                   	push   %ebp
801014b7:	89 e5                	mov    %esp,%ebp
801014b9:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, bno);
801014bc:	8b 55 0c             	mov    0xc(%ebp),%edx
801014bf:	8b 45 08             	mov    0x8(%ebp),%eax
801014c2:	83 ec 08             	sub    $0x8,%esp
801014c5:	52                   	push   %edx
801014c6:	50                   	push   %eax
801014c7:	e8 0b ed ff ff       	call   801001d7 <bread>
801014cc:	83 c4 10             	add    $0x10,%esp
801014cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801014d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014d5:	83 c0 5c             	add    $0x5c,%eax
801014d8:	83 ec 04             	sub    $0x4,%esp
801014db:	68 00 02 00 00       	push   $0x200
801014e0:	6a 00                	push   $0x0
801014e2:	50                   	push   %eax
801014e3:	e8 75 40 00 00       	call   8010555d <memset>
801014e8:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801014eb:	83 ec 0c             	sub    $0xc,%esp
801014ee:	ff 75 f4             	pushl  -0xc(%ebp)
801014f1:	e8 cb 23 00 00       	call   801038c1 <log_write>
801014f6:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801014f9:	83 ec 0c             	sub    $0xc,%esp
801014fc:	ff 75 f4             	pushl  -0xc(%ebp)
801014ff:	e8 5d ed ff ff       	call   80100261 <brelse>
80101504:	83 c4 10             	add    $0x10,%esp
}
80101507:	90                   	nop
80101508:	c9                   	leave  
80101509:	c3                   	ret    

8010150a <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010150a:	f3 0f 1e fb          	endbr32 
8010150e:	55                   	push   %ebp
8010150f:	89 e5                	mov    %esp,%ebp
80101511:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
80101514:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010151b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101522:	e9 13 01 00 00       	jmp    8010163a <balloc+0x130>
    bp = bread(dev, BBLOCK(b, sb));
80101527:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010152a:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80101530:	85 c0                	test   %eax,%eax
80101532:	0f 48 c2             	cmovs  %edx,%eax
80101535:	c1 f8 0c             	sar    $0xc,%eax
80101538:	89 c2                	mov    %eax,%edx
8010153a:	a1 58 1a 11 80       	mov    0x80111a58,%eax
8010153f:	01 d0                	add    %edx,%eax
80101541:	83 ec 08             	sub    $0x8,%esp
80101544:	50                   	push   %eax
80101545:	ff 75 08             	pushl  0x8(%ebp)
80101548:	e8 8a ec ff ff       	call   801001d7 <bread>
8010154d:	83 c4 10             	add    $0x10,%esp
80101550:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101553:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010155a:	e9 a6 00 00 00       	jmp    80101605 <balloc+0xfb>
      m = 1 << (bi % 8);
8010155f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101562:	99                   	cltd   
80101563:	c1 ea 1d             	shr    $0x1d,%edx
80101566:	01 d0                	add    %edx,%eax
80101568:	83 e0 07             	and    $0x7,%eax
8010156b:	29 d0                	sub    %edx,%eax
8010156d:	ba 01 00 00 00       	mov    $0x1,%edx
80101572:	89 c1                	mov    %eax,%ecx
80101574:	d3 e2                	shl    %cl,%edx
80101576:	89 d0                	mov    %edx,%eax
80101578:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010157b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010157e:	8d 50 07             	lea    0x7(%eax),%edx
80101581:	85 c0                	test   %eax,%eax
80101583:	0f 48 c2             	cmovs  %edx,%eax
80101586:	c1 f8 03             	sar    $0x3,%eax
80101589:	89 c2                	mov    %eax,%edx
8010158b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010158e:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
80101593:	0f b6 c0             	movzbl %al,%eax
80101596:	23 45 e8             	and    -0x18(%ebp),%eax
80101599:	85 c0                	test   %eax,%eax
8010159b:	75 64                	jne    80101601 <balloc+0xf7>
        bp->data[bi/8] |= m;  // Mark block in use.
8010159d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015a0:	8d 50 07             	lea    0x7(%eax),%edx
801015a3:	85 c0                	test   %eax,%eax
801015a5:	0f 48 c2             	cmovs  %edx,%eax
801015a8:	c1 f8 03             	sar    $0x3,%eax
801015ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
801015ae:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
801015b3:	89 d1                	mov    %edx,%ecx
801015b5:	8b 55 e8             	mov    -0x18(%ebp),%edx
801015b8:	09 ca                	or     %ecx,%edx
801015ba:	89 d1                	mov    %edx,%ecx
801015bc:	8b 55 ec             	mov    -0x14(%ebp),%edx
801015bf:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
        log_write(bp);
801015c3:	83 ec 0c             	sub    $0xc,%esp
801015c6:	ff 75 ec             	pushl  -0x14(%ebp)
801015c9:	e8 f3 22 00 00       	call   801038c1 <log_write>
801015ce:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801015d1:	83 ec 0c             	sub    $0xc,%esp
801015d4:	ff 75 ec             	pushl  -0x14(%ebp)
801015d7:	e8 85 ec ff ff       	call   80100261 <brelse>
801015dc:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801015df:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015e5:	01 c2                	add    %eax,%edx
801015e7:	8b 45 08             	mov    0x8(%ebp),%eax
801015ea:	83 ec 08             	sub    $0x8,%esp
801015ed:	52                   	push   %edx
801015ee:	50                   	push   %eax
801015ef:	e8 be fe ff ff       	call   801014b2 <bzero>
801015f4:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801015f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015fd:	01 d0                	add    %edx,%eax
801015ff:	eb 57                	jmp    80101658 <balloc+0x14e>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101601:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101605:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
8010160c:	7f 17                	jg     80101625 <balloc+0x11b>
8010160e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101611:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101614:	01 d0                	add    %edx,%eax
80101616:	89 c2                	mov    %eax,%edx
80101618:	a1 40 1a 11 80       	mov    0x80111a40,%eax
8010161d:	39 c2                	cmp    %eax,%edx
8010161f:	0f 82 3a ff ff ff    	jb     8010155f <balloc+0x55>
      }
    }
    brelse(bp);
80101625:	83 ec 0c             	sub    $0xc,%esp
80101628:	ff 75 ec             	pushl  -0x14(%ebp)
8010162b:	e8 31 ec ff ff       	call   80100261 <brelse>
80101630:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
80101633:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010163a:	8b 15 40 1a 11 80    	mov    0x80111a40,%edx
80101640:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101643:	39 c2                	cmp    %eax,%edx
80101645:	0f 87 dc fe ff ff    	ja     80101527 <balloc+0x1d>
  }
  panic("balloc: out of blocks");
8010164b:	83 ec 0c             	sub    $0xc,%esp
8010164e:	68 c4 88 10 80       	push   $0x801088c4
80101653:	e8 79 ef ff ff       	call   801005d1 <panic>
}
80101658:	c9                   	leave  
80101659:	c3                   	ret    

8010165a <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
8010165a:	f3 0f 1e fb          	endbr32 
8010165e:	55                   	push   %ebp
8010165f:	89 e5                	mov    %esp,%ebp
80101661:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101664:	8b 45 0c             	mov    0xc(%ebp),%eax
80101667:	c1 e8 0c             	shr    $0xc,%eax
8010166a:	89 c2                	mov    %eax,%edx
8010166c:	a1 58 1a 11 80       	mov    0x80111a58,%eax
80101671:	01 c2                	add    %eax,%edx
80101673:	8b 45 08             	mov    0x8(%ebp),%eax
80101676:	83 ec 08             	sub    $0x8,%esp
80101679:	52                   	push   %edx
8010167a:	50                   	push   %eax
8010167b:	e8 57 eb ff ff       	call   801001d7 <bread>
80101680:	83 c4 10             	add    $0x10,%esp
80101683:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101686:	8b 45 0c             	mov    0xc(%ebp),%eax
80101689:	25 ff 0f 00 00       	and    $0xfff,%eax
8010168e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101691:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101694:	99                   	cltd   
80101695:	c1 ea 1d             	shr    $0x1d,%edx
80101698:	01 d0                	add    %edx,%eax
8010169a:	83 e0 07             	and    $0x7,%eax
8010169d:	29 d0                	sub    %edx,%eax
8010169f:	ba 01 00 00 00       	mov    $0x1,%edx
801016a4:	89 c1                	mov    %eax,%ecx
801016a6:	d3 e2                	shl    %cl,%edx
801016a8:	89 d0                	mov    %edx,%eax
801016aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
801016ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016b0:	8d 50 07             	lea    0x7(%eax),%edx
801016b3:	85 c0                	test   %eax,%eax
801016b5:	0f 48 c2             	cmovs  %edx,%eax
801016b8:	c1 f8 03             	sar    $0x3,%eax
801016bb:	89 c2                	mov    %eax,%edx
801016bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016c0:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
801016c5:	0f b6 c0             	movzbl %al,%eax
801016c8:	23 45 ec             	and    -0x14(%ebp),%eax
801016cb:	85 c0                	test   %eax,%eax
801016cd:	75 0d                	jne    801016dc <bfree+0x82>
    panic("freeing free block");
801016cf:	83 ec 0c             	sub    $0xc,%esp
801016d2:	68 da 88 10 80       	push   $0x801088da
801016d7:	e8 f5 ee ff ff       	call   801005d1 <panic>
  bp->data[bi/8] &= ~m;
801016dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016df:	8d 50 07             	lea    0x7(%eax),%edx
801016e2:	85 c0                	test   %eax,%eax
801016e4:	0f 48 c2             	cmovs  %edx,%eax
801016e7:	c1 f8 03             	sar    $0x3,%eax
801016ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
801016ed:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
801016f2:	89 d1                	mov    %edx,%ecx
801016f4:	8b 55 ec             	mov    -0x14(%ebp),%edx
801016f7:	f7 d2                	not    %edx
801016f9:	21 ca                	and    %ecx,%edx
801016fb:	89 d1                	mov    %edx,%ecx
801016fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101700:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
  log_write(bp);
80101704:	83 ec 0c             	sub    $0xc,%esp
80101707:	ff 75 f4             	pushl  -0xc(%ebp)
8010170a:	e8 b2 21 00 00       	call   801038c1 <log_write>
8010170f:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101712:	83 ec 0c             	sub    $0xc,%esp
80101715:	ff 75 f4             	pushl  -0xc(%ebp)
80101718:	e8 44 eb ff ff       	call   80100261 <brelse>
8010171d:	83 c4 10             	add    $0x10,%esp
}
80101720:	90                   	nop
80101721:	c9                   	leave  
80101722:	c3                   	ret    

80101723 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101723:	f3 0f 1e fb          	endbr32 
80101727:	55                   	push   %ebp
80101728:	89 e5                	mov    %esp,%ebp
8010172a:	57                   	push   %edi
8010172b:	56                   	push   %esi
8010172c:	53                   	push   %ebx
8010172d:	83 ec 2c             	sub    $0x2c,%esp
  int i = 0;
80101730:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  
  initlock(&icache.lock, "icache");
80101737:	83 ec 08             	sub    $0x8,%esp
8010173a:	68 ed 88 10 80       	push   $0x801088ed
8010173f:	68 60 1a 11 80       	push   $0x80111a60
80101744:	e8 4f 3b 00 00       	call   80105298 <initlock>
80101749:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
8010174c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101753:	eb 2d                	jmp    80101782 <iinit+0x5f>
    initsleeplock(&icache.inode[i].lock, "inode");
80101755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101758:	89 d0                	mov    %edx,%eax
8010175a:	c1 e0 03             	shl    $0x3,%eax
8010175d:	01 d0                	add    %edx,%eax
8010175f:	c1 e0 04             	shl    $0x4,%eax
80101762:	83 c0 30             	add    $0x30,%eax
80101765:	05 60 1a 11 80       	add    $0x80111a60,%eax
8010176a:	83 c0 10             	add    $0x10,%eax
8010176d:	83 ec 08             	sub    $0x8,%esp
80101770:	68 f4 88 10 80       	push   $0x801088f4
80101775:	50                   	push   %eax
80101776:	e8 8a 39 00 00       	call   80105105 <initsleeplock>
8010177b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
8010177e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80101782:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
80101786:	7e cd                	jle    80101755 <iinit+0x32>
  }

  readsb(dev, &sb);
80101788:	83 ec 08             	sub    $0x8,%esp
8010178b:	68 40 1a 11 80       	push   $0x80111a40
80101790:	ff 75 08             	pushl  0x8(%ebp)
80101793:	e8 d4 fc ff ff       	call   8010146c <readsb>
80101798:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010179b:	a1 58 1a 11 80       	mov    0x80111a58,%eax
801017a0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801017a3:	8b 3d 54 1a 11 80    	mov    0x80111a54,%edi
801017a9:	8b 35 50 1a 11 80    	mov    0x80111a50,%esi
801017af:	8b 1d 4c 1a 11 80    	mov    0x80111a4c,%ebx
801017b5:	8b 0d 48 1a 11 80    	mov    0x80111a48,%ecx
801017bb:	8b 15 44 1a 11 80    	mov    0x80111a44,%edx
801017c1:	a1 40 1a 11 80       	mov    0x80111a40,%eax
801017c6:	ff 75 d4             	pushl  -0x2c(%ebp)
801017c9:	57                   	push   %edi
801017ca:	56                   	push   %esi
801017cb:	53                   	push   %ebx
801017cc:	51                   	push   %ecx
801017cd:	52                   	push   %edx
801017ce:	50                   	push   %eax
801017cf:	68 fc 88 10 80       	push   $0x801088fc
801017d4:	e8 3f ec ff ff       	call   80100418 <cprintf>
801017d9:	83 c4 20             	add    $0x20,%esp
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801017dc:	90                   	nop
801017dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017e0:	5b                   	pop    %ebx
801017e1:	5e                   	pop    %esi
801017e2:	5f                   	pop    %edi
801017e3:	5d                   	pop    %ebp
801017e4:	c3                   	ret    

801017e5 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801017e5:	f3 0f 1e fb          	endbr32 
801017e9:	55                   	push   %ebp
801017ea:	89 e5                	mov    %esp,%ebp
801017ec:	83 ec 28             	sub    $0x28,%esp
801017ef:	8b 45 0c             	mov    0xc(%ebp),%eax
801017f2:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801017f6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801017fd:	e9 9e 00 00 00       	jmp    801018a0 <ialloc+0xbb>
    bp = bread(dev, IBLOCK(inum, sb));
80101802:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101805:	c1 e8 03             	shr    $0x3,%eax
80101808:	89 c2                	mov    %eax,%edx
8010180a:	a1 54 1a 11 80       	mov    0x80111a54,%eax
8010180f:	01 d0                	add    %edx,%eax
80101811:	83 ec 08             	sub    $0x8,%esp
80101814:	50                   	push   %eax
80101815:	ff 75 08             	pushl  0x8(%ebp)
80101818:	e8 ba e9 ff ff       	call   801001d7 <bread>
8010181d:	83 c4 10             	add    $0x10,%esp
80101820:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101823:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101826:	8d 50 5c             	lea    0x5c(%eax),%edx
80101829:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010182c:	83 e0 07             	and    $0x7,%eax
8010182f:	c1 e0 06             	shl    $0x6,%eax
80101832:	01 d0                	add    %edx,%eax
80101834:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101837:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010183a:	0f b7 00             	movzwl (%eax),%eax
8010183d:	66 85 c0             	test   %ax,%ax
80101840:	75 4c                	jne    8010188e <ialloc+0xa9>
      memset(dip, 0, sizeof(*dip));
80101842:	83 ec 04             	sub    $0x4,%esp
80101845:	6a 40                	push   $0x40
80101847:	6a 00                	push   $0x0
80101849:	ff 75 ec             	pushl  -0x14(%ebp)
8010184c:	e8 0c 3d 00 00       	call   8010555d <memset>
80101851:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
80101854:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101857:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
8010185b:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
8010185e:	83 ec 0c             	sub    $0xc,%esp
80101861:	ff 75 f0             	pushl  -0x10(%ebp)
80101864:	e8 58 20 00 00       	call   801038c1 <log_write>
80101869:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
8010186c:	83 ec 0c             	sub    $0xc,%esp
8010186f:	ff 75 f0             	pushl  -0x10(%ebp)
80101872:	e8 ea e9 ff ff       	call   80100261 <brelse>
80101877:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
8010187a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010187d:	83 ec 08             	sub    $0x8,%esp
80101880:	50                   	push   %eax
80101881:	ff 75 08             	pushl  0x8(%ebp)
80101884:	e8 fc 00 00 00       	call   80101985 <iget>
80101889:	83 c4 10             	add    $0x10,%esp
8010188c:	eb 30                	jmp    801018be <ialloc+0xd9>
    }
    brelse(bp);
8010188e:	83 ec 0c             	sub    $0xc,%esp
80101891:	ff 75 f0             	pushl  -0x10(%ebp)
80101894:	e8 c8 e9 ff ff       	call   80100261 <brelse>
80101899:	83 c4 10             	add    $0x10,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
8010189c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801018a0:	8b 15 48 1a 11 80    	mov    0x80111a48,%edx
801018a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a9:	39 c2                	cmp    %eax,%edx
801018ab:	0f 87 51 ff ff ff    	ja     80101802 <ialloc+0x1d>
  }
  panic("ialloc: no inodes");
801018b1:	83 ec 0c             	sub    $0xc,%esp
801018b4:	68 4f 89 10 80       	push   $0x8010894f
801018b9:	e8 13 ed ff ff       	call   801005d1 <panic>
}
801018be:	c9                   	leave  
801018bf:	c3                   	ret    

801018c0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801018c0:	f3 0f 1e fb          	endbr32 
801018c4:	55                   	push   %ebp
801018c5:	89 e5                	mov    %esp,%ebp
801018c7:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018ca:	8b 45 08             	mov    0x8(%ebp),%eax
801018cd:	8b 40 04             	mov    0x4(%eax),%eax
801018d0:	c1 e8 03             	shr    $0x3,%eax
801018d3:	89 c2                	mov    %eax,%edx
801018d5:	a1 54 1a 11 80       	mov    0x80111a54,%eax
801018da:	01 c2                	add    %eax,%edx
801018dc:	8b 45 08             	mov    0x8(%ebp),%eax
801018df:	8b 00                	mov    (%eax),%eax
801018e1:	83 ec 08             	sub    $0x8,%esp
801018e4:	52                   	push   %edx
801018e5:	50                   	push   %eax
801018e6:	e8 ec e8 ff ff       	call   801001d7 <bread>
801018eb:	83 c4 10             	add    $0x10,%esp
801018ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801018f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018f4:	8d 50 5c             	lea    0x5c(%eax),%edx
801018f7:	8b 45 08             	mov    0x8(%ebp),%eax
801018fa:	8b 40 04             	mov    0x4(%eax),%eax
801018fd:	83 e0 07             	and    $0x7,%eax
80101900:	c1 e0 06             	shl    $0x6,%eax
80101903:	01 d0                	add    %edx,%eax
80101905:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101908:	8b 45 08             	mov    0x8(%ebp),%eax
8010190b:	0f b7 50 50          	movzwl 0x50(%eax),%edx
8010190f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101912:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101915:	8b 45 08             	mov    0x8(%ebp),%eax
80101918:	0f b7 50 52          	movzwl 0x52(%eax),%edx
8010191c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010191f:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101923:	8b 45 08             	mov    0x8(%ebp),%eax
80101926:	0f b7 50 54          	movzwl 0x54(%eax),%edx
8010192a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010192d:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101931:	8b 45 08             	mov    0x8(%ebp),%eax
80101934:	0f b7 50 56          	movzwl 0x56(%eax),%edx
80101938:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010193b:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
8010193f:	8b 45 08             	mov    0x8(%ebp),%eax
80101942:	8b 50 58             	mov    0x58(%eax),%edx
80101945:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101948:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010194b:	8b 45 08             	mov    0x8(%ebp),%eax
8010194e:	8d 50 5c             	lea    0x5c(%eax),%edx
80101951:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101954:	83 c0 0c             	add    $0xc,%eax
80101957:	83 ec 04             	sub    $0x4,%esp
8010195a:	6a 34                	push   $0x34
8010195c:	52                   	push   %edx
8010195d:	50                   	push   %eax
8010195e:	e8 c1 3c 00 00       	call   80105624 <memmove>
80101963:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101966:	83 ec 0c             	sub    $0xc,%esp
80101969:	ff 75 f4             	pushl  -0xc(%ebp)
8010196c:	e8 50 1f 00 00       	call   801038c1 <log_write>
80101971:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101974:	83 ec 0c             	sub    $0xc,%esp
80101977:	ff 75 f4             	pushl  -0xc(%ebp)
8010197a:	e8 e2 e8 ff ff       	call   80100261 <brelse>
8010197f:	83 c4 10             	add    $0x10,%esp
}
80101982:	90                   	nop
80101983:	c9                   	leave  
80101984:	c3                   	ret    

80101985 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101985:	f3 0f 1e fb          	endbr32 
80101989:	55                   	push   %ebp
8010198a:	89 e5                	mov    %esp,%ebp
8010198c:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
8010198f:	83 ec 0c             	sub    $0xc,%esp
80101992:	68 60 1a 11 80       	push   $0x80111a60
80101997:	e8 22 39 00 00       	call   801052be <acquire>
8010199c:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
8010199f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801019a6:	c7 45 f4 94 1a 11 80 	movl   $0x80111a94,-0xc(%ebp)
801019ad:	eb 60                	jmp    80101a0f <iget+0x8a>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801019af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019b2:	8b 40 08             	mov    0x8(%eax),%eax
801019b5:	85 c0                	test   %eax,%eax
801019b7:	7e 39                	jle    801019f2 <iget+0x6d>
801019b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019bc:	8b 00                	mov    (%eax),%eax
801019be:	39 45 08             	cmp    %eax,0x8(%ebp)
801019c1:	75 2f                	jne    801019f2 <iget+0x6d>
801019c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019c6:	8b 40 04             	mov    0x4(%eax),%eax
801019c9:	39 45 0c             	cmp    %eax,0xc(%ebp)
801019cc:	75 24                	jne    801019f2 <iget+0x6d>
      ip->ref++;
801019ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019d1:	8b 40 08             	mov    0x8(%eax),%eax
801019d4:	8d 50 01             	lea    0x1(%eax),%edx
801019d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019da:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
801019dd:	83 ec 0c             	sub    $0xc,%esp
801019e0:	68 60 1a 11 80       	push   $0x80111a60
801019e5:	e8 46 39 00 00       	call   80105330 <release>
801019ea:	83 c4 10             	add    $0x10,%esp
      return ip;
801019ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019f0:	eb 77                	jmp    80101a69 <iget+0xe4>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801019f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801019f6:	75 10                	jne    80101a08 <iget+0x83>
801019f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019fb:	8b 40 08             	mov    0x8(%eax),%eax
801019fe:	85 c0                	test   %eax,%eax
80101a00:	75 06                	jne    80101a08 <iget+0x83>
      empty = ip;
80101a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a05:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101a08:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
80101a0f:	81 7d f4 b4 36 11 80 	cmpl   $0x801136b4,-0xc(%ebp)
80101a16:	72 97                	jb     801019af <iget+0x2a>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101a18:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101a1c:	75 0d                	jne    80101a2b <iget+0xa6>
    panic("iget: no inodes");
80101a1e:	83 ec 0c             	sub    $0xc,%esp
80101a21:	68 61 89 10 80       	push   $0x80108961
80101a26:	e8 a6 eb ff ff       	call   801005d1 <panic>

  ip = empty;
80101a2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a34:	8b 55 08             	mov    0x8(%ebp),%edx
80101a37:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101a39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a3c:	8b 55 0c             	mov    0xc(%ebp),%edx
80101a3f:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101a42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a45:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->valid = 0;
80101a4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a4f:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  release(&icache.lock);
80101a56:	83 ec 0c             	sub    $0xc,%esp
80101a59:	68 60 1a 11 80       	push   $0x80111a60
80101a5e:	e8 cd 38 00 00       	call   80105330 <release>
80101a63:	83 c4 10             	add    $0x10,%esp

  return ip;
80101a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101a69:	c9                   	leave  
80101a6a:	c3                   	ret    

80101a6b <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101a6b:	f3 0f 1e fb          	endbr32 
80101a6f:	55                   	push   %ebp
80101a70:	89 e5                	mov    %esp,%ebp
80101a72:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101a75:	83 ec 0c             	sub    $0xc,%esp
80101a78:	68 60 1a 11 80       	push   $0x80111a60
80101a7d:	e8 3c 38 00 00       	call   801052be <acquire>
80101a82:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101a85:	8b 45 08             	mov    0x8(%ebp),%eax
80101a88:	8b 40 08             	mov    0x8(%eax),%eax
80101a8b:	8d 50 01             	lea    0x1(%eax),%edx
80101a8e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a91:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101a94:	83 ec 0c             	sub    $0xc,%esp
80101a97:	68 60 1a 11 80       	push   $0x80111a60
80101a9c:	e8 8f 38 00 00       	call   80105330 <release>
80101aa1:	83 c4 10             	add    $0x10,%esp
  return ip;
80101aa4:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101aa7:	c9                   	leave  
80101aa8:	c3                   	ret    

80101aa9 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101aa9:	f3 0f 1e fb          	endbr32 
80101aad:	55                   	push   %ebp
80101aae:	89 e5                	mov    %esp,%ebp
80101ab0:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101ab3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101ab7:	74 0a                	je     80101ac3 <ilock+0x1a>
80101ab9:	8b 45 08             	mov    0x8(%ebp),%eax
80101abc:	8b 40 08             	mov    0x8(%eax),%eax
80101abf:	85 c0                	test   %eax,%eax
80101ac1:	7f 0d                	jg     80101ad0 <ilock+0x27>
    panic("ilock");
80101ac3:	83 ec 0c             	sub    $0xc,%esp
80101ac6:	68 71 89 10 80       	push   $0x80108971
80101acb:	e8 01 eb ff ff       	call   801005d1 <panic>

  acquiresleep(&ip->lock);
80101ad0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad3:	83 c0 0c             	add    $0xc,%eax
80101ad6:	83 ec 0c             	sub    $0xc,%esp
80101ad9:	50                   	push   %eax
80101ada:	e8 66 36 00 00       	call   80105145 <acquiresleep>
80101adf:	83 c4 10             	add    $0x10,%esp

  if(ip->valid == 0){
80101ae2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae5:	8b 40 4c             	mov    0x4c(%eax),%eax
80101ae8:	85 c0                	test   %eax,%eax
80101aea:	0f 85 cd 00 00 00    	jne    80101bbd <ilock+0x114>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101af0:	8b 45 08             	mov    0x8(%ebp),%eax
80101af3:	8b 40 04             	mov    0x4(%eax),%eax
80101af6:	c1 e8 03             	shr    $0x3,%eax
80101af9:	89 c2                	mov    %eax,%edx
80101afb:	a1 54 1a 11 80       	mov    0x80111a54,%eax
80101b00:	01 c2                	add    %eax,%edx
80101b02:	8b 45 08             	mov    0x8(%ebp),%eax
80101b05:	8b 00                	mov    (%eax),%eax
80101b07:	83 ec 08             	sub    $0x8,%esp
80101b0a:	52                   	push   %edx
80101b0b:	50                   	push   %eax
80101b0c:	e8 c6 e6 ff ff       	call   801001d7 <bread>
80101b11:	83 c4 10             	add    $0x10,%esp
80101b14:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101b17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b1a:	8d 50 5c             	lea    0x5c(%eax),%edx
80101b1d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b20:	8b 40 04             	mov    0x4(%eax),%eax
80101b23:	83 e0 07             	and    $0x7,%eax
80101b26:	c1 e0 06             	shl    $0x6,%eax
80101b29:	01 d0                	add    %edx,%eax
80101b2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101b2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b31:	0f b7 10             	movzwl (%eax),%edx
80101b34:	8b 45 08             	mov    0x8(%ebp),%eax
80101b37:	66 89 50 50          	mov    %dx,0x50(%eax)
    ip->major = dip->major;
80101b3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b3e:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101b42:	8b 45 08             	mov    0x8(%ebp),%eax
80101b45:	66 89 50 52          	mov    %dx,0x52(%eax)
    ip->minor = dip->minor;
80101b49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b4c:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101b50:	8b 45 08             	mov    0x8(%ebp),%eax
80101b53:	66 89 50 54          	mov    %dx,0x54(%eax)
    ip->nlink = dip->nlink;
80101b57:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b5a:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101b5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b61:	66 89 50 56          	mov    %dx,0x56(%eax)
    ip->size = dip->size;
80101b65:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b68:	8b 50 08             	mov    0x8(%eax),%edx
80101b6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101b6e:	89 50 58             	mov    %edx,0x58(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101b71:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b74:	8d 50 0c             	lea    0xc(%eax),%edx
80101b77:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7a:	83 c0 5c             	add    $0x5c,%eax
80101b7d:	83 ec 04             	sub    $0x4,%esp
80101b80:	6a 34                	push   $0x34
80101b82:	52                   	push   %edx
80101b83:	50                   	push   %eax
80101b84:	e8 9b 3a 00 00       	call   80105624 <memmove>
80101b89:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101b8c:	83 ec 0c             	sub    $0xc,%esp
80101b8f:	ff 75 f4             	pushl  -0xc(%ebp)
80101b92:	e8 ca e6 ff ff       	call   80100261 <brelse>
80101b97:	83 c4 10             	add    $0x10,%esp
    ip->valid = 1;
80101b9a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9d:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
    if(ip->type == 0)
80101ba4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba7:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101bab:	66 85 c0             	test   %ax,%ax
80101bae:	75 0d                	jne    80101bbd <ilock+0x114>
      panic("ilock: no type");
80101bb0:	83 ec 0c             	sub    $0xc,%esp
80101bb3:	68 77 89 10 80       	push   $0x80108977
80101bb8:	e8 14 ea ff ff       	call   801005d1 <panic>
  }
}
80101bbd:	90                   	nop
80101bbe:	c9                   	leave  
80101bbf:	c3                   	ret    

80101bc0 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101bc0:	f3 0f 1e fb          	endbr32 
80101bc4:	55                   	push   %ebp
80101bc5:	89 e5                	mov    %esp,%ebp
80101bc7:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101bca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101bce:	74 20                	je     80101bf0 <iunlock+0x30>
80101bd0:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd3:	83 c0 0c             	add    $0xc,%eax
80101bd6:	83 ec 0c             	sub    $0xc,%esp
80101bd9:	50                   	push   %eax
80101bda:	e8 20 36 00 00       	call   801051ff <holdingsleep>
80101bdf:	83 c4 10             	add    $0x10,%esp
80101be2:	85 c0                	test   %eax,%eax
80101be4:	74 0a                	je     80101bf0 <iunlock+0x30>
80101be6:	8b 45 08             	mov    0x8(%ebp),%eax
80101be9:	8b 40 08             	mov    0x8(%eax),%eax
80101bec:	85 c0                	test   %eax,%eax
80101bee:	7f 0d                	jg     80101bfd <iunlock+0x3d>
    panic("iunlock");
80101bf0:	83 ec 0c             	sub    $0xc,%esp
80101bf3:	68 86 89 10 80       	push   $0x80108986
80101bf8:	e8 d4 e9 ff ff       	call   801005d1 <panic>

  releasesleep(&ip->lock);
80101bfd:	8b 45 08             	mov    0x8(%ebp),%eax
80101c00:	83 c0 0c             	add    $0xc,%eax
80101c03:	83 ec 0c             	sub    $0xc,%esp
80101c06:	50                   	push   %eax
80101c07:	e8 a1 35 00 00       	call   801051ad <releasesleep>
80101c0c:	83 c4 10             	add    $0x10,%esp
}
80101c0f:	90                   	nop
80101c10:	c9                   	leave  
80101c11:	c3                   	ret    

80101c12 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101c12:	f3 0f 1e fb          	endbr32 
80101c16:	55                   	push   %ebp
80101c17:	89 e5                	mov    %esp,%ebp
80101c19:	83 ec 18             	sub    $0x18,%esp
  acquiresleep(&ip->lock);
80101c1c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c1f:	83 c0 0c             	add    $0xc,%eax
80101c22:	83 ec 0c             	sub    $0xc,%esp
80101c25:	50                   	push   %eax
80101c26:	e8 1a 35 00 00       	call   80105145 <acquiresleep>
80101c2b:	83 c4 10             	add    $0x10,%esp
  if(ip->valid && ip->nlink == 0){
80101c2e:	8b 45 08             	mov    0x8(%ebp),%eax
80101c31:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c34:	85 c0                	test   %eax,%eax
80101c36:	74 6a                	je     80101ca2 <iput+0x90>
80101c38:	8b 45 08             	mov    0x8(%ebp),%eax
80101c3b:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80101c3f:	66 85 c0             	test   %ax,%ax
80101c42:	75 5e                	jne    80101ca2 <iput+0x90>
    acquire(&icache.lock);
80101c44:	83 ec 0c             	sub    $0xc,%esp
80101c47:	68 60 1a 11 80       	push   $0x80111a60
80101c4c:	e8 6d 36 00 00       	call   801052be <acquire>
80101c51:	83 c4 10             	add    $0x10,%esp
    int r = ip->ref;
80101c54:	8b 45 08             	mov    0x8(%ebp),%eax
80101c57:	8b 40 08             	mov    0x8(%eax),%eax
80101c5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    release(&icache.lock);
80101c5d:	83 ec 0c             	sub    $0xc,%esp
80101c60:	68 60 1a 11 80       	push   $0x80111a60
80101c65:	e8 c6 36 00 00       	call   80105330 <release>
80101c6a:	83 c4 10             	add    $0x10,%esp
    if(r == 1){
80101c6d:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80101c71:	75 2f                	jne    80101ca2 <iput+0x90>
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
80101c73:	83 ec 0c             	sub    $0xc,%esp
80101c76:	ff 75 08             	pushl  0x8(%ebp)
80101c79:	e8 b5 01 00 00       	call   80101e33 <itrunc>
80101c7e:	83 c4 10             	add    $0x10,%esp
      ip->type = 0;
80101c81:	8b 45 08             	mov    0x8(%ebp),%eax
80101c84:	66 c7 40 50 00 00    	movw   $0x0,0x50(%eax)
      iupdate(ip);
80101c8a:	83 ec 0c             	sub    $0xc,%esp
80101c8d:	ff 75 08             	pushl  0x8(%ebp)
80101c90:	e8 2b fc ff ff       	call   801018c0 <iupdate>
80101c95:	83 c4 10             	add    $0x10,%esp
      ip->valid = 0;
80101c98:	8b 45 08             	mov    0x8(%ebp),%eax
80101c9b:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
    }
  }
  releasesleep(&ip->lock);
80101ca2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ca5:	83 c0 0c             	add    $0xc,%eax
80101ca8:	83 ec 0c             	sub    $0xc,%esp
80101cab:	50                   	push   %eax
80101cac:	e8 fc 34 00 00       	call   801051ad <releasesleep>
80101cb1:	83 c4 10             	add    $0x10,%esp

  acquire(&icache.lock);
80101cb4:	83 ec 0c             	sub    $0xc,%esp
80101cb7:	68 60 1a 11 80       	push   $0x80111a60
80101cbc:	e8 fd 35 00 00       	call   801052be <acquire>
80101cc1:	83 c4 10             	add    $0x10,%esp
  ip->ref--;
80101cc4:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc7:	8b 40 08             	mov    0x8(%eax),%eax
80101cca:	8d 50 ff             	lea    -0x1(%eax),%edx
80101ccd:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd0:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101cd3:	83 ec 0c             	sub    $0xc,%esp
80101cd6:	68 60 1a 11 80       	push   $0x80111a60
80101cdb:	e8 50 36 00 00       	call   80105330 <release>
80101ce0:	83 c4 10             	add    $0x10,%esp
}
80101ce3:	90                   	nop
80101ce4:	c9                   	leave  
80101ce5:	c3                   	ret    

80101ce6 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101ce6:	f3 0f 1e fb          	endbr32 
80101cea:	55                   	push   %ebp
80101ceb:	89 e5                	mov    %esp,%ebp
80101ced:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101cf0:	83 ec 0c             	sub    $0xc,%esp
80101cf3:	ff 75 08             	pushl  0x8(%ebp)
80101cf6:	e8 c5 fe ff ff       	call   80101bc0 <iunlock>
80101cfb:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101cfe:	83 ec 0c             	sub    $0xc,%esp
80101d01:	ff 75 08             	pushl  0x8(%ebp)
80101d04:	e8 09 ff ff ff       	call   80101c12 <iput>
80101d09:	83 c4 10             	add    $0x10,%esp
}
80101d0c:	90                   	nop
80101d0d:	c9                   	leave  
80101d0e:	c3                   	ret    

80101d0f <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101d0f:	f3 0f 1e fb          	endbr32 
80101d13:	55                   	push   %ebp
80101d14:	89 e5                	mov    %esp,%ebp
80101d16:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101d19:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101d1d:	77 42                	ja     80101d61 <bmap+0x52>
    if((addr = ip->addrs[bn]) == 0)
80101d1f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d22:	8b 55 0c             	mov    0xc(%ebp),%edx
80101d25:	83 c2 14             	add    $0x14,%edx
80101d28:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d2f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101d33:	75 24                	jne    80101d59 <bmap+0x4a>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101d35:	8b 45 08             	mov    0x8(%ebp),%eax
80101d38:	8b 00                	mov    (%eax),%eax
80101d3a:	83 ec 0c             	sub    $0xc,%esp
80101d3d:	50                   	push   %eax
80101d3e:	e8 c7 f7 ff ff       	call   8010150a <balloc>
80101d43:	83 c4 10             	add    $0x10,%esp
80101d46:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d49:	8b 45 08             	mov    0x8(%ebp),%eax
80101d4c:	8b 55 0c             	mov    0xc(%ebp),%edx
80101d4f:	8d 4a 14             	lea    0x14(%edx),%ecx
80101d52:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d55:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101d59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d5c:	e9 d0 00 00 00       	jmp    80101e31 <bmap+0x122>
  }
  bn -= NDIRECT;
80101d61:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101d65:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101d69:	0f 87 b5 00 00 00    	ja     80101e24 <bmap+0x115>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101d6f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d72:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101d78:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d7b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101d7f:	75 20                	jne    80101da1 <bmap+0x92>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101d81:	8b 45 08             	mov    0x8(%ebp),%eax
80101d84:	8b 00                	mov    (%eax),%eax
80101d86:	83 ec 0c             	sub    $0xc,%esp
80101d89:	50                   	push   %eax
80101d8a:	e8 7b f7 ff ff       	call   8010150a <balloc>
80101d8f:	83 c4 10             	add    $0x10,%esp
80101d92:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d95:	8b 45 08             	mov    0x8(%ebp),%eax
80101d98:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d9b:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    bp = bread(ip->dev, addr);
80101da1:	8b 45 08             	mov    0x8(%ebp),%eax
80101da4:	8b 00                	mov    (%eax),%eax
80101da6:	83 ec 08             	sub    $0x8,%esp
80101da9:	ff 75 f4             	pushl  -0xc(%ebp)
80101dac:	50                   	push   %eax
80101dad:	e8 25 e4 ff ff       	call   801001d7 <bread>
80101db2:	83 c4 10             	add    $0x10,%esp
80101db5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101db8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dbb:	83 c0 5c             	add    $0x5c,%eax
80101dbe:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dc4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101dcb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101dce:	01 d0                	add    %edx,%eax
80101dd0:	8b 00                	mov    (%eax),%eax
80101dd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101dd5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101dd9:	75 36                	jne    80101e11 <bmap+0x102>
      a[bn] = addr = balloc(ip->dev);
80101ddb:	8b 45 08             	mov    0x8(%ebp),%eax
80101dde:	8b 00                	mov    (%eax),%eax
80101de0:	83 ec 0c             	sub    $0xc,%esp
80101de3:	50                   	push   %eax
80101de4:	e8 21 f7 ff ff       	call   8010150a <balloc>
80101de9:	83 c4 10             	add    $0x10,%esp
80101dec:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101def:	8b 45 0c             	mov    0xc(%ebp),%eax
80101df2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101df9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101dfc:	01 c2                	add    %eax,%edx
80101dfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e01:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101e03:	83 ec 0c             	sub    $0xc,%esp
80101e06:	ff 75 f0             	pushl  -0x10(%ebp)
80101e09:	e8 b3 1a 00 00       	call   801038c1 <log_write>
80101e0e:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101e11:	83 ec 0c             	sub    $0xc,%esp
80101e14:	ff 75 f0             	pushl  -0x10(%ebp)
80101e17:	e8 45 e4 ff ff       	call   80100261 <brelse>
80101e1c:	83 c4 10             	add    $0x10,%esp
    return addr;
80101e1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e22:	eb 0d                	jmp    80101e31 <bmap+0x122>
  }

  panic("bmap: out of range");
80101e24:	83 ec 0c             	sub    $0xc,%esp
80101e27:	68 8e 89 10 80       	push   $0x8010898e
80101e2c:	e8 a0 e7 ff ff       	call   801005d1 <panic>
}
80101e31:	c9                   	leave  
80101e32:	c3                   	ret    

80101e33 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101e33:	f3 0f 1e fb          	endbr32 
80101e37:	55                   	push   %ebp
80101e38:	89 e5                	mov    %esp,%ebp
80101e3a:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101e3d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101e44:	eb 45                	jmp    80101e8b <itrunc+0x58>
    if(ip->addrs[i]){
80101e46:	8b 45 08             	mov    0x8(%ebp),%eax
80101e49:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101e4c:	83 c2 14             	add    $0x14,%edx
80101e4f:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101e53:	85 c0                	test   %eax,%eax
80101e55:	74 30                	je     80101e87 <itrunc+0x54>
      bfree(ip->dev, ip->addrs[i]);
80101e57:	8b 45 08             	mov    0x8(%ebp),%eax
80101e5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101e5d:	83 c2 14             	add    $0x14,%edx
80101e60:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101e64:	8b 55 08             	mov    0x8(%ebp),%edx
80101e67:	8b 12                	mov    (%edx),%edx
80101e69:	83 ec 08             	sub    $0x8,%esp
80101e6c:	50                   	push   %eax
80101e6d:	52                   	push   %edx
80101e6e:	e8 e7 f7 ff ff       	call   8010165a <bfree>
80101e73:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101e76:	8b 45 08             	mov    0x8(%ebp),%eax
80101e79:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101e7c:	83 c2 14             	add    $0x14,%edx
80101e7f:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101e86:	00 
  for(i = 0; i < NDIRECT; i++){
80101e87:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101e8b:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101e8f:	7e b5                	jle    80101e46 <itrunc+0x13>
    }
  }

  if(ip->addrs[NDIRECT]){
80101e91:	8b 45 08             	mov    0x8(%ebp),%eax
80101e94:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101e9a:	85 c0                	test   %eax,%eax
80101e9c:	0f 84 aa 00 00 00    	je     80101f4c <itrunc+0x119>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101ea2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea5:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101eab:	8b 45 08             	mov    0x8(%ebp),%eax
80101eae:	8b 00                	mov    (%eax),%eax
80101eb0:	83 ec 08             	sub    $0x8,%esp
80101eb3:	52                   	push   %edx
80101eb4:	50                   	push   %eax
80101eb5:	e8 1d e3 ff ff       	call   801001d7 <bread>
80101eba:	83 c4 10             	add    $0x10,%esp
80101ebd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101ec0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ec3:	83 c0 5c             	add    $0x5c,%eax
80101ec6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101ec9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101ed0:	eb 3c                	jmp    80101f0e <itrunc+0xdb>
      if(a[j])
80101ed2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ed5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101edc:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101edf:	01 d0                	add    %edx,%eax
80101ee1:	8b 00                	mov    (%eax),%eax
80101ee3:	85 c0                	test   %eax,%eax
80101ee5:	74 23                	je     80101f0a <itrunc+0xd7>
        bfree(ip->dev, a[j]);
80101ee7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101eea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ef1:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101ef4:	01 d0                	add    %edx,%eax
80101ef6:	8b 00                	mov    (%eax),%eax
80101ef8:	8b 55 08             	mov    0x8(%ebp),%edx
80101efb:	8b 12                	mov    (%edx),%edx
80101efd:	83 ec 08             	sub    $0x8,%esp
80101f00:	50                   	push   %eax
80101f01:	52                   	push   %edx
80101f02:	e8 53 f7 ff ff       	call   8010165a <bfree>
80101f07:	83 c4 10             	add    $0x10,%esp
    for(j = 0; j < NINDIRECT; j++){
80101f0a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101f0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f11:	83 f8 7f             	cmp    $0x7f,%eax
80101f14:	76 bc                	jbe    80101ed2 <itrunc+0x9f>
    }
    brelse(bp);
80101f16:	83 ec 0c             	sub    $0xc,%esp
80101f19:	ff 75 ec             	pushl  -0x14(%ebp)
80101f1c:	e8 40 e3 ff ff       	call   80100261 <brelse>
80101f21:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101f24:	8b 45 08             	mov    0x8(%ebp),%eax
80101f27:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101f2d:	8b 55 08             	mov    0x8(%ebp),%edx
80101f30:	8b 12                	mov    (%edx),%edx
80101f32:	83 ec 08             	sub    $0x8,%esp
80101f35:	50                   	push   %eax
80101f36:	52                   	push   %edx
80101f37:	e8 1e f7 ff ff       	call   8010165a <bfree>
80101f3c:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101f3f:	8b 45 08             	mov    0x8(%ebp),%eax
80101f42:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80101f49:	00 00 00 
  }

  ip->size = 0;
80101f4c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f4f:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  iupdate(ip);
80101f56:	83 ec 0c             	sub    $0xc,%esp
80101f59:	ff 75 08             	pushl  0x8(%ebp)
80101f5c:	e8 5f f9 ff ff       	call   801018c0 <iupdate>
80101f61:	83 c4 10             	add    $0x10,%esp
}
80101f64:	90                   	nop
80101f65:	c9                   	leave  
80101f66:	c3                   	ret    

80101f67 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101f67:	f3 0f 1e fb          	endbr32 
80101f6b:	55                   	push   %ebp
80101f6c:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101f6e:	8b 45 08             	mov    0x8(%ebp),%eax
80101f71:	8b 00                	mov    (%eax),%eax
80101f73:	89 c2                	mov    %eax,%edx
80101f75:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f78:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101f7b:	8b 45 08             	mov    0x8(%ebp),%eax
80101f7e:	8b 50 04             	mov    0x4(%eax),%edx
80101f81:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f84:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101f87:	8b 45 08             	mov    0x8(%ebp),%eax
80101f8a:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80101f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f91:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101f94:	8b 45 08             	mov    0x8(%ebp),%eax
80101f97:	0f b7 50 56          	movzwl 0x56(%eax),%edx
80101f9b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f9e:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101fa2:	8b 45 08             	mov    0x8(%ebp),%eax
80101fa5:	8b 50 58             	mov    0x58(%eax),%edx
80101fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
80101fab:	89 50 10             	mov    %edx,0x10(%eax)
}
80101fae:	90                   	nop
80101faf:	5d                   	pop    %ebp
80101fb0:	c3                   	ret    

80101fb1 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101fb1:	f3 0f 1e fb          	endbr32 
80101fb5:	55                   	push   %ebp
80101fb6:	89 e5                	mov    %esp,%ebp
80101fb8:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101fbb:	8b 45 08             	mov    0x8(%ebp),%eax
80101fbe:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101fc2:	66 83 f8 03          	cmp    $0x3,%ax
80101fc6:	75 5c                	jne    80102024 <readi+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101fc8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fcb:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101fcf:	66 85 c0             	test   %ax,%ax
80101fd2:	78 20                	js     80101ff4 <readi+0x43>
80101fd4:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd7:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101fdb:	66 83 f8 09          	cmp    $0x9,%ax
80101fdf:	7f 13                	jg     80101ff4 <readi+0x43>
80101fe1:	8b 45 08             	mov    0x8(%ebp),%eax
80101fe4:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101fe8:	98                   	cwtl   
80101fe9:	8b 04 c5 e0 19 11 80 	mov    -0x7feee620(,%eax,8),%eax
80101ff0:	85 c0                	test   %eax,%eax
80101ff2:	75 0a                	jne    80101ffe <readi+0x4d>
      return -1;
80101ff4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ff9:	e9 0a 01 00 00       	jmp    80102108 <readi+0x157>
    return devsw[ip->major].read(ip, dst, n);
80101ffe:	8b 45 08             	mov    0x8(%ebp),%eax
80102001:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102005:	98                   	cwtl   
80102006:	8b 04 c5 e0 19 11 80 	mov    -0x7feee620(,%eax,8),%eax
8010200d:	8b 55 14             	mov    0x14(%ebp),%edx
80102010:	83 ec 04             	sub    $0x4,%esp
80102013:	52                   	push   %edx
80102014:	ff 75 0c             	pushl  0xc(%ebp)
80102017:	ff 75 08             	pushl  0x8(%ebp)
8010201a:	ff d0                	call   *%eax
8010201c:	83 c4 10             	add    $0x10,%esp
8010201f:	e9 e4 00 00 00       	jmp    80102108 <readi+0x157>
  }

  if(off > ip->size || off + n < off)
80102024:	8b 45 08             	mov    0x8(%ebp),%eax
80102027:	8b 40 58             	mov    0x58(%eax),%eax
8010202a:	39 45 10             	cmp    %eax,0x10(%ebp)
8010202d:	77 0d                	ja     8010203c <readi+0x8b>
8010202f:	8b 55 10             	mov    0x10(%ebp),%edx
80102032:	8b 45 14             	mov    0x14(%ebp),%eax
80102035:	01 d0                	add    %edx,%eax
80102037:	39 45 10             	cmp    %eax,0x10(%ebp)
8010203a:	76 0a                	jbe    80102046 <readi+0x95>
    return -1;
8010203c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102041:	e9 c2 00 00 00       	jmp    80102108 <readi+0x157>
  if(off + n > ip->size)
80102046:	8b 55 10             	mov    0x10(%ebp),%edx
80102049:	8b 45 14             	mov    0x14(%ebp),%eax
8010204c:	01 c2                	add    %eax,%edx
8010204e:	8b 45 08             	mov    0x8(%ebp),%eax
80102051:	8b 40 58             	mov    0x58(%eax),%eax
80102054:	39 c2                	cmp    %eax,%edx
80102056:	76 0c                	jbe    80102064 <readi+0xb3>
    n = ip->size - off;
80102058:	8b 45 08             	mov    0x8(%ebp),%eax
8010205b:	8b 40 58             	mov    0x58(%eax),%eax
8010205e:	2b 45 10             	sub    0x10(%ebp),%eax
80102061:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102064:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010206b:	e9 89 00 00 00       	jmp    801020f9 <readi+0x148>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102070:	8b 45 10             	mov    0x10(%ebp),%eax
80102073:	c1 e8 09             	shr    $0x9,%eax
80102076:	83 ec 08             	sub    $0x8,%esp
80102079:	50                   	push   %eax
8010207a:	ff 75 08             	pushl  0x8(%ebp)
8010207d:	e8 8d fc ff ff       	call   80101d0f <bmap>
80102082:	83 c4 10             	add    $0x10,%esp
80102085:	8b 55 08             	mov    0x8(%ebp),%edx
80102088:	8b 12                	mov    (%edx),%edx
8010208a:	83 ec 08             	sub    $0x8,%esp
8010208d:	50                   	push   %eax
8010208e:	52                   	push   %edx
8010208f:	e8 43 e1 ff ff       	call   801001d7 <bread>
80102094:	83 c4 10             	add    $0x10,%esp
80102097:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
8010209a:	8b 45 10             	mov    0x10(%ebp),%eax
8010209d:	25 ff 01 00 00       	and    $0x1ff,%eax
801020a2:	ba 00 02 00 00       	mov    $0x200,%edx
801020a7:	29 c2                	sub    %eax,%edx
801020a9:	8b 45 14             	mov    0x14(%ebp),%eax
801020ac:	2b 45 f4             	sub    -0xc(%ebp),%eax
801020af:	39 c2                	cmp    %eax,%edx
801020b1:	0f 46 c2             	cmovbe %edx,%eax
801020b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
801020b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020ba:	8d 50 5c             	lea    0x5c(%eax),%edx
801020bd:	8b 45 10             	mov    0x10(%ebp),%eax
801020c0:	25 ff 01 00 00       	and    $0x1ff,%eax
801020c5:	01 d0                	add    %edx,%eax
801020c7:	83 ec 04             	sub    $0x4,%esp
801020ca:	ff 75 ec             	pushl  -0x14(%ebp)
801020cd:	50                   	push   %eax
801020ce:	ff 75 0c             	pushl  0xc(%ebp)
801020d1:	e8 4e 35 00 00       	call   80105624 <memmove>
801020d6:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801020d9:	83 ec 0c             	sub    $0xc,%esp
801020dc:	ff 75 f0             	pushl  -0x10(%ebp)
801020df:	e8 7d e1 ff ff       	call   80100261 <brelse>
801020e4:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801020e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020ea:	01 45 f4             	add    %eax,-0xc(%ebp)
801020ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020f0:	01 45 10             	add    %eax,0x10(%ebp)
801020f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020f6:	01 45 0c             	add    %eax,0xc(%ebp)
801020f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020fc:	3b 45 14             	cmp    0x14(%ebp),%eax
801020ff:	0f 82 6b ff ff ff    	jb     80102070 <readi+0xbf>
  }
  return n;
80102105:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102108:	c9                   	leave  
80102109:	c3                   	ret    

8010210a <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
8010210a:	f3 0f 1e fb          	endbr32 
8010210e:	55                   	push   %ebp
8010210f:	89 e5                	mov    %esp,%ebp
80102111:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102114:	8b 45 08             	mov    0x8(%ebp),%eax
80102117:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010211b:	66 83 f8 03          	cmp    $0x3,%ax
8010211f:	75 5c                	jne    8010217d <writei+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102121:	8b 45 08             	mov    0x8(%ebp),%eax
80102124:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102128:	66 85 c0             	test   %ax,%ax
8010212b:	78 20                	js     8010214d <writei+0x43>
8010212d:	8b 45 08             	mov    0x8(%ebp),%eax
80102130:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102134:	66 83 f8 09          	cmp    $0x9,%ax
80102138:	7f 13                	jg     8010214d <writei+0x43>
8010213a:	8b 45 08             	mov    0x8(%ebp),%eax
8010213d:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102141:	98                   	cwtl   
80102142:	8b 04 c5 e4 19 11 80 	mov    -0x7feee61c(,%eax,8),%eax
80102149:	85 c0                	test   %eax,%eax
8010214b:	75 0a                	jne    80102157 <writei+0x4d>
      return -1;
8010214d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102152:	e9 3b 01 00 00       	jmp    80102292 <writei+0x188>
    return devsw[ip->major].write(ip, src, n);
80102157:	8b 45 08             	mov    0x8(%ebp),%eax
8010215a:	0f b7 40 52          	movzwl 0x52(%eax),%eax
8010215e:	98                   	cwtl   
8010215f:	8b 04 c5 e4 19 11 80 	mov    -0x7feee61c(,%eax,8),%eax
80102166:	8b 55 14             	mov    0x14(%ebp),%edx
80102169:	83 ec 04             	sub    $0x4,%esp
8010216c:	52                   	push   %edx
8010216d:	ff 75 0c             	pushl  0xc(%ebp)
80102170:	ff 75 08             	pushl  0x8(%ebp)
80102173:	ff d0                	call   *%eax
80102175:	83 c4 10             	add    $0x10,%esp
80102178:	e9 15 01 00 00       	jmp    80102292 <writei+0x188>
  }

  if(off > ip->size || off + n < off)
8010217d:	8b 45 08             	mov    0x8(%ebp),%eax
80102180:	8b 40 58             	mov    0x58(%eax),%eax
80102183:	39 45 10             	cmp    %eax,0x10(%ebp)
80102186:	77 0d                	ja     80102195 <writei+0x8b>
80102188:	8b 55 10             	mov    0x10(%ebp),%edx
8010218b:	8b 45 14             	mov    0x14(%ebp),%eax
8010218e:	01 d0                	add    %edx,%eax
80102190:	39 45 10             	cmp    %eax,0x10(%ebp)
80102193:	76 0a                	jbe    8010219f <writei+0x95>
    return -1;
80102195:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010219a:	e9 f3 00 00 00       	jmp    80102292 <writei+0x188>
  if(off + n > MAXFILE*BSIZE)
8010219f:	8b 55 10             	mov    0x10(%ebp),%edx
801021a2:	8b 45 14             	mov    0x14(%ebp),%eax
801021a5:	01 d0                	add    %edx,%eax
801021a7:	3d 00 18 01 00       	cmp    $0x11800,%eax
801021ac:	76 0a                	jbe    801021b8 <writei+0xae>
    return -1;
801021ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021b3:	e9 da 00 00 00       	jmp    80102292 <writei+0x188>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801021b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801021bf:	e9 97 00 00 00       	jmp    8010225b <writei+0x151>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801021c4:	8b 45 10             	mov    0x10(%ebp),%eax
801021c7:	c1 e8 09             	shr    $0x9,%eax
801021ca:	83 ec 08             	sub    $0x8,%esp
801021cd:	50                   	push   %eax
801021ce:	ff 75 08             	pushl  0x8(%ebp)
801021d1:	e8 39 fb ff ff       	call   80101d0f <bmap>
801021d6:	83 c4 10             	add    $0x10,%esp
801021d9:	8b 55 08             	mov    0x8(%ebp),%edx
801021dc:	8b 12                	mov    (%edx),%edx
801021de:	83 ec 08             	sub    $0x8,%esp
801021e1:	50                   	push   %eax
801021e2:	52                   	push   %edx
801021e3:	e8 ef df ff ff       	call   801001d7 <bread>
801021e8:	83 c4 10             	add    $0x10,%esp
801021eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801021ee:	8b 45 10             	mov    0x10(%ebp),%eax
801021f1:	25 ff 01 00 00       	and    $0x1ff,%eax
801021f6:	ba 00 02 00 00       	mov    $0x200,%edx
801021fb:	29 c2                	sub    %eax,%edx
801021fd:	8b 45 14             	mov    0x14(%ebp),%eax
80102200:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102203:	39 c2                	cmp    %eax,%edx
80102205:	0f 46 c2             	cmovbe %edx,%eax
80102208:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
8010220b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010220e:	8d 50 5c             	lea    0x5c(%eax),%edx
80102211:	8b 45 10             	mov    0x10(%ebp),%eax
80102214:	25 ff 01 00 00       	and    $0x1ff,%eax
80102219:	01 d0                	add    %edx,%eax
8010221b:	83 ec 04             	sub    $0x4,%esp
8010221e:	ff 75 ec             	pushl  -0x14(%ebp)
80102221:	ff 75 0c             	pushl  0xc(%ebp)
80102224:	50                   	push   %eax
80102225:	e8 fa 33 00 00       	call   80105624 <memmove>
8010222a:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
8010222d:	83 ec 0c             	sub    $0xc,%esp
80102230:	ff 75 f0             	pushl  -0x10(%ebp)
80102233:	e8 89 16 00 00       	call   801038c1 <log_write>
80102238:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
8010223b:	83 ec 0c             	sub    $0xc,%esp
8010223e:	ff 75 f0             	pushl  -0x10(%ebp)
80102241:	e8 1b e0 ff ff       	call   80100261 <brelse>
80102246:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102249:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010224c:	01 45 f4             	add    %eax,-0xc(%ebp)
8010224f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102252:	01 45 10             	add    %eax,0x10(%ebp)
80102255:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102258:	01 45 0c             	add    %eax,0xc(%ebp)
8010225b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010225e:	3b 45 14             	cmp    0x14(%ebp),%eax
80102261:	0f 82 5d ff ff ff    	jb     801021c4 <writei+0xba>
  }

  if(n > 0 && off > ip->size){
80102267:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010226b:	74 22                	je     8010228f <writei+0x185>
8010226d:	8b 45 08             	mov    0x8(%ebp),%eax
80102270:	8b 40 58             	mov    0x58(%eax),%eax
80102273:	39 45 10             	cmp    %eax,0x10(%ebp)
80102276:	76 17                	jbe    8010228f <writei+0x185>
    ip->size = off;
80102278:	8b 45 08             	mov    0x8(%ebp),%eax
8010227b:	8b 55 10             	mov    0x10(%ebp),%edx
8010227e:	89 50 58             	mov    %edx,0x58(%eax)
    iupdate(ip);
80102281:	83 ec 0c             	sub    $0xc,%esp
80102284:	ff 75 08             	pushl  0x8(%ebp)
80102287:	e8 34 f6 ff ff       	call   801018c0 <iupdate>
8010228c:	83 c4 10             	add    $0x10,%esp
  }
  return n;
8010228f:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102292:	c9                   	leave  
80102293:	c3                   	ret    

80102294 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102294:	f3 0f 1e fb          	endbr32 
80102298:	55                   	push   %ebp
80102299:	89 e5                	mov    %esp,%ebp
8010229b:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
8010229e:	83 ec 04             	sub    $0x4,%esp
801022a1:	6a 0e                	push   $0xe
801022a3:	ff 75 0c             	pushl  0xc(%ebp)
801022a6:	ff 75 08             	pushl  0x8(%ebp)
801022a9:	e8 14 34 00 00       	call   801056c2 <strncmp>
801022ae:	83 c4 10             	add    $0x10,%esp
}
801022b1:	c9                   	leave  
801022b2:	c3                   	ret    

801022b3 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801022b3:	f3 0f 1e fb          	endbr32 
801022b7:	55                   	push   %ebp
801022b8:	89 e5                	mov    %esp,%ebp
801022ba:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801022bd:	8b 45 08             	mov    0x8(%ebp),%eax
801022c0:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801022c4:	66 83 f8 01          	cmp    $0x1,%ax
801022c8:	74 0d                	je     801022d7 <dirlookup+0x24>
    panic("dirlookup not DIR");
801022ca:	83 ec 0c             	sub    $0xc,%esp
801022cd:	68 a1 89 10 80       	push   $0x801089a1
801022d2:	e8 fa e2 ff ff       	call   801005d1 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801022d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801022de:	eb 7b                	jmp    8010235b <dirlookup+0xa8>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022e0:	6a 10                	push   $0x10
801022e2:	ff 75 f4             	pushl  -0xc(%ebp)
801022e5:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022e8:	50                   	push   %eax
801022e9:	ff 75 08             	pushl  0x8(%ebp)
801022ec:	e8 c0 fc ff ff       	call   80101fb1 <readi>
801022f1:	83 c4 10             	add    $0x10,%esp
801022f4:	83 f8 10             	cmp    $0x10,%eax
801022f7:	74 0d                	je     80102306 <dirlookup+0x53>
      panic("dirlookup read");
801022f9:	83 ec 0c             	sub    $0xc,%esp
801022fc:	68 b3 89 10 80       	push   $0x801089b3
80102301:	e8 cb e2 ff ff       	call   801005d1 <panic>
    if(de.inum == 0)
80102306:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010230a:	66 85 c0             	test   %ax,%ax
8010230d:	74 47                	je     80102356 <dirlookup+0xa3>
      continue;
    if(namecmp(name, de.name) == 0){
8010230f:	83 ec 08             	sub    $0x8,%esp
80102312:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102315:	83 c0 02             	add    $0x2,%eax
80102318:	50                   	push   %eax
80102319:	ff 75 0c             	pushl  0xc(%ebp)
8010231c:	e8 73 ff ff ff       	call   80102294 <namecmp>
80102321:	83 c4 10             	add    $0x10,%esp
80102324:	85 c0                	test   %eax,%eax
80102326:	75 2f                	jne    80102357 <dirlookup+0xa4>
      // entry matches path element
      if(poff)
80102328:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010232c:	74 08                	je     80102336 <dirlookup+0x83>
        *poff = off;
8010232e:	8b 45 10             	mov    0x10(%ebp),%eax
80102331:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102334:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102336:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010233a:	0f b7 c0             	movzwl %ax,%eax
8010233d:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102340:	8b 45 08             	mov    0x8(%ebp),%eax
80102343:	8b 00                	mov    (%eax),%eax
80102345:	83 ec 08             	sub    $0x8,%esp
80102348:	ff 75 f0             	pushl  -0x10(%ebp)
8010234b:	50                   	push   %eax
8010234c:	e8 34 f6 ff ff       	call   80101985 <iget>
80102351:	83 c4 10             	add    $0x10,%esp
80102354:	eb 19                	jmp    8010236f <dirlookup+0xbc>
      continue;
80102356:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
80102357:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010235b:	8b 45 08             	mov    0x8(%ebp),%eax
8010235e:	8b 40 58             	mov    0x58(%eax),%eax
80102361:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80102364:	0f 82 76 ff ff ff    	jb     801022e0 <dirlookup+0x2d>
    }
  }

  return 0;
8010236a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010236f:	c9                   	leave  
80102370:	c3                   	ret    

80102371 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102371:	f3 0f 1e fb          	endbr32 
80102375:	55                   	push   %ebp
80102376:	89 e5                	mov    %esp,%ebp
80102378:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
8010237b:	83 ec 04             	sub    $0x4,%esp
8010237e:	6a 00                	push   $0x0
80102380:	ff 75 0c             	pushl  0xc(%ebp)
80102383:	ff 75 08             	pushl  0x8(%ebp)
80102386:	e8 28 ff ff ff       	call   801022b3 <dirlookup>
8010238b:	83 c4 10             	add    $0x10,%esp
8010238e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102391:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102395:	74 18                	je     801023af <dirlink+0x3e>
    iput(ip);
80102397:	83 ec 0c             	sub    $0xc,%esp
8010239a:	ff 75 f0             	pushl  -0x10(%ebp)
8010239d:	e8 70 f8 ff ff       	call   80101c12 <iput>
801023a2:	83 c4 10             	add    $0x10,%esp
    return -1;
801023a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801023aa:	e9 9c 00 00 00       	jmp    8010244b <dirlink+0xda>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801023af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801023b6:	eb 39                	jmp    801023f1 <dirlink+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801023b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023bb:	6a 10                	push   $0x10
801023bd:	50                   	push   %eax
801023be:	8d 45 e0             	lea    -0x20(%ebp),%eax
801023c1:	50                   	push   %eax
801023c2:	ff 75 08             	pushl  0x8(%ebp)
801023c5:	e8 e7 fb ff ff       	call   80101fb1 <readi>
801023ca:	83 c4 10             	add    $0x10,%esp
801023cd:	83 f8 10             	cmp    $0x10,%eax
801023d0:	74 0d                	je     801023df <dirlink+0x6e>
      panic("dirlink read");
801023d2:	83 ec 0c             	sub    $0xc,%esp
801023d5:	68 c2 89 10 80       	push   $0x801089c2
801023da:	e8 f2 e1 ff ff       	call   801005d1 <panic>
    if(de.inum == 0)
801023df:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801023e3:	66 85 c0             	test   %ax,%ax
801023e6:	74 18                	je     80102400 <dirlink+0x8f>
  for(off = 0; off < dp->size; off += sizeof(de)){
801023e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023eb:	83 c0 10             	add    $0x10,%eax
801023ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
801023f1:	8b 45 08             	mov    0x8(%ebp),%eax
801023f4:	8b 50 58             	mov    0x58(%eax),%edx
801023f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023fa:	39 c2                	cmp    %eax,%edx
801023fc:	77 ba                	ja     801023b8 <dirlink+0x47>
801023fe:	eb 01                	jmp    80102401 <dirlink+0x90>
      break;
80102400:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
80102401:	83 ec 04             	sub    $0x4,%esp
80102404:	6a 0e                	push   $0xe
80102406:	ff 75 0c             	pushl  0xc(%ebp)
80102409:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010240c:	83 c0 02             	add    $0x2,%eax
8010240f:	50                   	push   %eax
80102410:	e8 07 33 00 00       	call   8010571c <strncpy>
80102415:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102418:	8b 45 10             	mov    0x10(%ebp),%eax
8010241b:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010241f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102422:	6a 10                	push   $0x10
80102424:	50                   	push   %eax
80102425:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102428:	50                   	push   %eax
80102429:	ff 75 08             	pushl  0x8(%ebp)
8010242c:	e8 d9 fc ff ff       	call   8010210a <writei>
80102431:	83 c4 10             	add    $0x10,%esp
80102434:	83 f8 10             	cmp    $0x10,%eax
80102437:	74 0d                	je     80102446 <dirlink+0xd5>
    panic("dirlink");
80102439:	83 ec 0c             	sub    $0xc,%esp
8010243c:	68 cf 89 10 80       	push   $0x801089cf
80102441:	e8 8b e1 ff ff       	call   801005d1 <panic>

  return 0;
80102446:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010244b:	c9                   	leave  
8010244c:	c3                   	ret    

8010244d <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
8010244d:	f3 0f 1e fb          	endbr32 
80102451:	55                   	push   %ebp
80102452:	89 e5                	mov    %esp,%ebp
80102454:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
80102457:	eb 04                	jmp    8010245d <skipelem+0x10>
    path++;
80102459:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
8010245d:	8b 45 08             	mov    0x8(%ebp),%eax
80102460:	0f b6 00             	movzbl (%eax),%eax
80102463:	3c 2f                	cmp    $0x2f,%al
80102465:	74 f2                	je     80102459 <skipelem+0xc>
  if(*path == 0)
80102467:	8b 45 08             	mov    0x8(%ebp),%eax
8010246a:	0f b6 00             	movzbl (%eax),%eax
8010246d:	84 c0                	test   %al,%al
8010246f:	75 07                	jne    80102478 <skipelem+0x2b>
    return 0;
80102471:	b8 00 00 00 00       	mov    $0x0,%eax
80102476:	eb 77                	jmp    801024ef <skipelem+0xa2>
  s = path;
80102478:	8b 45 08             	mov    0x8(%ebp),%eax
8010247b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
8010247e:	eb 04                	jmp    80102484 <skipelem+0x37>
    path++;
80102480:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path != '/' && *path != 0)
80102484:	8b 45 08             	mov    0x8(%ebp),%eax
80102487:	0f b6 00             	movzbl (%eax),%eax
8010248a:	3c 2f                	cmp    $0x2f,%al
8010248c:	74 0a                	je     80102498 <skipelem+0x4b>
8010248e:	8b 45 08             	mov    0x8(%ebp),%eax
80102491:	0f b6 00             	movzbl (%eax),%eax
80102494:	84 c0                	test   %al,%al
80102496:	75 e8                	jne    80102480 <skipelem+0x33>
  len = path - s;
80102498:	8b 45 08             	mov    0x8(%ebp),%eax
8010249b:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010249e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
801024a1:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801024a5:	7e 15                	jle    801024bc <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
801024a7:	83 ec 04             	sub    $0x4,%esp
801024aa:	6a 0e                	push   $0xe
801024ac:	ff 75 f4             	pushl  -0xc(%ebp)
801024af:	ff 75 0c             	pushl  0xc(%ebp)
801024b2:	e8 6d 31 00 00       	call   80105624 <memmove>
801024b7:	83 c4 10             	add    $0x10,%esp
801024ba:	eb 26                	jmp    801024e2 <skipelem+0x95>
  else {
    memmove(name, s, len);
801024bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024bf:	83 ec 04             	sub    $0x4,%esp
801024c2:	50                   	push   %eax
801024c3:	ff 75 f4             	pushl  -0xc(%ebp)
801024c6:	ff 75 0c             	pushl  0xc(%ebp)
801024c9:	e8 56 31 00 00       	call   80105624 <memmove>
801024ce:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
801024d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
801024d4:	8b 45 0c             	mov    0xc(%ebp),%eax
801024d7:	01 d0                	add    %edx,%eax
801024d9:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801024dc:	eb 04                	jmp    801024e2 <skipelem+0x95>
    path++;
801024de:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
801024e2:	8b 45 08             	mov    0x8(%ebp),%eax
801024e5:	0f b6 00             	movzbl (%eax),%eax
801024e8:	3c 2f                	cmp    $0x2f,%al
801024ea:	74 f2                	je     801024de <skipelem+0x91>
  return path;
801024ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
801024ef:	c9                   	leave  
801024f0:	c3                   	ret    

801024f1 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801024f1:	f3 0f 1e fb          	endbr32 
801024f5:	55                   	push   %ebp
801024f6:	89 e5                	mov    %esp,%ebp
801024f8:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
801024fb:	8b 45 08             	mov    0x8(%ebp),%eax
801024fe:	0f b6 00             	movzbl (%eax),%eax
80102501:	3c 2f                	cmp    $0x2f,%al
80102503:	75 17                	jne    8010251c <namex+0x2b>
    ip = iget(ROOTDEV, ROOTINO);
80102505:	83 ec 08             	sub    $0x8,%esp
80102508:	6a 01                	push   $0x1
8010250a:	6a 01                	push   $0x1
8010250c:	e8 74 f4 ff ff       	call   80101985 <iget>
80102511:	83 c4 10             	add    $0x10,%esp
80102514:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102517:	e9 ba 00 00 00       	jmp    801025d6 <namex+0xe5>
  else
    ip = idup(myproc()->cwd);
8010251c:	e8 16 1f 00 00       	call   80104437 <myproc>
80102521:	8b 40 68             	mov    0x68(%eax),%eax
80102524:	83 ec 0c             	sub    $0xc,%esp
80102527:	50                   	push   %eax
80102528:	e8 3e f5 ff ff       	call   80101a6b <idup>
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102533:	e9 9e 00 00 00       	jmp    801025d6 <namex+0xe5>
    ilock(ip);
80102538:	83 ec 0c             	sub    $0xc,%esp
8010253b:	ff 75 f4             	pushl  -0xc(%ebp)
8010253e:	e8 66 f5 ff ff       	call   80101aa9 <ilock>
80102543:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
80102546:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102549:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010254d:	66 83 f8 01          	cmp    $0x1,%ax
80102551:	74 18                	je     8010256b <namex+0x7a>
      iunlockput(ip);
80102553:	83 ec 0c             	sub    $0xc,%esp
80102556:	ff 75 f4             	pushl  -0xc(%ebp)
80102559:	e8 88 f7 ff ff       	call   80101ce6 <iunlockput>
8010255e:	83 c4 10             	add    $0x10,%esp
      return 0;
80102561:	b8 00 00 00 00       	mov    $0x0,%eax
80102566:	e9 a7 00 00 00       	jmp    80102612 <namex+0x121>
    }
    if(nameiparent && *path == '\0'){
8010256b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010256f:	74 20                	je     80102591 <namex+0xa0>
80102571:	8b 45 08             	mov    0x8(%ebp),%eax
80102574:	0f b6 00             	movzbl (%eax),%eax
80102577:	84 c0                	test   %al,%al
80102579:	75 16                	jne    80102591 <namex+0xa0>
      // Stop one level early.
      iunlock(ip);
8010257b:	83 ec 0c             	sub    $0xc,%esp
8010257e:	ff 75 f4             	pushl  -0xc(%ebp)
80102581:	e8 3a f6 ff ff       	call   80101bc0 <iunlock>
80102586:	83 c4 10             	add    $0x10,%esp
      return ip;
80102589:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010258c:	e9 81 00 00 00       	jmp    80102612 <namex+0x121>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102591:	83 ec 04             	sub    $0x4,%esp
80102594:	6a 00                	push   $0x0
80102596:	ff 75 10             	pushl  0x10(%ebp)
80102599:	ff 75 f4             	pushl  -0xc(%ebp)
8010259c:	e8 12 fd ff ff       	call   801022b3 <dirlookup>
801025a1:	83 c4 10             	add    $0x10,%esp
801025a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
801025a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801025ab:	75 15                	jne    801025c2 <namex+0xd1>
      iunlockput(ip);
801025ad:	83 ec 0c             	sub    $0xc,%esp
801025b0:	ff 75 f4             	pushl  -0xc(%ebp)
801025b3:	e8 2e f7 ff ff       	call   80101ce6 <iunlockput>
801025b8:	83 c4 10             	add    $0x10,%esp
      return 0;
801025bb:	b8 00 00 00 00       	mov    $0x0,%eax
801025c0:	eb 50                	jmp    80102612 <namex+0x121>
    }
    iunlockput(ip);
801025c2:	83 ec 0c             	sub    $0xc,%esp
801025c5:	ff 75 f4             	pushl  -0xc(%ebp)
801025c8:	e8 19 f7 ff ff       	call   80101ce6 <iunlockput>
801025cd:	83 c4 10             	add    $0x10,%esp
    ip = next;
801025d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801025d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while((path = skipelem(path, name)) != 0){
801025d6:	83 ec 08             	sub    $0x8,%esp
801025d9:	ff 75 10             	pushl  0x10(%ebp)
801025dc:	ff 75 08             	pushl  0x8(%ebp)
801025df:	e8 69 fe ff ff       	call   8010244d <skipelem>
801025e4:	83 c4 10             	add    $0x10,%esp
801025e7:	89 45 08             	mov    %eax,0x8(%ebp)
801025ea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025ee:	0f 85 44 ff ff ff    	jne    80102538 <namex+0x47>
  }
  if(nameiparent){
801025f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801025f8:	74 15                	je     8010260f <namex+0x11e>
    iput(ip);
801025fa:	83 ec 0c             	sub    $0xc,%esp
801025fd:	ff 75 f4             	pushl  -0xc(%ebp)
80102600:	e8 0d f6 ff ff       	call   80101c12 <iput>
80102605:	83 c4 10             	add    $0x10,%esp
    return 0;
80102608:	b8 00 00 00 00       	mov    $0x0,%eax
8010260d:	eb 03                	jmp    80102612 <namex+0x121>
  }
  return ip;
8010260f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102612:	c9                   	leave  
80102613:	c3                   	ret    

80102614 <namei>:

struct inode*
namei(char *path)
{
80102614:	f3 0f 1e fb          	endbr32 
80102618:	55                   	push   %ebp
80102619:	89 e5                	mov    %esp,%ebp
8010261b:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
8010261e:	83 ec 04             	sub    $0x4,%esp
80102621:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102624:	50                   	push   %eax
80102625:	6a 00                	push   $0x0
80102627:	ff 75 08             	pushl  0x8(%ebp)
8010262a:	e8 c2 fe ff ff       	call   801024f1 <namex>
8010262f:	83 c4 10             	add    $0x10,%esp
}
80102632:	c9                   	leave  
80102633:	c3                   	ret    

80102634 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102634:	f3 0f 1e fb          	endbr32 
80102638:	55                   	push   %ebp
80102639:	89 e5                	mov    %esp,%ebp
8010263b:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
8010263e:	83 ec 04             	sub    $0x4,%esp
80102641:	ff 75 0c             	pushl  0xc(%ebp)
80102644:	6a 01                	push   $0x1
80102646:	ff 75 08             	pushl  0x8(%ebp)
80102649:	e8 a3 fe ff ff       	call   801024f1 <namex>
8010264e:	83 c4 10             	add    $0x10,%esp
}
80102651:	c9                   	leave  
80102652:	c3                   	ret    

80102653 <inb>:
{
80102653:	55                   	push   %ebp
80102654:	89 e5                	mov    %esp,%ebp
80102656:	83 ec 14             	sub    $0x14,%esp
80102659:	8b 45 08             	mov    0x8(%ebp),%eax
8010265c:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102660:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102664:	89 c2                	mov    %eax,%edx
80102666:	ec                   	in     (%dx),%al
80102667:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010266a:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010266e:	c9                   	leave  
8010266f:	c3                   	ret    

80102670 <insl>:
{
80102670:	55                   	push   %ebp
80102671:	89 e5                	mov    %esp,%ebp
80102673:	57                   	push   %edi
80102674:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102675:	8b 55 08             	mov    0x8(%ebp),%edx
80102678:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010267b:	8b 45 10             	mov    0x10(%ebp),%eax
8010267e:	89 cb                	mov    %ecx,%ebx
80102680:	89 df                	mov    %ebx,%edi
80102682:	89 c1                	mov    %eax,%ecx
80102684:	fc                   	cld    
80102685:	f3 6d                	rep insl (%dx),%es:(%edi)
80102687:	89 c8                	mov    %ecx,%eax
80102689:	89 fb                	mov    %edi,%ebx
8010268b:	89 5d 0c             	mov    %ebx,0xc(%ebp)
8010268e:	89 45 10             	mov    %eax,0x10(%ebp)
}
80102691:	90                   	nop
80102692:	5b                   	pop    %ebx
80102693:	5f                   	pop    %edi
80102694:	5d                   	pop    %ebp
80102695:	c3                   	ret    

80102696 <outb>:
{
80102696:	55                   	push   %ebp
80102697:	89 e5                	mov    %esp,%ebp
80102699:	83 ec 08             	sub    $0x8,%esp
8010269c:	8b 45 08             	mov    0x8(%ebp),%eax
8010269f:	8b 55 0c             	mov    0xc(%ebp),%edx
801026a2:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801026a6:	89 d0                	mov    %edx,%eax
801026a8:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026ab:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801026af:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801026b3:	ee                   	out    %al,(%dx)
}
801026b4:	90                   	nop
801026b5:	c9                   	leave  
801026b6:	c3                   	ret    

801026b7 <outsl>:
{
801026b7:	55                   	push   %ebp
801026b8:	89 e5                	mov    %esp,%ebp
801026ba:	56                   	push   %esi
801026bb:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801026bc:	8b 55 08             	mov    0x8(%ebp),%edx
801026bf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801026c2:	8b 45 10             	mov    0x10(%ebp),%eax
801026c5:	89 cb                	mov    %ecx,%ebx
801026c7:	89 de                	mov    %ebx,%esi
801026c9:	89 c1                	mov    %eax,%ecx
801026cb:	fc                   	cld    
801026cc:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801026ce:	89 c8                	mov    %ecx,%eax
801026d0:	89 f3                	mov    %esi,%ebx
801026d2:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801026d5:	89 45 10             	mov    %eax,0x10(%ebp)
}
801026d8:	90                   	nop
801026d9:	5b                   	pop    %ebx
801026da:	5e                   	pop    %esi
801026db:	5d                   	pop    %ebp
801026dc:	c3                   	ret    

801026dd <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801026dd:	f3 0f 1e fb          	endbr32 
801026e1:	55                   	push   %ebp
801026e2:	89 e5                	mov    %esp,%ebp
801026e4:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801026e7:	90                   	nop
801026e8:	68 f7 01 00 00       	push   $0x1f7
801026ed:	e8 61 ff ff ff       	call   80102653 <inb>
801026f2:	83 c4 04             	add    $0x4,%esp
801026f5:	0f b6 c0             	movzbl %al,%eax
801026f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
801026fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
801026fe:	25 c0 00 00 00       	and    $0xc0,%eax
80102703:	83 f8 40             	cmp    $0x40,%eax
80102706:	75 e0                	jne    801026e8 <idewait+0xb>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102708:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010270c:	74 11                	je     8010271f <idewait+0x42>
8010270e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102711:	83 e0 21             	and    $0x21,%eax
80102714:	85 c0                	test   %eax,%eax
80102716:	74 07                	je     8010271f <idewait+0x42>
    return -1;
80102718:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010271d:	eb 05                	jmp    80102724 <idewait+0x47>
  return 0;
8010271f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102724:	c9                   	leave  
80102725:	c3                   	ret    

80102726 <ideinit>:

void
ideinit(void)
{
80102726:	f3 0f 1e fb          	endbr32 
8010272a:	55                   	push   %ebp
8010272b:	89 e5                	mov    %esp,%ebp
8010272d:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102730:	83 ec 08             	sub    $0x8,%esp
80102733:	68 d7 89 10 80       	push   $0x801089d7
80102738:	68 e0 b5 10 80       	push   $0x8010b5e0
8010273d:	e8 56 2b 00 00       	call   80105298 <initlock>
80102742:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
80102745:	a1 80 3d 11 80       	mov    0x80113d80,%eax
8010274a:	83 e8 01             	sub    $0x1,%eax
8010274d:	83 ec 08             	sub    $0x8,%esp
80102750:	50                   	push   %eax
80102751:	6a 0e                	push   $0xe
80102753:	e8 bb 04 00 00       	call   80102c13 <ioapicenable>
80102758:	83 c4 10             	add    $0x10,%esp
  idewait(0);
8010275b:	83 ec 0c             	sub    $0xc,%esp
8010275e:	6a 00                	push   $0x0
80102760:	e8 78 ff ff ff       	call   801026dd <idewait>
80102765:	83 c4 10             	add    $0x10,%esp

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102768:	83 ec 08             	sub    $0x8,%esp
8010276b:	68 f0 00 00 00       	push   $0xf0
80102770:	68 f6 01 00 00       	push   $0x1f6
80102775:	e8 1c ff ff ff       	call   80102696 <outb>
8010277a:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
8010277d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102784:	eb 24                	jmp    801027aa <ideinit+0x84>
    if(inb(0x1f7) != 0){
80102786:	83 ec 0c             	sub    $0xc,%esp
80102789:	68 f7 01 00 00       	push   $0x1f7
8010278e:	e8 c0 fe ff ff       	call   80102653 <inb>
80102793:	83 c4 10             	add    $0x10,%esp
80102796:	84 c0                	test   %al,%al
80102798:	74 0c                	je     801027a6 <ideinit+0x80>
      havedisk1 = 1;
8010279a:	c7 05 18 b6 10 80 01 	movl   $0x1,0x8010b618
801027a1:	00 00 00 
      break;
801027a4:	eb 0d                	jmp    801027b3 <ideinit+0x8d>
  for(i=0; i<1000; i++){
801027a6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801027aa:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801027b1:	7e d3                	jle    80102786 <ideinit+0x60>
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801027b3:	83 ec 08             	sub    $0x8,%esp
801027b6:	68 e0 00 00 00       	push   $0xe0
801027bb:	68 f6 01 00 00       	push   $0x1f6
801027c0:	e8 d1 fe ff ff       	call   80102696 <outb>
801027c5:	83 c4 10             	add    $0x10,%esp
}
801027c8:	90                   	nop
801027c9:	c9                   	leave  
801027ca:	c3                   	ret    

801027cb <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801027cb:	f3 0f 1e fb          	endbr32 
801027cf:	55                   	push   %ebp
801027d0:	89 e5                	mov    %esp,%ebp
801027d2:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
801027d5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801027d9:	75 0d                	jne    801027e8 <idestart+0x1d>
    panic("idestart");
801027db:	83 ec 0c             	sub    $0xc,%esp
801027de:	68 db 89 10 80       	push   $0x801089db
801027e3:	e8 e9 dd ff ff       	call   801005d1 <panic>
  if(b->blockno >= FSSIZE)
801027e8:	8b 45 08             	mov    0x8(%ebp),%eax
801027eb:	8b 40 08             	mov    0x8(%eax),%eax
801027ee:	3d e7 03 00 00       	cmp    $0x3e7,%eax
801027f3:	76 0d                	jbe    80102802 <idestart+0x37>
    panic("incorrect blockno");
801027f5:	83 ec 0c             	sub    $0xc,%esp
801027f8:	68 e4 89 10 80       	push   $0x801089e4
801027fd:	e8 cf dd ff ff       	call   801005d1 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
80102802:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
80102809:	8b 45 08             	mov    0x8(%ebp),%eax
8010280c:	8b 50 08             	mov    0x8(%eax),%edx
8010280f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102812:	0f af c2             	imul   %edx,%eax
80102815:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
80102818:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
8010281c:	75 07                	jne    80102825 <idestart+0x5a>
8010281e:	b8 20 00 00 00       	mov    $0x20,%eax
80102823:	eb 05                	jmp    8010282a <idestart+0x5f>
80102825:	b8 c4 00 00 00       	mov    $0xc4,%eax
8010282a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
8010282d:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80102831:	75 07                	jne    8010283a <idestart+0x6f>
80102833:	b8 30 00 00 00       	mov    $0x30,%eax
80102838:	eb 05                	jmp    8010283f <idestart+0x74>
8010283a:	b8 c5 00 00 00       	mov    $0xc5,%eax
8010283f:	89 45 e8             	mov    %eax,-0x18(%ebp)

  if (sector_per_block > 7) panic("idestart");
80102842:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
80102846:	7e 0d                	jle    80102855 <idestart+0x8a>
80102848:	83 ec 0c             	sub    $0xc,%esp
8010284b:	68 db 89 10 80       	push   $0x801089db
80102850:	e8 7c dd ff ff       	call   801005d1 <panic>

  idewait(0);
80102855:	83 ec 0c             	sub    $0xc,%esp
80102858:	6a 00                	push   $0x0
8010285a:	e8 7e fe ff ff       	call   801026dd <idewait>
8010285f:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
80102862:	83 ec 08             	sub    $0x8,%esp
80102865:	6a 00                	push   $0x0
80102867:	68 f6 03 00 00       	push   $0x3f6
8010286c:	e8 25 fe ff ff       	call   80102696 <outb>
80102871:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
80102874:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102877:	0f b6 c0             	movzbl %al,%eax
8010287a:	83 ec 08             	sub    $0x8,%esp
8010287d:	50                   	push   %eax
8010287e:	68 f2 01 00 00       	push   $0x1f2
80102883:	e8 0e fe ff ff       	call   80102696 <outb>
80102888:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
8010288b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010288e:	0f b6 c0             	movzbl %al,%eax
80102891:	83 ec 08             	sub    $0x8,%esp
80102894:	50                   	push   %eax
80102895:	68 f3 01 00 00       	push   $0x1f3
8010289a:	e8 f7 fd ff ff       	call   80102696 <outb>
8010289f:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
801028a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801028a5:	c1 f8 08             	sar    $0x8,%eax
801028a8:	0f b6 c0             	movzbl %al,%eax
801028ab:	83 ec 08             	sub    $0x8,%esp
801028ae:	50                   	push   %eax
801028af:	68 f4 01 00 00       	push   $0x1f4
801028b4:	e8 dd fd ff ff       	call   80102696 <outb>
801028b9:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
801028bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801028bf:	c1 f8 10             	sar    $0x10,%eax
801028c2:	0f b6 c0             	movzbl %al,%eax
801028c5:	83 ec 08             	sub    $0x8,%esp
801028c8:	50                   	push   %eax
801028c9:	68 f5 01 00 00       	push   $0x1f5
801028ce:	e8 c3 fd ff ff       	call   80102696 <outb>
801028d3:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801028d6:	8b 45 08             	mov    0x8(%ebp),%eax
801028d9:	8b 40 04             	mov    0x4(%eax),%eax
801028dc:	c1 e0 04             	shl    $0x4,%eax
801028df:	83 e0 10             	and    $0x10,%eax
801028e2:	89 c2                	mov    %eax,%edx
801028e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801028e7:	c1 f8 18             	sar    $0x18,%eax
801028ea:	83 e0 0f             	and    $0xf,%eax
801028ed:	09 d0                	or     %edx,%eax
801028ef:	83 c8 e0             	or     $0xffffffe0,%eax
801028f2:	0f b6 c0             	movzbl %al,%eax
801028f5:	83 ec 08             	sub    $0x8,%esp
801028f8:	50                   	push   %eax
801028f9:	68 f6 01 00 00       	push   $0x1f6
801028fe:	e8 93 fd ff ff       	call   80102696 <outb>
80102903:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102906:	8b 45 08             	mov    0x8(%ebp),%eax
80102909:	8b 00                	mov    (%eax),%eax
8010290b:	83 e0 04             	and    $0x4,%eax
8010290e:	85 c0                	test   %eax,%eax
80102910:	74 35                	je     80102947 <idestart+0x17c>
    outb(0x1f7, write_cmd);
80102912:	8b 45 e8             	mov    -0x18(%ebp),%eax
80102915:	0f b6 c0             	movzbl %al,%eax
80102918:	83 ec 08             	sub    $0x8,%esp
8010291b:	50                   	push   %eax
8010291c:	68 f7 01 00 00       	push   $0x1f7
80102921:	e8 70 fd ff ff       	call   80102696 <outb>
80102926:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
80102929:	8b 45 08             	mov    0x8(%ebp),%eax
8010292c:	83 c0 5c             	add    $0x5c,%eax
8010292f:	83 ec 04             	sub    $0x4,%esp
80102932:	68 80 00 00 00       	push   $0x80
80102937:	50                   	push   %eax
80102938:	68 f0 01 00 00       	push   $0x1f0
8010293d:	e8 75 fd ff ff       	call   801026b7 <outsl>
80102942:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102945:	eb 17                	jmp    8010295e <idestart+0x193>
    outb(0x1f7, read_cmd);
80102947:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010294a:	0f b6 c0             	movzbl %al,%eax
8010294d:	83 ec 08             	sub    $0x8,%esp
80102950:	50                   	push   %eax
80102951:	68 f7 01 00 00       	push   $0x1f7
80102956:	e8 3b fd ff ff       	call   80102696 <outb>
8010295b:	83 c4 10             	add    $0x10,%esp
}
8010295e:	90                   	nop
8010295f:	c9                   	leave  
80102960:	c3                   	ret    

80102961 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102961:	f3 0f 1e fb          	endbr32 
80102965:	55                   	push   %ebp
80102966:	89 e5                	mov    %esp,%ebp
80102968:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
8010296b:	83 ec 0c             	sub    $0xc,%esp
8010296e:	68 e0 b5 10 80       	push   $0x8010b5e0
80102973:	e8 46 29 00 00       	call   801052be <acquire>
80102978:	83 c4 10             	add    $0x10,%esp

  if((b = idequeue) == 0){
8010297b:	a1 14 b6 10 80       	mov    0x8010b614,%eax
80102980:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102983:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102987:	75 15                	jne    8010299e <ideintr+0x3d>
    release(&idelock);
80102989:	83 ec 0c             	sub    $0xc,%esp
8010298c:	68 e0 b5 10 80       	push   $0x8010b5e0
80102991:	e8 9a 29 00 00       	call   80105330 <release>
80102996:	83 c4 10             	add    $0x10,%esp
    return;
80102999:	e9 9a 00 00 00       	jmp    80102a38 <ideintr+0xd7>
  }
  idequeue = b->qnext;
8010299e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029a1:	8b 40 58             	mov    0x58(%eax),%eax
801029a4:	a3 14 b6 10 80       	mov    %eax,0x8010b614

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801029a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029ac:	8b 00                	mov    (%eax),%eax
801029ae:	83 e0 04             	and    $0x4,%eax
801029b1:	85 c0                	test   %eax,%eax
801029b3:	75 2d                	jne    801029e2 <ideintr+0x81>
801029b5:	83 ec 0c             	sub    $0xc,%esp
801029b8:	6a 01                	push   $0x1
801029ba:	e8 1e fd ff ff       	call   801026dd <idewait>
801029bf:	83 c4 10             	add    $0x10,%esp
801029c2:	85 c0                	test   %eax,%eax
801029c4:	78 1c                	js     801029e2 <ideintr+0x81>
    insl(0x1f0, b->data, BSIZE/4);
801029c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029c9:	83 c0 5c             	add    $0x5c,%eax
801029cc:	83 ec 04             	sub    $0x4,%esp
801029cf:	68 80 00 00 00       	push   $0x80
801029d4:	50                   	push   %eax
801029d5:	68 f0 01 00 00       	push   $0x1f0
801029da:	e8 91 fc ff ff       	call   80102670 <insl>
801029df:	83 c4 10             	add    $0x10,%esp

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801029e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029e5:	8b 00                	mov    (%eax),%eax
801029e7:	83 c8 02             	or     $0x2,%eax
801029ea:	89 c2                	mov    %eax,%edx
801029ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029ef:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
801029f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029f4:	8b 00                	mov    (%eax),%eax
801029f6:	83 e0 fb             	and    $0xfffffffb,%eax
801029f9:	89 c2                	mov    %eax,%edx
801029fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029fe:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102a00:	83 ec 0c             	sub    $0xc,%esp
80102a03:	ff 75 f4             	pushl  -0xc(%ebp)
80102a06:	e8 33 25 00 00       	call   80104f3e <wakeup>
80102a0b:	83 c4 10             	add    $0x10,%esp

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102a0e:	a1 14 b6 10 80       	mov    0x8010b614,%eax
80102a13:	85 c0                	test   %eax,%eax
80102a15:	74 11                	je     80102a28 <ideintr+0xc7>
    idestart(idequeue);
80102a17:	a1 14 b6 10 80       	mov    0x8010b614,%eax
80102a1c:	83 ec 0c             	sub    $0xc,%esp
80102a1f:	50                   	push   %eax
80102a20:	e8 a6 fd ff ff       	call   801027cb <idestart>
80102a25:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102a28:	83 ec 0c             	sub    $0xc,%esp
80102a2b:	68 e0 b5 10 80       	push   $0x8010b5e0
80102a30:	e8 fb 28 00 00       	call   80105330 <release>
80102a35:	83 c4 10             	add    $0x10,%esp
}
80102a38:	c9                   	leave  
80102a39:	c3                   	ret    

80102a3a <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102a3a:	f3 0f 1e fb          	endbr32 
80102a3e:	55                   	push   %ebp
80102a3f:	89 e5                	mov    %esp,%ebp
80102a41:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102a44:	8b 45 08             	mov    0x8(%ebp),%eax
80102a47:	83 c0 0c             	add    $0xc,%eax
80102a4a:	83 ec 0c             	sub    $0xc,%esp
80102a4d:	50                   	push   %eax
80102a4e:	e8 ac 27 00 00       	call   801051ff <holdingsleep>
80102a53:	83 c4 10             	add    $0x10,%esp
80102a56:	85 c0                	test   %eax,%eax
80102a58:	75 0d                	jne    80102a67 <iderw+0x2d>
    panic("iderw: buf not locked");
80102a5a:	83 ec 0c             	sub    $0xc,%esp
80102a5d:	68 f6 89 10 80       	push   $0x801089f6
80102a62:	e8 6a db ff ff       	call   801005d1 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102a67:	8b 45 08             	mov    0x8(%ebp),%eax
80102a6a:	8b 00                	mov    (%eax),%eax
80102a6c:	83 e0 06             	and    $0x6,%eax
80102a6f:	83 f8 02             	cmp    $0x2,%eax
80102a72:	75 0d                	jne    80102a81 <iderw+0x47>
    panic("iderw: nothing to do");
80102a74:	83 ec 0c             	sub    $0xc,%esp
80102a77:	68 0c 8a 10 80       	push   $0x80108a0c
80102a7c:	e8 50 db ff ff       	call   801005d1 <panic>
  if(b->dev != 0 && !havedisk1)
80102a81:	8b 45 08             	mov    0x8(%ebp),%eax
80102a84:	8b 40 04             	mov    0x4(%eax),%eax
80102a87:	85 c0                	test   %eax,%eax
80102a89:	74 16                	je     80102aa1 <iderw+0x67>
80102a8b:	a1 18 b6 10 80       	mov    0x8010b618,%eax
80102a90:	85 c0                	test   %eax,%eax
80102a92:	75 0d                	jne    80102aa1 <iderw+0x67>
    panic("iderw: ide disk 1 not present");
80102a94:	83 ec 0c             	sub    $0xc,%esp
80102a97:	68 21 8a 10 80       	push   $0x80108a21
80102a9c:	e8 30 db ff ff       	call   801005d1 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102aa1:	83 ec 0c             	sub    $0xc,%esp
80102aa4:	68 e0 b5 10 80       	push   $0x8010b5e0
80102aa9:	e8 10 28 00 00       	call   801052be <acquire>
80102aae:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80102ab1:	8b 45 08             	mov    0x8(%ebp),%eax
80102ab4:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102abb:	c7 45 f4 14 b6 10 80 	movl   $0x8010b614,-0xc(%ebp)
80102ac2:	eb 0b                	jmp    80102acf <iderw+0x95>
80102ac4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ac7:	8b 00                	mov    (%eax),%eax
80102ac9:	83 c0 58             	add    $0x58,%eax
80102acc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102acf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ad2:	8b 00                	mov    (%eax),%eax
80102ad4:	85 c0                	test   %eax,%eax
80102ad6:	75 ec                	jne    80102ac4 <iderw+0x8a>
    ;
  *pp = b;
80102ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102adb:	8b 55 08             	mov    0x8(%ebp),%edx
80102ade:	89 10                	mov    %edx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
80102ae0:	a1 14 b6 10 80       	mov    0x8010b614,%eax
80102ae5:	39 45 08             	cmp    %eax,0x8(%ebp)
80102ae8:	75 23                	jne    80102b0d <iderw+0xd3>
    idestart(b);
80102aea:	83 ec 0c             	sub    $0xc,%esp
80102aed:	ff 75 08             	pushl  0x8(%ebp)
80102af0:	e8 d6 fc ff ff       	call   801027cb <idestart>
80102af5:	83 c4 10             	add    $0x10,%esp

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102af8:	eb 13                	jmp    80102b0d <iderw+0xd3>
    sleep(b, &idelock);
80102afa:	83 ec 08             	sub    $0x8,%esp
80102afd:	68 e0 b5 10 80       	push   $0x8010b5e0
80102b02:	ff 75 08             	pushl  0x8(%ebp)
80102b05:	e8 42 23 00 00       	call   80104e4c <sleep>
80102b0a:	83 c4 10             	add    $0x10,%esp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102b0d:	8b 45 08             	mov    0x8(%ebp),%eax
80102b10:	8b 00                	mov    (%eax),%eax
80102b12:	83 e0 06             	and    $0x6,%eax
80102b15:	83 f8 02             	cmp    $0x2,%eax
80102b18:	75 e0                	jne    80102afa <iderw+0xc0>
  }


  release(&idelock);
80102b1a:	83 ec 0c             	sub    $0xc,%esp
80102b1d:	68 e0 b5 10 80       	push   $0x8010b5e0
80102b22:	e8 09 28 00 00       	call   80105330 <release>
80102b27:	83 c4 10             	add    $0x10,%esp
}
80102b2a:	90                   	nop
80102b2b:	c9                   	leave  
80102b2c:	c3                   	ret    

80102b2d <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102b2d:	f3 0f 1e fb          	endbr32 
80102b31:	55                   	push   %ebp
80102b32:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102b34:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102b39:	8b 55 08             	mov    0x8(%ebp),%edx
80102b3c:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102b3e:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102b43:	8b 40 10             	mov    0x10(%eax),%eax
}
80102b46:	5d                   	pop    %ebp
80102b47:	c3                   	ret    

80102b48 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102b48:	f3 0f 1e fb          	endbr32 
80102b4c:	55                   	push   %ebp
80102b4d:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102b4f:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102b54:	8b 55 08             	mov    0x8(%ebp),%edx
80102b57:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102b59:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102b5e:	8b 55 0c             	mov    0xc(%ebp),%edx
80102b61:	89 50 10             	mov    %edx,0x10(%eax)
}
80102b64:	90                   	nop
80102b65:	5d                   	pop    %ebp
80102b66:	c3                   	ret    

80102b67 <ioapicinit>:

void
ioapicinit(void)
{
80102b67:	f3 0f 1e fb          	endbr32 
80102b6b:	55                   	push   %ebp
80102b6c:	89 e5                	mov    %esp,%ebp
80102b6e:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102b71:	c7 05 b4 36 11 80 00 	movl   $0xfec00000,0x801136b4
80102b78:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102b7b:	6a 01                	push   $0x1
80102b7d:	e8 ab ff ff ff       	call   80102b2d <ioapicread>
80102b82:	83 c4 04             	add    $0x4,%esp
80102b85:	c1 e8 10             	shr    $0x10,%eax
80102b88:	25 ff 00 00 00       	and    $0xff,%eax
80102b8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102b90:	6a 00                	push   $0x0
80102b92:	e8 96 ff ff ff       	call   80102b2d <ioapicread>
80102b97:	83 c4 04             	add    $0x4,%esp
80102b9a:	c1 e8 18             	shr    $0x18,%eax
80102b9d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102ba0:	0f b6 05 e0 37 11 80 	movzbl 0x801137e0,%eax
80102ba7:	0f b6 c0             	movzbl %al,%eax
80102baa:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80102bad:	74 10                	je     80102bbf <ioapicinit+0x58>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102baf:	83 ec 0c             	sub    $0xc,%esp
80102bb2:	68 40 8a 10 80       	push   $0x80108a40
80102bb7:	e8 5c d8 ff ff       	call   80100418 <cprintf>
80102bbc:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102bbf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102bc6:	eb 3f                	jmp    80102c07 <ioapicinit+0xa0>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bcb:	83 c0 20             	add    $0x20,%eax
80102bce:	0d 00 00 01 00       	or     $0x10000,%eax
80102bd3:	89 c2                	mov    %eax,%edx
80102bd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bd8:	83 c0 08             	add    $0x8,%eax
80102bdb:	01 c0                	add    %eax,%eax
80102bdd:	83 ec 08             	sub    $0x8,%esp
80102be0:	52                   	push   %edx
80102be1:	50                   	push   %eax
80102be2:	e8 61 ff ff ff       	call   80102b48 <ioapicwrite>
80102be7:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102bea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bed:	83 c0 08             	add    $0x8,%eax
80102bf0:	01 c0                	add    %eax,%eax
80102bf2:	83 c0 01             	add    $0x1,%eax
80102bf5:	83 ec 08             	sub    $0x8,%esp
80102bf8:	6a 00                	push   $0x0
80102bfa:	50                   	push   %eax
80102bfb:	e8 48 ff ff ff       	call   80102b48 <ioapicwrite>
80102c00:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i <= maxintr; i++){
80102c03:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102c07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c0a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102c0d:	7e b9                	jle    80102bc8 <ioapicinit+0x61>
  }
}
80102c0f:	90                   	nop
80102c10:	90                   	nop
80102c11:	c9                   	leave  
80102c12:	c3                   	ret    

80102c13 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102c13:	f3 0f 1e fb          	endbr32 
80102c17:	55                   	push   %ebp
80102c18:	89 e5                	mov    %esp,%ebp
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102c1a:	8b 45 08             	mov    0x8(%ebp),%eax
80102c1d:	83 c0 20             	add    $0x20,%eax
80102c20:	89 c2                	mov    %eax,%edx
80102c22:	8b 45 08             	mov    0x8(%ebp),%eax
80102c25:	83 c0 08             	add    $0x8,%eax
80102c28:	01 c0                	add    %eax,%eax
80102c2a:	52                   	push   %edx
80102c2b:	50                   	push   %eax
80102c2c:	e8 17 ff ff ff       	call   80102b48 <ioapicwrite>
80102c31:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102c34:	8b 45 0c             	mov    0xc(%ebp),%eax
80102c37:	c1 e0 18             	shl    $0x18,%eax
80102c3a:	89 c2                	mov    %eax,%edx
80102c3c:	8b 45 08             	mov    0x8(%ebp),%eax
80102c3f:	83 c0 08             	add    $0x8,%eax
80102c42:	01 c0                	add    %eax,%eax
80102c44:	83 c0 01             	add    $0x1,%eax
80102c47:	52                   	push   %edx
80102c48:	50                   	push   %eax
80102c49:	e8 fa fe ff ff       	call   80102b48 <ioapicwrite>
80102c4e:	83 c4 08             	add    $0x8,%esp
}
80102c51:	90                   	nop
80102c52:	c9                   	leave  
80102c53:	c3                   	ret    

80102c54 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102c54:	f3 0f 1e fb          	endbr32 
80102c58:	55                   	push   %ebp
80102c59:	89 e5                	mov    %esp,%ebp
80102c5b:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102c5e:	83 ec 08             	sub    $0x8,%esp
80102c61:	68 72 8a 10 80       	push   $0x80108a72
80102c66:	68 c0 36 11 80       	push   $0x801136c0
80102c6b:	e8 28 26 00 00       	call   80105298 <initlock>
80102c70:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102c73:	c7 05 f4 36 11 80 00 	movl   $0x0,0x801136f4
80102c7a:	00 00 00 
  freerange(vstart, vend);
80102c7d:	83 ec 08             	sub    $0x8,%esp
80102c80:	ff 75 0c             	pushl  0xc(%ebp)
80102c83:	ff 75 08             	pushl  0x8(%ebp)
80102c86:	e8 2e 00 00 00       	call   80102cb9 <freerange>
80102c8b:	83 c4 10             	add    $0x10,%esp
}
80102c8e:	90                   	nop
80102c8f:	c9                   	leave  
80102c90:	c3                   	ret    

80102c91 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102c91:	f3 0f 1e fb          	endbr32 
80102c95:	55                   	push   %ebp
80102c96:	89 e5                	mov    %esp,%ebp
80102c98:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102c9b:	83 ec 08             	sub    $0x8,%esp
80102c9e:	ff 75 0c             	pushl  0xc(%ebp)
80102ca1:	ff 75 08             	pushl  0x8(%ebp)
80102ca4:	e8 10 00 00 00       	call   80102cb9 <freerange>
80102ca9:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102cac:	c7 05 f4 36 11 80 01 	movl   $0x1,0x801136f4
80102cb3:	00 00 00 
}
80102cb6:	90                   	nop
80102cb7:	c9                   	leave  
80102cb8:	c3                   	ret    

80102cb9 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102cb9:	f3 0f 1e fb          	endbr32 
80102cbd:	55                   	push   %ebp
80102cbe:	89 e5                	mov    %esp,%ebp
80102cc0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102cc3:	8b 45 08             	mov    0x8(%ebp),%eax
80102cc6:	05 ff 0f 00 00       	add    $0xfff,%eax
80102ccb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102cd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102cd3:	eb 15                	jmp    80102cea <freerange+0x31>
    kfree(p);
80102cd5:	83 ec 0c             	sub    $0xc,%esp
80102cd8:	ff 75 f4             	pushl  -0xc(%ebp)
80102cdb:	e8 1b 00 00 00       	call   80102cfb <kfree>
80102ce0:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ce3:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102cea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ced:	05 00 10 00 00       	add    $0x1000,%eax
80102cf2:	39 45 0c             	cmp    %eax,0xc(%ebp)
80102cf5:	73 de                	jae    80102cd5 <freerange+0x1c>
}
80102cf7:	90                   	nop
80102cf8:	90                   	nop
80102cf9:	c9                   	leave  
80102cfa:	c3                   	ret    

80102cfb <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102cfb:	f3 0f 1e fb          	endbr32 
80102cff:	55                   	push   %ebp
80102d00:	89 e5                	mov    %esp,%ebp
80102d02:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102d05:	8b 45 08             	mov    0x8(%ebp),%eax
80102d08:	25 ff 0f 00 00       	and    $0xfff,%eax
80102d0d:	85 c0                	test   %eax,%eax
80102d0f:	75 18                	jne    80102d29 <kfree+0x2e>
80102d11:	81 7d 08 28 68 11 80 	cmpl   $0x80116828,0x8(%ebp)
80102d18:	72 0f                	jb     80102d29 <kfree+0x2e>
80102d1a:	8b 45 08             	mov    0x8(%ebp),%eax
80102d1d:	05 00 00 00 80       	add    $0x80000000,%eax
80102d22:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102d27:	76 0d                	jbe    80102d36 <kfree+0x3b>
    panic("kfree");
80102d29:	83 ec 0c             	sub    $0xc,%esp
80102d2c:	68 77 8a 10 80       	push   $0x80108a77
80102d31:	e8 9b d8 ff ff       	call   801005d1 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102d36:	83 ec 04             	sub    $0x4,%esp
80102d39:	68 00 10 00 00       	push   $0x1000
80102d3e:	6a 01                	push   $0x1
80102d40:	ff 75 08             	pushl  0x8(%ebp)
80102d43:	e8 15 28 00 00       	call   8010555d <memset>
80102d48:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102d4b:	a1 f4 36 11 80       	mov    0x801136f4,%eax
80102d50:	85 c0                	test   %eax,%eax
80102d52:	74 10                	je     80102d64 <kfree+0x69>
    acquire(&kmem.lock);
80102d54:	83 ec 0c             	sub    $0xc,%esp
80102d57:	68 c0 36 11 80       	push   $0x801136c0
80102d5c:	e8 5d 25 00 00       	call   801052be <acquire>
80102d61:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102d64:	8b 45 08             	mov    0x8(%ebp),%eax
80102d67:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102d6a:	8b 15 f8 36 11 80    	mov    0x801136f8,%edx
80102d70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d73:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102d75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d78:	a3 f8 36 11 80       	mov    %eax,0x801136f8
  if(kmem.use_lock)
80102d7d:	a1 f4 36 11 80       	mov    0x801136f4,%eax
80102d82:	85 c0                	test   %eax,%eax
80102d84:	74 10                	je     80102d96 <kfree+0x9b>
    release(&kmem.lock);
80102d86:	83 ec 0c             	sub    $0xc,%esp
80102d89:	68 c0 36 11 80       	push   $0x801136c0
80102d8e:	e8 9d 25 00 00       	call   80105330 <release>
80102d93:	83 c4 10             	add    $0x10,%esp
}
80102d96:	90                   	nop
80102d97:	c9                   	leave  
80102d98:	c3                   	ret    

80102d99 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102d99:	f3 0f 1e fb          	endbr32 
80102d9d:	55                   	push   %ebp
80102d9e:	89 e5                	mov    %esp,%ebp
80102da0:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102da3:	a1 f4 36 11 80       	mov    0x801136f4,%eax
80102da8:	85 c0                	test   %eax,%eax
80102daa:	74 10                	je     80102dbc <kalloc+0x23>
    acquire(&kmem.lock);
80102dac:	83 ec 0c             	sub    $0xc,%esp
80102daf:	68 c0 36 11 80       	push   $0x801136c0
80102db4:	e8 05 25 00 00       	call   801052be <acquire>
80102db9:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102dbc:	a1 f8 36 11 80       	mov    0x801136f8,%eax
80102dc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102dc4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102dc8:	74 0a                	je     80102dd4 <kalloc+0x3b>
    kmem.freelist = r->next;
80102dca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102dcd:	8b 00                	mov    (%eax),%eax
80102dcf:	a3 f8 36 11 80       	mov    %eax,0x801136f8
  if(kmem.use_lock)
80102dd4:	a1 f4 36 11 80       	mov    0x801136f4,%eax
80102dd9:	85 c0                	test   %eax,%eax
80102ddb:	74 10                	je     80102ded <kalloc+0x54>
    release(&kmem.lock);
80102ddd:	83 ec 0c             	sub    $0xc,%esp
80102de0:	68 c0 36 11 80       	push   $0x801136c0
80102de5:	e8 46 25 00 00       	call   80105330 <release>
80102dea:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102ded:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102df0:	c9                   	leave  
80102df1:	c3                   	ret    

80102df2 <inb>:
{
80102df2:	55                   	push   %ebp
80102df3:	89 e5                	mov    %esp,%ebp
80102df5:	83 ec 14             	sub    $0x14,%esp
80102df8:	8b 45 08             	mov    0x8(%ebp),%eax
80102dfb:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dff:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102e03:	89 c2                	mov    %eax,%edx
80102e05:	ec                   	in     (%dx),%al
80102e06:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102e09:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102e0d:	c9                   	leave  
80102e0e:	c3                   	ret    

80102e0f <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102e0f:	f3 0f 1e fb          	endbr32 
80102e13:	55                   	push   %ebp
80102e14:	89 e5                	mov    %esp,%ebp
80102e16:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102e19:	6a 64                	push   $0x64
80102e1b:	e8 d2 ff ff ff       	call   80102df2 <inb>
80102e20:	83 c4 04             	add    $0x4,%esp
80102e23:	0f b6 c0             	movzbl %al,%eax
80102e26:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102e29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e2c:	83 e0 01             	and    $0x1,%eax
80102e2f:	85 c0                	test   %eax,%eax
80102e31:	75 0a                	jne    80102e3d <kbdgetc+0x2e>
    return -1;
80102e33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102e38:	e9 23 01 00 00       	jmp    80102f60 <kbdgetc+0x151>
  data = inb(KBDATAP);
80102e3d:	6a 60                	push   $0x60
80102e3f:	e8 ae ff ff ff       	call   80102df2 <inb>
80102e44:	83 c4 04             	add    $0x4,%esp
80102e47:	0f b6 c0             	movzbl %al,%eax
80102e4a:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102e4d:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102e54:	75 17                	jne    80102e6d <kbdgetc+0x5e>
    shift |= E0ESC;
80102e56:	a1 1c b6 10 80       	mov    0x8010b61c,%eax
80102e5b:	83 c8 40             	or     $0x40,%eax
80102e5e:	a3 1c b6 10 80       	mov    %eax,0x8010b61c
    return 0;
80102e63:	b8 00 00 00 00       	mov    $0x0,%eax
80102e68:	e9 f3 00 00 00       	jmp    80102f60 <kbdgetc+0x151>
  } else if(data & 0x80){
80102e6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e70:	25 80 00 00 00       	and    $0x80,%eax
80102e75:	85 c0                	test   %eax,%eax
80102e77:	74 45                	je     80102ebe <kbdgetc+0xaf>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102e79:	a1 1c b6 10 80       	mov    0x8010b61c,%eax
80102e7e:	83 e0 40             	and    $0x40,%eax
80102e81:	85 c0                	test   %eax,%eax
80102e83:	75 08                	jne    80102e8d <kbdgetc+0x7e>
80102e85:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e88:	83 e0 7f             	and    $0x7f,%eax
80102e8b:	eb 03                	jmp    80102e90 <kbdgetc+0x81>
80102e8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e90:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102e93:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e96:	05 20 90 10 80       	add    $0x80109020,%eax
80102e9b:	0f b6 00             	movzbl (%eax),%eax
80102e9e:	83 c8 40             	or     $0x40,%eax
80102ea1:	0f b6 c0             	movzbl %al,%eax
80102ea4:	f7 d0                	not    %eax
80102ea6:	89 c2                	mov    %eax,%edx
80102ea8:	a1 1c b6 10 80       	mov    0x8010b61c,%eax
80102ead:	21 d0                	and    %edx,%eax
80102eaf:	a3 1c b6 10 80       	mov    %eax,0x8010b61c
    return 0;
80102eb4:	b8 00 00 00 00       	mov    $0x0,%eax
80102eb9:	e9 a2 00 00 00       	jmp    80102f60 <kbdgetc+0x151>
  } else if(shift & E0ESC){
80102ebe:	a1 1c b6 10 80       	mov    0x8010b61c,%eax
80102ec3:	83 e0 40             	and    $0x40,%eax
80102ec6:	85 c0                	test   %eax,%eax
80102ec8:	74 14                	je     80102ede <kbdgetc+0xcf>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102eca:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102ed1:	a1 1c b6 10 80       	mov    0x8010b61c,%eax
80102ed6:	83 e0 bf             	and    $0xffffffbf,%eax
80102ed9:	a3 1c b6 10 80       	mov    %eax,0x8010b61c
  }

  shift |= shiftcode[data];
80102ede:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102ee1:	05 20 90 10 80       	add    $0x80109020,%eax
80102ee6:	0f b6 00             	movzbl (%eax),%eax
80102ee9:	0f b6 d0             	movzbl %al,%edx
80102eec:	a1 1c b6 10 80       	mov    0x8010b61c,%eax
80102ef1:	09 d0                	or     %edx,%eax
80102ef3:	a3 1c b6 10 80       	mov    %eax,0x8010b61c
  shift ^= togglecode[data];
80102ef8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102efb:	05 20 91 10 80       	add    $0x80109120,%eax
80102f00:	0f b6 00             	movzbl (%eax),%eax
80102f03:	0f b6 d0             	movzbl %al,%edx
80102f06:	a1 1c b6 10 80       	mov    0x8010b61c,%eax
80102f0b:	31 d0                	xor    %edx,%eax
80102f0d:	a3 1c b6 10 80       	mov    %eax,0x8010b61c
  c = charcode[shift & (CTL | SHIFT)][data];
80102f12:	a1 1c b6 10 80       	mov    0x8010b61c,%eax
80102f17:	83 e0 03             	and    $0x3,%eax
80102f1a:	8b 14 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%edx
80102f21:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f24:	01 d0                	add    %edx,%eax
80102f26:	0f b6 00             	movzbl (%eax),%eax
80102f29:	0f b6 c0             	movzbl %al,%eax
80102f2c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102f2f:	a1 1c b6 10 80       	mov    0x8010b61c,%eax
80102f34:	83 e0 08             	and    $0x8,%eax
80102f37:	85 c0                	test   %eax,%eax
80102f39:	74 22                	je     80102f5d <kbdgetc+0x14e>
    if('a' <= c && c <= 'z')
80102f3b:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102f3f:	76 0c                	jbe    80102f4d <kbdgetc+0x13e>
80102f41:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102f45:	77 06                	ja     80102f4d <kbdgetc+0x13e>
      c += 'A' - 'a';
80102f47:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102f4b:	eb 10                	jmp    80102f5d <kbdgetc+0x14e>
    else if('A' <= c && c <= 'Z')
80102f4d:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102f51:	76 0a                	jbe    80102f5d <kbdgetc+0x14e>
80102f53:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102f57:	77 04                	ja     80102f5d <kbdgetc+0x14e>
      c += 'a' - 'A';
80102f59:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102f5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102f60:	c9                   	leave  
80102f61:	c3                   	ret    

80102f62 <kbdintr>:

void
kbdintr(void)
{
80102f62:	f3 0f 1e fb          	endbr32 
80102f66:	55                   	push   %ebp
80102f67:	89 e5                	mov    %esp,%ebp
80102f69:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102f6c:	83 ec 0c             	sub    $0xc,%esp
80102f6f:	68 0f 2e 10 80       	push   $0x80102e0f
80102f74:	e8 f8 d8 ff ff       	call   80100871 <consoleintr>
80102f79:	83 c4 10             	add    $0x10,%esp
}
80102f7c:	90                   	nop
80102f7d:	c9                   	leave  
80102f7e:	c3                   	ret    

80102f7f <inb>:
{
80102f7f:	55                   	push   %ebp
80102f80:	89 e5                	mov    %esp,%ebp
80102f82:	83 ec 14             	sub    $0x14,%esp
80102f85:	8b 45 08             	mov    0x8(%ebp),%eax
80102f88:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f8c:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102f90:	89 c2                	mov    %eax,%edx
80102f92:	ec                   	in     (%dx),%al
80102f93:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102f96:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102f9a:	c9                   	leave  
80102f9b:	c3                   	ret    

80102f9c <outb>:
{
80102f9c:	55                   	push   %ebp
80102f9d:	89 e5                	mov    %esp,%ebp
80102f9f:	83 ec 08             	sub    $0x8,%esp
80102fa2:	8b 45 08             	mov    0x8(%ebp),%eax
80102fa5:	8b 55 0c             	mov    0xc(%ebp),%edx
80102fa8:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80102fac:	89 d0                	mov    %edx,%eax
80102fae:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fb1:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102fb5:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102fb9:	ee                   	out    %al,(%dx)
}
80102fba:	90                   	nop
80102fbb:	c9                   	leave  
80102fbc:	c3                   	ret    

80102fbd <lapicw>:
volatile uint *lapic;  // Initialized in mp.c

//PAGEBREAK!
static void
lapicw(int index, int value)
{
80102fbd:	f3 0f 1e fb          	endbr32 
80102fc1:	55                   	push   %ebp
80102fc2:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102fc4:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80102fc9:	8b 55 08             	mov    0x8(%ebp),%edx
80102fcc:	c1 e2 02             	shl    $0x2,%edx
80102fcf:	01 c2                	add    %eax,%edx
80102fd1:	8b 45 0c             	mov    0xc(%ebp),%eax
80102fd4:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102fd6:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80102fdb:	83 c0 20             	add    $0x20,%eax
80102fde:	8b 00                	mov    (%eax),%eax
}
80102fe0:	90                   	nop
80102fe1:	5d                   	pop    %ebp
80102fe2:	c3                   	ret    

80102fe3 <lapicinit>:

void
lapicinit(void)
{
80102fe3:	f3 0f 1e fb          	endbr32 
80102fe7:	55                   	push   %ebp
80102fe8:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102fea:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80102fef:	85 c0                	test   %eax,%eax
80102ff1:	0f 84 0c 01 00 00    	je     80103103 <lapicinit+0x120>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102ff7:	68 3f 01 00 00       	push   $0x13f
80102ffc:	6a 3c                	push   $0x3c
80102ffe:	e8 ba ff ff ff       	call   80102fbd <lapicw>
80103003:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80103006:	6a 0b                	push   $0xb
80103008:	68 f8 00 00 00       	push   $0xf8
8010300d:	e8 ab ff ff ff       	call   80102fbd <lapicw>
80103012:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80103015:	68 20 00 02 00       	push   $0x20020
8010301a:	68 c8 00 00 00       	push   $0xc8
8010301f:	e8 99 ff ff ff       	call   80102fbd <lapicw>
80103024:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000);
80103027:	68 80 96 98 00       	push   $0x989680
8010302c:	68 e0 00 00 00       	push   $0xe0
80103031:	e8 87 ff ff ff       	call   80102fbd <lapicw>
80103036:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80103039:	68 00 00 01 00       	push   $0x10000
8010303e:	68 d4 00 00 00       	push   $0xd4
80103043:	e8 75 ff ff ff       	call   80102fbd <lapicw>
80103048:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
8010304b:	68 00 00 01 00       	push   $0x10000
80103050:	68 d8 00 00 00       	push   $0xd8
80103055:	e8 63 ff ff ff       	call   80102fbd <lapicw>
8010305a:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010305d:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80103062:	83 c0 30             	add    $0x30,%eax
80103065:	8b 00                	mov    (%eax),%eax
80103067:	c1 e8 10             	shr    $0x10,%eax
8010306a:	25 fc 00 00 00       	and    $0xfc,%eax
8010306f:	85 c0                	test   %eax,%eax
80103071:	74 12                	je     80103085 <lapicinit+0xa2>
    lapicw(PCINT, MASKED);
80103073:	68 00 00 01 00       	push   $0x10000
80103078:	68 d0 00 00 00       	push   $0xd0
8010307d:	e8 3b ff ff ff       	call   80102fbd <lapicw>
80103082:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80103085:	6a 33                	push   $0x33
80103087:	68 dc 00 00 00       	push   $0xdc
8010308c:	e8 2c ff ff ff       	call   80102fbd <lapicw>
80103091:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80103094:	6a 00                	push   $0x0
80103096:	68 a0 00 00 00       	push   $0xa0
8010309b:	e8 1d ff ff ff       	call   80102fbd <lapicw>
801030a0:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
801030a3:	6a 00                	push   $0x0
801030a5:	68 a0 00 00 00       	push   $0xa0
801030aa:	e8 0e ff ff ff       	call   80102fbd <lapicw>
801030af:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
801030b2:	6a 00                	push   $0x0
801030b4:	6a 2c                	push   $0x2c
801030b6:	e8 02 ff ff ff       	call   80102fbd <lapicw>
801030bb:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
801030be:	6a 00                	push   $0x0
801030c0:	68 c4 00 00 00       	push   $0xc4
801030c5:	e8 f3 fe ff ff       	call   80102fbd <lapicw>
801030ca:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
801030cd:	68 00 85 08 00       	push   $0x88500
801030d2:	68 c0 00 00 00       	push   $0xc0
801030d7:	e8 e1 fe ff ff       	call   80102fbd <lapicw>
801030dc:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
801030df:	90                   	nop
801030e0:	a1 fc 36 11 80       	mov    0x801136fc,%eax
801030e5:	05 00 03 00 00       	add    $0x300,%eax
801030ea:	8b 00                	mov    (%eax),%eax
801030ec:	25 00 10 00 00       	and    $0x1000,%eax
801030f1:	85 c0                	test   %eax,%eax
801030f3:	75 eb                	jne    801030e0 <lapicinit+0xfd>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
801030f5:	6a 00                	push   $0x0
801030f7:	6a 20                	push   $0x20
801030f9:	e8 bf fe ff ff       	call   80102fbd <lapicw>
801030fe:	83 c4 08             	add    $0x8,%esp
80103101:	eb 01                	jmp    80103104 <lapicinit+0x121>
    return;
80103103:	90                   	nop
}
80103104:	c9                   	leave  
80103105:	c3                   	ret    

80103106 <lapicid>:

int
lapicid(void)
{
80103106:	f3 0f 1e fb          	endbr32 
8010310a:	55                   	push   %ebp
8010310b:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010310d:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80103112:	85 c0                	test   %eax,%eax
80103114:	75 07                	jne    8010311d <lapicid+0x17>
    return 0;
80103116:	b8 00 00 00 00       	mov    $0x0,%eax
8010311b:	eb 0d                	jmp    8010312a <lapicid+0x24>
  return lapic[ID] >> 24;
8010311d:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80103122:	83 c0 20             	add    $0x20,%eax
80103125:	8b 00                	mov    (%eax),%eax
80103127:	c1 e8 18             	shr    $0x18,%eax
}
8010312a:	5d                   	pop    %ebp
8010312b:	c3                   	ret    

8010312c <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
8010312c:	f3 0f 1e fb          	endbr32 
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
  if(lapic)
80103133:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80103138:	85 c0                	test   %eax,%eax
8010313a:	74 0c                	je     80103148 <lapiceoi+0x1c>
    lapicw(EOI, 0);
8010313c:	6a 00                	push   $0x0
8010313e:	6a 2c                	push   $0x2c
80103140:	e8 78 fe ff ff       	call   80102fbd <lapicw>
80103145:	83 c4 08             	add    $0x8,%esp
}
80103148:	90                   	nop
80103149:	c9                   	leave  
8010314a:	c3                   	ret    

8010314b <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
8010314b:	f3 0f 1e fb          	endbr32 
8010314f:	55                   	push   %ebp
80103150:	89 e5                	mov    %esp,%ebp
}
80103152:	90                   	nop
80103153:	5d                   	pop    %ebp
80103154:	c3                   	ret    

80103155 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103155:	f3 0f 1e fb          	endbr32 
80103159:	55                   	push   %ebp
8010315a:	89 e5                	mov    %esp,%ebp
8010315c:	83 ec 14             	sub    $0x14,%esp
8010315f:	8b 45 08             	mov    0x8(%ebp),%eax
80103162:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
80103165:	6a 0f                	push   $0xf
80103167:	6a 70                	push   $0x70
80103169:	e8 2e fe ff ff       	call   80102f9c <outb>
8010316e:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
80103171:	6a 0a                	push   $0xa
80103173:	6a 71                	push   $0x71
80103175:	e8 22 fe ff ff       	call   80102f9c <outb>
8010317a:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
8010317d:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103184:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103187:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
8010318c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010318f:	c1 e8 04             	shr    $0x4,%eax
80103192:	89 c2                	mov    %eax,%edx
80103194:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103197:	83 c0 02             	add    $0x2,%eax
8010319a:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010319d:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801031a1:	c1 e0 18             	shl    $0x18,%eax
801031a4:	50                   	push   %eax
801031a5:	68 c4 00 00 00       	push   $0xc4
801031aa:	e8 0e fe ff ff       	call   80102fbd <lapicw>
801031af:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
801031b2:	68 00 c5 00 00       	push   $0xc500
801031b7:	68 c0 00 00 00       	push   $0xc0
801031bc:	e8 fc fd ff ff       	call   80102fbd <lapicw>
801031c1:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
801031c4:	68 c8 00 00 00       	push   $0xc8
801031c9:	e8 7d ff ff ff       	call   8010314b <microdelay>
801031ce:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
801031d1:	68 00 85 00 00       	push   $0x8500
801031d6:	68 c0 00 00 00       	push   $0xc0
801031db:	e8 dd fd ff ff       	call   80102fbd <lapicw>
801031e0:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
801031e3:	6a 64                	push   $0x64
801031e5:	e8 61 ff ff ff       	call   8010314b <microdelay>
801031ea:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801031ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801031f4:	eb 3d                	jmp    80103233 <lapicstartap+0xde>
    lapicw(ICRHI, apicid<<24);
801031f6:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801031fa:	c1 e0 18             	shl    $0x18,%eax
801031fd:	50                   	push   %eax
801031fe:	68 c4 00 00 00       	push   $0xc4
80103203:	e8 b5 fd ff ff       	call   80102fbd <lapicw>
80103208:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
8010320b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010320e:	c1 e8 0c             	shr    $0xc,%eax
80103211:	80 cc 06             	or     $0x6,%ah
80103214:	50                   	push   %eax
80103215:	68 c0 00 00 00       	push   $0xc0
8010321a:	e8 9e fd ff ff       	call   80102fbd <lapicw>
8010321f:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
80103222:	68 c8 00 00 00       	push   $0xc8
80103227:	e8 1f ff ff ff       	call   8010314b <microdelay>
8010322c:	83 c4 04             	add    $0x4,%esp
  for(i = 0; i < 2; i++){
8010322f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103233:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103237:	7e bd                	jle    801031f6 <lapicstartap+0xa1>
  }
}
80103239:	90                   	nop
8010323a:	90                   	nop
8010323b:	c9                   	leave  
8010323c:	c3                   	ret    

8010323d <cmos_read>:
#define MONTH   0x08
#define YEAR    0x09

static uint
cmos_read(uint reg)
{
8010323d:	f3 0f 1e fb          	endbr32 
80103241:	55                   	push   %ebp
80103242:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
80103244:	8b 45 08             	mov    0x8(%ebp),%eax
80103247:	0f b6 c0             	movzbl %al,%eax
8010324a:	50                   	push   %eax
8010324b:	6a 70                	push   $0x70
8010324d:	e8 4a fd ff ff       	call   80102f9c <outb>
80103252:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103255:	68 c8 00 00 00       	push   $0xc8
8010325a:	e8 ec fe ff ff       	call   8010314b <microdelay>
8010325f:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
80103262:	6a 71                	push   $0x71
80103264:	e8 16 fd ff ff       	call   80102f7f <inb>
80103269:	83 c4 04             	add    $0x4,%esp
8010326c:	0f b6 c0             	movzbl %al,%eax
}
8010326f:	c9                   	leave  
80103270:	c3                   	ret    

80103271 <fill_rtcdate>:

static void
fill_rtcdate(struct rtcdate *r)
{
80103271:	f3 0f 1e fb          	endbr32 
80103275:	55                   	push   %ebp
80103276:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
80103278:	6a 00                	push   $0x0
8010327a:	e8 be ff ff ff       	call   8010323d <cmos_read>
8010327f:	83 c4 04             	add    $0x4,%esp
80103282:	8b 55 08             	mov    0x8(%ebp),%edx
80103285:	89 02                	mov    %eax,(%edx)
  r->minute = cmos_read(MINS);
80103287:	6a 02                	push   $0x2
80103289:	e8 af ff ff ff       	call   8010323d <cmos_read>
8010328e:	83 c4 04             	add    $0x4,%esp
80103291:	8b 55 08             	mov    0x8(%ebp),%edx
80103294:	89 42 04             	mov    %eax,0x4(%edx)
  r->hour   = cmos_read(HOURS);
80103297:	6a 04                	push   $0x4
80103299:	e8 9f ff ff ff       	call   8010323d <cmos_read>
8010329e:	83 c4 04             	add    $0x4,%esp
801032a1:	8b 55 08             	mov    0x8(%ebp),%edx
801032a4:	89 42 08             	mov    %eax,0x8(%edx)
  r->day    = cmos_read(DAY);
801032a7:	6a 07                	push   $0x7
801032a9:	e8 8f ff ff ff       	call   8010323d <cmos_read>
801032ae:	83 c4 04             	add    $0x4,%esp
801032b1:	8b 55 08             	mov    0x8(%ebp),%edx
801032b4:	89 42 0c             	mov    %eax,0xc(%edx)
  r->month  = cmos_read(MONTH);
801032b7:	6a 08                	push   $0x8
801032b9:	e8 7f ff ff ff       	call   8010323d <cmos_read>
801032be:	83 c4 04             	add    $0x4,%esp
801032c1:	8b 55 08             	mov    0x8(%ebp),%edx
801032c4:	89 42 10             	mov    %eax,0x10(%edx)
  r->year   = cmos_read(YEAR);
801032c7:	6a 09                	push   $0x9
801032c9:	e8 6f ff ff ff       	call   8010323d <cmos_read>
801032ce:	83 c4 04             	add    $0x4,%esp
801032d1:	8b 55 08             	mov    0x8(%ebp),%edx
801032d4:	89 42 14             	mov    %eax,0x14(%edx)
}
801032d7:	90                   	nop
801032d8:	c9                   	leave  
801032d9:	c3                   	ret    

801032da <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801032da:	f3 0f 1e fb          	endbr32 
801032de:	55                   	push   %ebp
801032df:	89 e5                	mov    %esp,%ebp
801032e1:	83 ec 48             	sub    $0x48,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
801032e4:	6a 0b                	push   $0xb
801032e6:	e8 52 ff ff ff       	call   8010323d <cmos_read>
801032eb:	83 c4 04             	add    $0x4,%esp
801032ee:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
801032f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032f4:	83 e0 04             	and    $0x4,%eax
801032f7:	85 c0                	test   %eax,%eax
801032f9:	0f 94 c0             	sete   %al
801032fc:	0f b6 c0             	movzbl %al,%eax
801032ff:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
80103302:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103305:	50                   	push   %eax
80103306:	e8 66 ff ff ff       	call   80103271 <fill_rtcdate>
8010330b:	83 c4 04             	add    $0x4,%esp
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
8010330e:	6a 0a                	push   $0xa
80103310:	e8 28 ff ff ff       	call   8010323d <cmos_read>
80103315:	83 c4 04             	add    $0x4,%esp
80103318:	25 80 00 00 00       	and    $0x80,%eax
8010331d:	85 c0                	test   %eax,%eax
8010331f:	75 27                	jne    80103348 <cmostime+0x6e>
        continue;
    fill_rtcdate(&t2);
80103321:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103324:	50                   	push   %eax
80103325:	e8 47 ff ff ff       	call   80103271 <fill_rtcdate>
8010332a:	83 c4 04             	add    $0x4,%esp
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010332d:	83 ec 04             	sub    $0x4,%esp
80103330:	6a 18                	push   $0x18
80103332:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103335:	50                   	push   %eax
80103336:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103339:	50                   	push   %eax
8010333a:	e8 89 22 00 00       	call   801055c8 <memcmp>
8010333f:	83 c4 10             	add    $0x10,%esp
80103342:	85 c0                	test   %eax,%eax
80103344:	74 05                	je     8010334b <cmostime+0x71>
80103346:	eb ba                	jmp    80103302 <cmostime+0x28>
        continue;
80103348:	90                   	nop
    fill_rtcdate(&t1);
80103349:	eb b7                	jmp    80103302 <cmostime+0x28>
      break;
8010334b:	90                   	nop
  }

  // convert
  if(bcd) {
8010334c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103350:	0f 84 b4 00 00 00    	je     8010340a <cmostime+0x130>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103356:	8b 45 d8             	mov    -0x28(%ebp),%eax
80103359:	c1 e8 04             	shr    $0x4,%eax
8010335c:	89 c2                	mov    %eax,%edx
8010335e:	89 d0                	mov    %edx,%eax
80103360:	c1 e0 02             	shl    $0x2,%eax
80103363:	01 d0                	add    %edx,%eax
80103365:	01 c0                	add    %eax,%eax
80103367:	89 c2                	mov    %eax,%edx
80103369:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010336c:	83 e0 0f             	and    $0xf,%eax
8010336f:	01 d0                	add    %edx,%eax
80103371:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
80103374:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103377:	c1 e8 04             	shr    $0x4,%eax
8010337a:	89 c2                	mov    %eax,%edx
8010337c:	89 d0                	mov    %edx,%eax
8010337e:	c1 e0 02             	shl    $0x2,%eax
80103381:	01 d0                	add    %edx,%eax
80103383:	01 c0                	add    %eax,%eax
80103385:	89 c2                	mov    %eax,%edx
80103387:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010338a:	83 e0 0f             	and    $0xf,%eax
8010338d:	01 d0                	add    %edx,%eax
8010338f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
80103392:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103395:	c1 e8 04             	shr    $0x4,%eax
80103398:	89 c2                	mov    %eax,%edx
8010339a:	89 d0                	mov    %edx,%eax
8010339c:	c1 e0 02             	shl    $0x2,%eax
8010339f:	01 d0                	add    %edx,%eax
801033a1:	01 c0                	add    %eax,%eax
801033a3:	89 c2                	mov    %eax,%edx
801033a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801033a8:	83 e0 0f             	and    $0xf,%eax
801033ab:	01 d0                	add    %edx,%eax
801033ad:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
801033b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801033b3:	c1 e8 04             	shr    $0x4,%eax
801033b6:	89 c2                	mov    %eax,%edx
801033b8:	89 d0                	mov    %edx,%eax
801033ba:	c1 e0 02             	shl    $0x2,%eax
801033bd:	01 d0                	add    %edx,%eax
801033bf:	01 c0                	add    %eax,%eax
801033c1:	89 c2                	mov    %eax,%edx
801033c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801033c6:	83 e0 0f             	and    $0xf,%eax
801033c9:	01 d0                	add    %edx,%eax
801033cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
801033ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
801033d1:	c1 e8 04             	shr    $0x4,%eax
801033d4:	89 c2                	mov    %eax,%edx
801033d6:	89 d0                	mov    %edx,%eax
801033d8:	c1 e0 02             	shl    $0x2,%eax
801033db:	01 d0                	add    %edx,%eax
801033dd:	01 c0                	add    %eax,%eax
801033df:	89 c2                	mov    %eax,%edx
801033e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801033e4:	83 e0 0f             	and    $0xf,%eax
801033e7:	01 d0                	add    %edx,%eax
801033e9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
801033ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033ef:	c1 e8 04             	shr    $0x4,%eax
801033f2:	89 c2                	mov    %eax,%edx
801033f4:	89 d0                	mov    %edx,%eax
801033f6:	c1 e0 02             	shl    $0x2,%eax
801033f9:	01 d0                	add    %edx,%eax
801033fb:	01 c0                	add    %eax,%eax
801033fd:	89 c2                	mov    %eax,%edx
801033ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103402:	83 e0 0f             	and    $0xf,%eax
80103405:	01 d0                	add    %edx,%eax
80103407:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
8010340a:	8b 45 08             	mov    0x8(%ebp),%eax
8010340d:	8b 55 d8             	mov    -0x28(%ebp),%edx
80103410:	89 10                	mov    %edx,(%eax)
80103412:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103415:	89 50 04             	mov    %edx,0x4(%eax)
80103418:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010341b:	89 50 08             	mov    %edx,0x8(%eax)
8010341e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103421:	89 50 0c             	mov    %edx,0xc(%eax)
80103424:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103427:	89 50 10             	mov    %edx,0x10(%eax)
8010342a:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010342d:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
80103430:	8b 45 08             	mov    0x8(%ebp),%eax
80103433:	8b 40 14             	mov    0x14(%eax),%eax
80103436:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
8010343c:	8b 45 08             	mov    0x8(%ebp),%eax
8010343f:	89 50 14             	mov    %edx,0x14(%eax)
}
80103442:	90                   	nop
80103443:	c9                   	leave  
80103444:	c3                   	ret    

80103445 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80103445:	f3 0f 1e fb          	endbr32 
80103449:	55                   	push   %ebp
8010344a:	89 e5                	mov    %esp,%ebp
8010344c:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010344f:	83 ec 08             	sub    $0x8,%esp
80103452:	68 7d 8a 10 80       	push   $0x80108a7d
80103457:	68 00 37 11 80       	push   $0x80113700
8010345c:	e8 37 1e 00 00       	call   80105298 <initlock>
80103461:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
80103464:	83 ec 08             	sub    $0x8,%esp
80103467:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010346a:	50                   	push   %eax
8010346b:	ff 75 08             	pushl  0x8(%ebp)
8010346e:	e8 f9 df ff ff       	call   8010146c <readsb>
80103473:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
80103476:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103479:	a3 34 37 11 80       	mov    %eax,0x80113734
  log.size = sb.nlog;
8010347e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103481:	a3 38 37 11 80       	mov    %eax,0x80113738
  log.dev = dev;
80103486:	8b 45 08             	mov    0x8(%ebp),%eax
80103489:	a3 44 37 11 80       	mov    %eax,0x80113744
  recover_from_log();
8010348e:	e8 bf 01 00 00       	call   80103652 <recover_from_log>
}
80103493:	90                   	nop
80103494:	c9                   	leave  
80103495:	c3                   	ret    

80103496 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80103496:	f3 0f 1e fb          	endbr32 
8010349a:	55                   	push   %ebp
8010349b:	89 e5                	mov    %esp,%ebp
8010349d:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801034a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034a7:	e9 95 00 00 00       	jmp    80103541 <install_trans+0xab>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801034ac:	8b 15 34 37 11 80    	mov    0x80113734,%edx
801034b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034b5:	01 d0                	add    %edx,%eax
801034b7:	83 c0 01             	add    $0x1,%eax
801034ba:	89 c2                	mov    %eax,%edx
801034bc:	a1 44 37 11 80       	mov    0x80113744,%eax
801034c1:	83 ec 08             	sub    $0x8,%esp
801034c4:	52                   	push   %edx
801034c5:	50                   	push   %eax
801034c6:	e8 0c cd ff ff       	call   801001d7 <bread>
801034cb:	83 c4 10             	add    $0x10,%esp
801034ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801034d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034d4:	83 c0 10             	add    $0x10,%eax
801034d7:	8b 04 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%eax
801034de:	89 c2                	mov    %eax,%edx
801034e0:	a1 44 37 11 80       	mov    0x80113744,%eax
801034e5:	83 ec 08             	sub    $0x8,%esp
801034e8:	52                   	push   %edx
801034e9:	50                   	push   %eax
801034ea:	e8 e8 cc ff ff       	call   801001d7 <bread>
801034ef:	83 c4 10             	add    $0x10,%esp
801034f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801034f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034f8:	8d 50 5c             	lea    0x5c(%eax),%edx
801034fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034fe:	83 c0 5c             	add    $0x5c,%eax
80103501:	83 ec 04             	sub    $0x4,%esp
80103504:	68 00 02 00 00       	push   $0x200
80103509:	52                   	push   %edx
8010350a:	50                   	push   %eax
8010350b:	e8 14 21 00 00       	call   80105624 <memmove>
80103510:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103513:	83 ec 0c             	sub    $0xc,%esp
80103516:	ff 75 ec             	pushl  -0x14(%ebp)
80103519:	e8 f6 cc ff ff       	call   80100214 <bwrite>
8010351e:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf);
80103521:	83 ec 0c             	sub    $0xc,%esp
80103524:	ff 75 f0             	pushl  -0x10(%ebp)
80103527:	e8 35 cd ff ff       	call   80100261 <brelse>
8010352c:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
8010352f:	83 ec 0c             	sub    $0xc,%esp
80103532:	ff 75 ec             	pushl  -0x14(%ebp)
80103535:	e8 27 cd ff ff       	call   80100261 <brelse>
8010353a:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
8010353d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103541:	a1 48 37 11 80       	mov    0x80113748,%eax
80103546:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103549:	0f 8c 5d ff ff ff    	jl     801034ac <install_trans+0x16>
  }
}
8010354f:	90                   	nop
80103550:	90                   	nop
80103551:	c9                   	leave  
80103552:	c3                   	ret    

80103553 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103553:	f3 0f 1e fb          	endbr32 
80103557:	55                   	push   %ebp
80103558:	89 e5                	mov    %esp,%ebp
8010355a:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
8010355d:	a1 34 37 11 80       	mov    0x80113734,%eax
80103562:	89 c2                	mov    %eax,%edx
80103564:	a1 44 37 11 80       	mov    0x80113744,%eax
80103569:	83 ec 08             	sub    $0x8,%esp
8010356c:	52                   	push   %edx
8010356d:	50                   	push   %eax
8010356e:	e8 64 cc ff ff       	call   801001d7 <bread>
80103573:	83 c4 10             	add    $0x10,%esp
80103576:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
80103579:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010357c:	83 c0 5c             	add    $0x5c,%eax
8010357f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103582:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103585:	8b 00                	mov    (%eax),%eax
80103587:	a3 48 37 11 80       	mov    %eax,0x80113748
  for (i = 0; i < log.lh.n; i++) {
8010358c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103593:	eb 1b                	jmp    801035b0 <read_head+0x5d>
    log.lh.block[i] = lh->block[i];
80103595:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103598:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010359b:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
8010359f:	8b 55 f4             	mov    -0xc(%ebp),%edx
801035a2:	83 c2 10             	add    $0x10,%edx
801035a5:	89 04 95 0c 37 11 80 	mov    %eax,-0x7feec8f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801035ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801035b0:	a1 48 37 11 80       	mov    0x80113748,%eax
801035b5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801035b8:	7c db                	jl     80103595 <read_head+0x42>
  }
  brelse(buf);
801035ba:	83 ec 0c             	sub    $0xc,%esp
801035bd:	ff 75 f0             	pushl  -0x10(%ebp)
801035c0:	e8 9c cc ff ff       	call   80100261 <brelse>
801035c5:	83 c4 10             	add    $0x10,%esp
}
801035c8:	90                   	nop
801035c9:	c9                   	leave  
801035ca:	c3                   	ret    

801035cb <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801035cb:	f3 0f 1e fb          	endbr32 
801035cf:	55                   	push   %ebp
801035d0:	89 e5                	mov    %esp,%ebp
801035d2:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801035d5:	a1 34 37 11 80       	mov    0x80113734,%eax
801035da:	89 c2                	mov    %eax,%edx
801035dc:	a1 44 37 11 80       	mov    0x80113744,%eax
801035e1:	83 ec 08             	sub    $0x8,%esp
801035e4:	52                   	push   %edx
801035e5:	50                   	push   %eax
801035e6:	e8 ec cb ff ff       	call   801001d7 <bread>
801035eb:	83 c4 10             	add    $0x10,%esp
801035ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
801035f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035f4:	83 c0 5c             	add    $0x5c,%eax
801035f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801035fa:	8b 15 48 37 11 80    	mov    0x80113748,%edx
80103600:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103603:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103605:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010360c:	eb 1b                	jmp    80103629 <write_head+0x5e>
    hb->block[i] = log.lh.block[i];
8010360e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103611:	83 c0 10             	add    $0x10,%eax
80103614:	8b 0c 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%ecx
8010361b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010361e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103621:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103625:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103629:	a1 48 37 11 80       	mov    0x80113748,%eax
8010362e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103631:	7c db                	jl     8010360e <write_head+0x43>
  }
  bwrite(buf);
80103633:	83 ec 0c             	sub    $0xc,%esp
80103636:	ff 75 f0             	pushl  -0x10(%ebp)
80103639:	e8 d6 cb ff ff       	call   80100214 <bwrite>
8010363e:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80103641:	83 ec 0c             	sub    $0xc,%esp
80103644:	ff 75 f0             	pushl  -0x10(%ebp)
80103647:	e8 15 cc ff ff       	call   80100261 <brelse>
8010364c:	83 c4 10             	add    $0x10,%esp
}
8010364f:	90                   	nop
80103650:	c9                   	leave  
80103651:	c3                   	ret    

80103652 <recover_from_log>:

static void
recover_from_log(void)
{
80103652:	f3 0f 1e fb          	endbr32 
80103656:	55                   	push   %ebp
80103657:	89 e5                	mov    %esp,%ebp
80103659:	83 ec 08             	sub    $0x8,%esp
  read_head();
8010365c:	e8 f2 fe ff ff       	call   80103553 <read_head>
  install_trans(); // if committed, copy from log to disk
80103661:	e8 30 fe ff ff       	call   80103496 <install_trans>
  log.lh.n = 0;
80103666:	c7 05 48 37 11 80 00 	movl   $0x0,0x80113748
8010366d:	00 00 00 
  write_head(); // clear the log
80103670:	e8 56 ff ff ff       	call   801035cb <write_head>
}
80103675:	90                   	nop
80103676:	c9                   	leave  
80103677:	c3                   	ret    

80103678 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
80103678:	f3 0f 1e fb          	endbr32 
8010367c:	55                   	push   %ebp
8010367d:	89 e5                	mov    %esp,%ebp
8010367f:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
80103682:	83 ec 0c             	sub    $0xc,%esp
80103685:	68 00 37 11 80       	push   $0x80113700
8010368a:	e8 2f 1c 00 00       	call   801052be <acquire>
8010368f:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
80103692:	a1 40 37 11 80       	mov    0x80113740,%eax
80103697:	85 c0                	test   %eax,%eax
80103699:	74 17                	je     801036b2 <begin_op+0x3a>
      sleep(&log, &log.lock);
8010369b:	83 ec 08             	sub    $0x8,%esp
8010369e:	68 00 37 11 80       	push   $0x80113700
801036a3:	68 00 37 11 80       	push   $0x80113700
801036a8:	e8 9f 17 00 00       	call   80104e4c <sleep>
801036ad:	83 c4 10             	add    $0x10,%esp
801036b0:	eb e0                	jmp    80103692 <begin_op+0x1a>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801036b2:	8b 0d 48 37 11 80    	mov    0x80113748,%ecx
801036b8:	a1 3c 37 11 80       	mov    0x8011373c,%eax
801036bd:	8d 50 01             	lea    0x1(%eax),%edx
801036c0:	89 d0                	mov    %edx,%eax
801036c2:	c1 e0 02             	shl    $0x2,%eax
801036c5:	01 d0                	add    %edx,%eax
801036c7:	01 c0                	add    %eax,%eax
801036c9:	01 c8                	add    %ecx,%eax
801036cb:	83 f8 1e             	cmp    $0x1e,%eax
801036ce:	7e 17                	jle    801036e7 <begin_op+0x6f>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
801036d0:	83 ec 08             	sub    $0x8,%esp
801036d3:	68 00 37 11 80       	push   $0x80113700
801036d8:	68 00 37 11 80       	push   $0x80113700
801036dd:	e8 6a 17 00 00       	call   80104e4c <sleep>
801036e2:	83 c4 10             	add    $0x10,%esp
801036e5:	eb ab                	jmp    80103692 <begin_op+0x1a>
    } else {
      log.outstanding += 1;
801036e7:	a1 3c 37 11 80       	mov    0x8011373c,%eax
801036ec:	83 c0 01             	add    $0x1,%eax
801036ef:	a3 3c 37 11 80       	mov    %eax,0x8011373c
      release(&log.lock);
801036f4:	83 ec 0c             	sub    $0xc,%esp
801036f7:	68 00 37 11 80       	push   $0x80113700
801036fc:	e8 2f 1c 00 00       	call   80105330 <release>
80103701:	83 c4 10             	add    $0x10,%esp
      break;
80103704:	90                   	nop
    }
  }
}
80103705:	90                   	nop
80103706:	c9                   	leave  
80103707:	c3                   	ret    

80103708 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103708:	f3 0f 1e fb          	endbr32 
8010370c:	55                   	push   %ebp
8010370d:	89 e5                	mov    %esp,%ebp
8010370f:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
80103712:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
80103719:	83 ec 0c             	sub    $0xc,%esp
8010371c:	68 00 37 11 80       	push   $0x80113700
80103721:	e8 98 1b 00 00       	call   801052be <acquire>
80103726:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103729:	a1 3c 37 11 80       	mov    0x8011373c,%eax
8010372e:	83 e8 01             	sub    $0x1,%eax
80103731:	a3 3c 37 11 80       	mov    %eax,0x8011373c
  if(log.committing)
80103736:	a1 40 37 11 80       	mov    0x80113740,%eax
8010373b:	85 c0                	test   %eax,%eax
8010373d:	74 0d                	je     8010374c <end_op+0x44>
    panic("log.committing");
8010373f:	83 ec 0c             	sub    $0xc,%esp
80103742:	68 81 8a 10 80       	push   $0x80108a81
80103747:	e8 85 ce ff ff       	call   801005d1 <panic>
  if(log.outstanding == 0){
8010374c:	a1 3c 37 11 80       	mov    0x8011373c,%eax
80103751:	85 c0                	test   %eax,%eax
80103753:	75 13                	jne    80103768 <end_op+0x60>
    do_commit = 1;
80103755:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
8010375c:	c7 05 40 37 11 80 01 	movl   $0x1,0x80113740
80103763:	00 00 00 
80103766:	eb 10                	jmp    80103778 <end_op+0x70>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80103768:	83 ec 0c             	sub    $0xc,%esp
8010376b:	68 00 37 11 80       	push   $0x80113700
80103770:	e8 c9 17 00 00       	call   80104f3e <wakeup>
80103775:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
80103778:	83 ec 0c             	sub    $0xc,%esp
8010377b:	68 00 37 11 80       	push   $0x80113700
80103780:	e8 ab 1b 00 00       	call   80105330 <release>
80103785:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
80103788:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010378c:	74 3f                	je     801037cd <end_op+0xc5>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
8010378e:	e8 fa 00 00 00       	call   8010388d <commit>
    acquire(&log.lock);
80103793:	83 ec 0c             	sub    $0xc,%esp
80103796:	68 00 37 11 80       	push   $0x80113700
8010379b:	e8 1e 1b 00 00       	call   801052be <acquire>
801037a0:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
801037a3:	c7 05 40 37 11 80 00 	movl   $0x0,0x80113740
801037aa:	00 00 00 
    wakeup(&log);
801037ad:	83 ec 0c             	sub    $0xc,%esp
801037b0:	68 00 37 11 80       	push   $0x80113700
801037b5:	e8 84 17 00 00       	call   80104f3e <wakeup>
801037ba:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
801037bd:	83 ec 0c             	sub    $0xc,%esp
801037c0:	68 00 37 11 80       	push   $0x80113700
801037c5:	e8 66 1b 00 00       	call   80105330 <release>
801037ca:	83 c4 10             	add    $0x10,%esp
  }
}
801037cd:	90                   	nop
801037ce:	c9                   	leave  
801037cf:	c3                   	ret    

801037d0 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
801037d0:	f3 0f 1e fb          	endbr32 
801037d4:	55                   	push   %ebp
801037d5:	89 e5                	mov    %esp,%ebp
801037d7:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801037da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801037e1:	e9 95 00 00 00       	jmp    8010387b <write_log+0xab>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801037e6:	8b 15 34 37 11 80    	mov    0x80113734,%edx
801037ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037ef:	01 d0                	add    %edx,%eax
801037f1:	83 c0 01             	add    $0x1,%eax
801037f4:	89 c2                	mov    %eax,%edx
801037f6:	a1 44 37 11 80       	mov    0x80113744,%eax
801037fb:	83 ec 08             	sub    $0x8,%esp
801037fe:	52                   	push   %edx
801037ff:	50                   	push   %eax
80103800:	e8 d2 c9 ff ff       	call   801001d7 <bread>
80103805:	83 c4 10             	add    $0x10,%esp
80103808:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010380b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010380e:	83 c0 10             	add    $0x10,%eax
80103811:	8b 04 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%eax
80103818:	89 c2                	mov    %eax,%edx
8010381a:	a1 44 37 11 80       	mov    0x80113744,%eax
8010381f:	83 ec 08             	sub    $0x8,%esp
80103822:	52                   	push   %edx
80103823:	50                   	push   %eax
80103824:	e8 ae c9 ff ff       	call   801001d7 <bread>
80103829:	83 c4 10             	add    $0x10,%esp
8010382c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
8010382f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103832:	8d 50 5c             	lea    0x5c(%eax),%edx
80103835:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103838:	83 c0 5c             	add    $0x5c,%eax
8010383b:	83 ec 04             	sub    $0x4,%esp
8010383e:	68 00 02 00 00       	push   $0x200
80103843:	52                   	push   %edx
80103844:	50                   	push   %eax
80103845:	e8 da 1d 00 00       	call   80105624 <memmove>
8010384a:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
8010384d:	83 ec 0c             	sub    $0xc,%esp
80103850:	ff 75 f0             	pushl  -0x10(%ebp)
80103853:	e8 bc c9 ff ff       	call   80100214 <bwrite>
80103858:	83 c4 10             	add    $0x10,%esp
    brelse(from);
8010385b:	83 ec 0c             	sub    $0xc,%esp
8010385e:	ff 75 ec             	pushl  -0x14(%ebp)
80103861:	e8 fb c9 ff ff       	call   80100261 <brelse>
80103866:	83 c4 10             	add    $0x10,%esp
    brelse(to);
80103869:	83 ec 0c             	sub    $0xc,%esp
8010386c:	ff 75 f0             	pushl  -0x10(%ebp)
8010386f:	e8 ed c9 ff ff       	call   80100261 <brelse>
80103874:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80103877:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010387b:	a1 48 37 11 80       	mov    0x80113748,%eax
80103880:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103883:	0f 8c 5d ff ff ff    	jl     801037e6 <write_log+0x16>
  }
}
80103889:	90                   	nop
8010388a:	90                   	nop
8010388b:	c9                   	leave  
8010388c:	c3                   	ret    

8010388d <commit>:

static void
commit()
{
8010388d:	f3 0f 1e fb          	endbr32 
80103891:	55                   	push   %ebp
80103892:	89 e5                	mov    %esp,%ebp
80103894:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103897:	a1 48 37 11 80       	mov    0x80113748,%eax
8010389c:	85 c0                	test   %eax,%eax
8010389e:	7e 1e                	jle    801038be <commit+0x31>
    write_log();     // Write modified blocks from cache to log
801038a0:	e8 2b ff ff ff       	call   801037d0 <write_log>
    write_head();    // Write header to disk -- the real commit
801038a5:	e8 21 fd ff ff       	call   801035cb <write_head>
    install_trans(); // Now install writes to home locations
801038aa:	e8 e7 fb ff ff       	call   80103496 <install_trans>
    log.lh.n = 0;
801038af:	c7 05 48 37 11 80 00 	movl   $0x0,0x80113748
801038b6:	00 00 00 
    write_head();    // Erase the transaction from the log
801038b9:	e8 0d fd ff ff       	call   801035cb <write_head>
  }
}
801038be:	90                   	nop
801038bf:	c9                   	leave  
801038c0:	c3                   	ret    

801038c1 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801038c1:	f3 0f 1e fb          	endbr32 
801038c5:	55                   	push   %ebp
801038c6:	89 e5                	mov    %esp,%ebp
801038c8:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801038cb:	a1 48 37 11 80       	mov    0x80113748,%eax
801038d0:	83 f8 1d             	cmp    $0x1d,%eax
801038d3:	7f 12                	jg     801038e7 <log_write+0x26>
801038d5:	a1 48 37 11 80       	mov    0x80113748,%eax
801038da:	8b 15 38 37 11 80    	mov    0x80113738,%edx
801038e0:	83 ea 01             	sub    $0x1,%edx
801038e3:	39 d0                	cmp    %edx,%eax
801038e5:	7c 0d                	jl     801038f4 <log_write+0x33>
    panic("too big a transaction");
801038e7:	83 ec 0c             	sub    $0xc,%esp
801038ea:	68 90 8a 10 80       	push   $0x80108a90
801038ef:	e8 dd cc ff ff       	call   801005d1 <panic>
  if (log.outstanding < 1)
801038f4:	a1 3c 37 11 80       	mov    0x8011373c,%eax
801038f9:	85 c0                	test   %eax,%eax
801038fb:	7f 0d                	jg     8010390a <log_write+0x49>
    panic("log_write outside of trans");
801038fd:	83 ec 0c             	sub    $0xc,%esp
80103900:	68 a6 8a 10 80       	push   $0x80108aa6
80103905:	e8 c7 cc ff ff       	call   801005d1 <panic>

  acquire(&log.lock);
8010390a:	83 ec 0c             	sub    $0xc,%esp
8010390d:	68 00 37 11 80       	push   $0x80113700
80103912:	e8 a7 19 00 00       	call   801052be <acquire>
80103917:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
8010391a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103921:	eb 1d                	jmp    80103940 <log_write+0x7f>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103923:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103926:	83 c0 10             	add    $0x10,%eax
80103929:	8b 04 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%eax
80103930:	89 c2                	mov    %eax,%edx
80103932:	8b 45 08             	mov    0x8(%ebp),%eax
80103935:	8b 40 08             	mov    0x8(%eax),%eax
80103938:	39 c2                	cmp    %eax,%edx
8010393a:	74 10                	je     8010394c <log_write+0x8b>
  for (i = 0; i < log.lh.n; i++) {
8010393c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103940:	a1 48 37 11 80       	mov    0x80113748,%eax
80103945:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103948:	7c d9                	jl     80103923 <log_write+0x62>
8010394a:	eb 01                	jmp    8010394d <log_write+0x8c>
      break;
8010394c:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
8010394d:	8b 45 08             	mov    0x8(%ebp),%eax
80103950:	8b 40 08             	mov    0x8(%eax),%eax
80103953:	89 c2                	mov    %eax,%edx
80103955:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103958:	83 c0 10             	add    $0x10,%eax
8010395b:	89 14 85 0c 37 11 80 	mov    %edx,-0x7feec8f4(,%eax,4)
  if (i == log.lh.n)
80103962:	a1 48 37 11 80       	mov    0x80113748,%eax
80103967:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010396a:	75 0d                	jne    80103979 <log_write+0xb8>
    log.lh.n++;
8010396c:	a1 48 37 11 80       	mov    0x80113748,%eax
80103971:	83 c0 01             	add    $0x1,%eax
80103974:	a3 48 37 11 80       	mov    %eax,0x80113748
  b->flags |= B_DIRTY; // prevent eviction
80103979:	8b 45 08             	mov    0x8(%ebp),%eax
8010397c:	8b 00                	mov    (%eax),%eax
8010397e:	83 c8 04             	or     $0x4,%eax
80103981:	89 c2                	mov    %eax,%edx
80103983:	8b 45 08             	mov    0x8(%ebp),%eax
80103986:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
80103988:	83 ec 0c             	sub    $0xc,%esp
8010398b:	68 00 37 11 80       	push   $0x80113700
80103990:	e8 9b 19 00 00       	call   80105330 <release>
80103995:	83 c4 10             	add    $0x10,%esp
}
80103998:	90                   	nop
80103999:	c9                   	leave  
8010399a:	c3                   	ret    

8010399b <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010399b:	55                   	push   %ebp
8010399c:	89 e5                	mov    %esp,%ebp
8010399e:	83 ec 10             	sub    $0x10,%esp
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801039a1:	8b 55 08             	mov    0x8(%ebp),%edx
801039a4:	8b 45 0c             	mov    0xc(%ebp),%eax
801039a7:	8b 4d 08             	mov    0x8(%ebp),%ecx
801039aa:	f0 87 02             	lock xchg %eax,(%edx)
801039ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801039b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801039b3:	c9                   	leave  
801039b4:	c3                   	ret    

801039b5 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
801039b5:	f3 0f 1e fb          	endbr32 
801039b9:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801039bd:	83 e4 f0             	and    $0xfffffff0,%esp
801039c0:	ff 71 fc             	pushl  -0x4(%ecx)
801039c3:	55                   	push   %ebp
801039c4:	89 e5                	mov    %esp,%ebp
801039c6:	51                   	push   %ecx
801039c7:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801039ca:	83 ec 08             	sub    $0x8,%esp
801039cd:	68 00 00 40 80       	push   $0x80400000
801039d2:	68 28 68 11 80       	push   $0x80116828
801039d7:	e8 78 f2 ff ff       	call   80102c54 <kinit1>
801039dc:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
801039df:	e8 3a 46 00 00       	call   8010801e <kvmalloc>
  mpinit();        // detect other processors
801039e4:	e8 d9 03 00 00       	call   80103dc2 <mpinit>
  lapicinit();     // interrupt controller
801039e9:	e8 f5 f5 ff ff       	call   80102fe3 <lapicinit>
  seginit();       // segment descriptors
801039ee:	e8 06 41 00 00       	call   80107af9 <seginit>
  picinit();       // disable pic
801039f3:	e8 35 05 00 00       	call   80103f2d <picinit>
  ioapicinit();    // another interrupt controller
801039f8:	e8 6a f1 ff ff       	call   80102b67 <ioapicinit>
  consoleinit();   // console hardware
801039fd:	e8 a8 d1 ff ff       	call   80100baa <consoleinit>
  uartinit();      // serial port
80103a02:	e8 7b 34 00 00       	call   80106e82 <uartinit>
  pinit();         // process table
80103a07:	e8 6e 09 00 00       	call   8010437a <pinit>
  tvinit();        // trap vectors
80103a0c:	e8 44 30 00 00       	call   80106a55 <tvinit>
  binit();         // buffer cache
80103a11:	e8 1e c6 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103a16:	e8 26 d6 ff ff       	call   80101041 <fileinit>
  ideinit();       // disk 
80103a1b:	e8 06 ed ff ff       	call   80102726 <ideinit>
  startothers();   // start other processors
80103a20:	e8 88 00 00 00       	call   80103aad <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103a25:	83 ec 08             	sub    $0x8,%esp
80103a28:	68 00 00 00 8e       	push   $0x8e000000
80103a2d:	68 00 00 40 80       	push   $0x80400000
80103a32:	e8 5a f2 ff ff       	call   80102c91 <kinit2>
80103a37:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
80103a3a:	e8 58 0b 00 00       	call   80104597 <userinit>
  mpmain();        // finish this processor's setup
80103a3f:	e8 1e 00 00 00       	call   80103a62 <mpmain>

80103a44 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103a44:	f3 0f 1e fb          	endbr32 
80103a48:	55                   	push   %ebp
80103a49:	89 e5                	mov    %esp,%ebp
80103a4b:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103a4e:	e8 e7 45 00 00       	call   8010803a <switchkvm>
  seginit();
80103a53:	e8 a1 40 00 00       	call   80107af9 <seginit>
  lapicinit();
80103a58:	e8 86 f5 ff ff       	call   80102fe3 <lapicinit>
  mpmain();
80103a5d:	e8 00 00 00 00       	call   80103a62 <mpmain>

80103a62 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103a62:	f3 0f 1e fb          	endbr32 
80103a66:	55                   	push   %ebp
80103a67:	89 e5                	mov    %esp,%ebp
80103a69:	53                   	push   %ebx
80103a6a:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103a6d:	e8 2a 09 00 00       	call   8010439c <cpuid>
80103a72:	89 c3                	mov    %eax,%ebx
80103a74:	e8 23 09 00 00       	call   8010439c <cpuid>
80103a79:	83 ec 04             	sub    $0x4,%esp
80103a7c:	53                   	push   %ebx
80103a7d:	50                   	push   %eax
80103a7e:	68 c1 8a 10 80       	push   $0x80108ac1
80103a83:	e8 90 c9 ff ff       	call   80100418 <cprintf>
80103a88:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103a8b:	e8 3f 31 00 00       	call   80106bcf <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103a90:	e8 26 09 00 00       	call   801043bb <mycpu>
80103a95:	05 a0 00 00 00       	add    $0xa0,%eax
80103a9a:	83 ec 08             	sub    $0x8,%esp
80103a9d:	6a 01                	push   $0x1
80103a9f:	50                   	push   %eax
80103aa0:	e8 f6 fe ff ff       	call   8010399b <xchg>
80103aa5:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103aa8:	e8 4b 11 00 00       	call   80104bf8 <scheduler>

80103aad <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103aad:	f3 0f 1e fb          	endbr32 
80103ab1:	55                   	push   %ebp
80103ab2:	89 e5                	mov    %esp,%ebp
80103ab4:	83 ec 18             	sub    $0x18,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
80103ab7:	c7 45 f0 00 70 00 80 	movl   $0x80007000,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103abe:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103ac3:	83 ec 04             	sub    $0x4,%esp
80103ac6:	50                   	push   %eax
80103ac7:	68 ec b4 10 80       	push   $0x8010b4ec
80103acc:	ff 75 f0             	pushl  -0x10(%ebp)
80103acf:	e8 50 1b 00 00       	call   80105624 <memmove>
80103ad4:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103ad7:	c7 45 f4 00 38 11 80 	movl   $0x80113800,-0xc(%ebp)
80103ade:	eb 79                	jmp    80103b59 <startothers+0xac>
    if(c == mycpu())  // We've started already.
80103ae0:	e8 d6 08 00 00       	call   801043bb <mycpu>
80103ae5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103ae8:	74 67                	je     80103b51 <startothers+0xa4>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103aea:	e8 aa f2 ff ff       	call   80102d99 <kalloc>
80103aef:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103af2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103af5:	83 e8 04             	sub    $0x4,%eax
80103af8:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103afb:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103b01:	89 10                	mov    %edx,(%eax)
    *(void(**)(void))(code-8) = mpenter;
80103b03:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b06:	83 e8 08             	sub    $0x8,%eax
80103b09:	c7 00 44 3a 10 80    	movl   $0x80103a44,(%eax)
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103b0f:	b8 00 a0 10 80       	mov    $0x8010a000,%eax
80103b14:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80103b1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b1d:	83 e8 0c             	sub    $0xc,%eax
80103b20:	89 10                	mov    %edx,(%eax)

    lapicstartap(c->apicid, V2P(code));
80103b22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b25:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80103b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b2e:	0f b6 00             	movzbl (%eax),%eax
80103b31:	0f b6 c0             	movzbl %al,%eax
80103b34:	83 ec 08             	sub    $0x8,%esp
80103b37:	52                   	push   %edx
80103b38:	50                   	push   %eax
80103b39:	e8 17 f6 ff ff       	call   80103155 <lapicstartap>
80103b3e:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103b41:	90                   	nop
80103b42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b45:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
80103b4b:	85 c0                	test   %eax,%eax
80103b4d:	74 f3                	je     80103b42 <startothers+0x95>
80103b4f:	eb 01                	jmp    80103b52 <startothers+0xa5>
      continue;
80103b51:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
80103b52:	81 45 f4 b0 00 00 00 	addl   $0xb0,-0xc(%ebp)
80103b59:	a1 80 3d 11 80       	mov    0x80113d80,%eax
80103b5e:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80103b64:	05 00 38 11 80       	add    $0x80113800,%eax
80103b69:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103b6c:	0f 82 6e ff ff ff    	jb     80103ae0 <startothers+0x33>
      ;
  }
}
80103b72:	90                   	nop
80103b73:	90                   	nop
80103b74:	c9                   	leave  
80103b75:	c3                   	ret    

80103b76 <inb>:
{
80103b76:	55                   	push   %ebp
80103b77:	89 e5                	mov    %esp,%ebp
80103b79:	83 ec 14             	sub    $0x14,%esp
80103b7c:	8b 45 08             	mov    0x8(%ebp),%eax
80103b7f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b83:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103b87:	89 c2                	mov    %eax,%edx
80103b89:	ec                   	in     (%dx),%al
80103b8a:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103b8d:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103b91:	c9                   	leave  
80103b92:	c3                   	ret    

80103b93 <outb>:
{
80103b93:	55                   	push   %ebp
80103b94:	89 e5                	mov    %esp,%ebp
80103b96:	83 ec 08             	sub    $0x8,%esp
80103b99:	8b 45 08             	mov    0x8(%ebp),%eax
80103b9c:	8b 55 0c             	mov    0xc(%ebp),%edx
80103b9f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103ba3:	89 d0                	mov    %edx,%eax
80103ba5:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ba8:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103bac:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103bb0:	ee                   	out    %al,(%dx)
}
80103bb1:	90                   	nop
80103bb2:	c9                   	leave  
80103bb3:	c3                   	ret    

80103bb4 <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
80103bb4:	f3 0f 1e fb          	endbr32 
80103bb8:	55                   	push   %ebp
80103bb9:	89 e5                	mov    %esp,%ebp
80103bbb:	83 ec 10             	sub    $0x10,%esp
  int i, sum;

  sum = 0;
80103bbe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103bc5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103bcc:	eb 15                	jmp    80103be3 <sum+0x2f>
    sum += addr[i];
80103bce:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103bd1:	8b 45 08             	mov    0x8(%ebp),%eax
80103bd4:	01 d0                	add    %edx,%eax
80103bd6:	0f b6 00             	movzbl (%eax),%eax
80103bd9:	0f b6 c0             	movzbl %al,%eax
80103bdc:	01 45 f8             	add    %eax,-0x8(%ebp)
  for(i=0; i<len; i++)
80103bdf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103be3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103be6:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103be9:	7c e3                	jl     80103bce <sum+0x1a>
  return sum;
80103beb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103bee:	c9                   	leave  
80103bef:	c3                   	ret    

80103bf0 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103bf0:	f3 0f 1e fb          	endbr32 
80103bf4:	55                   	push   %ebp
80103bf5:	89 e5                	mov    %esp,%ebp
80103bf7:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80103bfa:	8b 45 08             	mov    0x8(%ebp),%eax
80103bfd:	05 00 00 00 80       	add    $0x80000000,%eax
80103c02:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103c05:	8b 55 0c             	mov    0xc(%ebp),%edx
80103c08:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c0b:	01 d0                	add    %edx,%eax
80103c0d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103c10:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c13:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c16:	eb 36                	jmp    80103c4e <mpsearch1+0x5e>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103c18:	83 ec 04             	sub    $0x4,%esp
80103c1b:	6a 04                	push   $0x4
80103c1d:	68 d8 8a 10 80       	push   $0x80108ad8
80103c22:	ff 75 f4             	pushl  -0xc(%ebp)
80103c25:	e8 9e 19 00 00       	call   801055c8 <memcmp>
80103c2a:	83 c4 10             	add    $0x10,%esp
80103c2d:	85 c0                	test   %eax,%eax
80103c2f:	75 19                	jne    80103c4a <mpsearch1+0x5a>
80103c31:	83 ec 08             	sub    $0x8,%esp
80103c34:	6a 10                	push   $0x10
80103c36:	ff 75 f4             	pushl  -0xc(%ebp)
80103c39:	e8 76 ff ff ff       	call   80103bb4 <sum>
80103c3e:	83 c4 10             	add    $0x10,%esp
80103c41:	84 c0                	test   %al,%al
80103c43:	75 05                	jne    80103c4a <mpsearch1+0x5a>
      return (struct mp*)p;
80103c45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c48:	eb 11                	jmp    80103c5b <mpsearch1+0x6b>
  for(p = addr; p < e; p += sizeof(struct mp))
80103c4a:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103c4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c51:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103c54:	72 c2                	jb     80103c18 <mpsearch1+0x28>
  return 0;
80103c56:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103c5b:	c9                   	leave  
80103c5c:	c3                   	ret    

80103c5d <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103c5d:	f3 0f 1e fb          	endbr32 
80103c61:	55                   	push   %ebp
80103c62:	89 e5                	mov    %esp,%ebp
80103c64:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103c67:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103c6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c71:	83 c0 0f             	add    $0xf,%eax
80103c74:	0f b6 00             	movzbl (%eax),%eax
80103c77:	0f b6 c0             	movzbl %al,%eax
80103c7a:	c1 e0 08             	shl    $0x8,%eax
80103c7d:	89 c2                	mov    %eax,%edx
80103c7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c82:	83 c0 0e             	add    $0xe,%eax
80103c85:	0f b6 00             	movzbl (%eax),%eax
80103c88:	0f b6 c0             	movzbl %al,%eax
80103c8b:	09 d0                	or     %edx,%eax
80103c8d:	c1 e0 04             	shl    $0x4,%eax
80103c90:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103c93:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103c97:	74 21                	je     80103cba <mpsearch+0x5d>
    if((mp = mpsearch1(p, 1024)))
80103c99:	83 ec 08             	sub    $0x8,%esp
80103c9c:	68 00 04 00 00       	push   $0x400
80103ca1:	ff 75 f0             	pushl  -0x10(%ebp)
80103ca4:	e8 47 ff ff ff       	call   80103bf0 <mpsearch1>
80103ca9:	83 c4 10             	add    $0x10,%esp
80103cac:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103caf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103cb3:	74 51                	je     80103d06 <mpsearch+0xa9>
      return mp;
80103cb5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103cb8:	eb 61                	jmp    80103d1b <mpsearch+0xbe>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cbd:	83 c0 14             	add    $0x14,%eax
80103cc0:	0f b6 00             	movzbl (%eax),%eax
80103cc3:	0f b6 c0             	movzbl %al,%eax
80103cc6:	c1 e0 08             	shl    $0x8,%eax
80103cc9:	89 c2                	mov    %eax,%edx
80103ccb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cce:	83 c0 13             	add    $0x13,%eax
80103cd1:	0f b6 00             	movzbl (%eax),%eax
80103cd4:	0f b6 c0             	movzbl %al,%eax
80103cd7:	09 d0                	or     %edx,%eax
80103cd9:	c1 e0 0a             	shl    $0xa,%eax
80103cdc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103cdf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ce2:	2d 00 04 00 00       	sub    $0x400,%eax
80103ce7:	83 ec 08             	sub    $0x8,%esp
80103cea:	68 00 04 00 00       	push   $0x400
80103cef:	50                   	push   %eax
80103cf0:	e8 fb fe ff ff       	call   80103bf0 <mpsearch1>
80103cf5:	83 c4 10             	add    $0x10,%esp
80103cf8:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103cfb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103cff:	74 05                	je     80103d06 <mpsearch+0xa9>
      return mp;
80103d01:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103d04:	eb 15                	jmp    80103d1b <mpsearch+0xbe>
  }
  return mpsearch1(0xF0000, 0x10000);
80103d06:	83 ec 08             	sub    $0x8,%esp
80103d09:	68 00 00 01 00       	push   $0x10000
80103d0e:	68 00 00 0f 00       	push   $0xf0000
80103d13:	e8 d8 fe ff ff       	call   80103bf0 <mpsearch1>
80103d18:	83 c4 10             	add    $0x10,%esp
}
80103d1b:	c9                   	leave  
80103d1c:	c3                   	ret    

80103d1d <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103d1d:	f3 0f 1e fb          	endbr32 
80103d21:	55                   	push   %ebp
80103d22:	89 e5                	mov    %esp,%ebp
80103d24:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103d27:	e8 31 ff ff ff       	call   80103c5d <mpsearch>
80103d2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103d2f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103d33:	74 0a                	je     80103d3f <mpconfig+0x22>
80103d35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d38:	8b 40 04             	mov    0x4(%eax),%eax
80103d3b:	85 c0                	test   %eax,%eax
80103d3d:	75 07                	jne    80103d46 <mpconfig+0x29>
    return 0;
80103d3f:	b8 00 00 00 00       	mov    $0x0,%eax
80103d44:	eb 7a                	jmp    80103dc0 <mpconfig+0xa3>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103d46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d49:	8b 40 04             	mov    0x4(%eax),%eax
80103d4c:	05 00 00 00 80       	add    $0x80000000,%eax
80103d51:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103d54:	83 ec 04             	sub    $0x4,%esp
80103d57:	6a 04                	push   $0x4
80103d59:	68 dd 8a 10 80       	push   $0x80108add
80103d5e:	ff 75 f0             	pushl  -0x10(%ebp)
80103d61:	e8 62 18 00 00       	call   801055c8 <memcmp>
80103d66:	83 c4 10             	add    $0x10,%esp
80103d69:	85 c0                	test   %eax,%eax
80103d6b:	74 07                	je     80103d74 <mpconfig+0x57>
    return 0;
80103d6d:	b8 00 00 00 00       	mov    $0x0,%eax
80103d72:	eb 4c                	jmp    80103dc0 <mpconfig+0xa3>
  if(conf->version != 1 && conf->version != 4)
80103d74:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d77:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103d7b:	3c 01                	cmp    $0x1,%al
80103d7d:	74 12                	je     80103d91 <mpconfig+0x74>
80103d7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d82:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103d86:	3c 04                	cmp    $0x4,%al
80103d88:	74 07                	je     80103d91 <mpconfig+0x74>
    return 0;
80103d8a:	b8 00 00 00 00       	mov    $0x0,%eax
80103d8f:	eb 2f                	jmp    80103dc0 <mpconfig+0xa3>
  if(sum((uchar*)conf, conf->length) != 0)
80103d91:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d94:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103d98:	0f b7 c0             	movzwl %ax,%eax
80103d9b:	83 ec 08             	sub    $0x8,%esp
80103d9e:	50                   	push   %eax
80103d9f:	ff 75 f0             	pushl  -0x10(%ebp)
80103da2:	e8 0d fe ff ff       	call   80103bb4 <sum>
80103da7:	83 c4 10             	add    $0x10,%esp
80103daa:	84 c0                	test   %al,%al
80103dac:	74 07                	je     80103db5 <mpconfig+0x98>
    return 0;
80103dae:	b8 00 00 00 00       	mov    $0x0,%eax
80103db3:	eb 0b                	jmp    80103dc0 <mpconfig+0xa3>
  *pmp = mp;
80103db5:	8b 45 08             	mov    0x8(%ebp),%eax
80103db8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103dbb:	89 10                	mov    %edx,(%eax)
  return conf;
80103dbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103dc0:	c9                   	leave  
80103dc1:	c3                   	ret    

80103dc2 <mpinit>:

void
mpinit(void)
{
80103dc2:	f3 0f 1e fb          	endbr32 
80103dc6:	55                   	push   %ebp
80103dc7:	89 e5                	mov    %esp,%ebp
80103dc9:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103dcc:	83 ec 0c             	sub    $0xc,%esp
80103dcf:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103dd2:	50                   	push   %eax
80103dd3:	e8 45 ff ff ff       	call   80103d1d <mpconfig>
80103dd8:	83 c4 10             	add    $0x10,%esp
80103ddb:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103dde:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103de2:	75 0d                	jne    80103df1 <mpinit+0x2f>
    panic("Expect to run on an SMP");
80103de4:	83 ec 0c             	sub    $0xc,%esp
80103de7:	68 e2 8a 10 80       	push   $0x80108ae2
80103dec:	e8 e0 c7 ff ff       	call   801005d1 <panic>
  ismp = 1;
80103df1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  lapic = (uint*)conf->lapicaddr;
80103df8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103dfb:	8b 40 24             	mov    0x24(%eax),%eax
80103dfe:	a3 fc 36 11 80       	mov    %eax,0x801136fc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e03:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103e06:	83 c0 2c             	add    $0x2c,%eax
80103e09:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103e0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103e0f:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103e13:	0f b7 d0             	movzwl %ax,%edx
80103e16:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103e19:	01 d0                	add    %edx,%eax
80103e1b:	89 45 e8             	mov    %eax,-0x18(%ebp)
80103e1e:	e9 8c 00 00 00       	jmp    80103eaf <mpinit+0xed>
    switch(*p){
80103e23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e26:	0f b6 00             	movzbl (%eax),%eax
80103e29:	0f b6 c0             	movzbl %al,%eax
80103e2c:	83 f8 04             	cmp    $0x4,%eax
80103e2f:	7f 76                	jg     80103ea7 <mpinit+0xe5>
80103e31:	83 f8 03             	cmp    $0x3,%eax
80103e34:	7d 6b                	jge    80103ea1 <mpinit+0xdf>
80103e36:	83 f8 02             	cmp    $0x2,%eax
80103e39:	74 4e                	je     80103e89 <mpinit+0xc7>
80103e3b:	83 f8 02             	cmp    $0x2,%eax
80103e3e:	7f 67                	jg     80103ea7 <mpinit+0xe5>
80103e40:	85 c0                	test   %eax,%eax
80103e42:	74 07                	je     80103e4b <mpinit+0x89>
80103e44:	83 f8 01             	cmp    $0x1,%eax
80103e47:	74 58                	je     80103ea1 <mpinit+0xdf>
80103e49:	eb 5c                	jmp    80103ea7 <mpinit+0xe5>
    case MPPROC:
      proc = (struct mpproc*)p;
80103e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      if(ncpu < NCPU) {
80103e51:	a1 80 3d 11 80       	mov    0x80113d80,%eax
80103e56:	83 f8 07             	cmp    $0x7,%eax
80103e59:	7f 28                	jg     80103e83 <mpinit+0xc1>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103e5b:	8b 15 80 3d 11 80    	mov    0x80113d80,%edx
80103e61:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e64:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103e68:	69 d2 b0 00 00 00    	imul   $0xb0,%edx,%edx
80103e6e:	81 c2 00 38 11 80    	add    $0x80113800,%edx
80103e74:	88 02                	mov    %al,(%edx)
        ncpu++;
80103e76:	a1 80 3d 11 80       	mov    0x80113d80,%eax
80103e7b:	83 c0 01             	add    $0x1,%eax
80103e7e:	a3 80 3d 11 80       	mov    %eax,0x80113d80
      }
      p += sizeof(struct mpproc);
80103e83:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103e87:	eb 26                	jmp    80103eaf <mpinit+0xed>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103e89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e8c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103e8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103e92:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103e96:	a2 e0 37 11 80       	mov    %al,0x801137e0
      p += sizeof(struct mpioapic);
80103e9b:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103e9f:	eb 0e                	jmp    80103eaf <mpinit+0xed>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103ea1:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103ea5:	eb 08                	jmp    80103eaf <mpinit+0xed>
    default:
      ismp = 0;
80103ea7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      break;
80103eae:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103eaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103eb2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
80103eb5:	0f 82 68 ff ff ff    	jb     80103e23 <mpinit+0x61>
    }
  }
  if(!ismp)
80103ebb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103ebf:	75 0d                	jne    80103ece <mpinit+0x10c>
    panic("Didn't find a suitable machine");
80103ec1:	83 ec 0c             	sub    $0xc,%esp
80103ec4:	68 fc 8a 10 80       	push   $0x80108afc
80103ec9:	e8 03 c7 ff ff       	call   801005d1 <panic>

  if(mp->imcrp){
80103ece:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103ed1:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103ed5:	84 c0                	test   %al,%al
80103ed7:	74 30                	je     80103f09 <mpinit+0x147>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103ed9:	83 ec 08             	sub    $0x8,%esp
80103edc:	6a 70                	push   $0x70
80103ede:	6a 22                	push   $0x22
80103ee0:	e8 ae fc ff ff       	call   80103b93 <outb>
80103ee5:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103ee8:	83 ec 0c             	sub    $0xc,%esp
80103eeb:	6a 23                	push   $0x23
80103eed:	e8 84 fc ff ff       	call   80103b76 <inb>
80103ef2:	83 c4 10             	add    $0x10,%esp
80103ef5:	83 c8 01             	or     $0x1,%eax
80103ef8:	0f b6 c0             	movzbl %al,%eax
80103efb:	83 ec 08             	sub    $0x8,%esp
80103efe:	50                   	push   %eax
80103eff:	6a 23                	push   $0x23
80103f01:	e8 8d fc ff ff       	call   80103b93 <outb>
80103f06:	83 c4 10             	add    $0x10,%esp
  }
}
80103f09:	90                   	nop
80103f0a:	c9                   	leave  
80103f0b:	c3                   	ret    

80103f0c <outb>:
{
80103f0c:	55                   	push   %ebp
80103f0d:	89 e5                	mov    %esp,%ebp
80103f0f:	83 ec 08             	sub    $0x8,%esp
80103f12:	8b 45 08             	mov    0x8(%ebp),%eax
80103f15:	8b 55 0c             	mov    0xc(%ebp),%edx
80103f18:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103f1c:	89 d0                	mov    %edx,%eax
80103f1e:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103f21:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103f25:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103f29:	ee                   	out    %al,(%dx)
}
80103f2a:	90                   	nop
80103f2b:	c9                   	leave  
80103f2c:	c3                   	ret    

80103f2d <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103f2d:	f3 0f 1e fb          	endbr32 
80103f31:	55                   	push   %ebp
80103f32:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103f34:	68 ff 00 00 00       	push   $0xff
80103f39:	6a 21                	push   $0x21
80103f3b:	e8 cc ff ff ff       	call   80103f0c <outb>
80103f40:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103f43:	68 ff 00 00 00       	push   $0xff
80103f48:	68 a1 00 00 00       	push   $0xa1
80103f4d:	e8 ba ff ff ff       	call   80103f0c <outb>
80103f52:	83 c4 08             	add    $0x8,%esp
}
80103f55:	90                   	nop
80103f56:	c9                   	leave  
80103f57:	c3                   	ret    

80103f58 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103f58:	f3 0f 1e fb          	endbr32 
80103f5c:	55                   	push   %ebp
80103f5d:	89 e5                	mov    %esp,%ebp
80103f5f:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103f62:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103f69:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f6c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103f72:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f75:	8b 10                	mov    (%eax),%edx
80103f77:	8b 45 08             	mov    0x8(%ebp),%eax
80103f7a:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103f7c:	e8 e2 d0 ff ff       	call   80101063 <filealloc>
80103f81:	8b 55 08             	mov    0x8(%ebp),%edx
80103f84:	89 02                	mov    %eax,(%edx)
80103f86:	8b 45 08             	mov    0x8(%ebp),%eax
80103f89:	8b 00                	mov    (%eax),%eax
80103f8b:	85 c0                	test   %eax,%eax
80103f8d:	0f 84 c8 00 00 00    	je     8010405b <pipealloc+0x103>
80103f93:	e8 cb d0 ff ff       	call   80101063 <filealloc>
80103f98:	8b 55 0c             	mov    0xc(%ebp),%edx
80103f9b:	89 02                	mov    %eax,(%edx)
80103f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fa0:	8b 00                	mov    (%eax),%eax
80103fa2:	85 c0                	test   %eax,%eax
80103fa4:	0f 84 b1 00 00 00    	je     8010405b <pipealloc+0x103>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103faa:	e8 ea ed ff ff       	call   80102d99 <kalloc>
80103faf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103fb2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103fb6:	0f 84 a2 00 00 00    	je     8010405e <pipealloc+0x106>
    goto bad;
  p->readopen = 1;
80103fbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fbf:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103fc6:	00 00 00 
  p->writeopen = 1;
80103fc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fcc:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103fd3:	00 00 00 
  p->nwrite = 0;
80103fd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fd9:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103fe0:	00 00 00 
  p->nread = 0;
80103fe3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fe6:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103fed:	00 00 00 
  initlock(&p->lock, "pipe");
80103ff0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ff3:	83 ec 08             	sub    $0x8,%esp
80103ff6:	68 1b 8b 10 80       	push   $0x80108b1b
80103ffb:	50                   	push   %eax
80103ffc:	e8 97 12 00 00       	call   80105298 <initlock>
80104001:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104004:	8b 45 08             	mov    0x8(%ebp),%eax
80104007:	8b 00                	mov    (%eax),%eax
80104009:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010400f:	8b 45 08             	mov    0x8(%ebp),%eax
80104012:	8b 00                	mov    (%eax),%eax
80104014:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104018:	8b 45 08             	mov    0x8(%ebp),%eax
8010401b:	8b 00                	mov    (%eax),%eax
8010401d:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104021:	8b 45 08             	mov    0x8(%ebp),%eax
80104024:	8b 00                	mov    (%eax),%eax
80104026:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104029:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010402c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010402f:	8b 00                	mov    (%eax),%eax
80104031:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104037:	8b 45 0c             	mov    0xc(%ebp),%eax
8010403a:	8b 00                	mov    (%eax),%eax
8010403c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104040:	8b 45 0c             	mov    0xc(%ebp),%eax
80104043:	8b 00                	mov    (%eax),%eax
80104045:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80104049:	8b 45 0c             	mov    0xc(%ebp),%eax
8010404c:	8b 00                	mov    (%eax),%eax
8010404e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104051:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80104054:	b8 00 00 00 00       	mov    $0x0,%eax
80104059:	eb 51                	jmp    801040ac <pipealloc+0x154>
    goto bad;
8010405b:	90                   	nop
8010405c:	eb 01                	jmp    8010405f <pipealloc+0x107>
    goto bad;
8010405e:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
8010405f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104063:	74 0e                	je     80104073 <pipealloc+0x11b>
    kfree((char*)p);
80104065:	83 ec 0c             	sub    $0xc,%esp
80104068:	ff 75 f4             	pushl  -0xc(%ebp)
8010406b:	e8 8b ec ff ff       	call   80102cfb <kfree>
80104070:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80104073:	8b 45 08             	mov    0x8(%ebp),%eax
80104076:	8b 00                	mov    (%eax),%eax
80104078:	85 c0                	test   %eax,%eax
8010407a:	74 11                	je     8010408d <pipealloc+0x135>
    fileclose(*f0);
8010407c:	8b 45 08             	mov    0x8(%ebp),%eax
8010407f:	8b 00                	mov    (%eax),%eax
80104081:	83 ec 0c             	sub    $0xc,%esp
80104084:	50                   	push   %eax
80104085:	e8 9f d0 ff ff       	call   80101129 <fileclose>
8010408a:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010408d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104090:	8b 00                	mov    (%eax),%eax
80104092:	85 c0                	test   %eax,%eax
80104094:	74 11                	je     801040a7 <pipealloc+0x14f>
    fileclose(*f1);
80104096:	8b 45 0c             	mov    0xc(%ebp),%eax
80104099:	8b 00                	mov    (%eax),%eax
8010409b:	83 ec 0c             	sub    $0xc,%esp
8010409e:	50                   	push   %eax
8010409f:	e8 85 d0 ff ff       	call   80101129 <fileclose>
801040a4:	83 c4 10             	add    $0x10,%esp
  return -1;
801040a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040ac:	c9                   	leave  
801040ad:	c3                   	ret    

801040ae <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801040ae:	f3 0f 1e fb          	endbr32 
801040b2:	55                   	push   %ebp
801040b3:	89 e5                	mov    %esp,%ebp
801040b5:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
801040b8:	8b 45 08             	mov    0x8(%ebp),%eax
801040bb:	83 ec 0c             	sub    $0xc,%esp
801040be:	50                   	push   %eax
801040bf:	e8 fa 11 00 00       	call   801052be <acquire>
801040c4:	83 c4 10             	add    $0x10,%esp
  if(writable){
801040c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801040cb:	74 23                	je     801040f0 <pipeclose+0x42>
    p->writeopen = 0;
801040cd:	8b 45 08             	mov    0x8(%ebp),%eax
801040d0:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801040d7:	00 00 00 
    wakeup(&p->nread);
801040da:	8b 45 08             	mov    0x8(%ebp),%eax
801040dd:	05 34 02 00 00       	add    $0x234,%eax
801040e2:	83 ec 0c             	sub    $0xc,%esp
801040e5:	50                   	push   %eax
801040e6:	e8 53 0e 00 00       	call   80104f3e <wakeup>
801040eb:	83 c4 10             	add    $0x10,%esp
801040ee:	eb 21                	jmp    80104111 <pipeclose+0x63>
  } else {
    p->readopen = 0;
801040f0:	8b 45 08             	mov    0x8(%ebp),%eax
801040f3:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
801040fa:	00 00 00 
    wakeup(&p->nwrite);
801040fd:	8b 45 08             	mov    0x8(%ebp),%eax
80104100:	05 38 02 00 00       	add    $0x238,%eax
80104105:	83 ec 0c             	sub    $0xc,%esp
80104108:	50                   	push   %eax
80104109:	e8 30 0e 00 00       	call   80104f3e <wakeup>
8010410e:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104111:	8b 45 08             	mov    0x8(%ebp),%eax
80104114:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010411a:	85 c0                	test   %eax,%eax
8010411c:	75 2c                	jne    8010414a <pipeclose+0x9c>
8010411e:	8b 45 08             	mov    0x8(%ebp),%eax
80104121:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104127:	85 c0                	test   %eax,%eax
80104129:	75 1f                	jne    8010414a <pipeclose+0x9c>
    release(&p->lock);
8010412b:	8b 45 08             	mov    0x8(%ebp),%eax
8010412e:	83 ec 0c             	sub    $0xc,%esp
80104131:	50                   	push   %eax
80104132:	e8 f9 11 00 00       	call   80105330 <release>
80104137:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
8010413a:	83 ec 0c             	sub    $0xc,%esp
8010413d:	ff 75 08             	pushl  0x8(%ebp)
80104140:	e8 b6 eb ff ff       	call   80102cfb <kfree>
80104145:	83 c4 10             	add    $0x10,%esp
80104148:	eb 10                	jmp    8010415a <pipeclose+0xac>
  } else
    release(&p->lock);
8010414a:	8b 45 08             	mov    0x8(%ebp),%eax
8010414d:	83 ec 0c             	sub    $0xc,%esp
80104150:	50                   	push   %eax
80104151:	e8 da 11 00 00       	call   80105330 <release>
80104156:	83 c4 10             	add    $0x10,%esp
}
80104159:	90                   	nop
8010415a:	90                   	nop
8010415b:	c9                   	leave  
8010415c:	c3                   	ret    

8010415d <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
8010415d:	f3 0f 1e fb          	endbr32 
80104161:	55                   	push   %ebp
80104162:	89 e5                	mov    %esp,%ebp
80104164:	53                   	push   %ebx
80104165:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80104168:	8b 45 08             	mov    0x8(%ebp),%eax
8010416b:	83 ec 0c             	sub    $0xc,%esp
8010416e:	50                   	push   %eax
8010416f:	e8 4a 11 00 00       	call   801052be <acquire>
80104174:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80104177:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010417e:	e9 ad 00 00 00       	jmp    80104230 <pipewrite+0xd3>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
80104183:	8b 45 08             	mov    0x8(%ebp),%eax
80104186:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010418c:	85 c0                	test   %eax,%eax
8010418e:	74 0c                	je     8010419c <pipewrite+0x3f>
80104190:	e8 a2 02 00 00       	call   80104437 <myproc>
80104195:	8b 40 24             	mov    0x24(%eax),%eax
80104198:	85 c0                	test   %eax,%eax
8010419a:	74 19                	je     801041b5 <pipewrite+0x58>
        release(&p->lock);
8010419c:	8b 45 08             	mov    0x8(%ebp),%eax
8010419f:	83 ec 0c             	sub    $0xc,%esp
801041a2:	50                   	push   %eax
801041a3:	e8 88 11 00 00       	call   80105330 <release>
801041a8:	83 c4 10             	add    $0x10,%esp
        return -1;
801041ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801041b0:	e9 a9 00 00 00       	jmp    8010425e <pipewrite+0x101>
      }
      wakeup(&p->nread);
801041b5:	8b 45 08             	mov    0x8(%ebp),%eax
801041b8:	05 34 02 00 00       	add    $0x234,%eax
801041bd:	83 ec 0c             	sub    $0xc,%esp
801041c0:	50                   	push   %eax
801041c1:	e8 78 0d 00 00       	call   80104f3e <wakeup>
801041c6:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801041c9:	8b 45 08             	mov    0x8(%ebp),%eax
801041cc:	8b 55 08             	mov    0x8(%ebp),%edx
801041cf:	81 c2 38 02 00 00    	add    $0x238,%edx
801041d5:	83 ec 08             	sub    $0x8,%esp
801041d8:	50                   	push   %eax
801041d9:	52                   	push   %edx
801041da:	e8 6d 0c 00 00       	call   80104e4c <sleep>
801041df:	83 c4 10             	add    $0x10,%esp
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041e2:	8b 45 08             	mov    0x8(%ebp),%eax
801041e5:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
801041eb:	8b 45 08             	mov    0x8(%ebp),%eax
801041ee:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801041f4:	05 00 02 00 00       	add    $0x200,%eax
801041f9:	39 c2                	cmp    %eax,%edx
801041fb:	74 86                	je     80104183 <pipewrite+0x26>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801041fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104200:	8b 45 0c             	mov    0xc(%ebp),%eax
80104203:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80104206:	8b 45 08             	mov    0x8(%ebp),%eax
80104209:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010420f:	8d 48 01             	lea    0x1(%eax),%ecx
80104212:	8b 55 08             	mov    0x8(%ebp),%edx
80104215:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
8010421b:	25 ff 01 00 00       	and    $0x1ff,%eax
80104220:	89 c1                	mov    %eax,%ecx
80104222:	0f b6 13             	movzbl (%ebx),%edx
80104225:	8b 45 08             	mov    0x8(%ebp),%eax
80104228:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
  for(i = 0; i < n; i++){
8010422c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104230:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104233:	3b 45 10             	cmp    0x10(%ebp),%eax
80104236:	7c aa                	jl     801041e2 <pipewrite+0x85>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104238:	8b 45 08             	mov    0x8(%ebp),%eax
8010423b:	05 34 02 00 00       	add    $0x234,%eax
80104240:	83 ec 0c             	sub    $0xc,%esp
80104243:	50                   	push   %eax
80104244:	e8 f5 0c 00 00       	call   80104f3e <wakeup>
80104249:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
8010424c:	8b 45 08             	mov    0x8(%ebp),%eax
8010424f:	83 ec 0c             	sub    $0xc,%esp
80104252:	50                   	push   %eax
80104253:	e8 d8 10 00 00       	call   80105330 <release>
80104258:	83 c4 10             	add    $0x10,%esp
  return n;
8010425b:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010425e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104261:	c9                   	leave  
80104262:	c3                   	ret    

80104263 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104263:	f3 0f 1e fb          	endbr32 
80104267:	55                   	push   %ebp
80104268:	89 e5                	mov    %esp,%ebp
8010426a:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
8010426d:	8b 45 08             	mov    0x8(%ebp),%eax
80104270:	83 ec 0c             	sub    $0xc,%esp
80104273:	50                   	push   %eax
80104274:	e8 45 10 00 00       	call   801052be <acquire>
80104279:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010427c:	eb 3e                	jmp    801042bc <piperead+0x59>
    if(myproc()->killed){
8010427e:	e8 b4 01 00 00       	call   80104437 <myproc>
80104283:	8b 40 24             	mov    0x24(%eax),%eax
80104286:	85 c0                	test   %eax,%eax
80104288:	74 19                	je     801042a3 <piperead+0x40>
      release(&p->lock);
8010428a:	8b 45 08             	mov    0x8(%ebp),%eax
8010428d:	83 ec 0c             	sub    $0xc,%esp
80104290:	50                   	push   %eax
80104291:	e8 9a 10 00 00       	call   80105330 <release>
80104296:	83 c4 10             	add    $0x10,%esp
      return -1;
80104299:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010429e:	e9 be 00 00 00       	jmp    80104361 <piperead+0xfe>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801042a3:	8b 45 08             	mov    0x8(%ebp),%eax
801042a6:	8b 55 08             	mov    0x8(%ebp),%edx
801042a9:	81 c2 34 02 00 00    	add    $0x234,%edx
801042af:	83 ec 08             	sub    $0x8,%esp
801042b2:	50                   	push   %eax
801042b3:	52                   	push   %edx
801042b4:	e8 93 0b 00 00       	call   80104e4c <sleep>
801042b9:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801042bc:	8b 45 08             	mov    0x8(%ebp),%eax
801042bf:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801042c5:	8b 45 08             	mov    0x8(%ebp),%eax
801042c8:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042ce:	39 c2                	cmp    %eax,%edx
801042d0:	75 0d                	jne    801042df <piperead+0x7c>
801042d2:	8b 45 08             	mov    0x8(%ebp),%eax
801042d5:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801042db:	85 c0                	test   %eax,%eax
801042dd:	75 9f                	jne    8010427e <piperead+0x1b>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801042df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801042e6:	eb 48                	jmp    80104330 <piperead+0xcd>
    if(p->nread == p->nwrite)
801042e8:	8b 45 08             	mov    0x8(%ebp),%eax
801042eb:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801042f1:	8b 45 08             	mov    0x8(%ebp),%eax
801042f4:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042fa:	39 c2                	cmp    %eax,%edx
801042fc:	74 3c                	je     8010433a <piperead+0xd7>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801042fe:	8b 45 08             	mov    0x8(%ebp),%eax
80104301:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104307:	8d 48 01             	lea    0x1(%eax),%ecx
8010430a:	8b 55 08             	mov    0x8(%ebp),%edx
8010430d:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80104313:	25 ff 01 00 00       	and    $0x1ff,%eax
80104318:	89 c1                	mov    %eax,%ecx
8010431a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010431d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104320:	01 c2                	add    %eax,%edx
80104322:	8b 45 08             	mov    0x8(%ebp),%eax
80104325:	0f b6 44 08 34       	movzbl 0x34(%eax,%ecx,1),%eax
8010432a:	88 02                	mov    %al,(%edx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010432c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104330:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104333:	3b 45 10             	cmp    0x10(%ebp),%eax
80104336:	7c b0                	jl     801042e8 <piperead+0x85>
80104338:	eb 01                	jmp    8010433b <piperead+0xd8>
      break;
8010433a:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010433b:	8b 45 08             	mov    0x8(%ebp),%eax
8010433e:	05 38 02 00 00       	add    $0x238,%eax
80104343:	83 ec 0c             	sub    $0xc,%esp
80104346:	50                   	push   %eax
80104347:	e8 f2 0b 00 00       	call   80104f3e <wakeup>
8010434c:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
8010434f:	8b 45 08             	mov    0x8(%ebp),%eax
80104352:	83 ec 0c             	sub    $0xc,%esp
80104355:	50                   	push   %eax
80104356:	e8 d5 0f 00 00       	call   80105330 <release>
8010435b:	83 c4 10             	add    $0x10,%esp
  return i;
8010435e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104361:	c9                   	leave  
80104362:	c3                   	ret    

80104363 <readeflags>:
{
80104363:	55                   	push   %ebp
80104364:	89 e5                	mov    %esp,%ebp
80104366:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104369:	9c                   	pushf  
8010436a:	58                   	pop    %eax
8010436b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010436e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104371:	c9                   	leave  
80104372:	c3                   	ret    

80104373 <sti>:
{
80104373:	55                   	push   %ebp
80104374:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104376:	fb                   	sti    
}
80104377:	90                   	nop
80104378:	5d                   	pop    %ebp
80104379:	c3                   	ret    

8010437a <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
8010437a:	f3 0f 1e fb          	endbr32 
8010437e:	55                   	push   %ebp
8010437f:	89 e5                	mov    %esp,%ebp
80104381:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
80104384:	83 ec 08             	sub    $0x8,%esp
80104387:	68 20 8b 10 80       	push   $0x80108b20
8010438c:	68 a0 3d 11 80       	push   $0x80113da0
80104391:	e8 02 0f 00 00       	call   80105298 <initlock>
80104396:	83 c4 10             	add    $0x10,%esp
}
80104399:	90                   	nop
8010439a:	c9                   	leave  
8010439b:	c3                   	ret    

8010439c <cpuid>:

// Must be called with interrupts disabled
int
cpuid() {
8010439c:	f3 0f 1e fb          	endbr32 
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801043a6:	e8 10 00 00 00       	call   801043bb <mycpu>
801043ab:	2d 00 38 11 80       	sub    $0x80113800,%eax
801043b0:	c1 f8 04             	sar    $0x4,%eax
801043b3:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801043b9:	c9                   	leave  
801043ba:	c3                   	ret    

801043bb <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801043bb:	f3 0f 1e fb          	endbr32 
801043bf:	55                   	push   %ebp
801043c0:	89 e5                	mov    %esp,%ebp
801043c2:	83 ec 18             	sub    $0x18,%esp
  int apicid, i;
  
  if(readeflags()&FL_IF)
801043c5:	e8 99 ff ff ff       	call   80104363 <readeflags>
801043ca:	25 00 02 00 00       	and    $0x200,%eax
801043cf:	85 c0                	test   %eax,%eax
801043d1:	74 0d                	je     801043e0 <mycpu+0x25>
    panic("mycpu called with interrupts enabled\n");
801043d3:	83 ec 0c             	sub    $0xc,%esp
801043d6:	68 28 8b 10 80       	push   $0x80108b28
801043db:	e8 f1 c1 ff ff       	call   801005d1 <panic>
  
  apicid = lapicid();
801043e0:	e8 21 ed ff ff       	call   80103106 <lapicid>
801043e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801043e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801043ef:	eb 2d                	jmp    8010441e <mycpu+0x63>
    if (cpus[i].apicid == apicid)
801043f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043f4:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801043fa:	05 00 38 11 80       	add    $0x80113800,%eax
801043ff:	0f b6 00             	movzbl (%eax),%eax
80104402:	0f b6 c0             	movzbl %al,%eax
80104405:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80104408:	75 10                	jne    8010441a <mycpu+0x5f>
      return &cpus[i];
8010440a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010440d:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80104413:	05 00 38 11 80       	add    $0x80113800,%eax
80104418:	eb 1b                	jmp    80104435 <mycpu+0x7a>
  for (i = 0; i < ncpu; ++i) {
8010441a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010441e:	a1 80 3d 11 80       	mov    0x80113d80,%eax
80104423:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104426:	7c c9                	jl     801043f1 <mycpu+0x36>
  }
  panic("unknown apicid\n");
80104428:	83 ec 0c             	sub    $0xc,%esp
8010442b:	68 4e 8b 10 80       	push   $0x80108b4e
80104430:	e8 9c c1 ff ff       	call   801005d1 <panic>
}
80104435:	c9                   	leave  
80104436:	c3                   	ret    

80104437 <myproc>:

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80104437:	f3 0f 1e fb          	endbr32 
8010443b:	55                   	push   %ebp
8010443c:	89 e5                	mov    %esp,%ebp
8010443e:	83 ec 18             	sub    $0x18,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80104441:	e8 04 10 00 00       	call   8010544a <pushcli>
  c = mycpu();
80104446:	e8 70 ff ff ff       	call   801043bb <mycpu>
8010444b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  p = c->proc;
8010444e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104451:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104457:	89 45 f0             	mov    %eax,-0x10(%ebp)
  popcli();
8010445a:	e8 3c 10 00 00       	call   8010549b <popcli>
  return p;
8010445f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80104462:	c9                   	leave  
80104463:	c3                   	ret    

80104464 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104464:	f3 0f 1e fb          	endbr32 
80104468:	55                   	push   %ebp
80104469:	89 e5                	mov    %esp,%ebp
8010446b:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010446e:	83 ec 0c             	sub    $0xc,%esp
80104471:	68 a0 3d 11 80       	push   $0x80113da0
80104476:	e8 43 0e 00 00       	call   801052be <acquire>
8010447b:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010447e:	c7 45 f4 d4 3d 11 80 	movl   $0x80113dd4,-0xc(%ebp)
80104485:	eb 11                	jmp    80104498 <allocproc+0x34>
    if(p->state == UNUSED)
80104487:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010448a:	8b 40 0c             	mov    0xc(%eax),%eax
8010448d:	85 c0                	test   %eax,%eax
8010448f:	74 2a                	je     801044bb <allocproc+0x57>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104491:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104498:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
8010449f:	72 e6                	jb     80104487 <allocproc+0x23>
      goto found;

  release(&ptable.lock);
801044a1:	83 ec 0c             	sub    $0xc,%esp
801044a4:	68 a0 3d 11 80       	push   $0x80113da0
801044a9:	e8 82 0e 00 00       	call   80105330 <release>
801044ae:	83 c4 10             	add    $0x10,%esp
  return 0;
801044b1:	b8 00 00 00 00       	mov    $0x0,%eax
801044b6:	e9 da 00 00 00       	jmp    80104595 <allocproc+0x131>
      goto found;
801044bb:	90                   	nop
801044bc:	f3 0f 1e fb          	endbr32 

found:
  p->state = EMBRYO;
801044c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044c3:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
801044ca:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801044cf:	8d 50 01             	lea    0x1(%eax),%edx
801044d2:	89 15 00 b0 10 80    	mov    %edx,0x8010b000
801044d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044db:	89 42 10             	mov    %eax,0x10(%edx)
  p->tickets = 1;
801044de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044e1:	c7 40 7c 01 00 00 00 	movl   $0x1,0x7c(%eax)
  p->ticksAcc = 0;
801044e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044eb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801044f2:	00 00 00 
  p->inuse = 0;
801044f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044f8:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
801044ff:	00 00 00 
  release(&ptable.lock);
80104502:	83 ec 0c             	sub    $0xc,%esp
80104505:	68 a0 3d 11 80       	push   $0x80113da0
8010450a:	e8 21 0e 00 00       	call   80105330 <release>
8010450f:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104512:	e8 82 e8 ff ff       	call   80102d99 <kalloc>
80104517:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010451a:	89 42 08             	mov    %eax,0x8(%edx)
8010451d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104520:	8b 40 08             	mov    0x8(%eax),%eax
80104523:	85 c0                	test   %eax,%eax
80104525:	75 11                	jne    80104538 <allocproc+0xd4>
    p->state = UNUSED;
80104527:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010452a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104531:	b8 00 00 00 00       	mov    $0x0,%eax
80104536:	eb 5d                	jmp    80104595 <allocproc+0x131>
  }
  sp = p->kstack + KSTACKSIZE;
80104538:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010453b:	8b 40 08             	mov    0x8(%eax),%eax
8010453e:	05 00 10 00 00       	add    $0x1000,%eax
80104543:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104546:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
8010454a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010454d:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104550:	89 50 18             	mov    %edx,0x18(%eax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80104553:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
80104557:	ba 0f 6a 10 80       	mov    $0x80106a0f,%edx
8010455c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010455f:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104561:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
80104565:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104568:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010456b:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
8010456e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104571:	8b 40 1c             	mov    0x1c(%eax),%eax
80104574:	83 ec 04             	sub    $0x4,%esp
80104577:	6a 14                	push   $0x14
80104579:	6a 00                	push   $0x0
8010457b:	50                   	push   %eax
8010457c:	e8 dc 0f 00 00       	call   8010555d <memset>
80104581:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104584:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104587:	8b 40 1c             	mov    0x1c(%eax),%eax
8010458a:	ba 02 4e 10 80       	mov    $0x80104e02,%edx
8010458f:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104592:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104595:	c9                   	leave  
80104596:	c3                   	ret    

80104597 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104597:	f3 0f 1e fb          	endbr32 
8010459b:	55                   	push   %ebp
8010459c:	89 e5                	mov    %esp,%ebp
8010459e:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801045a1:	e8 be fe ff ff       	call   80104464 <allocproc>
801045a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  initproc = p;
801045a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ac:	a3 20 b6 10 80       	mov    %eax,0x8010b620
  if((p->pgdir = setupkvm()) == 0)
801045b1:	e8 cb 39 00 00       	call   80107f81 <setupkvm>
801045b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045b9:	89 42 04             	mov    %eax,0x4(%edx)
801045bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045bf:	8b 40 04             	mov    0x4(%eax),%eax
801045c2:	85 c0                	test   %eax,%eax
801045c4:	75 0d                	jne    801045d3 <userinit+0x3c>
    panic("userinit: out of memory?");
801045c6:	83 ec 0c             	sub    $0xc,%esp
801045c9:	68 5e 8b 10 80       	push   $0x80108b5e
801045ce:	e8 fe bf ff ff       	call   801005d1 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801045d3:	ba 2c 00 00 00       	mov    $0x2c,%edx
801045d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045db:	8b 40 04             	mov    0x4(%eax),%eax
801045de:	83 ec 04             	sub    $0x4,%esp
801045e1:	52                   	push   %edx
801045e2:	68 c0 b4 10 80       	push   $0x8010b4c0
801045e7:	50                   	push   %eax
801045e8:	e8 0d 3c 00 00       	call   801081fa <inituvm>
801045ed:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
801045f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045f3:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
801045f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045fc:	8b 40 18             	mov    0x18(%eax),%eax
801045ff:	83 ec 04             	sub    $0x4,%esp
80104602:	6a 4c                	push   $0x4c
80104604:	6a 00                	push   $0x0
80104606:	50                   	push   %eax
80104607:	e8 51 0f 00 00       	call   8010555d <memset>
8010460c:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010460f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104612:	8b 40 18             	mov    0x18(%eax),%eax
80104615:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010461b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010461e:	8b 40 18             	mov    0x18(%eax),%eax
80104621:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104627:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010462a:	8b 50 18             	mov    0x18(%eax),%edx
8010462d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104630:	8b 40 18             	mov    0x18(%eax),%eax
80104633:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104637:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010463b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010463e:	8b 50 18             	mov    0x18(%eax),%edx
80104641:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104644:	8b 40 18             	mov    0x18(%eax),%eax
80104647:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
8010464b:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010464f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104652:	8b 40 18             	mov    0x18(%eax),%eax
80104655:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
8010465c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010465f:	8b 40 18             	mov    0x18(%eax),%eax
80104662:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104669:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010466c:	8b 40 18             	mov    0x18(%eax),%eax
8010466f:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104676:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104679:	83 c0 6c             	add    $0x6c,%eax
8010467c:	83 ec 04             	sub    $0x4,%esp
8010467f:	6a 10                	push   $0x10
80104681:	68 77 8b 10 80       	push   $0x80108b77
80104686:	50                   	push   %eax
80104687:	e8 ec 10 00 00       	call   80105778 <safestrcpy>
8010468c:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
8010468f:	83 ec 0c             	sub    $0xc,%esp
80104692:	68 80 8b 10 80       	push   $0x80108b80
80104697:	e8 78 df ff ff       	call   80102614 <namei>
8010469c:	83 c4 10             	add    $0x10,%esp
8010469f:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046a2:	89 42 68             	mov    %eax,0x68(%edx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
801046a5:	83 ec 0c             	sub    $0xc,%esp
801046a8:	68 a0 3d 11 80       	push   $0x80113da0
801046ad:	e8 0c 0c 00 00       	call   801052be <acquire>
801046b2:	83 c4 10             	add    $0x10,%esp

  p->state = RUNNABLE;
801046b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046b8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
801046bf:	83 ec 0c             	sub    $0xc,%esp
801046c2:	68 a0 3d 11 80       	push   $0x80113da0
801046c7:	e8 64 0c 00 00       	call   80105330 <release>
801046cc:	83 c4 10             	add    $0x10,%esp
}
801046cf:	90                   	nop
801046d0:	c9                   	leave  
801046d1:	c3                   	ret    

801046d2 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801046d2:	f3 0f 1e fb          	endbr32 
801046d6:	55                   	push   %ebp
801046d7:	89 e5                	mov    %esp,%ebp
801046d9:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  struct proc *curproc = myproc();
801046dc:	e8 56 fd ff ff       	call   80104437 <myproc>
801046e1:	89 45 f0             	mov    %eax,-0x10(%ebp)

  sz = curproc->sz;
801046e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801046e7:	8b 00                	mov    (%eax),%eax
801046e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
801046ec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801046f0:	7e 2e                	jle    80104720 <growproc+0x4e>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801046f2:	8b 55 08             	mov    0x8(%ebp),%edx
801046f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046f8:	01 c2                	add    %eax,%edx
801046fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801046fd:	8b 40 04             	mov    0x4(%eax),%eax
80104700:	83 ec 04             	sub    $0x4,%esp
80104703:	52                   	push   %edx
80104704:	ff 75 f4             	pushl  -0xc(%ebp)
80104707:	50                   	push   %eax
80104708:	e8 32 3c 00 00       	call   8010833f <allocuvm>
8010470d:	83 c4 10             	add    $0x10,%esp
80104710:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104713:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104717:	75 3b                	jne    80104754 <growproc+0x82>
      return -1;
80104719:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010471e:	eb 4f                	jmp    8010476f <growproc+0x9d>
  } else if(n < 0){
80104720:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104724:	79 2e                	jns    80104754 <growproc+0x82>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104726:	8b 55 08             	mov    0x8(%ebp),%edx
80104729:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010472c:	01 c2                	add    %eax,%edx
8010472e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104731:	8b 40 04             	mov    0x4(%eax),%eax
80104734:	83 ec 04             	sub    $0x4,%esp
80104737:	52                   	push   %edx
80104738:	ff 75 f4             	pushl  -0xc(%ebp)
8010473b:	50                   	push   %eax
8010473c:	e8 07 3d 00 00       	call   80108448 <deallocuvm>
80104741:	83 c4 10             	add    $0x10,%esp
80104744:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104747:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010474b:	75 07                	jne    80104754 <growproc+0x82>
      return -1;
8010474d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104752:	eb 1b                	jmp    8010476f <growproc+0x9d>
  }
  curproc->sz = sz;
80104754:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104757:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010475a:	89 10                	mov    %edx,(%eax)
  switchuvm(curproc);
8010475c:	83 ec 0c             	sub    $0xc,%esp
8010475f:	ff 75 f0             	pushl  -0x10(%ebp)
80104762:	e8 f0 38 00 00       	call   80108057 <switchuvm>
80104767:	83 c4 10             	add    $0x10,%esp
  return 0;
8010476a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010476f:	c9                   	leave  
80104770:	c3                   	ret    

80104771 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104771:	f3 0f 1e fb          	endbr32 
80104775:	55                   	push   %ebp
80104776:	89 e5                	mov    %esp,%ebp
80104778:	57                   	push   %edi
80104779:	56                   	push   %esi
8010477a:	53                   	push   %ebx
8010477b:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();
8010477e:	e8 b4 fc ff ff       	call   80104437 <myproc>
80104783:	89 45 e0             	mov    %eax,-0x20(%ebp)

  // Allocate process.
  if((np = allocproc()) == 0){
80104786:	e8 d9 fc ff ff       	call   80104464 <allocproc>
8010478b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010478e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
80104792:	75 0a                	jne    8010479e <fork+0x2d>
    return -1;
80104794:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104799:	e9 61 01 00 00       	jmp    801048ff <fork+0x18e>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010479e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047a1:	8b 10                	mov    (%eax),%edx
801047a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047a6:	8b 40 04             	mov    0x4(%eax),%eax
801047a9:	83 ec 08             	sub    $0x8,%esp
801047ac:	52                   	push   %edx
801047ad:	50                   	push   %eax
801047ae:	e8 3f 3e 00 00       	call   801085f2 <copyuvm>
801047b3:	83 c4 10             	add    $0x10,%esp
801047b6:	8b 55 dc             	mov    -0x24(%ebp),%edx
801047b9:	89 42 04             	mov    %eax,0x4(%edx)
801047bc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801047bf:	8b 40 04             	mov    0x4(%eax),%eax
801047c2:	85 c0                	test   %eax,%eax
801047c4:	75 30                	jne    801047f6 <fork+0x85>
    kfree(np->kstack);
801047c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801047c9:	8b 40 08             	mov    0x8(%eax),%eax
801047cc:	83 ec 0c             	sub    $0xc,%esp
801047cf:	50                   	push   %eax
801047d0:	e8 26 e5 ff ff       	call   80102cfb <kfree>
801047d5:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
801047d8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801047db:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
801047e2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801047e5:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
801047ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047f1:	e9 09 01 00 00       	jmp    801048ff <fork+0x18e>
  }
  np->sz = curproc->sz;
801047f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047f9:	8b 10                	mov    (%eax),%edx
801047fb:	8b 45 dc             	mov    -0x24(%ebp),%eax
801047fe:	89 10                	mov    %edx,(%eax)
  np->parent = curproc;
80104800:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104803:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104806:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *curproc->tf;
80104809:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010480c:	8b 48 18             	mov    0x18(%eax),%ecx
8010480f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104812:	8b 40 18             	mov    0x18(%eax),%eax
80104815:	89 c2                	mov    %eax,%edx
80104817:	89 cb                	mov    %ecx,%ebx
80104819:	b8 13 00 00 00       	mov    $0x13,%eax
8010481e:	89 d7                	mov    %edx,%edi
80104820:	89 de                	mov    %ebx,%esi
80104822:	89 c1                	mov    %eax,%ecx
80104824:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tickets = curproc->tickets;
80104826:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104829:	8b 50 7c             	mov    0x7c(%eax),%edx
8010482c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010482f:	89 50 7c             	mov    %edx,0x7c(%eax)
  np->ticksAcc = 0;
80104832:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104835:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010483c:	00 00 00 
  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
8010483f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104842:	8b 40 18             	mov    0x18(%eax),%eax
80104845:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
8010484c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104853:	eb 3b                	jmp    80104890 <fork+0x11f>
    if(curproc->ofile[i])
80104855:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104858:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010485b:	83 c2 08             	add    $0x8,%edx
8010485e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104862:	85 c0                	test   %eax,%eax
80104864:	74 26                	je     8010488c <fork+0x11b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104866:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104869:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010486c:	83 c2 08             	add    $0x8,%edx
8010486f:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104873:	83 ec 0c             	sub    $0xc,%esp
80104876:	50                   	push   %eax
80104877:	e8 58 c8 ff ff       	call   801010d4 <filedup>
8010487c:	83 c4 10             	add    $0x10,%esp
8010487f:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104882:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104885:	83 c1 08             	add    $0x8,%ecx
80104888:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  for(i = 0; i < NOFILE; i++)
8010488c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104890:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104894:	7e bf                	jle    80104855 <fork+0xe4>
  np->cwd = idup(curproc->cwd);
80104896:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104899:	8b 40 68             	mov    0x68(%eax),%eax
8010489c:	83 ec 0c             	sub    $0xc,%esp
8010489f:	50                   	push   %eax
801048a0:	e8 c6 d1 ff ff       	call   80101a6b <idup>
801048a5:	83 c4 10             	add    $0x10,%esp
801048a8:	8b 55 dc             	mov    -0x24(%ebp),%edx
801048ab:	89 42 68             	mov    %eax,0x68(%edx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801048ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048b1:	8d 50 6c             	lea    0x6c(%eax),%edx
801048b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801048b7:	83 c0 6c             	add    $0x6c,%eax
801048ba:	83 ec 04             	sub    $0x4,%esp
801048bd:	6a 10                	push   $0x10
801048bf:	52                   	push   %edx
801048c0:	50                   	push   %eax
801048c1:	e8 b2 0e 00 00       	call   80105778 <safestrcpy>
801048c6:	83 c4 10             	add    $0x10,%esp

  pid = np->pid;
801048c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801048cc:	8b 40 10             	mov    0x10(%eax),%eax
801048cf:	89 45 d8             	mov    %eax,-0x28(%ebp)

  acquire(&ptable.lock);
801048d2:	83 ec 0c             	sub    $0xc,%esp
801048d5:	68 a0 3d 11 80       	push   $0x80113da0
801048da:	e8 df 09 00 00       	call   801052be <acquire>
801048df:	83 c4 10             	add    $0x10,%esp

  np->state = RUNNABLE;
801048e2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801048e5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
801048ec:	83 ec 0c             	sub    $0xc,%esp
801048ef:	68 a0 3d 11 80       	push   $0x80113da0
801048f4:	e8 37 0a 00 00       	call   80105330 <release>
801048f9:	83 c4 10             	add    $0x10,%esp

  return pid;
801048fc:	8b 45 d8             	mov    -0x28(%ebp),%eax
}
801048ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104902:	5b                   	pop    %ebx
80104903:	5e                   	pop    %esi
80104904:	5f                   	pop    %edi
80104905:	5d                   	pop    %ebp
80104906:	c3                   	ret    

80104907 <fill>:

int
fill(struct pstat* st)
{
80104907:	f3 0f 1e fb          	endbr32 
8010490b:	55                   	push   %ebp
8010490c:	89 e5                	mov    %esp,%ebp
8010490e:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104911:	83 ec 0c             	sub    $0xc,%esp
80104914:	68 a0 3d 11 80       	push   $0x80113da0
80104919:	e8 a0 09 00 00       	call   801052be <acquire>
8010491e:	83 c4 10             	add    $0x10,%esp
  int i = 0;
80104921:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104928:	c7 45 f4 d4 3d 11 80 	movl   $0x80113dd4,-0xc(%ebp)
8010492f:	eb 59                	jmp    8010498a <fill+0x83>
    st->pid[i] = p->pid;
80104931:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104934:	8b 50 10             	mov    0x10(%eax),%edx
80104937:	8b 45 08             	mov    0x8(%ebp),%eax
8010493a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010493d:	83 e9 80             	sub    $0xffffff80,%ecx
80104940:	89 14 88             	mov    %edx,(%eax,%ecx,4)
    st->tickets[i] = p->tickets;
80104943:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104946:	8b 50 7c             	mov    0x7c(%eax),%edx
80104949:	8b 45 08             	mov    0x8(%ebp),%eax
8010494c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010494f:	83 c1 40             	add    $0x40,%ecx
80104952:	89 14 88             	mov    %edx,(%eax,%ecx,4)
    st->inuse[i] = p->inuse;
80104955:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104958:	8b 88 84 00 00 00    	mov    0x84(%eax),%ecx
8010495e:	8b 45 08             	mov    0x8(%ebp),%eax
80104961:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104964:	89 0c 90             	mov    %ecx,(%eax,%edx,4)
    st->ticks[i] = p->ticksAcc;
80104967:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010496a:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80104970:	8b 45 08             	mov    0x8(%ebp),%eax
80104973:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80104976:	81 c1 c0 00 00 00    	add    $0xc0,%ecx
8010497c:	89 14 88             	mov    %edx,(%eax,%ecx,4)
    i++;
8010497f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104983:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
8010498a:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
80104991:	72 9e                	jb     80104931 <fill+0x2a>
  }
  release(&ptable.lock);
80104993:	83 ec 0c             	sub    $0xc,%esp
80104996:	68 a0 3d 11 80       	push   $0x80113da0
8010499b:	e8 90 09 00 00       	call   80105330 <release>
801049a0:	83 c4 10             	add    $0x10,%esp
  return 0;
801049a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801049a8:	c9                   	leave  
801049a9:	c3                   	ret    

801049aa <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
801049aa:	f3 0f 1e fb          	endbr32 
801049ae:	55                   	push   %ebp
801049af:	89 e5                	mov    %esp,%ebp
801049b1:	83 ec 18             	sub    $0x18,%esp
  struct proc *curproc = myproc();
801049b4:	e8 7e fa ff ff       	call   80104437 <myproc>
801049b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct proc *p;
  int fd;

  if(curproc == initproc)
801049bc:	a1 20 b6 10 80       	mov    0x8010b620,%eax
801049c1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
801049c4:	75 0d                	jne    801049d3 <exit+0x29>
    panic("init exiting");
801049c6:	83 ec 0c             	sub    $0xc,%esp
801049c9:	68 82 8b 10 80       	push   $0x80108b82
801049ce:	e8 fe bb ff ff       	call   801005d1 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801049d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801049da:	eb 3f                	jmp    80104a1b <exit+0x71>
    if(curproc->ofile[fd]){
801049dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801049df:	8b 55 f0             	mov    -0x10(%ebp),%edx
801049e2:	83 c2 08             	add    $0x8,%edx
801049e5:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801049e9:	85 c0                	test   %eax,%eax
801049eb:	74 2a                	je     80104a17 <exit+0x6d>
      fileclose(curproc->ofile[fd]);
801049ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
801049f0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801049f3:	83 c2 08             	add    $0x8,%edx
801049f6:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801049fa:	83 ec 0c             	sub    $0xc,%esp
801049fd:	50                   	push   %eax
801049fe:	e8 26 c7 ff ff       	call   80101129 <fileclose>
80104a03:	83 c4 10             	add    $0x10,%esp
      curproc->ofile[fd] = 0;
80104a06:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a09:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a0c:	83 c2 08             	add    $0x8,%edx
80104a0f:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104a16:	00 
  for(fd = 0; fd < NOFILE; fd++){
80104a17:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104a1b:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104a1f:	7e bb                	jle    801049dc <exit+0x32>
    }
  }

  begin_op();
80104a21:	e8 52 ec ff ff       	call   80103678 <begin_op>
  iput(curproc->cwd);
80104a26:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a29:	8b 40 68             	mov    0x68(%eax),%eax
80104a2c:	83 ec 0c             	sub    $0xc,%esp
80104a2f:	50                   	push   %eax
80104a30:	e8 dd d1 ff ff       	call   80101c12 <iput>
80104a35:	83 c4 10             	add    $0x10,%esp
  end_op();
80104a38:	e8 cb ec ff ff       	call   80103708 <end_op>
  curproc->cwd = 0;
80104a3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a40:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104a47:	83 ec 0c             	sub    $0xc,%esp
80104a4a:	68 a0 3d 11 80       	push   $0x80113da0
80104a4f:	e8 6a 08 00 00       	call   801052be <acquire>
80104a54:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80104a57:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a5a:	8b 40 14             	mov    0x14(%eax),%eax
80104a5d:	83 ec 0c             	sub    $0xc,%esp
80104a60:	50                   	push   %eax
80104a61:	e8 91 04 00 00       	call   80104ef7 <wakeup1>
80104a66:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a69:	c7 45 f4 d4 3d 11 80 	movl   $0x80113dd4,-0xc(%ebp)
80104a70:	eb 3a                	jmp    80104aac <exit+0x102>
    if(p->parent == curproc){
80104a72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a75:	8b 40 14             	mov    0x14(%eax),%eax
80104a78:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104a7b:	75 28                	jne    80104aa5 <exit+0xfb>
      p->parent = initproc;
80104a7d:	8b 15 20 b6 10 80    	mov    0x8010b620,%edx
80104a83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a86:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a8c:	8b 40 0c             	mov    0xc(%eax),%eax
80104a8f:	83 f8 05             	cmp    $0x5,%eax
80104a92:	75 11                	jne    80104aa5 <exit+0xfb>
        wakeup1(initproc);
80104a94:	a1 20 b6 10 80       	mov    0x8010b620,%eax
80104a99:	83 ec 0c             	sub    $0xc,%esp
80104a9c:	50                   	push   %eax
80104a9d:	e8 55 04 00 00       	call   80104ef7 <wakeup1>
80104aa2:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aa5:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104aac:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
80104ab3:	72 bd                	jb     80104a72 <exit+0xc8>
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80104ab5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104ab8:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104abf:	e8 43 02 00 00       	call   80104d07 <sched>
  panic("zombie exit");
80104ac4:	83 ec 0c             	sub    $0xc,%esp
80104ac7:	68 8f 8b 10 80       	push   $0x80108b8f
80104acc:	e8 00 bb ff ff       	call   801005d1 <panic>

80104ad1 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104ad1:	f3 0f 1e fb          	endbr32 
80104ad5:	55                   	push   %ebp
80104ad6:	89 e5                	mov    %esp,%ebp
80104ad8:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80104adb:	e8 57 f9 ff ff       	call   80104437 <myproc>
80104ae0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
  acquire(&ptable.lock);
80104ae3:	83 ec 0c             	sub    $0xc,%esp
80104ae6:	68 a0 3d 11 80       	push   $0x80113da0
80104aeb:	e8 ce 07 00 00       	call   801052be <acquire>
80104af0:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80104af3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104afa:	c7 45 f4 d4 3d 11 80 	movl   $0x80113dd4,-0xc(%ebp)
80104b01:	e9 a4 00 00 00       	jmp    80104baa <wait+0xd9>
      if(p->parent != curproc)
80104b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b09:	8b 40 14             	mov    0x14(%eax),%eax
80104b0c:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104b0f:	0f 85 8d 00 00 00    	jne    80104ba2 <wait+0xd1>
        continue;
      havekids = 1;
80104b15:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b1f:	8b 40 0c             	mov    0xc(%eax),%eax
80104b22:	83 f8 05             	cmp    $0x5,%eax
80104b25:	75 7c                	jne    80104ba3 <wait+0xd2>
        // Found one.
        pid = p->pid;
80104b27:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b2a:	8b 40 10             	mov    0x10(%eax),%eax
80104b2d:	89 45 e8             	mov    %eax,-0x18(%ebp)
        kfree(p->kstack);
80104b30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b33:	8b 40 08             	mov    0x8(%eax),%eax
80104b36:	83 ec 0c             	sub    $0xc,%esp
80104b39:	50                   	push   %eax
80104b3a:	e8 bc e1 ff ff       	call   80102cfb <kfree>
80104b3f:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104b42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b45:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b4f:	8b 40 04             	mov    0x4(%eax),%eax
80104b52:	83 ec 0c             	sub    $0xc,%esp
80104b55:	50                   	push   %eax
80104b56:	e8 b5 39 00 00       	call   80108510 <freevm>
80104b5b:	83 c4 10             	add    $0x10,%esp
        p->pid = 0;
80104b5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b61:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b6b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104b72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b75:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104b79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b7c:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->state = UNUSED;
80104b83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b86:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        release(&ptable.lock);
80104b8d:	83 ec 0c             	sub    $0xc,%esp
80104b90:	68 a0 3d 11 80       	push   $0x80113da0
80104b95:	e8 96 07 00 00       	call   80105330 <release>
80104b9a:	83 c4 10             	add    $0x10,%esp
        return pid;
80104b9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104ba0:	eb 54                	jmp    80104bf6 <wait+0x125>
        continue;
80104ba2:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ba3:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104baa:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
80104bb1:	0f 82 4f ff ff ff    	jb     80104b06 <wait+0x35>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104bb7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104bbb:	74 0a                	je     80104bc7 <wait+0xf6>
80104bbd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104bc0:	8b 40 24             	mov    0x24(%eax),%eax
80104bc3:	85 c0                	test   %eax,%eax
80104bc5:	74 17                	je     80104bde <wait+0x10d>
      release(&ptable.lock);
80104bc7:	83 ec 0c             	sub    $0xc,%esp
80104bca:	68 a0 3d 11 80       	push   $0x80113da0
80104bcf:	e8 5c 07 00 00       	call   80105330 <release>
80104bd4:	83 c4 10             	add    $0x10,%esp
      return -1;
80104bd7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bdc:	eb 18                	jmp    80104bf6 <wait+0x125>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104bde:	83 ec 08             	sub    $0x8,%esp
80104be1:	68 a0 3d 11 80       	push   $0x80113da0
80104be6:	ff 75 ec             	pushl  -0x14(%ebp)
80104be9:	e8 5e 02 00 00       	call   80104e4c <sleep>
80104bee:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104bf1:	e9 fd fe ff ff       	jmp    80104af3 <wait+0x22>
  }
}
80104bf6:	c9                   	leave  
80104bf7:	c3                   	ret    

80104bf8 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104bf8:	f3 0f 1e fb          	endbr32 
80104bfc:	55                   	push   %ebp
80104bfd:	89 e5                	mov    %esp,%ebp
80104bff:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80104c02:	e8 b4 f7 ff ff       	call   801043bb <mycpu>
80104c07:	89 45 ec             	mov    %eax,-0x14(%ebp)
  c->proc = 0;
80104c0a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104c0d:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104c14:	00 00 00 
  
  for(;;){
    // Enable interrupts on this processor.
    sti();
80104c17:	e8 57 f7 ff ff       	call   80104373 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104c1c:	83 ec 0c             	sub    $0xc,%esp
80104c1f:	68 a0 3d 11 80       	push   $0x80113da0
80104c24:	e8 95 06 00 00       	call   801052be <acquire>
80104c29:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c2c:	c7 45 f4 d4 3d 11 80 	movl   $0x80113dd4,-0xc(%ebp)
80104c33:	e9 ad 00 00 00       	jmp    80104ce5 <scheduler+0xed>
      if(p->state != RUNNABLE)
80104c38:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c3b:	8b 40 0c             	mov    0xc(%eax),%eax
80104c3e:	83 f8 03             	cmp    $0x3,%eax
80104c41:	0f 85 96 00 00 00    	jne    80104cdd <scheduler+0xe5>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80104c47:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104c4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c4d:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
      switchuvm(p);
80104c53:	83 ec 0c             	sub    $0xc,%esp
80104c56:	ff 75 f4             	pushl  -0xc(%ebp)
80104c59:	e8 f9 33 00 00       	call   80108057 <switchuvm>
80104c5e:	83 c4 10             	add    $0x10,%esp
      int i = 1;
80104c61:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        while(i<=p->tickets && p->state == RUNNABLE){
80104c68:	eb 49                	jmp    80104cb3 <scheduler+0xbb>
      		p->state = RUNNING;
80104c6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c6d:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
		p->inuse = 1;
80104c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c77:	c7 80 84 00 00 00 01 	movl   $0x1,0x84(%eax)
80104c7e:	00 00 00 
		p->ticksAcc++;
80104c81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c84:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104c8a:	8d 50 01             	lea    0x1(%eax),%edx
80104c8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c90:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
//		if(p->pid == 7 || p->pid == 5 || p->pid == 6) {
//			cprintf("%d\n", p->pid);
//		}
      		i++;
80104c96:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
		swtch(&(c->scheduler), p->context);
80104c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c9d:	8b 40 1c             	mov    0x1c(%eax),%eax
80104ca0:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104ca3:	83 c2 04             	add    $0x4,%edx
80104ca6:	83 ec 08             	sub    $0x8,%esp
80104ca9:	50                   	push   %eax
80104caa:	52                   	push   %edx
80104cab:	e8 41 0b 00 00       	call   801057f1 <swtch>
80104cb0:	83 c4 10             	add    $0x10,%esp
        while(i<=p->tickets && p->state == RUNNABLE){
80104cb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cb6:	8b 40 7c             	mov    0x7c(%eax),%eax
80104cb9:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80104cbc:	7f 0b                	jg     80104cc9 <scheduler+0xd1>
80104cbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cc1:	8b 40 0c             	mov    0xc(%eax),%eax
80104cc4:	83 f8 03             	cmp    $0x3,%eax
80104cc7:	74 a1                	je     80104c6a <scheduler+0x72>
	}
//	if(p->pid == 7 || p->pid == 5 || p->pid == 6)
//		cprintf("Accumulated ticks for pid %d is %d\n", p->pid, p->ticksAcc);
	switchkvm();
80104cc9:	e8 6c 33 00 00       	call   8010803a <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80104cce:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104cd1:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104cd8:	00 00 00 
80104cdb:	eb 01                	jmp    80104cde <scheduler+0xe6>
        continue;
80104cdd:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cde:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104ce5:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
80104cec:	0f 82 46 ff ff ff    	jb     80104c38 <scheduler+0x40>
    }
    release(&ptable.lock);
80104cf2:	83 ec 0c             	sub    $0xc,%esp
80104cf5:	68 a0 3d 11 80       	push   $0x80113da0
80104cfa:	e8 31 06 00 00       	call   80105330 <release>
80104cff:	83 c4 10             	add    $0x10,%esp
    sti();
80104d02:	e9 10 ff ff ff       	jmp    80104c17 <scheduler+0x1f>

80104d07 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80104d07:	f3 0f 1e fb          	endbr32 
80104d0b:	55                   	push   %ebp
80104d0c:	89 e5                	mov    %esp,%ebp
80104d0e:	83 ec 18             	sub    $0x18,%esp
  int intena;
  struct proc *p = myproc();
80104d11:	e8 21 f7 ff ff       	call   80104437 <myproc>
80104d16:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(!holding(&ptable.lock))
80104d19:	83 ec 0c             	sub    $0xc,%esp
80104d1c:	68 a0 3d 11 80       	push   $0x80113da0
80104d21:	e8 df 06 00 00       	call   80105405 <holding>
80104d26:	83 c4 10             	add    $0x10,%esp
80104d29:	85 c0                	test   %eax,%eax
80104d2b:	75 0d                	jne    80104d3a <sched+0x33>
    panic("sched ptable.lock");
80104d2d:	83 ec 0c             	sub    $0xc,%esp
80104d30:	68 9b 8b 10 80       	push   $0x80108b9b
80104d35:	e8 97 b8 ff ff       	call   801005d1 <panic>
  if(mycpu()->ncli != 1)
80104d3a:	e8 7c f6 ff ff       	call   801043bb <mycpu>
80104d3f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104d45:	83 f8 01             	cmp    $0x1,%eax
80104d48:	74 0d                	je     80104d57 <sched+0x50>
    panic("sched locks");
80104d4a:	83 ec 0c             	sub    $0xc,%esp
80104d4d:	68 ad 8b 10 80       	push   $0x80108bad
80104d52:	e8 7a b8 ff ff       	call   801005d1 <panic>
  if(p->state == RUNNING)
80104d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d5a:	8b 40 0c             	mov    0xc(%eax),%eax
80104d5d:	83 f8 04             	cmp    $0x4,%eax
80104d60:	75 0d                	jne    80104d6f <sched+0x68>
    panic("sched running");
80104d62:	83 ec 0c             	sub    $0xc,%esp
80104d65:	68 b9 8b 10 80       	push   $0x80108bb9
80104d6a:	e8 62 b8 ff ff       	call   801005d1 <panic>
  if(readeflags()&FL_IF)
80104d6f:	e8 ef f5 ff ff       	call   80104363 <readeflags>
80104d74:	25 00 02 00 00       	and    $0x200,%eax
80104d79:	85 c0                	test   %eax,%eax
80104d7b:	74 0d                	je     80104d8a <sched+0x83>
    panic("sched interruptible");
80104d7d:	83 ec 0c             	sub    $0xc,%esp
80104d80:	68 c7 8b 10 80       	push   $0x80108bc7
80104d85:	e8 47 b8 ff ff       	call   801005d1 <panic>
  intena = mycpu()->intena;
80104d8a:	e8 2c f6 ff ff       	call   801043bb <mycpu>
80104d8f:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104d95:	89 45 f0             	mov    %eax,-0x10(%ebp)
  swtch(&p->context, mycpu()->scheduler);
80104d98:	e8 1e f6 ff ff       	call   801043bb <mycpu>
80104d9d:	8b 40 04             	mov    0x4(%eax),%eax
80104da0:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104da3:	83 c2 1c             	add    $0x1c,%edx
80104da6:	83 ec 08             	sub    $0x8,%esp
80104da9:	50                   	push   %eax
80104daa:	52                   	push   %edx
80104dab:	e8 41 0a 00 00       	call   801057f1 <swtch>
80104db0:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104db3:	e8 03 f6 ff ff       	call   801043bb <mycpu>
80104db8:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104dbb:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
}
80104dc1:	90                   	nop
80104dc2:	c9                   	leave  
80104dc3:	c3                   	ret    

80104dc4 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104dc4:	f3 0f 1e fb          	endbr32 
80104dc8:	55                   	push   %ebp
80104dc9:	89 e5                	mov    %esp,%ebp
80104dcb:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104dce:	83 ec 0c             	sub    $0xc,%esp
80104dd1:	68 a0 3d 11 80       	push   $0x80113da0
80104dd6:	e8 e3 04 00 00       	call   801052be <acquire>
80104ddb:	83 c4 10             	add    $0x10,%esp
  myproc()->state = RUNNABLE;
80104dde:	e8 54 f6 ff ff       	call   80104437 <myproc>
80104de3:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104dea:	e8 18 ff ff ff       	call   80104d07 <sched>
  release(&ptable.lock);
80104def:	83 ec 0c             	sub    $0xc,%esp
80104df2:	68 a0 3d 11 80       	push   $0x80113da0
80104df7:	e8 34 05 00 00       	call   80105330 <release>
80104dfc:	83 c4 10             	add    $0x10,%esp
}
80104dff:	90                   	nop
80104e00:	c9                   	leave  
80104e01:	c3                   	ret    

80104e02 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104e02:	f3 0f 1e fb          	endbr32 
80104e06:	55                   	push   %ebp
80104e07:	89 e5                	mov    %esp,%ebp
80104e09:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104e0c:	83 ec 0c             	sub    $0xc,%esp
80104e0f:	68 a0 3d 11 80       	push   $0x80113da0
80104e14:	e8 17 05 00 00       	call   80105330 <release>
80104e19:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104e1c:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80104e21:	85 c0                	test   %eax,%eax
80104e23:	74 24                	je     80104e49 <forkret+0x47>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80104e25:	c7 05 04 b0 10 80 00 	movl   $0x0,0x8010b004
80104e2c:	00 00 00 
    iinit(ROOTDEV);
80104e2f:	83 ec 0c             	sub    $0xc,%esp
80104e32:	6a 01                	push   $0x1
80104e34:	e8 ea c8 ff ff       	call   80101723 <iinit>
80104e39:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
80104e3c:	83 ec 0c             	sub    $0xc,%esp
80104e3f:	6a 01                	push   $0x1
80104e41:	e8 ff e5 ff ff       	call   80103445 <initlog>
80104e46:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80104e49:	90                   	nop
80104e4a:	c9                   	leave  
80104e4b:	c3                   	ret    

80104e4c <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104e4c:	f3 0f 1e fb          	endbr32 
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	83 ec 18             	sub    $0x18,%esp
  struct proc *p = myproc();
80104e56:	e8 dc f5 ff ff       	call   80104437 <myproc>
80104e5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  if(p == 0)
80104e5e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104e62:	75 0d                	jne    80104e71 <sleep+0x25>
    panic("sleep");
80104e64:	83 ec 0c             	sub    $0xc,%esp
80104e67:	68 db 8b 10 80       	push   $0x80108bdb
80104e6c:	e8 60 b7 ff ff       	call   801005d1 <panic>

  if(lk == 0)
80104e71:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104e75:	75 0d                	jne    80104e84 <sleep+0x38>
    panic("sleep without lk");
80104e77:	83 ec 0c             	sub    $0xc,%esp
80104e7a:	68 e1 8b 10 80       	push   $0x80108be1
80104e7f:	e8 4d b7 ff ff       	call   801005d1 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104e84:	81 7d 0c a0 3d 11 80 	cmpl   $0x80113da0,0xc(%ebp)
80104e8b:	74 1e                	je     80104eab <sleep+0x5f>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104e8d:	83 ec 0c             	sub    $0xc,%esp
80104e90:	68 a0 3d 11 80       	push   $0x80113da0
80104e95:	e8 24 04 00 00       	call   801052be <acquire>
80104e9a:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104e9d:	83 ec 0c             	sub    $0xc,%esp
80104ea0:	ff 75 0c             	pushl  0xc(%ebp)
80104ea3:	e8 88 04 00 00       	call   80105330 <release>
80104ea8:	83 c4 10             	add    $0x10,%esp
  }
  // Go to sleep.
  p->chan = chan;
80104eab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104eae:	8b 55 08             	mov    0x8(%ebp),%edx
80104eb1:	89 50 20             	mov    %edx,0x20(%eax)
  p->state = SLEEPING;
80104eb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104eb7:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
80104ebe:	e8 44 fe ff ff       	call   80104d07 <sched>

  // Tidy up.
  p->chan = 0;
80104ec3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ec6:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104ecd:	81 7d 0c a0 3d 11 80 	cmpl   $0x80113da0,0xc(%ebp)
80104ed4:	74 1e                	je     80104ef4 <sleep+0xa8>
    release(&ptable.lock);
80104ed6:	83 ec 0c             	sub    $0xc,%esp
80104ed9:	68 a0 3d 11 80       	push   $0x80113da0
80104ede:	e8 4d 04 00 00       	call   80105330 <release>
80104ee3:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104ee6:	83 ec 0c             	sub    $0xc,%esp
80104ee9:	ff 75 0c             	pushl  0xc(%ebp)
80104eec:	e8 cd 03 00 00       	call   801052be <acquire>
80104ef1:	83 c4 10             	add    $0x10,%esp
  }
}
80104ef4:	90                   	nop
80104ef5:	c9                   	leave  
80104ef6:	c3                   	ret    

80104ef7 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104ef7:	f3 0f 1e fb          	endbr32 
80104efb:	55                   	push   %ebp
80104efc:	89 e5                	mov    %esp,%ebp
80104efe:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f01:	c7 45 fc d4 3d 11 80 	movl   $0x80113dd4,-0x4(%ebp)
80104f08:	eb 27                	jmp    80104f31 <wakeup1+0x3a>
    if(p->state == SLEEPING && p->chan == chan)
80104f0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f0d:	8b 40 0c             	mov    0xc(%eax),%eax
80104f10:	83 f8 02             	cmp    $0x2,%eax
80104f13:	75 15                	jne    80104f2a <wakeup1+0x33>
80104f15:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f18:	8b 40 20             	mov    0x20(%eax),%eax
80104f1b:	39 45 08             	cmp    %eax,0x8(%ebp)
80104f1e:	75 0a                	jne    80104f2a <wakeup1+0x33>
      p->state = RUNNABLE;
80104f20:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f23:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f2a:	81 45 fc 88 00 00 00 	addl   $0x88,-0x4(%ebp)
80104f31:	81 7d fc d4 5f 11 80 	cmpl   $0x80115fd4,-0x4(%ebp)
80104f38:	72 d0                	jb     80104f0a <wakeup1+0x13>
}
80104f3a:	90                   	nop
80104f3b:	90                   	nop
80104f3c:	c9                   	leave  
80104f3d:	c3                   	ret    

80104f3e <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104f3e:	f3 0f 1e fb          	endbr32 
80104f42:	55                   	push   %ebp
80104f43:	89 e5                	mov    %esp,%ebp
80104f45:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104f48:	83 ec 0c             	sub    $0xc,%esp
80104f4b:	68 a0 3d 11 80       	push   $0x80113da0
80104f50:	e8 69 03 00 00       	call   801052be <acquire>
80104f55:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104f58:	83 ec 0c             	sub    $0xc,%esp
80104f5b:	ff 75 08             	pushl  0x8(%ebp)
80104f5e:	e8 94 ff ff ff       	call   80104ef7 <wakeup1>
80104f63:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104f66:	83 ec 0c             	sub    $0xc,%esp
80104f69:	68 a0 3d 11 80       	push   $0x80113da0
80104f6e:	e8 bd 03 00 00       	call   80105330 <release>
80104f73:	83 c4 10             	add    $0x10,%esp
}
80104f76:	90                   	nop
80104f77:	c9                   	leave  
80104f78:	c3                   	ret    

80104f79 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104f79:	f3 0f 1e fb          	endbr32 
80104f7d:	55                   	push   %ebp
80104f7e:	89 e5                	mov    %esp,%ebp
80104f80:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104f83:	83 ec 0c             	sub    $0xc,%esp
80104f86:	68 a0 3d 11 80       	push   $0x80113da0
80104f8b:	e8 2e 03 00 00       	call   801052be <acquire>
80104f90:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f93:	c7 45 f4 d4 3d 11 80 	movl   $0x80113dd4,-0xc(%ebp)
80104f9a:	eb 48                	jmp    80104fe4 <kill+0x6b>
    if(p->pid == pid){
80104f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f9f:	8b 40 10             	mov    0x10(%eax),%eax
80104fa2:	39 45 08             	cmp    %eax,0x8(%ebp)
80104fa5:	75 36                	jne    80104fdd <kill+0x64>
      p->killed = 1;
80104fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104faa:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104fb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fb4:	8b 40 0c             	mov    0xc(%eax),%eax
80104fb7:	83 f8 02             	cmp    $0x2,%eax
80104fba:	75 0a                	jne    80104fc6 <kill+0x4d>
        p->state = RUNNABLE;
80104fbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fbf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104fc6:	83 ec 0c             	sub    $0xc,%esp
80104fc9:	68 a0 3d 11 80       	push   $0x80113da0
80104fce:	e8 5d 03 00 00       	call   80105330 <release>
80104fd3:	83 c4 10             	add    $0x10,%esp
      return 0;
80104fd6:	b8 00 00 00 00       	mov    $0x0,%eax
80104fdb:	eb 25                	jmp    80105002 <kill+0x89>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104fdd:	81 45 f4 88 00 00 00 	addl   $0x88,-0xc(%ebp)
80104fe4:	81 7d f4 d4 5f 11 80 	cmpl   $0x80115fd4,-0xc(%ebp)
80104feb:	72 af                	jb     80104f9c <kill+0x23>
    }
  }
  release(&ptable.lock);
80104fed:	83 ec 0c             	sub    $0xc,%esp
80104ff0:	68 a0 3d 11 80       	push   $0x80113da0
80104ff5:	e8 36 03 00 00       	call   80105330 <release>
80104ffa:	83 c4 10             	add    $0x10,%esp
  return -1;
80104ffd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105002:	c9                   	leave  
80105003:	c3                   	ret    

80105004 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80105004:	f3 0f 1e fb          	endbr32 
80105008:	55                   	push   %ebp
80105009:	89 e5                	mov    %esp,%ebp
8010500b:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010500e:	c7 45 f0 d4 3d 11 80 	movl   $0x80113dd4,-0x10(%ebp)
80105015:	e9 da 00 00 00       	jmp    801050f4 <procdump+0xf0>
    if(p->state == UNUSED)
8010501a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010501d:	8b 40 0c             	mov    0xc(%eax),%eax
80105020:	85 c0                	test   %eax,%eax
80105022:	0f 84 c4 00 00 00    	je     801050ec <procdump+0xe8>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105028:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010502b:	8b 40 0c             	mov    0xc(%eax),%eax
8010502e:	83 f8 05             	cmp    $0x5,%eax
80105031:	77 23                	ja     80105056 <procdump+0x52>
80105033:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105036:	8b 40 0c             	mov    0xc(%eax),%eax
80105039:	8b 04 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%eax
80105040:	85 c0                	test   %eax,%eax
80105042:	74 12                	je     80105056 <procdump+0x52>
      state = states[p->state];
80105044:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105047:	8b 40 0c             	mov    0xc(%eax),%eax
8010504a:	8b 04 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%eax
80105051:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105054:	eb 07                	jmp    8010505d <procdump+0x59>
    else
      state = "???";
80105056:	c7 45 ec f2 8b 10 80 	movl   $0x80108bf2,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
8010505d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105060:	8d 50 6c             	lea    0x6c(%eax),%edx
80105063:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105066:	8b 40 10             	mov    0x10(%eax),%eax
80105069:	52                   	push   %edx
8010506a:	ff 75 ec             	pushl  -0x14(%ebp)
8010506d:	50                   	push   %eax
8010506e:	68 f6 8b 10 80       	push   $0x80108bf6
80105073:	e8 a0 b3 ff ff       	call   80100418 <cprintf>
80105078:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
8010507b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010507e:	8b 40 0c             	mov    0xc(%eax),%eax
80105081:	83 f8 02             	cmp    $0x2,%eax
80105084:	75 54                	jne    801050da <procdump+0xd6>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105086:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105089:	8b 40 1c             	mov    0x1c(%eax),%eax
8010508c:	8b 40 0c             	mov    0xc(%eax),%eax
8010508f:	83 c0 08             	add    $0x8,%eax
80105092:	89 c2                	mov    %eax,%edx
80105094:	83 ec 08             	sub    $0x8,%esp
80105097:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010509a:	50                   	push   %eax
8010509b:	52                   	push   %edx
8010509c:	e8 e5 02 00 00       	call   80105386 <getcallerpcs>
801050a1:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801050a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801050ab:	eb 1c                	jmp    801050c9 <procdump+0xc5>
        cprintf(" %p", pc[i]);
801050ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050b0:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801050b4:	83 ec 08             	sub    $0x8,%esp
801050b7:	50                   	push   %eax
801050b8:	68 ff 8b 10 80       	push   $0x80108bff
801050bd:	e8 56 b3 ff ff       	call   80100418 <cprintf>
801050c2:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801050c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801050c9:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801050cd:	7f 0b                	jg     801050da <procdump+0xd6>
801050cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050d2:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801050d6:	85 c0                	test   %eax,%eax
801050d8:	75 d3                	jne    801050ad <procdump+0xa9>
    }
    cprintf("\n");
801050da:	83 ec 0c             	sub    $0xc,%esp
801050dd:	68 03 8c 10 80       	push   $0x80108c03
801050e2:	e8 31 b3 ff ff       	call   80100418 <cprintf>
801050e7:	83 c4 10             	add    $0x10,%esp
801050ea:	eb 01                	jmp    801050ed <procdump+0xe9>
      continue;
801050ec:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801050ed:	81 45 f0 88 00 00 00 	addl   $0x88,-0x10(%ebp)
801050f4:	81 7d f0 d4 5f 11 80 	cmpl   $0x80115fd4,-0x10(%ebp)
801050fb:	0f 82 19 ff ff ff    	jb     8010501a <procdump+0x16>
  }
}
80105101:	90                   	nop
80105102:	90                   	nop
80105103:	c9                   	leave  
80105104:	c3                   	ret    

80105105 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105105:	f3 0f 1e fb          	endbr32 
80105109:	55                   	push   %ebp
8010510a:	89 e5                	mov    %esp,%ebp
8010510c:	83 ec 08             	sub    $0x8,%esp
  initlock(&lk->lk, "sleep lock");
8010510f:	8b 45 08             	mov    0x8(%ebp),%eax
80105112:	83 c0 04             	add    $0x4,%eax
80105115:	83 ec 08             	sub    $0x8,%esp
80105118:	68 2f 8c 10 80       	push   $0x80108c2f
8010511d:	50                   	push   %eax
8010511e:	e8 75 01 00 00       	call   80105298 <initlock>
80105123:	83 c4 10             	add    $0x10,%esp
  lk->name = name;
80105126:	8b 45 08             	mov    0x8(%ebp),%eax
80105129:	8b 55 0c             	mov    0xc(%ebp),%edx
8010512c:	89 50 38             	mov    %edx,0x38(%eax)
  lk->locked = 0;
8010512f:	8b 45 08             	mov    0x8(%ebp),%eax
80105132:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80105138:	8b 45 08             	mov    0x8(%ebp),%eax
8010513b:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
}
80105142:	90                   	nop
80105143:	c9                   	leave  
80105144:	c3                   	ret    

80105145 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105145:	f3 0f 1e fb          	endbr32 
80105149:	55                   	push   %ebp
8010514a:	89 e5                	mov    %esp,%ebp
8010514c:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
8010514f:	8b 45 08             	mov    0x8(%ebp),%eax
80105152:	83 c0 04             	add    $0x4,%eax
80105155:	83 ec 0c             	sub    $0xc,%esp
80105158:	50                   	push   %eax
80105159:	e8 60 01 00 00       	call   801052be <acquire>
8010515e:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80105161:	eb 15                	jmp    80105178 <acquiresleep+0x33>
    sleep(lk, &lk->lk);
80105163:	8b 45 08             	mov    0x8(%ebp),%eax
80105166:	83 c0 04             	add    $0x4,%eax
80105169:	83 ec 08             	sub    $0x8,%esp
8010516c:	50                   	push   %eax
8010516d:	ff 75 08             	pushl  0x8(%ebp)
80105170:	e8 d7 fc ff ff       	call   80104e4c <sleep>
80105175:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80105178:	8b 45 08             	mov    0x8(%ebp),%eax
8010517b:	8b 00                	mov    (%eax),%eax
8010517d:	85 c0                	test   %eax,%eax
8010517f:	75 e2                	jne    80105163 <acquiresleep+0x1e>
  }
  lk->locked = 1;
80105181:	8b 45 08             	mov    0x8(%ebp),%eax
80105184:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  lk->pid = myproc()->pid;
8010518a:	e8 a8 f2 ff ff       	call   80104437 <myproc>
8010518f:	8b 50 10             	mov    0x10(%eax),%edx
80105192:	8b 45 08             	mov    0x8(%ebp),%eax
80105195:	89 50 3c             	mov    %edx,0x3c(%eax)
  release(&lk->lk);
80105198:	8b 45 08             	mov    0x8(%ebp),%eax
8010519b:	83 c0 04             	add    $0x4,%eax
8010519e:	83 ec 0c             	sub    $0xc,%esp
801051a1:	50                   	push   %eax
801051a2:	e8 89 01 00 00       	call   80105330 <release>
801051a7:	83 c4 10             	add    $0x10,%esp
}
801051aa:	90                   	nop
801051ab:	c9                   	leave  
801051ac:	c3                   	ret    

801051ad <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801051ad:	f3 0f 1e fb          	endbr32 
801051b1:	55                   	push   %ebp
801051b2:	89 e5                	mov    %esp,%ebp
801051b4:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
801051b7:	8b 45 08             	mov    0x8(%ebp),%eax
801051ba:	83 c0 04             	add    $0x4,%eax
801051bd:	83 ec 0c             	sub    $0xc,%esp
801051c0:	50                   	push   %eax
801051c1:	e8 f8 00 00 00       	call   801052be <acquire>
801051c6:	83 c4 10             	add    $0x10,%esp
  lk->locked = 0;
801051c9:	8b 45 08             	mov    0x8(%ebp),%eax
801051cc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
801051d2:	8b 45 08             	mov    0x8(%ebp),%eax
801051d5:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
  wakeup(lk);
801051dc:	83 ec 0c             	sub    $0xc,%esp
801051df:	ff 75 08             	pushl  0x8(%ebp)
801051e2:	e8 57 fd ff ff       	call   80104f3e <wakeup>
801051e7:	83 c4 10             	add    $0x10,%esp
  release(&lk->lk);
801051ea:	8b 45 08             	mov    0x8(%ebp),%eax
801051ed:	83 c0 04             	add    $0x4,%eax
801051f0:	83 ec 0c             	sub    $0xc,%esp
801051f3:	50                   	push   %eax
801051f4:	e8 37 01 00 00       	call   80105330 <release>
801051f9:	83 c4 10             	add    $0x10,%esp
}
801051fc:	90                   	nop
801051fd:	c9                   	leave  
801051fe:	c3                   	ret    

801051ff <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801051ff:	f3 0f 1e fb          	endbr32 
80105203:	55                   	push   %ebp
80105204:	89 e5                	mov    %esp,%ebp
80105206:	53                   	push   %ebx
80105207:	83 ec 14             	sub    $0x14,%esp
  int r;
  
  acquire(&lk->lk);
8010520a:	8b 45 08             	mov    0x8(%ebp),%eax
8010520d:	83 c0 04             	add    $0x4,%eax
80105210:	83 ec 0c             	sub    $0xc,%esp
80105213:	50                   	push   %eax
80105214:	e8 a5 00 00 00       	call   801052be <acquire>
80105219:	83 c4 10             	add    $0x10,%esp
  r = lk->locked && (lk->pid == myproc()->pid);
8010521c:	8b 45 08             	mov    0x8(%ebp),%eax
8010521f:	8b 00                	mov    (%eax),%eax
80105221:	85 c0                	test   %eax,%eax
80105223:	74 19                	je     8010523e <holdingsleep+0x3f>
80105225:	8b 45 08             	mov    0x8(%ebp),%eax
80105228:	8b 58 3c             	mov    0x3c(%eax),%ebx
8010522b:	e8 07 f2 ff ff       	call   80104437 <myproc>
80105230:	8b 40 10             	mov    0x10(%eax),%eax
80105233:	39 c3                	cmp    %eax,%ebx
80105235:	75 07                	jne    8010523e <holdingsleep+0x3f>
80105237:	b8 01 00 00 00       	mov    $0x1,%eax
8010523c:	eb 05                	jmp    80105243 <holdingsleep+0x44>
8010523e:	b8 00 00 00 00       	mov    $0x0,%eax
80105243:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&lk->lk);
80105246:	8b 45 08             	mov    0x8(%ebp),%eax
80105249:	83 c0 04             	add    $0x4,%eax
8010524c:	83 ec 0c             	sub    $0xc,%esp
8010524f:	50                   	push   %eax
80105250:	e8 db 00 00 00       	call   80105330 <release>
80105255:	83 c4 10             	add    $0x10,%esp
  return r;
80105258:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010525b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010525e:	c9                   	leave  
8010525f:	c3                   	ret    

80105260 <readeflags>:
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105266:	9c                   	pushf  
80105267:	58                   	pop    %eax
80105268:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010526b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010526e:	c9                   	leave  
8010526f:	c3                   	ret    

80105270 <cli>:
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80105273:	fa                   	cli    
}
80105274:	90                   	nop
80105275:	5d                   	pop    %ebp
80105276:	c3                   	ret    

80105277 <sti>:
{
80105277:	55                   	push   %ebp
80105278:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
8010527a:	fb                   	sti    
}
8010527b:	90                   	nop
8010527c:	5d                   	pop    %ebp
8010527d:	c3                   	ret    

8010527e <xchg>:
{
8010527e:	55                   	push   %ebp
8010527f:	89 e5                	mov    %esp,%ebp
80105281:	83 ec 10             	sub    $0x10,%esp
  asm volatile("lock; xchgl %0, %1" :
80105284:	8b 55 08             	mov    0x8(%ebp),%edx
80105287:	8b 45 0c             	mov    0xc(%ebp),%eax
8010528a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010528d:	f0 87 02             	lock xchg %eax,(%edx)
80105290:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return result;
80105293:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105296:	c9                   	leave  
80105297:	c3                   	ret    

80105298 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105298:	f3 0f 1e fb          	endbr32 
8010529c:	55                   	push   %ebp
8010529d:	89 e5                	mov    %esp,%ebp
  lk->name = name;
8010529f:	8b 45 08             	mov    0x8(%ebp),%eax
801052a2:	8b 55 0c             	mov    0xc(%ebp),%edx
801052a5:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
801052a8:	8b 45 08             	mov    0x8(%ebp),%eax
801052ab:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
801052b1:	8b 45 08             	mov    0x8(%ebp),%eax
801052b4:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801052bb:	90                   	nop
801052bc:	5d                   	pop    %ebp
801052bd:	c3                   	ret    

801052be <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801052be:	f3 0f 1e fb          	endbr32 
801052c2:	55                   	push   %ebp
801052c3:	89 e5                	mov    %esp,%ebp
801052c5:	53                   	push   %ebx
801052c6:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801052c9:	e8 7c 01 00 00       	call   8010544a <pushcli>
  if(holding(lk))
801052ce:	8b 45 08             	mov    0x8(%ebp),%eax
801052d1:	83 ec 0c             	sub    $0xc,%esp
801052d4:	50                   	push   %eax
801052d5:	e8 2b 01 00 00       	call   80105405 <holding>
801052da:	83 c4 10             	add    $0x10,%esp
801052dd:	85 c0                	test   %eax,%eax
801052df:	74 0d                	je     801052ee <acquire+0x30>
    panic("acquire");
801052e1:	83 ec 0c             	sub    $0xc,%esp
801052e4:	68 3a 8c 10 80       	push   $0x80108c3a
801052e9:	e8 e3 b2 ff ff       	call   801005d1 <panic>

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801052ee:	90                   	nop
801052ef:	8b 45 08             	mov    0x8(%ebp),%eax
801052f2:	83 ec 08             	sub    $0x8,%esp
801052f5:	6a 01                	push   $0x1
801052f7:	50                   	push   %eax
801052f8:	e8 81 ff ff ff       	call   8010527e <xchg>
801052fd:	83 c4 10             	add    $0x10,%esp
80105300:	85 c0                	test   %eax,%eax
80105302:	75 eb                	jne    801052ef <acquire+0x31>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80105304:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80105309:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010530c:	e8 aa f0 ff ff       	call   801043bb <mycpu>
80105311:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
80105314:	8b 45 08             	mov    0x8(%ebp),%eax
80105317:	83 c0 0c             	add    $0xc,%eax
8010531a:	83 ec 08             	sub    $0x8,%esp
8010531d:	50                   	push   %eax
8010531e:	8d 45 08             	lea    0x8(%ebp),%eax
80105321:	50                   	push   %eax
80105322:	e8 5f 00 00 00       	call   80105386 <getcallerpcs>
80105327:	83 c4 10             	add    $0x10,%esp
}
8010532a:	90                   	nop
8010532b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010532e:	c9                   	leave  
8010532f:	c3                   	ret    

80105330 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80105330:	f3 0f 1e fb          	endbr32 
80105334:	55                   	push   %ebp
80105335:	89 e5                	mov    %esp,%ebp
80105337:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
8010533a:	83 ec 0c             	sub    $0xc,%esp
8010533d:	ff 75 08             	pushl  0x8(%ebp)
80105340:	e8 c0 00 00 00       	call   80105405 <holding>
80105345:	83 c4 10             	add    $0x10,%esp
80105348:	85 c0                	test   %eax,%eax
8010534a:	75 0d                	jne    80105359 <release+0x29>
    panic("release");
8010534c:	83 ec 0c             	sub    $0xc,%esp
8010534f:	68 42 8c 10 80       	push   $0x80108c42
80105354:	e8 78 b2 ff ff       	call   801005d1 <panic>

  lk->pcs[0] = 0;
80105359:	8b 45 08             	mov    0x8(%ebp),%eax
8010535c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80105363:	8b 45 08             	mov    0x8(%ebp),%eax
80105366:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010536d:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105372:	8b 45 08             	mov    0x8(%ebp),%eax
80105375:	8b 55 08             	mov    0x8(%ebp),%edx
80105378:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
8010537e:	e8 18 01 00 00       	call   8010549b <popcli>
}
80105383:	90                   	nop
80105384:	c9                   	leave  
80105385:	c3                   	ret    

80105386 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105386:	f3 0f 1e fb          	endbr32 
8010538a:	55                   	push   %ebp
8010538b:	89 e5                	mov    %esp,%ebp
8010538d:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80105390:	8b 45 08             	mov    0x8(%ebp),%eax
80105393:	83 e8 08             	sub    $0x8,%eax
80105396:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80105399:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801053a0:	eb 38                	jmp    801053da <getcallerpcs+0x54>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801053a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
801053a6:	74 53                	je     801053fb <getcallerpcs+0x75>
801053a8:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
801053af:	76 4a                	jbe    801053fb <getcallerpcs+0x75>
801053b1:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
801053b5:	74 44                	je     801053fb <getcallerpcs+0x75>
      break;
    pcs[i] = ebp[1];     // saved %eip
801053b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
801053ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801053c1:	8b 45 0c             	mov    0xc(%ebp),%eax
801053c4:	01 c2                	add    %eax,%edx
801053c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053c9:	8b 40 04             	mov    0x4(%eax),%eax
801053cc:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
801053ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053d1:	8b 00                	mov    (%eax),%eax
801053d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801053d6:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801053da:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801053de:	7e c2                	jle    801053a2 <getcallerpcs+0x1c>
  }
  for(; i < 10; i++)
801053e0:	eb 19                	jmp    801053fb <getcallerpcs+0x75>
    pcs[i] = 0;
801053e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
801053e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801053ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801053ef:	01 d0                	add    %edx,%eax
801053f1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801053f7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801053fb:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801053ff:	7e e1                	jle    801053e2 <getcallerpcs+0x5c>
}
80105401:	90                   	nop
80105402:	90                   	nop
80105403:	c9                   	leave  
80105404:	c3                   	ret    

80105405 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105405:	f3 0f 1e fb          	endbr32 
80105409:	55                   	push   %ebp
8010540a:	89 e5                	mov    %esp,%ebp
8010540c:	53                   	push   %ebx
8010540d:	83 ec 14             	sub    $0x14,%esp
  int r;
  pushcli();
80105410:	e8 35 00 00 00       	call   8010544a <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105415:	8b 45 08             	mov    0x8(%ebp),%eax
80105418:	8b 00                	mov    (%eax),%eax
8010541a:	85 c0                	test   %eax,%eax
8010541c:	74 16                	je     80105434 <holding+0x2f>
8010541e:	8b 45 08             	mov    0x8(%ebp),%eax
80105421:	8b 58 08             	mov    0x8(%eax),%ebx
80105424:	e8 92 ef ff ff       	call   801043bb <mycpu>
80105429:	39 c3                	cmp    %eax,%ebx
8010542b:	75 07                	jne    80105434 <holding+0x2f>
8010542d:	b8 01 00 00 00       	mov    $0x1,%eax
80105432:	eb 05                	jmp    80105439 <holding+0x34>
80105434:	b8 00 00 00 00       	mov    $0x0,%eax
80105439:	89 45 f4             	mov    %eax,-0xc(%ebp)
  popcli();
8010543c:	e8 5a 00 00 00       	call   8010549b <popcli>
  return r;
80105441:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105444:	83 c4 14             	add    $0x14,%esp
80105447:	5b                   	pop    %ebx
80105448:	5d                   	pop    %ebp
80105449:	c3                   	ret    

8010544a <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
8010544a:	f3 0f 1e fb          	endbr32 
8010544e:	55                   	push   %ebp
8010544f:	89 e5                	mov    %esp,%ebp
80105451:	83 ec 18             	sub    $0x18,%esp
  int eflags;

  eflags = readeflags();
80105454:	e8 07 fe ff ff       	call   80105260 <readeflags>
80105459:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cli();
8010545c:	e8 0f fe ff ff       	call   80105270 <cli>
  if(mycpu()->ncli == 0)
80105461:	e8 55 ef ff ff       	call   801043bb <mycpu>
80105466:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
8010546c:	85 c0                	test   %eax,%eax
8010546e:	75 14                	jne    80105484 <pushcli+0x3a>
    mycpu()->intena = eflags & FL_IF;
80105470:	e8 46 ef ff ff       	call   801043bb <mycpu>
80105475:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105478:	81 e2 00 02 00 00    	and    $0x200,%edx
8010547e:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
  mycpu()->ncli += 1;
80105484:	e8 32 ef ff ff       	call   801043bb <mycpu>
80105489:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
8010548f:	83 c2 01             	add    $0x1,%edx
80105492:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
}
80105498:	90                   	nop
80105499:	c9                   	leave  
8010549a:	c3                   	ret    

8010549b <popcli>:

void
popcli(void)
{
8010549b:	f3 0f 1e fb          	endbr32 
8010549f:	55                   	push   %ebp
801054a0:	89 e5                	mov    %esp,%ebp
801054a2:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
801054a5:	e8 b6 fd ff ff       	call   80105260 <readeflags>
801054aa:	25 00 02 00 00       	and    $0x200,%eax
801054af:	85 c0                	test   %eax,%eax
801054b1:	74 0d                	je     801054c0 <popcli+0x25>
    panic("popcli - interruptible");
801054b3:	83 ec 0c             	sub    $0xc,%esp
801054b6:	68 4a 8c 10 80       	push   $0x80108c4a
801054bb:	e8 11 b1 ff ff       	call   801005d1 <panic>
  if(--mycpu()->ncli < 0)
801054c0:	e8 f6 ee ff ff       	call   801043bb <mycpu>
801054c5:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801054cb:	83 ea 01             	sub    $0x1,%edx
801054ce:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801054d4:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801054da:	85 c0                	test   %eax,%eax
801054dc:	79 0d                	jns    801054eb <popcli+0x50>
    panic("popcli");
801054de:	83 ec 0c             	sub    $0xc,%esp
801054e1:	68 61 8c 10 80       	push   $0x80108c61
801054e6:	e8 e6 b0 ff ff       	call   801005d1 <panic>
  if(mycpu()->ncli == 0 && mycpu()->intena)
801054eb:	e8 cb ee ff ff       	call   801043bb <mycpu>
801054f0:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801054f6:	85 c0                	test   %eax,%eax
801054f8:	75 14                	jne    8010550e <popcli+0x73>
801054fa:	e8 bc ee ff ff       	call   801043bb <mycpu>
801054ff:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105505:	85 c0                	test   %eax,%eax
80105507:	74 05                	je     8010550e <popcli+0x73>
    sti();
80105509:	e8 69 fd ff ff       	call   80105277 <sti>
}
8010550e:	90                   	nop
8010550f:	c9                   	leave  
80105510:	c3                   	ret    

80105511 <stosb>:
{
80105511:	55                   	push   %ebp
80105512:	89 e5                	mov    %esp,%ebp
80105514:	57                   	push   %edi
80105515:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105516:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105519:	8b 55 10             	mov    0x10(%ebp),%edx
8010551c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010551f:	89 cb                	mov    %ecx,%ebx
80105521:	89 df                	mov    %ebx,%edi
80105523:	89 d1                	mov    %edx,%ecx
80105525:	fc                   	cld    
80105526:	f3 aa                	rep stos %al,%es:(%edi)
80105528:	89 ca                	mov    %ecx,%edx
8010552a:	89 fb                	mov    %edi,%ebx
8010552c:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010552f:	89 55 10             	mov    %edx,0x10(%ebp)
}
80105532:	90                   	nop
80105533:	5b                   	pop    %ebx
80105534:	5f                   	pop    %edi
80105535:	5d                   	pop    %ebp
80105536:	c3                   	ret    

80105537 <stosl>:
{
80105537:	55                   	push   %ebp
80105538:	89 e5                	mov    %esp,%ebp
8010553a:	57                   	push   %edi
8010553b:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
8010553c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010553f:	8b 55 10             	mov    0x10(%ebp),%edx
80105542:	8b 45 0c             	mov    0xc(%ebp),%eax
80105545:	89 cb                	mov    %ecx,%ebx
80105547:	89 df                	mov    %ebx,%edi
80105549:	89 d1                	mov    %edx,%ecx
8010554b:	fc                   	cld    
8010554c:	f3 ab                	rep stos %eax,%es:(%edi)
8010554e:	89 ca                	mov    %ecx,%edx
80105550:	89 fb                	mov    %edi,%ebx
80105552:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105555:	89 55 10             	mov    %edx,0x10(%ebp)
}
80105558:	90                   	nop
80105559:	5b                   	pop    %ebx
8010555a:	5f                   	pop    %edi
8010555b:	5d                   	pop    %ebp
8010555c:	c3                   	ret    

8010555d <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
8010555d:	f3 0f 1e fb          	endbr32 
80105561:	55                   	push   %ebp
80105562:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
80105564:	8b 45 08             	mov    0x8(%ebp),%eax
80105567:	83 e0 03             	and    $0x3,%eax
8010556a:	85 c0                	test   %eax,%eax
8010556c:	75 43                	jne    801055b1 <memset+0x54>
8010556e:	8b 45 10             	mov    0x10(%ebp),%eax
80105571:	83 e0 03             	and    $0x3,%eax
80105574:	85 c0                	test   %eax,%eax
80105576:	75 39                	jne    801055b1 <memset+0x54>
    c &= 0xFF;
80105578:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010557f:	8b 45 10             	mov    0x10(%ebp),%eax
80105582:	c1 e8 02             	shr    $0x2,%eax
80105585:	89 c1                	mov    %eax,%ecx
80105587:	8b 45 0c             	mov    0xc(%ebp),%eax
8010558a:	c1 e0 18             	shl    $0x18,%eax
8010558d:	89 c2                	mov    %eax,%edx
8010558f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105592:	c1 e0 10             	shl    $0x10,%eax
80105595:	09 c2                	or     %eax,%edx
80105597:	8b 45 0c             	mov    0xc(%ebp),%eax
8010559a:	c1 e0 08             	shl    $0x8,%eax
8010559d:	09 d0                	or     %edx,%eax
8010559f:	0b 45 0c             	or     0xc(%ebp),%eax
801055a2:	51                   	push   %ecx
801055a3:	50                   	push   %eax
801055a4:	ff 75 08             	pushl  0x8(%ebp)
801055a7:	e8 8b ff ff ff       	call   80105537 <stosl>
801055ac:	83 c4 0c             	add    $0xc,%esp
801055af:	eb 12                	jmp    801055c3 <memset+0x66>
  } else
    stosb(dst, c, n);
801055b1:	8b 45 10             	mov    0x10(%ebp),%eax
801055b4:	50                   	push   %eax
801055b5:	ff 75 0c             	pushl  0xc(%ebp)
801055b8:	ff 75 08             	pushl  0x8(%ebp)
801055bb:	e8 51 ff ff ff       	call   80105511 <stosb>
801055c0:	83 c4 0c             	add    $0xc,%esp
  return dst;
801055c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801055c6:	c9                   	leave  
801055c7:	c3                   	ret    

801055c8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801055c8:	f3 0f 1e fb          	endbr32 
801055cc:	55                   	push   %ebp
801055cd:	89 e5                	mov    %esp,%ebp
801055cf:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;

  s1 = v1;
801055d2:	8b 45 08             	mov    0x8(%ebp),%eax
801055d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801055d8:	8b 45 0c             	mov    0xc(%ebp),%eax
801055db:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801055de:	eb 30                	jmp    80105610 <memcmp+0x48>
    if(*s1 != *s2)
801055e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055e3:	0f b6 10             	movzbl (%eax),%edx
801055e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
801055e9:	0f b6 00             	movzbl (%eax),%eax
801055ec:	38 c2                	cmp    %al,%dl
801055ee:	74 18                	je     80105608 <memcmp+0x40>
      return *s1 - *s2;
801055f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055f3:	0f b6 00             	movzbl (%eax),%eax
801055f6:	0f b6 d0             	movzbl %al,%edx
801055f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
801055fc:	0f b6 00             	movzbl (%eax),%eax
801055ff:	0f b6 c0             	movzbl %al,%eax
80105602:	29 c2                	sub    %eax,%edx
80105604:	89 d0                	mov    %edx,%eax
80105606:	eb 1a                	jmp    80105622 <memcmp+0x5a>
    s1++, s2++;
80105608:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010560c:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  while(n-- > 0){
80105610:	8b 45 10             	mov    0x10(%ebp),%eax
80105613:	8d 50 ff             	lea    -0x1(%eax),%edx
80105616:	89 55 10             	mov    %edx,0x10(%ebp)
80105619:	85 c0                	test   %eax,%eax
8010561b:	75 c3                	jne    801055e0 <memcmp+0x18>
  }

  return 0;
8010561d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105622:	c9                   	leave  
80105623:	c3                   	ret    

80105624 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105624:	f3 0f 1e fb          	endbr32 
80105628:	55                   	push   %ebp
80105629:	89 e5                	mov    %esp,%ebp
8010562b:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
8010562e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105631:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105634:	8b 45 08             	mov    0x8(%ebp),%eax
80105637:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
8010563a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010563d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105640:	73 54                	jae    80105696 <memmove+0x72>
80105642:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105645:	8b 45 10             	mov    0x10(%ebp),%eax
80105648:	01 d0                	add    %edx,%eax
8010564a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
8010564d:	73 47                	jae    80105696 <memmove+0x72>
    s += n;
8010564f:	8b 45 10             	mov    0x10(%ebp),%eax
80105652:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105655:	8b 45 10             	mov    0x10(%ebp),%eax
80105658:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
8010565b:	eb 13                	jmp    80105670 <memmove+0x4c>
      *--d = *--s;
8010565d:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105661:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105665:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105668:	0f b6 10             	movzbl (%eax),%edx
8010566b:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010566e:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80105670:	8b 45 10             	mov    0x10(%ebp),%eax
80105673:	8d 50 ff             	lea    -0x1(%eax),%edx
80105676:	89 55 10             	mov    %edx,0x10(%ebp)
80105679:	85 c0                	test   %eax,%eax
8010567b:	75 e0                	jne    8010565d <memmove+0x39>
  if(s < d && s + n > d){
8010567d:	eb 24                	jmp    801056a3 <memmove+0x7f>
  } else
    while(n-- > 0)
      *d++ = *s++;
8010567f:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105682:	8d 42 01             	lea    0x1(%edx),%eax
80105685:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105688:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010568b:	8d 48 01             	lea    0x1(%eax),%ecx
8010568e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
80105691:	0f b6 12             	movzbl (%edx),%edx
80105694:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80105696:	8b 45 10             	mov    0x10(%ebp),%eax
80105699:	8d 50 ff             	lea    -0x1(%eax),%edx
8010569c:	89 55 10             	mov    %edx,0x10(%ebp)
8010569f:	85 c0                	test   %eax,%eax
801056a1:	75 dc                	jne    8010567f <memmove+0x5b>

  return dst;
801056a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801056a6:	c9                   	leave  
801056a7:	c3                   	ret    

801056a8 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801056a8:	f3 0f 1e fb          	endbr32 
801056ac:	55                   	push   %ebp
801056ad:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
801056af:	ff 75 10             	pushl  0x10(%ebp)
801056b2:	ff 75 0c             	pushl  0xc(%ebp)
801056b5:	ff 75 08             	pushl  0x8(%ebp)
801056b8:	e8 67 ff ff ff       	call   80105624 <memmove>
801056bd:	83 c4 0c             	add    $0xc,%esp
}
801056c0:	c9                   	leave  
801056c1:	c3                   	ret    

801056c2 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801056c2:	f3 0f 1e fb          	endbr32 
801056c6:	55                   	push   %ebp
801056c7:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
801056c9:	eb 0c                	jmp    801056d7 <strncmp+0x15>
    n--, p++, q++;
801056cb:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801056cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801056d3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(n > 0 && *p && *p == *q)
801056d7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801056db:	74 1a                	je     801056f7 <strncmp+0x35>
801056dd:	8b 45 08             	mov    0x8(%ebp),%eax
801056e0:	0f b6 00             	movzbl (%eax),%eax
801056e3:	84 c0                	test   %al,%al
801056e5:	74 10                	je     801056f7 <strncmp+0x35>
801056e7:	8b 45 08             	mov    0x8(%ebp),%eax
801056ea:	0f b6 10             	movzbl (%eax),%edx
801056ed:	8b 45 0c             	mov    0xc(%ebp),%eax
801056f0:	0f b6 00             	movzbl (%eax),%eax
801056f3:	38 c2                	cmp    %al,%dl
801056f5:	74 d4                	je     801056cb <strncmp+0x9>
  if(n == 0)
801056f7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801056fb:	75 07                	jne    80105704 <strncmp+0x42>
    return 0;
801056fd:	b8 00 00 00 00       	mov    $0x0,%eax
80105702:	eb 16                	jmp    8010571a <strncmp+0x58>
  return (uchar)*p - (uchar)*q;
80105704:	8b 45 08             	mov    0x8(%ebp),%eax
80105707:	0f b6 00             	movzbl (%eax),%eax
8010570a:	0f b6 d0             	movzbl %al,%edx
8010570d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105710:	0f b6 00             	movzbl (%eax),%eax
80105713:	0f b6 c0             	movzbl %al,%eax
80105716:	29 c2                	sub    %eax,%edx
80105718:	89 d0                	mov    %edx,%eax
}
8010571a:	5d                   	pop    %ebp
8010571b:	c3                   	ret    

8010571c <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
8010571c:	f3 0f 1e fb          	endbr32 
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
80105726:	8b 45 08             	mov    0x8(%ebp),%eax
80105729:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010572c:	90                   	nop
8010572d:	8b 45 10             	mov    0x10(%ebp),%eax
80105730:	8d 50 ff             	lea    -0x1(%eax),%edx
80105733:	89 55 10             	mov    %edx,0x10(%ebp)
80105736:	85 c0                	test   %eax,%eax
80105738:	7e 2c                	jle    80105766 <strncpy+0x4a>
8010573a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010573d:	8d 42 01             	lea    0x1(%edx),%eax
80105740:	89 45 0c             	mov    %eax,0xc(%ebp)
80105743:	8b 45 08             	mov    0x8(%ebp),%eax
80105746:	8d 48 01             	lea    0x1(%eax),%ecx
80105749:	89 4d 08             	mov    %ecx,0x8(%ebp)
8010574c:	0f b6 12             	movzbl (%edx),%edx
8010574f:	88 10                	mov    %dl,(%eax)
80105751:	0f b6 00             	movzbl (%eax),%eax
80105754:	84 c0                	test   %al,%al
80105756:	75 d5                	jne    8010572d <strncpy+0x11>
    ;
  while(n-- > 0)
80105758:	eb 0c                	jmp    80105766 <strncpy+0x4a>
    *s++ = 0;
8010575a:	8b 45 08             	mov    0x8(%ebp),%eax
8010575d:	8d 50 01             	lea    0x1(%eax),%edx
80105760:	89 55 08             	mov    %edx,0x8(%ebp)
80105763:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
80105766:	8b 45 10             	mov    0x10(%ebp),%eax
80105769:	8d 50 ff             	lea    -0x1(%eax),%edx
8010576c:	89 55 10             	mov    %edx,0x10(%ebp)
8010576f:	85 c0                	test   %eax,%eax
80105771:	7f e7                	jg     8010575a <strncpy+0x3e>
  return os;
80105773:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105776:	c9                   	leave  
80105777:	c3                   	ret    

80105778 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105778:	f3 0f 1e fb          	endbr32 
8010577c:	55                   	push   %ebp
8010577d:	89 e5                	mov    %esp,%ebp
8010577f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
80105782:	8b 45 08             	mov    0x8(%ebp),%eax
80105785:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80105788:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010578c:	7f 05                	jg     80105793 <safestrcpy+0x1b>
    return os;
8010578e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105791:	eb 31                	jmp    801057c4 <safestrcpy+0x4c>
  while(--n > 0 && (*s++ = *t++) != 0)
80105793:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105797:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010579b:	7e 1e                	jle    801057bb <safestrcpy+0x43>
8010579d:	8b 55 0c             	mov    0xc(%ebp),%edx
801057a0:	8d 42 01             	lea    0x1(%edx),%eax
801057a3:	89 45 0c             	mov    %eax,0xc(%ebp)
801057a6:	8b 45 08             	mov    0x8(%ebp),%eax
801057a9:	8d 48 01             	lea    0x1(%eax),%ecx
801057ac:	89 4d 08             	mov    %ecx,0x8(%ebp)
801057af:	0f b6 12             	movzbl (%edx),%edx
801057b2:	88 10                	mov    %dl,(%eax)
801057b4:	0f b6 00             	movzbl (%eax),%eax
801057b7:	84 c0                	test   %al,%al
801057b9:	75 d8                	jne    80105793 <safestrcpy+0x1b>
    ;
  *s = 0;
801057bb:	8b 45 08             	mov    0x8(%ebp),%eax
801057be:	c6 00 00             	movb   $0x0,(%eax)
  return os;
801057c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801057c4:	c9                   	leave  
801057c5:	c3                   	ret    

801057c6 <strlen>:

int
strlen(const char *s)
{
801057c6:	f3 0f 1e fb          	endbr32 
801057ca:	55                   	push   %ebp
801057cb:	89 e5                	mov    %esp,%ebp
801057cd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
801057d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801057d7:	eb 04                	jmp    801057dd <strlen+0x17>
801057d9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801057dd:	8b 55 fc             	mov    -0x4(%ebp),%edx
801057e0:	8b 45 08             	mov    0x8(%ebp),%eax
801057e3:	01 d0                	add    %edx,%eax
801057e5:	0f b6 00             	movzbl (%eax),%eax
801057e8:	84 c0                	test   %al,%al
801057ea:	75 ed                	jne    801057d9 <strlen+0x13>
    ;
  return n;
801057ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801057ef:	c9                   	leave  
801057f0:	c3                   	ret    

801057f1 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801057f1:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801057f5:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801057f9:	55                   	push   %ebp
  pushl %ebx
801057fa:	53                   	push   %ebx
  pushl %esi
801057fb:	56                   	push   %esi
  pushl %edi
801057fc:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801057fd:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801057ff:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105801:	5f                   	pop    %edi
  popl %esi
80105802:	5e                   	pop    %esi
  popl %ebx
80105803:	5b                   	pop    %ebx
  popl %ebp
80105804:	5d                   	pop    %ebp
  ret
80105805:	c3                   	ret    

80105806 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105806:	f3 0f 1e fb          	endbr32 
8010580a:	55                   	push   %ebp
8010580b:	89 e5                	mov    %esp,%ebp
8010580d:	83 ec 18             	sub    $0x18,%esp
  struct proc *curproc = myproc();
80105810:	e8 22 ec ff ff       	call   80104437 <myproc>
80105815:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105818:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010581b:	8b 00                	mov    (%eax),%eax
8010581d:	39 45 08             	cmp    %eax,0x8(%ebp)
80105820:	73 0f                	jae    80105831 <fetchint+0x2b>
80105822:	8b 45 08             	mov    0x8(%ebp),%eax
80105825:	8d 50 04             	lea    0x4(%eax),%edx
80105828:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010582b:	8b 00                	mov    (%eax),%eax
8010582d:	39 c2                	cmp    %eax,%edx
8010582f:	76 07                	jbe    80105838 <fetchint+0x32>
    return -1;
80105831:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105836:	eb 0f                	jmp    80105847 <fetchint+0x41>
  *ip = *(int*)(addr);
80105838:	8b 45 08             	mov    0x8(%ebp),%eax
8010583b:	8b 10                	mov    (%eax),%edx
8010583d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105840:	89 10                	mov    %edx,(%eax)
  return 0;
80105842:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105847:	c9                   	leave  
80105848:	c3                   	ret    

80105849 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105849:	f3 0f 1e fb          	endbr32 
8010584d:	55                   	push   %ebp
8010584e:	89 e5                	mov    %esp,%ebp
80105850:	83 ec 18             	sub    $0x18,%esp
  char *s, *ep;
  struct proc *curproc = myproc();
80105853:	e8 df eb ff ff       	call   80104437 <myproc>
80105858:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(addr >= curproc->sz)
8010585b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010585e:	8b 00                	mov    (%eax),%eax
80105860:	39 45 08             	cmp    %eax,0x8(%ebp)
80105863:	72 07                	jb     8010586c <fetchstr+0x23>
    return -1;
80105865:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586a:	eb 43                	jmp    801058af <fetchstr+0x66>
  *pp = (char*)addr;
8010586c:	8b 55 08             	mov    0x8(%ebp),%edx
8010586f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105872:	89 10                	mov    %edx,(%eax)
  ep = (char*)curproc->sz;
80105874:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105877:	8b 00                	mov    (%eax),%eax
80105879:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(s = *pp; s < ep; s++){
8010587c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010587f:	8b 00                	mov    (%eax),%eax
80105881:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105884:	eb 1c                	jmp    801058a2 <fetchstr+0x59>
    if(*s == 0)
80105886:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105889:	0f b6 00             	movzbl (%eax),%eax
8010588c:	84 c0                	test   %al,%al
8010588e:	75 0e                	jne    8010589e <fetchstr+0x55>
      return s - *pp;
80105890:	8b 45 0c             	mov    0xc(%ebp),%eax
80105893:	8b 00                	mov    (%eax),%eax
80105895:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105898:	29 c2                	sub    %eax,%edx
8010589a:	89 d0                	mov    %edx,%eax
8010589c:	eb 11                	jmp    801058af <fetchstr+0x66>
  for(s = *pp; s < ep; s++){
8010589e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801058a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058a5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801058a8:	72 dc                	jb     80105886 <fetchstr+0x3d>
  }
  return -1;
801058aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058af:	c9                   	leave  
801058b0:	c3                   	ret    

801058b1 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801058b1:	f3 0f 1e fb          	endbr32 
801058b5:	55                   	push   %ebp
801058b6:	89 e5                	mov    %esp,%ebp
801058b8:	83 ec 08             	sub    $0x8,%esp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801058bb:	e8 77 eb ff ff       	call   80104437 <myproc>
801058c0:	8b 40 18             	mov    0x18(%eax),%eax
801058c3:	8b 40 44             	mov    0x44(%eax),%eax
801058c6:	8b 55 08             	mov    0x8(%ebp),%edx
801058c9:	c1 e2 02             	shl    $0x2,%edx
801058cc:	01 d0                	add    %edx,%eax
801058ce:	83 c0 04             	add    $0x4,%eax
801058d1:	83 ec 08             	sub    $0x8,%esp
801058d4:	ff 75 0c             	pushl  0xc(%ebp)
801058d7:	50                   	push   %eax
801058d8:	e8 29 ff ff ff       	call   80105806 <fetchint>
801058dd:	83 c4 10             	add    $0x10,%esp
}
801058e0:	c9                   	leave  
801058e1:	c3                   	ret    

801058e2 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801058e2:	f3 0f 1e fb          	endbr32 
801058e6:	55                   	push   %ebp
801058e7:	89 e5                	mov    %esp,%ebp
801058e9:	83 ec 18             	sub    $0x18,%esp
  int i;
  struct proc *curproc = myproc();
801058ec:	e8 46 eb ff ff       	call   80104437 <myproc>
801058f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 
  if(argint(n, &i) < 0)
801058f4:	83 ec 08             	sub    $0x8,%esp
801058f7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058fa:	50                   	push   %eax
801058fb:	ff 75 08             	pushl  0x8(%ebp)
801058fe:	e8 ae ff ff ff       	call   801058b1 <argint>
80105903:	83 c4 10             	add    $0x10,%esp
80105906:	85 c0                	test   %eax,%eax
80105908:	79 07                	jns    80105911 <argptr+0x2f>
    return -1;
8010590a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010590f:	eb 3b                	jmp    8010594c <argptr+0x6a>
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105911:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105915:	78 1f                	js     80105936 <argptr+0x54>
80105917:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010591a:	8b 00                	mov    (%eax),%eax
8010591c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010591f:	39 d0                	cmp    %edx,%eax
80105921:	76 13                	jbe    80105936 <argptr+0x54>
80105923:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105926:	89 c2                	mov    %eax,%edx
80105928:	8b 45 10             	mov    0x10(%ebp),%eax
8010592b:	01 c2                	add    %eax,%edx
8010592d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105930:	8b 00                	mov    (%eax),%eax
80105932:	39 c2                	cmp    %eax,%edx
80105934:	76 07                	jbe    8010593d <argptr+0x5b>
    return -1;
80105936:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010593b:	eb 0f                	jmp    8010594c <argptr+0x6a>
  *pp = (char*)i;
8010593d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105940:	89 c2                	mov    %eax,%edx
80105942:	8b 45 0c             	mov    0xc(%ebp),%eax
80105945:	89 10                	mov    %edx,(%eax)
  return 0;
80105947:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010594c:	c9                   	leave  
8010594d:	c3                   	ret    

8010594e <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
8010594e:	f3 0f 1e fb          	endbr32 
80105952:	55                   	push   %ebp
80105953:	89 e5                	mov    %esp,%ebp
80105955:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105958:	83 ec 08             	sub    $0x8,%esp
8010595b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010595e:	50                   	push   %eax
8010595f:	ff 75 08             	pushl  0x8(%ebp)
80105962:	e8 4a ff ff ff       	call   801058b1 <argint>
80105967:	83 c4 10             	add    $0x10,%esp
8010596a:	85 c0                	test   %eax,%eax
8010596c:	79 07                	jns    80105975 <argstr+0x27>
    return -1;
8010596e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105973:	eb 12                	jmp    80105987 <argstr+0x39>
  return fetchstr(addr, pp);
80105975:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105978:	83 ec 08             	sub    $0x8,%esp
8010597b:	ff 75 0c             	pushl  0xc(%ebp)
8010597e:	50                   	push   %eax
8010597f:	e8 c5 fe ff ff       	call   80105849 <fetchstr>
80105984:	83 c4 10             	add    $0x10,%esp
}
80105987:	c9                   	leave  
80105988:	c3                   	ret    

80105989 <syscall>:
[SYS_getpinfo]    sys_getpinfo,
};

void
syscall(void)
{
80105989:	f3 0f 1e fb          	endbr32 
8010598d:	55                   	push   %ebp
8010598e:	89 e5                	mov    %esp,%ebp
80105990:	83 ec 18             	sub    $0x18,%esp
  int num;
  struct proc *curproc = myproc();
80105993:	e8 9f ea ff ff       	call   80104437 <myproc>
80105998:	89 45 f4             	mov    %eax,-0xc(%ebp)

  num = curproc->tf->eax;
8010599b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010599e:	8b 40 18             	mov    0x18(%eax),%eax
801059a1:	8b 40 1c             	mov    0x1c(%eax),%eax
801059a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801059a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801059ab:	7e 2f                	jle    801059dc <syscall+0x53>
801059ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059b0:	83 f8 17             	cmp    $0x17,%eax
801059b3:	77 27                	ja     801059dc <syscall+0x53>
801059b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059b8:	8b 04 85 20 b0 10 80 	mov    -0x7fef4fe0(,%eax,4),%eax
801059bf:	85 c0                	test   %eax,%eax
801059c1:	74 19                	je     801059dc <syscall+0x53>
    curproc->tf->eax = syscalls[num]();
801059c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059c6:	8b 04 85 20 b0 10 80 	mov    -0x7fef4fe0(,%eax,4),%eax
801059cd:	ff d0                	call   *%eax
801059cf:	89 c2                	mov    %eax,%edx
801059d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059d4:	8b 40 18             	mov    0x18(%eax),%eax
801059d7:	89 50 1c             	mov    %edx,0x1c(%eax)
801059da:	eb 2c                	jmp    80105a08 <syscall+0x7f>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
801059dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059df:	8d 50 6c             	lea    0x6c(%eax),%edx
    cprintf("%d %s: unknown sys call %d\n",
801059e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059e5:	8b 40 10             	mov    0x10(%eax),%eax
801059e8:	ff 75 f0             	pushl  -0x10(%ebp)
801059eb:	52                   	push   %edx
801059ec:	50                   	push   %eax
801059ed:	68 68 8c 10 80       	push   $0x80108c68
801059f2:	e8 21 aa ff ff       	call   80100418 <cprintf>
801059f7:	83 c4 10             	add    $0x10,%esp
    curproc->tf->eax = -1;
801059fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059fd:	8b 40 18             	mov    0x18(%eax),%eax
80105a00:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105a07:	90                   	nop
80105a08:	90                   	nop
80105a09:	c9                   	leave  
80105a0a:	c3                   	ret    

80105a0b <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105a0b:	f3 0f 1e fb          	endbr32 
80105a0f:	55                   	push   %ebp
80105a10:	89 e5                	mov    %esp,%ebp
80105a12:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105a15:	83 ec 08             	sub    $0x8,%esp
80105a18:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a1b:	50                   	push   %eax
80105a1c:	ff 75 08             	pushl  0x8(%ebp)
80105a1f:	e8 8d fe ff ff       	call   801058b1 <argint>
80105a24:	83 c4 10             	add    $0x10,%esp
80105a27:	85 c0                	test   %eax,%eax
80105a29:	79 07                	jns    80105a32 <argfd+0x27>
    return -1;
80105a2b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a30:	eb 4f                	jmp    80105a81 <argfd+0x76>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105a32:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a35:	85 c0                	test   %eax,%eax
80105a37:	78 20                	js     80105a59 <argfd+0x4e>
80105a39:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a3c:	83 f8 0f             	cmp    $0xf,%eax
80105a3f:	7f 18                	jg     80105a59 <argfd+0x4e>
80105a41:	e8 f1 e9 ff ff       	call   80104437 <myproc>
80105a46:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a49:	83 c2 08             	add    $0x8,%edx
80105a4c:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105a50:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105a53:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a57:	75 07                	jne    80105a60 <argfd+0x55>
    return -1;
80105a59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a5e:	eb 21                	jmp    80105a81 <argfd+0x76>
  if(pfd)
80105a60:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105a64:	74 08                	je     80105a6e <argfd+0x63>
    *pfd = fd;
80105a66:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a69:	8b 45 0c             	mov    0xc(%ebp),%eax
80105a6c:	89 10                	mov    %edx,(%eax)
  if(pf)
80105a6e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105a72:	74 08                	je     80105a7c <argfd+0x71>
    *pf = f;
80105a74:	8b 45 10             	mov    0x10(%ebp),%eax
80105a77:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a7a:	89 10                	mov    %edx,(%eax)
  return 0;
80105a7c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105a81:	c9                   	leave  
80105a82:	c3                   	ret    

80105a83 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105a83:	f3 0f 1e fb          	endbr32 
80105a87:	55                   	push   %ebp
80105a88:	89 e5                	mov    %esp,%ebp
80105a8a:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct proc *curproc = myproc();
80105a8d:	e8 a5 e9 ff ff       	call   80104437 <myproc>
80105a92:	89 45 f0             	mov    %eax,-0x10(%ebp)

  for(fd = 0; fd < NOFILE; fd++){
80105a95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80105a9c:	eb 2a                	jmp    80105ac8 <fdalloc+0x45>
    if(curproc->ofile[fd] == 0){
80105a9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105aa1:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105aa4:	83 c2 08             	add    $0x8,%edx
80105aa7:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105aab:	85 c0                	test   %eax,%eax
80105aad:	75 15                	jne    80105ac4 <fdalloc+0x41>
      curproc->ofile[fd] = f;
80105aaf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ab2:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ab5:	8d 4a 08             	lea    0x8(%edx),%ecx
80105ab8:	8b 55 08             	mov    0x8(%ebp),%edx
80105abb:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105abf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ac2:	eb 0f                	jmp    80105ad3 <fdalloc+0x50>
  for(fd = 0; fd < NOFILE; fd++){
80105ac4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105ac8:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105acc:	7e d0                	jle    80105a9e <fdalloc+0x1b>
    }
  }
  return -1;
80105ace:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ad3:	c9                   	leave  
80105ad4:	c3                   	ret    

80105ad5 <sys_dup>:

int
sys_dup(void)
{
80105ad5:	f3 0f 1e fb          	endbr32 
80105ad9:	55                   	push   %ebp
80105ada:	89 e5                	mov    %esp,%ebp
80105adc:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105adf:	83 ec 04             	sub    $0x4,%esp
80105ae2:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ae5:	50                   	push   %eax
80105ae6:	6a 00                	push   $0x0
80105ae8:	6a 00                	push   $0x0
80105aea:	e8 1c ff ff ff       	call   80105a0b <argfd>
80105aef:	83 c4 10             	add    $0x10,%esp
80105af2:	85 c0                	test   %eax,%eax
80105af4:	79 07                	jns    80105afd <sys_dup+0x28>
    return -1;
80105af6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105afb:	eb 31                	jmp    80105b2e <sys_dup+0x59>
  if((fd=fdalloc(f)) < 0)
80105afd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b00:	83 ec 0c             	sub    $0xc,%esp
80105b03:	50                   	push   %eax
80105b04:	e8 7a ff ff ff       	call   80105a83 <fdalloc>
80105b09:	83 c4 10             	add    $0x10,%esp
80105b0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b13:	79 07                	jns    80105b1c <sys_dup+0x47>
    return -1;
80105b15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b1a:	eb 12                	jmp    80105b2e <sys_dup+0x59>
  filedup(f);
80105b1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b1f:	83 ec 0c             	sub    $0xc,%esp
80105b22:	50                   	push   %eax
80105b23:	e8 ac b5 ff ff       	call   801010d4 <filedup>
80105b28:	83 c4 10             	add    $0x10,%esp
  return fd;
80105b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105b2e:	c9                   	leave  
80105b2f:	c3                   	ret    

80105b30 <sys_read>:

int
sys_read(void)
{
80105b30:	f3 0f 1e fb          	endbr32 
80105b34:	55                   	push   %ebp
80105b35:	89 e5                	mov    %esp,%ebp
80105b37:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b3a:	83 ec 04             	sub    $0x4,%esp
80105b3d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b40:	50                   	push   %eax
80105b41:	6a 00                	push   $0x0
80105b43:	6a 00                	push   $0x0
80105b45:	e8 c1 fe ff ff       	call   80105a0b <argfd>
80105b4a:	83 c4 10             	add    $0x10,%esp
80105b4d:	85 c0                	test   %eax,%eax
80105b4f:	78 2e                	js     80105b7f <sys_read+0x4f>
80105b51:	83 ec 08             	sub    $0x8,%esp
80105b54:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b57:	50                   	push   %eax
80105b58:	6a 02                	push   $0x2
80105b5a:	e8 52 fd ff ff       	call   801058b1 <argint>
80105b5f:	83 c4 10             	add    $0x10,%esp
80105b62:	85 c0                	test   %eax,%eax
80105b64:	78 19                	js     80105b7f <sys_read+0x4f>
80105b66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b69:	83 ec 04             	sub    $0x4,%esp
80105b6c:	50                   	push   %eax
80105b6d:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105b70:	50                   	push   %eax
80105b71:	6a 01                	push   $0x1
80105b73:	e8 6a fd ff ff       	call   801058e2 <argptr>
80105b78:	83 c4 10             	add    $0x10,%esp
80105b7b:	85 c0                	test   %eax,%eax
80105b7d:	79 07                	jns    80105b86 <sys_read+0x56>
    return -1;
80105b7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b84:	eb 17                	jmp    80105b9d <sys_read+0x6d>
  return fileread(f, p, n);
80105b86:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105b89:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105b8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b8f:	83 ec 04             	sub    $0x4,%esp
80105b92:	51                   	push   %ecx
80105b93:	52                   	push   %edx
80105b94:	50                   	push   %eax
80105b95:	e8 d6 b6 ff ff       	call   80101270 <fileread>
80105b9a:	83 c4 10             	add    $0x10,%esp
}
80105b9d:	c9                   	leave  
80105b9e:	c3                   	ret    

80105b9f <sys_write>:

int
sys_write(void)
{
80105b9f:	f3 0f 1e fb          	endbr32 
80105ba3:	55                   	push   %ebp
80105ba4:	89 e5                	mov    %esp,%ebp
80105ba6:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105ba9:	83 ec 04             	sub    $0x4,%esp
80105bac:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105baf:	50                   	push   %eax
80105bb0:	6a 00                	push   $0x0
80105bb2:	6a 00                	push   $0x0
80105bb4:	e8 52 fe ff ff       	call   80105a0b <argfd>
80105bb9:	83 c4 10             	add    $0x10,%esp
80105bbc:	85 c0                	test   %eax,%eax
80105bbe:	78 2e                	js     80105bee <sys_write+0x4f>
80105bc0:	83 ec 08             	sub    $0x8,%esp
80105bc3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105bc6:	50                   	push   %eax
80105bc7:	6a 02                	push   $0x2
80105bc9:	e8 e3 fc ff ff       	call   801058b1 <argint>
80105bce:	83 c4 10             	add    $0x10,%esp
80105bd1:	85 c0                	test   %eax,%eax
80105bd3:	78 19                	js     80105bee <sys_write+0x4f>
80105bd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bd8:	83 ec 04             	sub    $0x4,%esp
80105bdb:	50                   	push   %eax
80105bdc:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105bdf:	50                   	push   %eax
80105be0:	6a 01                	push   $0x1
80105be2:	e8 fb fc ff ff       	call   801058e2 <argptr>
80105be7:	83 c4 10             	add    $0x10,%esp
80105bea:	85 c0                	test   %eax,%eax
80105bec:	79 07                	jns    80105bf5 <sys_write+0x56>
    return -1;
80105bee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bf3:	eb 17                	jmp    80105c0c <sys_write+0x6d>
  return filewrite(f, p, n);
80105bf5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105bf8:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105bfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bfe:	83 ec 04             	sub    $0x4,%esp
80105c01:	51                   	push   %ecx
80105c02:	52                   	push   %edx
80105c03:	50                   	push   %eax
80105c04:	e8 23 b7 ff ff       	call   8010132c <filewrite>
80105c09:	83 c4 10             	add    $0x10,%esp
}
80105c0c:	c9                   	leave  
80105c0d:	c3                   	ret    

80105c0e <sys_close>:

int
sys_close(void)
{
80105c0e:	f3 0f 1e fb          	endbr32 
80105c12:	55                   	push   %ebp
80105c13:	89 e5                	mov    %esp,%ebp
80105c15:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105c18:	83 ec 04             	sub    $0x4,%esp
80105c1b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c1e:	50                   	push   %eax
80105c1f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c22:	50                   	push   %eax
80105c23:	6a 00                	push   $0x0
80105c25:	e8 e1 fd ff ff       	call   80105a0b <argfd>
80105c2a:	83 c4 10             	add    $0x10,%esp
80105c2d:	85 c0                	test   %eax,%eax
80105c2f:	79 07                	jns    80105c38 <sys_close+0x2a>
    return -1;
80105c31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c36:	eb 27                	jmp    80105c5f <sys_close+0x51>
  myproc()->ofile[fd] = 0;
80105c38:	e8 fa e7 ff ff       	call   80104437 <myproc>
80105c3d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c40:	83 c2 08             	add    $0x8,%edx
80105c43:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105c4a:	00 
  fileclose(f);
80105c4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c4e:	83 ec 0c             	sub    $0xc,%esp
80105c51:	50                   	push   %eax
80105c52:	e8 d2 b4 ff ff       	call   80101129 <fileclose>
80105c57:	83 c4 10             	add    $0x10,%esp
  return 0;
80105c5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105c5f:	c9                   	leave  
80105c60:	c3                   	ret    

80105c61 <sys_fstat>:

int
sys_fstat(void)
{
80105c61:	f3 0f 1e fb          	endbr32 
80105c65:	55                   	push   %ebp
80105c66:	89 e5                	mov    %esp,%ebp
80105c68:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105c6b:	83 ec 04             	sub    $0x4,%esp
80105c6e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c71:	50                   	push   %eax
80105c72:	6a 00                	push   $0x0
80105c74:	6a 00                	push   $0x0
80105c76:	e8 90 fd ff ff       	call   80105a0b <argfd>
80105c7b:	83 c4 10             	add    $0x10,%esp
80105c7e:	85 c0                	test   %eax,%eax
80105c80:	78 17                	js     80105c99 <sys_fstat+0x38>
80105c82:	83 ec 04             	sub    $0x4,%esp
80105c85:	6a 14                	push   $0x14
80105c87:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c8a:	50                   	push   %eax
80105c8b:	6a 01                	push   $0x1
80105c8d:	e8 50 fc ff ff       	call   801058e2 <argptr>
80105c92:	83 c4 10             	add    $0x10,%esp
80105c95:	85 c0                	test   %eax,%eax
80105c97:	79 07                	jns    80105ca0 <sys_fstat+0x3f>
    return -1;
80105c99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c9e:	eb 13                	jmp    80105cb3 <sys_fstat+0x52>
  return filestat(f, st);
80105ca0:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105ca3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ca6:	83 ec 08             	sub    $0x8,%esp
80105ca9:	52                   	push   %edx
80105caa:	50                   	push   %eax
80105cab:	e8 65 b5 ff ff       	call   80101215 <filestat>
80105cb0:	83 c4 10             	add    $0x10,%esp
}
80105cb3:	c9                   	leave  
80105cb4:	c3                   	ret    

80105cb5 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105cb5:	f3 0f 1e fb          	endbr32 
80105cb9:	55                   	push   %ebp
80105cba:	89 e5                	mov    %esp,%ebp
80105cbc:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105cbf:	83 ec 08             	sub    $0x8,%esp
80105cc2:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105cc5:	50                   	push   %eax
80105cc6:	6a 00                	push   $0x0
80105cc8:	e8 81 fc ff ff       	call   8010594e <argstr>
80105ccd:	83 c4 10             	add    $0x10,%esp
80105cd0:	85 c0                	test   %eax,%eax
80105cd2:	78 15                	js     80105ce9 <sys_link+0x34>
80105cd4:	83 ec 08             	sub    $0x8,%esp
80105cd7:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105cda:	50                   	push   %eax
80105cdb:	6a 01                	push   $0x1
80105cdd:	e8 6c fc ff ff       	call   8010594e <argstr>
80105ce2:	83 c4 10             	add    $0x10,%esp
80105ce5:	85 c0                	test   %eax,%eax
80105ce7:	79 0a                	jns    80105cf3 <sys_link+0x3e>
    return -1;
80105ce9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cee:	e9 68 01 00 00       	jmp    80105e5b <sys_link+0x1a6>

  begin_op();
80105cf3:	e8 80 d9 ff ff       	call   80103678 <begin_op>
  if((ip = namei(old)) == 0){
80105cf8:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105cfb:	83 ec 0c             	sub    $0xc,%esp
80105cfe:	50                   	push   %eax
80105cff:	e8 10 c9 ff ff       	call   80102614 <namei>
80105d04:	83 c4 10             	add    $0x10,%esp
80105d07:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d0a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d0e:	75 0f                	jne    80105d1f <sys_link+0x6a>
    end_op();
80105d10:	e8 f3 d9 ff ff       	call   80103708 <end_op>
    return -1;
80105d15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d1a:	e9 3c 01 00 00       	jmp    80105e5b <sys_link+0x1a6>
  }

  ilock(ip);
80105d1f:	83 ec 0c             	sub    $0xc,%esp
80105d22:	ff 75 f4             	pushl  -0xc(%ebp)
80105d25:	e8 7f bd ff ff       	call   80101aa9 <ilock>
80105d2a:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105d2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d30:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105d34:	66 83 f8 01          	cmp    $0x1,%ax
80105d38:	75 1d                	jne    80105d57 <sys_link+0xa2>
    iunlockput(ip);
80105d3a:	83 ec 0c             	sub    $0xc,%esp
80105d3d:	ff 75 f4             	pushl  -0xc(%ebp)
80105d40:	e8 a1 bf ff ff       	call   80101ce6 <iunlockput>
80105d45:	83 c4 10             	add    $0x10,%esp
    end_op();
80105d48:	e8 bb d9 ff ff       	call   80103708 <end_op>
    return -1;
80105d4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d52:	e9 04 01 00 00       	jmp    80105e5b <sys_link+0x1a6>
  }

  ip->nlink++;
80105d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d5a:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105d5e:	83 c0 01             	add    $0x1,%eax
80105d61:	89 c2                	mov    %eax,%edx
80105d63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d66:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
80105d6a:	83 ec 0c             	sub    $0xc,%esp
80105d6d:	ff 75 f4             	pushl  -0xc(%ebp)
80105d70:	e8 4b bb ff ff       	call   801018c0 <iupdate>
80105d75:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105d78:	83 ec 0c             	sub    $0xc,%esp
80105d7b:	ff 75 f4             	pushl  -0xc(%ebp)
80105d7e:	e8 3d be ff ff       	call   80101bc0 <iunlock>
80105d83:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105d86:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d89:	83 ec 08             	sub    $0x8,%esp
80105d8c:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105d8f:	52                   	push   %edx
80105d90:	50                   	push   %eax
80105d91:	e8 9e c8 ff ff       	call   80102634 <nameiparent>
80105d96:	83 c4 10             	add    $0x10,%esp
80105d99:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d9c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105da0:	74 71                	je     80105e13 <sys_link+0x15e>
    goto bad;
  ilock(dp);
80105da2:	83 ec 0c             	sub    $0xc,%esp
80105da5:	ff 75 f0             	pushl  -0x10(%ebp)
80105da8:	e8 fc bc ff ff       	call   80101aa9 <ilock>
80105dad:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105db0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105db3:	8b 10                	mov    (%eax),%edx
80105db5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105db8:	8b 00                	mov    (%eax),%eax
80105dba:	39 c2                	cmp    %eax,%edx
80105dbc:	75 1d                	jne    80105ddb <sys_link+0x126>
80105dbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dc1:	8b 40 04             	mov    0x4(%eax),%eax
80105dc4:	83 ec 04             	sub    $0x4,%esp
80105dc7:	50                   	push   %eax
80105dc8:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105dcb:	50                   	push   %eax
80105dcc:	ff 75 f0             	pushl  -0x10(%ebp)
80105dcf:	e8 9d c5 ff ff       	call   80102371 <dirlink>
80105dd4:	83 c4 10             	add    $0x10,%esp
80105dd7:	85 c0                	test   %eax,%eax
80105dd9:	79 10                	jns    80105deb <sys_link+0x136>
    iunlockput(dp);
80105ddb:	83 ec 0c             	sub    $0xc,%esp
80105dde:	ff 75 f0             	pushl  -0x10(%ebp)
80105de1:	e8 00 bf ff ff       	call   80101ce6 <iunlockput>
80105de6:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105de9:	eb 29                	jmp    80105e14 <sys_link+0x15f>
  }
  iunlockput(dp);
80105deb:	83 ec 0c             	sub    $0xc,%esp
80105dee:	ff 75 f0             	pushl  -0x10(%ebp)
80105df1:	e8 f0 be ff ff       	call   80101ce6 <iunlockput>
80105df6:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105df9:	83 ec 0c             	sub    $0xc,%esp
80105dfc:	ff 75 f4             	pushl  -0xc(%ebp)
80105dff:	e8 0e be ff ff       	call   80101c12 <iput>
80105e04:	83 c4 10             	add    $0x10,%esp

  end_op();
80105e07:	e8 fc d8 ff ff       	call   80103708 <end_op>

  return 0;
80105e0c:	b8 00 00 00 00       	mov    $0x0,%eax
80105e11:	eb 48                	jmp    80105e5b <sys_link+0x1a6>
    goto bad;
80105e13:	90                   	nop

bad:
  ilock(ip);
80105e14:	83 ec 0c             	sub    $0xc,%esp
80105e17:	ff 75 f4             	pushl  -0xc(%ebp)
80105e1a:	e8 8a bc ff ff       	call   80101aa9 <ilock>
80105e1f:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105e22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e25:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105e29:	83 e8 01             	sub    $0x1,%eax
80105e2c:	89 c2                	mov    %eax,%edx
80105e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e31:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
80105e35:	83 ec 0c             	sub    $0xc,%esp
80105e38:	ff 75 f4             	pushl  -0xc(%ebp)
80105e3b:	e8 80 ba ff ff       	call   801018c0 <iupdate>
80105e40:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105e43:	83 ec 0c             	sub    $0xc,%esp
80105e46:	ff 75 f4             	pushl  -0xc(%ebp)
80105e49:	e8 98 be ff ff       	call   80101ce6 <iunlockput>
80105e4e:	83 c4 10             	add    $0x10,%esp
  end_op();
80105e51:	e8 b2 d8 ff ff       	call   80103708 <end_op>
  return -1;
80105e56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e5b:	c9                   	leave  
80105e5c:	c3                   	ret    

80105e5d <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105e5d:	f3 0f 1e fb          	endbr32 
80105e61:	55                   	push   %ebp
80105e62:	89 e5                	mov    %esp,%ebp
80105e64:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105e67:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105e6e:	eb 40                	jmp    80105eb0 <isdirempty+0x53>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105e70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e73:	6a 10                	push   $0x10
80105e75:	50                   	push   %eax
80105e76:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105e79:	50                   	push   %eax
80105e7a:	ff 75 08             	pushl  0x8(%ebp)
80105e7d:	e8 2f c1 ff ff       	call   80101fb1 <readi>
80105e82:	83 c4 10             	add    $0x10,%esp
80105e85:	83 f8 10             	cmp    $0x10,%eax
80105e88:	74 0d                	je     80105e97 <isdirempty+0x3a>
      panic("isdirempty: readi");
80105e8a:	83 ec 0c             	sub    $0xc,%esp
80105e8d:	68 84 8c 10 80       	push   $0x80108c84
80105e92:	e8 3a a7 ff ff       	call   801005d1 <panic>
    if(de.inum != 0)
80105e97:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105e9b:	66 85 c0             	test   %ax,%ax
80105e9e:	74 07                	je     80105ea7 <isdirempty+0x4a>
      return 0;
80105ea0:	b8 00 00 00 00       	mov    $0x0,%eax
80105ea5:	eb 1b                	jmp    80105ec2 <isdirempty+0x65>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105ea7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105eaa:	83 c0 10             	add    $0x10,%eax
80105ead:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105eb0:	8b 45 08             	mov    0x8(%ebp),%eax
80105eb3:	8b 50 58             	mov    0x58(%eax),%edx
80105eb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105eb9:	39 c2                	cmp    %eax,%edx
80105ebb:	77 b3                	ja     80105e70 <isdirempty+0x13>
  }
  return 1;
80105ebd:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105ec2:	c9                   	leave  
80105ec3:	c3                   	ret    

80105ec4 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105ec4:	f3 0f 1e fb          	endbr32 
80105ec8:	55                   	push   %ebp
80105ec9:	89 e5                	mov    %esp,%ebp
80105ecb:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105ece:	83 ec 08             	sub    $0x8,%esp
80105ed1:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105ed4:	50                   	push   %eax
80105ed5:	6a 00                	push   $0x0
80105ed7:	e8 72 fa ff ff       	call   8010594e <argstr>
80105edc:	83 c4 10             	add    $0x10,%esp
80105edf:	85 c0                	test   %eax,%eax
80105ee1:	79 0a                	jns    80105eed <sys_unlink+0x29>
    return -1;
80105ee3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ee8:	e9 bf 01 00 00       	jmp    801060ac <sys_unlink+0x1e8>

  begin_op();
80105eed:	e8 86 d7 ff ff       	call   80103678 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105ef2:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105ef5:	83 ec 08             	sub    $0x8,%esp
80105ef8:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105efb:	52                   	push   %edx
80105efc:	50                   	push   %eax
80105efd:	e8 32 c7 ff ff       	call   80102634 <nameiparent>
80105f02:	83 c4 10             	add    $0x10,%esp
80105f05:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f08:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f0c:	75 0f                	jne    80105f1d <sys_unlink+0x59>
    end_op();
80105f0e:	e8 f5 d7 ff ff       	call   80103708 <end_op>
    return -1;
80105f13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f18:	e9 8f 01 00 00       	jmp    801060ac <sys_unlink+0x1e8>
  }

  ilock(dp);
80105f1d:	83 ec 0c             	sub    $0xc,%esp
80105f20:	ff 75 f4             	pushl  -0xc(%ebp)
80105f23:	e8 81 bb ff ff       	call   80101aa9 <ilock>
80105f28:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105f2b:	83 ec 08             	sub    $0x8,%esp
80105f2e:	68 96 8c 10 80       	push   $0x80108c96
80105f33:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105f36:	50                   	push   %eax
80105f37:	e8 58 c3 ff ff       	call   80102294 <namecmp>
80105f3c:	83 c4 10             	add    $0x10,%esp
80105f3f:	85 c0                	test   %eax,%eax
80105f41:	0f 84 49 01 00 00    	je     80106090 <sys_unlink+0x1cc>
80105f47:	83 ec 08             	sub    $0x8,%esp
80105f4a:	68 98 8c 10 80       	push   $0x80108c98
80105f4f:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105f52:	50                   	push   %eax
80105f53:	e8 3c c3 ff ff       	call   80102294 <namecmp>
80105f58:	83 c4 10             	add    $0x10,%esp
80105f5b:	85 c0                	test   %eax,%eax
80105f5d:	0f 84 2d 01 00 00    	je     80106090 <sys_unlink+0x1cc>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105f63:	83 ec 04             	sub    $0x4,%esp
80105f66:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105f69:	50                   	push   %eax
80105f6a:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105f6d:	50                   	push   %eax
80105f6e:	ff 75 f4             	pushl  -0xc(%ebp)
80105f71:	e8 3d c3 ff ff       	call   801022b3 <dirlookup>
80105f76:	83 c4 10             	add    $0x10,%esp
80105f79:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f7c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f80:	0f 84 0d 01 00 00    	je     80106093 <sys_unlink+0x1cf>
    goto bad;
  ilock(ip);
80105f86:	83 ec 0c             	sub    $0xc,%esp
80105f89:	ff 75 f0             	pushl  -0x10(%ebp)
80105f8c:	e8 18 bb ff ff       	call   80101aa9 <ilock>
80105f91:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105f94:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f97:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105f9b:	66 85 c0             	test   %ax,%ax
80105f9e:	7f 0d                	jg     80105fad <sys_unlink+0xe9>
    panic("unlink: nlink < 1");
80105fa0:	83 ec 0c             	sub    $0xc,%esp
80105fa3:	68 9b 8c 10 80       	push   $0x80108c9b
80105fa8:	e8 24 a6 ff ff       	call   801005d1 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105fad:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fb0:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105fb4:	66 83 f8 01          	cmp    $0x1,%ax
80105fb8:	75 25                	jne    80105fdf <sys_unlink+0x11b>
80105fba:	83 ec 0c             	sub    $0xc,%esp
80105fbd:	ff 75 f0             	pushl  -0x10(%ebp)
80105fc0:	e8 98 fe ff ff       	call   80105e5d <isdirempty>
80105fc5:	83 c4 10             	add    $0x10,%esp
80105fc8:	85 c0                	test   %eax,%eax
80105fca:	75 13                	jne    80105fdf <sys_unlink+0x11b>
    iunlockput(ip);
80105fcc:	83 ec 0c             	sub    $0xc,%esp
80105fcf:	ff 75 f0             	pushl  -0x10(%ebp)
80105fd2:	e8 0f bd ff ff       	call   80101ce6 <iunlockput>
80105fd7:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105fda:	e9 b5 00 00 00       	jmp    80106094 <sys_unlink+0x1d0>
  }

  memset(&de, 0, sizeof(de));
80105fdf:	83 ec 04             	sub    $0x4,%esp
80105fe2:	6a 10                	push   $0x10
80105fe4:	6a 00                	push   $0x0
80105fe6:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105fe9:	50                   	push   %eax
80105fea:	e8 6e f5 ff ff       	call   8010555d <memset>
80105fef:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ff2:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105ff5:	6a 10                	push   $0x10
80105ff7:	50                   	push   %eax
80105ff8:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ffb:	50                   	push   %eax
80105ffc:	ff 75 f4             	pushl  -0xc(%ebp)
80105fff:	e8 06 c1 ff ff       	call   8010210a <writei>
80106004:	83 c4 10             	add    $0x10,%esp
80106007:	83 f8 10             	cmp    $0x10,%eax
8010600a:	74 0d                	je     80106019 <sys_unlink+0x155>
    panic("unlink: writei");
8010600c:	83 ec 0c             	sub    $0xc,%esp
8010600f:	68 ad 8c 10 80       	push   $0x80108cad
80106014:	e8 b8 a5 ff ff       	call   801005d1 <panic>
  if(ip->type == T_DIR){
80106019:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010601c:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106020:	66 83 f8 01          	cmp    $0x1,%ax
80106024:	75 21                	jne    80106047 <sys_unlink+0x183>
    dp->nlink--;
80106026:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106029:	0f b7 40 56          	movzwl 0x56(%eax),%eax
8010602d:	83 e8 01             	sub    $0x1,%eax
80106030:	89 c2                	mov    %eax,%edx
80106032:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106035:	66 89 50 56          	mov    %dx,0x56(%eax)
    iupdate(dp);
80106039:	83 ec 0c             	sub    $0xc,%esp
8010603c:	ff 75 f4             	pushl  -0xc(%ebp)
8010603f:	e8 7c b8 ff ff       	call   801018c0 <iupdate>
80106044:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80106047:	83 ec 0c             	sub    $0xc,%esp
8010604a:	ff 75 f4             	pushl  -0xc(%ebp)
8010604d:	e8 94 bc ff ff       	call   80101ce6 <iunlockput>
80106052:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80106055:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106058:	0f b7 40 56          	movzwl 0x56(%eax),%eax
8010605c:	83 e8 01             	sub    $0x1,%eax
8010605f:	89 c2                	mov    %eax,%edx
80106061:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106064:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
80106068:	83 ec 0c             	sub    $0xc,%esp
8010606b:	ff 75 f0             	pushl  -0x10(%ebp)
8010606e:	e8 4d b8 ff ff       	call   801018c0 <iupdate>
80106073:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80106076:	83 ec 0c             	sub    $0xc,%esp
80106079:	ff 75 f0             	pushl  -0x10(%ebp)
8010607c:	e8 65 bc ff ff       	call   80101ce6 <iunlockput>
80106081:	83 c4 10             	add    $0x10,%esp

  end_op();
80106084:	e8 7f d6 ff ff       	call   80103708 <end_op>

  return 0;
80106089:	b8 00 00 00 00       	mov    $0x0,%eax
8010608e:	eb 1c                	jmp    801060ac <sys_unlink+0x1e8>
    goto bad;
80106090:	90                   	nop
80106091:	eb 01                	jmp    80106094 <sys_unlink+0x1d0>
    goto bad;
80106093:	90                   	nop

bad:
  iunlockput(dp);
80106094:	83 ec 0c             	sub    $0xc,%esp
80106097:	ff 75 f4             	pushl  -0xc(%ebp)
8010609a:	e8 47 bc ff ff       	call   80101ce6 <iunlockput>
8010609f:	83 c4 10             	add    $0x10,%esp
  end_op();
801060a2:	e8 61 d6 ff ff       	call   80103708 <end_op>
  return -1;
801060a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060ac:	c9                   	leave  
801060ad:	c3                   	ret    

801060ae <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
801060ae:	f3 0f 1e fb          	endbr32 
801060b2:	55                   	push   %ebp
801060b3:	89 e5                	mov    %esp,%ebp
801060b5:	83 ec 38             	sub    $0x38,%esp
801060b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801060bb:	8b 55 10             	mov    0x10(%ebp),%edx
801060be:	8b 45 14             	mov    0x14(%ebp),%eax
801060c1:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
801060c5:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
801060c9:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801060cd:	83 ec 08             	sub    $0x8,%esp
801060d0:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801060d3:	50                   	push   %eax
801060d4:	ff 75 08             	pushl  0x8(%ebp)
801060d7:	e8 58 c5 ff ff       	call   80102634 <nameiparent>
801060dc:	83 c4 10             	add    $0x10,%esp
801060df:	89 45 f4             	mov    %eax,-0xc(%ebp)
801060e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801060e6:	75 0a                	jne    801060f2 <create+0x44>
    return 0;
801060e8:	b8 00 00 00 00       	mov    $0x0,%eax
801060ed:	e9 8e 01 00 00       	jmp    80106280 <create+0x1d2>
  ilock(dp);
801060f2:	83 ec 0c             	sub    $0xc,%esp
801060f5:	ff 75 f4             	pushl  -0xc(%ebp)
801060f8:	e8 ac b9 ff ff       	call   80101aa9 <ilock>
801060fd:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, 0)) != 0){
80106100:	83 ec 04             	sub    $0x4,%esp
80106103:	6a 00                	push   $0x0
80106105:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106108:	50                   	push   %eax
80106109:	ff 75 f4             	pushl  -0xc(%ebp)
8010610c:	e8 a2 c1 ff ff       	call   801022b3 <dirlookup>
80106111:	83 c4 10             	add    $0x10,%esp
80106114:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106117:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010611b:	74 50                	je     8010616d <create+0xbf>
    iunlockput(dp);
8010611d:	83 ec 0c             	sub    $0xc,%esp
80106120:	ff 75 f4             	pushl  -0xc(%ebp)
80106123:	e8 be bb ff ff       	call   80101ce6 <iunlockput>
80106128:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
8010612b:	83 ec 0c             	sub    $0xc,%esp
8010612e:	ff 75 f0             	pushl  -0x10(%ebp)
80106131:	e8 73 b9 ff ff       	call   80101aa9 <ilock>
80106136:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80106139:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010613e:	75 15                	jne    80106155 <create+0xa7>
80106140:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106143:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106147:	66 83 f8 02          	cmp    $0x2,%ax
8010614b:	75 08                	jne    80106155 <create+0xa7>
      return ip;
8010614d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106150:	e9 2b 01 00 00       	jmp    80106280 <create+0x1d2>
    iunlockput(ip);
80106155:	83 ec 0c             	sub    $0xc,%esp
80106158:	ff 75 f0             	pushl  -0x10(%ebp)
8010615b:	e8 86 bb ff ff       	call   80101ce6 <iunlockput>
80106160:	83 c4 10             	add    $0x10,%esp
    return 0;
80106163:	b8 00 00 00 00       	mov    $0x0,%eax
80106168:	e9 13 01 00 00       	jmp    80106280 <create+0x1d2>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
8010616d:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80106171:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106174:	8b 00                	mov    (%eax),%eax
80106176:	83 ec 08             	sub    $0x8,%esp
80106179:	52                   	push   %edx
8010617a:	50                   	push   %eax
8010617b:	e8 65 b6 ff ff       	call   801017e5 <ialloc>
80106180:	83 c4 10             	add    $0x10,%esp
80106183:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106186:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010618a:	75 0d                	jne    80106199 <create+0xeb>
    panic("create: ialloc");
8010618c:	83 ec 0c             	sub    $0xc,%esp
8010618f:	68 bc 8c 10 80       	push   $0x80108cbc
80106194:	e8 38 a4 ff ff       	call   801005d1 <panic>

  ilock(ip);
80106199:	83 ec 0c             	sub    $0xc,%esp
8010619c:	ff 75 f0             	pushl  -0x10(%ebp)
8010619f:	e8 05 b9 ff ff       	call   80101aa9 <ilock>
801061a4:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
801061a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061aa:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
801061ae:	66 89 50 52          	mov    %dx,0x52(%eax)
  ip->minor = minor;
801061b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061b5:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
801061b9:	66 89 50 54          	mov    %dx,0x54(%eax)
  ip->nlink = 1;
801061bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061c0:	66 c7 40 56 01 00    	movw   $0x1,0x56(%eax)
  iupdate(ip);
801061c6:	83 ec 0c             	sub    $0xc,%esp
801061c9:	ff 75 f0             	pushl  -0x10(%ebp)
801061cc:	e8 ef b6 ff ff       	call   801018c0 <iupdate>
801061d1:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
801061d4:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801061d9:	75 6a                	jne    80106245 <create+0x197>
    dp->nlink++;  // for ".."
801061db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061de:	0f b7 40 56          	movzwl 0x56(%eax),%eax
801061e2:	83 c0 01             	add    $0x1,%eax
801061e5:	89 c2                	mov    %eax,%edx
801061e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061ea:	66 89 50 56          	mov    %dx,0x56(%eax)
    iupdate(dp);
801061ee:	83 ec 0c             	sub    $0xc,%esp
801061f1:	ff 75 f4             	pushl  -0xc(%ebp)
801061f4:	e8 c7 b6 ff ff       	call   801018c0 <iupdate>
801061f9:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801061fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061ff:	8b 40 04             	mov    0x4(%eax),%eax
80106202:	83 ec 04             	sub    $0x4,%esp
80106205:	50                   	push   %eax
80106206:	68 96 8c 10 80       	push   $0x80108c96
8010620b:	ff 75 f0             	pushl  -0x10(%ebp)
8010620e:	e8 5e c1 ff ff       	call   80102371 <dirlink>
80106213:	83 c4 10             	add    $0x10,%esp
80106216:	85 c0                	test   %eax,%eax
80106218:	78 1e                	js     80106238 <create+0x18a>
8010621a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010621d:	8b 40 04             	mov    0x4(%eax),%eax
80106220:	83 ec 04             	sub    $0x4,%esp
80106223:	50                   	push   %eax
80106224:	68 98 8c 10 80       	push   $0x80108c98
80106229:	ff 75 f0             	pushl  -0x10(%ebp)
8010622c:	e8 40 c1 ff ff       	call   80102371 <dirlink>
80106231:	83 c4 10             	add    $0x10,%esp
80106234:	85 c0                	test   %eax,%eax
80106236:	79 0d                	jns    80106245 <create+0x197>
      panic("create dots");
80106238:	83 ec 0c             	sub    $0xc,%esp
8010623b:	68 cb 8c 10 80       	push   $0x80108ccb
80106240:	e8 8c a3 ff ff       	call   801005d1 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80106245:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106248:	8b 40 04             	mov    0x4(%eax),%eax
8010624b:	83 ec 04             	sub    $0x4,%esp
8010624e:	50                   	push   %eax
8010624f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106252:	50                   	push   %eax
80106253:	ff 75 f4             	pushl  -0xc(%ebp)
80106256:	e8 16 c1 ff ff       	call   80102371 <dirlink>
8010625b:	83 c4 10             	add    $0x10,%esp
8010625e:	85 c0                	test   %eax,%eax
80106260:	79 0d                	jns    8010626f <create+0x1c1>
    panic("create: dirlink");
80106262:	83 ec 0c             	sub    $0xc,%esp
80106265:	68 d7 8c 10 80       	push   $0x80108cd7
8010626a:	e8 62 a3 ff ff       	call   801005d1 <panic>

  iunlockput(dp);
8010626f:	83 ec 0c             	sub    $0xc,%esp
80106272:	ff 75 f4             	pushl  -0xc(%ebp)
80106275:	e8 6c ba ff ff       	call   80101ce6 <iunlockput>
8010627a:	83 c4 10             	add    $0x10,%esp

  return ip;
8010627d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80106280:	c9                   	leave  
80106281:	c3                   	ret    

80106282 <sys_open>:

int
sys_open(void)
{
80106282:	f3 0f 1e fb          	endbr32 
80106286:	55                   	push   %ebp
80106287:	89 e5                	mov    %esp,%ebp
80106289:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010628c:	83 ec 08             	sub    $0x8,%esp
8010628f:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106292:	50                   	push   %eax
80106293:	6a 00                	push   $0x0
80106295:	e8 b4 f6 ff ff       	call   8010594e <argstr>
8010629a:	83 c4 10             	add    $0x10,%esp
8010629d:	85 c0                	test   %eax,%eax
8010629f:	78 15                	js     801062b6 <sys_open+0x34>
801062a1:	83 ec 08             	sub    $0x8,%esp
801062a4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801062a7:	50                   	push   %eax
801062a8:	6a 01                	push   $0x1
801062aa:	e8 02 f6 ff ff       	call   801058b1 <argint>
801062af:	83 c4 10             	add    $0x10,%esp
801062b2:	85 c0                	test   %eax,%eax
801062b4:	79 0a                	jns    801062c0 <sys_open+0x3e>
    return -1;
801062b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062bb:	e9 61 01 00 00       	jmp    80106421 <sys_open+0x19f>

  begin_op();
801062c0:	e8 b3 d3 ff ff       	call   80103678 <begin_op>

  if(omode & O_CREATE){
801062c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801062c8:	25 00 02 00 00       	and    $0x200,%eax
801062cd:	85 c0                	test   %eax,%eax
801062cf:	74 2a                	je     801062fb <sys_open+0x79>
    ip = create(path, T_FILE, 0, 0);
801062d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801062d4:	6a 00                	push   $0x0
801062d6:	6a 00                	push   $0x0
801062d8:	6a 02                	push   $0x2
801062da:	50                   	push   %eax
801062db:	e8 ce fd ff ff       	call   801060ae <create>
801062e0:	83 c4 10             	add    $0x10,%esp
801062e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
801062e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062ea:	75 75                	jne    80106361 <sys_open+0xdf>
      end_op();
801062ec:	e8 17 d4 ff ff       	call   80103708 <end_op>
      return -1;
801062f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062f6:	e9 26 01 00 00       	jmp    80106421 <sys_open+0x19f>
    }
  } else {
    if((ip = namei(path)) == 0){
801062fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801062fe:	83 ec 0c             	sub    $0xc,%esp
80106301:	50                   	push   %eax
80106302:	e8 0d c3 ff ff       	call   80102614 <namei>
80106307:	83 c4 10             	add    $0x10,%esp
8010630a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010630d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106311:	75 0f                	jne    80106322 <sys_open+0xa0>
      end_op();
80106313:	e8 f0 d3 ff ff       	call   80103708 <end_op>
      return -1;
80106318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010631d:	e9 ff 00 00 00       	jmp    80106421 <sys_open+0x19f>
    }
    ilock(ip);
80106322:	83 ec 0c             	sub    $0xc,%esp
80106325:	ff 75 f4             	pushl  -0xc(%ebp)
80106328:	e8 7c b7 ff ff       	call   80101aa9 <ilock>
8010632d:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80106330:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106333:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106337:	66 83 f8 01          	cmp    $0x1,%ax
8010633b:	75 24                	jne    80106361 <sys_open+0xdf>
8010633d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106340:	85 c0                	test   %eax,%eax
80106342:	74 1d                	je     80106361 <sys_open+0xdf>
      iunlockput(ip);
80106344:	83 ec 0c             	sub    $0xc,%esp
80106347:	ff 75 f4             	pushl  -0xc(%ebp)
8010634a:	e8 97 b9 ff ff       	call   80101ce6 <iunlockput>
8010634f:	83 c4 10             	add    $0x10,%esp
      end_op();
80106352:	e8 b1 d3 ff ff       	call   80103708 <end_op>
      return -1;
80106357:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010635c:	e9 c0 00 00 00       	jmp    80106421 <sys_open+0x19f>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106361:	e8 fd ac ff ff       	call   80101063 <filealloc>
80106366:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106369:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010636d:	74 17                	je     80106386 <sys_open+0x104>
8010636f:	83 ec 0c             	sub    $0xc,%esp
80106372:	ff 75 f0             	pushl  -0x10(%ebp)
80106375:	e8 09 f7 ff ff       	call   80105a83 <fdalloc>
8010637a:	83 c4 10             	add    $0x10,%esp
8010637d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80106380:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106384:	79 2e                	jns    801063b4 <sys_open+0x132>
    if(f)
80106386:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010638a:	74 0e                	je     8010639a <sys_open+0x118>
      fileclose(f);
8010638c:	83 ec 0c             	sub    $0xc,%esp
8010638f:	ff 75 f0             	pushl  -0x10(%ebp)
80106392:	e8 92 ad ff ff       	call   80101129 <fileclose>
80106397:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010639a:	83 ec 0c             	sub    $0xc,%esp
8010639d:	ff 75 f4             	pushl  -0xc(%ebp)
801063a0:	e8 41 b9 ff ff       	call   80101ce6 <iunlockput>
801063a5:	83 c4 10             	add    $0x10,%esp
    end_op();
801063a8:	e8 5b d3 ff ff       	call   80103708 <end_op>
    return -1;
801063ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063b2:	eb 6d                	jmp    80106421 <sys_open+0x19f>
  }
  iunlock(ip);
801063b4:	83 ec 0c             	sub    $0xc,%esp
801063b7:	ff 75 f4             	pushl  -0xc(%ebp)
801063ba:	e8 01 b8 ff ff       	call   80101bc0 <iunlock>
801063bf:	83 c4 10             	add    $0x10,%esp
  end_op();
801063c2:	e8 41 d3 ff ff       	call   80103708 <end_op>

  f->type = FD_INODE;
801063c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063ca:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
801063d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801063d6:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
801063d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063dc:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
801063e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063e6:	83 e0 01             	and    $0x1,%eax
801063e9:	85 c0                	test   %eax,%eax
801063eb:	0f 94 c0             	sete   %al
801063ee:	89 c2                	mov    %eax,%edx
801063f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063f3:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801063f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063f9:	83 e0 01             	and    $0x1,%eax
801063fc:	85 c0                	test   %eax,%eax
801063fe:	75 0a                	jne    8010640a <sys_open+0x188>
80106400:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106403:	83 e0 02             	and    $0x2,%eax
80106406:	85 c0                	test   %eax,%eax
80106408:	74 07                	je     80106411 <sys_open+0x18f>
8010640a:	b8 01 00 00 00       	mov    $0x1,%eax
8010640f:	eb 05                	jmp    80106416 <sys_open+0x194>
80106411:	b8 00 00 00 00       	mov    $0x0,%eax
80106416:	89 c2                	mov    %eax,%edx
80106418:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010641b:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
8010641e:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80106421:	c9                   	leave  
80106422:	c3                   	ret    

80106423 <sys_mkdir>:

int
sys_mkdir(void)
{
80106423:	f3 0f 1e fb          	endbr32 
80106427:	55                   	push   %ebp
80106428:	89 e5                	mov    %esp,%ebp
8010642a:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
8010642d:	e8 46 d2 ff ff       	call   80103678 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106432:	83 ec 08             	sub    $0x8,%esp
80106435:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106438:	50                   	push   %eax
80106439:	6a 00                	push   $0x0
8010643b:	e8 0e f5 ff ff       	call   8010594e <argstr>
80106440:	83 c4 10             	add    $0x10,%esp
80106443:	85 c0                	test   %eax,%eax
80106445:	78 1b                	js     80106462 <sys_mkdir+0x3f>
80106447:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010644a:	6a 00                	push   $0x0
8010644c:	6a 00                	push   $0x0
8010644e:	6a 01                	push   $0x1
80106450:	50                   	push   %eax
80106451:	e8 58 fc ff ff       	call   801060ae <create>
80106456:	83 c4 10             	add    $0x10,%esp
80106459:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010645c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106460:	75 0c                	jne    8010646e <sys_mkdir+0x4b>
    end_op();
80106462:	e8 a1 d2 ff ff       	call   80103708 <end_op>
    return -1;
80106467:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010646c:	eb 18                	jmp    80106486 <sys_mkdir+0x63>
  }
  iunlockput(ip);
8010646e:	83 ec 0c             	sub    $0xc,%esp
80106471:	ff 75 f4             	pushl  -0xc(%ebp)
80106474:	e8 6d b8 ff ff       	call   80101ce6 <iunlockput>
80106479:	83 c4 10             	add    $0x10,%esp
  end_op();
8010647c:	e8 87 d2 ff ff       	call   80103708 <end_op>
  return 0;
80106481:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106486:	c9                   	leave  
80106487:	c3                   	ret    

80106488 <sys_mknod>:

int
sys_mknod(void)
{
80106488:	f3 0f 1e fb          	endbr32 
8010648c:	55                   	push   %ebp
8010648d:	89 e5                	mov    %esp,%ebp
8010648f:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106492:	e8 e1 d1 ff ff       	call   80103678 <begin_op>
  if((argstr(0, &path)) < 0 ||
80106497:	83 ec 08             	sub    $0x8,%esp
8010649a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010649d:	50                   	push   %eax
8010649e:	6a 00                	push   $0x0
801064a0:	e8 a9 f4 ff ff       	call   8010594e <argstr>
801064a5:	83 c4 10             	add    $0x10,%esp
801064a8:	85 c0                	test   %eax,%eax
801064aa:	78 4f                	js     801064fb <sys_mknod+0x73>
     argint(1, &major) < 0 ||
801064ac:	83 ec 08             	sub    $0x8,%esp
801064af:	8d 45 ec             	lea    -0x14(%ebp),%eax
801064b2:	50                   	push   %eax
801064b3:	6a 01                	push   $0x1
801064b5:	e8 f7 f3 ff ff       	call   801058b1 <argint>
801064ba:	83 c4 10             	add    $0x10,%esp
  if((argstr(0, &path)) < 0 ||
801064bd:	85 c0                	test   %eax,%eax
801064bf:	78 3a                	js     801064fb <sys_mknod+0x73>
     argint(2, &minor) < 0 ||
801064c1:	83 ec 08             	sub    $0x8,%esp
801064c4:	8d 45 e8             	lea    -0x18(%ebp),%eax
801064c7:	50                   	push   %eax
801064c8:	6a 02                	push   $0x2
801064ca:	e8 e2 f3 ff ff       	call   801058b1 <argint>
801064cf:	83 c4 10             	add    $0x10,%esp
     argint(1, &major) < 0 ||
801064d2:	85 c0                	test   %eax,%eax
801064d4:	78 25                	js     801064fb <sys_mknod+0x73>
     (ip = create(path, T_DEV, major, minor)) == 0){
801064d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064d9:	0f bf c8             	movswl %ax,%ecx
801064dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801064df:	0f bf d0             	movswl %ax,%edx
801064e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064e5:	51                   	push   %ecx
801064e6:	52                   	push   %edx
801064e7:	6a 03                	push   $0x3
801064e9:	50                   	push   %eax
801064ea:	e8 bf fb ff ff       	call   801060ae <create>
801064ef:	83 c4 10             	add    $0x10,%esp
801064f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     argint(2, &minor) < 0 ||
801064f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064f9:	75 0c                	jne    80106507 <sys_mknod+0x7f>
    end_op();
801064fb:	e8 08 d2 ff ff       	call   80103708 <end_op>
    return -1;
80106500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106505:	eb 18                	jmp    8010651f <sys_mknod+0x97>
  }
  iunlockput(ip);
80106507:	83 ec 0c             	sub    $0xc,%esp
8010650a:	ff 75 f4             	pushl  -0xc(%ebp)
8010650d:	e8 d4 b7 ff ff       	call   80101ce6 <iunlockput>
80106512:	83 c4 10             	add    $0x10,%esp
  end_op();
80106515:	e8 ee d1 ff ff       	call   80103708 <end_op>
  return 0;
8010651a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010651f:	c9                   	leave  
80106520:	c3                   	ret    

80106521 <sys_chdir>:

int
sys_chdir(void)
{
80106521:	f3 0f 1e fb          	endbr32 
80106525:	55                   	push   %ebp
80106526:	89 e5                	mov    %esp,%ebp
80106528:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
8010652b:	e8 07 df ff ff       	call   80104437 <myproc>
80106530:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  begin_op();
80106533:	e8 40 d1 ff ff       	call   80103678 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106538:	83 ec 08             	sub    $0x8,%esp
8010653b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010653e:	50                   	push   %eax
8010653f:	6a 00                	push   $0x0
80106541:	e8 08 f4 ff ff       	call   8010594e <argstr>
80106546:	83 c4 10             	add    $0x10,%esp
80106549:	85 c0                	test   %eax,%eax
8010654b:	78 18                	js     80106565 <sys_chdir+0x44>
8010654d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106550:	83 ec 0c             	sub    $0xc,%esp
80106553:	50                   	push   %eax
80106554:	e8 bb c0 ff ff       	call   80102614 <namei>
80106559:	83 c4 10             	add    $0x10,%esp
8010655c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010655f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106563:	75 0c                	jne    80106571 <sys_chdir+0x50>
    end_op();
80106565:	e8 9e d1 ff ff       	call   80103708 <end_op>
    return -1;
8010656a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010656f:	eb 68                	jmp    801065d9 <sys_chdir+0xb8>
  }
  ilock(ip);
80106571:	83 ec 0c             	sub    $0xc,%esp
80106574:	ff 75 f0             	pushl  -0x10(%ebp)
80106577:	e8 2d b5 ff ff       	call   80101aa9 <ilock>
8010657c:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
8010657f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106582:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106586:	66 83 f8 01          	cmp    $0x1,%ax
8010658a:	74 1a                	je     801065a6 <sys_chdir+0x85>
    iunlockput(ip);
8010658c:	83 ec 0c             	sub    $0xc,%esp
8010658f:	ff 75 f0             	pushl  -0x10(%ebp)
80106592:	e8 4f b7 ff ff       	call   80101ce6 <iunlockput>
80106597:	83 c4 10             	add    $0x10,%esp
    end_op();
8010659a:	e8 69 d1 ff ff       	call   80103708 <end_op>
    return -1;
8010659f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065a4:	eb 33                	jmp    801065d9 <sys_chdir+0xb8>
  }
  iunlock(ip);
801065a6:	83 ec 0c             	sub    $0xc,%esp
801065a9:	ff 75 f0             	pushl  -0x10(%ebp)
801065ac:	e8 0f b6 ff ff       	call   80101bc0 <iunlock>
801065b1:	83 c4 10             	add    $0x10,%esp
  iput(curproc->cwd);
801065b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065b7:	8b 40 68             	mov    0x68(%eax),%eax
801065ba:	83 ec 0c             	sub    $0xc,%esp
801065bd:	50                   	push   %eax
801065be:	e8 4f b6 ff ff       	call   80101c12 <iput>
801065c3:	83 c4 10             	add    $0x10,%esp
  end_op();
801065c6:	e8 3d d1 ff ff       	call   80103708 <end_op>
  curproc->cwd = ip;
801065cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065ce:	8b 55 f0             	mov    -0x10(%ebp),%edx
801065d1:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
801065d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801065d9:	c9                   	leave  
801065da:	c3                   	ret    

801065db <sys_exec>:

int
sys_exec(void)
{
801065db:	f3 0f 1e fb          	endbr32 
801065df:	55                   	push   %ebp
801065e0:	89 e5                	mov    %esp,%ebp
801065e2:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801065e8:	83 ec 08             	sub    $0x8,%esp
801065eb:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065ee:	50                   	push   %eax
801065ef:	6a 00                	push   $0x0
801065f1:	e8 58 f3 ff ff       	call   8010594e <argstr>
801065f6:	83 c4 10             	add    $0x10,%esp
801065f9:	85 c0                	test   %eax,%eax
801065fb:	78 18                	js     80106615 <sys_exec+0x3a>
801065fd:	83 ec 08             	sub    $0x8,%esp
80106600:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106606:	50                   	push   %eax
80106607:	6a 01                	push   $0x1
80106609:	e8 a3 f2 ff ff       	call   801058b1 <argint>
8010660e:	83 c4 10             	add    $0x10,%esp
80106611:	85 c0                	test   %eax,%eax
80106613:	79 0a                	jns    8010661f <sys_exec+0x44>
    return -1;
80106615:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010661a:	e9 c6 00 00 00       	jmp    801066e5 <sys_exec+0x10a>
  }
  memset(argv, 0, sizeof(argv));
8010661f:	83 ec 04             	sub    $0x4,%esp
80106622:	68 80 00 00 00       	push   $0x80
80106627:	6a 00                	push   $0x0
80106629:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010662f:	50                   	push   %eax
80106630:	e8 28 ef ff ff       	call   8010555d <memset>
80106635:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80106638:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
8010663f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106642:	83 f8 1f             	cmp    $0x1f,%eax
80106645:	76 0a                	jbe    80106651 <sys_exec+0x76>
      return -1;
80106647:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010664c:	e9 94 00 00 00       	jmp    801066e5 <sys_exec+0x10a>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106651:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106654:	c1 e0 02             	shl    $0x2,%eax
80106657:	89 c2                	mov    %eax,%edx
80106659:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
8010665f:	01 c2                	add    %eax,%edx
80106661:	83 ec 08             	sub    $0x8,%esp
80106664:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010666a:	50                   	push   %eax
8010666b:	52                   	push   %edx
8010666c:	e8 95 f1 ff ff       	call   80105806 <fetchint>
80106671:	83 c4 10             	add    $0x10,%esp
80106674:	85 c0                	test   %eax,%eax
80106676:	79 07                	jns    8010667f <sys_exec+0xa4>
      return -1;
80106678:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010667d:	eb 66                	jmp    801066e5 <sys_exec+0x10a>
    if(uarg == 0){
8010667f:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106685:	85 c0                	test   %eax,%eax
80106687:	75 27                	jne    801066b0 <sys_exec+0xd5>
      argv[i] = 0;
80106689:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010668c:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106693:	00 00 00 00 
      break;
80106697:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106698:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010669b:	83 ec 08             	sub    $0x8,%esp
8010669e:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
801066a4:	52                   	push   %edx
801066a5:	50                   	push   %eax
801066a6:	e8 4e a5 ff ff       	call   80100bf9 <exec>
801066ab:	83 c4 10             	add    $0x10,%esp
801066ae:	eb 35                	jmp    801066e5 <sys_exec+0x10a>
    if(fetchstr(uarg, &argv[i]) < 0)
801066b0:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801066b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801066b9:	c1 e2 02             	shl    $0x2,%edx
801066bc:	01 c2                	add    %eax,%edx
801066be:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801066c4:	83 ec 08             	sub    $0x8,%esp
801066c7:	52                   	push   %edx
801066c8:	50                   	push   %eax
801066c9:	e8 7b f1 ff ff       	call   80105849 <fetchstr>
801066ce:	83 c4 10             	add    $0x10,%esp
801066d1:	85 c0                	test   %eax,%eax
801066d3:	79 07                	jns    801066dc <sys_exec+0x101>
      return -1;
801066d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066da:	eb 09                	jmp    801066e5 <sys_exec+0x10a>
  for(i=0;; i++){
801066dc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(i >= NELEM(argv))
801066e0:	e9 5a ff ff ff       	jmp    8010663f <sys_exec+0x64>
}
801066e5:	c9                   	leave  
801066e6:	c3                   	ret    

801066e7 <sys_pipe>:

int
sys_pipe(void)
{
801066e7:	f3 0f 1e fb          	endbr32 
801066eb:	55                   	push   %ebp
801066ec:	89 e5                	mov    %esp,%ebp
801066ee:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801066f1:	83 ec 04             	sub    $0x4,%esp
801066f4:	6a 08                	push   $0x8
801066f6:	8d 45 ec             	lea    -0x14(%ebp),%eax
801066f9:	50                   	push   %eax
801066fa:	6a 00                	push   $0x0
801066fc:	e8 e1 f1 ff ff       	call   801058e2 <argptr>
80106701:	83 c4 10             	add    $0x10,%esp
80106704:	85 c0                	test   %eax,%eax
80106706:	79 0a                	jns    80106712 <sys_pipe+0x2b>
    return -1;
80106708:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010670d:	e9 ae 00 00 00       	jmp    801067c0 <sys_pipe+0xd9>
  if(pipealloc(&rf, &wf) < 0)
80106712:	83 ec 08             	sub    $0x8,%esp
80106715:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106718:	50                   	push   %eax
80106719:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010671c:	50                   	push   %eax
8010671d:	e8 36 d8 ff ff       	call   80103f58 <pipealloc>
80106722:	83 c4 10             	add    $0x10,%esp
80106725:	85 c0                	test   %eax,%eax
80106727:	79 0a                	jns    80106733 <sys_pipe+0x4c>
    return -1;
80106729:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010672e:	e9 8d 00 00 00       	jmp    801067c0 <sys_pipe+0xd9>
  fd0 = -1;
80106733:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010673a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010673d:	83 ec 0c             	sub    $0xc,%esp
80106740:	50                   	push   %eax
80106741:	e8 3d f3 ff ff       	call   80105a83 <fdalloc>
80106746:	83 c4 10             	add    $0x10,%esp
80106749:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010674c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106750:	78 18                	js     8010676a <sys_pipe+0x83>
80106752:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106755:	83 ec 0c             	sub    $0xc,%esp
80106758:	50                   	push   %eax
80106759:	e8 25 f3 ff ff       	call   80105a83 <fdalloc>
8010675e:	83 c4 10             	add    $0x10,%esp
80106761:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106764:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106768:	79 3e                	jns    801067a8 <sys_pipe+0xc1>
    if(fd0 >= 0)
8010676a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010676e:	78 13                	js     80106783 <sys_pipe+0x9c>
      myproc()->ofile[fd0] = 0;
80106770:	e8 c2 dc ff ff       	call   80104437 <myproc>
80106775:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106778:	83 c2 08             	add    $0x8,%edx
8010677b:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106782:	00 
    fileclose(rf);
80106783:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106786:	83 ec 0c             	sub    $0xc,%esp
80106789:	50                   	push   %eax
8010678a:	e8 9a a9 ff ff       	call   80101129 <fileclose>
8010678f:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80106792:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106795:	83 ec 0c             	sub    $0xc,%esp
80106798:	50                   	push   %eax
80106799:	e8 8b a9 ff ff       	call   80101129 <fileclose>
8010679e:	83 c4 10             	add    $0x10,%esp
    return -1;
801067a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067a6:	eb 18                	jmp    801067c0 <sys_pipe+0xd9>
  }
  fd[0] = fd0;
801067a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801067ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
801067ae:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
801067b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801067b3:	8d 50 04             	lea    0x4(%eax),%edx
801067b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067b9:	89 02                	mov    %eax,(%edx)
  return 0;
801067bb:	b8 00 00 00 00       	mov    $0x0,%eax
}
801067c0:	c9                   	leave  
801067c1:	c3                   	ret    

801067c2 <sys_fork>:
#include "proc.h"
#include "pstat.h"

int
sys_fork(void)
{
801067c2:	f3 0f 1e fb          	endbr32 
801067c6:	55                   	push   %ebp
801067c7:	89 e5                	mov    %esp,%ebp
801067c9:	83 ec 08             	sub    $0x8,%esp
  return fork();
801067cc:	e8 a0 df ff ff       	call   80104771 <fork>
}
801067d1:	c9                   	leave  
801067d2:	c3                   	ret    

801067d3 <sys_exit>:

int
sys_exit(void)
{
801067d3:	f3 0f 1e fb          	endbr32 
801067d7:	55                   	push   %ebp
801067d8:	89 e5                	mov    %esp,%ebp
801067da:	83 ec 08             	sub    $0x8,%esp
  exit();
801067dd:	e8 c8 e1 ff ff       	call   801049aa <exit>
  return 0;  // not reached
801067e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801067e7:	c9                   	leave  
801067e8:	c3                   	ret    

801067e9 <sys_wait>:

int
sys_wait(void)
{
801067e9:	f3 0f 1e fb          	endbr32 
801067ed:	55                   	push   %ebp
801067ee:	89 e5                	mov    %esp,%ebp
801067f0:	83 ec 08             	sub    $0x8,%esp
  return wait();
801067f3:	e8 d9 e2 ff ff       	call   80104ad1 <wait>
}
801067f8:	c9                   	leave  
801067f9:	c3                   	ret    

801067fa <sys_kill>:

int
sys_kill(void)
{
801067fa:	f3 0f 1e fb          	endbr32 
801067fe:	55                   	push   %ebp
801067ff:	89 e5                	mov    %esp,%ebp
80106801:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106804:	83 ec 08             	sub    $0x8,%esp
80106807:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010680a:	50                   	push   %eax
8010680b:	6a 00                	push   $0x0
8010680d:	e8 9f f0 ff ff       	call   801058b1 <argint>
80106812:	83 c4 10             	add    $0x10,%esp
80106815:	85 c0                	test   %eax,%eax
80106817:	79 07                	jns    80106820 <sys_kill+0x26>
    return -1;
80106819:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010681e:	eb 0f                	jmp    8010682f <sys_kill+0x35>
  return kill(pid);
80106820:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106823:	83 ec 0c             	sub    $0xc,%esp
80106826:	50                   	push   %eax
80106827:	e8 4d e7 ff ff       	call   80104f79 <kill>
8010682c:	83 c4 10             	add    $0x10,%esp
}
8010682f:	c9                   	leave  
80106830:	c3                   	ret    

80106831 <sys_getpid>:

int
sys_getpid(void)
{
80106831:	f3 0f 1e fb          	endbr32 
80106835:	55                   	push   %ebp
80106836:	89 e5                	mov    %esp,%ebp
80106838:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
8010683b:	e8 f7 db ff ff       	call   80104437 <myproc>
80106840:	8b 40 10             	mov    0x10(%eax),%eax
}
80106843:	c9                   	leave  
80106844:	c3                   	ret    

80106845 <sys_sbrk>:

int
sys_sbrk(void)
{
80106845:	f3 0f 1e fb          	endbr32 
80106849:	55                   	push   %ebp
8010684a:	89 e5                	mov    %esp,%ebp
8010684c:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010684f:	83 ec 08             	sub    $0x8,%esp
80106852:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106855:	50                   	push   %eax
80106856:	6a 00                	push   $0x0
80106858:	e8 54 f0 ff ff       	call   801058b1 <argint>
8010685d:	83 c4 10             	add    $0x10,%esp
80106860:	85 c0                	test   %eax,%eax
80106862:	79 07                	jns    8010686b <sys_sbrk+0x26>
    return -1;
80106864:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106869:	eb 27                	jmp    80106892 <sys_sbrk+0x4d>
  addr = myproc()->sz;
8010686b:	e8 c7 db ff ff       	call   80104437 <myproc>
80106870:	8b 00                	mov    (%eax),%eax
80106872:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106875:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106878:	83 ec 0c             	sub    $0xc,%esp
8010687b:	50                   	push   %eax
8010687c:	e8 51 de ff ff       	call   801046d2 <growproc>
80106881:	83 c4 10             	add    $0x10,%esp
80106884:	85 c0                	test   %eax,%eax
80106886:	79 07                	jns    8010688f <sys_sbrk+0x4a>
    return -1;
80106888:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010688d:	eb 03                	jmp    80106892 <sys_sbrk+0x4d>
  return addr;
8010688f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106892:	c9                   	leave  
80106893:	c3                   	ret    

80106894 <sys_sleep>:

int
sys_sleep(void)
{
80106894:	f3 0f 1e fb          	endbr32 
80106898:	55                   	push   %ebp
80106899:	89 e5                	mov    %esp,%ebp
8010689b:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010689e:	83 ec 08             	sub    $0x8,%esp
801068a1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801068a4:	50                   	push   %eax
801068a5:	6a 00                	push   $0x0
801068a7:	e8 05 f0 ff ff       	call   801058b1 <argint>
801068ac:	83 c4 10             	add    $0x10,%esp
801068af:	85 c0                	test   %eax,%eax
801068b1:	79 07                	jns    801068ba <sys_sleep+0x26>
    return -1;
801068b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068b8:	eb 76                	jmp    80106930 <sys_sleep+0x9c>
  acquire(&tickslock);
801068ba:	83 ec 0c             	sub    $0xc,%esp
801068bd:	68 e0 5f 11 80       	push   $0x80115fe0
801068c2:	e8 f7 e9 ff ff       	call   801052be <acquire>
801068c7:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801068ca:	a1 20 68 11 80       	mov    0x80116820,%eax
801068cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
801068d2:	eb 38                	jmp    8010690c <sys_sleep+0x78>
    if(myproc()->killed){
801068d4:	e8 5e db ff ff       	call   80104437 <myproc>
801068d9:	8b 40 24             	mov    0x24(%eax),%eax
801068dc:	85 c0                	test   %eax,%eax
801068de:	74 17                	je     801068f7 <sys_sleep+0x63>
      release(&tickslock);
801068e0:	83 ec 0c             	sub    $0xc,%esp
801068e3:	68 e0 5f 11 80       	push   $0x80115fe0
801068e8:	e8 43 ea ff ff       	call   80105330 <release>
801068ed:	83 c4 10             	add    $0x10,%esp
      return -1;
801068f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068f5:	eb 39                	jmp    80106930 <sys_sleep+0x9c>
    }
    sleep(&ticks, &tickslock);
801068f7:	83 ec 08             	sub    $0x8,%esp
801068fa:	68 e0 5f 11 80       	push   $0x80115fe0
801068ff:	68 20 68 11 80       	push   $0x80116820
80106904:	e8 43 e5 ff ff       	call   80104e4c <sleep>
80106909:	83 c4 10             	add    $0x10,%esp
  while(ticks - ticks0 < n){
8010690c:	a1 20 68 11 80       	mov    0x80116820,%eax
80106911:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106914:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106917:	39 d0                	cmp    %edx,%eax
80106919:	72 b9                	jb     801068d4 <sys_sleep+0x40>
  }
  release(&tickslock);
8010691b:	83 ec 0c             	sub    $0xc,%esp
8010691e:	68 e0 5f 11 80       	push   $0x80115fe0
80106923:	e8 08 ea ff ff       	call   80105330 <release>
80106928:	83 c4 10             	add    $0x10,%esp
  return 0;
8010692b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106930:	c9                   	leave  
80106931:	c3                   	ret    

80106932 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106932:	f3 0f 1e fb          	endbr32 
80106936:	55                   	push   %ebp
80106937:	89 e5                	mov    %esp,%ebp
80106939:	83 ec 18             	sub    $0x18,%esp
  uint xticks;

  acquire(&tickslock);
8010693c:	83 ec 0c             	sub    $0xc,%esp
8010693f:	68 e0 5f 11 80       	push   $0x80115fe0
80106944:	e8 75 e9 ff ff       	call   801052be <acquire>
80106949:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
8010694c:	a1 20 68 11 80       	mov    0x80116820,%eax
80106951:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106954:	83 ec 0c             	sub    $0xc,%esp
80106957:	68 e0 5f 11 80       	push   $0x80115fe0
8010695c:	e8 cf e9 ff ff       	call   80105330 <release>
80106961:	83 c4 10             	add    $0x10,%esp
  return xticks;
80106964:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106967:	c9                   	leave  
80106968:	c3                   	ret    

80106969 <sys_settickets>:

int
sys_settickets(void)
{
80106969:	f3 0f 1e fb          	endbr32 
8010696d:	55                   	push   %ebp
8010696e:	89 e5                	mov    %esp,%ebp
80106970:	83 ec 18             	sub    $0x18,%esp
  int n;
  if (argint(0, &n) < 0 || n < 1){
80106973:	83 ec 08             	sub    $0x8,%esp
80106976:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106979:	50                   	push   %eax
8010697a:	6a 00                	push   $0x0
8010697c:	e8 30 ef ff ff       	call   801058b1 <argint>
80106981:	83 c4 10             	add    $0x10,%esp
80106984:	85 c0                	test   %eax,%eax
80106986:	78 07                	js     8010698f <sys_settickets+0x26>
80106988:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010698b:	85 c0                	test   %eax,%eax
8010698d:	7f 07                	jg     80106996 <sys_settickets+0x2d>
    return -1;
8010698f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106994:	eb 10                	jmp    801069a6 <sys_settickets+0x3d>
  }
  myproc()->tickets = n;
80106996:	e8 9c da ff ff       	call   80104437 <myproc>
8010699b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010699e:	89 50 7c             	mov    %edx,0x7c(%eax)
  return 0;
801069a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
801069a6:	c9                   	leave  
801069a7:	c3                   	ret    

801069a8 <sys_getpinfo>:

int
sys_getpinfo(void)
{
801069a8:	f3 0f 1e fb          	endbr32 
801069ac:	55                   	push   %ebp
801069ad:	89 e5                	mov    %esp,%ebp
801069af:	83 ec 18             	sub    $0x18,%esp
  struct pstat *st;

  if (argptr(0, (void*)&st, sizeof(*st)) < 0){
801069b2:	83 ec 04             	sub    $0x4,%esp
801069b5:	68 00 04 00 00       	push   $0x400
801069ba:	8d 45 f4             	lea    -0xc(%ebp),%eax
801069bd:	50                   	push   %eax
801069be:	6a 00                	push   $0x0
801069c0:	e8 1d ef ff ff       	call   801058e2 <argptr>
801069c5:	83 c4 10             	add    $0x10,%esp
801069c8:	85 c0                	test   %eax,%eax
801069ca:	79 07                	jns    801069d3 <sys_getpinfo+0x2b>
    return -1; 
801069cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069d1:	eb 22                	jmp    801069f5 <sys_getpinfo+0x4d>
  }
  if (st == 0) {
801069d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069d6:	85 c0                	test   %eax,%eax
801069d8:	75 07                	jne    801069e1 <sys_getpinfo+0x39>
	  return -1;
801069da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069df:	eb 14                	jmp    801069f5 <sys_getpinfo+0x4d>
  }

  fill(st);
801069e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069e4:	83 ec 0c             	sub    $0xc,%esp
801069e7:	50                   	push   %eax
801069e8:	e8 1a df ff ff       	call   80104907 <fill>
801069ed:	83 c4 10             	add    $0x10,%esp
  return 0;
801069f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801069f5:	c9                   	leave  
801069f6:	c3                   	ret    

801069f7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801069f7:	1e                   	push   %ds
  pushl %es
801069f8:	06                   	push   %es
  pushl %fs
801069f9:	0f a0                	push   %fs
  pushl %gs
801069fb:	0f a8                	push   %gs
  pushal
801069fd:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801069fe:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106a02:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106a04:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106a06:	54                   	push   %esp
  call trap
80106a07:	e8 df 01 00 00       	call   80106beb <trap>
  addl $4, %esp
80106a0c:	83 c4 04             	add    $0x4,%esp

80106a0f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106a0f:	61                   	popa   
  popl %gs
80106a10:	0f a9                	pop    %gs
  popl %fs
80106a12:	0f a1                	pop    %fs
  popl %es
80106a14:	07                   	pop    %es
  popl %ds
80106a15:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106a16:	83 c4 08             	add    $0x8,%esp
  iret
80106a19:	cf                   	iret   

80106a1a <lidt>:
{
80106a1a:	55                   	push   %ebp
80106a1b:	89 e5                	mov    %esp,%ebp
80106a1d:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80106a20:	8b 45 0c             	mov    0xc(%ebp),%eax
80106a23:	83 e8 01             	sub    $0x1,%eax
80106a26:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106a2a:	8b 45 08             	mov    0x8(%ebp),%eax
80106a2d:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106a31:	8b 45 08             	mov    0x8(%ebp),%eax
80106a34:	c1 e8 10             	shr    $0x10,%eax
80106a37:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106a3b:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106a3e:	0f 01 18             	lidtl  (%eax)
}
80106a41:	90                   	nop
80106a42:	c9                   	leave  
80106a43:	c3                   	ret    

80106a44 <rcr2>:

static inline uint
rcr2(void)
{
80106a44:	55                   	push   %ebp
80106a45:	89 e5                	mov    %esp,%ebp
80106a47:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106a4a:	0f 20 d0             	mov    %cr2,%eax
80106a4d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106a50:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106a53:	c9                   	leave  
80106a54:	c3                   	ret    

80106a55 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106a55:	f3 0f 1e fb          	endbr32 
80106a59:	55                   	push   %ebp
80106a5a:	89 e5                	mov    %esp,%ebp
80106a5c:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
80106a5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106a66:	e9 c3 00 00 00       	jmp    80106b2e <tvinit+0xd9>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106a6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a6e:	8b 04 85 80 b0 10 80 	mov    -0x7fef4f80(,%eax,4),%eax
80106a75:	89 c2                	mov    %eax,%edx
80106a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a7a:	66 89 14 c5 20 60 11 	mov    %dx,-0x7fee9fe0(,%eax,8)
80106a81:	80 
80106a82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a85:	66 c7 04 c5 22 60 11 	movw   $0x8,-0x7fee9fde(,%eax,8)
80106a8c:	80 08 00 
80106a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a92:	0f b6 14 c5 24 60 11 	movzbl -0x7fee9fdc(,%eax,8),%edx
80106a99:	80 
80106a9a:	83 e2 e0             	and    $0xffffffe0,%edx
80106a9d:	88 14 c5 24 60 11 80 	mov    %dl,-0x7fee9fdc(,%eax,8)
80106aa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106aa7:	0f b6 14 c5 24 60 11 	movzbl -0x7fee9fdc(,%eax,8),%edx
80106aae:	80 
80106aaf:	83 e2 1f             	and    $0x1f,%edx
80106ab2:	88 14 c5 24 60 11 80 	mov    %dl,-0x7fee9fdc(,%eax,8)
80106ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106abc:	0f b6 14 c5 25 60 11 	movzbl -0x7fee9fdb(,%eax,8),%edx
80106ac3:	80 
80106ac4:	83 e2 f0             	and    $0xfffffff0,%edx
80106ac7:	83 ca 0e             	or     $0xe,%edx
80106aca:	88 14 c5 25 60 11 80 	mov    %dl,-0x7fee9fdb(,%eax,8)
80106ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ad4:	0f b6 14 c5 25 60 11 	movzbl -0x7fee9fdb(,%eax,8),%edx
80106adb:	80 
80106adc:	83 e2 ef             	and    $0xffffffef,%edx
80106adf:	88 14 c5 25 60 11 80 	mov    %dl,-0x7fee9fdb(,%eax,8)
80106ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ae9:	0f b6 14 c5 25 60 11 	movzbl -0x7fee9fdb(,%eax,8),%edx
80106af0:	80 
80106af1:	83 e2 9f             	and    $0xffffff9f,%edx
80106af4:	88 14 c5 25 60 11 80 	mov    %dl,-0x7fee9fdb(,%eax,8)
80106afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106afe:	0f b6 14 c5 25 60 11 	movzbl -0x7fee9fdb(,%eax,8),%edx
80106b05:	80 
80106b06:	83 ca 80             	or     $0xffffff80,%edx
80106b09:	88 14 c5 25 60 11 80 	mov    %dl,-0x7fee9fdb(,%eax,8)
80106b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b13:	8b 04 85 80 b0 10 80 	mov    -0x7fef4f80(,%eax,4),%eax
80106b1a:	c1 e8 10             	shr    $0x10,%eax
80106b1d:	89 c2                	mov    %eax,%edx
80106b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b22:	66 89 14 c5 26 60 11 	mov    %dx,-0x7fee9fda(,%eax,8)
80106b29:	80 
  for(i = 0; i < 256; i++)
80106b2a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106b2e:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80106b35:	0f 8e 30 ff ff ff    	jle    80106a6b <tvinit+0x16>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106b3b:	a1 80 b1 10 80       	mov    0x8010b180,%eax
80106b40:	66 a3 20 62 11 80    	mov    %ax,0x80116220
80106b46:	66 c7 05 22 62 11 80 	movw   $0x8,0x80116222
80106b4d:	08 00 
80106b4f:	0f b6 05 24 62 11 80 	movzbl 0x80116224,%eax
80106b56:	83 e0 e0             	and    $0xffffffe0,%eax
80106b59:	a2 24 62 11 80       	mov    %al,0x80116224
80106b5e:	0f b6 05 24 62 11 80 	movzbl 0x80116224,%eax
80106b65:	83 e0 1f             	and    $0x1f,%eax
80106b68:	a2 24 62 11 80       	mov    %al,0x80116224
80106b6d:	0f b6 05 25 62 11 80 	movzbl 0x80116225,%eax
80106b74:	83 c8 0f             	or     $0xf,%eax
80106b77:	a2 25 62 11 80       	mov    %al,0x80116225
80106b7c:	0f b6 05 25 62 11 80 	movzbl 0x80116225,%eax
80106b83:	83 e0 ef             	and    $0xffffffef,%eax
80106b86:	a2 25 62 11 80       	mov    %al,0x80116225
80106b8b:	0f b6 05 25 62 11 80 	movzbl 0x80116225,%eax
80106b92:	83 c8 60             	or     $0x60,%eax
80106b95:	a2 25 62 11 80       	mov    %al,0x80116225
80106b9a:	0f b6 05 25 62 11 80 	movzbl 0x80116225,%eax
80106ba1:	83 c8 80             	or     $0xffffff80,%eax
80106ba4:	a2 25 62 11 80       	mov    %al,0x80116225
80106ba9:	a1 80 b1 10 80       	mov    0x8010b180,%eax
80106bae:	c1 e8 10             	shr    $0x10,%eax
80106bb1:	66 a3 26 62 11 80    	mov    %ax,0x80116226

  initlock(&tickslock, "time");
80106bb7:	83 ec 08             	sub    $0x8,%esp
80106bba:	68 e8 8c 10 80       	push   $0x80108ce8
80106bbf:	68 e0 5f 11 80       	push   $0x80115fe0
80106bc4:	e8 cf e6 ff ff       	call   80105298 <initlock>
80106bc9:	83 c4 10             	add    $0x10,%esp
}
80106bcc:	90                   	nop
80106bcd:	c9                   	leave  
80106bce:	c3                   	ret    

80106bcf <idtinit>:

void
idtinit(void)
{
80106bcf:	f3 0f 1e fb          	endbr32 
80106bd3:	55                   	push   %ebp
80106bd4:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80106bd6:	68 00 08 00 00       	push   $0x800
80106bdb:	68 20 60 11 80       	push   $0x80116020
80106be0:	e8 35 fe ff ff       	call   80106a1a <lidt>
80106be5:	83 c4 08             	add    $0x8,%esp
}
80106be8:	90                   	nop
80106be9:	c9                   	leave  
80106bea:	c3                   	ret    

80106beb <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106beb:	f3 0f 1e fb          	endbr32 
80106bef:	55                   	push   %ebp
80106bf0:	89 e5                	mov    %esp,%ebp
80106bf2:	57                   	push   %edi
80106bf3:	56                   	push   %esi
80106bf4:	53                   	push   %ebx
80106bf5:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106bf8:	8b 45 08             	mov    0x8(%ebp),%eax
80106bfb:	8b 40 30             	mov    0x30(%eax),%eax
80106bfe:	83 f8 40             	cmp    $0x40,%eax
80106c01:	75 3b                	jne    80106c3e <trap+0x53>
    if(myproc()->killed)
80106c03:	e8 2f d8 ff ff       	call   80104437 <myproc>
80106c08:	8b 40 24             	mov    0x24(%eax),%eax
80106c0b:	85 c0                	test   %eax,%eax
80106c0d:	74 05                	je     80106c14 <trap+0x29>
      exit();
80106c0f:	e8 96 dd ff ff       	call   801049aa <exit>
    myproc()->tf = tf;
80106c14:	e8 1e d8 ff ff       	call   80104437 <myproc>
80106c19:	8b 55 08             	mov    0x8(%ebp),%edx
80106c1c:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106c1f:	e8 65 ed ff ff       	call   80105989 <syscall>
    if(myproc()->killed)
80106c24:	e8 0e d8 ff ff       	call   80104437 <myproc>
80106c29:	8b 40 24             	mov    0x24(%eax),%eax
80106c2c:	85 c0                	test   %eax,%eax
80106c2e:	0f 84 07 02 00 00    	je     80106e3b <trap+0x250>
      exit();
80106c34:	e8 71 dd ff ff       	call   801049aa <exit>
    return;
80106c39:	e9 fd 01 00 00       	jmp    80106e3b <trap+0x250>
  }

  switch(tf->trapno){
80106c3e:	8b 45 08             	mov    0x8(%ebp),%eax
80106c41:	8b 40 30             	mov    0x30(%eax),%eax
80106c44:	83 e8 20             	sub    $0x20,%eax
80106c47:	83 f8 1f             	cmp    $0x1f,%eax
80106c4a:	0f 87 b6 00 00 00    	ja     80106d06 <trap+0x11b>
80106c50:	8b 04 85 90 8d 10 80 	mov    -0x7fef7270(,%eax,4),%eax
80106c57:	3e ff e0             	notrack jmp *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80106c5a:	e8 3d d7 ff ff       	call   8010439c <cpuid>
80106c5f:	85 c0                	test   %eax,%eax
80106c61:	75 3d                	jne    80106ca0 <trap+0xb5>
      acquire(&tickslock);
80106c63:	83 ec 0c             	sub    $0xc,%esp
80106c66:	68 e0 5f 11 80       	push   $0x80115fe0
80106c6b:	e8 4e e6 ff ff       	call   801052be <acquire>
80106c70:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106c73:	a1 20 68 11 80       	mov    0x80116820,%eax
80106c78:	83 c0 01             	add    $0x1,%eax
80106c7b:	a3 20 68 11 80       	mov    %eax,0x80116820
      wakeup(&ticks);
80106c80:	83 ec 0c             	sub    $0xc,%esp
80106c83:	68 20 68 11 80       	push   $0x80116820
80106c88:	e8 b1 e2 ff ff       	call   80104f3e <wakeup>
80106c8d:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106c90:	83 ec 0c             	sub    $0xc,%esp
80106c93:	68 e0 5f 11 80       	push   $0x80115fe0
80106c98:	e8 93 e6 ff ff       	call   80105330 <release>
80106c9d:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106ca0:	e8 87 c4 ff ff       	call   8010312c <lapiceoi>
    break;
80106ca5:	e9 11 01 00 00       	jmp    80106dbb <trap+0x1d0>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106caa:	e8 b2 bc ff ff       	call   80102961 <ideintr>
    lapiceoi();
80106caf:	e8 78 c4 ff ff       	call   8010312c <lapiceoi>
    break;
80106cb4:	e9 02 01 00 00       	jmp    80106dbb <trap+0x1d0>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106cb9:	e8 a4 c2 ff ff       	call   80102f62 <kbdintr>
    lapiceoi();
80106cbe:	e8 69 c4 ff ff       	call   8010312c <lapiceoi>
    break;
80106cc3:	e9 f3 00 00 00       	jmp    80106dbb <trap+0x1d0>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106cc8:	e8 50 03 00 00       	call   8010701d <uartintr>
    lapiceoi();
80106ccd:	e8 5a c4 ff ff       	call   8010312c <lapiceoi>
    break;
80106cd2:	e9 e4 00 00 00       	jmp    80106dbb <trap+0x1d0>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80106cda:	8b 70 38             	mov    0x38(%eax),%esi
            cpuid(), tf->cs, tf->eip);
80106cdd:	8b 45 08             	mov    0x8(%ebp),%eax
80106ce0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106ce4:	0f b7 d8             	movzwl %ax,%ebx
80106ce7:	e8 b0 d6 ff ff       	call   8010439c <cpuid>
80106cec:	56                   	push   %esi
80106ced:	53                   	push   %ebx
80106cee:	50                   	push   %eax
80106cef:	68 f0 8c 10 80       	push   $0x80108cf0
80106cf4:	e8 1f 97 ff ff       	call   80100418 <cprintf>
80106cf9:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106cfc:	e8 2b c4 ff ff       	call   8010312c <lapiceoi>
    break;
80106d01:	e9 b5 00 00 00       	jmp    80106dbb <trap+0x1d0>

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106d06:	e8 2c d7 ff ff       	call   80104437 <myproc>
80106d0b:	85 c0                	test   %eax,%eax
80106d0d:	74 11                	je     80106d20 <trap+0x135>
80106d0f:	8b 45 08             	mov    0x8(%ebp),%eax
80106d12:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106d16:	0f b7 c0             	movzwl %ax,%eax
80106d19:	83 e0 03             	and    $0x3,%eax
80106d1c:	85 c0                	test   %eax,%eax
80106d1e:	75 39                	jne    80106d59 <trap+0x16e>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106d20:	e8 1f fd ff ff       	call   80106a44 <rcr2>
80106d25:	89 c3                	mov    %eax,%ebx
80106d27:	8b 45 08             	mov    0x8(%ebp),%eax
80106d2a:	8b 70 38             	mov    0x38(%eax),%esi
80106d2d:	e8 6a d6 ff ff       	call   8010439c <cpuid>
80106d32:	8b 55 08             	mov    0x8(%ebp),%edx
80106d35:	8b 52 30             	mov    0x30(%edx),%edx
80106d38:	83 ec 0c             	sub    $0xc,%esp
80106d3b:	53                   	push   %ebx
80106d3c:	56                   	push   %esi
80106d3d:	50                   	push   %eax
80106d3e:	52                   	push   %edx
80106d3f:	68 14 8d 10 80       	push   $0x80108d14
80106d44:	e8 cf 96 ff ff       	call   80100418 <cprintf>
80106d49:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80106d4c:	83 ec 0c             	sub    $0xc,%esp
80106d4f:	68 46 8d 10 80       	push   $0x80108d46
80106d54:	e8 78 98 ff ff       	call   801005d1 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d59:	e8 e6 fc ff ff       	call   80106a44 <rcr2>
80106d5e:	89 c6                	mov    %eax,%esi
80106d60:	8b 45 08             	mov    0x8(%ebp),%eax
80106d63:	8b 40 38             	mov    0x38(%eax),%eax
80106d66:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d69:	e8 2e d6 ff ff       	call   8010439c <cpuid>
80106d6e:	89 c3                	mov    %eax,%ebx
80106d70:	8b 45 08             	mov    0x8(%ebp),%eax
80106d73:	8b 48 34             	mov    0x34(%eax),%ecx
80106d76:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106d79:	8b 45 08             	mov    0x8(%ebp),%eax
80106d7c:	8b 78 30             	mov    0x30(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106d7f:	e8 b3 d6 ff ff       	call   80104437 <myproc>
80106d84:	8d 50 6c             	lea    0x6c(%eax),%edx
80106d87:	89 55 dc             	mov    %edx,-0x24(%ebp)
80106d8a:	e8 a8 d6 ff ff       	call   80104437 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106d8f:	8b 40 10             	mov    0x10(%eax),%eax
80106d92:	56                   	push   %esi
80106d93:	ff 75 e4             	pushl  -0x1c(%ebp)
80106d96:	53                   	push   %ebx
80106d97:	ff 75 e0             	pushl  -0x20(%ebp)
80106d9a:	57                   	push   %edi
80106d9b:	ff 75 dc             	pushl  -0x24(%ebp)
80106d9e:	50                   	push   %eax
80106d9f:	68 4c 8d 10 80       	push   $0x80108d4c
80106da4:	e8 6f 96 ff ff       	call   80100418 <cprintf>
80106da9:	83 c4 20             	add    $0x20,%esp
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106dac:	e8 86 d6 ff ff       	call   80104437 <myproc>
80106db1:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106db8:	eb 01                	jmp    80106dbb <trap+0x1d0>
    break;
80106dba:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106dbb:	e8 77 d6 ff ff       	call   80104437 <myproc>
80106dc0:	85 c0                	test   %eax,%eax
80106dc2:	74 23                	je     80106de7 <trap+0x1fc>
80106dc4:	e8 6e d6 ff ff       	call   80104437 <myproc>
80106dc9:	8b 40 24             	mov    0x24(%eax),%eax
80106dcc:	85 c0                	test   %eax,%eax
80106dce:	74 17                	je     80106de7 <trap+0x1fc>
80106dd0:	8b 45 08             	mov    0x8(%ebp),%eax
80106dd3:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106dd7:	0f b7 c0             	movzwl %ax,%eax
80106dda:	83 e0 03             	and    $0x3,%eax
80106ddd:	83 f8 03             	cmp    $0x3,%eax
80106de0:	75 05                	jne    80106de7 <trap+0x1fc>
    exit();
80106de2:	e8 c3 db ff ff       	call   801049aa <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106de7:	e8 4b d6 ff ff       	call   80104437 <myproc>
80106dec:	85 c0                	test   %eax,%eax
80106dee:	74 1d                	je     80106e0d <trap+0x222>
80106df0:	e8 42 d6 ff ff       	call   80104437 <myproc>
80106df5:	8b 40 0c             	mov    0xc(%eax),%eax
80106df8:	83 f8 04             	cmp    $0x4,%eax
80106dfb:	75 10                	jne    80106e0d <trap+0x222>
     tf->trapno == T_IRQ0+IRQ_TIMER)
80106dfd:	8b 45 08             	mov    0x8(%ebp),%eax
80106e00:	8b 40 30             	mov    0x30(%eax),%eax
  if(myproc() && myproc()->state == RUNNING &&
80106e03:	83 f8 20             	cmp    $0x20,%eax
80106e06:	75 05                	jne    80106e0d <trap+0x222>
    yield();
80106e08:	e8 b7 df ff ff       	call   80104dc4 <yield>

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e0d:	e8 25 d6 ff ff       	call   80104437 <myproc>
80106e12:	85 c0                	test   %eax,%eax
80106e14:	74 26                	je     80106e3c <trap+0x251>
80106e16:	e8 1c d6 ff ff       	call   80104437 <myproc>
80106e1b:	8b 40 24             	mov    0x24(%eax),%eax
80106e1e:	85 c0                	test   %eax,%eax
80106e20:	74 1a                	je     80106e3c <trap+0x251>
80106e22:	8b 45 08             	mov    0x8(%ebp),%eax
80106e25:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106e29:	0f b7 c0             	movzwl %ax,%eax
80106e2c:	83 e0 03             	and    $0x3,%eax
80106e2f:	83 f8 03             	cmp    $0x3,%eax
80106e32:	75 08                	jne    80106e3c <trap+0x251>
    exit();
80106e34:	e8 71 db ff ff       	call   801049aa <exit>
80106e39:	eb 01                	jmp    80106e3c <trap+0x251>
    return;
80106e3b:	90                   	nop
}
80106e3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e3f:	5b                   	pop    %ebx
80106e40:	5e                   	pop    %esi
80106e41:	5f                   	pop    %edi
80106e42:	5d                   	pop    %ebp
80106e43:	c3                   	ret    

80106e44 <inb>:
{
80106e44:	55                   	push   %ebp
80106e45:	89 e5                	mov    %esp,%ebp
80106e47:	83 ec 14             	sub    $0x14,%esp
80106e4a:	8b 45 08             	mov    0x8(%ebp),%eax
80106e4d:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106e51:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106e55:	89 c2                	mov    %eax,%edx
80106e57:	ec                   	in     (%dx),%al
80106e58:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106e5b:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106e5f:	c9                   	leave  
80106e60:	c3                   	ret    

80106e61 <outb>:
{
80106e61:	55                   	push   %ebp
80106e62:	89 e5                	mov    %esp,%ebp
80106e64:	83 ec 08             	sub    $0x8,%esp
80106e67:	8b 45 08             	mov    0x8(%ebp),%eax
80106e6a:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e6d:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80106e71:	89 d0                	mov    %edx,%eax
80106e73:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106e76:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106e7a:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106e7e:	ee                   	out    %al,(%dx)
}
80106e7f:	90                   	nop
80106e80:	c9                   	leave  
80106e81:	c3                   	ret    

80106e82 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106e82:	f3 0f 1e fb          	endbr32 
80106e86:	55                   	push   %ebp
80106e87:	89 e5                	mov    %esp,%ebp
80106e89:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106e8c:	6a 00                	push   $0x0
80106e8e:	68 fa 03 00 00       	push   $0x3fa
80106e93:	e8 c9 ff ff ff       	call   80106e61 <outb>
80106e98:	83 c4 08             	add    $0x8,%esp

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106e9b:	68 80 00 00 00       	push   $0x80
80106ea0:	68 fb 03 00 00       	push   $0x3fb
80106ea5:	e8 b7 ff ff ff       	call   80106e61 <outb>
80106eaa:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106ead:	6a 0c                	push   $0xc
80106eaf:	68 f8 03 00 00       	push   $0x3f8
80106eb4:	e8 a8 ff ff ff       	call   80106e61 <outb>
80106eb9:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106ebc:	6a 00                	push   $0x0
80106ebe:	68 f9 03 00 00       	push   $0x3f9
80106ec3:	e8 99 ff ff ff       	call   80106e61 <outb>
80106ec8:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106ecb:	6a 03                	push   $0x3
80106ecd:	68 fb 03 00 00       	push   $0x3fb
80106ed2:	e8 8a ff ff ff       	call   80106e61 <outb>
80106ed7:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106eda:	6a 00                	push   $0x0
80106edc:	68 fc 03 00 00       	push   $0x3fc
80106ee1:	e8 7b ff ff ff       	call   80106e61 <outb>
80106ee6:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106ee9:	6a 01                	push   $0x1
80106eeb:	68 f9 03 00 00       	push   $0x3f9
80106ef0:	e8 6c ff ff ff       	call   80106e61 <outb>
80106ef5:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106ef8:	68 fd 03 00 00       	push   $0x3fd
80106efd:	e8 42 ff ff ff       	call   80106e44 <inb>
80106f02:	83 c4 04             	add    $0x4,%esp
80106f05:	3c ff                	cmp    $0xff,%al
80106f07:	74 61                	je     80106f6a <uartinit+0xe8>
    return;
  uart = 1;
80106f09:	c7 05 24 b6 10 80 01 	movl   $0x1,0x8010b624
80106f10:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106f13:	68 fa 03 00 00       	push   $0x3fa
80106f18:	e8 27 ff ff ff       	call   80106e44 <inb>
80106f1d:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106f20:	68 f8 03 00 00       	push   $0x3f8
80106f25:	e8 1a ff ff ff       	call   80106e44 <inb>
80106f2a:	83 c4 04             	add    $0x4,%esp
  ioapicenable(IRQ_COM1, 0);
80106f2d:	83 ec 08             	sub    $0x8,%esp
80106f30:	6a 00                	push   $0x0
80106f32:	6a 04                	push   $0x4
80106f34:	e8 da bc ff ff       	call   80102c13 <ioapicenable>
80106f39:	83 c4 10             	add    $0x10,%esp

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106f3c:	c7 45 f4 10 8e 10 80 	movl   $0x80108e10,-0xc(%ebp)
80106f43:	eb 19                	jmp    80106f5e <uartinit+0xdc>
    uartputc(*p);
80106f45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f48:	0f b6 00             	movzbl (%eax),%eax
80106f4b:	0f be c0             	movsbl %al,%eax
80106f4e:	83 ec 0c             	sub    $0xc,%esp
80106f51:	50                   	push   %eax
80106f52:	e8 16 00 00 00       	call   80106f6d <uartputc>
80106f57:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106f5a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106f5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f61:	0f b6 00             	movzbl (%eax),%eax
80106f64:	84 c0                	test   %al,%al
80106f66:	75 dd                	jne    80106f45 <uartinit+0xc3>
80106f68:	eb 01                	jmp    80106f6b <uartinit+0xe9>
    return;
80106f6a:	90                   	nop
}
80106f6b:	c9                   	leave  
80106f6c:	c3                   	ret    

80106f6d <uartputc>:

void
uartputc(int c)
{
80106f6d:	f3 0f 1e fb          	endbr32 
80106f71:	55                   	push   %ebp
80106f72:	89 e5                	mov    %esp,%ebp
80106f74:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106f77:	a1 24 b6 10 80       	mov    0x8010b624,%eax
80106f7c:	85 c0                	test   %eax,%eax
80106f7e:	74 53                	je     80106fd3 <uartputc+0x66>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106f80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106f87:	eb 11                	jmp    80106f9a <uartputc+0x2d>
    microdelay(10);
80106f89:	83 ec 0c             	sub    $0xc,%esp
80106f8c:	6a 0a                	push   $0xa
80106f8e:	e8 b8 c1 ff ff       	call   8010314b <microdelay>
80106f93:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106f96:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106f9a:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106f9e:	7f 1a                	jg     80106fba <uartputc+0x4d>
80106fa0:	83 ec 0c             	sub    $0xc,%esp
80106fa3:	68 fd 03 00 00       	push   $0x3fd
80106fa8:	e8 97 fe ff ff       	call   80106e44 <inb>
80106fad:	83 c4 10             	add    $0x10,%esp
80106fb0:	0f b6 c0             	movzbl %al,%eax
80106fb3:	83 e0 20             	and    $0x20,%eax
80106fb6:	85 c0                	test   %eax,%eax
80106fb8:	74 cf                	je     80106f89 <uartputc+0x1c>
  outb(COM1+0, c);
80106fba:	8b 45 08             	mov    0x8(%ebp),%eax
80106fbd:	0f b6 c0             	movzbl %al,%eax
80106fc0:	83 ec 08             	sub    $0x8,%esp
80106fc3:	50                   	push   %eax
80106fc4:	68 f8 03 00 00       	push   $0x3f8
80106fc9:	e8 93 fe ff ff       	call   80106e61 <outb>
80106fce:	83 c4 10             	add    $0x10,%esp
80106fd1:	eb 01                	jmp    80106fd4 <uartputc+0x67>
    return;
80106fd3:	90                   	nop
}
80106fd4:	c9                   	leave  
80106fd5:	c3                   	ret    

80106fd6 <uartgetc>:

static int
uartgetc(void)
{
80106fd6:	f3 0f 1e fb          	endbr32 
80106fda:	55                   	push   %ebp
80106fdb:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106fdd:	a1 24 b6 10 80       	mov    0x8010b624,%eax
80106fe2:	85 c0                	test   %eax,%eax
80106fe4:	75 07                	jne    80106fed <uartgetc+0x17>
    return -1;
80106fe6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106feb:	eb 2e                	jmp    8010701b <uartgetc+0x45>
  if(!(inb(COM1+5) & 0x01))
80106fed:	68 fd 03 00 00       	push   $0x3fd
80106ff2:	e8 4d fe ff ff       	call   80106e44 <inb>
80106ff7:	83 c4 04             	add    $0x4,%esp
80106ffa:	0f b6 c0             	movzbl %al,%eax
80106ffd:	83 e0 01             	and    $0x1,%eax
80107000:	85 c0                	test   %eax,%eax
80107002:	75 07                	jne    8010700b <uartgetc+0x35>
    return -1;
80107004:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107009:	eb 10                	jmp    8010701b <uartgetc+0x45>
  return inb(COM1+0);
8010700b:	68 f8 03 00 00       	push   $0x3f8
80107010:	e8 2f fe ff ff       	call   80106e44 <inb>
80107015:	83 c4 04             	add    $0x4,%esp
80107018:	0f b6 c0             	movzbl %al,%eax
}
8010701b:	c9                   	leave  
8010701c:	c3                   	ret    

8010701d <uartintr>:

void
uartintr(void)
{
8010701d:	f3 0f 1e fb          	endbr32 
80107021:	55                   	push   %ebp
80107022:	89 e5                	mov    %esp,%ebp
80107024:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80107027:	83 ec 0c             	sub    $0xc,%esp
8010702a:	68 d6 6f 10 80       	push   $0x80106fd6
8010702f:	e8 3d 98 ff ff       	call   80100871 <consoleintr>
80107034:	83 c4 10             	add    $0x10,%esp
}
80107037:	90                   	nop
80107038:	c9                   	leave  
80107039:	c3                   	ret    

8010703a <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
8010703a:	6a 00                	push   $0x0
  pushl $0
8010703c:	6a 00                	push   $0x0
  jmp alltraps
8010703e:	e9 b4 f9 ff ff       	jmp    801069f7 <alltraps>

80107043 <vector1>:
.globl vector1
vector1:
  pushl $0
80107043:	6a 00                	push   $0x0
  pushl $1
80107045:	6a 01                	push   $0x1
  jmp alltraps
80107047:	e9 ab f9 ff ff       	jmp    801069f7 <alltraps>

8010704c <vector2>:
.globl vector2
vector2:
  pushl $0
8010704c:	6a 00                	push   $0x0
  pushl $2
8010704e:	6a 02                	push   $0x2
  jmp alltraps
80107050:	e9 a2 f9 ff ff       	jmp    801069f7 <alltraps>

80107055 <vector3>:
.globl vector3
vector3:
  pushl $0
80107055:	6a 00                	push   $0x0
  pushl $3
80107057:	6a 03                	push   $0x3
  jmp alltraps
80107059:	e9 99 f9 ff ff       	jmp    801069f7 <alltraps>

8010705e <vector4>:
.globl vector4
vector4:
  pushl $0
8010705e:	6a 00                	push   $0x0
  pushl $4
80107060:	6a 04                	push   $0x4
  jmp alltraps
80107062:	e9 90 f9 ff ff       	jmp    801069f7 <alltraps>

80107067 <vector5>:
.globl vector5
vector5:
  pushl $0
80107067:	6a 00                	push   $0x0
  pushl $5
80107069:	6a 05                	push   $0x5
  jmp alltraps
8010706b:	e9 87 f9 ff ff       	jmp    801069f7 <alltraps>

80107070 <vector6>:
.globl vector6
vector6:
  pushl $0
80107070:	6a 00                	push   $0x0
  pushl $6
80107072:	6a 06                	push   $0x6
  jmp alltraps
80107074:	e9 7e f9 ff ff       	jmp    801069f7 <alltraps>

80107079 <vector7>:
.globl vector7
vector7:
  pushl $0
80107079:	6a 00                	push   $0x0
  pushl $7
8010707b:	6a 07                	push   $0x7
  jmp alltraps
8010707d:	e9 75 f9 ff ff       	jmp    801069f7 <alltraps>

80107082 <vector8>:
.globl vector8
vector8:
  pushl $8
80107082:	6a 08                	push   $0x8
  jmp alltraps
80107084:	e9 6e f9 ff ff       	jmp    801069f7 <alltraps>

80107089 <vector9>:
.globl vector9
vector9:
  pushl $0
80107089:	6a 00                	push   $0x0
  pushl $9
8010708b:	6a 09                	push   $0x9
  jmp alltraps
8010708d:	e9 65 f9 ff ff       	jmp    801069f7 <alltraps>

80107092 <vector10>:
.globl vector10
vector10:
  pushl $10
80107092:	6a 0a                	push   $0xa
  jmp alltraps
80107094:	e9 5e f9 ff ff       	jmp    801069f7 <alltraps>

80107099 <vector11>:
.globl vector11
vector11:
  pushl $11
80107099:	6a 0b                	push   $0xb
  jmp alltraps
8010709b:	e9 57 f9 ff ff       	jmp    801069f7 <alltraps>

801070a0 <vector12>:
.globl vector12
vector12:
  pushl $12
801070a0:	6a 0c                	push   $0xc
  jmp alltraps
801070a2:	e9 50 f9 ff ff       	jmp    801069f7 <alltraps>

801070a7 <vector13>:
.globl vector13
vector13:
  pushl $13
801070a7:	6a 0d                	push   $0xd
  jmp alltraps
801070a9:	e9 49 f9 ff ff       	jmp    801069f7 <alltraps>

801070ae <vector14>:
.globl vector14
vector14:
  pushl $14
801070ae:	6a 0e                	push   $0xe
  jmp alltraps
801070b0:	e9 42 f9 ff ff       	jmp    801069f7 <alltraps>

801070b5 <vector15>:
.globl vector15
vector15:
  pushl $0
801070b5:	6a 00                	push   $0x0
  pushl $15
801070b7:	6a 0f                	push   $0xf
  jmp alltraps
801070b9:	e9 39 f9 ff ff       	jmp    801069f7 <alltraps>

801070be <vector16>:
.globl vector16
vector16:
  pushl $0
801070be:	6a 00                	push   $0x0
  pushl $16
801070c0:	6a 10                	push   $0x10
  jmp alltraps
801070c2:	e9 30 f9 ff ff       	jmp    801069f7 <alltraps>

801070c7 <vector17>:
.globl vector17
vector17:
  pushl $17
801070c7:	6a 11                	push   $0x11
  jmp alltraps
801070c9:	e9 29 f9 ff ff       	jmp    801069f7 <alltraps>

801070ce <vector18>:
.globl vector18
vector18:
  pushl $0
801070ce:	6a 00                	push   $0x0
  pushl $18
801070d0:	6a 12                	push   $0x12
  jmp alltraps
801070d2:	e9 20 f9 ff ff       	jmp    801069f7 <alltraps>

801070d7 <vector19>:
.globl vector19
vector19:
  pushl $0
801070d7:	6a 00                	push   $0x0
  pushl $19
801070d9:	6a 13                	push   $0x13
  jmp alltraps
801070db:	e9 17 f9 ff ff       	jmp    801069f7 <alltraps>

801070e0 <vector20>:
.globl vector20
vector20:
  pushl $0
801070e0:	6a 00                	push   $0x0
  pushl $20
801070e2:	6a 14                	push   $0x14
  jmp alltraps
801070e4:	e9 0e f9 ff ff       	jmp    801069f7 <alltraps>

801070e9 <vector21>:
.globl vector21
vector21:
  pushl $0
801070e9:	6a 00                	push   $0x0
  pushl $21
801070eb:	6a 15                	push   $0x15
  jmp alltraps
801070ed:	e9 05 f9 ff ff       	jmp    801069f7 <alltraps>

801070f2 <vector22>:
.globl vector22
vector22:
  pushl $0
801070f2:	6a 00                	push   $0x0
  pushl $22
801070f4:	6a 16                	push   $0x16
  jmp alltraps
801070f6:	e9 fc f8 ff ff       	jmp    801069f7 <alltraps>

801070fb <vector23>:
.globl vector23
vector23:
  pushl $0
801070fb:	6a 00                	push   $0x0
  pushl $23
801070fd:	6a 17                	push   $0x17
  jmp alltraps
801070ff:	e9 f3 f8 ff ff       	jmp    801069f7 <alltraps>

80107104 <vector24>:
.globl vector24
vector24:
  pushl $0
80107104:	6a 00                	push   $0x0
  pushl $24
80107106:	6a 18                	push   $0x18
  jmp alltraps
80107108:	e9 ea f8 ff ff       	jmp    801069f7 <alltraps>

8010710d <vector25>:
.globl vector25
vector25:
  pushl $0
8010710d:	6a 00                	push   $0x0
  pushl $25
8010710f:	6a 19                	push   $0x19
  jmp alltraps
80107111:	e9 e1 f8 ff ff       	jmp    801069f7 <alltraps>

80107116 <vector26>:
.globl vector26
vector26:
  pushl $0
80107116:	6a 00                	push   $0x0
  pushl $26
80107118:	6a 1a                	push   $0x1a
  jmp alltraps
8010711a:	e9 d8 f8 ff ff       	jmp    801069f7 <alltraps>

8010711f <vector27>:
.globl vector27
vector27:
  pushl $0
8010711f:	6a 00                	push   $0x0
  pushl $27
80107121:	6a 1b                	push   $0x1b
  jmp alltraps
80107123:	e9 cf f8 ff ff       	jmp    801069f7 <alltraps>

80107128 <vector28>:
.globl vector28
vector28:
  pushl $0
80107128:	6a 00                	push   $0x0
  pushl $28
8010712a:	6a 1c                	push   $0x1c
  jmp alltraps
8010712c:	e9 c6 f8 ff ff       	jmp    801069f7 <alltraps>

80107131 <vector29>:
.globl vector29
vector29:
  pushl $0
80107131:	6a 00                	push   $0x0
  pushl $29
80107133:	6a 1d                	push   $0x1d
  jmp alltraps
80107135:	e9 bd f8 ff ff       	jmp    801069f7 <alltraps>

8010713a <vector30>:
.globl vector30
vector30:
  pushl $0
8010713a:	6a 00                	push   $0x0
  pushl $30
8010713c:	6a 1e                	push   $0x1e
  jmp alltraps
8010713e:	e9 b4 f8 ff ff       	jmp    801069f7 <alltraps>

80107143 <vector31>:
.globl vector31
vector31:
  pushl $0
80107143:	6a 00                	push   $0x0
  pushl $31
80107145:	6a 1f                	push   $0x1f
  jmp alltraps
80107147:	e9 ab f8 ff ff       	jmp    801069f7 <alltraps>

8010714c <vector32>:
.globl vector32
vector32:
  pushl $0
8010714c:	6a 00                	push   $0x0
  pushl $32
8010714e:	6a 20                	push   $0x20
  jmp alltraps
80107150:	e9 a2 f8 ff ff       	jmp    801069f7 <alltraps>

80107155 <vector33>:
.globl vector33
vector33:
  pushl $0
80107155:	6a 00                	push   $0x0
  pushl $33
80107157:	6a 21                	push   $0x21
  jmp alltraps
80107159:	e9 99 f8 ff ff       	jmp    801069f7 <alltraps>

8010715e <vector34>:
.globl vector34
vector34:
  pushl $0
8010715e:	6a 00                	push   $0x0
  pushl $34
80107160:	6a 22                	push   $0x22
  jmp alltraps
80107162:	e9 90 f8 ff ff       	jmp    801069f7 <alltraps>

80107167 <vector35>:
.globl vector35
vector35:
  pushl $0
80107167:	6a 00                	push   $0x0
  pushl $35
80107169:	6a 23                	push   $0x23
  jmp alltraps
8010716b:	e9 87 f8 ff ff       	jmp    801069f7 <alltraps>

80107170 <vector36>:
.globl vector36
vector36:
  pushl $0
80107170:	6a 00                	push   $0x0
  pushl $36
80107172:	6a 24                	push   $0x24
  jmp alltraps
80107174:	e9 7e f8 ff ff       	jmp    801069f7 <alltraps>

80107179 <vector37>:
.globl vector37
vector37:
  pushl $0
80107179:	6a 00                	push   $0x0
  pushl $37
8010717b:	6a 25                	push   $0x25
  jmp alltraps
8010717d:	e9 75 f8 ff ff       	jmp    801069f7 <alltraps>

80107182 <vector38>:
.globl vector38
vector38:
  pushl $0
80107182:	6a 00                	push   $0x0
  pushl $38
80107184:	6a 26                	push   $0x26
  jmp alltraps
80107186:	e9 6c f8 ff ff       	jmp    801069f7 <alltraps>

8010718b <vector39>:
.globl vector39
vector39:
  pushl $0
8010718b:	6a 00                	push   $0x0
  pushl $39
8010718d:	6a 27                	push   $0x27
  jmp alltraps
8010718f:	e9 63 f8 ff ff       	jmp    801069f7 <alltraps>

80107194 <vector40>:
.globl vector40
vector40:
  pushl $0
80107194:	6a 00                	push   $0x0
  pushl $40
80107196:	6a 28                	push   $0x28
  jmp alltraps
80107198:	e9 5a f8 ff ff       	jmp    801069f7 <alltraps>

8010719d <vector41>:
.globl vector41
vector41:
  pushl $0
8010719d:	6a 00                	push   $0x0
  pushl $41
8010719f:	6a 29                	push   $0x29
  jmp alltraps
801071a1:	e9 51 f8 ff ff       	jmp    801069f7 <alltraps>

801071a6 <vector42>:
.globl vector42
vector42:
  pushl $0
801071a6:	6a 00                	push   $0x0
  pushl $42
801071a8:	6a 2a                	push   $0x2a
  jmp alltraps
801071aa:	e9 48 f8 ff ff       	jmp    801069f7 <alltraps>

801071af <vector43>:
.globl vector43
vector43:
  pushl $0
801071af:	6a 00                	push   $0x0
  pushl $43
801071b1:	6a 2b                	push   $0x2b
  jmp alltraps
801071b3:	e9 3f f8 ff ff       	jmp    801069f7 <alltraps>

801071b8 <vector44>:
.globl vector44
vector44:
  pushl $0
801071b8:	6a 00                	push   $0x0
  pushl $44
801071ba:	6a 2c                	push   $0x2c
  jmp alltraps
801071bc:	e9 36 f8 ff ff       	jmp    801069f7 <alltraps>

801071c1 <vector45>:
.globl vector45
vector45:
  pushl $0
801071c1:	6a 00                	push   $0x0
  pushl $45
801071c3:	6a 2d                	push   $0x2d
  jmp alltraps
801071c5:	e9 2d f8 ff ff       	jmp    801069f7 <alltraps>

801071ca <vector46>:
.globl vector46
vector46:
  pushl $0
801071ca:	6a 00                	push   $0x0
  pushl $46
801071cc:	6a 2e                	push   $0x2e
  jmp alltraps
801071ce:	e9 24 f8 ff ff       	jmp    801069f7 <alltraps>

801071d3 <vector47>:
.globl vector47
vector47:
  pushl $0
801071d3:	6a 00                	push   $0x0
  pushl $47
801071d5:	6a 2f                	push   $0x2f
  jmp alltraps
801071d7:	e9 1b f8 ff ff       	jmp    801069f7 <alltraps>

801071dc <vector48>:
.globl vector48
vector48:
  pushl $0
801071dc:	6a 00                	push   $0x0
  pushl $48
801071de:	6a 30                	push   $0x30
  jmp alltraps
801071e0:	e9 12 f8 ff ff       	jmp    801069f7 <alltraps>

801071e5 <vector49>:
.globl vector49
vector49:
  pushl $0
801071e5:	6a 00                	push   $0x0
  pushl $49
801071e7:	6a 31                	push   $0x31
  jmp alltraps
801071e9:	e9 09 f8 ff ff       	jmp    801069f7 <alltraps>

801071ee <vector50>:
.globl vector50
vector50:
  pushl $0
801071ee:	6a 00                	push   $0x0
  pushl $50
801071f0:	6a 32                	push   $0x32
  jmp alltraps
801071f2:	e9 00 f8 ff ff       	jmp    801069f7 <alltraps>

801071f7 <vector51>:
.globl vector51
vector51:
  pushl $0
801071f7:	6a 00                	push   $0x0
  pushl $51
801071f9:	6a 33                	push   $0x33
  jmp alltraps
801071fb:	e9 f7 f7 ff ff       	jmp    801069f7 <alltraps>

80107200 <vector52>:
.globl vector52
vector52:
  pushl $0
80107200:	6a 00                	push   $0x0
  pushl $52
80107202:	6a 34                	push   $0x34
  jmp alltraps
80107204:	e9 ee f7 ff ff       	jmp    801069f7 <alltraps>

80107209 <vector53>:
.globl vector53
vector53:
  pushl $0
80107209:	6a 00                	push   $0x0
  pushl $53
8010720b:	6a 35                	push   $0x35
  jmp alltraps
8010720d:	e9 e5 f7 ff ff       	jmp    801069f7 <alltraps>

80107212 <vector54>:
.globl vector54
vector54:
  pushl $0
80107212:	6a 00                	push   $0x0
  pushl $54
80107214:	6a 36                	push   $0x36
  jmp alltraps
80107216:	e9 dc f7 ff ff       	jmp    801069f7 <alltraps>

8010721b <vector55>:
.globl vector55
vector55:
  pushl $0
8010721b:	6a 00                	push   $0x0
  pushl $55
8010721d:	6a 37                	push   $0x37
  jmp alltraps
8010721f:	e9 d3 f7 ff ff       	jmp    801069f7 <alltraps>

80107224 <vector56>:
.globl vector56
vector56:
  pushl $0
80107224:	6a 00                	push   $0x0
  pushl $56
80107226:	6a 38                	push   $0x38
  jmp alltraps
80107228:	e9 ca f7 ff ff       	jmp    801069f7 <alltraps>

8010722d <vector57>:
.globl vector57
vector57:
  pushl $0
8010722d:	6a 00                	push   $0x0
  pushl $57
8010722f:	6a 39                	push   $0x39
  jmp alltraps
80107231:	e9 c1 f7 ff ff       	jmp    801069f7 <alltraps>

80107236 <vector58>:
.globl vector58
vector58:
  pushl $0
80107236:	6a 00                	push   $0x0
  pushl $58
80107238:	6a 3a                	push   $0x3a
  jmp alltraps
8010723a:	e9 b8 f7 ff ff       	jmp    801069f7 <alltraps>

8010723f <vector59>:
.globl vector59
vector59:
  pushl $0
8010723f:	6a 00                	push   $0x0
  pushl $59
80107241:	6a 3b                	push   $0x3b
  jmp alltraps
80107243:	e9 af f7 ff ff       	jmp    801069f7 <alltraps>

80107248 <vector60>:
.globl vector60
vector60:
  pushl $0
80107248:	6a 00                	push   $0x0
  pushl $60
8010724a:	6a 3c                	push   $0x3c
  jmp alltraps
8010724c:	e9 a6 f7 ff ff       	jmp    801069f7 <alltraps>

80107251 <vector61>:
.globl vector61
vector61:
  pushl $0
80107251:	6a 00                	push   $0x0
  pushl $61
80107253:	6a 3d                	push   $0x3d
  jmp alltraps
80107255:	e9 9d f7 ff ff       	jmp    801069f7 <alltraps>

8010725a <vector62>:
.globl vector62
vector62:
  pushl $0
8010725a:	6a 00                	push   $0x0
  pushl $62
8010725c:	6a 3e                	push   $0x3e
  jmp alltraps
8010725e:	e9 94 f7 ff ff       	jmp    801069f7 <alltraps>

80107263 <vector63>:
.globl vector63
vector63:
  pushl $0
80107263:	6a 00                	push   $0x0
  pushl $63
80107265:	6a 3f                	push   $0x3f
  jmp alltraps
80107267:	e9 8b f7 ff ff       	jmp    801069f7 <alltraps>

8010726c <vector64>:
.globl vector64
vector64:
  pushl $0
8010726c:	6a 00                	push   $0x0
  pushl $64
8010726e:	6a 40                	push   $0x40
  jmp alltraps
80107270:	e9 82 f7 ff ff       	jmp    801069f7 <alltraps>

80107275 <vector65>:
.globl vector65
vector65:
  pushl $0
80107275:	6a 00                	push   $0x0
  pushl $65
80107277:	6a 41                	push   $0x41
  jmp alltraps
80107279:	e9 79 f7 ff ff       	jmp    801069f7 <alltraps>

8010727e <vector66>:
.globl vector66
vector66:
  pushl $0
8010727e:	6a 00                	push   $0x0
  pushl $66
80107280:	6a 42                	push   $0x42
  jmp alltraps
80107282:	e9 70 f7 ff ff       	jmp    801069f7 <alltraps>

80107287 <vector67>:
.globl vector67
vector67:
  pushl $0
80107287:	6a 00                	push   $0x0
  pushl $67
80107289:	6a 43                	push   $0x43
  jmp alltraps
8010728b:	e9 67 f7 ff ff       	jmp    801069f7 <alltraps>

80107290 <vector68>:
.globl vector68
vector68:
  pushl $0
80107290:	6a 00                	push   $0x0
  pushl $68
80107292:	6a 44                	push   $0x44
  jmp alltraps
80107294:	e9 5e f7 ff ff       	jmp    801069f7 <alltraps>

80107299 <vector69>:
.globl vector69
vector69:
  pushl $0
80107299:	6a 00                	push   $0x0
  pushl $69
8010729b:	6a 45                	push   $0x45
  jmp alltraps
8010729d:	e9 55 f7 ff ff       	jmp    801069f7 <alltraps>

801072a2 <vector70>:
.globl vector70
vector70:
  pushl $0
801072a2:	6a 00                	push   $0x0
  pushl $70
801072a4:	6a 46                	push   $0x46
  jmp alltraps
801072a6:	e9 4c f7 ff ff       	jmp    801069f7 <alltraps>

801072ab <vector71>:
.globl vector71
vector71:
  pushl $0
801072ab:	6a 00                	push   $0x0
  pushl $71
801072ad:	6a 47                	push   $0x47
  jmp alltraps
801072af:	e9 43 f7 ff ff       	jmp    801069f7 <alltraps>

801072b4 <vector72>:
.globl vector72
vector72:
  pushl $0
801072b4:	6a 00                	push   $0x0
  pushl $72
801072b6:	6a 48                	push   $0x48
  jmp alltraps
801072b8:	e9 3a f7 ff ff       	jmp    801069f7 <alltraps>

801072bd <vector73>:
.globl vector73
vector73:
  pushl $0
801072bd:	6a 00                	push   $0x0
  pushl $73
801072bf:	6a 49                	push   $0x49
  jmp alltraps
801072c1:	e9 31 f7 ff ff       	jmp    801069f7 <alltraps>

801072c6 <vector74>:
.globl vector74
vector74:
  pushl $0
801072c6:	6a 00                	push   $0x0
  pushl $74
801072c8:	6a 4a                	push   $0x4a
  jmp alltraps
801072ca:	e9 28 f7 ff ff       	jmp    801069f7 <alltraps>

801072cf <vector75>:
.globl vector75
vector75:
  pushl $0
801072cf:	6a 00                	push   $0x0
  pushl $75
801072d1:	6a 4b                	push   $0x4b
  jmp alltraps
801072d3:	e9 1f f7 ff ff       	jmp    801069f7 <alltraps>

801072d8 <vector76>:
.globl vector76
vector76:
  pushl $0
801072d8:	6a 00                	push   $0x0
  pushl $76
801072da:	6a 4c                	push   $0x4c
  jmp alltraps
801072dc:	e9 16 f7 ff ff       	jmp    801069f7 <alltraps>

801072e1 <vector77>:
.globl vector77
vector77:
  pushl $0
801072e1:	6a 00                	push   $0x0
  pushl $77
801072e3:	6a 4d                	push   $0x4d
  jmp alltraps
801072e5:	e9 0d f7 ff ff       	jmp    801069f7 <alltraps>

801072ea <vector78>:
.globl vector78
vector78:
  pushl $0
801072ea:	6a 00                	push   $0x0
  pushl $78
801072ec:	6a 4e                	push   $0x4e
  jmp alltraps
801072ee:	e9 04 f7 ff ff       	jmp    801069f7 <alltraps>

801072f3 <vector79>:
.globl vector79
vector79:
  pushl $0
801072f3:	6a 00                	push   $0x0
  pushl $79
801072f5:	6a 4f                	push   $0x4f
  jmp alltraps
801072f7:	e9 fb f6 ff ff       	jmp    801069f7 <alltraps>

801072fc <vector80>:
.globl vector80
vector80:
  pushl $0
801072fc:	6a 00                	push   $0x0
  pushl $80
801072fe:	6a 50                	push   $0x50
  jmp alltraps
80107300:	e9 f2 f6 ff ff       	jmp    801069f7 <alltraps>

80107305 <vector81>:
.globl vector81
vector81:
  pushl $0
80107305:	6a 00                	push   $0x0
  pushl $81
80107307:	6a 51                	push   $0x51
  jmp alltraps
80107309:	e9 e9 f6 ff ff       	jmp    801069f7 <alltraps>

8010730e <vector82>:
.globl vector82
vector82:
  pushl $0
8010730e:	6a 00                	push   $0x0
  pushl $82
80107310:	6a 52                	push   $0x52
  jmp alltraps
80107312:	e9 e0 f6 ff ff       	jmp    801069f7 <alltraps>

80107317 <vector83>:
.globl vector83
vector83:
  pushl $0
80107317:	6a 00                	push   $0x0
  pushl $83
80107319:	6a 53                	push   $0x53
  jmp alltraps
8010731b:	e9 d7 f6 ff ff       	jmp    801069f7 <alltraps>

80107320 <vector84>:
.globl vector84
vector84:
  pushl $0
80107320:	6a 00                	push   $0x0
  pushl $84
80107322:	6a 54                	push   $0x54
  jmp alltraps
80107324:	e9 ce f6 ff ff       	jmp    801069f7 <alltraps>

80107329 <vector85>:
.globl vector85
vector85:
  pushl $0
80107329:	6a 00                	push   $0x0
  pushl $85
8010732b:	6a 55                	push   $0x55
  jmp alltraps
8010732d:	e9 c5 f6 ff ff       	jmp    801069f7 <alltraps>

80107332 <vector86>:
.globl vector86
vector86:
  pushl $0
80107332:	6a 00                	push   $0x0
  pushl $86
80107334:	6a 56                	push   $0x56
  jmp alltraps
80107336:	e9 bc f6 ff ff       	jmp    801069f7 <alltraps>

8010733b <vector87>:
.globl vector87
vector87:
  pushl $0
8010733b:	6a 00                	push   $0x0
  pushl $87
8010733d:	6a 57                	push   $0x57
  jmp alltraps
8010733f:	e9 b3 f6 ff ff       	jmp    801069f7 <alltraps>

80107344 <vector88>:
.globl vector88
vector88:
  pushl $0
80107344:	6a 00                	push   $0x0
  pushl $88
80107346:	6a 58                	push   $0x58
  jmp alltraps
80107348:	e9 aa f6 ff ff       	jmp    801069f7 <alltraps>

8010734d <vector89>:
.globl vector89
vector89:
  pushl $0
8010734d:	6a 00                	push   $0x0
  pushl $89
8010734f:	6a 59                	push   $0x59
  jmp alltraps
80107351:	e9 a1 f6 ff ff       	jmp    801069f7 <alltraps>

80107356 <vector90>:
.globl vector90
vector90:
  pushl $0
80107356:	6a 00                	push   $0x0
  pushl $90
80107358:	6a 5a                	push   $0x5a
  jmp alltraps
8010735a:	e9 98 f6 ff ff       	jmp    801069f7 <alltraps>

8010735f <vector91>:
.globl vector91
vector91:
  pushl $0
8010735f:	6a 00                	push   $0x0
  pushl $91
80107361:	6a 5b                	push   $0x5b
  jmp alltraps
80107363:	e9 8f f6 ff ff       	jmp    801069f7 <alltraps>

80107368 <vector92>:
.globl vector92
vector92:
  pushl $0
80107368:	6a 00                	push   $0x0
  pushl $92
8010736a:	6a 5c                	push   $0x5c
  jmp alltraps
8010736c:	e9 86 f6 ff ff       	jmp    801069f7 <alltraps>

80107371 <vector93>:
.globl vector93
vector93:
  pushl $0
80107371:	6a 00                	push   $0x0
  pushl $93
80107373:	6a 5d                	push   $0x5d
  jmp alltraps
80107375:	e9 7d f6 ff ff       	jmp    801069f7 <alltraps>

8010737a <vector94>:
.globl vector94
vector94:
  pushl $0
8010737a:	6a 00                	push   $0x0
  pushl $94
8010737c:	6a 5e                	push   $0x5e
  jmp alltraps
8010737e:	e9 74 f6 ff ff       	jmp    801069f7 <alltraps>

80107383 <vector95>:
.globl vector95
vector95:
  pushl $0
80107383:	6a 00                	push   $0x0
  pushl $95
80107385:	6a 5f                	push   $0x5f
  jmp alltraps
80107387:	e9 6b f6 ff ff       	jmp    801069f7 <alltraps>

8010738c <vector96>:
.globl vector96
vector96:
  pushl $0
8010738c:	6a 00                	push   $0x0
  pushl $96
8010738e:	6a 60                	push   $0x60
  jmp alltraps
80107390:	e9 62 f6 ff ff       	jmp    801069f7 <alltraps>

80107395 <vector97>:
.globl vector97
vector97:
  pushl $0
80107395:	6a 00                	push   $0x0
  pushl $97
80107397:	6a 61                	push   $0x61
  jmp alltraps
80107399:	e9 59 f6 ff ff       	jmp    801069f7 <alltraps>

8010739e <vector98>:
.globl vector98
vector98:
  pushl $0
8010739e:	6a 00                	push   $0x0
  pushl $98
801073a0:	6a 62                	push   $0x62
  jmp alltraps
801073a2:	e9 50 f6 ff ff       	jmp    801069f7 <alltraps>

801073a7 <vector99>:
.globl vector99
vector99:
  pushl $0
801073a7:	6a 00                	push   $0x0
  pushl $99
801073a9:	6a 63                	push   $0x63
  jmp alltraps
801073ab:	e9 47 f6 ff ff       	jmp    801069f7 <alltraps>

801073b0 <vector100>:
.globl vector100
vector100:
  pushl $0
801073b0:	6a 00                	push   $0x0
  pushl $100
801073b2:	6a 64                	push   $0x64
  jmp alltraps
801073b4:	e9 3e f6 ff ff       	jmp    801069f7 <alltraps>

801073b9 <vector101>:
.globl vector101
vector101:
  pushl $0
801073b9:	6a 00                	push   $0x0
  pushl $101
801073bb:	6a 65                	push   $0x65
  jmp alltraps
801073bd:	e9 35 f6 ff ff       	jmp    801069f7 <alltraps>

801073c2 <vector102>:
.globl vector102
vector102:
  pushl $0
801073c2:	6a 00                	push   $0x0
  pushl $102
801073c4:	6a 66                	push   $0x66
  jmp alltraps
801073c6:	e9 2c f6 ff ff       	jmp    801069f7 <alltraps>

801073cb <vector103>:
.globl vector103
vector103:
  pushl $0
801073cb:	6a 00                	push   $0x0
  pushl $103
801073cd:	6a 67                	push   $0x67
  jmp alltraps
801073cf:	e9 23 f6 ff ff       	jmp    801069f7 <alltraps>

801073d4 <vector104>:
.globl vector104
vector104:
  pushl $0
801073d4:	6a 00                	push   $0x0
  pushl $104
801073d6:	6a 68                	push   $0x68
  jmp alltraps
801073d8:	e9 1a f6 ff ff       	jmp    801069f7 <alltraps>

801073dd <vector105>:
.globl vector105
vector105:
  pushl $0
801073dd:	6a 00                	push   $0x0
  pushl $105
801073df:	6a 69                	push   $0x69
  jmp alltraps
801073e1:	e9 11 f6 ff ff       	jmp    801069f7 <alltraps>

801073e6 <vector106>:
.globl vector106
vector106:
  pushl $0
801073e6:	6a 00                	push   $0x0
  pushl $106
801073e8:	6a 6a                	push   $0x6a
  jmp alltraps
801073ea:	e9 08 f6 ff ff       	jmp    801069f7 <alltraps>

801073ef <vector107>:
.globl vector107
vector107:
  pushl $0
801073ef:	6a 00                	push   $0x0
  pushl $107
801073f1:	6a 6b                	push   $0x6b
  jmp alltraps
801073f3:	e9 ff f5 ff ff       	jmp    801069f7 <alltraps>

801073f8 <vector108>:
.globl vector108
vector108:
  pushl $0
801073f8:	6a 00                	push   $0x0
  pushl $108
801073fa:	6a 6c                	push   $0x6c
  jmp alltraps
801073fc:	e9 f6 f5 ff ff       	jmp    801069f7 <alltraps>

80107401 <vector109>:
.globl vector109
vector109:
  pushl $0
80107401:	6a 00                	push   $0x0
  pushl $109
80107403:	6a 6d                	push   $0x6d
  jmp alltraps
80107405:	e9 ed f5 ff ff       	jmp    801069f7 <alltraps>

8010740a <vector110>:
.globl vector110
vector110:
  pushl $0
8010740a:	6a 00                	push   $0x0
  pushl $110
8010740c:	6a 6e                	push   $0x6e
  jmp alltraps
8010740e:	e9 e4 f5 ff ff       	jmp    801069f7 <alltraps>

80107413 <vector111>:
.globl vector111
vector111:
  pushl $0
80107413:	6a 00                	push   $0x0
  pushl $111
80107415:	6a 6f                	push   $0x6f
  jmp alltraps
80107417:	e9 db f5 ff ff       	jmp    801069f7 <alltraps>

8010741c <vector112>:
.globl vector112
vector112:
  pushl $0
8010741c:	6a 00                	push   $0x0
  pushl $112
8010741e:	6a 70                	push   $0x70
  jmp alltraps
80107420:	e9 d2 f5 ff ff       	jmp    801069f7 <alltraps>

80107425 <vector113>:
.globl vector113
vector113:
  pushl $0
80107425:	6a 00                	push   $0x0
  pushl $113
80107427:	6a 71                	push   $0x71
  jmp alltraps
80107429:	e9 c9 f5 ff ff       	jmp    801069f7 <alltraps>

8010742e <vector114>:
.globl vector114
vector114:
  pushl $0
8010742e:	6a 00                	push   $0x0
  pushl $114
80107430:	6a 72                	push   $0x72
  jmp alltraps
80107432:	e9 c0 f5 ff ff       	jmp    801069f7 <alltraps>

80107437 <vector115>:
.globl vector115
vector115:
  pushl $0
80107437:	6a 00                	push   $0x0
  pushl $115
80107439:	6a 73                	push   $0x73
  jmp alltraps
8010743b:	e9 b7 f5 ff ff       	jmp    801069f7 <alltraps>

80107440 <vector116>:
.globl vector116
vector116:
  pushl $0
80107440:	6a 00                	push   $0x0
  pushl $116
80107442:	6a 74                	push   $0x74
  jmp alltraps
80107444:	e9 ae f5 ff ff       	jmp    801069f7 <alltraps>

80107449 <vector117>:
.globl vector117
vector117:
  pushl $0
80107449:	6a 00                	push   $0x0
  pushl $117
8010744b:	6a 75                	push   $0x75
  jmp alltraps
8010744d:	e9 a5 f5 ff ff       	jmp    801069f7 <alltraps>

80107452 <vector118>:
.globl vector118
vector118:
  pushl $0
80107452:	6a 00                	push   $0x0
  pushl $118
80107454:	6a 76                	push   $0x76
  jmp alltraps
80107456:	e9 9c f5 ff ff       	jmp    801069f7 <alltraps>

8010745b <vector119>:
.globl vector119
vector119:
  pushl $0
8010745b:	6a 00                	push   $0x0
  pushl $119
8010745d:	6a 77                	push   $0x77
  jmp alltraps
8010745f:	e9 93 f5 ff ff       	jmp    801069f7 <alltraps>

80107464 <vector120>:
.globl vector120
vector120:
  pushl $0
80107464:	6a 00                	push   $0x0
  pushl $120
80107466:	6a 78                	push   $0x78
  jmp alltraps
80107468:	e9 8a f5 ff ff       	jmp    801069f7 <alltraps>

8010746d <vector121>:
.globl vector121
vector121:
  pushl $0
8010746d:	6a 00                	push   $0x0
  pushl $121
8010746f:	6a 79                	push   $0x79
  jmp alltraps
80107471:	e9 81 f5 ff ff       	jmp    801069f7 <alltraps>

80107476 <vector122>:
.globl vector122
vector122:
  pushl $0
80107476:	6a 00                	push   $0x0
  pushl $122
80107478:	6a 7a                	push   $0x7a
  jmp alltraps
8010747a:	e9 78 f5 ff ff       	jmp    801069f7 <alltraps>

8010747f <vector123>:
.globl vector123
vector123:
  pushl $0
8010747f:	6a 00                	push   $0x0
  pushl $123
80107481:	6a 7b                	push   $0x7b
  jmp alltraps
80107483:	e9 6f f5 ff ff       	jmp    801069f7 <alltraps>

80107488 <vector124>:
.globl vector124
vector124:
  pushl $0
80107488:	6a 00                	push   $0x0
  pushl $124
8010748a:	6a 7c                	push   $0x7c
  jmp alltraps
8010748c:	e9 66 f5 ff ff       	jmp    801069f7 <alltraps>

80107491 <vector125>:
.globl vector125
vector125:
  pushl $0
80107491:	6a 00                	push   $0x0
  pushl $125
80107493:	6a 7d                	push   $0x7d
  jmp alltraps
80107495:	e9 5d f5 ff ff       	jmp    801069f7 <alltraps>

8010749a <vector126>:
.globl vector126
vector126:
  pushl $0
8010749a:	6a 00                	push   $0x0
  pushl $126
8010749c:	6a 7e                	push   $0x7e
  jmp alltraps
8010749e:	e9 54 f5 ff ff       	jmp    801069f7 <alltraps>

801074a3 <vector127>:
.globl vector127
vector127:
  pushl $0
801074a3:	6a 00                	push   $0x0
  pushl $127
801074a5:	6a 7f                	push   $0x7f
  jmp alltraps
801074a7:	e9 4b f5 ff ff       	jmp    801069f7 <alltraps>

801074ac <vector128>:
.globl vector128
vector128:
  pushl $0
801074ac:	6a 00                	push   $0x0
  pushl $128
801074ae:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801074b3:	e9 3f f5 ff ff       	jmp    801069f7 <alltraps>

801074b8 <vector129>:
.globl vector129
vector129:
  pushl $0
801074b8:	6a 00                	push   $0x0
  pushl $129
801074ba:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801074bf:	e9 33 f5 ff ff       	jmp    801069f7 <alltraps>

801074c4 <vector130>:
.globl vector130
vector130:
  pushl $0
801074c4:	6a 00                	push   $0x0
  pushl $130
801074c6:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801074cb:	e9 27 f5 ff ff       	jmp    801069f7 <alltraps>

801074d0 <vector131>:
.globl vector131
vector131:
  pushl $0
801074d0:	6a 00                	push   $0x0
  pushl $131
801074d2:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801074d7:	e9 1b f5 ff ff       	jmp    801069f7 <alltraps>

801074dc <vector132>:
.globl vector132
vector132:
  pushl $0
801074dc:	6a 00                	push   $0x0
  pushl $132
801074de:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801074e3:	e9 0f f5 ff ff       	jmp    801069f7 <alltraps>

801074e8 <vector133>:
.globl vector133
vector133:
  pushl $0
801074e8:	6a 00                	push   $0x0
  pushl $133
801074ea:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801074ef:	e9 03 f5 ff ff       	jmp    801069f7 <alltraps>

801074f4 <vector134>:
.globl vector134
vector134:
  pushl $0
801074f4:	6a 00                	push   $0x0
  pushl $134
801074f6:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801074fb:	e9 f7 f4 ff ff       	jmp    801069f7 <alltraps>

80107500 <vector135>:
.globl vector135
vector135:
  pushl $0
80107500:	6a 00                	push   $0x0
  pushl $135
80107502:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107507:	e9 eb f4 ff ff       	jmp    801069f7 <alltraps>

8010750c <vector136>:
.globl vector136
vector136:
  pushl $0
8010750c:	6a 00                	push   $0x0
  pushl $136
8010750e:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107513:	e9 df f4 ff ff       	jmp    801069f7 <alltraps>

80107518 <vector137>:
.globl vector137
vector137:
  pushl $0
80107518:	6a 00                	push   $0x0
  pushl $137
8010751a:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010751f:	e9 d3 f4 ff ff       	jmp    801069f7 <alltraps>

80107524 <vector138>:
.globl vector138
vector138:
  pushl $0
80107524:	6a 00                	push   $0x0
  pushl $138
80107526:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
8010752b:	e9 c7 f4 ff ff       	jmp    801069f7 <alltraps>

80107530 <vector139>:
.globl vector139
vector139:
  pushl $0
80107530:	6a 00                	push   $0x0
  pushl $139
80107532:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107537:	e9 bb f4 ff ff       	jmp    801069f7 <alltraps>

8010753c <vector140>:
.globl vector140
vector140:
  pushl $0
8010753c:	6a 00                	push   $0x0
  pushl $140
8010753e:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107543:	e9 af f4 ff ff       	jmp    801069f7 <alltraps>

80107548 <vector141>:
.globl vector141
vector141:
  pushl $0
80107548:	6a 00                	push   $0x0
  pushl $141
8010754a:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010754f:	e9 a3 f4 ff ff       	jmp    801069f7 <alltraps>

80107554 <vector142>:
.globl vector142
vector142:
  pushl $0
80107554:	6a 00                	push   $0x0
  pushl $142
80107556:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
8010755b:	e9 97 f4 ff ff       	jmp    801069f7 <alltraps>

80107560 <vector143>:
.globl vector143
vector143:
  pushl $0
80107560:	6a 00                	push   $0x0
  pushl $143
80107562:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107567:	e9 8b f4 ff ff       	jmp    801069f7 <alltraps>

8010756c <vector144>:
.globl vector144
vector144:
  pushl $0
8010756c:	6a 00                	push   $0x0
  pushl $144
8010756e:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107573:	e9 7f f4 ff ff       	jmp    801069f7 <alltraps>

80107578 <vector145>:
.globl vector145
vector145:
  pushl $0
80107578:	6a 00                	push   $0x0
  pushl $145
8010757a:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010757f:	e9 73 f4 ff ff       	jmp    801069f7 <alltraps>

80107584 <vector146>:
.globl vector146
vector146:
  pushl $0
80107584:	6a 00                	push   $0x0
  pushl $146
80107586:	68 92 00 00 00       	push   $0x92
  jmp alltraps
8010758b:	e9 67 f4 ff ff       	jmp    801069f7 <alltraps>

80107590 <vector147>:
.globl vector147
vector147:
  pushl $0
80107590:	6a 00                	push   $0x0
  pushl $147
80107592:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107597:	e9 5b f4 ff ff       	jmp    801069f7 <alltraps>

8010759c <vector148>:
.globl vector148
vector148:
  pushl $0
8010759c:	6a 00                	push   $0x0
  pushl $148
8010759e:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801075a3:	e9 4f f4 ff ff       	jmp    801069f7 <alltraps>

801075a8 <vector149>:
.globl vector149
vector149:
  pushl $0
801075a8:	6a 00                	push   $0x0
  pushl $149
801075aa:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801075af:	e9 43 f4 ff ff       	jmp    801069f7 <alltraps>

801075b4 <vector150>:
.globl vector150
vector150:
  pushl $0
801075b4:	6a 00                	push   $0x0
  pushl $150
801075b6:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801075bb:	e9 37 f4 ff ff       	jmp    801069f7 <alltraps>

801075c0 <vector151>:
.globl vector151
vector151:
  pushl $0
801075c0:	6a 00                	push   $0x0
  pushl $151
801075c2:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801075c7:	e9 2b f4 ff ff       	jmp    801069f7 <alltraps>

801075cc <vector152>:
.globl vector152
vector152:
  pushl $0
801075cc:	6a 00                	push   $0x0
  pushl $152
801075ce:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801075d3:	e9 1f f4 ff ff       	jmp    801069f7 <alltraps>

801075d8 <vector153>:
.globl vector153
vector153:
  pushl $0
801075d8:	6a 00                	push   $0x0
  pushl $153
801075da:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801075df:	e9 13 f4 ff ff       	jmp    801069f7 <alltraps>

801075e4 <vector154>:
.globl vector154
vector154:
  pushl $0
801075e4:	6a 00                	push   $0x0
  pushl $154
801075e6:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801075eb:	e9 07 f4 ff ff       	jmp    801069f7 <alltraps>

801075f0 <vector155>:
.globl vector155
vector155:
  pushl $0
801075f0:	6a 00                	push   $0x0
  pushl $155
801075f2:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801075f7:	e9 fb f3 ff ff       	jmp    801069f7 <alltraps>

801075fc <vector156>:
.globl vector156
vector156:
  pushl $0
801075fc:	6a 00                	push   $0x0
  pushl $156
801075fe:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107603:	e9 ef f3 ff ff       	jmp    801069f7 <alltraps>

80107608 <vector157>:
.globl vector157
vector157:
  pushl $0
80107608:	6a 00                	push   $0x0
  pushl $157
8010760a:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010760f:	e9 e3 f3 ff ff       	jmp    801069f7 <alltraps>

80107614 <vector158>:
.globl vector158
vector158:
  pushl $0
80107614:	6a 00                	push   $0x0
  pushl $158
80107616:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
8010761b:	e9 d7 f3 ff ff       	jmp    801069f7 <alltraps>

80107620 <vector159>:
.globl vector159
vector159:
  pushl $0
80107620:	6a 00                	push   $0x0
  pushl $159
80107622:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107627:	e9 cb f3 ff ff       	jmp    801069f7 <alltraps>

8010762c <vector160>:
.globl vector160
vector160:
  pushl $0
8010762c:	6a 00                	push   $0x0
  pushl $160
8010762e:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107633:	e9 bf f3 ff ff       	jmp    801069f7 <alltraps>

80107638 <vector161>:
.globl vector161
vector161:
  pushl $0
80107638:	6a 00                	push   $0x0
  pushl $161
8010763a:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010763f:	e9 b3 f3 ff ff       	jmp    801069f7 <alltraps>

80107644 <vector162>:
.globl vector162
vector162:
  pushl $0
80107644:	6a 00                	push   $0x0
  pushl $162
80107646:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
8010764b:	e9 a7 f3 ff ff       	jmp    801069f7 <alltraps>

80107650 <vector163>:
.globl vector163
vector163:
  pushl $0
80107650:	6a 00                	push   $0x0
  pushl $163
80107652:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107657:	e9 9b f3 ff ff       	jmp    801069f7 <alltraps>

8010765c <vector164>:
.globl vector164
vector164:
  pushl $0
8010765c:	6a 00                	push   $0x0
  pushl $164
8010765e:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107663:	e9 8f f3 ff ff       	jmp    801069f7 <alltraps>

80107668 <vector165>:
.globl vector165
vector165:
  pushl $0
80107668:	6a 00                	push   $0x0
  pushl $165
8010766a:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010766f:	e9 83 f3 ff ff       	jmp    801069f7 <alltraps>

80107674 <vector166>:
.globl vector166
vector166:
  pushl $0
80107674:	6a 00                	push   $0x0
  pushl $166
80107676:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
8010767b:	e9 77 f3 ff ff       	jmp    801069f7 <alltraps>

80107680 <vector167>:
.globl vector167
vector167:
  pushl $0
80107680:	6a 00                	push   $0x0
  pushl $167
80107682:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107687:	e9 6b f3 ff ff       	jmp    801069f7 <alltraps>

8010768c <vector168>:
.globl vector168
vector168:
  pushl $0
8010768c:	6a 00                	push   $0x0
  pushl $168
8010768e:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107693:	e9 5f f3 ff ff       	jmp    801069f7 <alltraps>

80107698 <vector169>:
.globl vector169
vector169:
  pushl $0
80107698:	6a 00                	push   $0x0
  pushl $169
8010769a:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010769f:	e9 53 f3 ff ff       	jmp    801069f7 <alltraps>

801076a4 <vector170>:
.globl vector170
vector170:
  pushl $0
801076a4:	6a 00                	push   $0x0
  pushl $170
801076a6:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801076ab:	e9 47 f3 ff ff       	jmp    801069f7 <alltraps>

801076b0 <vector171>:
.globl vector171
vector171:
  pushl $0
801076b0:	6a 00                	push   $0x0
  pushl $171
801076b2:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801076b7:	e9 3b f3 ff ff       	jmp    801069f7 <alltraps>

801076bc <vector172>:
.globl vector172
vector172:
  pushl $0
801076bc:	6a 00                	push   $0x0
  pushl $172
801076be:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801076c3:	e9 2f f3 ff ff       	jmp    801069f7 <alltraps>

801076c8 <vector173>:
.globl vector173
vector173:
  pushl $0
801076c8:	6a 00                	push   $0x0
  pushl $173
801076ca:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801076cf:	e9 23 f3 ff ff       	jmp    801069f7 <alltraps>

801076d4 <vector174>:
.globl vector174
vector174:
  pushl $0
801076d4:	6a 00                	push   $0x0
  pushl $174
801076d6:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801076db:	e9 17 f3 ff ff       	jmp    801069f7 <alltraps>

801076e0 <vector175>:
.globl vector175
vector175:
  pushl $0
801076e0:	6a 00                	push   $0x0
  pushl $175
801076e2:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801076e7:	e9 0b f3 ff ff       	jmp    801069f7 <alltraps>

801076ec <vector176>:
.globl vector176
vector176:
  pushl $0
801076ec:	6a 00                	push   $0x0
  pushl $176
801076ee:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801076f3:	e9 ff f2 ff ff       	jmp    801069f7 <alltraps>

801076f8 <vector177>:
.globl vector177
vector177:
  pushl $0
801076f8:	6a 00                	push   $0x0
  pushl $177
801076fa:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801076ff:	e9 f3 f2 ff ff       	jmp    801069f7 <alltraps>

80107704 <vector178>:
.globl vector178
vector178:
  pushl $0
80107704:	6a 00                	push   $0x0
  pushl $178
80107706:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
8010770b:	e9 e7 f2 ff ff       	jmp    801069f7 <alltraps>

80107710 <vector179>:
.globl vector179
vector179:
  pushl $0
80107710:	6a 00                	push   $0x0
  pushl $179
80107712:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107717:	e9 db f2 ff ff       	jmp    801069f7 <alltraps>

8010771c <vector180>:
.globl vector180
vector180:
  pushl $0
8010771c:	6a 00                	push   $0x0
  pushl $180
8010771e:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107723:	e9 cf f2 ff ff       	jmp    801069f7 <alltraps>

80107728 <vector181>:
.globl vector181
vector181:
  pushl $0
80107728:	6a 00                	push   $0x0
  pushl $181
8010772a:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010772f:	e9 c3 f2 ff ff       	jmp    801069f7 <alltraps>

80107734 <vector182>:
.globl vector182
vector182:
  pushl $0
80107734:	6a 00                	push   $0x0
  pushl $182
80107736:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
8010773b:	e9 b7 f2 ff ff       	jmp    801069f7 <alltraps>

80107740 <vector183>:
.globl vector183
vector183:
  pushl $0
80107740:	6a 00                	push   $0x0
  pushl $183
80107742:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107747:	e9 ab f2 ff ff       	jmp    801069f7 <alltraps>

8010774c <vector184>:
.globl vector184
vector184:
  pushl $0
8010774c:	6a 00                	push   $0x0
  pushl $184
8010774e:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107753:	e9 9f f2 ff ff       	jmp    801069f7 <alltraps>

80107758 <vector185>:
.globl vector185
vector185:
  pushl $0
80107758:	6a 00                	push   $0x0
  pushl $185
8010775a:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010775f:	e9 93 f2 ff ff       	jmp    801069f7 <alltraps>

80107764 <vector186>:
.globl vector186
vector186:
  pushl $0
80107764:	6a 00                	push   $0x0
  pushl $186
80107766:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
8010776b:	e9 87 f2 ff ff       	jmp    801069f7 <alltraps>

80107770 <vector187>:
.globl vector187
vector187:
  pushl $0
80107770:	6a 00                	push   $0x0
  pushl $187
80107772:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107777:	e9 7b f2 ff ff       	jmp    801069f7 <alltraps>

8010777c <vector188>:
.globl vector188
vector188:
  pushl $0
8010777c:	6a 00                	push   $0x0
  pushl $188
8010777e:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107783:	e9 6f f2 ff ff       	jmp    801069f7 <alltraps>

80107788 <vector189>:
.globl vector189
vector189:
  pushl $0
80107788:	6a 00                	push   $0x0
  pushl $189
8010778a:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010778f:	e9 63 f2 ff ff       	jmp    801069f7 <alltraps>

80107794 <vector190>:
.globl vector190
vector190:
  pushl $0
80107794:	6a 00                	push   $0x0
  pushl $190
80107796:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
8010779b:	e9 57 f2 ff ff       	jmp    801069f7 <alltraps>

801077a0 <vector191>:
.globl vector191
vector191:
  pushl $0
801077a0:	6a 00                	push   $0x0
  pushl $191
801077a2:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801077a7:	e9 4b f2 ff ff       	jmp    801069f7 <alltraps>

801077ac <vector192>:
.globl vector192
vector192:
  pushl $0
801077ac:	6a 00                	push   $0x0
  pushl $192
801077ae:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801077b3:	e9 3f f2 ff ff       	jmp    801069f7 <alltraps>

801077b8 <vector193>:
.globl vector193
vector193:
  pushl $0
801077b8:	6a 00                	push   $0x0
  pushl $193
801077ba:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801077bf:	e9 33 f2 ff ff       	jmp    801069f7 <alltraps>

801077c4 <vector194>:
.globl vector194
vector194:
  pushl $0
801077c4:	6a 00                	push   $0x0
  pushl $194
801077c6:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801077cb:	e9 27 f2 ff ff       	jmp    801069f7 <alltraps>

801077d0 <vector195>:
.globl vector195
vector195:
  pushl $0
801077d0:	6a 00                	push   $0x0
  pushl $195
801077d2:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801077d7:	e9 1b f2 ff ff       	jmp    801069f7 <alltraps>

801077dc <vector196>:
.globl vector196
vector196:
  pushl $0
801077dc:	6a 00                	push   $0x0
  pushl $196
801077de:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801077e3:	e9 0f f2 ff ff       	jmp    801069f7 <alltraps>

801077e8 <vector197>:
.globl vector197
vector197:
  pushl $0
801077e8:	6a 00                	push   $0x0
  pushl $197
801077ea:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801077ef:	e9 03 f2 ff ff       	jmp    801069f7 <alltraps>

801077f4 <vector198>:
.globl vector198
vector198:
  pushl $0
801077f4:	6a 00                	push   $0x0
  pushl $198
801077f6:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801077fb:	e9 f7 f1 ff ff       	jmp    801069f7 <alltraps>

80107800 <vector199>:
.globl vector199
vector199:
  pushl $0
80107800:	6a 00                	push   $0x0
  pushl $199
80107802:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107807:	e9 eb f1 ff ff       	jmp    801069f7 <alltraps>

8010780c <vector200>:
.globl vector200
vector200:
  pushl $0
8010780c:	6a 00                	push   $0x0
  pushl $200
8010780e:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107813:	e9 df f1 ff ff       	jmp    801069f7 <alltraps>

80107818 <vector201>:
.globl vector201
vector201:
  pushl $0
80107818:	6a 00                	push   $0x0
  pushl $201
8010781a:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010781f:	e9 d3 f1 ff ff       	jmp    801069f7 <alltraps>

80107824 <vector202>:
.globl vector202
vector202:
  pushl $0
80107824:	6a 00                	push   $0x0
  pushl $202
80107826:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
8010782b:	e9 c7 f1 ff ff       	jmp    801069f7 <alltraps>

80107830 <vector203>:
.globl vector203
vector203:
  pushl $0
80107830:	6a 00                	push   $0x0
  pushl $203
80107832:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107837:	e9 bb f1 ff ff       	jmp    801069f7 <alltraps>

8010783c <vector204>:
.globl vector204
vector204:
  pushl $0
8010783c:	6a 00                	push   $0x0
  pushl $204
8010783e:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107843:	e9 af f1 ff ff       	jmp    801069f7 <alltraps>

80107848 <vector205>:
.globl vector205
vector205:
  pushl $0
80107848:	6a 00                	push   $0x0
  pushl $205
8010784a:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010784f:	e9 a3 f1 ff ff       	jmp    801069f7 <alltraps>

80107854 <vector206>:
.globl vector206
vector206:
  pushl $0
80107854:	6a 00                	push   $0x0
  pushl $206
80107856:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
8010785b:	e9 97 f1 ff ff       	jmp    801069f7 <alltraps>

80107860 <vector207>:
.globl vector207
vector207:
  pushl $0
80107860:	6a 00                	push   $0x0
  pushl $207
80107862:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107867:	e9 8b f1 ff ff       	jmp    801069f7 <alltraps>

8010786c <vector208>:
.globl vector208
vector208:
  pushl $0
8010786c:	6a 00                	push   $0x0
  pushl $208
8010786e:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107873:	e9 7f f1 ff ff       	jmp    801069f7 <alltraps>

80107878 <vector209>:
.globl vector209
vector209:
  pushl $0
80107878:	6a 00                	push   $0x0
  pushl $209
8010787a:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010787f:	e9 73 f1 ff ff       	jmp    801069f7 <alltraps>

80107884 <vector210>:
.globl vector210
vector210:
  pushl $0
80107884:	6a 00                	push   $0x0
  pushl $210
80107886:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
8010788b:	e9 67 f1 ff ff       	jmp    801069f7 <alltraps>

80107890 <vector211>:
.globl vector211
vector211:
  pushl $0
80107890:	6a 00                	push   $0x0
  pushl $211
80107892:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107897:	e9 5b f1 ff ff       	jmp    801069f7 <alltraps>

8010789c <vector212>:
.globl vector212
vector212:
  pushl $0
8010789c:	6a 00                	push   $0x0
  pushl $212
8010789e:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801078a3:	e9 4f f1 ff ff       	jmp    801069f7 <alltraps>

801078a8 <vector213>:
.globl vector213
vector213:
  pushl $0
801078a8:	6a 00                	push   $0x0
  pushl $213
801078aa:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801078af:	e9 43 f1 ff ff       	jmp    801069f7 <alltraps>

801078b4 <vector214>:
.globl vector214
vector214:
  pushl $0
801078b4:	6a 00                	push   $0x0
  pushl $214
801078b6:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801078bb:	e9 37 f1 ff ff       	jmp    801069f7 <alltraps>

801078c0 <vector215>:
.globl vector215
vector215:
  pushl $0
801078c0:	6a 00                	push   $0x0
  pushl $215
801078c2:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801078c7:	e9 2b f1 ff ff       	jmp    801069f7 <alltraps>

801078cc <vector216>:
.globl vector216
vector216:
  pushl $0
801078cc:	6a 00                	push   $0x0
  pushl $216
801078ce:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801078d3:	e9 1f f1 ff ff       	jmp    801069f7 <alltraps>

801078d8 <vector217>:
.globl vector217
vector217:
  pushl $0
801078d8:	6a 00                	push   $0x0
  pushl $217
801078da:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801078df:	e9 13 f1 ff ff       	jmp    801069f7 <alltraps>

801078e4 <vector218>:
.globl vector218
vector218:
  pushl $0
801078e4:	6a 00                	push   $0x0
  pushl $218
801078e6:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801078eb:	e9 07 f1 ff ff       	jmp    801069f7 <alltraps>

801078f0 <vector219>:
.globl vector219
vector219:
  pushl $0
801078f0:	6a 00                	push   $0x0
  pushl $219
801078f2:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801078f7:	e9 fb f0 ff ff       	jmp    801069f7 <alltraps>

801078fc <vector220>:
.globl vector220
vector220:
  pushl $0
801078fc:	6a 00                	push   $0x0
  pushl $220
801078fe:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107903:	e9 ef f0 ff ff       	jmp    801069f7 <alltraps>

80107908 <vector221>:
.globl vector221
vector221:
  pushl $0
80107908:	6a 00                	push   $0x0
  pushl $221
8010790a:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010790f:	e9 e3 f0 ff ff       	jmp    801069f7 <alltraps>

80107914 <vector222>:
.globl vector222
vector222:
  pushl $0
80107914:	6a 00                	push   $0x0
  pushl $222
80107916:	68 de 00 00 00       	push   $0xde
  jmp alltraps
8010791b:	e9 d7 f0 ff ff       	jmp    801069f7 <alltraps>

80107920 <vector223>:
.globl vector223
vector223:
  pushl $0
80107920:	6a 00                	push   $0x0
  pushl $223
80107922:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107927:	e9 cb f0 ff ff       	jmp    801069f7 <alltraps>

8010792c <vector224>:
.globl vector224
vector224:
  pushl $0
8010792c:	6a 00                	push   $0x0
  pushl $224
8010792e:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107933:	e9 bf f0 ff ff       	jmp    801069f7 <alltraps>

80107938 <vector225>:
.globl vector225
vector225:
  pushl $0
80107938:	6a 00                	push   $0x0
  pushl $225
8010793a:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010793f:	e9 b3 f0 ff ff       	jmp    801069f7 <alltraps>

80107944 <vector226>:
.globl vector226
vector226:
  pushl $0
80107944:	6a 00                	push   $0x0
  pushl $226
80107946:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
8010794b:	e9 a7 f0 ff ff       	jmp    801069f7 <alltraps>

80107950 <vector227>:
.globl vector227
vector227:
  pushl $0
80107950:	6a 00                	push   $0x0
  pushl $227
80107952:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107957:	e9 9b f0 ff ff       	jmp    801069f7 <alltraps>

8010795c <vector228>:
.globl vector228
vector228:
  pushl $0
8010795c:	6a 00                	push   $0x0
  pushl $228
8010795e:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107963:	e9 8f f0 ff ff       	jmp    801069f7 <alltraps>

80107968 <vector229>:
.globl vector229
vector229:
  pushl $0
80107968:	6a 00                	push   $0x0
  pushl $229
8010796a:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010796f:	e9 83 f0 ff ff       	jmp    801069f7 <alltraps>

80107974 <vector230>:
.globl vector230
vector230:
  pushl $0
80107974:	6a 00                	push   $0x0
  pushl $230
80107976:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
8010797b:	e9 77 f0 ff ff       	jmp    801069f7 <alltraps>

80107980 <vector231>:
.globl vector231
vector231:
  pushl $0
80107980:	6a 00                	push   $0x0
  pushl $231
80107982:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107987:	e9 6b f0 ff ff       	jmp    801069f7 <alltraps>

8010798c <vector232>:
.globl vector232
vector232:
  pushl $0
8010798c:	6a 00                	push   $0x0
  pushl $232
8010798e:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107993:	e9 5f f0 ff ff       	jmp    801069f7 <alltraps>

80107998 <vector233>:
.globl vector233
vector233:
  pushl $0
80107998:	6a 00                	push   $0x0
  pushl $233
8010799a:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010799f:	e9 53 f0 ff ff       	jmp    801069f7 <alltraps>

801079a4 <vector234>:
.globl vector234
vector234:
  pushl $0
801079a4:	6a 00                	push   $0x0
  pushl $234
801079a6:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801079ab:	e9 47 f0 ff ff       	jmp    801069f7 <alltraps>

801079b0 <vector235>:
.globl vector235
vector235:
  pushl $0
801079b0:	6a 00                	push   $0x0
  pushl $235
801079b2:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801079b7:	e9 3b f0 ff ff       	jmp    801069f7 <alltraps>

801079bc <vector236>:
.globl vector236
vector236:
  pushl $0
801079bc:	6a 00                	push   $0x0
  pushl $236
801079be:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801079c3:	e9 2f f0 ff ff       	jmp    801069f7 <alltraps>

801079c8 <vector237>:
.globl vector237
vector237:
  pushl $0
801079c8:	6a 00                	push   $0x0
  pushl $237
801079ca:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801079cf:	e9 23 f0 ff ff       	jmp    801069f7 <alltraps>

801079d4 <vector238>:
.globl vector238
vector238:
  pushl $0
801079d4:	6a 00                	push   $0x0
  pushl $238
801079d6:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801079db:	e9 17 f0 ff ff       	jmp    801069f7 <alltraps>

801079e0 <vector239>:
.globl vector239
vector239:
  pushl $0
801079e0:	6a 00                	push   $0x0
  pushl $239
801079e2:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801079e7:	e9 0b f0 ff ff       	jmp    801069f7 <alltraps>

801079ec <vector240>:
.globl vector240
vector240:
  pushl $0
801079ec:	6a 00                	push   $0x0
  pushl $240
801079ee:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801079f3:	e9 ff ef ff ff       	jmp    801069f7 <alltraps>

801079f8 <vector241>:
.globl vector241
vector241:
  pushl $0
801079f8:	6a 00                	push   $0x0
  pushl $241
801079fa:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801079ff:	e9 f3 ef ff ff       	jmp    801069f7 <alltraps>

80107a04 <vector242>:
.globl vector242
vector242:
  pushl $0
80107a04:	6a 00                	push   $0x0
  pushl $242
80107a06:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107a0b:	e9 e7 ef ff ff       	jmp    801069f7 <alltraps>

80107a10 <vector243>:
.globl vector243
vector243:
  pushl $0
80107a10:	6a 00                	push   $0x0
  pushl $243
80107a12:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107a17:	e9 db ef ff ff       	jmp    801069f7 <alltraps>

80107a1c <vector244>:
.globl vector244
vector244:
  pushl $0
80107a1c:	6a 00                	push   $0x0
  pushl $244
80107a1e:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107a23:	e9 cf ef ff ff       	jmp    801069f7 <alltraps>

80107a28 <vector245>:
.globl vector245
vector245:
  pushl $0
80107a28:	6a 00                	push   $0x0
  pushl $245
80107a2a:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107a2f:	e9 c3 ef ff ff       	jmp    801069f7 <alltraps>

80107a34 <vector246>:
.globl vector246
vector246:
  pushl $0
80107a34:	6a 00                	push   $0x0
  pushl $246
80107a36:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107a3b:	e9 b7 ef ff ff       	jmp    801069f7 <alltraps>

80107a40 <vector247>:
.globl vector247
vector247:
  pushl $0
80107a40:	6a 00                	push   $0x0
  pushl $247
80107a42:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107a47:	e9 ab ef ff ff       	jmp    801069f7 <alltraps>

80107a4c <vector248>:
.globl vector248
vector248:
  pushl $0
80107a4c:	6a 00                	push   $0x0
  pushl $248
80107a4e:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107a53:	e9 9f ef ff ff       	jmp    801069f7 <alltraps>

80107a58 <vector249>:
.globl vector249
vector249:
  pushl $0
80107a58:	6a 00                	push   $0x0
  pushl $249
80107a5a:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107a5f:	e9 93 ef ff ff       	jmp    801069f7 <alltraps>

80107a64 <vector250>:
.globl vector250
vector250:
  pushl $0
80107a64:	6a 00                	push   $0x0
  pushl $250
80107a66:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107a6b:	e9 87 ef ff ff       	jmp    801069f7 <alltraps>

80107a70 <vector251>:
.globl vector251
vector251:
  pushl $0
80107a70:	6a 00                	push   $0x0
  pushl $251
80107a72:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107a77:	e9 7b ef ff ff       	jmp    801069f7 <alltraps>

80107a7c <vector252>:
.globl vector252
vector252:
  pushl $0
80107a7c:	6a 00                	push   $0x0
  pushl $252
80107a7e:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107a83:	e9 6f ef ff ff       	jmp    801069f7 <alltraps>

80107a88 <vector253>:
.globl vector253
vector253:
  pushl $0
80107a88:	6a 00                	push   $0x0
  pushl $253
80107a8a:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107a8f:	e9 63 ef ff ff       	jmp    801069f7 <alltraps>

80107a94 <vector254>:
.globl vector254
vector254:
  pushl $0
80107a94:	6a 00                	push   $0x0
  pushl $254
80107a96:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107a9b:	e9 57 ef ff ff       	jmp    801069f7 <alltraps>

80107aa0 <vector255>:
.globl vector255
vector255:
  pushl $0
80107aa0:	6a 00                	push   $0x0
  pushl $255
80107aa2:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107aa7:	e9 4b ef ff ff       	jmp    801069f7 <alltraps>

80107aac <lgdt>:
{
80107aac:	55                   	push   %ebp
80107aad:	89 e5                	mov    %esp,%ebp
80107aaf:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80107ab2:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ab5:	83 e8 01             	sub    $0x1,%eax
80107ab8:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107abc:	8b 45 08             	mov    0x8(%ebp),%eax
80107abf:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107ac3:	8b 45 08             	mov    0x8(%ebp),%eax
80107ac6:	c1 e8 10             	shr    $0x10,%eax
80107ac9:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107acd:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107ad0:	0f 01 10             	lgdtl  (%eax)
}
80107ad3:	90                   	nop
80107ad4:	c9                   	leave  
80107ad5:	c3                   	ret    

80107ad6 <ltr>:
{
80107ad6:	55                   	push   %ebp
80107ad7:	89 e5                	mov    %esp,%ebp
80107ad9:	83 ec 04             	sub    $0x4,%esp
80107adc:	8b 45 08             	mov    0x8(%ebp),%eax
80107adf:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107ae3:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107ae7:	0f 00 d8             	ltr    %ax
}
80107aea:	90                   	nop
80107aeb:	c9                   	leave  
80107aec:	c3                   	ret    

80107aed <lcr3>:

static inline void
lcr3(uint val)
{
80107aed:	55                   	push   %ebp
80107aee:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107af0:	8b 45 08             	mov    0x8(%ebp),%eax
80107af3:	0f 22 d8             	mov    %eax,%cr3
}
80107af6:	90                   	nop
80107af7:	5d                   	pop    %ebp
80107af8:	c3                   	ret    

80107af9 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107af9:	f3 0f 1e fb          	endbr32 
80107afd:	55                   	push   %ebp
80107afe:	89 e5                	mov    %esp,%ebp
80107b00:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80107b03:	e8 94 c8 ff ff       	call   8010439c <cpuid>
80107b08:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107b0e:	05 00 38 11 80       	add    $0x80113800,%eax
80107b13:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107b16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b19:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b22:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107b28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b2b:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b32:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107b36:	83 e2 f0             	and    $0xfffffff0,%edx
80107b39:	83 ca 0a             	or     $0xa,%edx
80107b3c:	88 50 7d             	mov    %dl,0x7d(%eax)
80107b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b42:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107b46:	83 ca 10             	or     $0x10,%edx
80107b49:	88 50 7d             	mov    %dl,0x7d(%eax)
80107b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b4f:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107b53:	83 e2 9f             	and    $0xffffff9f,%edx
80107b56:	88 50 7d             	mov    %dl,0x7d(%eax)
80107b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b5c:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107b60:	83 ca 80             	or     $0xffffff80,%edx
80107b63:	88 50 7d             	mov    %dl,0x7d(%eax)
80107b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b69:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107b6d:	83 ca 0f             	or     $0xf,%edx
80107b70:	88 50 7e             	mov    %dl,0x7e(%eax)
80107b73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b76:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107b7a:	83 e2 ef             	and    $0xffffffef,%edx
80107b7d:	88 50 7e             	mov    %dl,0x7e(%eax)
80107b80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b83:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107b87:	83 e2 df             	and    $0xffffffdf,%edx
80107b8a:	88 50 7e             	mov    %dl,0x7e(%eax)
80107b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b90:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107b94:	83 ca 40             	or     $0x40,%edx
80107b97:	88 50 7e             	mov    %dl,0x7e(%eax)
80107b9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b9d:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107ba1:	83 ca 80             	or     $0xffffff80,%edx
80107ba4:	88 50 7e             	mov    %dl,0x7e(%eax)
80107ba7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107baa:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107bae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb1:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107bb8:	ff ff 
80107bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bbd:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107bc4:	00 00 
80107bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc9:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107bd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd3:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107bda:	83 e2 f0             	and    $0xfffffff0,%edx
80107bdd:	83 ca 02             	or     $0x2,%edx
80107be0:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107be6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107be9:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107bf0:	83 ca 10             	or     $0x10,%edx
80107bf3:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107bf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bfc:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107c03:	83 e2 9f             	and    $0xffffff9f,%edx
80107c06:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c0f:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107c16:	83 ca 80             	or     $0xffffff80,%edx
80107c19:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c22:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107c29:	83 ca 0f             	or     $0xf,%edx
80107c2c:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107c32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c35:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107c3c:	83 e2 ef             	and    $0xffffffef,%edx
80107c3f:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107c45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c48:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107c4f:	83 e2 df             	and    $0xffffffdf,%edx
80107c52:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107c58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c5b:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107c62:	83 ca 40             	or     $0x40,%edx
80107c65:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107c6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c6e:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107c75:	83 ca 80             	or     $0xffffff80,%edx
80107c78:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107c7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c81:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107c88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c8b:	66 c7 80 88 00 00 00 	movw   $0xffff,0x88(%eax)
80107c92:	ff ff 
80107c94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c97:	66 c7 80 8a 00 00 00 	movw   $0x0,0x8a(%eax)
80107c9e:	00 00 
80107ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ca3:	c6 80 8c 00 00 00 00 	movb   $0x0,0x8c(%eax)
80107caa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cad:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107cb4:	83 e2 f0             	and    $0xfffffff0,%edx
80107cb7:	83 ca 0a             	or     $0xa,%edx
80107cba:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107cc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cc3:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107cca:	83 ca 10             	or     $0x10,%edx
80107ccd:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cd6:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107cdd:	83 ca 60             	or     $0x60,%edx
80107ce0:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107ce6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ce9:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107cf0:	83 ca 80             	or     $0xffffff80,%edx
80107cf3:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107cf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cfc:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d03:	83 ca 0f             	or     $0xf,%edx
80107d06:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d0f:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d16:	83 e2 ef             	and    $0xffffffef,%edx
80107d19:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d22:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d29:	83 e2 df             	and    $0xffffffdf,%edx
80107d2c:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d35:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d3c:	83 ca 40             	or     $0x40,%edx
80107d3f:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d48:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107d4f:	83 ca 80             	or     $0xffffff80,%edx
80107d52:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107d58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d5b:	c6 80 8f 00 00 00 00 	movb   $0x0,0x8f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107d62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d65:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107d6c:	ff ff 
80107d6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d71:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107d78:	00 00 
80107d7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d7d:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107d84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d87:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107d8e:	83 e2 f0             	and    $0xfffffff0,%edx
80107d91:	83 ca 02             	or     $0x2,%edx
80107d94:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107d9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d9d:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107da4:	83 ca 10             	or     $0x10,%edx
80107da7:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107dad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107db0:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107db7:	83 ca 60             	or     $0x60,%edx
80107dba:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107dc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dc3:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107dca:	83 ca 80             	or     $0xffffff80,%edx
80107dcd:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107dd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dd6:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107ddd:	83 ca 0f             	or     $0xf,%edx
80107de0:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107de9:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107df0:	83 e2 ef             	and    $0xffffffef,%edx
80107df3:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107df9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dfc:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107e03:	83 e2 df             	and    $0xffffffdf,%edx
80107e06:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107e0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e0f:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107e16:	83 ca 40             	or     $0x40,%edx
80107e19:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107e1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e22:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107e29:	83 ca 80             	or     $0xffffff80,%edx
80107e2c:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107e32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e35:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80107e3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e3f:	83 c0 70             	add    $0x70,%eax
80107e42:	83 ec 08             	sub    $0x8,%esp
80107e45:	6a 30                	push   $0x30
80107e47:	50                   	push   %eax
80107e48:	e8 5f fc ff ff       	call   80107aac <lgdt>
80107e4d:	83 c4 10             	add    $0x10,%esp
}
80107e50:	90                   	nop
80107e51:	c9                   	leave  
80107e52:	c3                   	ret    

80107e53 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107e53:	f3 0f 1e fb          	endbr32 
80107e57:	55                   	push   %ebp
80107e58:	89 e5                	mov    %esp,%ebp
80107e5a:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e60:	c1 e8 16             	shr    $0x16,%eax
80107e63:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107e6a:	8b 45 08             	mov    0x8(%ebp),%eax
80107e6d:	01 d0                	add    %edx,%eax
80107e6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107e72:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e75:	8b 00                	mov    (%eax),%eax
80107e77:	83 e0 01             	and    $0x1,%eax
80107e7a:	85 c0                	test   %eax,%eax
80107e7c:	74 14                	je     80107e92 <walkpgdir+0x3f>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107e7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e81:	8b 00                	mov    (%eax),%eax
80107e83:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e88:	05 00 00 00 80       	add    $0x80000000,%eax
80107e8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107e90:	eb 42                	jmp    80107ed4 <walkpgdir+0x81>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107e92:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107e96:	74 0e                	je     80107ea6 <walkpgdir+0x53>
80107e98:	e8 fc ae ff ff       	call   80102d99 <kalloc>
80107e9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107ea0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107ea4:	75 07                	jne    80107ead <walkpgdir+0x5a>
      return 0;
80107ea6:	b8 00 00 00 00       	mov    $0x0,%eax
80107eab:	eb 3e                	jmp    80107eeb <walkpgdir+0x98>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107ead:	83 ec 04             	sub    $0x4,%esp
80107eb0:	68 00 10 00 00       	push   $0x1000
80107eb5:	6a 00                	push   $0x0
80107eb7:	ff 75 f4             	pushl  -0xc(%ebp)
80107eba:	e8 9e d6 ff ff       	call   8010555d <memset>
80107ebf:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107ec2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ec5:	05 00 00 00 80       	add    $0x80000000,%eax
80107eca:	83 c8 07             	or     $0x7,%eax
80107ecd:	89 c2                	mov    %eax,%edx
80107ecf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ed2:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107ed4:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ed7:	c1 e8 0c             	shr    $0xc,%eax
80107eda:	25 ff 03 00 00       	and    $0x3ff,%eax
80107edf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107ee6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ee9:	01 d0                	add    %edx,%eax
}
80107eeb:	c9                   	leave  
80107eec:	c3                   	ret    

80107eed <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107eed:	f3 0f 1e fb          	endbr32 
80107ef1:	55                   	push   %ebp
80107ef2:	89 e5                	mov    %esp,%ebp
80107ef4:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107ef7:	8b 45 0c             	mov    0xc(%ebp),%eax
80107efa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107eff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107f02:	8b 55 0c             	mov    0xc(%ebp),%edx
80107f05:	8b 45 10             	mov    0x10(%ebp),%eax
80107f08:	01 d0                	add    %edx,%eax
80107f0a:	83 e8 01             	sub    $0x1,%eax
80107f0d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f12:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107f15:	83 ec 04             	sub    $0x4,%esp
80107f18:	6a 01                	push   $0x1
80107f1a:	ff 75 f4             	pushl  -0xc(%ebp)
80107f1d:	ff 75 08             	pushl  0x8(%ebp)
80107f20:	e8 2e ff ff ff       	call   80107e53 <walkpgdir>
80107f25:	83 c4 10             	add    $0x10,%esp
80107f28:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107f2b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107f2f:	75 07                	jne    80107f38 <mappages+0x4b>
      return -1;
80107f31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107f36:	eb 47                	jmp    80107f7f <mappages+0x92>
    if(*pte & PTE_P)
80107f38:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107f3b:	8b 00                	mov    (%eax),%eax
80107f3d:	83 e0 01             	and    $0x1,%eax
80107f40:	85 c0                	test   %eax,%eax
80107f42:	74 0d                	je     80107f51 <mappages+0x64>
      panic("remap");
80107f44:	83 ec 0c             	sub    $0xc,%esp
80107f47:	68 18 8e 10 80       	push   $0x80108e18
80107f4c:	e8 80 86 ff ff       	call   801005d1 <panic>
    *pte = pa | perm | PTE_P;
80107f51:	8b 45 18             	mov    0x18(%ebp),%eax
80107f54:	0b 45 14             	or     0x14(%ebp),%eax
80107f57:	83 c8 01             	or     $0x1,%eax
80107f5a:	89 c2                	mov    %eax,%edx
80107f5c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107f5f:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107f61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f64:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107f67:	74 10                	je     80107f79 <mappages+0x8c>
      break;
    a += PGSIZE;
80107f69:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107f70:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107f77:	eb 9c                	jmp    80107f15 <mappages+0x28>
      break;
80107f79:	90                   	nop
  }
  return 0;
80107f7a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107f7f:	c9                   	leave  
80107f80:	c3                   	ret    

80107f81 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107f81:	f3 0f 1e fb          	endbr32 
80107f85:	55                   	push   %ebp
80107f86:	89 e5                	mov    %esp,%ebp
80107f88:	53                   	push   %ebx
80107f89:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107f8c:	e8 08 ae ff ff       	call   80102d99 <kalloc>
80107f91:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107f94:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f98:	75 07                	jne    80107fa1 <setupkvm+0x20>
    return 0;
80107f9a:	b8 00 00 00 00       	mov    $0x0,%eax
80107f9f:	eb 78                	jmp    80108019 <setupkvm+0x98>
  memset(pgdir, 0, PGSIZE);
80107fa1:	83 ec 04             	sub    $0x4,%esp
80107fa4:	68 00 10 00 00       	push   $0x1000
80107fa9:	6a 00                	push   $0x0
80107fab:	ff 75 f0             	pushl  -0x10(%ebp)
80107fae:	e8 aa d5 ff ff       	call   8010555d <memset>
80107fb3:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107fb6:	c7 45 f4 80 b4 10 80 	movl   $0x8010b480,-0xc(%ebp)
80107fbd:	eb 4e                	jmp    8010800d <setupkvm+0x8c>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107fbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fc2:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0) {
80107fc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fc8:	8b 50 04             	mov    0x4(%eax),%edx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107fcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fce:	8b 58 08             	mov    0x8(%eax),%ebx
80107fd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fd4:	8b 40 04             	mov    0x4(%eax),%eax
80107fd7:	29 c3                	sub    %eax,%ebx
80107fd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fdc:	8b 00                	mov    (%eax),%eax
80107fde:	83 ec 0c             	sub    $0xc,%esp
80107fe1:	51                   	push   %ecx
80107fe2:	52                   	push   %edx
80107fe3:	53                   	push   %ebx
80107fe4:	50                   	push   %eax
80107fe5:	ff 75 f0             	pushl  -0x10(%ebp)
80107fe8:	e8 00 ff ff ff       	call   80107eed <mappages>
80107fed:	83 c4 20             	add    $0x20,%esp
80107ff0:	85 c0                	test   %eax,%eax
80107ff2:	79 15                	jns    80108009 <setupkvm+0x88>
      freevm(pgdir);
80107ff4:	83 ec 0c             	sub    $0xc,%esp
80107ff7:	ff 75 f0             	pushl  -0x10(%ebp)
80107ffa:	e8 11 05 00 00       	call   80108510 <freevm>
80107fff:	83 c4 10             	add    $0x10,%esp
      return 0;
80108002:	b8 00 00 00 00       	mov    $0x0,%eax
80108007:	eb 10                	jmp    80108019 <setupkvm+0x98>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108009:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010800d:	81 7d f4 c0 b4 10 80 	cmpl   $0x8010b4c0,-0xc(%ebp)
80108014:	72 a9                	jb     80107fbf <setupkvm+0x3e>
    }
  return pgdir;
80108016:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80108019:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010801c:	c9                   	leave  
8010801d:	c3                   	ret    

8010801e <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
8010801e:	f3 0f 1e fb          	endbr32 
80108022:	55                   	push   %ebp
80108023:	89 e5                	mov    %esp,%ebp
80108025:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108028:	e8 54 ff ff ff       	call   80107f81 <setupkvm>
8010802d:	a3 24 68 11 80       	mov    %eax,0x80116824
  switchkvm();
80108032:	e8 03 00 00 00       	call   8010803a <switchkvm>
}
80108037:	90                   	nop
80108038:	c9                   	leave  
80108039:	c3                   	ret    

8010803a <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
8010803a:	f3 0f 1e fb          	endbr32 
8010803e:	55                   	push   %ebp
8010803f:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108041:	a1 24 68 11 80       	mov    0x80116824,%eax
80108046:	05 00 00 00 80       	add    $0x80000000,%eax
8010804b:	50                   	push   %eax
8010804c:	e8 9c fa ff ff       	call   80107aed <lcr3>
80108051:	83 c4 04             	add    $0x4,%esp
}
80108054:	90                   	nop
80108055:	c9                   	leave  
80108056:	c3                   	ret    

80108057 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80108057:	f3 0f 1e fb          	endbr32 
8010805b:	55                   	push   %ebp
8010805c:	89 e5                	mov    %esp,%ebp
8010805e:	56                   	push   %esi
8010805f:	53                   	push   %ebx
80108060:	83 ec 10             	sub    $0x10,%esp
  if(p == 0)
80108063:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108067:	75 0d                	jne    80108076 <switchuvm+0x1f>
    panic("switchuvm: no process");
80108069:	83 ec 0c             	sub    $0xc,%esp
8010806c:	68 1e 8e 10 80       	push   $0x80108e1e
80108071:	e8 5b 85 ff ff       	call   801005d1 <panic>
  if(p->kstack == 0)
80108076:	8b 45 08             	mov    0x8(%ebp),%eax
80108079:	8b 40 08             	mov    0x8(%eax),%eax
8010807c:	85 c0                	test   %eax,%eax
8010807e:	75 0d                	jne    8010808d <switchuvm+0x36>
    panic("switchuvm: no kstack");
80108080:	83 ec 0c             	sub    $0xc,%esp
80108083:	68 34 8e 10 80       	push   $0x80108e34
80108088:	e8 44 85 ff ff       	call   801005d1 <panic>
  if(p->pgdir == 0)
8010808d:	8b 45 08             	mov    0x8(%ebp),%eax
80108090:	8b 40 04             	mov    0x4(%eax),%eax
80108093:	85 c0                	test   %eax,%eax
80108095:	75 0d                	jne    801080a4 <switchuvm+0x4d>
    panic("switchuvm: no pgdir");
80108097:	83 ec 0c             	sub    $0xc,%esp
8010809a:	68 49 8e 10 80       	push   $0x80108e49
8010809f:	e8 2d 85 ff ff       	call   801005d1 <panic>

  pushcli();
801080a4:	e8 a1 d3 ff ff       	call   8010544a <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801080a9:	e8 0d c3 ff ff       	call   801043bb <mycpu>
801080ae:	89 c3                	mov    %eax,%ebx
801080b0:	e8 06 c3 ff ff       	call   801043bb <mycpu>
801080b5:	83 c0 08             	add    $0x8,%eax
801080b8:	89 c6                	mov    %eax,%esi
801080ba:	e8 fc c2 ff ff       	call   801043bb <mycpu>
801080bf:	83 c0 08             	add    $0x8,%eax
801080c2:	c1 e8 10             	shr    $0x10,%eax
801080c5:	88 45 f7             	mov    %al,-0x9(%ebp)
801080c8:	e8 ee c2 ff ff       	call   801043bb <mycpu>
801080cd:	83 c0 08             	add    $0x8,%eax
801080d0:	c1 e8 18             	shr    $0x18,%eax
801080d3:	89 c2                	mov    %eax,%edx
801080d5:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
801080dc:	67 00 
801080de:	66 89 b3 9a 00 00 00 	mov    %si,0x9a(%ebx)
801080e5:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
801080e9:	88 83 9c 00 00 00    	mov    %al,0x9c(%ebx)
801080ef:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
801080f6:	83 e0 f0             	and    $0xfffffff0,%eax
801080f9:	83 c8 09             	or     $0x9,%eax
801080fc:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108102:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108109:	83 c8 10             	or     $0x10,%eax
8010810c:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108112:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108119:	83 e0 9f             	and    $0xffffff9f,%eax
8010811c:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108122:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108129:	83 c8 80             	or     $0xffffff80,%eax
8010812c:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108132:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108139:	83 e0 f0             	and    $0xfffffff0,%eax
8010813c:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108142:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108149:	83 e0 ef             	and    $0xffffffef,%eax
8010814c:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108152:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108159:	83 e0 df             	and    $0xffffffdf,%eax
8010815c:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108162:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108169:	83 c8 40             	or     $0x40,%eax
8010816c:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108172:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108179:	83 e0 7f             	and    $0x7f,%eax
8010817c:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108182:	88 93 9f 00 00 00    	mov    %dl,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80108188:	e8 2e c2 ff ff       	call   801043bb <mycpu>
8010818d:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80108194:	83 e2 ef             	and    $0xffffffef,%edx
80108197:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010819d:	e8 19 c2 ff ff       	call   801043bb <mycpu>
801081a2:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801081a8:	8b 45 08             	mov    0x8(%ebp),%eax
801081ab:	8b 40 08             	mov    0x8(%eax),%eax
801081ae:	89 c3                	mov    %eax,%ebx
801081b0:	e8 06 c2 ff ff       	call   801043bb <mycpu>
801081b5:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
801081bb:	89 50 0c             	mov    %edx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801081be:	e8 f8 c1 ff ff       	call   801043bb <mycpu>
801081c3:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  ltr(SEG_TSS << 3);
801081c9:	83 ec 0c             	sub    $0xc,%esp
801081cc:	6a 28                	push   $0x28
801081ce:	e8 03 f9 ff ff       	call   80107ad6 <ltr>
801081d3:	83 c4 10             	add    $0x10,%esp
  lcr3(V2P(p->pgdir));  // switch to process's address space
801081d6:	8b 45 08             	mov    0x8(%ebp),%eax
801081d9:	8b 40 04             	mov    0x4(%eax),%eax
801081dc:	05 00 00 00 80       	add    $0x80000000,%eax
801081e1:	83 ec 0c             	sub    $0xc,%esp
801081e4:	50                   	push   %eax
801081e5:	e8 03 f9 ff ff       	call   80107aed <lcr3>
801081ea:	83 c4 10             	add    $0x10,%esp
  popcli();
801081ed:	e8 a9 d2 ff ff       	call   8010549b <popcli>
}
801081f2:	90                   	nop
801081f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801081f6:	5b                   	pop    %ebx
801081f7:	5e                   	pop    %esi
801081f8:	5d                   	pop    %ebp
801081f9:	c3                   	ret    

801081fa <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801081fa:	f3 0f 1e fb          	endbr32 
801081fe:	55                   	push   %ebp
801081ff:	89 e5                	mov    %esp,%ebp
80108201:	83 ec 18             	sub    $0x18,%esp
  char *mem;

  if(sz >= PGSIZE)
80108204:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
8010820b:	76 0d                	jbe    8010821a <inituvm+0x20>
    panic("inituvm: more than a page");
8010820d:	83 ec 0c             	sub    $0xc,%esp
80108210:	68 5d 8e 10 80       	push   $0x80108e5d
80108215:	e8 b7 83 ff ff       	call   801005d1 <panic>
  mem = kalloc();
8010821a:	e8 7a ab ff ff       	call   80102d99 <kalloc>
8010821f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80108222:	83 ec 04             	sub    $0x4,%esp
80108225:	68 00 10 00 00       	push   $0x1000
8010822a:	6a 00                	push   $0x0
8010822c:	ff 75 f4             	pushl  -0xc(%ebp)
8010822f:	e8 29 d3 ff ff       	call   8010555d <memset>
80108234:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108237:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010823a:	05 00 00 00 80       	add    $0x80000000,%eax
8010823f:	83 ec 0c             	sub    $0xc,%esp
80108242:	6a 06                	push   $0x6
80108244:	50                   	push   %eax
80108245:	68 00 10 00 00       	push   $0x1000
8010824a:	6a 00                	push   $0x0
8010824c:	ff 75 08             	pushl  0x8(%ebp)
8010824f:	e8 99 fc ff ff       	call   80107eed <mappages>
80108254:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80108257:	83 ec 04             	sub    $0x4,%esp
8010825a:	ff 75 10             	pushl  0x10(%ebp)
8010825d:	ff 75 0c             	pushl  0xc(%ebp)
80108260:	ff 75 f4             	pushl  -0xc(%ebp)
80108263:	e8 bc d3 ff ff       	call   80105624 <memmove>
80108268:	83 c4 10             	add    $0x10,%esp
}
8010826b:	90                   	nop
8010826c:	c9                   	leave  
8010826d:	c3                   	ret    

8010826e <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
8010826e:	f3 0f 1e fb          	endbr32 
80108272:	55                   	push   %ebp
80108273:	89 e5                	mov    %esp,%ebp
80108275:	83 ec 18             	sub    $0x18,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80108278:	8b 45 0c             	mov    0xc(%ebp),%eax
8010827b:	25 ff 0f 00 00       	and    $0xfff,%eax
80108280:	85 c0                	test   %eax,%eax
80108282:	74 0d                	je     80108291 <loaduvm+0x23>
    panic("loaduvm: addr must be page aligned");
80108284:	83 ec 0c             	sub    $0xc,%esp
80108287:	68 78 8e 10 80       	push   $0x80108e78
8010828c:	e8 40 83 ff ff       	call   801005d1 <panic>
  for(i = 0; i < sz; i += PGSIZE){
80108291:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108298:	e9 8f 00 00 00       	jmp    8010832c <loaduvm+0xbe>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010829d:	8b 55 0c             	mov    0xc(%ebp),%edx
801082a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082a3:	01 d0                	add    %edx,%eax
801082a5:	83 ec 04             	sub    $0x4,%esp
801082a8:	6a 00                	push   $0x0
801082aa:	50                   	push   %eax
801082ab:	ff 75 08             	pushl  0x8(%ebp)
801082ae:	e8 a0 fb ff ff       	call   80107e53 <walkpgdir>
801082b3:	83 c4 10             	add    $0x10,%esp
801082b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
801082b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801082bd:	75 0d                	jne    801082cc <loaduvm+0x5e>
      panic("loaduvm: address should exist");
801082bf:	83 ec 0c             	sub    $0xc,%esp
801082c2:	68 9b 8e 10 80       	push   $0x80108e9b
801082c7:	e8 05 83 ff ff       	call   801005d1 <panic>
    pa = PTE_ADDR(*pte);
801082cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082cf:	8b 00                	mov    (%eax),%eax
801082d1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082d6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
801082d9:	8b 45 18             	mov    0x18(%ebp),%eax
801082dc:	2b 45 f4             	sub    -0xc(%ebp),%eax
801082df:	3d ff 0f 00 00       	cmp    $0xfff,%eax
801082e4:	77 0b                	ja     801082f1 <loaduvm+0x83>
      n = sz - i;
801082e6:	8b 45 18             	mov    0x18(%ebp),%eax
801082e9:	2b 45 f4             	sub    -0xc(%ebp),%eax
801082ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
801082ef:	eb 07                	jmp    801082f8 <loaduvm+0x8a>
    else
      n = PGSIZE;
801082f1:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801082f8:	8b 55 14             	mov    0x14(%ebp),%edx
801082fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082fe:	01 d0                	add    %edx,%eax
80108300:	8b 55 e8             	mov    -0x18(%ebp),%edx
80108303:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80108309:	ff 75 f0             	pushl  -0x10(%ebp)
8010830c:	50                   	push   %eax
8010830d:	52                   	push   %edx
8010830e:	ff 75 10             	pushl  0x10(%ebp)
80108311:	e8 9b 9c ff ff       	call   80101fb1 <readi>
80108316:	83 c4 10             	add    $0x10,%esp
80108319:	39 45 f0             	cmp    %eax,-0x10(%ebp)
8010831c:	74 07                	je     80108325 <loaduvm+0xb7>
      return -1;
8010831e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108323:	eb 18                	jmp    8010833d <loaduvm+0xcf>
  for(i = 0; i < sz; i += PGSIZE){
80108325:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010832c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010832f:	3b 45 18             	cmp    0x18(%ebp),%eax
80108332:	0f 82 65 ff ff ff    	jb     8010829d <loaduvm+0x2f>
  }
  return 0;
80108338:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010833d:	c9                   	leave  
8010833e:	c3                   	ret    

8010833f <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010833f:	f3 0f 1e fb          	endbr32 
80108343:	55                   	push   %ebp
80108344:	89 e5                	mov    %esp,%ebp
80108346:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80108349:	8b 45 10             	mov    0x10(%ebp),%eax
8010834c:	85 c0                	test   %eax,%eax
8010834e:	79 0a                	jns    8010835a <allocuvm+0x1b>
    return 0;
80108350:	b8 00 00 00 00       	mov    $0x0,%eax
80108355:	e9 ec 00 00 00       	jmp    80108446 <allocuvm+0x107>
  if(newsz < oldsz)
8010835a:	8b 45 10             	mov    0x10(%ebp),%eax
8010835d:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108360:	73 08                	jae    8010836a <allocuvm+0x2b>
    return oldsz;
80108362:	8b 45 0c             	mov    0xc(%ebp),%eax
80108365:	e9 dc 00 00 00       	jmp    80108446 <allocuvm+0x107>

  a = PGROUNDUP(oldsz);
8010836a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010836d:	05 ff 0f 00 00       	add    $0xfff,%eax
80108372:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108377:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
8010837a:	e9 b8 00 00 00       	jmp    80108437 <allocuvm+0xf8>
    mem = kalloc();
8010837f:	e8 15 aa ff ff       	call   80102d99 <kalloc>
80108384:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80108387:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010838b:	75 2e                	jne    801083bb <allocuvm+0x7c>
      cprintf("allocuvm out of memory\n");
8010838d:	83 ec 0c             	sub    $0xc,%esp
80108390:	68 b9 8e 10 80       	push   $0x80108eb9
80108395:	e8 7e 80 ff ff       	call   80100418 <cprintf>
8010839a:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
8010839d:	83 ec 04             	sub    $0x4,%esp
801083a0:	ff 75 0c             	pushl  0xc(%ebp)
801083a3:	ff 75 10             	pushl  0x10(%ebp)
801083a6:	ff 75 08             	pushl  0x8(%ebp)
801083a9:	e8 9a 00 00 00       	call   80108448 <deallocuvm>
801083ae:	83 c4 10             	add    $0x10,%esp
      return 0;
801083b1:	b8 00 00 00 00       	mov    $0x0,%eax
801083b6:	e9 8b 00 00 00       	jmp    80108446 <allocuvm+0x107>
    }
    memset(mem, 0, PGSIZE);
801083bb:	83 ec 04             	sub    $0x4,%esp
801083be:	68 00 10 00 00       	push   $0x1000
801083c3:	6a 00                	push   $0x0
801083c5:	ff 75 f0             	pushl  -0x10(%ebp)
801083c8:	e8 90 d1 ff ff       	call   8010555d <memset>
801083cd:	83 c4 10             	add    $0x10,%esp
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801083d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801083d3:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801083d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083dc:	83 ec 0c             	sub    $0xc,%esp
801083df:	6a 06                	push   $0x6
801083e1:	52                   	push   %edx
801083e2:	68 00 10 00 00       	push   $0x1000
801083e7:	50                   	push   %eax
801083e8:	ff 75 08             	pushl  0x8(%ebp)
801083eb:	e8 fd fa ff ff       	call   80107eed <mappages>
801083f0:	83 c4 20             	add    $0x20,%esp
801083f3:	85 c0                	test   %eax,%eax
801083f5:	79 39                	jns    80108430 <allocuvm+0xf1>
      cprintf("allocuvm out of memory (2)\n");
801083f7:	83 ec 0c             	sub    $0xc,%esp
801083fa:	68 d1 8e 10 80       	push   $0x80108ed1
801083ff:	e8 14 80 ff ff       	call   80100418 <cprintf>
80108404:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80108407:	83 ec 04             	sub    $0x4,%esp
8010840a:	ff 75 0c             	pushl  0xc(%ebp)
8010840d:	ff 75 10             	pushl  0x10(%ebp)
80108410:	ff 75 08             	pushl  0x8(%ebp)
80108413:	e8 30 00 00 00       	call   80108448 <deallocuvm>
80108418:	83 c4 10             	add    $0x10,%esp
      kfree(mem);
8010841b:	83 ec 0c             	sub    $0xc,%esp
8010841e:	ff 75 f0             	pushl  -0x10(%ebp)
80108421:	e8 d5 a8 ff ff       	call   80102cfb <kfree>
80108426:	83 c4 10             	add    $0x10,%esp
      return 0;
80108429:	b8 00 00 00 00       	mov    $0x0,%eax
8010842e:	eb 16                	jmp    80108446 <allocuvm+0x107>
  for(; a < newsz; a += PGSIZE){
80108430:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108437:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010843a:	3b 45 10             	cmp    0x10(%ebp),%eax
8010843d:	0f 82 3c ff ff ff    	jb     8010837f <allocuvm+0x40>
    }
  }
  return newsz;
80108443:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108446:	c9                   	leave  
80108447:	c3                   	ret    

80108448 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108448:	f3 0f 1e fb          	endbr32 
8010844c:	55                   	push   %ebp
8010844d:	89 e5                	mov    %esp,%ebp
8010844f:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108452:	8b 45 10             	mov    0x10(%ebp),%eax
80108455:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108458:	72 08                	jb     80108462 <deallocuvm+0x1a>
    return oldsz;
8010845a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010845d:	e9 ac 00 00 00       	jmp    8010850e <deallocuvm+0xc6>

  a = PGROUNDUP(newsz);
80108462:	8b 45 10             	mov    0x10(%ebp),%eax
80108465:	05 ff 0f 00 00       	add    $0xfff,%eax
8010846a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010846f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108472:	e9 88 00 00 00       	jmp    801084ff <deallocuvm+0xb7>
    pte = walkpgdir(pgdir, (char*)a, 0);
80108477:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010847a:	83 ec 04             	sub    $0x4,%esp
8010847d:	6a 00                	push   $0x0
8010847f:	50                   	push   %eax
80108480:	ff 75 08             	pushl  0x8(%ebp)
80108483:	e8 cb f9 ff ff       	call   80107e53 <walkpgdir>
80108488:	83 c4 10             	add    $0x10,%esp
8010848b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
8010848e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108492:	75 16                	jne    801084aa <deallocuvm+0x62>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80108494:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108497:	c1 e8 16             	shr    $0x16,%eax
8010849a:	83 c0 01             	add    $0x1,%eax
8010849d:	c1 e0 16             	shl    $0x16,%eax
801084a0:	2d 00 10 00 00       	sub    $0x1000,%eax
801084a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801084a8:	eb 4e                	jmp    801084f8 <deallocuvm+0xb0>
    else if((*pte & PTE_P) != 0){
801084aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801084ad:	8b 00                	mov    (%eax),%eax
801084af:	83 e0 01             	and    $0x1,%eax
801084b2:	85 c0                	test   %eax,%eax
801084b4:	74 42                	je     801084f8 <deallocuvm+0xb0>
      pa = PTE_ADDR(*pte);
801084b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801084b9:	8b 00                	mov    (%eax),%eax
801084bb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801084c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
801084c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801084c7:	75 0d                	jne    801084d6 <deallocuvm+0x8e>
        panic("kfree");
801084c9:	83 ec 0c             	sub    $0xc,%esp
801084cc:	68 ed 8e 10 80       	push   $0x80108eed
801084d1:	e8 fb 80 ff ff       	call   801005d1 <panic>
      char *v = P2V(pa);
801084d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801084d9:	05 00 00 00 80       	add    $0x80000000,%eax
801084de:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
801084e1:	83 ec 0c             	sub    $0xc,%esp
801084e4:	ff 75 e8             	pushl  -0x18(%ebp)
801084e7:	e8 0f a8 ff ff       	call   80102cfb <kfree>
801084ec:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
801084ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801084f2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801084f8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801084ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108502:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108505:	0f 82 6c ff ff ff    	jb     80108477 <deallocuvm+0x2f>
    }
  }
  return newsz;
8010850b:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010850e:	c9                   	leave  
8010850f:	c3                   	ret    

80108510 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108510:	f3 0f 1e fb          	endbr32 
80108514:	55                   	push   %ebp
80108515:	89 e5                	mov    %esp,%ebp
80108517:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
8010851a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010851e:	75 0d                	jne    8010852d <freevm+0x1d>
    panic("freevm: no pgdir");
80108520:	83 ec 0c             	sub    $0xc,%esp
80108523:	68 f3 8e 10 80       	push   $0x80108ef3
80108528:	e8 a4 80 ff ff       	call   801005d1 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
8010852d:	83 ec 04             	sub    $0x4,%esp
80108530:	6a 00                	push   $0x0
80108532:	68 00 00 00 80       	push   $0x80000000
80108537:	ff 75 08             	pushl  0x8(%ebp)
8010853a:	e8 09 ff ff ff       	call   80108448 <deallocuvm>
8010853f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108542:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108549:	eb 48                	jmp    80108593 <freevm+0x83>
    if(pgdir[i] & PTE_P){
8010854b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010854e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108555:	8b 45 08             	mov    0x8(%ebp),%eax
80108558:	01 d0                	add    %edx,%eax
8010855a:	8b 00                	mov    (%eax),%eax
8010855c:	83 e0 01             	and    $0x1,%eax
8010855f:	85 c0                	test   %eax,%eax
80108561:	74 2c                	je     8010858f <freevm+0x7f>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108563:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108566:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010856d:	8b 45 08             	mov    0x8(%ebp),%eax
80108570:	01 d0                	add    %edx,%eax
80108572:	8b 00                	mov    (%eax),%eax
80108574:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108579:	05 00 00 00 80       	add    $0x80000000,%eax
8010857e:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80108581:	83 ec 0c             	sub    $0xc,%esp
80108584:	ff 75 f0             	pushl  -0x10(%ebp)
80108587:	e8 6f a7 ff ff       	call   80102cfb <kfree>
8010858c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010858f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108593:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
8010859a:	76 af                	jbe    8010854b <freevm+0x3b>
    }
  }
  kfree((char*)pgdir);
8010859c:	83 ec 0c             	sub    $0xc,%esp
8010859f:	ff 75 08             	pushl  0x8(%ebp)
801085a2:	e8 54 a7 ff ff       	call   80102cfb <kfree>
801085a7:	83 c4 10             	add    $0x10,%esp
}
801085aa:	90                   	nop
801085ab:	c9                   	leave  
801085ac:	c3                   	ret    

801085ad <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801085ad:	f3 0f 1e fb          	endbr32 
801085b1:	55                   	push   %ebp
801085b2:	89 e5                	mov    %esp,%ebp
801085b4:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801085b7:	83 ec 04             	sub    $0x4,%esp
801085ba:	6a 00                	push   $0x0
801085bc:	ff 75 0c             	pushl  0xc(%ebp)
801085bf:	ff 75 08             	pushl  0x8(%ebp)
801085c2:	e8 8c f8 ff ff       	call   80107e53 <walkpgdir>
801085c7:	83 c4 10             	add    $0x10,%esp
801085ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801085cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801085d1:	75 0d                	jne    801085e0 <clearpteu+0x33>
    panic("clearpteu");
801085d3:	83 ec 0c             	sub    $0xc,%esp
801085d6:	68 04 8f 10 80       	push   $0x80108f04
801085db:	e8 f1 7f ff ff       	call   801005d1 <panic>
  *pte &= ~PTE_U;
801085e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085e3:	8b 00                	mov    (%eax),%eax
801085e5:	83 e0 fb             	and    $0xfffffffb,%eax
801085e8:	89 c2                	mov    %eax,%edx
801085ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085ed:	89 10                	mov    %edx,(%eax)
}
801085ef:	90                   	nop
801085f0:	c9                   	leave  
801085f1:	c3                   	ret    

801085f2 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801085f2:	f3 0f 1e fb          	endbr32 
801085f6:	55                   	push   %ebp
801085f7:	89 e5                	mov    %esp,%ebp
801085f9:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801085fc:	e8 80 f9 ff ff       	call   80107f81 <setupkvm>
80108601:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108604:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108608:	75 0a                	jne    80108614 <copyuvm+0x22>
    return 0;
8010860a:	b8 00 00 00 00       	mov    $0x0,%eax
8010860f:	e9 f8 00 00 00       	jmp    8010870c <copyuvm+0x11a>
  for(i = PGSIZE; i < sz; i += PGSIZE){
80108614:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
8010861b:	e9 c7 00 00 00       	jmp    801086e7 <copyuvm+0xf5>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108620:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108623:	83 ec 04             	sub    $0x4,%esp
80108626:	6a 00                	push   $0x0
80108628:	50                   	push   %eax
80108629:	ff 75 08             	pushl  0x8(%ebp)
8010862c:	e8 22 f8 ff ff       	call   80107e53 <walkpgdir>
80108631:	83 c4 10             	add    $0x10,%esp
80108634:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108637:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010863b:	75 0d                	jne    8010864a <copyuvm+0x58>
      panic("copyuvm: pte should exist");
8010863d:	83 ec 0c             	sub    $0xc,%esp
80108640:	68 0e 8f 10 80       	push   $0x80108f0e
80108645:	e8 87 7f ff ff       	call   801005d1 <panic>
    if(!(*pte & PTE_P))
8010864a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010864d:	8b 00                	mov    (%eax),%eax
8010864f:	83 e0 01             	and    $0x1,%eax
80108652:	85 c0                	test   %eax,%eax
80108654:	75 0d                	jne    80108663 <copyuvm+0x71>
      panic("copyuvm: page not present");
80108656:	83 ec 0c             	sub    $0xc,%esp
80108659:	68 28 8f 10 80       	push   $0x80108f28
8010865e:	e8 6e 7f ff ff       	call   801005d1 <panic>
    pa = PTE_ADDR(*pte);
80108663:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108666:	8b 00                	mov    (%eax),%eax
80108668:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010866d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80108670:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108673:	8b 00                	mov    (%eax),%eax
80108675:	25 ff 0f 00 00       	and    $0xfff,%eax
8010867a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010867d:	e8 17 a7 ff ff       	call   80102d99 <kalloc>
80108682:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108685:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80108689:	74 6d                	je     801086f8 <copyuvm+0x106>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
8010868b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010868e:	05 00 00 00 80       	add    $0x80000000,%eax
80108693:	83 ec 04             	sub    $0x4,%esp
80108696:	68 00 10 00 00       	push   $0x1000
8010869b:	50                   	push   %eax
8010869c:	ff 75 e0             	pushl  -0x20(%ebp)
8010869f:	e8 80 cf ff ff       	call   80105624 <memmove>
801086a4:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801086a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801086aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
801086ad:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801086b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086b6:	83 ec 0c             	sub    $0xc,%esp
801086b9:	52                   	push   %edx
801086ba:	51                   	push   %ecx
801086bb:	68 00 10 00 00       	push   $0x1000
801086c0:	50                   	push   %eax
801086c1:	ff 75 f0             	pushl  -0x10(%ebp)
801086c4:	e8 24 f8 ff ff       	call   80107eed <mappages>
801086c9:	83 c4 20             	add    $0x20,%esp
801086cc:	85 c0                	test   %eax,%eax
801086ce:	79 10                	jns    801086e0 <copyuvm+0xee>
      kfree(mem);
801086d0:	83 ec 0c             	sub    $0xc,%esp
801086d3:	ff 75 e0             	pushl  -0x20(%ebp)
801086d6:	e8 20 a6 ff ff       	call   80102cfb <kfree>
801086db:	83 c4 10             	add    $0x10,%esp
      goto bad;
801086de:	eb 19                	jmp    801086f9 <copyuvm+0x107>
  for(i = PGSIZE; i < sz; i += PGSIZE){
801086e0:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801086e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086ea:	3b 45 0c             	cmp    0xc(%ebp),%eax
801086ed:	0f 82 2d ff ff ff    	jb     80108620 <copyuvm+0x2e>
    }
  }
  return d;
801086f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801086f6:	eb 14                	jmp    8010870c <copyuvm+0x11a>
      goto bad;
801086f8:	90                   	nop

bad:
  freevm(d);
801086f9:	83 ec 0c             	sub    $0xc,%esp
801086fc:	ff 75 f0             	pushl  -0x10(%ebp)
801086ff:	e8 0c fe ff ff       	call   80108510 <freevm>
80108704:	83 c4 10             	add    $0x10,%esp
  return 0;
80108707:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010870c:	c9                   	leave  
8010870d:	c3                   	ret    

8010870e <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010870e:	f3 0f 1e fb          	endbr32 
80108712:	55                   	push   %ebp
80108713:	89 e5                	mov    %esp,%ebp
80108715:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108718:	83 ec 04             	sub    $0x4,%esp
8010871b:	6a 00                	push   $0x0
8010871d:	ff 75 0c             	pushl  0xc(%ebp)
80108720:	ff 75 08             	pushl  0x8(%ebp)
80108723:	e8 2b f7 ff ff       	call   80107e53 <walkpgdir>
80108728:	83 c4 10             	add    $0x10,%esp
8010872b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
8010872e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108731:	8b 00                	mov    (%eax),%eax
80108733:	83 e0 01             	and    $0x1,%eax
80108736:	85 c0                	test   %eax,%eax
80108738:	75 07                	jne    80108741 <uva2ka+0x33>
    return 0;
8010873a:	b8 00 00 00 00       	mov    $0x0,%eax
8010873f:	eb 22                	jmp    80108763 <uva2ka+0x55>
  if((*pte & PTE_U) == 0)
80108741:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108744:	8b 00                	mov    (%eax),%eax
80108746:	83 e0 04             	and    $0x4,%eax
80108749:	85 c0                	test   %eax,%eax
8010874b:	75 07                	jne    80108754 <uva2ka+0x46>
    return 0;
8010874d:	b8 00 00 00 00       	mov    $0x0,%eax
80108752:	eb 0f                	jmp    80108763 <uva2ka+0x55>
  return (char*)P2V(PTE_ADDR(*pte));
80108754:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108757:	8b 00                	mov    (%eax),%eax
80108759:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010875e:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108763:	c9                   	leave  
80108764:	c3                   	ret    

80108765 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108765:	f3 0f 1e fb          	endbr32 
80108769:	55                   	push   %ebp
8010876a:	89 e5                	mov    %esp,%ebp
8010876c:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
8010876f:	8b 45 10             	mov    0x10(%ebp),%eax
80108772:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80108775:	eb 7f                	jmp    801087f6 <copyout+0x91>
    va0 = (uint)PGROUNDDOWN(va);
80108777:	8b 45 0c             	mov    0xc(%ebp),%eax
8010877a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010877f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108782:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108785:	83 ec 08             	sub    $0x8,%esp
80108788:	50                   	push   %eax
80108789:	ff 75 08             	pushl  0x8(%ebp)
8010878c:	e8 7d ff ff ff       	call   8010870e <uva2ka>
80108791:	83 c4 10             	add    $0x10,%esp
80108794:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
80108797:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010879b:	75 07                	jne    801087a4 <copyout+0x3f>
      return -1;
8010879d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801087a2:	eb 61                	jmp    80108805 <copyout+0xa0>
    n = PGSIZE - (va - va0);
801087a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801087a7:	2b 45 0c             	sub    0xc(%ebp),%eax
801087aa:	05 00 10 00 00       	add    $0x1000,%eax
801087af:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801087b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801087b5:	3b 45 14             	cmp    0x14(%ebp),%eax
801087b8:	76 06                	jbe    801087c0 <copyout+0x5b>
      n = len;
801087ba:	8b 45 14             	mov    0x14(%ebp),%eax
801087bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801087c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801087c3:	2b 45 ec             	sub    -0x14(%ebp),%eax
801087c6:	89 c2                	mov    %eax,%edx
801087c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
801087cb:	01 d0                	add    %edx,%eax
801087cd:	83 ec 04             	sub    $0x4,%esp
801087d0:	ff 75 f0             	pushl  -0x10(%ebp)
801087d3:	ff 75 f4             	pushl  -0xc(%ebp)
801087d6:	50                   	push   %eax
801087d7:	e8 48 ce ff ff       	call   80105624 <memmove>
801087dc:	83 c4 10             	add    $0x10,%esp
    len -= n;
801087df:	8b 45 f0             	mov    -0x10(%ebp),%eax
801087e2:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
801087e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801087e8:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
801087eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801087ee:	05 00 10 00 00       	add    $0x1000,%eax
801087f3:	89 45 0c             	mov    %eax,0xc(%ebp)
  while(len > 0){
801087f6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801087fa:	0f 85 77 ff ff ff    	jne    80108777 <copyout+0x12>
  }
  return 0;
80108800:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108805:	c9                   	leave  
80108806:	c3                   	ret    
