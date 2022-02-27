.data
CR:	.word32 0x10000
DR:	.word32 0x10008
BIGZERO: .double 0.0
OSTR: .word32 4
IDAT: .word32 8
MSG1: .asciiz "Please enter the number of digits:\n"
MSG2: .asciiz "Please enter a digit:\n"
MSG3: .asciiz "Armstrong number\n"
MSG4: .asciiz "Not an Armstrong number\n"
MSG5: .asciiz "Entered number: \n"
MSG6: .asciiz "Sum: \n"


.text
main:
; num=t8
; i=t9
; digit=r4
; capture=f4/f5
; sum = f6/f7

l.d	f6,BIGZERO(r0)	; set to 0.0
l.d	f4,BIGZERO(r0)

lwu	$t5,0($zero)	;tempsum 0
lwu $t6,0($zero)	;tempcap 0

lwu	r5,CR(r0)	; store addr of CR in r5
lwu	r6,DR(r0)	; store addr of DR in r6

daddi	$v0,$zero,4		;tempctrl = 0+4
daddi	$t1,$zero,MSG1	;tempdat = MSG1
sd	$t1,0(r6)			;dat = tempdat
sd	$v0,0(r5)			;ctrl = tempctrl

daddi	$v0,$zero,8		;tempctrl = 8
sd	$v0,0(r5)			;ctrl = tempctrl
lwu	$t8,0(r6)			;num = dat

daddi	$t9,$zero,0			;i = 0
beqz	$t8,skiploop	;if (num==0) goto end

loop:	daddi	$v0,$zero,4		;tempctrl = outputstr
		daddi	$t1,$zero,MSG2	;tempdat = MSG2
		sd	$t1,0(r6)			;dat = tempdat
		sd	$v0,0(r5)			;ctrl = tempctrl
		
		daddi	$v0,$zero,8		;tempctrl = read
		sd	$v0,0(r5)			;ctrl = tempctrl
		lwu	r4,0(r6)			;digit = dat
		
		daddi $t3,$zero,0		;j = 0
		lwu	$t4,0(r4)			;power = digit
		powers:	dmulu	$t4,$t4,r4	;power = power*digit
				daddi	$t3,$t3,1	;j++
				bne	$t3,$t8,powers	;if (j!=num) goto powers
		daddu	$t5,$t5,$t4		; tempsum = tempsum+digit^num
		daddi	$t7,$zero,10	; temp = 10
		dmulu	$t6,$t6,$t7		;tempcap = tempcap*temp
		daddu	$t6,$t6,r4		;tempcap = tempcap+digit
		daddi	$t9,$t9,1			;i++
		bne	$t9,$t8,loop			; if(i!=num) goto loop
		

daddi	$v0,$zero,4		;tempctrl = 0+4
daddi	$t1,$zero,MSG5	;tempdat = MSG5
sd	$t1,0(r6)			;dat = tempdat
sd	$v0,0(r5)			;ctrl = tempctrl

daddi	$v0,$zero,1		;tempctrl = 1
daddu	$t1,$zero,$t6
sd	$t1,0(r6)			;dat = tempdat
sd	$v0,0(r5)			;ctrl = tempctrl

daddi	$v0,$zero,4		;tempctrl = 0+4
daddi	$t1,$zero,MSG6	;tempdat = MSG6
sd	$t1,0(r6)			;dat = tempdat
sd	$v0,0(r5)			;ctrl = tempctrl

daddi	$v0,$zero,1		;tempctrl = 1
daddu	$t1,$zero,$t5
sd	$t1,0(r6)			;dat = tempdat
sd	$v0,0(r5)			;ctrl = tempctrl

beq	$t5,$t6,arm			;if(tempsum==tempcap) armstrong
daddi	$v0,$zero,4
daddi	$t1,$zero,MSG4
sd	$t1,0(r6)
sd	$v0,0(r5)
	
halt

arm:
daddi	$v0,$zero,4
daddi	$t1,$zero,MSG3
sd	$t1,0(r6)
sd	$v0,0(r5)

skiploop:	halt


		


