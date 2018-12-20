
build/stmdriver.elf:     file format elf32-littlearm

Sections:
Idx Name          Size      VMA       LMA       File off  Algn  Flags
  0 .isr_vector   000000c0  08000000  08000000  00008000  2**0  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .text         000019b4  080000c0  080000c0  000080c0  2**2  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .rodata       00000048  08001a74  08001a74  00009a74  2**2  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .init_array   00000008  08001abc  08001abc  00009abc  2**2  CONTENTS, ALLOC, LOAD, DATA
  4 .fini_array   00000004  08001ac4  08001ac4  00009ac4  2**2  CONTENTS, ALLOC, LOAD, DATA
  5 .data         00000430  20000000  08001ac8  00010000  2**3  CONTENTS, ALLOC, LOAD, DATA
  6 .bss          000001b0  20000430  08001ef8  00010430  2**2  ALLOC
  7 ._user_heap_stack 00000600  200005e0  08001ef8  000105e0  2**0  ALLOC
  8 .ARM.attributes 00000028  00000000  00000000  00010430  2**0  CONTENTS, READONLY
  9 .debug_info   00002b74  00000000  00000000  00010458  2**0  CONTENTS, READONLY, DEBUGGING
 10 .debug_abbrev 00000990  00000000  00000000  00012fcc  2**0  CONTENTS, READONLY, DEBUGGING
 11 .debug_aranges 000003e8  00000000  00000000  0001395c  2**0  CONTENTS, READONLY, DEBUGGING
 12 .debug_ranges 00000378  00000000  00000000  00013d44  2**0  CONTENTS, READONLY, DEBUGGING
 13 .debug_line   00001041  00000000  00000000  000140bc  2**0  CONTENTS, READONLY, DEBUGGING
 14 .debug_str    00000e2d  00000000  00000000  000150fd  2**0  CONTENTS, READONLY, DEBUGGING
 15 .comment      00000070  00000000  00000000  00015f2a  2**0  CONTENTS, READONLY
 16 .debug_frame  00000ea8  00000000  00000000  00015f9c  2**2  CONTENTS, READONLY, DEBUGGING

Disassembly of section .text:

