.data
CR:	.word32 0x10000
DR:	.word32 0x10008
MSG1:	.asciiz	"Enter the number of fibonacci numbers > 2:\n"
MSG2:	.asciiz	"The numbers are: \n"
MSG3:	.asciiz	"0\n1\n"


.text
main:
;x=t1
;y=t2
;z=t3
;num=t4
;count=t5
;dataoutput=t6
;ctrlinput=v0
;dat=s1
;ctrl=s0

lwu	$s0,CR($zero)
lwu	$s1,DR($zero)

daddi	$v0,$zero,4
daddi	$t6,$zero,MSG1
sd	$t6,0($s1)
sd	$v0,0($s0)

daddi	$v0,$zero,8
sd	$v0,0($s0)
lwu		$t4,0($s1)

daddi	$t1,$zero,0
daddi	$t2,$zero,1
daddi	$t5,$zero,2

daddi	$v0,$zero,4
daddi	$t6,$zero,MSG2
sd	$t6,0($s1)
sd	$v0,0($s0)

daddi	$v0,$zero,4
daddi	$t6,$zero,MSG3
sd	$t6,0($s1)
sd	$v0,0($s0)

loop:	daddu	$t3,$t1,$t2

daddi	$v0,$zero,1
daddi	$t6,$t3,0
sd		$t6,0($s1)
sd		$v0,0($s0)

daddi	$t1,$t2,0
daddi	$t2,$t3,0
daddi	$t5,$t5,1
bne		$t4,$t5,loop

halt