080000c0 <__do_global_dtors_aux>:
 80000c0:	b510      	push	{r4, lr}
 80000c2:	4c06      	ldr	r4, [pc, #24]	; (80000dc <__do_global_dtors_aux+0x1c>)
 80000c4:	7823      	ldrb	r3, [r4, #0]
 80000c6:	2b00      	cmp	r3, #0
 80000c8:	d107      	bne.n	80000da <__do_global_dtors_aux+0x1a>
 80000ca:	4b05      	ldr	r3, [pc, #20]	; (80000e0 <__do_global_dtors_aux+0x20>)
 80000cc:	2b00      	cmp	r3, #0
 80000ce:	d002      	beq.n	80000d6 <__do_global_dtors_aux+0x16>
 80000d0:	4804      	ldr	r0, [pc, #16]	; (80000e4 <__do_global_dtors_aux+0x24>)
 80000d2:	e000      	b.n	80000d6 <__do_global_dtors_aux+0x16>
 80000d4:	bf00      	nop
 80000d6:	2301      	movs	r3, #1
 80000d8:	7023      	strb	r3, [r4, #0]
 80000da:	bd10      	pop	{r4, pc}
 80000dc:	20000430 	.word	0x20000430
 80000e0:	00000000 	.word	0x00000000
 80000e4:	08001a5c 	.word	0x08001a5c

080000e8 <frame_dummy>:
 80000e8:	b508      	push	{r3, lr}
 80000ea:	4b08      	ldr	r3, [pc, #32]	; (800010c <frame_dummy+0x24>)
 80000ec:	2b00      	cmp	r3, #0
 80000ee:	d003      	beq.n	80000f8 <frame_dummy+0x10>
 80000f0:	4807      	ldr	r0, [pc, #28]	; (8000110 <frame_dummy+0x28>)
 80000f2:	4908      	ldr	r1, [pc, #32]	; (8000114 <frame_dummy+0x2c>)
 80000f4:	e000      	b.n	80000f8 <frame_dummy+0x10>
 80000f6:	bf00      	nop
 80000f8:	4807      	ldr	r0, [pc, #28]	; (8000118 <frame_dummy+0x30>)
 80000fa:	6803      	ldr	r3, [r0, #0]
 80000fc:	2b00      	cmp	r3, #0
 80000fe:	d003      	beq.n	8000108 <frame_dummy+0x20>
 8000100:	4b06      	ldr	r3, [pc, #24]	; (800011c <frame_dummy+0x34>)
 8000102:	2b00      	cmp	r3, #0
 8000104:	d000      	beq.n	8000108 <frame_dummy+0x20>
 8000106:	4798      	blx	r3
 8000108:	bd08      	pop	{r3, pc}
 800010a:	46c0      	nop			; (mov r8, r8)
 800010c:	00000000 	.word	0x00000000
 8000110:	08001a5c 	.word	0x08001a5c
 8000114:	20000434 	.word	0x20000434
 8000118:	20000430 	.word	0x20000430
 800011c:	00000000 	.word	0x00000000

08000120 <__aeabi_uidiv>:
 8000120:	2900      	cmp	r1, #0
 8000122:	d034      	beq.n	800018e <.udivsi3_skip_div0_test+0x6a>

08000124 <.udivsi3_skip_div0_test>:
 8000124:	2301      	movs	r3, #1
 8000126:	2200      	movs	r2, #0
 8000128:	b410      	push	{r4}
 800012a:	4288      	cmp	r0, r1
 800012c:	d32c      	bcc.n	8000188 <.udivsi3_skip_div0_test+0x64>
 800012e:	2401      	movs	r4, #1
 8000130:	0724      	lsls	r4, r4, #28
 8000132:	42a1      	cmp	r1, r4
 8000134:	d204      	bcs.n	8000140 <.udivsi3_skip_div0_test+0x1c>
 8000136:	4281      	cmp	r1, r0
 8000138:	d202      	bcs.n	8000140 <.udivsi3_skip_div0_test+0x1c>
 800013a:	0109      	lsls	r1, r1, #4
 800013c:	011b      	lsls	r3, r3, #4
 800013e:	e7f8      	b.n	8000132 <.udivsi3_skip_div0_test+0xe>
 8000140:	00e4      	lsls	r4, r4, #3
 8000142:	42a1      	cmp	r1, r4
 8000144:	d204      	bcs.n	8000150 <.udivsi3_skip_div0_test+0x2c>
 8000146:	4281      	cmp	r1, r0
 8000148:	d202      	bcs.n	8000150 <.udivsi3_skip_div0_test+0x2c>
 800014a:	0049      	lsls	r1, r1, #1
 800014c:	005b      	lsls	r3, r3, #1
 800014e:	e7f8      	b.n	8000142 <.udivsi3_skip_div0_test+0x1e>
 8000150:	4288      	cmp	r0, r1
 8000152:	d301      	bcc.n	8000158 <.udivsi3_skip_div0_test+0x34>
 8000154:	1a40      	subs	r0, r0, r1
 8000156:	431a      	orrs	r2, r3
 8000158:	084c      	lsrs	r4, r1, #1
 800015a:	42a0      	cmp	r0, r4
 800015c:	d302      	bcc.n	8000164 <.udivsi3_skip_div0_test+0x40>
 800015e:	1b00      	subs	r0, r0, r4
 8000160:	085c      	lsrs	r4, r3, #1
 8000162:	4322      	orrs	r2, r4
 8000164:	088c      	lsrs	r4, r1, #2
 8000166:	42a0      	cmp	r0, r4
 8000168:	d302      	bcc.n	8000170 <.udivsi3_skip_div0_test+0x4c>
 800016a:	1b00      	subs	r0, r0, r4
 800016c:	089c      	lsrs	r4, r3, #2
 800016e:	4322      	orrs	r2, r4
 8000170:	08cc      	lsrs	r4, r1, #3
 8000172:	42a0      	cmp	r0, r4
 8000174:	d302      	bcc.n	800017c <.udivsi3_skip_div0_test+0x58>
 8000176:	1b00      	subs	r0, r0, r4
 8000178:	08dc      	lsrs	r4, r3, #3
 800017a:	4322      	orrs	r2, r4
 800017c:	2800      	cmp	r0, #0
 800017e:	d003      	beq.n	8000188 <.udivsi3_skip_div0_test+0x64>
 8000180:	091b      	lsrs	r3, r3, #4
 8000182:	d001      	beq.n	8000188 <.udivsi3_skip_div0_test+0x64>
 8000184:	0909      	lsrs	r1, r1, #4
 8000186:	e7e3      	b.n	8000150 <.udivsi3_skip_div0_test+0x2c>
 8000188:	1c10      	adds	r0, r2, #0
 800018a:	bc10      	pop	{r4}
 800018c:	4770      	bx	lr
 800018e:	2800      	cmp	r0, #0
 8000190:	d001      	beq.n	8000196 <.udivsi3_skip_div0_test+0x72>
 8000192:	2000      	movs	r0, #0
 8000194:	43c0      	mvns	r0, r0
 8000196:	b407      	push	{r0, r1, r2}
 8000198:	4802      	ldr	r0, [pc, #8]	; (80001a4 <.udivsi3_skip_div0_test+0x80>)
 800019a:	a102      	add	r1, pc, #8	; (adr r1, 80001a4 <.udivsi3_skip_div0_test+0x80>)
 800019c:	1840      	adds	r0, r0, r1
 800019e:	9002      	str	r0, [sp, #8]
 80001a0:	bd03      	pop	{r0, r1, pc}
 80001a2:	46c0      	nop			; (mov r8, r8)
 80001a4:	00000019 	.word	0x00000019

080001a8 <__aeabi_uidivmod>:
 80001a8:	2900      	cmp	r1, #0
 80001aa:	d0f0      	beq.n	800018e <.udivsi3_skip_div0_test+0x6a>
 80001ac:	b503      	push	{r0, r1, lr}
 80001ae:	f7ff ffb9 	bl	8000124 <.udivsi3_skip_div0_test>
 80001b2:	bc0e      	pop	{r1, r2, r3}
 80001b4:	4342      	muls	r2, r0
 80001b6:	1a89      	subs	r1, r1, r2
 80001b8:	4718      	bx	r3
 80001ba:	46c0      	nop			; (mov r8, r8)

080001bc <__aeabi_idiv0>:
 80001bc:	4770      	bx	lr
 80001be:	46c0      	nop			; (mov r8, r8)

080001c0 <Reset_Handler>:
 80001c0:	480d      	ldr	r0, [pc, #52]	; (80001f8 <LoopForever+0x2>)
 80001c2:	4685      	mov	sp, r0
 80001c4:	480d      	ldr	r0, [pc, #52]	; (80001fc <LoopForever+0x6>)
 80001c6:	490e      	ldr	r1, [pc, #56]	; (8000200 <LoopForever+0xa>)
 80001c8:	4a0e      	ldr	r2, [pc, #56]	; (8000204 <LoopForever+0xe>)
 80001ca:	2300      	movs	r3, #0
 80001cc:	e002      	b.n	80001d4 <LoopCopyDataInit>

080001ce <CopyDataInit>:
 80001ce:	58d4      	ldr	r4, [r2, r3]
 80001d0:	50c4      	str	r4, [r0, r3]
 80001d2:	3304      	adds	r3, #4

080001d4 <LoopCopyDataInit>:
 80001d4:	18c4      	adds	r4, r0, r3
 80001d6:	428c      	cmp	r4, r1
 80001d8:	d3f9      	bcc.n	80001ce <CopyDataInit>
 80001da:	4a0b      	ldr	r2, [pc, #44]	; (8000208 <LoopForever+0x12>)
 80001dc:	4c0b      	ldr	r4, [pc, #44]	; (800020c <LoopForever+0x16>)
 80001de:	2300      	movs	r3, #0
 80001e0:	e001      	b.n	80001e6 <LoopFillZerobss>

080001e2 <FillZerobss>:
 80001e2:	6013      	str	r3, [r2, #0]
 80001e4:	3204      	adds	r2, #4

080001e6 <LoopFillZerobss>:
 80001e6:	42a2      	cmp	r2, r4
 80001e8:	d3fb      	bcc.n	80001e2 <FillZerobss>
 80001ea:	f000 f9d5 	bl	8000598 <SystemInit>
 80001ee:	f001 fb43 	bl	8001878 <__libc_init_array>
 80001f2:	f000 f9ab 	bl	800054c <main>

080001f6 <LoopForever>:
 80001f6:	e7fe      	b.n	80001f6 <LoopForever>
 80001f8:	20002000 	.word	0x20002000
 80001fc:	20000000 	.word	0x20000000
 8000200:	20000430 	.word	0x20000430
 8000204:	08001ac8 	.word	0x08001ac8
 8000208:	20000430 	.word	0x20000430
 800020c:	200005e0 	.word	0x200005e0

08000210 <ADC1_COMP_IRQHandler>:
 8000210:	e7fe      	b.n	8000210 <ADC1_COMP_IRQHandler>
	...

08000214 <NVIC_SetPriority>:
 8000214:	b5b0      	push	{r4, r5, r7, lr}
 8000216:	b082      	sub	sp, #8
 8000218:	af00      	add	r7, sp, #0
 800021a:	1c02      	adds	r2, r0, #0
 800021c:	6039      	str	r1, [r7, #0]
 800021e:	1dfb      	adds	r3, r7, #7
 8000220:	701a      	strb	r2, [r3, #0]
 8000222:	1dfb      	adds	r3, r7, #7
 8000224:	781b      	ldrb	r3, [r3, #0]
 8000226:	2b7f      	cmp	r3, #127	; 0x7f
 8000228:	d932      	bls.n	8000290 <NVIC_SetPriority+0x7c>
 800022a:	4930      	ldr	r1, [pc, #192]	; (80002ec <NVIC_SetPriority+0xd8>)
 800022c:	1dfb      	adds	r3, r7, #7
 800022e:	781b      	ldrb	r3, [r3, #0]
 8000230:	1c1a      	adds	r2, r3, #0
 8000232:	230f      	movs	r3, #15
 8000234:	4013      	ands	r3, r2
 8000236:	3b08      	subs	r3, #8
 8000238:	0898      	lsrs	r0, r3, #2
 800023a:	4a2c      	ldr	r2, [pc, #176]	; (80002ec <NVIC_SetPriority+0xd8>)
 800023c:	1dfb      	adds	r3, r7, #7
 800023e:	781b      	ldrb	r3, [r3, #0]
 8000240:	1c1c      	adds	r4, r3, #0
 8000242:	230f      	movs	r3, #15
 8000244:	4023      	ands	r3, r4
 8000246:	3b08      	subs	r3, #8
 8000248:	089b      	lsrs	r3, r3, #2
 800024a:	3306      	adds	r3, #6
 800024c:	009b      	lsls	r3, r3, #2
 800024e:	18d3      	adds	r3, r2, r3
 8000250:	685b      	ldr	r3, [r3, #4]
 8000252:	1dfa      	adds	r2, r7, #7
 8000254:	7812      	ldrb	r2, [r2, #0]
 8000256:	1c14      	adds	r4, r2, #0
 8000258:	2203      	movs	r2, #3
 800025a:	4022      	ands	r2, r4
 800025c:	00d2      	lsls	r2, r2, #3
 800025e:	24ff      	movs	r4, #255	; 0xff
 8000260:	1c25      	adds	r5, r4, #0
 8000262:	4095      	lsls	r5, r2
 8000264:	1c2a      	adds	r2, r5, #0
 8000266:	43d2      	mvns	r2, r2
 8000268:	401a      	ands	r2, r3
 800026a:	683b      	ldr	r3, [r7, #0]
 800026c:	019c      	lsls	r4, r3, #6
 800026e:	23ff      	movs	r3, #255	; 0xff
 8000270:	401c      	ands	r4, r3
 8000272:	1dfb      	adds	r3, r7, #7
 8000274:	781b      	ldrb	r3, [r3, #0]
 8000276:	1c1d      	adds	r5, r3, #0
 8000278:	2303      	movs	r3, #3
 800027a:	402b      	ands	r3, r5
 800027c:	00db      	lsls	r3, r3, #3
 800027e:	1c25      	adds	r5, r4, #0
 8000280:	409d      	lsls	r5, r3
 8000282:	1c2b      	adds	r3, r5, #0
 8000284:	431a      	orrs	r2, r3
 8000286:	1d83      	adds	r3, r0, #6
 8000288:	009b      	lsls	r3, r3, #2
 800028a:	18cb      	adds	r3, r1, r3
 800028c:	605a      	str	r2, [r3, #4]
 800028e:	e029      	b.n	80002e4 <NVIC_SetPriority+0xd0>
 8000290:	4b17      	ldr	r3, [pc, #92]	; (80002f0 <NVIC_SetPriority+0xdc>)
 8000292:	1dfa      	adds	r2, r7, #7
 8000294:	7812      	ldrb	r2, [r2, #0]
 8000296:	b252      	sxtb	r2, r2
 8000298:	0892      	lsrs	r2, r2, #2
 800029a:	4915      	ldr	r1, [pc, #84]	; (80002f0 <NVIC_SetPriority+0xdc>)
 800029c:	1df8      	adds	r0, r7, #7
 800029e:	7800      	ldrb	r0, [r0, #0]
 80002a0:	b240      	sxtb	r0, r0
 80002a2:	0880      	lsrs	r0, r0, #2
 80002a4:	30c0      	adds	r0, #192	; 0xc0
 80002a6:	0080      	lsls	r0, r0, #2
 80002a8:	5841      	ldr	r1, [r0, r1]
 80002aa:	1df8      	adds	r0, r7, #7
 80002ac:	7800      	ldrb	r0, [r0, #0]
 80002ae:	1c04      	adds	r4, r0, #0
 80002b0:	2003      	movs	r0, #3
 80002b2:	4020      	ands	r0, r4
 80002b4:	00c0      	lsls	r0, r0, #3
 80002b6:	24ff      	movs	r4, #255	; 0xff
 80002b8:	1c25      	adds	r5, r4, #0
 80002ba:	4085      	lsls	r5, r0
 80002bc:	1c28      	adds	r0, r5, #0
 80002be:	43c0      	mvns	r0, r0
 80002c0:	4008      	ands	r0, r1
 80002c2:	6839      	ldr	r1, [r7, #0]
 80002c4:	018c      	lsls	r4, r1, #6
 80002c6:	21ff      	movs	r1, #255	; 0xff
 80002c8:	400c      	ands	r4, r1
 80002ca:	1df9      	adds	r1, r7, #7
 80002cc:	7809      	ldrb	r1, [r1, #0]
 80002ce:	1c0d      	adds	r5, r1, #0
 80002d0:	2103      	movs	r1, #3
 80002d2:	4029      	ands	r1, r5
 80002d4:	00c9      	lsls	r1, r1, #3
 80002d6:	1c25      	adds	r5, r4, #0
 80002d8:	408d      	lsls	r5, r1
 80002da:	1c29      	adds	r1, r5, #0
 80002dc:	4301      	orrs	r1, r0
 80002de:	32c0      	adds	r2, #192	; 0xc0
 80002e0:	0092      	lsls	r2, r2, #2
 80002e2:	50d1      	str	r1, [r2, r3]
 80002e4:	46bd      	mov	sp, r7
 80002e6:	b002      	add	sp, #8
 80002e8:	bdb0      	pop	{r4, r5, r7, pc}
 80002ea:	46c0      	nop			; (mov r8, r8)
 80002ec:	e000ed00 	.word	0xe000ed00
 80002f0:	e000e100 	.word	0xe000e100

080002f4 <SysTick_Config>:
 80002f4:	b580      	push	{r7, lr}
 80002f6:	b082      	sub	sp, #8
 80002f8:	af00      	add	r7, sp, #0
 80002fa:	6078      	str	r0, [r7, #4]
 80002fc:	687b      	ldr	r3, [r7, #4]
 80002fe:	1e5a      	subs	r2, r3, #1
 8000300:	4b0c      	ldr	r3, [pc, #48]	; (8000334 <SysTick_Config+0x40>)
 8000302:	429a      	cmp	r2, r3
 8000304:	d901      	bls.n	800030a <SysTick_Config+0x16>
 8000306:	2301      	movs	r3, #1
 8000308:	e010      	b.n	800032c <SysTick_Config+0x38>
 800030a:	4b0b      	ldr	r3, [pc, #44]	; (8000338 <SysTick_Config+0x44>)
 800030c:	687a      	ldr	r2, [r7, #4]
 800030e:	3a01      	subs	r2, #1
 8000310:	605a      	str	r2, [r3, #4]
 8000312:	2301      	movs	r3, #1
 8000314:	425b      	negs	r3, r3
 8000316:	1c18      	adds	r0, r3, #0
 8000318:	2103      	movs	r1, #3
 800031a:	f7ff ff7b 	bl	8000214 <NVIC_SetPriority>
 800031e:	4b06      	ldr	r3, [pc, #24]	; (8000338 <SysTick_Config+0x44>)
 8000320:	2200      	movs	r2, #0
 8000322:	609a      	str	r2, [r3, #8]
 8000324:	4b04      	ldr	r3, [pc, #16]	; (8000338 <SysTick_Config+0x44>)
 8000326:	2207      	movs	r2, #7
 8000328:	601a      	str	r2, [r3, #0]
 800032a:	2300      	movs	r3, #0
 800032c:	1c18      	adds	r0, r3, #0
 800032e:	46bd      	mov	sp, r7
 8000330:	b002      	add	sp, #8
 8000332:	bd80      	pop	{r7, pc}
 8000334:	00ffffff 	.word	0x00ffffff
 8000338:	e000e010 	.word	0xe000e010

0800033c <LL_RCC_HSI_Enable>:
 800033c:	b580      	push	{r7, lr}
 800033e:	af00      	add	r7, sp, #0
 8000340:	4b03      	ldr	r3, [pc, #12]	; (8000350 <LL_RCC_HSI_Enable+0x14>)
 8000342:	4a03      	ldr	r2, [pc, #12]	; (8000350 <LL_RCC_HSI_Enable+0x14>)
 8000344:	6812      	ldr	r2, [r2, #0]
 8000346:	2101      	movs	r1, #1
 8000348:	430a      	orrs	r2, r1
 800034a:	601a      	str	r2, [r3, #0]
 800034c:	46bd      	mov	sp, r7
 800034e:	bd80      	pop	{r7, pc}
 8000350:	40021000 	.word	0x40021000

08000354 <LL_RCC_HSI_IsReady>:
 8000354:	b580      	push	{r7, lr}
 8000356:	af00      	add	r7, sp, #0
 8000358:	4b04      	ldr	r3, [pc, #16]	; (800036c <LL_RCC_HSI_IsReady+0x18>)
 800035a:	681a      	ldr	r2, [r3, #0]
 800035c:	2302      	movs	r3, #2
 800035e:	4013      	ands	r3, r2
 8000360:	1e5a      	subs	r2, r3, #1
 8000362:	4193      	sbcs	r3, r2
 8000364:	b2db      	uxtb	r3, r3
 8000366:	1c18      	adds	r0, r3, #0
 8000368:	46bd      	mov	sp, r7
 800036a:	bd80      	pop	{r7, pc}
 800036c:	40021000 	.word	0x40021000

08000370 <LL_RCC_SetSysClkSource>:
 8000370:	b580      	push	{r7, lr}
 8000372:	b082      	sub	sp, #8
 8000374:	af00      	add	r7, sp, #0
 8000376:	6078      	str	r0, [r7, #4]
 8000378:	4b06      	ldr	r3, [pc, #24]	; (8000394 <LL_RCC_SetSysClkSource+0x24>)
 800037a:	4a06      	ldr	r2, [pc, #24]	; (8000394 <LL_RCC_SetSysClkSource+0x24>)
 800037c:	6852      	ldr	r2, [r2, #4]
 800037e:	2103      	movs	r1, #3
 8000380:	1c10      	adds	r0, r2, #0
 8000382:	4388      	bics	r0, r1
 8000384:	1c01      	adds	r1, r0, #0
 8000386:	687a      	ldr	r2, [r7, #4]
 8000388:	430a      	orrs	r2, r1
 800038a:	605a      	str	r2, [r3, #4]
 800038c:	46bd      	mov	sp, r7
 800038e:	b002      	add	sp, #8
 8000390:	bd80      	pop	{r7, pc}
 8000392:	46c0      	nop			; (mov r8, r8)
 8000394:	40021000 	.word	0x40021000

08000398 <LL_RCC_GetSysClkSource>:
 8000398:	b580      	push	{r7, lr}
 800039a:	af00      	add	r7, sp, #0
 800039c:	4b03      	ldr	r3, [pc, #12]	; (80003ac <LL_RCC_GetSysClkSource+0x14>)
 800039e:	685a      	ldr	r2, [r3, #4]
 80003a0:	230c      	movs	r3, #12
 80003a2:	4013      	ands	r3, r2
 80003a4:	1c18      	adds	r0, r3, #0
 80003a6:	46bd      	mov	sp, r7
 80003a8:	bd80      	pop	{r7, pc}
 80003aa:	46c0      	nop			; (mov r8, r8)
 80003ac:	40021000 	.word	0x40021000

080003b0 <LL_RCC_SetAHBPrescaler>:
 80003b0:	b580      	push	{r7, lr}
 80003b2:	b082      	sub	sp, #8
 80003b4:	af00      	add	r7, sp, #0
 80003b6:	6078      	str	r0, [r7, #4]
 80003b8:	4b06      	ldr	r3, [pc, #24]	; (80003d4 <LL_RCC_SetAHBPrescaler+0x24>)
 80003ba:	4a06      	ldr	r2, [pc, #24]	; (80003d4 <LL_RCC_SetAHBPrescaler+0x24>)
 80003bc:	6852      	ldr	r2, [r2, #4]
 80003be:	21f0      	movs	r1, #240	; 0xf0
 80003c0:	1c10      	adds	r0, r2, #0
 80003c2:	4388      	bics	r0, r1
 80003c4:	1c01      	adds	r1, r0, #0
 80003c6:	687a      	ldr	r2, [r7, #4]
 80003c8:	430a      	orrs	r2, r1
 80003ca:	605a      	str	r2, [r3, #4]
 80003cc:	46bd      	mov	sp, r7
 80003ce:	b002      	add	sp, #8
 80003d0:	bd80      	pop	{r7, pc}
 80003d2:	46c0      	nop			; (mov r8, r8)
 80003d4:	40021000 	.word	0x40021000

080003d8 <LL_RCC_SetAPB1Prescaler>:
 80003d8:	b580      	push	{r7, lr}
 80003da:	b082      	sub	sp, #8
 80003dc:	af00      	add	r7, sp, #0
 80003de:	6078      	str	r0, [r7, #4]
 80003e0:	4b05      	ldr	r3, [pc, #20]	; (80003f8 <LL_RCC_SetAPB1Prescaler+0x20>)
 80003e2:	4a05      	ldr	r2, [pc, #20]	; (80003f8 <LL_RCC_SetAPB1Prescaler+0x20>)
 80003e4:	6851      	ldr	r1, [r2, #4]
 80003e6:	4a05      	ldr	r2, [pc, #20]	; (80003fc <LL_RCC_SetAPB1Prescaler+0x24>)
 80003e8:	4011      	ands	r1, r2
 80003ea:	687a      	ldr	r2, [r7, #4]
 80003ec:	430a      	orrs	r2, r1
 80003ee:	605a      	str	r2, [r3, #4]
 80003f0:	46bd      	mov	sp, r7
 80003f2:	b002      	add	sp, #8
 80003f4:	bd80      	pop	{r7, pc}
 80003f6:	46c0      	nop			; (mov r8, r8)
 80003f8:	40021000 	.word	0x40021000
 80003fc:	fffff8ff 	.word	0xfffff8ff

08000400 <LL_RCC_PLL_Enable>:
 8000400:	b580      	push	{r7, lr}
 8000402:	af00      	add	r7, sp, #0
 8000404:	4b04      	ldr	r3, [pc, #16]	; (8000418 <LL_RCC_PLL_Enable+0x18>)
 8000406:	4a04      	ldr	r2, [pc, #16]	; (8000418 <LL_RCC_PLL_Enable+0x18>)
 8000408:	6812      	ldr	r2, [r2, #0]
 800040a:	2180      	movs	r1, #128	; 0x80
 800040c:	0449      	lsls	r1, r1, #17
 800040e:	430a      	orrs	r2, r1
 8000410:	601a      	str	r2, [r3, #0]
 8000412:	46bd      	mov	sp, r7
 8000414:	bd80      	pop	{r7, pc}
 8000416:	46c0      	nop			; (mov r8, r8)
 8000418:	40021000 	.word	0x40021000

0800041c <LL_RCC_PLL_IsReady>:
 800041c:	b580      	push	{r7, lr}
 800041e:	af00      	add	r7, sp, #0
 8000420:	4b05      	ldr	r3, [pc, #20]	; (8000438 <LL_RCC_PLL_IsReady+0x1c>)
 8000422:	681a      	ldr	r2, [r3, #0]
 8000424:	2380      	movs	r3, #128	; 0x80
 8000426:	049b      	lsls	r3, r3, #18
 8000428:	4013      	ands	r3, r2
 800042a:	1e5a      	subs	r2, r3, #1
 800042c:	4193      	sbcs	r3, r2
 800042e:	b2db      	uxtb	r3, r3
 8000430:	1c18      	adds	r0, r3, #0
 8000432:	46bd      	mov	sp, r7
 8000434:	bd80      	pop	{r7, pc}
 8000436:	46c0      	nop			; (mov r8, r8)
 8000438:	40021000 	.word	0x40021000

0800043c <LL_RCC_PLL_ConfigDomain_SYS>:
 800043c:	b580      	push	{r7, lr}
 800043e:	b082      	sub	sp, #8
 8000440:	af00      	add	r7, sp, #0
 8000442:	6078      	str	r0, [r7, #4]
 8000444:	6039      	str	r1, [r7, #0]
 8000446:	4b0e      	ldr	r3, [pc, #56]	; (8000480 <LL_RCC_PLL_ConfigDomain_SYS+0x44>)
 8000448:	4a0d      	ldr	r2, [pc, #52]	; (8000480 <LL_RCC_PLL_ConfigDomain_SYS+0x44>)
 800044a:	6851      	ldr	r1, [r2, #4]
 800044c:	4a0d      	ldr	r2, [pc, #52]	; (8000484 <LL_RCC_PLL_ConfigDomain_SYS+0x48>)
 800044e:	4011      	ands	r1, r2
 8000450:	6878      	ldr	r0, [r7, #4]
 8000452:	2280      	movs	r2, #128	; 0x80
 8000454:	0252      	lsls	r2, r2, #9
 8000456:	4010      	ands	r0, r2
 8000458:	683a      	ldr	r2, [r7, #0]
 800045a:	4302      	orrs	r2, r0
 800045c:	430a      	orrs	r2, r1
 800045e:	605a      	str	r2, [r3, #4]
 8000460:	4b07      	ldr	r3, [pc, #28]	; (8000480 <LL_RCC_PLL_ConfigDomain_SYS+0x44>)
 8000462:	4a07      	ldr	r2, [pc, #28]	; (8000480 <LL_RCC_PLL_ConfigDomain_SYS+0x44>)
 8000464:	6ad2      	ldr	r2, [r2, #44]	; 0x2c
 8000466:	210f      	movs	r1, #15
 8000468:	1c10      	adds	r0, r2, #0
 800046a:	4388      	bics	r0, r1
 800046c:	1c01      	adds	r1, r0, #0
 800046e:	6878      	ldr	r0, [r7, #4]
 8000470:	220f      	movs	r2, #15
 8000472:	4002      	ands	r2, r0
 8000474:	430a      	orrs	r2, r1
 8000476:	62da      	str	r2, [r3, #44]	; 0x2c
 8000478:	46bd      	mov	sp, r7
 800047a:	b002      	add	sp, #8
 800047c:	bd80      	pop	{r7, pc}
 800047e:	46c0      	nop			; (mov r8, r8)
 8000480:	40021000 	.word	0x40021000
 8000484:	ffc2ffff 	.word	0xffc2ffff

08000488 <LL_FLASH_SetLatency>:
 8000488:	b580      	push	{r7, lr}
 800048a:	b082      	sub	sp, #8
 800048c:	af00      	add	r7, sp, #0
 800048e:	6078      	str	r0, [r7, #4]
 8000490:	4b06      	ldr	r3, [pc, #24]	; (80004ac <LL_FLASH_SetLatency+0x24>)
 8000492:	4a06      	ldr	r2, [pc, #24]	; (80004ac <LL_FLASH_SetLatency+0x24>)
 8000494:	6812      	ldr	r2, [r2, #0]
 8000496:	2101      	movs	r1, #1
 8000498:	1c10      	adds	r0, r2, #0
 800049a:	4388      	bics	r0, r1
 800049c:	1c01      	adds	r1, r0, #0
 800049e:	687a      	ldr	r2, [r7, #4]
 80004a0:	430a      	orrs	r2, r1
 80004a2:	601a      	str	r2, [r3, #0]
 80004a4:	46bd      	mov	sp, r7
 80004a6:	b002      	add	sp, #8
 80004a8:	bd80      	pop	{r7, pc}
 80004aa:	46c0      	nop			; (mov r8, r8)
 80004ac:	40022000 	.word	0x40022000

080004b0 <rcc_config>:
 80004b0:	b580      	push	{r7, lr}
 80004b2:	af00      	add	r7, sp, #0
 80004b4:	2001      	movs	r0, #1
 80004b6:	f7ff ffe7 	bl	8000488 <LL_FLASH_SetLatency>
 80004ba:	f7ff ff3f 	bl	800033c <LL_RCC_HSI_Enable>
 80004be:	46c0      	nop			; (mov r8, r8)
 80004c0:	f7ff ff48 	bl	8000354 <LL_RCC_HSI_IsReady>
 80004c4:	1c03      	adds	r3, r0, #0
 80004c6:	2b01      	cmp	r3, #1
 80004c8:	d1fa      	bne.n	80004c0 <rcc_config+0x10>
 80004ca:	23a0      	movs	r3, #160	; 0xa0
 80004cc:	039b      	lsls	r3, r3, #14
 80004ce:	2000      	movs	r0, #0
 80004d0:	1c19      	adds	r1, r3, #0
 80004d2:	f7ff ffb3 	bl	800043c <LL_RCC_PLL_ConfigDomain_SYS>
 80004d6:	f7ff ff93 	bl	8000400 <LL_RCC_PLL_Enable>
 80004da:	46c0      	nop			; (mov r8, r8)
 80004dc:	f7ff ff9e 	bl	800041c <LL_RCC_PLL_IsReady>
 80004e0:	1c03      	adds	r3, r0, #0
 80004e2:	2b01      	cmp	r3, #1
 80004e4:	d1fa      	bne.n	80004dc <rcc_config+0x2c>
 80004e6:	2000      	movs	r0, #0
 80004e8:	f7ff ff62 	bl	80003b0 <LL_RCC_SetAHBPrescaler>
 80004ec:	2002      	movs	r0, #2
 80004ee:	f7ff ff3f 	bl	8000370 <LL_RCC_SetSysClkSource>
 80004f2:	46c0      	nop			; (mov r8, r8)
 80004f4:	f7ff ff50 	bl	8000398 <LL_RCC_GetSysClkSource>
 80004f8:	1c03      	adds	r3, r0, #0
 80004fa:	2b08      	cmp	r3, #8
 80004fc:	d1fa      	bne.n	80004f4 <rcc_config+0x44>
 80004fe:	2000      	movs	r0, #0
 8000500:	f7ff ff6a 	bl	80003d8 <LL_RCC_SetAPB1Prescaler>
 8000504:	4b04      	ldr	r3, [pc, #16]	; (8000518 <rcc_config+0x68>)
 8000506:	1c18      	adds	r0, r3, #0
 8000508:	f7ff fef4 	bl	80002f4 <SysTick_Config>
 800050c:	4b03      	ldr	r3, [pc, #12]	; (800051c <rcc_config+0x6c>)
 800050e:	4a04      	ldr	r2, [pc, #16]	; (8000520 <rcc_config+0x70>)
 8000510:	601a      	str	r2, [r3, #0]
 8000512:	46bd      	mov	sp, r7
 8000514:	bd80      	pop	{r7, pc}
 8000516:	46c0      	nop			; (mov r8, r8)
 8000518:	0000bb80 	.word	0x0000bb80
 800051c:	20000000 	.word	0x20000000
 8000520:	02dc6c00 	.word	0x02dc6c00

08000524 <fsm_global_init>:
 8000524:	b580      	push	{r7, lr}
 8000526:	b082      	sub	sp, #8
 8000528:	af00      	add	r7, sp, #0
 800052a:	6078      	str	r0, [r7, #4]
 800052c:	2004      	movs	r0, #4
 800052e:	f000 fd85 	bl	800103c <fsm_set_state>
 8000532:	46c0      	nop			; (mov r8, r8)
 8000534:	46bd      	mov	sp, r7
 8000536:	b002      	add	sp, #8
 8000538:	bd80      	pop	{r7, pc}
 800053a:	46c0      	nop			; (mov r8, r8)

0800053c <fsm_error>:
 800053c:	b580      	push	{r7, lr}
 800053e:	b082      	sub	sp, #8
 8000540:	af00      	add	r7, sp, #0
 8000542:	6078      	str	r0, [r7, #4]
 8000544:	46c0      	nop			; (mov r8, r8)
 8000546:	46bd      	mov	sp, r7
 8000548:	b002      	add	sp, #8
 800054a:	bd80      	pop	{r7, pc}

0800054c <main>:
 800054c:	b580      	push	{r7, lr}
 800054e:	b082      	sub	sp, #8
 8000550:	af00      	add	r7, sp, #0
 8000552:	f7ff ffad 	bl	80004b0 <rcc_config>
 8000556:	1d3b      	adds	r3, r7, #4
 8000558:	1c18      	adds	r0, r3, #0
 800055a:	f001 f867 	bl	800162c <fsm_term_init>
 800055e:	1d3b      	adds	r3, r7, #4
 8000560:	1c18      	adds	r0, r3, #0
 8000562:	f000 fbbd 	bl	8000ce0 <fsm_dynamixel_init>
 8000566:	1d3b      	adds	r3, r7, #4
 8000568:	1c18      	adds	r0, r3, #0
 800056a:	f001 f909 	bl	8001780 <fsm_term_main>
 800056e:	e7fa      	b.n	8000566 <main+0x1a>

08000570 <NMI_Handler>:
 8000570:	b580      	push	{r7, lr}
 8000572:	af00      	add	r7, sp, #0
 8000574:	46bd      	mov	sp, r7
 8000576:	bd80      	pop	{r7, pc}

08000578 <HardFault_Handler>:
 8000578:	b580      	push	{r7, lr}
 800057a:	af00      	add	r7, sp, #0
 800057c:	e7fe      	b.n	800057c <HardFault_Handler+0x4>
 800057e:	46c0      	nop			; (mov r8, r8)

08000580 <SVC_Handler>:
 8000580:	b580      	push	{r7, lr}
 8000582:	af00      	add	r7, sp, #0
 8000584:	46bd      	mov	sp, r7
 8000586:	bd80      	pop	{r7, pc}

08000588 <PendSV_Handler>:
 8000588:	b580      	push	{r7, lr}
 800058a:	af00      	add	r7, sp, #0
 800058c:	46bd      	mov	sp, r7
 800058e:	bd80      	pop	{r7, pc}

08000590 <SysTick_Handler>:
 8000590:	b580      	push	{r7, lr}
 8000592:	af00      	add	r7, sp, #0
 8000594:	46bd      	mov	sp, r7
 8000596:	bd80      	pop	{r7, pc}

08000598 <SystemInit>:
 8000598:	b580      	push	{r7, lr}
 800059a:	af00      	add	r7, sp, #0
 800059c:	4b1a      	ldr	r3, [pc, #104]	; (8000608 <SystemInit+0x70>)
 800059e:	4a1a      	ldr	r2, [pc, #104]	; (8000608 <SystemInit+0x70>)
 80005a0:	6812      	ldr	r2, [r2, #0]
 80005a2:	2101      	movs	r1, #1
 80005a4:	430a      	orrs	r2, r1
 80005a6:	601a      	str	r2, [r3, #0]
 80005a8:	4b17      	ldr	r3, [pc, #92]	; (8000608 <SystemInit+0x70>)
 80005aa:	4a17      	ldr	r2, [pc, #92]	; (8000608 <SystemInit+0x70>)
 80005ac:	6851      	ldr	r1, [r2, #4]
 80005ae:	4a17      	ldr	r2, [pc, #92]	; (800060c <SystemInit+0x74>)
 80005b0:	400a      	ands	r2, r1
 80005b2:	605a      	str	r2, [r3, #4]
 80005b4:	4b14      	ldr	r3, [pc, #80]	; (8000608 <SystemInit+0x70>)
 80005b6:	4a14      	ldr	r2, [pc, #80]	; (8000608 <SystemInit+0x70>)
 80005b8:	6811      	ldr	r1, [r2, #0]
 80005ba:	4a15      	ldr	r2, [pc, #84]	; (8000610 <SystemInit+0x78>)
 80005bc:	400a      	ands	r2, r1
 80005be:	601a      	str	r2, [r3, #0]
 80005c0:	4b11      	ldr	r3, [pc, #68]	; (8000608 <SystemInit+0x70>)
 80005c2:	4a11      	ldr	r2, [pc, #68]	; (8000608 <SystemInit+0x70>)
 80005c4:	6811      	ldr	r1, [r2, #0]
 80005c6:	4a13      	ldr	r2, [pc, #76]	; (8000614 <SystemInit+0x7c>)
 80005c8:	400a      	ands	r2, r1
 80005ca:	601a      	str	r2, [r3, #0]
 80005cc:	4b0e      	ldr	r3, [pc, #56]	; (8000608 <SystemInit+0x70>)
 80005ce:	4a0e      	ldr	r2, [pc, #56]	; (8000608 <SystemInit+0x70>)
 80005d0:	6851      	ldr	r1, [r2, #4]
 80005d2:	4a11      	ldr	r2, [pc, #68]	; (8000618 <SystemInit+0x80>)
 80005d4:	400a      	ands	r2, r1
 80005d6:	605a      	str	r2, [r3, #4]
 80005d8:	4b0b      	ldr	r3, [pc, #44]	; (8000608 <SystemInit+0x70>)
 80005da:	4a0b      	ldr	r2, [pc, #44]	; (8000608 <SystemInit+0x70>)
 80005dc:	6ad2      	ldr	r2, [r2, #44]	; 0x2c
 80005de:	210f      	movs	r1, #15
 80005e0:	438a      	bics	r2, r1
 80005e2:	62da      	str	r2, [r3, #44]	; 0x2c
 80005e4:	4b08      	ldr	r3, [pc, #32]	; (8000608 <SystemInit+0x70>)
 80005e6:	4a08      	ldr	r2, [pc, #32]	; (8000608 <SystemInit+0x70>)
 80005e8:	6b11      	ldr	r1, [r2, #48]	; 0x30
 80005ea:	4a0c      	ldr	r2, [pc, #48]	; (800061c <SystemInit+0x84>)
 80005ec:	400a      	ands	r2, r1
 80005ee:	631a      	str	r2, [r3, #48]	; 0x30
 80005f0:	4b05      	ldr	r3, [pc, #20]	; (8000608 <SystemInit+0x70>)
 80005f2:	4a05      	ldr	r2, [pc, #20]	; (8000608 <SystemInit+0x70>)
 80005f4:	6b52      	ldr	r2, [r2, #52]	; 0x34
 80005f6:	2101      	movs	r1, #1
 80005f8:	438a      	bics	r2, r1
 80005fa:	635a      	str	r2, [r3, #52]	; 0x34
 80005fc:	4b02      	ldr	r3, [pc, #8]	; (8000608 <SystemInit+0x70>)
 80005fe:	2200      	movs	r2, #0
 8000600:	609a      	str	r2, [r3, #8]
 8000602:	46bd      	mov	sp, r7
 8000604:	bd80      	pop	{r7, pc}
 8000606:	46c0      	nop			; (mov r8, r8)
 8000608:	40021000 	.word	0x40021000
 800060c:	f8ffb80c 	.word	0xf8ffb80c
 8000610:	fef6ffff 	.word	0xfef6ffff
 8000614:	fffbffff 	.word	0xfffbffff
 8000618:	ffc0ffff 	.word	0xffc0ffff
 800061c:	fffffeac 	.word	0xfffffeac

08000620 <fsm_coll_avoid_init>:
 8000620:	b580      	push	{r7, lr}
 8000622:	b082      	sub	sp, #8
 8000624:	af00      	add	r7, sp, #0
 8000626:	6078      	str	r0, [r7, #4]
 8000628:	2009      	movs	r0, #9
 800062a:	f000 fcd1 	bl	8000fd0 <fsm_add_shadow_state>
 800062e:	2006      	movs	r0, #6
 8000630:	f000 fd04 	bl	800103c <fsm_set_state>
 8000634:	46c0      	nop			; (mov r8, r8)
 8000636:	46bd      	mov	sp, r7
 8000638:	b002      	add	sp, #8
 800063a:	bd80      	pop	{r7, pc}

0800063c <fsm_coll_avoid_main>:
 800063c:	b580      	push	{r7, lr}
 800063e:	b082      	sub	sp, #8
 8000640:	af00      	add	r7, sp, #0
 8000642:	6078      	str	r0, [r7, #4]
 8000644:	46c0      	nop			; (mov r8, r8)
 8000646:	46bd      	mov	sp, r7
 8000648:	b002      	add	sp, #8
 800064a:	bd80      	pop	{r7, pc}

0800064c <NVIC_EnableIRQ>:
 800064c:	b580      	push	{r7, lr}
 800064e:	b082      	sub	sp, #8
 8000650:	af00      	add	r7, sp, #0
 8000652:	1c02      	adds	r2, r0, #0
 8000654:	1dfb      	adds	r3, r7, #7
 8000656:	701a      	strb	r2, [r3, #0]
 8000658:	4b06      	ldr	r3, [pc, #24]	; (8000674 <NVIC_EnableIRQ+0x28>)
 800065a:	1dfa      	adds	r2, r7, #7
 800065c:	7812      	ldrb	r2, [r2, #0]
 800065e:	1c11      	adds	r1, r2, #0
 8000660:	221f      	movs	r2, #31
 8000662:	400a      	ands	r2, r1
 8000664:	2101      	movs	r1, #1
 8000666:	1c08      	adds	r0, r1, #0
 8000668:	4090      	lsls	r0, r2
 800066a:	1c02      	adds	r2, r0, #0
 800066c:	601a      	str	r2, [r3, #0]
 800066e:	46bd      	mov	sp, r7
 8000670:	b002      	add	sp, #8
 8000672:	bd80      	pop	{r7, pc}
 8000674:	e000e100 	.word	0xe000e100

08000678 <NVIC_SetPriority>:
 8000678:	b5b0      	push	{r4, r5, r7, lr}
 800067a:	b082      	sub	sp, #8
 800067c:	af00      	add	r7, sp, #0
 800067e:	1c02      	adds	r2, r0, #0
 8000680:	6039      	str	r1, [r7, #0]
 8000682:	1dfb      	adds	r3, r7, #7
 8000684:	701a      	strb	r2, [r3, #0]
 8000686:	1dfb      	adds	r3, r7, #7
 8000688:	781b      	ldrb	r3, [r3, #0]
 800068a:	2b7f      	cmp	r3, #127	; 0x7f
 800068c:	d932      	bls.n	80006f4 <NVIC_SetPriority+0x7c>
 800068e:	4930      	ldr	r1, [pc, #192]	; (8000750 <NVIC_SetPriority+0xd8>)
 8000690:	1dfb      	adds	r3, r7, #7
 8000692:	781b      	ldrb	r3, [r3, #0]
 8000694:	1c1a      	adds	r2, r3, #0
 8000696:	230f      	movs	r3, #15
 8000698:	4013      	ands	r3, r2
 800069a:	3b08      	subs	r3, #8
 800069c:	0898      	lsrs	r0, r3, #2
 800069e:	4a2c      	ldr	r2, [pc, #176]	; (8000750 <NVIC_SetPriority+0xd8>)
 80006a0:	1dfb      	adds	r3, r7, #7
 80006a2:	781b      	ldrb	r3, [r3, #0]
 80006a4:	1c1c      	adds	r4, r3, #0
 80006a6:	230f      	movs	r3, #15
 80006a8:	4023      	ands	r3, r4
 80006aa:	3b08      	subs	r3, #8
 80006ac:	089b      	lsrs	r3, r3, #2
 80006ae:	3306      	adds	r3, #6
 80006b0:	009b      	lsls	r3, r3, #2
 80006b2:	18d3      	adds	r3, r2, r3
 80006b4:	685b      	ldr	r3, [r3, #4]
 80006b6:	1dfa      	adds	r2, r7, #7
 80006b8:	7812      	ldrb	r2, [r2, #0]
 80006ba:	1c14      	adds	r4, r2, #0
 80006bc:	2203      	movs	r2, #3
 80006be:	4022      	ands	r2, r4
 80006c0:	00d2      	lsls	r2, r2, #3
 80006c2:	24ff      	movs	r4, #255	; 0xff
 80006c4:	1c25      	adds	r5, r4, #0
 80006c6:	4095      	lsls	r5, r2
 80006c8:	1c2a      	adds	r2, r5, #0
 80006ca:	43d2      	mvns	r2, r2
 80006cc:	401a      	ands	r2, r3
 80006ce:	683b      	ldr	r3, [r7, #0]
 80006d0:	019c      	lsls	r4, r3, #6
 80006d2:	23ff      	movs	r3, #255	; 0xff
 80006d4:	401c      	ands	r4, r3
 80006d6:	1dfb      	adds	r3, r7, #7
 80006d8:	781b      	ldrb	r3, [r3, #0]
 80006da:	1c1d      	adds	r5, r3, #0
 80006dc:	2303      	movs	r3, #3
 80006de:	402b      	ands	r3, r5
 80006e0:	00db      	lsls	r3, r3, #3
 80006e2:	1c25      	adds	r5, r4, #0
 80006e4:	409d      	lsls	r5, r3
 80006e6:	1c2b      	adds	r3, r5, #0
 80006e8:	431a      	orrs	r2, r3
 80006ea:	1d83      	adds	r3, r0, #6
 80006ec:	009b      	lsls	r3, r3, #2
 80006ee:	18cb      	adds	r3, r1, r3
 80006f0:	605a      	str	r2, [r3, #4]
 80006f2:	e029      	b.n	8000748 <NVIC_SetPriority+0xd0>
 80006f4:	4b17      	ldr	r3, [pc, #92]	; (8000754 <NVIC_SetPriority+0xdc>)
 80006f6:	1dfa      	adds	r2, r7, #7
 80006f8:	7812      	ldrb	r2, [r2, #0]
 80006fa:	b252      	sxtb	r2, r2
 80006fc:	0892      	lsrs	r2, r2, #2
 80006fe:	4915      	ldr	r1, [pc, #84]	; (8000754 <NVIC_SetPriority+0xdc>)
 8000700:	1df8      	adds	r0, r7, #7
 8000702:	7800      	ldrb	r0, [r0, #0]
 8000704:	b240      	sxtb	r0, r0
 8000706:	0880      	lsrs	r0, r0, #2
 8000708:	30c0      	adds	r0, #192	; 0xc0
 800070a:	0080      	lsls	r0, r0, #2
 800070c:	5841      	ldr	r1, [r0, r1]
 800070e:	1df8      	adds	r0, r7, #7
 8000710:	7800      	ldrb	r0, [r0, #0]
 8000712:	1c04      	adds	r4, r0, #0
 8000714:	2003      	movs	r0, #3
 8000716:	4020      	ands	r0, r4
 8000718:	00c0      	lsls	r0, r0, #3
 800071a:	24ff      	movs	r4, #255	; 0xff
 800071c:	1c25      	adds	r5, r4, #0
 800071e:	4085      	lsls	r5, r0
 8000720:	1c28      	adds	r0, r5, #0
 8000722:	43c0      	mvns	r0, r0
 8000724:	4008      	ands	r0, r1
 8000726:	6839      	ldr	r1, [r7, #0]
 8000728:	018c      	lsls	r4, r1, #6
 800072a:	21ff      	movs	r1, #255	; 0xff
 800072c:	400c      	ands	r4, r1
 800072e:	1df9      	adds	r1, r7, #7
 8000730:	7809      	ldrb	r1, [r1, #0]
 8000732:	1c0d      	adds	r5, r1, #0
 8000734:	2103      	movs	r1, #3
 8000736:	4029      	ands	r1, r5
 8000738:	00c9      	lsls	r1, r1, #3
 800073a:	1c25      	adds	r5, r4, #0
 800073c:	408d      	lsls	r5, r1
 800073e:	1c29      	adds	r1, r5, #0
 8000740:	4301      	orrs	r1, r0
 8000742:	32c0      	adds	r2, #192	; 0xc0
 8000744:	0092      	lsls	r2, r2, #2
 8000746:	50d1      	str	r1, [r2, r3]
 8000748:	46bd      	mov	sp, r7
 800074a:	b002      	add	sp, #8
 800074c:	bdb0      	pop	{r4, r5, r7, pc}
 800074e:	46c0      	nop			; (mov r8, r8)
 8000750:	e000ed00 	.word	0xe000ed00
 8000754:	e000e100 	.word	0xe000e100

08000758 <LL_GPIO_SetPinMode>:
 8000758:	b580      	push	{r7, lr}
 800075a:	b084      	sub	sp, #16
 800075c:	af00      	add	r7, sp, #0
 800075e:	60f8      	str	r0, [r7, #12]
 8000760:	60b9      	str	r1, [r7, #8]
 8000762:	607a      	str	r2, [r7, #4]
 8000764:	68fb      	ldr	r3, [r7, #12]
 8000766:	6819      	ldr	r1, [r3, #0]
 8000768:	68bb      	ldr	r3, [r7, #8]
 800076a:	68ba      	ldr	r2, [r7, #8]
 800076c:	435a      	muls	r2, r3
 800076e:	1c13      	adds	r3, r2, #0
 8000770:	005b      	lsls	r3, r3, #1
 8000772:	189b      	adds	r3, r3, r2
 8000774:	43db      	mvns	r3, r3
 8000776:	1c1a      	adds	r2, r3, #0
 8000778:	400a      	ands	r2, r1
 800077a:	68bb      	ldr	r3, [r7, #8]
 800077c:	68b9      	ldr	r1, [r7, #8]
 800077e:	434b      	muls	r3, r1
 8000780:	6879      	ldr	r1, [r7, #4]
 8000782:	434b      	muls	r3, r1
 8000784:	431a      	orrs	r2, r3
 8000786:	68fb      	ldr	r3, [r7, #12]
 8000788:	601a      	str	r2, [r3, #0]
 800078a:	46bd      	mov	sp, r7
 800078c:	b004      	add	sp, #16
 800078e:	bd80      	pop	{r7, pc}

08000790 <LL_GPIO_SetPinOutputType>:
 8000790:	b580      	push	{r7, lr}
 8000792:	b084      	sub	sp, #16
 8000794:	af00      	add	r7, sp, #0
 8000796:	60f8      	str	r0, [r7, #12]
 8000798:	60b9      	str	r1, [r7, #8]
 800079a:	607a      	str	r2, [r7, #4]
 800079c:	68fb      	ldr	r3, [r7, #12]
 800079e:	685b      	ldr	r3, [r3, #4]
 80007a0:	68ba      	ldr	r2, [r7, #8]
 80007a2:	43d2      	mvns	r2, r2
 80007a4:	401a      	ands	r2, r3
 80007a6:	68bb      	ldr	r3, [r7, #8]
 80007a8:	6879      	ldr	r1, [r7, #4]
 80007aa:	434b      	muls	r3, r1
 80007ac:	431a      	orrs	r2, r3
 80007ae:	68fb      	ldr	r3, [r7, #12]
 80007b0:	605a      	str	r2, [r3, #4]
 80007b2:	46bd      	mov	sp, r7
 80007b4:	b004      	add	sp, #16
 80007b6:	bd80      	pop	{r7, pc}

080007b8 <LL_GPIO_SetPinSpeed>:
 80007b8:	b580      	push	{r7, lr}
 80007ba:	b084      	sub	sp, #16
 80007bc:	af00      	add	r7, sp, #0
 80007be:	60f8      	str	r0, [r7, #12]
 80007c0:	60b9      	str	r1, [r7, #8]
 80007c2:	607a      	str	r2, [r7, #4]
 80007c4:	68fb      	ldr	r3, [r7, #12]
 80007c6:	6899      	ldr	r1, [r3, #8]
 80007c8:	68bb      	ldr	r3, [r7, #8]
 80007ca:	68ba      	ldr	r2, [r7, #8]
 80007cc:	435a      	muls	r2, r3
 80007ce:	1c13      	adds	r3, r2, #0
 80007d0:	005b      	lsls	r3, r3, #1
 80007d2:	189b      	adds	r3, r3, r2
 80007d4:	43db      	mvns	r3, r3
 80007d6:	1c1a      	adds	r2, r3, #0
 80007d8:	400a      	ands	r2, r1
 80007da:	68bb      	ldr	r3, [r7, #8]
 80007dc:	68b9      	ldr	r1, [r7, #8]
 80007de:	434b      	muls	r3, r1
 80007e0:	6879      	ldr	r1, [r7, #4]
 80007e2:	434b      	muls	r3, r1
 80007e4:	431a      	orrs	r2, r3
 80007e6:	68fb      	ldr	r3, [r7, #12]
 80007e8:	609a      	str	r2, [r3, #8]
 80007ea:	46bd      	mov	sp, r7
 80007ec:	b004      	add	sp, #16
 80007ee:	bd80      	pop	{r7, pc}

080007f0 <LL_GPIO_SetAFPin_8_15>:
 80007f0:	b580      	push	{r7, lr}
 80007f2:	b084      	sub	sp, #16
 80007f4:	af00      	add	r7, sp, #0
 80007f6:	60f8      	str	r0, [r7, #12]
 80007f8:	60b9      	str	r1, [r7, #8]
 80007fa:	607a      	str	r2, [r7, #4]
 80007fc:	68fb      	ldr	r3, [r7, #12]
 80007fe:	6a59      	ldr	r1, [r3, #36]	; 0x24
 8000800:	68bb      	ldr	r3, [r7, #8]
 8000802:	0a1b      	lsrs	r3, r3, #8
 8000804:	68ba      	ldr	r2, [r7, #8]
 8000806:	0a12      	lsrs	r2, r2, #8
 8000808:	4353      	muls	r3, r2
 800080a:	68ba      	ldr	r2, [r7, #8]
 800080c:	0a12      	lsrs	r2, r2, #8
 800080e:	4353      	muls	r3, r2
 8000810:	68ba      	ldr	r2, [r7, #8]
 8000812:	0a12      	lsrs	r2, r2, #8
 8000814:	435a      	muls	r2, r3
 8000816:	1c13      	adds	r3, r2, #0
 8000818:	011b      	lsls	r3, r3, #4
 800081a:	1a9b      	subs	r3, r3, r2
 800081c:	43db      	mvns	r3, r3
 800081e:	1c1a      	adds	r2, r3, #0
 8000820:	400a      	ands	r2, r1
 8000822:	68bb      	ldr	r3, [r7, #8]
 8000824:	0a1b      	lsrs	r3, r3, #8
 8000826:	68b9      	ldr	r1, [r7, #8]
 8000828:	0a09      	lsrs	r1, r1, #8
 800082a:	434b      	muls	r3, r1
 800082c:	68b9      	ldr	r1, [r7, #8]
 800082e:	0a09      	lsrs	r1, r1, #8
 8000830:	434b      	muls	r3, r1
 8000832:	68b9      	ldr	r1, [r7, #8]
 8000834:	0a09      	lsrs	r1, r1, #8
 8000836:	434b      	muls	r3, r1
 8000838:	6879      	ldr	r1, [r7, #4]
 800083a:	434b      	muls	r3, r1
 800083c:	431a      	orrs	r2, r3
 800083e:	68fb      	ldr	r3, [r7, #12]
 8000840:	625a      	str	r2, [r3, #36]	; 0x24
 8000842:	46bd      	mov	sp, r7
 8000844:	b004      	add	sp, #16
 8000846:	bd80      	pop	{r7, pc}

08000848 <LL_AHB1_GRP1_EnableClock>:
 8000848:	b580      	push	{r7, lr}
 800084a:	b084      	sub	sp, #16
 800084c:	af00      	add	r7, sp, #0
 800084e:	6078      	str	r0, [r7, #4]
 8000850:	4b07      	ldr	r3, [pc, #28]	; (8000870 <LL_AHB1_GRP1_EnableClock+0x28>)
 8000852:	4a07      	ldr	r2, [pc, #28]	; (8000870 <LL_AHB1_GRP1_EnableClock+0x28>)
 8000854:	6951      	ldr	r1, [r2, #20]
 8000856:	687a      	ldr	r2, [r7, #4]
 8000858:	430a      	orrs	r2, r1
 800085a:	615a      	str	r2, [r3, #20]
 800085c:	4b04      	ldr	r3, [pc, #16]	; (8000870 <LL_AHB1_GRP1_EnableClock+0x28>)
 800085e:	695b      	ldr	r3, [r3, #20]
 8000860:	687a      	ldr	r2, [r7, #4]
 8000862:	4013      	ands	r3, r2
 8000864:	60fb      	str	r3, [r7, #12]
 8000866:	68fb      	ldr	r3, [r7, #12]
 8000868:	46bd      	mov	sp, r7
 800086a:	b004      	add	sp, #16
 800086c:	bd80      	pop	{r7, pc}
 800086e:	46c0      	nop			; (mov r8, r8)
 8000870:	40021000 	.word	0x40021000

08000874 <LL_APB1_GRP2_EnableClock>:
 8000874:	b580      	push	{r7, lr}
 8000876:	b084      	sub	sp, #16
 8000878:	af00      	add	r7, sp, #0
 800087a:	6078      	str	r0, [r7, #4]
 800087c:	4b07      	ldr	r3, [pc, #28]	; (800089c <LL_APB1_GRP2_EnableClock+0x28>)
 800087e:	4a07      	ldr	r2, [pc, #28]	; (800089c <LL_APB1_GRP2_EnableClock+0x28>)
 8000880:	6991      	ldr	r1, [r2, #24]
 8000882:	687a      	ldr	r2, [r7, #4]
 8000884:	430a      	orrs	r2, r1
 8000886:	619a      	str	r2, [r3, #24]
 8000888:	4b04      	ldr	r3, [pc, #16]	; (800089c <LL_APB1_GRP2_EnableClock+0x28>)
 800088a:	699b      	ldr	r3, [r3, #24]
 800088c:	687a      	ldr	r2, [r7, #4]
 800088e:	4013      	ands	r3, r2
 8000890:	60fb      	str	r3, [r7, #12]
 8000892:	68fb      	ldr	r3, [r7, #12]
 8000894:	46bd      	mov	sp, r7
 8000896:	b004      	add	sp, #16
 8000898:	bd80      	pop	{r7, pc}
 800089a:	46c0      	nop			; (mov r8, r8)
 800089c:	40021000 	.word	0x40021000

080008a0 <LL_USART_Enable>:
 80008a0:	b580      	push	{r7, lr}
 80008a2:	b082      	sub	sp, #8
 80008a4:	af00      	add	r7, sp, #0
 80008a6:	6078      	str	r0, [r7, #4]
 80008a8:	687b      	ldr	r3, [r7, #4]
 80008aa:	681b      	ldr	r3, [r3, #0]
 80008ac:	2201      	movs	r2, #1
 80008ae:	431a      	orrs	r2, r3
 80008b0:	687b      	ldr	r3, [r7, #4]
 80008b2:	601a      	str	r2, [r3, #0]
 80008b4:	46bd      	mov	sp, r7
 80008b6:	b002      	add	sp, #8
 80008b8:	bd80      	pop	{r7, pc}
 80008ba:	46c0      	nop			; (mov r8, r8)

080008bc <LL_USART_EnableDirectionRx>:
 80008bc:	b580      	push	{r7, lr}
 80008be:	b082      	sub	sp, #8
 80008c0:	af00      	add	r7, sp, #0
 80008c2:	6078      	str	r0, [r7, #4]
 80008c4:	687b      	ldr	r3, [r7, #4]
 80008c6:	681b      	ldr	r3, [r3, #0]
 80008c8:	2204      	movs	r2, #4
 80008ca:	431a      	orrs	r2, r3
 80008cc:	687b      	ldr	r3, [r7, #4]
 80008ce:	601a      	str	r2, [r3, #0]
 80008d0:	46bd      	mov	sp, r7
 80008d2:	b002      	add	sp, #8
 80008d4:	bd80      	pop	{r7, pc}
 80008d6:	46c0      	nop			; (mov r8, r8)

080008d8 <LL_USART_EnableDirectionTx>:
 80008d8:	b580      	push	{r7, lr}
 80008da:	b082      	sub	sp, #8
 80008dc:	af00      	add	r7, sp, #0
 80008de:	6078      	str	r0, [r7, #4]
 80008e0:	687b      	ldr	r3, [r7, #4]
 80008e2:	681b      	ldr	r3, [r3, #0]
 80008e4:	2208      	movs	r2, #8
 80008e6:	431a      	orrs	r2, r3
 80008e8:	687b      	ldr	r3, [r7, #4]
 80008ea:	601a      	str	r2, [r3, #0]
 80008ec:	46bd      	mov	sp, r7
 80008ee:	b002      	add	sp, #8
 80008f0:	bd80      	pop	{r7, pc}
 80008f2:	46c0      	nop			; (mov r8, r8)

080008f4 <LL_USART_DisableDirectionTx>:
 80008f4:	b580      	push	{r7, lr}
 80008f6:	b082      	sub	sp, #8
 80008f8:	af00      	add	r7, sp, #0
 80008fa:	6078      	str	r0, [r7, #4]
 80008fc:	687b      	ldr	r3, [r7, #4]
 80008fe:	681b      	ldr	r3, [r3, #0]
 8000900:	2208      	movs	r2, #8
 8000902:	1c19      	adds	r1, r3, #0
 8000904:	4391      	bics	r1, r2
 8000906:	1c0a      	adds	r2, r1, #0
 8000908:	687b      	ldr	r3, [r7, #4]
 800090a:	601a      	str	r2, [r3, #0]
 800090c:	46bd      	mov	sp, r7
 800090e:	b002      	add	sp, #8
 8000910:	bd80      	pop	{r7, pc}
 8000912:	46c0      	nop			; (mov r8, r8)

08000914 <LL_USART_SetParity>:
 8000914:	b580      	push	{r7, lr}
 8000916:	b082      	sub	sp, #8
 8000918:	af00      	add	r7, sp, #0
 800091a:	6078      	str	r0, [r7, #4]
 800091c:	6039      	str	r1, [r7, #0]
 800091e:	687b      	ldr	r3, [r7, #4]
 8000920:	681a      	ldr	r2, [r3, #0]
 8000922:	4b04      	ldr	r3, [pc, #16]	; (8000934 <LL_USART_SetParity+0x20>)
 8000924:	401a      	ands	r2, r3
 8000926:	683b      	ldr	r3, [r7, #0]
 8000928:	431a      	orrs	r2, r3
 800092a:	687b      	ldr	r3, [r7, #4]
 800092c:	601a      	str	r2, [r3, #0]
 800092e:	46bd      	mov	sp, r7
 8000930:	b002      	add	sp, #8
 8000932:	bd80      	pop	{r7, pc}
 8000934:	fffff9ff 	.word	0xfffff9ff

08000938 <LL_USART_SetDataWidth>:
 8000938:	b580      	push	{r7, lr}
 800093a:	b082      	sub	sp, #8
 800093c:	af00      	add	r7, sp, #0
 800093e:	6078      	str	r0, [r7, #4]
 8000940:	6039      	str	r1, [r7, #0]
 8000942:	687b      	ldr	r3, [r7, #4]
 8000944:	681a      	ldr	r2, [r3, #0]
 8000946:	4b04      	ldr	r3, [pc, #16]	; (8000958 <LL_USART_SetDataWidth+0x20>)
 8000948:	401a      	ands	r2, r3
 800094a:	683b      	ldr	r3, [r7, #0]
 800094c:	431a      	orrs	r2, r3
 800094e:	687b      	ldr	r3, [r7, #4]
 8000950:	601a      	str	r2, [r3, #0]
 8000952:	46bd      	mov	sp, r7
 8000954:	b002      	add	sp, #8
 8000956:	bd80      	pop	{r7, pc}
 8000958:	ffffefff 	.word	0xffffefff

0800095c <LL_USART_SetStopBitsLength>:
 800095c:	b580      	push	{r7, lr}
 800095e:	b082      	sub	sp, #8
 8000960:	af00      	add	r7, sp, #0
 8000962:	6078      	str	r0, [r7, #4]
 8000964:	6039      	str	r1, [r7, #0]
 8000966:	687b      	ldr	r3, [r7, #4]
 8000968:	685a      	ldr	r2, [r3, #4]
 800096a:	4b04      	ldr	r3, [pc, #16]	; (800097c <LL_USART_SetStopBitsLength+0x20>)
 800096c:	401a      	ands	r2, r3
 800096e:	683b      	ldr	r3, [r7, #0]
 8000970:	431a      	orrs	r2, r3
 8000972:	687b      	ldr	r3, [r7, #4]
 8000974:	605a      	str	r2, [r3, #4]
 8000976:	46bd      	mov	sp, r7
 8000978:	b002      	add	sp, #8
 800097a:	bd80      	pop	{r7, pc}
 800097c:	ffffcfff 	.word	0xffffcfff

08000980 <LL_USART_SetBaudRate>:
 8000980:	b5b0      	push	{r4, r5, r7, lr}
 8000982:	b084      	sub	sp, #16
 8000984:	af00      	add	r7, sp, #0
 8000986:	60f8      	str	r0, [r7, #12]
 8000988:	60b9      	str	r1, [r7, #8]
 800098a:	607a      	str	r2, [r7, #4]
 800098c:	603b      	str	r3, [r7, #0]
 800098e:	2500      	movs	r5, #0
 8000990:	2400      	movs	r4, #0
 8000992:	687a      	ldr	r2, [r7, #4]
 8000994:	2380      	movs	r3, #128	; 0x80
 8000996:	021b      	lsls	r3, r3, #8
 8000998:	429a      	cmp	r2, r3
 800099a:	d116      	bne.n	80009ca <LL_USART_SetBaudRate+0x4a>
 800099c:	68bb      	ldr	r3, [r7, #8]
 800099e:	005a      	lsls	r2, r3, #1
 80009a0:	683b      	ldr	r3, [r7, #0]
 80009a2:	085b      	lsrs	r3, r3, #1
 80009a4:	18d3      	adds	r3, r2, r3
 80009a6:	1c18      	adds	r0, r3, #0
 80009a8:	6839      	ldr	r1, [r7, #0]
 80009aa:	f7ff fbb9 	bl	8000120 <__aeabi_uidiv>
 80009ae:	1c03      	adds	r3, r0, #0
 80009b0:	b29b      	uxth	r3, r3
 80009b2:	1c1d      	adds	r5, r3, #0
 80009b4:	4b0d      	ldr	r3, [pc, #52]	; (80009ec <LL_USART_SetBaudRate+0x6c>)
 80009b6:	1c2c      	adds	r4, r5, #0
 80009b8:	401c      	ands	r4, r3
 80009ba:	230f      	movs	r3, #15
 80009bc:	402b      	ands	r3, r5
 80009be:	085b      	lsrs	r3, r3, #1
 80009c0:	b29b      	uxth	r3, r3
 80009c2:	431c      	orrs	r4, r3
 80009c4:	68fb      	ldr	r3, [r7, #12]
 80009c6:	60dc      	str	r4, [r3, #12]
 80009c8:	e00c      	b.n	80009e4 <LL_USART_SetBaudRate+0x64>
 80009ca:	683b      	ldr	r3, [r7, #0]
 80009cc:	085a      	lsrs	r2, r3, #1
 80009ce:	68bb      	ldr	r3, [r7, #8]
 80009d0:	18d3      	adds	r3, r2, r3
 80009d2:	1c18      	adds	r0, r3, #0
 80009d4:	6839      	ldr	r1, [r7, #0]
 80009d6:	f7ff fba3 	bl	8000120 <__aeabi_uidiv>
 80009da:	1c03      	adds	r3, r0, #0
 80009dc:	b29b      	uxth	r3, r3
 80009de:	1c1a      	adds	r2, r3, #0
 80009e0:	68fb      	ldr	r3, [r7, #12]
 80009e2:	60da      	str	r2, [r3, #12]
 80009e4:	46bd      	mov	sp, r7
 80009e6:	b004      	add	sp, #16
 80009e8:	bdb0      	pop	{r4, r5, r7, pc}
 80009ea:	46c0      	nop			; (mov r8, r8)
 80009ec:	0000fff0 	.word	0x0000fff0

080009f0 <LL_USART_EnableHalfDuplex>:
 80009f0:	b580      	push	{r7, lr}
 80009f2:	b082      	sub	sp, #8
 80009f4:	af00      	add	r7, sp, #0
 80009f6:	6078      	str	r0, [r7, #4]
 80009f8:	687b      	ldr	r3, [r7, #4]
 80009fa:	689b      	ldr	r3, [r3, #8]
 80009fc:	2208      	movs	r2, #8
 80009fe:	431a      	orrs	r2, r3
 8000a00:	687b      	ldr	r3, [r7, #4]
 8000a02:	609a      	str	r2, [r3, #8]
 8000a04:	46bd      	mov	sp, r7
 8000a06:	b002      	add	sp, #8
 8000a08:	bd80      	pop	{r7, pc}
 8000a0a:	46c0      	nop			; (mov r8, r8)

08000a0c <LL_USART_IsActiveFlag_TC>:
 8000a0c:	b580      	push	{r7, lr}
 8000a0e:	b082      	sub	sp, #8
 8000a10:	af00      	add	r7, sp, #0
 8000a12:	6078      	str	r0, [r7, #4]
 8000a14:	687b      	ldr	r3, [r7, #4]
 8000a16:	69da      	ldr	r2, [r3, #28]
 8000a18:	2340      	movs	r3, #64	; 0x40
 8000a1a:	4013      	ands	r3, r2
 8000a1c:	1e5a      	subs	r2, r3, #1
 8000a1e:	4193      	sbcs	r3, r2
 8000a20:	b2db      	uxtb	r3, r3
 8000a22:	1c18      	adds	r0, r3, #0
 8000a24:	46bd      	mov	sp, r7
 8000a26:	b002      	add	sp, #8
 8000a28:	bd80      	pop	{r7, pc}
 8000a2a:	46c0      	nop			; (mov r8, r8)

08000a2c <LL_USART_IsActiveFlag_TXE>:
 8000a2c:	b580      	push	{r7, lr}
 8000a2e:	b082      	sub	sp, #8
 8000a30:	af00      	add	r7, sp, #0
 8000a32:	6078      	str	r0, [r7, #4]
 8000a34:	687b      	ldr	r3, [r7, #4]
 8000a36:	69da      	ldr	r2, [r3, #28]
 8000a38:	2380      	movs	r3, #128	; 0x80
 8000a3a:	4013      	ands	r3, r2
 8000a3c:	1e5a      	subs	r2, r3, #1
 8000a3e:	4193      	sbcs	r3, r2
 8000a40:	b2db      	uxtb	r3, r3
 8000a42:	1c18      	adds	r0, r3, #0
 8000a44:	46bd      	mov	sp, r7
 8000a46:	b002      	add	sp, #8
 8000a48:	bd80      	pop	{r7, pc}
 8000a4a:	46c0      	nop			; (mov r8, r8)

08000a4c <LL_USART_ClearFlag_TC>:
 8000a4c:	b580      	push	{r7, lr}
 8000a4e:	b082      	sub	sp, #8
 8000a50:	af00      	add	r7, sp, #0
 8000a52:	6078      	str	r0, [r7, #4]
 8000a54:	687b      	ldr	r3, [r7, #4]
 8000a56:	2240      	movs	r2, #64	; 0x40
 8000a58:	621a      	str	r2, [r3, #32]
 8000a5a:	46bd      	mov	sp, r7
 8000a5c:	b002      	add	sp, #8
 8000a5e:	bd80      	pop	{r7, pc}

08000a60 <LL_USART_EnableDMAReq_RX>:
 8000a60:	b580      	push	{r7, lr}
 8000a62:	b082      	sub	sp, #8
 8000a64:	af00      	add	r7, sp, #0
 8000a66:	6078      	str	r0, [r7, #4]
 8000a68:	687b      	ldr	r3, [r7, #4]
 8000a6a:	689b      	ldr	r3, [r3, #8]
 8000a6c:	2240      	movs	r2, #64	; 0x40
 8000a6e:	431a      	orrs	r2, r3
 8000a70:	687b      	ldr	r3, [r7, #4]
 8000a72:	609a      	str	r2, [r3, #8]
 8000a74:	46bd      	mov	sp, r7
 8000a76:	b002      	add	sp, #8
 8000a78:	bd80      	pop	{r7, pc}
 8000a7a:	46c0      	nop			; (mov r8, r8)

08000a7c <LL_USART_TransmitData8>:
 8000a7c:	b580      	push	{r7, lr}
 8000a7e:	b082      	sub	sp, #8
 8000a80:	af00      	add	r7, sp, #0
 8000a82:	6078      	str	r0, [r7, #4]
 8000a84:	1c0a      	adds	r2, r1, #0
 8000a86:	1cfb      	adds	r3, r7, #3
 8000a88:	701a      	strb	r2, [r3, #0]
 8000a8a:	1cfb      	adds	r3, r7, #3
 8000a8c:	781b      	ldrb	r3, [r3, #0]
 8000a8e:	b29a      	uxth	r2, r3
 8000a90:	687b      	ldr	r3, [r7, #4]
 8000a92:	851a      	strh	r2, [r3, #40]	; 0x28
 8000a94:	46bd      	mov	sp, r7
 8000a96:	b002      	add	sp, #8
 8000a98:	bd80      	pop	{r7, pc}
 8000a9a:	46c0      	nop			; (mov r8, r8)

08000a9c <LL_DMA_EnableChannel>:
 8000a9c:	b580      	push	{r7, lr}
 8000a9e:	b082      	sub	sp, #8
 8000aa0:	af00      	add	r7, sp, #0
 8000aa2:	6078      	str	r0, [r7, #4]
 8000aa4:	6039      	str	r1, [r7, #0]
 8000aa6:	683b      	ldr	r3, [r7, #0]
 8000aa8:	3b01      	subs	r3, #1
 8000aaa:	4a09      	ldr	r2, [pc, #36]	; (8000ad0 <LL_DMA_EnableChannel+0x34>)
 8000aac:	5cd3      	ldrb	r3, [r2, r3]
 8000aae:	1c1a      	adds	r2, r3, #0
 8000ab0:	687b      	ldr	r3, [r7, #4]
 8000ab2:	18d3      	adds	r3, r2, r3
 8000ab4:	683a      	ldr	r2, [r7, #0]
 8000ab6:	3a01      	subs	r2, #1
 8000ab8:	4905      	ldr	r1, [pc, #20]	; (8000ad0 <LL_DMA_EnableChannel+0x34>)
 8000aba:	5c8a      	ldrb	r2, [r1, r2]
 8000abc:	1c11      	adds	r1, r2, #0
 8000abe:	687a      	ldr	r2, [r7, #4]
 8000ac0:	188a      	adds	r2, r1, r2
 8000ac2:	6812      	ldr	r2, [r2, #0]
 8000ac4:	2101      	movs	r1, #1
 8000ac6:	430a      	orrs	r2, r1
 8000ac8:	601a      	str	r2, [r3, #0]
 8000aca:	46bd      	mov	sp, r7
 8000acc:	b002      	add	sp, #8
 8000ace:	bd80      	pop	{r7, pc}
 8000ad0:	08001a74 	.word	0x08001a74

08000ad4 <LL_DMA_SetMemoryIncMode>:
 8000ad4:	b580      	push	{r7, lr}
 8000ad6:	b084      	sub	sp, #16
 8000ad8:	af00      	add	r7, sp, #0
 8000ada:	60f8      	str	r0, [r7, #12]
 8000adc:	60b9      	str	r1, [r7, #8]
 8000ade:	607a      	str	r2, [r7, #4]
 8000ae0:	68bb      	ldr	r3, [r7, #8]
 8000ae2:	3b01      	subs	r3, #1
 8000ae4:	4a0b      	ldr	r2, [pc, #44]	; (8000b14 <LL_DMA_SetMemoryIncMode+0x40>)
 8000ae6:	5cd3      	ldrb	r3, [r2, r3]
 8000ae8:	1c1a      	adds	r2, r3, #0
 8000aea:	68fb      	ldr	r3, [r7, #12]
 8000aec:	18d3      	adds	r3, r2, r3
 8000aee:	68ba      	ldr	r2, [r7, #8]
 8000af0:	3a01      	subs	r2, #1
 8000af2:	4908      	ldr	r1, [pc, #32]	; (8000b14 <LL_DMA_SetMemoryIncMode+0x40>)
 8000af4:	5c8a      	ldrb	r2, [r1, r2]
 8000af6:	1c11      	adds	r1, r2, #0
 8000af8:	68fa      	ldr	r2, [r7, #12]
 8000afa:	188a      	adds	r2, r1, r2
 8000afc:	6812      	ldr	r2, [r2, #0]
 8000afe:	2180      	movs	r1, #128	; 0x80
 8000b00:	1c10      	adds	r0, r2, #0
 8000b02:	4388      	bics	r0, r1
 8000b04:	1c01      	adds	r1, r0, #0
 8000b06:	687a      	ldr	r2, [r7, #4]
 8000b08:	430a      	orrs	r2, r1
 8000b0a:	601a      	str	r2, [r3, #0]
 8000b0c:	46bd      	mov	sp, r7
 8000b0e:	b004      	add	sp, #16
 8000b10:	bd80      	pop	{r7, pc}
 8000b12:	46c0      	nop			; (mov r8, r8)
 8000b14:	08001a74 	.word	0x08001a74

08000b18 <LL_DMA_SetDataLength>:
 8000b18:	b580      	push	{r7, lr}
 8000b1a:	b084      	sub	sp, #16
 8000b1c:	af00      	add	r7, sp, #0
 8000b1e:	60f8      	str	r0, [r7, #12]
 8000b20:	60b9      	str	r1, [r7, #8]
 8000b22:	607a      	str	r2, [r7, #4]
 8000b24:	68bb      	ldr	r3, [r7, #8]
 8000b26:	3b01      	subs	r3, #1
 8000b28:	4a0a      	ldr	r2, [pc, #40]	; (8000b54 <LL_DMA_SetDataLength+0x3c>)
 8000b2a:	5cd3      	ldrb	r3, [r2, r3]
 8000b2c:	1c1a      	adds	r2, r3, #0
 8000b2e:	68fb      	ldr	r3, [r7, #12]
 8000b30:	18d3      	adds	r3, r2, r3
 8000b32:	68ba      	ldr	r2, [r7, #8]
 8000b34:	3a01      	subs	r2, #1
 8000b36:	4907      	ldr	r1, [pc, #28]	; (8000b54 <LL_DMA_SetDataLength+0x3c>)
 8000b38:	5c8a      	ldrb	r2, [r1, r2]
 8000b3a:	1c11      	adds	r1, r2, #0
 8000b3c:	68fa      	ldr	r2, [r7, #12]
 8000b3e:	188a      	adds	r2, r1, r2
 8000b40:	6852      	ldr	r2, [r2, #4]
 8000b42:	0c12      	lsrs	r2, r2, #16
 8000b44:	0411      	lsls	r1, r2, #16
 8000b46:	687a      	ldr	r2, [r7, #4]
 8000b48:	430a      	orrs	r2, r1
 8000b4a:	605a      	str	r2, [r3, #4]
 8000b4c:	46bd      	mov	sp, r7
 8000b4e:	b004      	add	sp, #16
 8000b50:	bd80      	pop	{r7, pc}
 8000b52:	46c0      	nop			; (mov r8, r8)
 8000b54:	08001a74 	.word	0x08001a74

08000b58 <LL_DMA_ConfigAddresses>:
 8000b58:	b580      	push	{r7, lr}
 8000b5a:	b084      	sub	sp, #16
 8000b5c:	af00      	add	r7, sp, #0
 8000b5e:	60f8      	str	r0, [r7, #12]
 8000b60:	60b9      	str	r1, [r7, #8]
 8000b62:	607a      	str	r2, [r7, #4]
 8000b64:	603b      	str	r3, [r7, #0]
 8000b66:	69bb      	ldr	r3, [r7, #24]
 8000b68:	2b10      	cmp	r3, #16
 8000b6a:	d112      	bne.n	8000b92 <LL_DMA_ConfigAddresses+0x3a>
 8000b6c:	68bb      	ldr	r3, [r7, #8]
 8000b6e:	3b01      	subs	r3, #1
 8000b70:	4a12      	ldr	r2, [pc, #72]	; (8000bbc <LL_DMA_ConfigAddresses+0x64>)
 8000b72:	5cd3      	ldrb	r3, [r2, r3]
 8000b74:	1c1a      	adds	r2, r3, #0
 8000b76:	68fb      	ldr	r3, [r7, #12]
 8000b78:	18d3      	adds	r3, r2, r3
 8000b7a:	687a      	ldr	r2, [r7, #4]
 8000b7c:	60da      	str	r2, [r3, #12]
 8000b7e:	68bb      	ldr	r3, [r7, #8]
 8000b80:	3b01      	subs	r3, #1
 8000b82:	4a0e      	ldr	r2, [pc, #56]	; (8000bbc <LL_DMA_ConfigAddresses+0x64>)
 8000b84:	5cd3      	ldrb	r3, [r2, r3]
 8000b86:	1c1a      	adds	r2, r3, #0
 8000b88:	68fb      	ldr	r3, [r7, #12]
 8000b8a:	18d3      	adds	r3, r2, r3
 8000b8c:	683a      	ldr	r2, [r7, #0]
 8000b8e:	609a      	str	r2, [r3, #8]
 8000b90:	e011      	b.n	8000bb6 <LL_DMA_ConfigAddresses+0x5e>
 8000b92:	68bb      	ldr	r3, [r7, #8]
 8000b94:	3b01      	subs	r3, #1
 8000b96:	4a09      	ldr	r2, [pc, #36]	; (8000bbc <LL_DMA_ConfigAddresses+0x64>)
 8000b98:	5cd3      	ldrb	r3, [r2, r3]
 8000b9a:	1c1a      	adds	r2, r3, #0
 8000b9c:	68fb      	ldr	r3, [r7, #12]
 8000b9e:	18d3      	adds	r3, r2, r3
 8000ba0:	687a      	ldr	r2, [r7, #4]
 8000ba2:	609a      	str	r2, [r3, #8]
 8000ba4:	68bb      	ldr	r3, [r7, #8]
 8000ba6:	3b01      	subs	r3, #1
 8000ba8:	4a04      	ldr	r2, [pc, #16]	; (8000bbc <LL_DMA_ConfigAddresses+0x64>)
 8000baa:	5cd3      	ldrb	r3, [r2, r3]
 8000bac:	1c1a      	adds	r2, r3, #0
 8000bae:	68fb      	ldr	r3, [r7, #12]
 8000bb0:	18d3      	adds	r3, r2, r3
 8000bb2:	683a      	ldr	r2, [r7, #0]
 8000bb4:	60da      	str	r2, [r3, #12]
 8000bb6:	46bd      	mov	sp, r7
 8000bb8:	b004      	add	sp, #16
 8000bba:	bd80      	pop	{r7, pc}
 8000bbc:	08001a74 	.word	0x08001a74

08000bc0 <LL_DMA_IsActiveFlag_TC3>:
 8000bc0:	b580      	push	{r7, lr}
 8000bc2:	b082      	sub	sp, #8
 8000bc4:	af00      	add	r7, sp, #0
 8000bc6:	6078      	str	r0, [r7, #4]
 8000bc8:	687b      	ldr	r3, [r7, #4]
 8000bca:	681a      	ldr	r2, [r3, #0]
 8000bcc:	2380      	movs	r3, #128	; 0x80
 8000bce:	009b      	lsls	r3, r3, #2
 8000bd0:	4013      	ands	r3, r2
 8000bd2:	1e5a      	subs	r2, r3, #1
 8000bd4:	4193      	sbcs	r3, r2
 8000bd6:	b2db      	uxtb	r3, r3
 8000bd8:	1c18      	adds	r0, r3, #0
 8000bda:	46bd      	mov	sp, r7
 8000bdc:	b002      	add	sp, #8
 8000bde:	bd80      	pop	{r7, pc}

08000be0 <LL_DMA_ClearFlag_TC3>:
 8000be0:	b580      	push	{r7, lr}
 8000be2:	b082      	sub	sp, #8
 8000be4:	af00      	add	r7, sp, #0
 8000be6:	6078      	str	r0, [r7, #4]
 8000be8:	687b      	ldr	r3, [r7, #4]
 8000bea:	2280      	movs	r2, #128	; 0x80
 8000bec:	0092      	lsls	r2, r2, #2
 8000bee:	605a      	str	r2, [r3, #4]
 8000bf0:	46bd      	mov	sp, r7
 8000bf2:	b002      	add	sp, #8
 8000bf4:	bd80      	pop	{r7, pc}
 8000bf6:	46c0      	nop			; (mov r8, r8)

08000bf8 <LL_DMA_ClearFlag_HT3>:
 8000bf8:	b580      	push	{r7, lr}
 8000bfa:	b082      	sub	sp, #8
 8000bfc:	af00      	add	r7, sp, #0
 8000bfe:	6078      	str	r0, [r7, #4]
 8000c00:	687b      	ldr	r3, [r7, #4]
 8000c02:	2280      	movs	r2, #128	; 0x80
 8000c04:	00d2      	lsls	r2, r2, #3
 8000c06:	605a      	str	r2, [r3, #4]
 8000c08:	46bd      	mov	sp, r7
 8000c0a:	b002      	add	sp, #8
 8000c0c:	bd80      	pop	{r7, pc}
 8000c0e:	46c0      	nop			; (mov r8, r8)

08000c10 <LL_DMA_EnableIT_TC>:
 8000c10:	b580      	push	{r7, lr}
 8000c12:	b082      	sub	sp, #8
 8000c14:	af00      	add	r7, sp, #0
 8000c16:	6078      	str	r0, [r7, #4]
 8000c18:	6039      	str	r1, [r7, #0]
 8000c1a:	683b      	ldr	r3, [r7, #0]
 8000c1c:	3b01      	subs	r3, #1
 8000c1e:	4a09      	ldr	r2, [pc, #36]	; (8000c44 <LL_DMA_EnableIT_TC+0x34>)
 8000c20:	5cd3      	ldrb	r3, [r2, r3]
 8000c22:	1c1a      	adds	r2, r3, #0
 8000c24:	687b      	ldr	r3, [r7, #4]
 8000c26:	18d3      	adds	r3, r2, r3
 8000c28:	683a      	ldr	r2, [r7, #0]
 8000c2a:	3a01      	subs	r2, #1
 8000c2c:	4905      	ldr	r1, [pc, #20]	; (8000c44 <LL_DMA_EnableIT_TC+0x34>)
 8000c2e:	5c8a      	ldrb	r2, [r1, r2]
 8000c30:	1c11      	adds	r1, r2, #0
 8000c32:	687a      	ldr	r2, [r7, #4]
 8000c34:	188a      	adds	r2, r1, r2
 8000c36:	6812      	ldr	r2, [r2, #0]
 8000c38:	2102      	movs	r1, #2
 8000c3a:	430a      	orrs	r2, r1
 8000c3c:	601a      	str	r2, [r3, #0]
 8000c3e:	46bd      	mov	sp, r7
 8000c40:	b002      	add	sp, #8
 8000c42:	bd80      	pop	{r7, pc}
 8000c44:	08001a74 	.word	0x08001a74

08000c48 <dyn_send_cmd>:
 8000c48:	b580      	push	{r7, lr}
 8000c4a:	b084      	sub	sp, #16
 8000c4c:	af00      	add	r7, sp, #0
 8000c4e:	6078      	str	r0, [r7, #4]
 8000c50:	6039      	str	r1, [r7, #0]
 8000c52:	2300      	movs	r3, #0
 8000c54:	60fb      	str	r3, [r7, #12]
 8000c56:	4b1c      	ldr	r3, [pc, #112]	; (8000cc8 <dyn_send_cmd+0x80>)
 8000c58:	1c18      	adds	r0, r3, #0
 8000c5a:	f7ff fe3d 	bl	80008d8 <LL_USART_EnableDirectionTx>
 8000c5e:	4b1a      	ldr	r3, [pc, #104]	; (8000cc8 <dyn_send_cmd+0x80>)
 8000c60:	1c18      	adds	r0, r3, #0
 8000c62:	f7ff fef3 	bl	8000a4c <LL_USART_ClearFlag_TC>
 8000c66:	e012      	b.n	8000c8e <dyn_send_cmd+0x46>
 8000c68:	46c0      	nop			; (mov r8, r8)
 8000c6a:	4b17      	ldr	r3, [pc, #92]	; (8000cc8 <dyn_send_cmd+0x80>)
 8000c6c:	1c18      	adds	r0, r3, #0
 8000c6e:	f7ff fedd 	bl	8000a2c <LL_USART_IsActiveFlag_TXE>
 8000c72:	1c03      	adds	r3, r0, #0
 8000c74:	2b00      	cmp	r3, #0
 8000c76:	d0f8      	beq.n	8000c6a <dyn_send_cmd+0x22>
 8000c78:	68fb      	ldr	r3, [r7, #12]
 8000c7a:	1c5a      	adds	r2, r3, #1
 8000c7c:	60fa      	str	r2, [r7, #12]
 8000c7e:	687a      	ldr	r2, [r7, #4]
 8000c80:	18d3      	adds	r3, r2, r3
 8000c82:	781b      	ldrb	r3, [r3, #0]
 8000c84:	4a10      	ldr	r2, [pc, #64]	; (8000cc8 <dyn_send_cmd+0x80>)
 8000c86:	1c10      	adds	r0, r2, #0
 8000c88:	1c19      	adds	r1, r3, #0
 8000c8a:	f7ff fef7 	bl	8000a7c <LL_USART_TransmitData8>
 8000c8e:	683b      	ldr	r3, [r7, #0]
 8000c90:	1e5a      	subs	r2, r3, #1
 8000c92:	603a      	str	r2, [r7, #0]
 8000c94:	2b00      	cmp	r3, #0
 8000c96:	d1e7      	bne.n	8000c68 <dyn_send_cmd+0x20>
 8000c98:	46c0      	nop			; (mov r8, r8)
 8000c9a:	4b0b      	ldr	r3, [pc, #44]	; (8000cc8 <dyn_send_cmd+0x80>)
 8000c9c:	1c18      	adds	r0, r3, #0
 8000c9e:	f7ff feb5 	bl	8000a0c <LL_USART_IsActiveFlag_TC>
 8000ca2:	1c03      	adds	r3, r0, #0
 8000ca4:	2b00      	cmp	r3, #0
 8000ca6:	d0f8      	beq.n	8000c9a <dyn_send_cmd+0x52>
 8000ca8:	4b07      	ldr	r3, [pc, #28]	; (8000cc8 <dyn_send_cmd+0x80>)
 8000caa:	1c18      	adds	r0, r3, #0
 8000cac:	f7ff fe22 	bl	80008f4 <LL_USART_DisableDirectionTx>
 8000cb0:	4b05      	ldr	r3, [pc, #20]	; (8000cc8 <dyn_send_cmd+0x80>)
 8000cb2:	1c18      	adds	r0, r3, #0
 8000cb4:	f7ff fe02 	bl	80008bc <LL_USART_EnableDirectionRx>
 8000cb8:	4a04      	ldr	r2, [pc, #16]	; (8000ccc <dyn_send_cmd+0x84>)
 8000cba:	2340      	movs	r3, #64	; 0x40
 8000cbc:	2100      	movs	r1, #0
 8000cbe:	54d1      	strb	r1, [r2, r3]
 8000cc0:	46c0      	nop			; (mov r8, r8)
 8000cc2:	46bd      	mov	sp, r7
 8000cc4:	b004      	add	sp, #16
 8000cc6:	bd80      	pop	{r7, pc}
 8000cc8:	40013800 	.word	0x40013800
 8000ccc:	2000044c 	.word	0x2000044c

08000cd0 <fsm_dynamixel_error_catch>:
 8000cd0:	b580      	push	{r7, lr}
 8000cd2:	b082      	sub	sp, #8
 8000cd4:	af00      	add	r7, sp, #0
 8000cd6:	6078      	str	r0, [r7, #4]
 8000cd8:	46c0      	nop			; (mov r8, r8)
 8000cda:	46bd      	mov	sp, r7
 8000cdc:	b002      	add	sp, #8
 8000cde:	bd80      	pop	{r7, pc}

08000ce0 <fsm_dynamixel_init>:
 8000ce0:	b580      	push	{r7, lr}
 8000ce2:	b084      	sub	sp, #16
 8000ce4:	af02      	add	r7, sp, #8
 8000ce6:	6078      	str	r0, [r7, #4]
 8000ce8:	2005      	movs	r0, #5
 8000cea:	f000 f971 	bl	8000fd0 <fsm_add_shadow_state>
 8000cee:	2380      	movs	r3, #128	; 0x80
 8000cf0:	029b      	lsls	r3, r3, #10
 8000cf2:	1c18      	adds	r0, r3, #0
 8000cf4:	f7ff fda8 	bl	8000848 <LL_AHB1_GRP1_EnableClock>
 8000cf8:	2390      	movs	r3, #144	; 0x90
 8000cfa:	05da      	lsls	r2, r3, #23
 8000cfc:	2380      	movs	r3, #128	; 0x80
 8000cfe:	009b      	lsls	r3, r3, #2
 8000d00:	1c10      	adds	r0, r2, #0
 8000d02:	1c19      	adds	r1, r3, #0
 8000d04:	2202      	movs	r2, #2
 8000d06:	f7ff fd27 	bl	8000758 <LL_GPIO_SetPinMode>
 8000d0a:	2390      	movs	r3, #144	; 0x90
 8000d0c:	05da      	lsls	r2, r3, #23
 8000d0e:	2380      	movs	r3, #128	; 0x80
 8000d10:	009b      	lsls	r3, r3, #2
 8000d12:	1c10      	adds	r0, r2, #0
 8000d14:	1c19      	adds	r1, r3, #0
 8000d16:	2201      	movs	r2, #1
 8000d18:	f7ff fd6a 	bl	80007f0 <LL_GPIO_SetAFPin_8_15>
 8000d1c:	2390      	movs	r3, #144	; 0x90
 8000d1e:	05da      	lsls	r2, r3, #23
 8000d20:	2380      	movs	r3, #128	; 0x80
 8000d22:	009b      	lsls	r3, r3, #2
 8000d24:	1c10      	adds	r0, r2, #0
 8000d26:	1c19      	adds	r1, r3, #0
 8000d28:	2203      	movs	r2, #3
 8000d2a:	f7ff fd45 	bl	80007b8 <LL_GPIO_SetPinSpeed>
 8000d2e:	2390      	movs	r3, #144	; 0x90
 8000d30:	05da      	lsls	r2, r3, #23
 8000d32:	2380      	movs	r3, #128	; 0x80
 8000d34:	009b      	lsls	r3, r3, #2
 8000d36:	1c10      	adds	r0, r2, #0
 8000d38:	1c19      	adds	r1, r3, #0
 8000d3a:	2201      	movs	r2, #1
 8000d3c:	f7ff fd28 	bl	8000790 <LL_GPIO_SetPinOutputType>
 8000d40:	2380      	movs	r3, #128	; 0x80
 8000d42:	01db      	lsls	r3, r3, #7
 8000d44:	1c18      	adds	r0, r3, #0
 8000d46:	f7ff fd95 	bl	8000874 <LL_APB1_GRP2_EnableClock>
 8000d4a:	4b3d      	ldr	r3, [pc, #244]	; (8000e40 <fsm_dynamixel_init+0x160>)
 8000d4c:	1c18      	adds	r0, r3, #0
 8000d4e:	2100      	movs	r1, #0
 8000d50:	f7ff fde0 	bl	8000914 <LL_USART_SetParity>
 8000d54:	4b3a      	ldr	r3, [pc, #232]	; (8000e40 <fsm_dynamixel_init+0x160>)
 8000d56:	1c18      	adds	r0, r3, #0
 8000d58:	2100      	movs	r1, #0
 8000d5a:	f7ff fded 	bl	8000938 <LL_USART_SetDataWidth>
 8000d5e:	4b38      	ldr	r3, [pc, #224]	; (8000e40 <fsm_dynamixel_init+0x160>)
 8000d60:	1c18      	adds	r0, r3, #0
 8000d62:	2100      	movs	r1, #0
 8000d64:	f7ff fdfa 	bl	800095c <LL_USART_SetStopBitsLength>
 8000d68:	4b36      	ldr	r3, [pc, #216]	; (8000e44 <fsm_dynamixel_init+0x164>)
 8000d6a:	681a      	ldr	r2, [r3, #0]
 8000d6c:	4934      	ldr	r1, [pc, #208]	; (8000e40 <fsm_dynamixel_init+0x160>)
 8000d6e:	4b36      	ldr	r3, [pc, #216]	; (8000e48 <fsm_dynamixel_init+0x168>)
 8000d70:	1c08      	adds	r0, r1, #0
 8000d72:	1c11      	adds	r1, r2, #0
 8000d74:	2200      	movs	r2, #0
 8000d76:	f7ff fe03 	bl	8000980 <LL_USART_SetBaudRate>
 8000d7a:	4b31      	ldr	r3, [pc, #196]	; (8000e40 <fsm_dynamixel_init+0x160>)
 8000d7c:	1c18      	adds	r0, r3, #0
 8000d7e:	f7ff fdb9 	bl	80008f4 <LL_USART_DisableDirectionTx>
 8000d82:	4b2f      	ldr	r3, [pc, #188]	; (8000e40 <fsm_dynamixel_init+0x160>)
 8000d84:	1c18      	adds	r0, r3, #0
 8000d86:	f7ff fe33 	bl	80009f0 <LL_USART_EnableHalfDuplex>
 8000d8a:	4b2d      	ldr	r3, [pc, #180]	; (8000e40 <fsm_dynamixel_init+0x160>)
 8000d8c:	1c18      	adds	r0, r3, #0
 8000d8e:	f7ff fe67 	bl	8000a60 <LL_USART_EnableDMAReq_RX>
 8000d92:	2001      	movs	r0, #1
 8000d94:	f7ff fd58 	bl	8000848 <LL_AHB1_GRP1_EnableClock>
 8000d98:	4b2c      	ldr	r3, [pc, #176]	; (8000e4c <fsm_dynamixel_init+0x16c>)
 8000d9a:	492d      	ldr	r1, [pc, #180]	; (8000e50 <fsm_dynamixel_init+0x170>)
 8000d9c:	4a2d      	ldr	r2, [pc, #180]	; (8000e54 <fsm_dynamixel_init+0x174>)
 8000d9e:	2000      	movs	r0, #0
 8000da0:	9000      	str	r0, [sp, #0]
 8000da2:	1c08      	adds	r0, r1, #0
 8000da4:	2103      	movs	r1, #3
 8000da6:	f7ff fed7 	bl	8000b58 <LL_DMA_ConfigAddresses>
 8000daa:	4a29      	ldr	r2, [pc, #164]	; (8000e50 <fsm_dynamixel_init+0x170>)
 8000dac:	2380      	movs	r3, #128	; 0x80
 8000dae:	005b      	lsls	r3, r3, #1
 8000db0:	1c10      	adds	r0, r2, #0
 8000db2:	2103      	movs	r1, #3
 8000db4:	1c1a      	adds	r2, r3, #0
 8000db6:	f7ff feaf 	bl	8000b18 <LL_DMA_SetDataLength>
 8000dba:	4b25      	ldr	r3, [pc, #148]	; (8000e50 <fsm_dynamixel_init+0x170>)
 8000dbc:	1c18      	adds	r0, r3, #0
 8000dbe:	2103      	movs	r1, #3
 8000dc0:	2280      	movs	r2, #128	; 0x80
 8000dc2:	f7ff fe87 	bl	8000ad4 <LL_DMA_SetMemoryIncMode>
 8000dc6:	4b22      	ldr	r3, [pc, #136]	; (8000e50 <fsm_dynamixel_init+0x170>)
 8000dc8:	1c18      	adds	r0, r3, #0
 8000dca:	2103      	movs	r1, #3
 8000dcc:	f7ff ff20 	bl	8000c10 <LL_DMA_EnableIT_TC>
 8000dd0:	4b1b      	ldr	r3, [pc, #108]	; (8000e40 <fsm_dynamixel_init+0x160>)
 8000dd2:	1c18      	adds	r0, r3, #0
 8000dd4:	f7ff fd64 	bl	80008a0 <LL_USART_Enable>
 8000dd8:	4b1d      	ldr	r3, [pc, #116]	; (8000e50 <fsm_dynamixel_init+0x170>)
 8000dda:	1c18      	adds	r0, r3, #0
 8000ddc:	2103      	movs	r1, #3
 8000dde:	f7ff fe5d 	bl	8000a9c <LL_DMA_EnableChannel>
 8000de2:	201b      	movs	r0, #27
 8000de4:	2101      	movs	r1, #1
 8000de6:	f7ff fc47 	bl	8000678 <NVIC_SetPriority>
 8000dea:	201b      	movs	r0, #27
 8000dec:	f7ff fc2e 	bl	800064c <NVIC_EnableIRQ>
 8000df0:	200a      	movs	r0, #10
 8000df2:	2102      	movs	r1, #2
 8000df4:	f7ff fc40 	bl	8000678 <NVIC_SetPriority>
 8000df8:	200a      	movs	r0, #10
 8000dfa:	f7ff fc27 	bl	800064c <NVIC_EnableIRQ>
 8000dfe:	2380      	movs	r3, #128	; 0x80
 8000e00:	031b      	lsls	r3, r3, #12
 8000e02:	1c18      	adds	r0, r3, #0
 8000e04:	f7ff fd20 	bl	8000848 <LL_AHB1_GRP1_EnableClock>
 8000e08:	4a13      	ldr	r2, [pc, #76]	; (8000e58 <fsm_dynamixel_init+0x178>)
 8000e0a:	2380      	movs	r3, #128	; 0x80
 8000e0c:	009b      	lsls	r3, r3, #2
 8000e0e:	1c10      	adds	r0, r2, #0
 8000e10:	1c19      	adds	r1, r3, #0
 8000e12:	2201      	movs	r2, #1
 8000e14:	f7ff fca0 	bl	8000758 <LL_GPIO_SetPinMode>
 8000e18:	4a0f      	ldr	r2, [pc, #60]	; (8000e58 <fsm_dynamixel_init+0x178>)
 8000e1a:	2380      	movs	r3, #128	; 0x80
 8000e1c:	009b      	lsls	r3, r3, #2
 8000e1e:	1c10      	adds	r0, r2, #0
 8000e20:	1c19      	adds	r1, r3, #0
 8000e22:	2200      	movs	r2, #0
 8000e24:	f7ff fcb4 	bl	8000790 <LL_GPIO_SetPinOutputType>
 8000e28:	4a08      	ldr	r2, [pc, #32]	; (8000e4c <fsm_dynamixel_init+0x16c>)
 8000e2a:	2340      	movs	r3, #64	; 0x40
 8000e2c:	2100      	movs	r1, #0
 8000e2e:	54d1      	strb	r1, [r2, r3]
 8000e30:	2008      	movs	r0, #8
 8000e32:	f000 f903 	bl	800103c <fsm_set_state>
 8000e36:	46c0      	nop			; (mov r8, r8)
 8000e38:	46bd      	mov	sp, r7
 8000e3a:	b002      	add	sp, #8
 8000e3c:	bd80      	pop	{r7, pc}
 8000e3e:	46c0      	nop			; (mov r8, r8)
 8000e40:	40013800 	.word	0x40013800
 8000e44:	20000000 	.word	0x20000000
 8000e48:	000f4240 	.word	0x000f4240
 8000e4c:	2000044c 	.word	0x2000044c
 8000e50:	40020000 	.word	0x40020000
 8000e54:	40004424 	.word	0x40004424
 8000e58:	48000800 	.word	0x48000800

08000e5c <fsm_set_angle>:
 8000e5c:	b580      	push	{r7, lr}
 8000e5e:	b086      	sub	sp, #24
 8000e60:	af00      	add	r7, sp, #0
 8000e62:	6078      	str	r0, [r7, #4]
 8000e64:	687b      	ldr	r3, [r7, #4]
 8000e66:	617b      	str	r3, [r7, #20]
 8000e68:	697b      	ldr	r3, [r7, #20]
 8000e6a:	785a      	ldrb	r2, [r3, #1]
 8000e6c:	789b      	ldrb	r3, [r3, #2]
 8000e6e:	021b      	lsls	r3, r3, #8
 8000e70:	4313      	orrs	r3, r2
 8000e72:	b29a      	uxth	r2, r3
 8000e74:	4b2f      	ldr	r3, [pc, #188]	; (8000f34 <fsm_set_angle+0xd8>)
 8000e76:	429a      	cmp	r2, r3
 8000e78:	d900      	bls.n	8000e7c <fsm_set_angle+0x20>
 8000e7a:	e057      	b.n	8000f2c <fsm_set_angle+0xd0>
 8000e7c:	697b      	ldr	r3, [r7, #20]
 8000e7e:	785a      	ldrb	r2, [r3, #1]
 8000e80:	789b      	ldrb	r3, [r3, #2]
 8000e82:	021b      	lsls	r3, r3, #8
 8000e84:	4313      	orrs	r3, r2
 8000e86:	b29b      	uxth	r3, r3
 8000e88:	0a1b      	lsrs	r3, r3, #8
 8000e8a:	b29a      	uxth	r2, r3
 8000e8c:	1c3b      	adds	r3, r7, #0
 8000e8e:	3313      	adds	r3, #19
 8000e90:	701a      	strb	r2, [r3, #0]
 8000e92:	697b      	ldr	r3, [r7, #20]
 8000e94:	785a      	ldrb	r2, [r3, #1]
 8000e96:	789b      	ldrb	r3, [r3, #2]
 8000e98:	021b      	lsls	r3, r3, #8
 8000e9a:	4313      	orrs	r3, r2
 8000e9c:	b29a      	uxth	r2, r3
 8000e9e:	1c3b      	adds	r3, r7, #0
 8000ea0:	3312      	adds	r3, #18
 8000ea2:	701a      	strb	r2, [r3, #0]
 8000ea4:	697b      	ldr	r3, [r7, #20]
 8000ea6:	781a      	ldrb	r2, [r3, #0]
 8000ea8:	1c3b      	adds	r3, r7, #0
 8000eaa:	3312      	adds	r3, #18
 8000eac:	781b      	ldrb	r3, [r3, #0]
 8000eae:	18d3      	adds	r3, r2, r3
 8000eb0:	b2da      	uxtb	r2, r3
 8000eb2:	1c3b      	adds	r3, r7, #0
 8000eb4:	3313      	adds	r3, #19
 8000eb6:	781b      	ldrb	r3, [r3, #0]
 8000eb8:	18d3      	adds	r3, r2, r3
 8000eba:	b2da      	uxtb	r2, r3
 8000ebc:	1c3b      	adds	r3, r7, #0
 8000ebe:	3311      	adds	r3, #17
 8000ec0:	3226      	adds	r2, #38	; 0x26
 8000ec2:	701a      	strb	r2, [r3, #0]
 8000ec4:	1c3b      	adds	r3, r7, #0
 8000ec6:	3308      	adds	r3, #8
 8000ec8:	22ff      	movs	r2, #255	; 0xff
 8000eca:	701a      	strb	r2, [r3, #0]
 8000ecc:	1c3b      	adds	r3, r7, #0
 8000ece:	3308      	adds	r3, #8
 8000ed0:	22ff      	movs	r2, #255	; 0xff
 8000ed2:	705a      	strb	r2, [r3, #1]
 8000ed4:	697b      	ldr	r3, [r7, #20]
 8000ed6:	781a      	ldrb	r2, [r3, #0]
 8000ed8:	1c3b      	adds	r3, r7, #0
 8000eda:	3308      	adds	r3, #8
 8000edc:	709a      	strb	r2, [r3, #2]
 8000ede:	1c3b      	adds	r3, r7, #0
 8000ee0:	3308      	adds	r3, #8
 8000ee2:	2205      	movs	r2, #5
 8000ee4:	70da      	strb	r2, [r3, #3]
 8000ee6:	1c3b      	adds	r3, r7, #0
 8000ee8:	3308      	adds	r3, #8
 8000eea:	2203      	movs	r2, #3
 8000eec:	711a      	strb	r2, [r3, #4]
 8000eee:	1c3b      	adds	r3, r7, #0
 8000ef0:	3308      	adds	r3, #8
 8000ef2:	221e      	movs	r2, #30
 8000ef4:	715a      	strb	r2, [r3, #5]
 8000ef6:	1c3b      	adds	r3, r7, #0
 8000ef8:	3308      	adds	r3, #8
 8000efa:	1c3a      	adds	r2, r7, #0
 8000efc:	3212      	adds	r2, #18
 8000efe:	7812      	ldrb	r2, [r2, #0]
 8000f00:	719a      	strb	r2, [r3, #6]
 8000f02:	1c3b      	adds	r3, r7, #0
 8000f04:	3308      	adds	r3, #8
 8000f06:	1c3a      	adds	r2, r7, #0
 8000f08:	3213      	adds	r2, #19
 8000f0a:	7812      	ldrb	r2, [r2, #0]
 8000f0c:	71da      	strb	r2, [r3, #7]
 8000f0e:	1c3b      	adds	r3, r7, #0
 8000f10:	3311      	adds	r3, #17
 8000f12:	781b      	ldrb	r3, [r3, #0]
 8000f14:	43db      	mvns	r3, r3
 8000f16:	b2da      	uxtb	r2, r3
 8000f18:	1c3b      	adds	r3, r7, #0
 8000f1a:	3308      	adds	r3, #8
 8000f1c:	721a      	strb	r2, [r3, #8]
 8000f1e:	1c3b      	adds	r3, r7, #0
 8000f20:	3308      	adds	r3, #8
 8000f22:	1c18      	adds	r0, r3, #0
 8000f24:	2109      	movs	r1, #9
 8000f26:	f7ff fe8f 	bl	8000c48 <dyn_send_cmd>
 8000f2a:	46c0      	nop			; (mov r8, r8)
 8000f2c:	46bd      	mov	sp, r7
 8000f2e:	b006      	add	sp, #24
 8000f30:	bd80      	pop	{r7, pc}
 8000f32:	46c0      	nop			; (mov r8, r8)
 8000f34:	00003fff 	.word	0x00003fff

08000f38 <DMA1_Channel2_3_IRQHandler>:
 8000f38:	b580      	push	{r7, lr}
 8000f3a:	af00      	add	r7, sp, #0
 8000f3c:	4b0c      	ldr	r3, [pc, #48]	; (8000f70 <DMA1_Channel2_3_IRQHandler+0x38>)
 8000f3e:	1c18      	adds	r0, r3, #0
 8000f40:	f7ff fe3e 	bl	8000bc0 <LL_DMA_IsActiveFlag_TC3>
 8000f44:	1c03      	adds	r3, r0, #0
 8000f46:	2b00      	cmp	r3, #0
 8000f48:	d010      	beq.n	8000f6c <DMA1_Channel2_3_IRQHandler+0x34>
 8000f4a:	4b09      	ldr	r3, [pc, #36]	; (8000f70 <DMA1_Channel2_3_IRQHandler+0x38>)
 8000f4c:	1c18      	adds	r0, r3, #0
 8000f4e:	f7ff fe47 	bl	8000be0 <LL_DMA_ClearFlag_TC3>
 8000f52:	4b07      	ldr	r3, [pc, #28]	; (8000f70 <DMA1_Channel2_3_IRQHandler+0x38>)
 8000f54:	1c18      	adds	r0, r3, #0
 8000f56:	f7ff fe4f 	bl	8000bf8 <LL_DMA_ClearFlag_HT3>
 8000f5a:	4b05      	ldr	r3, [pc, #20]	; (8000f70 <DMA1_Channel2_3_IRQHandler+0x38>)
 8000f5c:	1c18      	adds	r0, r3, #0
 8000f5e:	2103      	movs	r1, #3
 8000f60:	f7ff fd9c 	bl	8000a9c <LL_DMA_EnableChannel>
 8000f64:	4a03      	ldr	r2, [pc, #12]	; (8000f74 <DMA1_Channel2_3_IRQHandler+0x3c>)
 8000f66:	2340      	movs	r3, #64	; 0x40
 8000f68:	2101      	movs	r1, #1
 8000f6a:	54d1      	strb	r1, [r2, r3]
 8000f6c:	46bd      	mov	sp, r7
 8000f6e:	bd80      	pop	{r7, pc}
 8000f70:	40020000 	.word	0x40020000
 8000f74:	2000044c 	.word	0x2000044c

08000f78 <fsm_dummy>:
 8000f78:	b580      	push	{r7, lr}
 8000f7a:	b082      	sub	sp, #8
 8000f7c:	af00      	add	r7, sp, #0
 8000f7e:	6078      	str	r0, [r7, #4]
 8000f80:	2003      	movs	r0, #3
 8000f82:	f000 f85b 	bl	800103c <fsm_set_state>
 8000f86:	46c0      	nop			; (mov r8, r8)
 8000f88:	46bd      	mov	sp, r7
 8000f8a:	b002      	add	sp, #8
 8000f8c:	bd80      	pop	{r7, pc}
 8000f8e:	46c0      	nop			; (mov r8, r8)

08000f90 <is_state_shadow>:
 8000f90:	b580      	push	{r7, lr}
 8000f92:	b084      	sub	sp, #16
 8000f94:	af00      	add	r7, sp, #0
 8000f96:	6078      	str	r0, [r7, #4]
 8000f98:	6039      	str	r1, [r7, #0]
 8000f9a:	2300      	movs	r3, #0
 8000f9c:	60fb      	str	r3, [r7, #12]
 8000f9e:	2300      	movs	r3, #0
 8000fa0:	60fb      	str	r3, [r7, #12]
 8000fa2:	e00c      	b.n	8000fbe <is_state_shadow+0x2e>
 8000fa4:	687b      	ldr	r3, [r7, #4]
 8000fa6:	68fa      	ldr	r2, [r7, #12]
 8000fa8:	3202      	adds	r2, #2
 8000faa:	0092      	lsls	r2, r2, #2
 8000fac:	58d2      	ldr	r2, [r2, r3]
 8000fae:	683b      	ldr	r3, [r7, #0]
 8000fb0:	429a      	cmp	r2, r3
 8000fb2:	d101      	bne.n	8000fb8 <is_state_shadow+0x28>
 8000fb4:	68fb      	ldr	r3, [r7, #12]
 8000fb6:	e007      	b.n	8000fc8 <is_state_shadow+0x38>
 8000fb8:	68fb      	ldr	r3, [r7, #12]
 8000fba:	3301      	adds	r3, #1
 8000fbc:	60fb      	str	r3, [r7, #12]
 8000fbe:	68fb      	ldr	r3, [r7, #12]
 8000fc0:	2b04      	cmp	r3, #4
 8000fc2:	ddef      	ble.n	8000fa4 <is_state_shadow+0x14>
 8000fc4:	2301      	movs	r3, #1
 8000fc6:	425b      	negs	r3, r3
 8000fc8:	1c18      	adds	r0, r3, #0
 8000fca:	46bd      	mov	sp, r7
 8000fcc:	b004      	add	sp, #16
 8000fce:	bd80      	pop	{r7, pc}

08000fd0 <fsm_add_shadow_state>:
 8000fd0:	b580      	push	{r7, lr}
 8000fd2:	b084      	sub	sp, #16
 8000fd4:	af00      	add	r7, sp, #0
 8000fd6:	6078      	str	r0, [r7, #4]
 8000fd8:	2300      	movs	r3, #0
 8000fda:	60fb      	str	r3, [r7, #12]
 8000fdc:	4a16      	ldr	r2, [pc, #88]	; (8001038 <fsm_add_shadow_state+0x68>)
 8000fde:	687b      	ldr	r3, [r7, #4]
 8000fe0:	1c10      	adds	r0, r2, #0
 8000fe2:	1c19      	adds	r1, r3, #0
 8000fe4:	f7ff ffd4 	bl	8000f90 <is_state_shadow>
 8000fe8:	1c03      	adds	r3, r0, #0
 8000fea:	3301      	adds	r3, #1
 8000fec:	d002      	beq.n	8000ff4 <fsm_add_shadow_state+0x24>
 8000fee:	2301      	movs	r3, #1
 8000ff0:	425b      	negs	r3, r3
 8000ff2:	e01c      	b.n	800102e <fsm_add_shadow_state+0x5e>
 8000ff4:	4b10      	ldr	r3, [pc, #64]	; (8001038 <fsm_add_shadow_state+0x68>)
 8000ff6:	1c18      	adds	r0, r3, #0
 8000ff8:	2100      	movs	r1, #0
 8000ffa:	f7ff ffc9 	bl	8000f90 <is_state_shadow>
 8000ffe:	1c03      	adds	r3, r0, #0
 8001000:	60fb      	str	r3, [r7, #12]
 8001002:	68fb      	ldr	r3, [r7, #12]
 8001004:	3301      	adds	r3, #1
 8001006:	d102      	bne.n	800100e <fsm_add_shadow_state+0x3e>
 8001008:	2301      	movs	r3, #1
 800100a:	425b      	negs	r3, r3
 800100c:	e00f      	b.n	800102e <fsm_add_shadow_state+0x5e>
 800100e:	687b      	ldr	r3, [r7, #4]
 8001010:	2b00      	cmp	r3, #0
 8001012:	d002      	beq.n	800101a <fsm_add_shadow_state+0x4a>
 8001014:	687b      	ldr	r3, [r7, #4]
 8001016:	2b0b      	cmp	r3, #11
 8001018:	d902      	bls.n	8001020 <fsm_add_shadow_state+0x50>
 800101a:	2301      	movs	r3, #1
 800101c:	425b      	negs	r3, r3
 800101e:	e006      	b.n	800102e <fsm_add_shadow_state+0x5e>
 8001020:	4b05      	ldr	r3, [pc, #20]	; (8001038 <fsm_add_shadow_state+0x68>)
 8001022:	68fa      	ldr	r2, [r7, #12]
 8001024:	3202      	adds	r2, #2
 8001026:	0092      	lsls	r2, r2, #2
 8001028:	6879      	ldr	r1, [r7, #4]
 800102a:	50d1      	str	r1, [r2, r3]
 800102c:	2300      	movs	r3, #0
 800102e:	1c18      	adds	r0, r3, #0
 8001030:	46bd      	mov	sp, r7
 8001032:	b004      	add	sp, #16
 8001034:	bd80      	pop	{r7, pc}
 8001036:	46c0      	nop			; (mov r8, r8)
 8001038:	20000490 	.word	0x20000490

0800103c <fsm_set_state>:
 800103c:	b580      	push	{r7, lr}
 800103e:	b084      	sub	sp, #16
 8001040:	af00      	add	r7, sp, #0
 8001042:	6078      	str	r0, [r7, #4]
 8001044:	2301      	movs	r3, #1
 8001046:	425b      	negs	r3, r3
 8001048:	60fb      	str	r3, [r7, #12]
 800104a:	2301      	movs	r3, #1
 800104c:	425b      	negs	r3, r3
 800104e:	60bb      	str	r3, [r7, #8]
 8001050:	4b16      	ldr	r3, [pc, #88]	; (80010ac <fsm_set_state+0x70>)
 8001052:	681b      	ldr	r3, [r3, #0]
 8001054:	4a15      	ldr	r2, [pc, #84]	; (80010ac <fsm_set_state+0x70>)
 8001056:	1c10      	adds	r0, r2, #0
 8001058:	1c19      	adds	r1, r3, #0
 800105a:	f7ff ff99 	bl	8000f90 <is_state_shadow>
 800105e:	1c03      	adds	r3, r0, #0
 8001060:	60fb      	str	r3, [r7, #12]
 8001062:	4a12      	ldr	r2, [pc, #72]	; (80010ac <fsm_set_state+0x70>)
 8001064:	687b      	ldr	r3, [r7, #4]
 8001066:	1c10      	adds	r0, r2, #0
 8001068:	1c19      	adds	r1, r3, #0
 800106a:	f7ff ff91 	bl	8000f90 <is_state_shadow>
 800106e:	1c03      	adds	r3, r0, #0
 8001070:	60bb      	str	r3, [r7, #8]
 8001072:	68fb      	ldr	r3, [r7, #12]
 8001074:	3301      	adds	r3, #1
 8001076:	d107      	bne.n	8001088 <fsm_set_state+0x4c>
 8001078:	68bb      	ldr	r3, [r7, #8]
 800107a:	3301      	adds	r3, #1
 800107c:	d104      	bne.n	8001088 <fsm_set_state+0x4c>
 800107e:	4b0b      	ldr	r3, [pc, #44]	; (80010ac <fsm_set_state+0x70>)
 8001080:	687a      	ldr	r2, [r7, #4]
 8001082:	601a      	str	r2, [r3, #0]
 8001084:	2300      	movs	r3, #0
 8001086:	e00c      	b.n	80010a2 <fsm_set_state+0x66>
 8001088:	68fb      	ldr	r3, [r7, #12]
 800108a:	3301      	adds	r3, #1
 800108c:	d007      	beq.n	800109e <fsm_set_state+0x62>
 800108e:	4b07      	ldr	r3, [pc, #28]	; (80010ac <fsm_set_state+0x70>)
 8001090:	68fa      	ldr	r2, [r7, #12]
 8001092:	3202      	adds	r2, #2
 8001094:	0092      	lsls	r2, r2, #2
 8001096:	6879      	ldr	r1, [r7, #4]
 8001098:	50d1      	str	r1, [r2, r3]
 800109a:	2300      	movs	r3, #0
 800109c:	e001      	b.n	80010a2 <fsm_set_state+0x66>
 800109e:	2301      	movs	r3, #1
 80010a0:	425b      	negs	r3, r3
 80010a2:	1c18      	adds	r0, r3, #0
 80010a4:	46bd      	mov	sp, r7
 80010a6:	b004      	add	sp, #16
 80010a8:	bd80      	pop	{r7, pc}
 80010aa:	46c0      	nop			; (mov r8, r8)
 80010ac:	20000490 	.word	0x20000490

080010b0 <NVIC_EnableIRQ>:
 80010b0:	b580      	push	{r7, lr}
 80010b2:	b082      	sub	sp, #8
 80010b4:	af00      	add	r7, sp, #0
 80010b6:	1c02      	adds	r2, r0, #0
 80010b8:	1dfb      	adds	r3, r7, #7
 80010ba:	701a      	strb	r2, [r3, #0]
 80010bc:	4b06      	ldr	r3, [pc, #24]	; (80010d8 <NVIC_EnableIRQ+0x28>)
 80010be:	1dfa      	adds	r2, r7, #7
 80010c0:	7812      	ldrb	r2, [r2, #0]
 80010c2:	1c11      	adds	r1, r2, #0
 80010c4:	221f      	movs	r2, #31
 80010c6:	400a      	ands	r2, r1
 80010c8:	2101      	movs	r1, #1
 80010ca:	1c08      	adds	r0, r1, #0
 80010cc:	4090      	lsls	r0, r2
 80010ce:	1c02      	adds	r2, r0, #0
 80010d0:	601a      	str	r2, [r3, #0]
 80010d2:	46bd      	mov	sp, r7
 80010d4:	b002      	add	sp, #8
 80010d6:	bd80      	pop	{r7, pc}
 80010d8:	e000e100 	.word	0xe000e100

080010dc <NVIC_SetPriority>:
 80010dc:	b5b0      	push	{r4, r5, r7, lr}
 80010de:	b082      	sub	sp, #8
 80010e0:	af00      	add	r7, sp, #0
 80010e2:	1c02      	adds	r2, r0, #0
 80010e4:	6039      	str	r1, [r7, #0]
 80010e6:	1dfb      	adds	r3, r7, #7
 80010e8:	701a      	strb	r2, [r3, #0]
 80010ea:	1dfb      	adds	r3, r7, #7
 80010ec:	781b      	ldrb	r3, [r3, #0]
 80010ee:	2b7f      	cmp	r3, #127	; 0x7f
 80010f0:	d932      	bls.n	8001158 <NVIC_SetPriority+0x7c>
 80010f2:	4930      	ldr	r1, [pc, #192]	; (80011b4 <NVIC_SetPriority+0xd8>)
 80010f4:	1dfb      	adds	r3, r7, #7
 80010f6:	781b      	ldrb	r3, [r3, #0]
 80010f8:	1c1a      	adds	r2, r3, #0
 80010fa:	230f      	movs	r3, #15
 80010fc:	4013      	ands	r3, r2
 80010fe:	3b08      	subs	r3, #8
 8001100:	0898      	lsrs	r0, r3, #2
 8001102:	4a2c      	ldr	r2, [pc, #176]	; (80011b4 <NVIC_SetPriority+0xd8>)
 8001104:	1dfb      	adds	r3, r7, #7
 8001106:	781b      	ldrb	r3, [r3, #0]
 8001108:	1c1c      	adds	r4, r3, #0
 800110a:	230f      	movs	r3, #15
 800110c:	4023      	ands	r3, r4
 800110e:	3b08      	subs	r3, #8
 8001110:	089b      	lsrs	r3, r3, #2
 8001112:	3306      	adds	r3, #6
 8001114:	009b      	lsls	r3, r3, #2
 8001116:	18d3      	adds	r3, r2, r3
 8001118:	685b      	ldr	r3, [r3, #4]
 800111a:	1dfa      	adds	r2, r7, #7
 800111c:	7812      	ldrb	r2, [r2, #0]
 800111e:	1c14      	adds	r4, r2, #0
 8001120:	2203      	movs	r2, #3
 8001122:	4022      	ands	r2, r4
 8001124:	00d2      	lsls	r2, r2, #3
 8001126:	24ff      	movs	r4, #255	; 0xff
 8001128:	1c25      	adds	r5, r4, #0
 800112a:	4095      	lsls	r5, r2
 800112c:	1c2a      	adds	r2, r5, #0
 800112e:	43d2      	mvns	r2, r2
 8001130:	401a      	ands	r2, r3
 8001132:	683b      	ldr	r3, [r7, #0]
 8001134:	019c      	lsls	r4, r3, #6
 8001136:	23ff      	movs	r3, #255	; 0xff
 8001138:	401c      	ands	r4, r3
 800113a:	1dfb      	adds	r3, r7, #7
 800113c:	781b      	ldrb	r3, [r3, #0]
 800113e:	1c1d      	adds	r5, r3, #0
 8001140:	2303      	movs	r3, #3
 8001142:	402b      	ands	r3, r5
 8001144:	00db      	lsls	r3, r3, #3
 8001146:	1c25      	adds	r5, r4, #0
 8001148:	409d      	lsls	r5, r3
 800114a:	1c2b      	adds	r3, r5, #0
 800114c:	431a      	orrs	r2, r3
 800114e:	1d83      	adds	r3, r0, #6
 8001150:	009b      	lsls	r3, r3, #2
 8001152:	18cb      	adds	r3, r1, r3
 8001154:	605a      	str	r2, [r3, #4]
 8001156:	e029      	b.n	80011ac <NVIC_SetPriority+0xd0>
 8001158:	4b17      	ldr	r3, [pc, #92]	; (80011b8 <NVIC_SetPriority+0xdc>)
 800115a:	1dfa      	adds	r2, r7, #7
 800115c:	7812      	ldrb	r2, [r2, #0]
 800115e:	b252      	sxtb	r2, r2
 8001160:	0892      	lsrs	r2, r2, #2
 8001162:	4915      	ldr	r1, [pc, #84]	; (80011b8 <NVIC_SetPriority+0xdc>)
 8001164:	1df8      	adds	r0, r7, #7
 8001166:	7800      	ldrb	r0, [r0, #0]
 8001168:	b240      	sxtb	r0, r0
 800116a:	0880      	lsrs	r0, r0, #2
 800116c:	30c0      	adds	r0, #192	; 0xc0
 800116e:	0080      	lsls	r0, r0, #2
 8001170:	5841      	ldr	r1, [r0, r1]
 8001172:	1df8      	adds	r0, r7, #7
 8001174:	7800      	ldrb	r0, [r0, #0]
 8001176:	1c04      	adds	r4, r0, #0
 8001178:	2003      	movs	r0, #3
 800117a:	4020      	ands	r0, r4
 800117c:	00c0      	lsls	r0, r0, #3
 800117e:	24ff      	movs	r4, #255	; 0xff
 8001180:	1c25      	adds	r5, r4, #0
 8001182:	4085      	lsls	r5, r0
 8001184:	1c28      	adds	r0, r5, #0
 8001186:	43c0      	mvns	r0, r0
 8001188:	4008      	ands	r0, r1
 800118a:	6839      	ldr	r1, [r7, #0]
 800118c:	018c      	lsls	r4, r1, #6
 800118e:	21ff      	movs	r1, #255	; 0xff
 8001190:	400c      	ands	r4, r1
 8001192:	1df9      	adds	r1, r7, #7
 8001194:	7809      	ldrb	r1, [r1, #0]
 8001196:	1c0d      	adds	r5, r1, #0
 8001198:	2103      	movs	r1, #3
 800119a:	4029      	ands	r1, r5
 800119c:	00c9      	lsls	r1, r1, #3
 800119e:	1c25      	adds	r5, r4, #0
 80011a0:	408d      	lsls	r5, r1
 80011a2:	1c29      	adds	r1, r5, #0
 80011a4:	4301      	orrs	r1, r0
 80011a6:	32c0      	adds	r2, #192	; 0xc0
 80011a8:	0092      	lsls	r2, r2, #2
 80011aa:	50d1      	str	r1, [r2, r3]
 80011ac:	46bd      	mov	sp, r7
 80011ae:	b002      	add	sp, #8
 80011b0:	bdb0      	pop	{r4, r5, r7, pc}
 80011b2:	46c0      	nop			; (mov r8, r8)
 80011b4:	e000ed00 	.word	0xe000ed00
 80011b8:	e000e100 	.word	0xe000e100

080011bc <LL_GPIO_SetPinMode>:
 80011bc:	b580      	push	{r7, lr}
 80011be:	b084      	sub	sp, #16
 80011c0:	af00      	add	r7, sp, #0
 80011c2:	60f8      	str	r0, [r7, #12]
 80011c4:	60b9      	str	r1, [r7, #8]
 80011c6:	607a      	str	r2, [r7, #4]
 80011c8:	68fb      	ldr	r3, [r7, #12]
 80011ca:	6819      	ldr	r1, [r3, #0]
 80011cc:	68bb      	ldr	r3, [r7, #8]
 80011ce:	68ba      	ldr	r2, [r7, #8]
 80011d0:	435a      	muls	r2, r3
 80011d2:	1c13      	adds	r3, r2, #0
 80011d4:	005b      	lsls	r3, r3, #1
 80011d6:	189b      	adds	r3, r3, r2
 80011d8:	43db      	mvns	r3, r3
 80011da:	1c1a      	adds	r2, r3, #0
 80011dc:	400a      	ands	r2, r1
 80011de:	68bb      	ldr	r3, [r7, #8]
 80011e0:	68b9      	ldr	r1, [r7, #8]
 80011e2:	434b      	muls	r3, r1
 80011e4:	6879      	ldr	r1, [r7, #4]
 80011e6:	434b      	muls	r3, r1
 80011e8:	431a      	orrs	r2, r3
 80011ea:	68fb      	ldr	r3, [r7, #12]
 80011ec:	601a      	str	r2, [r3, #0]
 80011ee:	46bd      	mov	sp, r7
 80011f0:	b004      	add	sp, #16
 80011f2:	bd80      	pop	{r7, pc}

080011f4 <LL_GPIO_SetPinSpeed>:
 80011f4:	b580      	push	{r7, lr}
 80011f6:	b084      	sub	sp, #16
 80011f8:	af00      	add	r7, sp, #0
 80011fa:	60f8      	str	r0, [r7, #12]
 80011fc:	60b9      	str	r1, [r7, #8]
 80011fe:	607a      	str	r2, [r7, #4]
 8001200:	68fb      	ldr	r3, [r7, #12]
 8001202:	6899      	ldr	r1, [r3, #8]
 8001204:	68bb      	ldr	r3, [r7, #8]
 8001206:	68ba      	ldr	r2, [r7, #8]
 8001208:	435a      	muls	r2, r3
 800120a:	1c13      	adds	r3, r2, #0
 800120c:	005b      	lsls	r3, r3, #1
 800120e:	189b      	adds	r3, r3, r2
 8001210:	43db      	mvns	r3, r3
 8001212:	1c1a      	adds	r2, r3, #0
 8001214:	400a      	ands	r2, r1
 8001216:	68bb      	ldr	r3, [r7, #8]
 8001218:	68b9      	ldr	r1, [r7, #8]
 800121a:	434b      	muls	r3, r1
 800121c:	6879      	ldr	r1, [r7, #4]
 800121e:	434b      	muls	r3, r1
 8001220:	431a      	orrs	r2, r3
 8001222:	68fb      	ldr	r3, [r7, #12]
 8001224:	609a      	str	r2, [r3, #8]
 8001226:	46bd      	mov	sp, r7
 8001228:	b004      	add	sp, #16
 800122a:	bd80      	pop	{r7, pc}

0800122c <LL_GPIO_SetAFPin_0_7>:
 800122c:	b580      	push	{r7, lr}
 800122e:	b084      	sub	sp, #16
 8001230:	af00      	add	r7, sp, #0
 8001232:	60f8      	str	r0, [r7, #12]
 8001234:	60b9      	str	r1, [r7, #8]
 8001236:	607a      	str	r2, [r7, #4]
 8001238:	68fb      	ldr	r3, [r7, #12]
 800123a:	6a19      	ldr	r1, [r3, #32]
 800123c:	68bb      	ldr	r3, [r7, #8]
 800123e:	68ba      	ldr	r2, [r7, #8]
 8001240:	4353      	muls	r3, r2
 8001242:	68ba      	ldr	r2, [r7, #8]
 8001244:	4353      	muls	r3, r2
 8001246:	68ba      	ldr	r2, [r7, #8]
 8001248:	435a      	muls	r2, r3
 800124a:	1c13      	adds	r3, r2, #0
 800124c:	011b      	lsls	r3, r3, #4
 800124e:	1a9b      	subs	r3, r3, r2
 8001250:	43db      	mvns	r3, r3
 8001252:	1c1a      	adds	r2, r3, #0
 8001254:	400a      	ands	r2, r1
 8001256:	68bb      	ldr	r3, [r7, #8]
 8001258:	68b9      	ldr	r1, [r7, #8]
 800125a:	434b      	muls	r3, r1
 800125c:	68b9      	ldr	r1, [r7, #8]
 800125e:	434b      	muls	r3, r1
 8001260:	68b9      	ldr	r1, [r7, #8]
 8001262:	434b      	muls	r3, r1
 8001264:	6879      	ldr	r1, [r7, #4]
 8001266:	434b      	muls	r3, r1
 8001268:	431a      	orrs	r2, r3
 800126a:	68fb      	ldr	r3, [r7, #12]
 800126c:	621a      	str	r2, [r3, #32]
 800126e:	46bd      	mov	sp, r7
 8001270:	b004      	add	sp, #16
 8001272:	bd80      	pop	{r7, pc}

08001274 <LL_AHB1_GRP1_EnableClock>:
 8001274:	b580      	push	{r7, lr}
 8001276:	b084      	sub	sp, #16
 8001278:	af00      	add	r7, sp, #0
 800127a:	6078      	str	r0, [r7, #4]
 800127c:	4b07      	ldr	r3, [pc, #28]	; (800129c <LL_AHB1_GRP1_EnableClock+0x28>)
 800127e:	4a07      	ldr	r2, [pc, #28]	; (800129c <LL_AHB1_GRP1_EnableClock+0x28>)
 8001280:	6951      	ldr	r1, [r2, #20]
 8001282:	687a      	ldr	r2, [r7, #4]
 8001284:	430a      	orrs	r2, r1
 8001286:	615a      	str	r2, [r3, #20]
 8001288:	4b04      	ldr	r3, [pc, #16]	; (800129c <LL_AHB1_GRP1_EnableClock+0x28>)
 800128a:	695b      	ldr	r3, [r3, #20]
 800128c:	687a      	ldr	r2, [r7, #4]
 800128e:	4013      	ands	r3, r2
 8001290:	60fb      	str	r3, [r7, #12]
 8001292:	68fb      	ldr	r3, [r7, #12]
 8001294:	46bd      	mov	sp, r7
 8001296:	b004      	add	sp, #16
 8001298:	bd80      	pop	{r7, pc}
 800129a:	46c0      	nop			; (mov r8, r8)
 800129c:	40021000 	.word	0x40021000

080012a0 <LL_APB1_GRP1_EnableClock>:
 80012a0:	b580      	push	{r7, lr}
 80012a2:	b084      	sub	sp, #16
 80012a4:	af00      	add	r7, sp, #0
 80012a6:	6078      	str	r0, [r7, #4]
 80012a8:	4b07      	ldr	r3, [pc, #28]	; (80012c8 <LL_APB1_GRP1_EnableClock+0x28>)
 80012aa:	4a07      	ldr	r2, [pc, #28]	; (80012c8 <LL_APB1_GRP1_EnableClock+0x28>)
 80012ac:	69d1      	ldr	r1, [r2, #28]
 80012ae:	687a      	ldr	r2, [r7, #4]
 80012b0:	430a      	orrs	r2, r1
 80012b2:	61da      	str	r2, [r3, #28]
 80012b4:	4b04      	ldr	r3, [pc, #16]	; (80012c8 <LL_APB1_GRP1_EnableClock+0x28>)
 80012b6:	69db      	ldr	r3, [r3, #28]
 80012b8:	687a      	ldr	r2, [r7, #4]
 80012ba:	4013      	ands	r3, r2
 80012bc:	60fb      	str	r3, [r7, #12]
 80012be:	68fb      	ldr	r3, [r7, #12]
 80012c0:	46bd      	mov	sp, r7
 80012c2:	b004      	add	sp, #16
 80012c4:	bd80      	pop	{r7, pc}
 80012c6:	46c0      	nop			; (mov r8, r8)
 80012c8:	40021000 	.word	0x40021000

080012cc <LL_USART_Enable>:
 80012cc:	b580      	push	{r7, lr}
 80012ce:	b082      	sub	sp, #8
 80012d0:	af00      	add	r7, sp, #0
 80012d2:	6078      	str	r0, [r7, #4]
 80012d4:	687b      	ldr	r3, [r7, #4]
 80012d6:	681b      	ldr	r3, [r3, #0]
 80012d8:	2201      	movs	r2, #1
 80012da:	431a      	orrs	r2, r3
 80012dc:	687b      	ldr	r3, [r7, #4]
 80012de:	601a      	str	r2, [r3, #0]
 80012e0:	46bd      	mov	sp, r7
 80012e2:	b002      	add	sp, #8
 80012e4:	bd80      	pop	{r7, pc}
 80012e6:	46c0      	nop			; (mov r8, r8)

080012e8 <LL_USART_EnableDirectionRx>:
 80012e8:	b580      	push	{r7, lr}
 80012ea:	b082      	sub	sp, #8
 80012ec:	af00      	add	r7, sp, #0
 80012ee:	6078      	str	r0, [r7, #4]
 80012f0:	687b      	ldr	r3, [r7, #4]
 80012f2:	681b      	ldr	r3, [r3, #0]
 80012f4:	2204      	movs	r2, #4
 80012f6:	431a      	orrs	r2, r3
 80012f8:	687b      	ldr	r3, [r7, #4]
 80012fa:	601a      	str	r2, [r3, #0]
 80012fc:	46bd      	mov	sp, r7
 80012fe:	b002      	add	sp, #8
 8001300:	bd80      	pop	{r7, pc}
 8001302:	46c0      	nop			; (mov r8, r8)

08001304 <LL_USART_EnableDirectionTx>:
 8001304:	b580      	push	{r7, lr}
 8001306:	b082      	sub	sp, #8
 8001308:	af00      	add	r7, sp, #0
 800130a:	6078      	str	r0, [r7, #4]
 800130c:	687b      	ldr	r3, [r7, #4]
 800130e:	681b      	ldr	r3, [r3, #0]
 8001310:	2208      	movs	r2, #8
 8001312:	431a      	orrs	r2, r3
 8001314:	687b      	ldr	r3, [r7, #4]
 8001316:	601a      	str	r2, [r3, #0]
 8001318:	46bd      	mov	sp, r7
 800131a:	b002      	add	sp, #8
 800131c:	bd80      	pop	{r7, pc}
 800131e:	46c0      	nop			; (mov r8, r8)

08001320 <LL_USART_SetTransferDirection>:
 8001320:	b580      	push	{r7, lr}
 8001322:	b082      	sub	sp, #8
 8001324:	af00      	add	r7, sp, #0
 8001326:	6078      	str	r0, [r7, #4]
 8001328:	6039      	str	r1, [r7, #0]
 800132a:	687b      	ldr	r3, [r7, #4]
 800132c:	681b      	ldr	r3, [r3, #0]
 800132e:	220c      	movs	r2, #12
 8001330:	1c19      	adds	r1, r3, #0
 8001332:	4391      	bics	r1, r2
 8001334:	1c0a      	adds	r2, r1, #0
 8001336:	683b      	ldr	r3, [r7, #0]
 8001338:	431a      	orrs	r2, r3
 800133a:	687b      	ldr	r3, [r7, #4]
 800133c:	601a      	str	r2, [r3, #0]
 800133e:	46bd      	mov	sp, r7
 8001340:	b002      	add	sp, #8
 8001342:	bd80      	pop	{r7, pc}

08001344 <LL_USART_SetParity>:
 8001344:	b580      	push	{r7, lr}
 8001346:	b082      	sub	sp, #8
 8001348:	af00      	add	r7, sp, #0
 800134a:	6078      	str	r0, [r7, #4]
 800134c:	6039      	str	r1, [r7, #0]
 800134e:	687b      	ldr	r3, [r7, #4]
 8001350:	681a      	ldr	r2, [r3, #0]
 8001352:	4b04      	ldr	r3, [pc, #16]	; (8001364 <LL_USART_SetParity+0x20>)
 8001354:	401a      	ands	r2, r3
 8001356:	683b      	ldr	r3, [r7, #0]
 8001358:	431a      	orrs	r2, r3
 800135a:	687b      	ldr	r3, [r7, #4]
 800135c:	601a      	str	r2, [r3, #0]
 800135e:	46bd      	mov	sp, r7
 8001360:	b002      	add	sp, #8
 8001362:	bd80      	pop	{r7, pc}
 8001364:	fffff9ff 	.word	0xfffff9ff

08001368 <LL_USART_SetDataWidth>:
 8001368:	b580      	push	{r7, lr}
 800136a:	b082      	sub	sp, #8
 800136c:	af00      	add	r7, sp, #0
 800136e:	6078      	str	r0, [r7, #4]
 8001370:	6039      	str	r1, [r7, #0]
 8001372:	687b      	ldr	r3, [r7, #4]
 8001374:	681a      	ldr	r2, [r3, #0]
 8001376:	4b04      	ldr	r3, [pc, #16]	; (8001388 <LL_USART_SetDataWidth+0x20>)
 8001378:	401a      	ands	r2, r3
 800137a:	683b      	ldr	r3, [r7, #0]
 800137c:	431a      	orrs	r2, r3
 800137e:	687b      	ldr	r3, [r7, #4]
 8001380:	601a      	str	r2, [r3, #0]
 8001382:	46bd      	mov	sp, r7
 8001384:	b002      	add	sp, #8
 8001386:	bd80      	pop	{r7, pc}
 8001388:	ffffefff 	.word	0xffffefff

0800138c <LL_USART_SetStopBitsLength>:
 800138c:	b580      	push	{r7, lr}
 800138e:	b082      	sub	sp, #8
 8001390:	af00      	add	r7, sp, #0
 8001392:	6078      	str	r0, [r7, #4]
 8001394:	6039      	str	r1, [r7, #0]
 8001396:	687b      	ldr	r3, [r7, #4]
 8001398:	685a      	ldr	r2, [r3, #4]
 800139a:	4b04      	ldr	r3, [pc, #16]	; (80013ac <LL_USART_SetStopBitsLength+0x20>)
 800139c:	401a      	ands	r2, r3
 800139e:	683b      	ldr	r3, [r7, #0]
 80013a0:	431a      	orrs	r2, r3
 80013a2:	687b      	ldr	r3, [r7, #4]
 80013a4:	605a      	str	r2, [r3, #4]
 80013a6:	46bd      	mov	sp, r7
 80013a8:	b002      	add	sp, #8
 80013aa:	bd80      	pop	{r7, pc}
 80013ac:	ffffcfff 	.word	0xffffcfff

080013b0 <LL_USART_SetBaudRate>:
 80013b0:	b5b0      	push	{r4, r5, r7, lr}
 80013b2:	b084      	sub	sp, #16
 80013b4:	af00      	add	r7, sp, #0
 80013b6:	60f8      	str	r0, [r7, #12]
 80013b8:	60b9      	str	r1, [r7, #8]
 80013ba:	607a      	str	r2, [r7, #4]
 80013bc:	603b      	str	r3, [r7, #0]
 80013be:	2500      	movs	r5, #0
 80013c0:	2400      	movs	r4, #0
 80013c2:	687a      	ldr	r2, [r7, #4]
 80013c4:	2380      	movs	r3, #128	; 0x80
 80013c6:	021b      	lsls	r3, r3, #8
 80013c8:	429a      	cmp	r2, r3
 80013ca:	d116      	bne.n	80013fa <LL_USART_SetBaudRate+0x4a>
 80013cc:	68bb      	ldr	r3, [r7, #8]
 80013ce:	005a      	lsls	r2, r3, #1
 80013d0:	683b      	ldr	r3, [r7, #0]
 80013d2:	085b      	lsrs	r3, r3, #1
 80013d4:	18d3      	adds	r3, r2, r3
 80013d6:	1c18      	adds	r0, r3, #0
 80013d8:	6839      	ldr	r1, [r7, #0]
 80013da:	f7fe fea1 	bl	8000120 <__aeabi_uidiv>
 80013de:	1c03      	adds	r3, r0, #0
 80013e0:	b29b      	uxth	r3, r3
 80013e2:	1c1d      	adds	r5, r3, #0
 80013e4:	4b0d      	ldr	r3, [pc, #52]	; (800141c <LL_USART_SetBaudRate+0x6c>)
 80013e6:	1c2c      	adds	r4, r5, #0
 80013e8:	401c      	ands	r4, r3
 80013ea:	230f      	movs	r3, #15
 80013ec:	402b      	ands	r3, r5
 80013ee:	085b      	lsrs	r3, r3, #1
 80013f0:	b29b      	uxth	r3, r3
 80013f2:	431c      	orrs	r4, r3
 80013f4:	68fb      	ldr	r3, [r7, #12]
 80013f6:	60dc      	str	r4, [r3, #12]
 80013f8:	e00c      	b.n	8001414 <LL_USART_SetBaudRate+0x64>
 80013fa:	683b      	ldr	r3, [r7, #0]
 80013fc:	085a      	lsrs	r2, r3, #1
 80013fe:	68bb      	ldr	r3, [r7, #8]
 8001400:	18d3      	adds	r3, r2, r3
 8001402:	1c18      	adds	r0, r3, #0
 8001404:	6839      	ldr	r1, [r7, #0]
 8001406:	f7fe fe8b 	bl	8000120 <__aeabi_uidiv>
 800140a:	1c03      	adds	r3, r0, #0
 800140c:	b29b      	uxth	r3, r3
 800140e:	1c1a      	adds	r2, r3, #0
 8001410:	68fb      	ldr	r3, [r7, #12]
 8001412:	60da      	str	r2, [r3, #12]
 8001414:	46bd      	mov	sp, r7
 8001416:	b004      	add	sp, #16
 8001418:	bdb0      	pop	{r4, r5, r7, pc}
 800141a:	46c0      	nop			; (mov r8, r8)
 800141c:	0000fff0 	.word	0x0000fff0

08001420 <LL_USART_EnableDMAReq_RX>:
 8001420:	b580      	push	{r7, lr}
 8001422:	b082      	sub	sp, #8
 8001424:	af00      	add	r7, sp, #0
 8001426:	6078      	str	r0, [r7, #4]
 8001428:	687b      	ldr	r3, [r7, #4]
 800142a:	689b      	ldr	r3, [r3, #8]
 800142c:	2240      	movs	r2, #64	; 0x40
 800142e:	431a      	orrs	r2, r3
 8001430:	687b      	ldr	r3, [r7, #4]
 8001432:	609a      	str	r2, [r3, #8]
 8001434:	46bd      	mov	sp, r7
 8001436:	b002      	add	sp, #8
 8001438:	bd80      	pop	{r7, pc}
 800143a:	46c0      	nop			; (mov r8, r8)

0800143c <LL_DMA_EnableChannel>:
 800143c:	b580      	push	{r7, lr}
 800143e:	b082      	sub	sp, #8
 8001440:	af00      	add	r7, sp, #0
 8001442:	6078      	str	r0, [r7, #4]
 8001444:	6039      	str	r1, [r7, #0]
 8001446:	683b      	ldr	r3, [r7, #0]
 8001448:	3b01      	subs	r3, #1
 800144a:	4a09      	ldr	r2, [pc, #36]	; (8001470 <LL_DMA_EnableChannel+0x34>)
 800144c:	5cd3      	ldrb	r3, [r2, r3]
 800144e:	1c1a      	adds	r2, r3, #0
 8001450:	687b      	ldr	r3, [r7, #4]
 8001452:	18d3      	adds	r3, r2, r3
 8001454:	683a      	ldr	r2, [r7, #0]
 8001456:	3a01      	subs	r2, #1
 8001458:	4905      	ldr	r1, [pc, #20]	; (8001470 <LL_DMA_EnableChannel+0x34>)
 800145a:	5c8a      	ldrb	r2, [r1, r2]
 800145c:	1c11      	adds	r1, r2, #0
 800145e:	687a      	ldr	r2, [r7, #4]
 8001460:	188a      	adds	r2, r1, r2
 8001462:	6812      	ldr	r2, [r2, #0]
 8001464:	2101      	movs	r1, #1
 8001466:	430a      	orrs	r2, r1
 8001468:	601a      	str	r2, [r3, #0]
 800146a:	46bd      	mov	sp, r7
 800146c:	b002      	add	sp, #8
 800146e:	bd80      	pop	{r7, pc}
 8001470:	08001aac 	.word	0x08001aac

08001474 <LL_DMA_SetMode>:
 8001474:	b580      	push	{r7, lr}
 8001476:	b084      	sub	sp, #16
 8001478:	af00      	add	r7, sp, #0
 800147a:	60f8      	str	r0, [r7, #12]
 800147c:	60b9      	str	r1, [r7, #8]
 800147e:	607a      	str	r2, [r7, #4]
 8001480:	68bb      	ldr	r3, [r7, #8]
 8001482:	3b01      	subs	r3, #1
 8001484:	4a0b      	ldr	r2, [pc, #44]	; (80014b4 <LL_DMA_SetMode+0x40>)
 8001486:	5cd3      	ldrb	r3, [r2, r3]
 8001488:	1c1a      	adds	r2, r3, #0
 800148a:	68fb      	ldr	r3, [r7, #12]
 800148c:	18d3      	adds	r3, r2, r3
 800148e:	68ba      	ldr	r2, [r7, #8]
 8001490:	3a01      	subs	r2, #1
 8001492:	4908      	ldr	r1, [pc, #32]	; (80014b4 <LL_DMA_SetMode+0x40>)
 8001494:	5c8a      	ldrb	r2, [r1, r2]
 8001496:	1c11      	adds	r1, r2, #0
 8001498:	68fa      	ldr	r2, [r7, #12]
 800149a:	188a      	adds	r2, r1, r2
 800149c:	6812      	ldr	r2, [r2, #0]
 800149e:	2120      	movs	r1, #32
 80014a0:	1c10      	adds	r0, r2, #0
 80014a2:	4388      	bics	r0, r1
 80014a4:	1c01      	adds	r1, r0, #0
 80014a6:	687a      	ldr	r2, [r7, #4]
 80014a8:	430a      	orrs	r2, r1
 80014aa:	601a      	str	r2, [r3, #0]
 80014ac:	46bd      	mov	sp, r7
 80014ae:	b004      	add	sp, #16
 80014b0:	bd80      	pop	{r7, pc}
 80014b2:	46c0      	nop			; (mov r8, r8)
 80014b4:	08001aac 	.word	0x08001aac

080014b8 <LL_DMA_SetMemoryIncMode>:
 80014b8:	b580      	push	{r7, lr}
 80014ba:	b084      	sub	sp, #16
 80014bc:	af00      	add	r7, sp, #0
 80014be:	60f8      	str	r0, [r7, #12]
 80014c0:	60b9      	str	r1, [r7, #8]
 80014c2:	607a      	str	r2, [r7, #4]
 80014c4:	68bb      	ldr	r3, [r7, #8]
 80014c6:	3b01      	subs	r3, #1
 80014c8:	4a0b      	ldr	r2, [pc, #44]	; (80014f8 <LL_DMA_SetMemoryIncMode+0x40>)
 80014ca:	5cd3      	ldrb	r3, [r2, r3]
 80014cc:	1c1a      	adds	r2, r3, #0
 80014ce:	68fb      	ldr	r3, [r7, #12]
 80014d0:	18d3      	adds	r3, r2, r3
 80014d2:	68ba      	ldr	r2, [r7, #8]
 80014d4:	3a01      	subs	r2, #1
 80014d6:	4908      	ldr	r1, [pc, #32]	; (80014f8 <LL_DMA_SetMemoryIncMode+0x40>)
 80014d8:	5c8a      	ldrb	r2, [r1, r2]
 80014da:	1c11      	adds	r1, r2, #0
 80014dc:	68fa      	ldr	r2, [r7, #12]
 80014de:	188a      	adds	r2, r1, r2
 80014e0:	6812      	ldr	r2, [r2, #0]
 80014e2:	2180      	movs	r1, #128	; 0x80
 80014e4:	1c10      	adds	r0, r2, #0
 80014e6:	4388      	bics	r0, r1
 80014e8:	1c01      	adds	r1, r0, #0
 80014ea:	687a      	ldr	r2, [r7, #4]
 80014ec:	430a      	orrs	r2, r1
 80014ee:	601a      	str	r2, [r3, #0]
 80014f0:	46bd      	mov	sp, r7
 80014f2:	b004      	add	sp, #16
 80014f4:	bd80      	pop	{r7, pc}
 80014f6:	46c0      	nop			; (mov r8, r8)
 80014f8:	08001aac 	.word	0x08001aac

080014fc <LL_DMA_SetDataLength>:
 80014fc:	b580      	push	{r7, lr}
 80014fe:	b084      	sub	sp, #16
 8001500:	af00      	add	r7, sp, #0
 8001502:	60f8      	str	r0, [r7, #12]
 8001504:	60b9      	str	r1, [r7, #8]
 8001506:	607a      	str	r2, [r7, #4]
 8001508:	68bb      	ldr	r3, [r7, #8]
 800150a:	3b01      	subs	r3, #1
 800150c:	4a0a      	ldr	r2, [pc, #40]	; (8001538 <LL_DMA_SetDataLength+0x3c>)
 800150e:	5cd3      	ldrb	r3, [r2, r3]
 8001510:	1c1a      	adds	r2, r3, #0
 8001512:	68fb      	ldr	r3, [r7, #12]
 8001514:	18d3      	adds	r3, r2, r3
 8001516:	68ba      	ldr	r2, [r7, #8]
 8001518:	3a01      	subs	r2, #1
 800151a:	4907      	ldr	r1, [pc, #28]	; (8001538 <LL_DMA_SetDataLength+0x3c>)
 800151c:	5c8a      	ldrb	r2, [r1, r2]
 800151e:	1c11      	adds	r1, r2, #0
 8001520:	68fa      	ldr	r2, [r7, #12]
 8001522:	188a      	adds	r2, r1, r2
 8001524:	6852      	ldr	r2, [r2, #4]
 8001526:	0c12      	lsrs	r2, r2, #16
 8001528:	0411      	lsls	r1, r2, #16
 800152a:	687a      	ldr	r2, [r7, #4]
 800152c:	430a      	orrs	r2, r1
 800152e:	605a      	str	r2, [r3, #4]
 8001530:	46bd      	mov	sp, r7
 8001532:	b004      	add	sp, #16
 8001534:	bd80      	pop	{r7, pc}
 8001536:	46c0      	nop			; (mov r8, r8)
 8001538:	08001aac 	.word	0x08001aac

0800153c <LL_DMA_ConfigAddresses>:
 800153c:	b580      	push	{r7, lr}
 800153e:	b084      	sub	sp, #16
 8001540:	af00      	add	r7, sp, #0
 8001542:	60f8      	str	r0, [r7, #12]
 8001544:	60b9      	str	r1, [r7, #8]
 8001546:	607a      	str	r2, [r7, #4]
 8001548:	603b      	str	r3, [r7, #0]
 800154a:	69bb      	ldr	r3, [r7, #24]
 800154c:	2b10      	cmp	r3, #16
 800154e:	d112      	bne.n	8001576 <LL_DMA_ConfigAddresses+0x3a>
 8001550:	68bb      	ldr	r3, [r7, #8]
 8001552:	3b01      	subs	r3, #1
 8001554:	4a12      	ldr	r2, [pc, #72]	; (80015a0 <LL_DMA_ConfigAddresses+0x64>)
 8001556:	5cd3      	ldrb	r3, [r2, r3]
 8001558:	1c1a      	adds	r2, r3, #0
 800155a:	68fb      	ldr	r3, [r7, #12]
 800155c:	18d3      	adds	r3, r2, r3
 800155e:	687a      	ldr	r2, [r7, #4]
 8001560:	60da      	str	r2, [r3, #12]
 8001562:	68bb      	ldr	r3, [r7, #8]
 8001564:	3b01      	subs	r3, #1
 8001566:	4a0e      	ldr	r2, [pc, #56]	; (80015a0 <LL_DMA_ConfigAddresses+0x64>)
 8001568:	5cd3      	ldrb	r3, [r2, r3]
 800156a:	1c1a      	adds	r2, r3, #0
 800156c:	68fb      	ldr	r3, [r7, #12]
 800156e:	18d3      	adds	r3, r2, r3
 8001570:	683a      	ldr	r2, [r7, #0]
 8001572:	609a      	str	r2, [r3, #8]
 8001574:	e011      	b.n	800159a <LL_DMA_ConfigAddresses+0x5e>
 8001576:	68bb      	ldr	r3, [r7, #8]
 8001578:	3b01      	subs	r3, #1
 800157a:	4a09      	ldr	r2, [pc, #36]	; (80015a0 <LL_DMA_ConfigAddresses+0x64>)
 800157c:	5cd3      	ldrb	r3, [r2, r3]
 800157e:	1c1a      	adds	r2, r3, #0
 8001580:	68fb      	ldr	r3, [r7, #12]
 8001582:	18d3      	adds	r3, r2, r3
 8001584:	687a      	ldr	r2, [r7, #4]
 8001586:	609a      	str	r2, [r3, #8]
 8001588:	68bb      	ldr	r3, [r7, #8]
 800158a:	3b01      	subs	r3, #1
 800158c:	4a04      	ldr	r2, [pc, #16]	; (80015a0 <LL_DMA_ConfigAddresses+0x64>)
 800158e:	5cd3      	ldrb	r3, [r2, r3]
 8001590:	1c1a      	adds	r2, r3, #0
 8001592:	68fb      	ldr	r3, [r7, #12]
 8001594:	18d3      	adds	r3, r2, r3
 8001596:	683a      	ldr	r2, [r7, #0]
 8001598:	60da      	str	r2, [r3, #12]
 800159a:	46bd      	mov	sp, r7
 800159c:	b004      	add	sp, #16
 800159e:	bd80      	pop	{r7, pc}
 80015a0:	08001aac 	.word	0x08001aac

080015a4 <LL_DMA_IsActiveFlag_TC5>:
 80015a4:	b580      	push	{r7, lr}
 80015a6:	b082      	sub	sp, #8
 80015a8:	af00      	add	r7, sp, #0
 80015aa:	6078      	str	r0, [r7, #4]
 80015ac:	687b      	ldr	r3, [r7, #4]
 80015ae:	681a      	ldr	r2, [r3, #0]
 80015b0:	2380      	movs	r3, #128	; 0x80
 80015b2:	029b      	lsls	r3, r3, #10
 80015b4:	4013      	ands	r3, r2
 80015b6:	1e5a      	subs	r2, r3, #1
 80015b8:	4193      	sbcs	r3, r2
 80015ba:	b2db      	uxtb	r3, r3
 80015bc:	1c18      	adds	r0, r3, #0
 80015be:	46bd      	mov	sp, r7
 80015c0:	b002      	add	sp, #8
 80015c2:	bd80      	pop	{r7, pc}

080015c4 <LL_DMA_ClearFlag_TC5>:
 80015c4:	b580      	push	{r7, lr}
 80015c6:	b082      	sub	sp, #8
 80015c8:	af00      	add	r7, sp, #0
 80015ca:	6078      	str	r0, [r7, #4]
 80015cc:	687b      	ldr	r3, [r7, #4]
 80015ce:	2280      	movs	r2, #128	; 0x80
 80015d0:	0292      	lsls	r2, r2, #10
 80015d2:	605a      	str	r2, [r3, #4]
 80015d4:	46bd      	mov	sp, r7
 80015d6:	b002      	add	sp, #8
 80015d8:	bd80      	pop	{r7, pc}
 80015da:	46c0      	nop			; (mov r8, r8)

080015dc <LL_DMA_ClearFlag_HT5>:
 80015dc:	b580      	push	{r7, lr}
 80015de:	b082      	sub	sp, #8
 80015e0:	af00      	add	r7, sp, #0
 80015e2:	6078      	str	r0, [r7, #4]
 80015e4:	687b      	ldr	r3, [r7, #4]
 80015e6:	2280      	movs	r2, #128	; 0x80
 80015e8:	02d2      	lsls	r2, r2, #11
 80015ea:	605a      	str	r2, [r3, #4]
 80015ec:	46bd      	mov	sp, r7
 80015ee:	b002      	add	sp, #8
 80015f0:	bd80      	pop	{r7, pc}
 80015f2:	46c0      	nop			; (mov r8, r8)

080015f4 <LL_DMA_EnableIT_TC>:
 80015f4:	b580      	push	{r7, lr}
 80015f6:	b082      	sub	sp, #8
 80015f8:	af00      	add	r7, sp, #0
 80015fa:	6078      	str	r0, [r7, #4]
 80015fc:	6039      	str	r1, [r7, #0]
 80015fe:	683b      	ldr	r3, [r7, #0]
 8001600:	3b01      	subs	r3, #1
 8001602:	4a09      	ldr	r2, [pc, #36]	; (8001628 <LL_DMA_EnableIT_TC+0x34>)
 8001604:	5cd3      	ldrb	r3, [r2, r3]
 8001606:	1c1a      	adds	r2, r3, #0
 8001608:	687b      	ldr	r3, [r7, #4]
 800160a:	18d3      	adds	r3, r2, r3
 800160c:	683a      	ldr	r2, [r7, #0]
 800160e:	3a01      	subs	r2, #1
 8001610:	4905      	ldr	r1, [pc, #20]	; (8001628 <LL_DMA_EnableIT_TC+0x34>)
 8001612:	5c8a      	ldrb	r2, [r1, r2]
 8001614:	1c11      	adds	r1, r2, #0
 8001616:	687a      	ldr	r2, [r7, #4]
 8001618:	188a      	adds	r2, r1, r2
 800161a:	6812      	ldr	r2, [r2, #0]
 800161c:	2102      	movs	r1, #2
 800161e:	430a      	orrs	r2, r1
 8001620:	601a      	str	r2, [r3, #0]
 8001622:	46bd      	mov	sp, r7
 8001624:	b002      	add	sp, #8
 8001626:	bd80      	pop	{r7, pc}
 8001628:	08001aac 	.word	0x08001aac

0800162c <fsm_term_init>:
 800162c:	b580      	push	{r7, lr}
 800162e:	b084      	sub	sp, #16
 8001630:	af02      	add	r7, sp, #8
 8001632:	6078      	str	r0, [r7, #4]
 8001634:	4a4d      	ldr	r2, [pc, #308]	; (800176c <fsm_term_init+0x140>)
 8001636:	23ff      	movs	r3, #255	; 0xff
 8001638:	2100      	movs	r1, #0
 800163a:	54d1      	strb	r1, [r2, r3]
 800163c:	2380      	movs	r3, #128	; 0x80
 800163e:	029b      	lsls	r3, r3, #10
 8001640:	1c18      	adds	r0, r3, #0
 8001642:	f7ff fe17 	bl	8001274 <LL_AHB1_GRP1_EnableClock>
 8001646:	2390      	movs	r3, #144	; 0x90
 8001648:	05db      	lsls	r3, r3, #23
 800164a:	1c18      	adds	r0, r3, #0
 800164c:	2104      	movs	r1, #4
 800164e:	2202      	movs	r2, #2
 8001650:	f7ff fdb4 	bl	80011bc <LL_GPIO_SetPinMode>
 8001654:	2390      	movs	r3, #144	; 0x90
 8001656:	05db      	lsls	r3, r3, #23
 8001658:	1c18      	adds	r0, r3, #0
 800165a:	2104      	movs	r1, #4
 800165c:	2201      	movs	r2, #1
 800165e:	f7ff fde5 	bl	800122c <LL_GPIO_SetAFPin_0_7>
 8001662:	2390      	movs	r3, #144	; 0x90
 8001664:	05db      	lsls	r3, r3, #23
 8001666:	1c18      	adds	r0, r3, #0
 8001668:	2104      	movs	r1, #4
 800166a:	2203      	movs	r2, #3
 800166c:	f7ff fdc2 	bl	80011f4 <LL_GPIO_SetPinSpeed>
 8001670:	2390      	movs	r3, #144	; 0x90
 8001672:	05db      	lsls	r3, r3, #23
 8001674:	1c18      	adds	r0, r3, #0
 8001676:	2108      	movs	r1, #8
 8001678:	2202      	movs	r2, #2
 800167a:	f7ff fd9f 	bl	80011bc <LL_GPIO_SetPinMode>
 800167e:	2390      	movs	r3, #144	; 0x90
 8001680:	05db      	lsls	r3, r3, #23
 8001682:	1c18      	adds	r0, r3, #0
 8001684:	2108      	movs	r1, #8
 8001686:	2201      	movs	r2, #1
 8001688:	f7ff fdd0 	bl	800122c <LL_GPIO_SetAFPin_0_7>
 800168c:	2390      	movs	r3, #144	; 0x90
 800168e:	05db      	lsls	r3, r3, #23
 8001690:	1c18      	adds	r0, r3, #0
 8001692:	2108      	movs	r1, #8
 8001694:	2203      	movs	r2, #3
 8001696:	f7ff fdad 	bl	80011f4 <LL_GPIO_SetPinSpeed>
 800169a:	2380      	movs	r3, #128	; 0x80
 800169c:	029b      	lsls	r3, r3, #10
 800169e:	1c18      	adds	r0, r3, #0
 80016a0:	f7ff fdfe 	bl	80012a0 <LL_APB1_GRP1_EnableClock>
 80016a4:	4b32      	ldr	r3, [pc, #200]	; (8001770 <fsm_term_init+0x144>)
 80016a6:	1c18      	adds	r0, r3, #0
 80016a8:	210c      	movs	r1, #12
 80016aa:	f7ff fe39 	bl	8001320 <LL_USART_SetTransferDirection>
 80016ae:	4b30      	ldr	r3, [pc, #192]	; (8001770 <fsm_term_init+0x144>)
 80016b0:	1c18      	adds	r0, r3, #0
 80016b2:	2100      	movs	r1, #0
 80016b4:	f7ff fe46 	bl	8001344 <LL_USART_SetParity>
 80016b8:	4b2d      	ldr	r3, [pc, #180]	; (8001770 <fsm_term_init+0x144>)
 80016ba:	1c18      	adds	r0, r3, #0
 80016bc:	2100      	movs	r1, #0
 80016be:	f7ff fe53 	bl	8001368 <LL_USART_SetDataWidth>
 80016c2:	4b2b      	ldr	r3, [pc, #172]	; (8001770 <fsm_term_init+0x144>)
 80016c4:	1c18      	adds	r0, r3, #0
 80016c6:	2100      	movs	r1, #0
 80016c8:	f7ff fe60 	bl	800138c <LL_USART_SetStopBitsLength>
 80016cc:	4b29      	ldr	r3, [pc, #164]	; (8001774 <fsm_term_init+0x148>)
 80016ce:	681a      	ldr	r2, [r3, #0]
 80016d0:	4927      	ldr	r1, [pc, #156]	; (8001770 <fsm_term_init+0x144>)
 80016d2:	23e1      	movs	r3, #225	; 0xe1
 80016d4:	025b      	lsls	r3, r3, #9
 80016d6:	1c08      	adds	r0, r1, #0
 80016d8:	1c11      	adds	r1, r2, #0
 80016da:	2200      	movs	r2, #0
 80016dc:	f7ff fe68 	bl	80013b0 <LL_USART_SetBaudRate>
 80016e0:	4b23      	ldr	r3, [pc, #140]	; (8001770 <fsm_term_init+0x144>)
 80016e2:	1c18      	adds	r0, r3, #0
 80016e4:	f7ff fe9c 	bl	8001420 <LL_USART_EnableDMAReq_RX>
 80016e8:	4b21      	ldr	r3, [pc, #132]	; (8001770 <fsm_term_init+0x144>)
 80016ea:	1c18      	adds	r0, r3, #0
 80016ec:	f7ff fdfc 	bl	80012e8 <LL_USART_EnableDirectionRx>
 80016f0:	4b1f      	ldr	r3, [pc, #124]	; (8001770 <fsm_term_init+0x144>)
 80016f2:	1c18      	adds	r0, r3, #0
 80016f4:	f7ff fe06 	bl	8001304 <LL_USART_EnableDirectionTx>
 80016f8:	2001      	movs	r0, #1
 80016fa:	f7ff fdbb 	bl	8001274 <LL_AHB1_GRP1_EnableClock>
 80016fe:	4b1b      	ldr	r3, [pc, #108]	; (800176c <fsm_term_init+0x140>)
 8001700:	491d      	ldr	r1, [pc, #116]	; (8001778 <fsm_term_init+0x14c>)
 8001702:	4a1e      	ldr	r2, [pc, #120]	; (800177c <fsm_term_init+0x150>)
 8001704:	2000      	movs	r0, #0
 8001706:	9000      	str	r0, [sp, #0]
 8001708:	1c08      	adds	r0, r1, #0
 800170a:	2105      	movs	r1, #5
 800170c:	f7ff ff16 	bl	800153c <LL_DMA_ConfigAddresses>
 8001710:	4b19      	ldr	r3, [pc, #100]	; (8001778 <fsm_term_init+0x14c>)
 8001712:	1c18      	adds	r0, r3, #0
 8001714:	2105      	movs	r1, #5
 8001716:	220a      	movs	r2, #10
 8001718:	f7ff fef0 	bl	80014fc <LL_DMA_SetDataLength>
 800171c:	4b16      	ldr	r3, [pc, #88]	; (8001778 <fsm_term_init+0x14c>)
 800171e:	1c18      	adds	r0, r3, #0
 8001720:	2105      	movs	r1, #5
 8001722:	2280      	movs	r2, #128	; 0x80
 8001724:	f7ff fec8 	bl	80014b8 <LL_DMA_SetMemoryIncMode>
 8001728:	4b13      	ldr	r3, [pc, #76]	; (8001778 <fsm_term_init+0x14c>)
 800172a:	1c18      	adds	r0, r3, #0
 800172c:	2105      	movs	r1, #5
 800172e:	2220      	movs	r2, #32
 8001730:	f7ff fea0 	bl	8001474 <LL_DMA_SetMode>
 8001734:	4b10      	ldr	r3, [pc, #64]	; (8001778 <fsm_term_init+0x14c>)
 8001736:	1c18      	adds	r0, r3, #0
 8001738:	2105      	movs	r1, #5
 800173a:	f7ff ff5b 	bl	80015f4 <LL_DMA_EnableIT_TC>
 800173e:	200b      	movs	r0, #11
 8001740:	2102      	movs	r1, #2
 8001742:	f7ff fccb 	bl	80010dc <NVIC_SetPriority>
 8001746:	200b      	movs	r0, #11
 8001748:	f7ff fcb2 	bl	80010b0 <NVIC_EnableIRQ>
 800174c:	4b08      	ldr	r3, [pc, #32]	; (8001770 <fsm_term_init+0x144>)
 800174e:	1c18      	adds	r0, r3, #0
 8001750:	f7ff fdbc 	bl	80012cc <LL_USART_Enable>
 8001754:	4b08      	ldr	r3, [pc, #32]	; (8001778 <fsm_term_init+0x14c>)
 8001756:	1c18      	adds	r0, r3, #0
 8001758:	2105      	movs	r1, #5
 800175a:	f7ff fe6f 	bl	800143c <LL_DMA_EnableChannel>
 800175e:	2007      	movs	r0, #7
 8001760:	f7ff fc6c 	bl	800103c <fsm_set_state>
 8001764:	46c0      	nop			; (mov r8, r8)
 8001766:	46bd      	mov	sp, r7
 8001768:	b002      	add	sp, #8
 800176a:	bd80      	pop	{r7, pc}
 800176c:	200004e0 	.word	0x200004e0
 8001770:	40004400 	.word	0x40004400
 8001774:	20000000 	.word	0x20000000
 8001778:	40020000 	.word	0x40020000
 800177c:	40004424 	.word	0x40004424

08001780 <fsm_term_main>:
 8001780:	b580      	push	{r7, lr}
 8001782:	b086      	sub	sp, #24
 8001784:	af00      	add	r7, sp, #0
 8001786:	6078      	str	r0, [r7, #4]
 8001788:	1c3b      	adds	r3, r7, #0
 800178a:	3317      	adds	r3, #23
 800178c:	2200      	movs	r2, #0
 800178e:	701a      	strb	r2, [r3, #0]
 8001790:	4a20      	ldr	r2, [pc, #128]	; (8001814 <fsm_term_main+0x94>)
 8001792:	23ff      	movs	r3, #255	; 0xff
 8001794:	5cd3      	ldrb	r3, [r2, r3]
 8001796:	1c1a      	adds	r2, r3, #0
 8001798:	2301      	movs	r3, #1
 800179a:	4013      	ands	r3, r2
 800179c:	d036      	beq.n	800180c <fsm_term_main+0x8c>
 800179e:	4a1d      	ldr	r2, [pc, #116]	; (8001814 <fsm_term_main+0x94>)
 80017a0:	23ff      	movs	r3, #255	; 0xff
 80017a2:	5cd3      	ldrb	r3, [r2, r3]
 80017a4:	2201      	movs	r2, #1
 80017a6:	4393      	bics	r3, r2
 80017a8:	b2d9      	uxtb	r1, r3
 80017aa:	4a1a      	ldr	r2, [pc, #104]	; (8001814 <fsm_term_main+0x94>)
 80017ac:	23ff      	movs	r3, #255	; 0xff
 80017ae:	54d1      	strb	r1, [r2, r3]
 80017b0:	1c3b      	adds	r3, r7, #0
 80017b2:	3317      	adds	r3, #23
 80017b4:	4a17      	ldr	r2, [pc, #92]	; (8001814 <fsm_term_main+0x94>)
 80017b6:	7812      	ldrb	r2, [r2, #0]
 80017b8:	701a      	strb	r2, [r3, #0]
 80017ba:	1c3b      	adds	r3, r7, #0
 80017bc:	3317      	adds	r3, #23
 80017be:	781b      	ldrb	r3, [r3, #0]
 80017c0:	2b00      	cmp	r3, #0
 80017c2:	d023      	beq.n	800180c <fsm_term_main+0x8c>
 80017c4:	1c3b      	adds	r3, r7, #0
 80017c6:	3317      	adds	r3, #23
 80017c8:	781b      	ldrb	r3, [r3, #0]
 80017ca:	2b01      	cmp	r3, #1
 80017cc:	d81e      	bhi.n	800180c <fsm_term_main+0x8c>
 80017ce:	1c3b      	adds	r3, r7, #0
 80017d0:	3317      	adds	r3, #23
 80017d2:	781a      	ldrb	r2, [r3, #0]
 80017d4:	4b10      	ldr	r3, [pc, #64]	; (8001818 <fsm_term_main+0x98>)
 80017d6:	0092      	lsls	r2, r2, #2
 80017d8:	58d3      	ldr	r3, [r2, r3]
 80017da:	2b00      	cmp	r3, #0
 80017dc:	d016      	beq.n	800180c <fsm_term_main+0x8c>
 80017de:	1c39      	adds	r1, r7, #0
 80017e0:	310c      	adds	r1, #12
 80017e2:	4a0c      	ldr	r2, [pc, #48]	; (8001814 <fsm_term_main+0x94>)
 80017e4:	2301      	movs	r3, #1
 80017e6:	18d2      	adds	r2, r2, r3
 80017e8:	2309      	movs	r3, #9
 80017ea:	1c08      	adds	r0, r1, #0
 80017ec:	1c11      	adds	r1, r2, #0
 80017ee:	1c1a      	adds	r2, r3, #0
 80017f0:	f000 f866 	bl	80018c0 <memcpy>
 80017f4:	1c3b      	adds	r3, r7, #0
 80017f6:	3317      	adds	r3, #23
 80017f8:	781b      	ldrb	r3, [r3, #0]
 80017fa:	1c1a      	adds	r2, r3, #0
 80017fc:	320a      	adds	r2, #10
 80017fe:	4b06      	ldr	r3, [pc, #24]	; (8001818 <fsm_term_main+0x98>)
 8001800:	0092      	lsls	r2, r2, #2
 8001802:	58d3      	ldr	r3, [r2, r3]
 8001804:	1c3a      	adds	r2, r7, #0
 8001806:	320c      	adds	r2, #12
 8001808:	1c10      	adds	r0, r2, #0
 800180a:	4798      	blx	r3
 800180c:	46c0      	nop			; (mov r8, r8)
 800180e:	46bd      	mov	sp, r7
 8001810:	b006      	add	sp, #24
 8001812:	bd80      	pop	{r7, pc}
 8001814:	200004e0 	.word	0x200004e0
 8001818:	08001a7c 	.word	0x08001a7c

0800181c <fsm_term_handlers_start>:
 800181c:	b580      	push	{r7, lr}
 800181e:	b082      	sub	sp, #8
 8001820:	af00      	add	r7, sp, #0
 8001822:	6078      	str	r0, [r7, #4]
 8001824:	46c0      	nop			; (mov r8, r8)
 8001826:	46bd      	mov	sp, r7
 8001828:	b002      	add	sp, #8
 800182a:	bd80      	pop	{r7, pc}

0800182c <DMA1_Channel4_5_IRQHandler>:
 800182c:	b580      	push	{r7, lr}
 800182e:	af00      	add	r7, sp, #0
 8001830:	4b0f      	ldr	r3, [pc, #60]	; (8001870 <DMA1_Channel4_5_IRQHandler+0x44>)
 8001832:	1c18      	adds	r0, r3, #0
 8001834:	f7ff feb6 	bl	80015a4 <LL_DMA_IsActiveFlag_TC5>
 8001838:	1c03      	adds	r3, r0, #0
 800183a:	2b00      	cmp	r3, #0
 800183c:	d015      	beq.n	800186a <DMA1_Channel4_5_IRQHandler+0x3e>
 800183e:	4b0c      	ldr	r3, [pc, #48]	; (8001870 <DMA1_Channel4_5_IRQHandler+0x44>)
 8001840:	1c18      	adds	r0, r3, #0
 8001842:	f7ff febf 	bl	80015c4 <LL_DMA_ClearFlag_TC5>
 8001846:	4b0a      	ldr	r3, [pc, #40]	; (8001870 <DMA1_Channel4_5_IRQHandler+0x44>)
 8001848:	1c18      	adds	r0, r3, #0
 800184a:	f7ff fec7 	bl	80015dc <LL_DMA_ClearFlag_HT5>
 800184e:	4b08      	ldr	r3, [pc, #32]	; (8001870 <DMA1_Channel4_5_IRQHandler+0x44>)
 8001850:	1c18      	adds	r0, r3, #0
 8001852:	2105      	movs	r1, #5
 8001854:	f7ff fdf2 	bl	800143c <LL_DMA_EnableChannel>
 8001858:	4a06      	ldr	r2, [pc, #24]	; (8001874 <DMA1_Channel4_5_IRQHandler+0x48>)
 800185a:	23ff      	movs	r3, #255	; 0xff
 800185c:	5cd3      	ldrb	r3, [r2, r3]
 800185e:	2201      	movs	r2, #1
 8001860:	4313      	orrs	r3, r2
 8001862:	b2d9      	uxtb	r1, r3
 8001864:	4a03      	ldr	r2, [pc, #12]	; (8001874 <DMA1_Channel4_5_IRQHandler+0x48>)
 8001866:	23ff      	movs	r3, #255	; 0xff
 8001868:	54d1      	strb	r1, [r2, r3]
 800186a:	46bd      	mov	sp, r7
 800186c:	bd80      	pop	{r7, pc}
 800186e:	46c0      	nop			; (mov r8, r8)
 8001870:	40020000 	.word	0x40020000
 8001874:	200004e0 	.word	0x200004e0

08001878 <__libc_init_array>:
 8001878:	b570      	push	{r4, r5, r6, lr}
 800187a:	4e0d      	ldr	r6, [pc, #52]	; (80018b0 <__libc_init_array+0x38>)
 800187c:	4d0d      	ldr	r5, [pc, #52]	; (80018b4 <__libc_init_array+0x3c>)
 800187e:	2400      	movs	r4, #0
 8001880:	1bad      	subs	r5, r5, r6
 8001882:	10ad      	asrs	r5, r5, #2
 8001884:	d005      	beq.n	8001892 <__libc_init_array+0x1a>
 8001886:	00a3      	lsls	r3, r4, #2
 8001888:	58f3      	ldr	r3, [r6, r3]
 800188a:	3401      	adds	r4, #1
 800188c:	4798      	blx	r3
 800188e:	42a5      	cmp	r5, r4
 8001890:	d1f9      	bne.n	8001886 <__libc_init_array+0xe>
 8001892:	f000 f8e3 	bl	8001a5c <_init>
 8001896:	4e08      	ldr	r6, [pc, #32]	; (80018b8 <__libc_init_array+0x40>)
 8001898:	4d08      	ldr	r5, [pc, #32]	; (80018bc <__libc_init_array+0x44>)
 800189a:	2400      	movs	r4, #0
 800189c:	1bad      	subs	r5, r5, r6
 800189e:	10ad      	asrs	r5, r5, #2
 80018a0:	d005      	beq.n	80018ae <__libc_init_array+0x36>
 80018a2:	00a3      	lsls	r3, r4, #2
 80018a4:	58f3      	ldr	r3, [r6, r3]
 80018a6:	3401      	adds	r4, #1
 80018a8:	4798      	blx	r3
 80018aa:	42a5      	cmp	r5, r4
 80018ac:	d1f9      	bne.n	80018a2 <__libc_init_array+0x2a>
 80018ae:	bd70      	pop	{r4, r5, r6, pc}
 80018b0:	08001abc 	.word	0x08001abc
 80018b4:	08001abc 	.word	0x08001abc
 80018b8:	08001abc 	.word	0x08001abc
 80018bc:	08001ac4 	.word	0x08001ac4

080018c0 <memcpy>:
 80018c0:	b5f0      	push	{r4, r5, r6, r7, lr}
 80018c2:	2a0f      	cmp	r2, #15
 80018c4:	d935      	bls.n	8001932 <memcpy+0x72>
 80018c6:	1c03      	adds	r3, r0, #0
 80018c8:	430b      	orrs	r3, r1
 80018ca:	079c      	lsls	r4, r3, #30
 80018cc:	d135      	bne.n	800193a <memcpy+0x7a>
 80018ce:	1c16      	adds	r6, r2, #0
 80018d0:	3e10      	subs	r6, #16
 80018d2:	0936      	lsrs	r6, r6, #4
 80018d4:	0135      	lsls	r5, r6, #4
 80018d6:	1945      	adds	r5, r0, r5
 80018d8:	3510      	adds	r5, #16
 80018da:	1c0c      	adds	r4, r1, #0
 80018dc:	1c03      	adds	r3, r0, #0
 80018de:	6827      	ldr	r7, [r4, #0]
 80018e0:	601f      	str	r7, [r3, #0]
 80018e2:	6867      	ldr	r7, [r4, #4]
 80018e4:	605f      	str	r7, [r3, #4]
 80018e6:	68a7      	ldr	r7, [r4, #8]
 80018e8:	609f      	str	r7, [r3, #8]
 80018ea:	68e7      	ldr	r7, [r4, #12]
 80018ec:	3410      	adds	r4, #16
 80018ee:	60df      	str	r7, [r3, #12]
 80018f0:	3310      	adds	r3, #16
 80018f2:	42ab      	cmp	r3, r5
 80018f4:	d1f3      	bne.n	80018de <memcpy+0x1e>
 80018f6:	1c73      	adds	r3, r6, #1
 80018f8:	011b      	lsls	r3, r3, #4
 80018fa:	18c5      	adds	r5, r0, r3
 80018fc:	18c9      	adds	r1, r1, r3
 80018fe:	230f      	movs	r3, #15
 8001900:	4013      	ands	r3, r2
 8001902:	2b03      	cmp	r3, #3
 8001904:	d91b      	bls.n	800193e <memcpy+0x7e>
 8001906:	1f1c      	subs	r4, r3, #4
 8001908:	08a4      	lsrs	r4, r4, #2
 800190a:	3401      	adds	r4, #1
 800190c:	00a4      	lsls	r4, r4, #2
 800190e:	2300      	movs	r3, #0
 8001910:	58ce      	ldr	r6, [r1, r3]
 8001912:	50ee      	str	r6, [r5, r3]
 8001914:	3304      	adds	r3, #4
 8001916:	42a3      	cmp	r3, r4
 8001918:	d1fa      	bne.n	8001910 <memcpy+0x50>
 800191a:	18ed      	adds	r5, r5, r3
 800191c:	18c9      	adds	r1, r1, r3
 800191e:	2303      	movs	r3, #3
 8001920:	401a      	ands	r2, r3
 8001922:	d005      	beq.n	8001930 <memcpy+0x70>
 8001924:	2300      	movs	r3, #0
 8001926:	5ccc      	ldrb	r4, [r1, r3]
 8001928:	54ec      	strb	r4, [r5, r3]
 800192a:	3301      	adds	r3, #1
 800192c:	4293      	cmp	r3, r2
 800192e:	d1fa      	bne.n	8001926 <memcpy+0x66>
 8001930:	bdf0      	pop	{r4, r5, r6, r7, pc}
 8001932:	1c05      	adds	r5, r0, #0
 8001934:	2a00      	cmp	r2, #0
 8001936:	d1f5      	bne.n	8001924 <memcpy+0x64>
 8001938:	e7fa      	b.n	8001930 <memcpy+0x70>
 800193a:	1c05      	adds	r5, r0, #0
 800193c:	e7f2      	b.n	8001924 <memcpy+0x64>
 800193e:	1c1a      	adds	r2, r3, #0
 8001940:	e7f8      	b.n	8001934 <memcpy+0x74>
 8001942:	46c0      	nop			; (mov r8, r8)

08001944 <register_fini>:
 8001944:	b508      	push	{r3, lr}
 8001946:	4b03      	ldr	r3, [pc, #12]	; (8001954 <register_fini+0x10>)
 8001948:	2b00      	cmp	r3, #0
 800194a:	d002      	beq.n	8001952 <register_fini+0xe>
 800194c:	4802      	ldr	r0, [pc, #8]	; (8001958 <register_fini+0x14>)
 800194e:	f000 f805 	bl	800195c <atexit>
 8001952:	bd08      	pop	{r3, pc}
 8001954:	00000000 	.word	0x00000000
 8001958:	0800196d 	.word	0x0800196d

0800195c <atexit>:
 800195c:	b508      	push	{r3, lr}
 800195e:	1c01      	adds	r1, r0, #0
 8001960:	2200      	movs	r2, #0
 8001962:	2000      	movs	r0, #0
 8001964:	2300      	movs	r3, #0
 8001966:	f000 f819 	bl	800199c <__register_exitproc>
 800196a:	bd08      	pop	{r3, pc}

0800196c <__libc_fini_array>:
 800196c:	b538      	push	{r3, r4, r5, lr}
 800196e:	4b09      	ldr	r3, [pc, #36]	; (8001994 <__libc_fini_array+0x28>)
 8001970:	4d09      	ldr	r5, [pc, #36]	; (8001998 <__libc_fini_array+0x2c>)
 8001972:	1aed      	subs	r5, r5, r3
 8001974:	10ad      	asrs	r5, r5, #2
 8001976:	d009      	beq.n	800198c <__libc_fini_array+0x20>
 8001978:	3d01      	subs	r5, #1
 800197a:	00ac      	lsls	r4, r5, #2
 800197c:	18e4      	adds	r4, r4, r3
 800197e:	e000      	b.n	8001982 <__libc_fini_array+0x16>
 8001980:	3d01      	subs	r5, #1
 8001982:	6823      	ldr	r3, [r4, #0]
 8001984:	4798      	blx	r3
 8001986:	3c04      	subs	r4, #4
 8001988:	2d00      	cmp	r5, #0
 800198a:	d1f9      	bne.n	8001980 <__libc_fini_array+0x14>
 800198c:	f000 f86c 	bl	8001a68 <_fini>
 8001990:	bd38      	pop	{r3, r4, r5, pc}
 8001992:	46c0      	nop			; (mov r8, r8)
 8001994:	08001ac4 	.word	0x08001ac4
 8001998:	08001ac8 	.word	0x08001ac8

0800199c <__register_exitproc>:
 800199c:	b5f0      	push	{r4, r5, r6, r7, lr}
 800199e:	464f      	mov	r7, r9
 80019a0:	4646      	mov	r6, r8
 80019a2:	b4c0      	push	{r6, r7}
 80019a4:	4698      	mov	r8, r3
 80019a6:	4b2b      	ldr	r3, [pc, #172]	; (8001a54 <__register_exitproc+0xb8>)
 80019a8:	25a4      	movs	r5, #164	; 0xa4
 80019aa:	681b      	ldr	r3, [r3, #0]
 80019ac:	006d      	lsls	r5, r5, #1
 80019ae:	595c      	ldr	r4, [r3, r5]
 80019b0:	b083      	sub	sp, #12
 80019b2:	1c06      	adds	r6, r0, #0
 80019b4:	1c0f      	adds	r7, r1, #0
 80019b6:	4691      	mov	r9, r2
 80019b8:	9301      	str	r3, [sp, #4]
 80019ba:	2c00      	cmp	r4, #0
 80019bc:	d044      	beq.n	8001a48 <__register_exitproc+0xac>
 80019be:	6865      	ldr	r5, [r4, #4]
 80019c0:	2d1f      	cmp	r5, #31
 80019c2:	dd1a      	ble.n	80019fa <__register_exitproc+0x5e>
 80019c4:	4b24      	ldr	r3, [pc, #144]	; (8001a58 <__register_exitproc+0xbc>)
 80019c6:	2b00      	cmp	r3, #0
 80019c8:	d102      	bne.n	80019d0 <__register_exitproc+0x34>
 80019ca:	2001      	movs	r0, #1
 80019cc:	4240      	negs	r0, r0
 80019ce:	e01c      	b.n	8001a0a <__register_exitproc+0x6e>
 80019d0:	20c8      	movs	r0, #200	; 0xc8
 80019d2:	0040      	lsls	r0, r0, #1
 80019d4:	e000      	b.n	80019d8 <__register_exitproc+0x3c>
 80019d6:	bf00      	nop
 80019d8:	1e04      	subs	r4, r0, #0
 80019da:	d0f6      	beq.n	80019ca <__register_exitproc+0x2e>
 80019dc:	2500      	movs	r5, #0
 80019de:	6045      	str	r5, [r0, #4]
 80019e0:	23a4      	movs	r3, #164	; 0xa4
 80019e2:	9801      	ldr	r0, [sp, #4]
 80019e4:	005b      	lsls	r3, r3, #1
 80019e6:	58c0      	ldr	r0, [r0, r3]
 80019e8:	9901      	ldr	r1, [sp, #4]
 80019ea:	6020      	str	r0, [r4, #0]
 80019ec:	50cc      	str	r4, [r1, r3]
 80019ee:	23c4      	movs	r3, #196	; 0xc4
 80019f0:	005b      	lsls	r3, r3, #1
 80019f2:	50e5      	str	r5, [r4, r3]
 80019f4:	23c6      	movs	r3, #198	; 0xc6
 80019f6:	005b      	lsls	r3, r3, #1
 80019f8:	50e5      	str	r5, [r4, r3]
 80019fa:	2e00      	cmp	r6, #0
 80019fc:	d10a      	bne.n	8001a14 <__register_exitproc+0x78>
 80019fe:	1c6b      	adds	r3, r5, #1
 8001a00:	3502      	adds	r5, #2
 8001a02:	00ad      	lsls	r5, r5, #2
 8001a04:	6063      	str	r3, [r4, #4]
 8001a06:	2000      	movs	r0, #0
 8001a08:	512f      	str	r7, [r5, r4]
 8001a0a:	b003      	add	sp, #12
 8001a0c:	bc0c      	pop	{r2, r3}
 8001a0e:	4690      	mov	r8, r2
 8001a10:	4699      	mov	r9, r3
 8001a12:	bdf0      	pop	{r4, r5, r6, r7, pc}
 8001a14:	00ab      	lsls	r3, r5, #2
 8001a16:	18e3      	adds	r3, r4, r3
 8001a18:	2288      	movs	r2, #136	; 0x88
 8001a1a:	4648      	mov	r0, r9
 8001a1c:	5098      	str	r0, [r3, r2]
 8001a1e:	20c4      	movs	r0, #196	; 0xc4
 8001a20:	0040      	lsls	r0, r0, #1
 8001a22:	1822      	adds	r2, r4, r0
 8001a24:	6810      	ldr	r0, [r2, #0]
 8001a26:	2101      	movs	r1, #1
 8001a28:	40a9      	lsls	r1, r5
 8001a2a:	4308      	orrs	r0, r1
 8001a2c:	6010      	str	r0, [r2, #0]
 8001a2e:	2284      	movs	r2, #132	; 0x84
 8001a30:	0052      	lsls	r2, r2, #1
 8001a32:	4640      	mov	r0, r8
 8001a34:	5098      	str	r0, [r3, r2]
 8001a36:	2e02      	cmp	r6, #2
 8001a38:	d1e1      	bne.n	80019fe <__register_exitproc+0x62>
 8001a3a:	22c6      	movs	r2, #198	; 0xc6
 8001a3c:	0052      	lsls	r2, r2, #1
 8001a3e:	18a3      	adds	r3, r4, r2
 8001a40:	6818      	ldr	r0, [r3, #0]
 8001a42:	4301      	orrs	r1, r0
 8001a44:	6019      	str	r1, [r3, #0]
 8001a46:	e7da      	b.n	80019fe <__register_exitproc+0x62>
 8001a48:	1c1c      	adds	r4, r3, #0
 8001a4a:	344d      	adds	r4, #77	; 0x4d
 8001a4c:	34ff      	adds	r4, #255	; 0xff
 8001a4e:	515c      	str	r4, [r3, r5]
 8001a50:	e7b5      	b.n	80019be <__register_exitproc+0x22>
 8001a52:	46c0      	nop			; (mov r8, r8)
 8001a54:	08001ab8 	.word	0x08001ab8
 8001a58:	00000000 	.word	0x00000000

08001a5c <_init>:
 8001a5c:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8001a5e:	46c0      	nop			; (mov r8, r8)
 8001a60:	bcf8      	pop	{r3, r4, r5, r6, r7}
 8001a62:	bc08      	pop	{r3}
 8001a64:	469e      	mov	lr, r3
 8001a66:	4770      	bx	lr

08001a68 <_fini>:
 8001a68:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8001a6a:	46c0      	nop			; (mov r8, r8)
 8001a6c:	bcf8      	pop	{r3, r4, r5, r6, r7}
 8001a6e:	bc08      	pop	{r3}
 8001a70:	469e      	mov	lr, r3
 8001a72:	4770      	bx	lr
