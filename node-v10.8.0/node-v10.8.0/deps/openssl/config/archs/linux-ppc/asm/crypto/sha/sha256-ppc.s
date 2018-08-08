.machine	"any"
.text

.globl	sha256_block_ppc
.type	sha256_block_ppc,@function
.align	6
sha256_block_ppc:
	stwu	1,-192(1)
	mflr	0
	slwi	5,5,6

	stw	3,104(1)

	stw	14,120(1)
	stw	15,124(1)
	stw	16,128(1)
	stw	17,132(1)
	stw	18,136(1)
	stw	19,140(1)
	stw	20,144(1)
	stw	21,148(1)
	stw	22,152(1)
	stw	23,156(1)
	stw	24,160(1)
	stw	25,164(1)
	stw	26,168(1)
	stw	27,172(1)
	stw	28,176(1)
	stw	29,180(1)
	stw	30,184(1)
	stw	31,188(1)
	stw	0,196(1)
	lwz	8,0(3)
	mr	31,4
	lwz	9,4(3)
	lwz	10,8(3)
	lwz	11,12(3)
	lwz	12,16(3)
	lwz	6,20(3)
	lwz	14,24(3)
	lwz	15,28(3)
	bl	.LPICmeup
.LPICedup:
	andi.	0,31,3
	bne	.Lunaligned
.Laligned:
	add	5,31,5
	stw	5,96(1)
	stw	31,100(1)
	bl	.Lsha2_block_private
	b	.Ldone







.align	4
.Lunaligned:
	subfic	0,31,4096
	andi.	0,0,4032
	beq	.Lcross_page
	.long	0x7c050040
	ble	.Laligned
	subfc	5,0,5
	add	0,31,0
	stw	5,92(1)
	stw	0,96(1)
	stw	31,100(1)
	bl	.Lsha2_block_private

	lwz	5,92(1)
.Lcross_page:
	li	0,16
	mtctr	0
	addi	20,1,24
.Lmemcpy:
	lbz	16,0(31)
	lbz	17,1(31)
	lbz	18,2(31)
	lbz	19,3(31)
	addi	31,31,4
	stb	16,0(20)
	stb	17,1(20)
	stb	18,2(20)
	stb	19,3(20)
	addi	20,20,4
	bdnz	.Lmemcpy
	stw	31,88(1)
	addi	0,1,88
	addi	31,1,24
	stw	5,92(1)
	stw	0,96(1)
	stw	31,100(1)
	bl	.Lsha2_block_private
	lwz	31,88(1)
	lwz	5,92(1)
	addic.	5,5,-64
	bne	.Lunaligned

.Ldone:
	lwz	0,196(1)
	lwz	14,120(1)
	lwz	15,124(1)
	lwz	16,128(1)
	lwz	17,132(1)
	lwz	18,136(1)
	lwz	19,140(1)
	lwz	20,144(1)
	lwz	21,148(1)
	lwz	22,152(1)
	lwz	23,156(1)
	lwz	24,160(1)
	lwz	25,164(1)
	lwz	26,168(1)
	lwz	27,172(1)
	lwz	28,176(1)
	lwz	29,180(1)
	lwz	30,184(1)
	lwz	31,188(1)
	mtlr	0
	addi	1,1,192
	blr
.long	0
.byte	0,12,4,1,0x80,18,3,0
.long	0
.align	4
.Lsha2_block_private:
	lwz	0,0(7)
	lwz	16,0(31)
	rotrwi	3,12,6
	rotrwi	4,12,11
	and	5,6,12
	xor	3,3,4
	add	15,15,0
	andc	0,14,12
	rotrwi	4,4,14
	or	5,5,0
	add	15,15,16
	xor	3,3,4
	add	15,15,5
	add	15,15,3

	rotrwi	3,8,2
	rotrwi	4,8,13
	and	5,8,9
	and	0,8,10
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,9,10
	xor	3,3,4
	add	11,11,15
	xor	5,5,0
	lwz	0,4(7)
	add	15,15,3
	add	15,15,5

	lwz	17,4(31)
	rotrwi	3,11,6
	rotrwi	4,11,11
	and	5,12,11
	xor	3,3,4
	add	14,14,0
	andc	0,6,11
	rotrwi	4,4,14
	or	5,5,0
	add	14,14,17
	xor	3,3,4
	add	14,14,5
	add	14,14,3

	rotrwi	3,15,2
	rotrwi	4,15,13
	and	5,15,8
	and	0,15,9
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,8,9
	xor	3,3,4
	add	10,10,14
	xor	5,5,0
	lwz	0,8(7)
	add	14,14,3
	add	14,14,5

	lwz	18,8(31)
	rotrwi	3,10,6
	rotrwi	4,10,11
	and	5,11,10
	xor	3,3,4
	add	6,6,0
	andc	0,12,10
	rotrwi	4,4,14
	or	5,5,0
	add	6,6,18
	xor	3,3,4
	add	6,6,5
	add	6,6,3

	rotrwi	3,14,2
	rotrwi	4,14,13
	and	5,14,15
	and	0,14,8
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,15,8
	xor	3,3,4
	add	9,9,6
	xor	5,5,0
	lwz	0,12(7)
	add	6,6,3
	add	6,6,5

	lwz	19,12(31)
	rotrwi	3,9,6
	rotrwi	4,9,11
	and	5,10,9
	xor	3,3,4
	add	12,12,0
	andc	0,11,9
	rotrwi	4,4,14
	or	5,5,0
	add	12,12,19
	xor	3,3,4
	add	12,12,5
	add	12,12,3

	rotrwi	3,6,2
	rotrwi	4,6,13
	and	5,6,14
	and	0,6,15
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,14,15
	xor	3,3,4
	add	8,8,12
	xor	5,5,0
	lwz	0,16(7)
	add	12,12,3
	add	12,12,5

	lwz	20,16(31)
	rotrwi	3,8,6
	rotrwi	4,8,11
	and	5,9,8
	xor	3,3,4
	add	11,11,0
	andc	0,10,8
	rotrwi	4,4,14
	or	5,5,0
	add	11,11,20
	xor	3,3,4
	add	11,11,5
	add	11,11,3

	rotrwi	3,12,2
	rotrwi	4,12,13
	and	5,12,6
	and	0,12,14
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,6,14
	xor	3,3,4
	add	15,15,11
	xor	5,5,0
	lwz	0,20(7)
	add	11,11,3
	add	11,11,5

	lwz	21,20(31)
	rotrwi	3,15,6
	rotrwi	4,15,11
	and	5,8,15
	xor	3,3,4
	add	10,10,0
	andc	0,9,15
	rotrwi	4,4,14
	or	5,5,0
	add	10,10,21
	xor	3,3,4
	add	10,10,5
	add	10,10,3

	rotrwi	3,11,2
	rotrwi	4,11,13
	and	5,11,12
	and	0,11,6
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,12,6
	xor	3,3,4
	add	14,14,10
	xor	5,5,0
	lwz	0,24(7)
	add	10,10,3
	add	10,10,5

	lwz	22,24(31)
	rotrwi	3,14,6
	rotrwi	4,14,11
	and	5,15,14
	xor	3,3,4
	add	9,9,0
	andc	0,8,14
	rotrwi	4,4,14
	or	5,5,0
	add	9,9,22
	xor	3,3,4
	add	9,9,5
	add	9,9,3

	rotrwi	3,10,2
	rotrwi	4,10,13
	and	5,10,11
	and	0,10,12
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,11,12
	xor	3,3,4
	add	6,6,9
	xor	5,5,0
	lwz	0,28(7)
	add	9,9,3
	add	9,9,5

	lwz	23,28(31)
	rotrwi	3,6,6
	rotrwi	4,6,11
	and	5,14,6
	xor	3,3,4
	add	8,8,0
	andc	0,15,6
	rotrwi	4,4,14
	or	5,5,0
	add	8,8,23
	xor	3,3,4
	add	8,8,5
	add	8,8,3

	rotrwi	3,9,2
	rotrwi	4,9,13
	and	5,9,10
	and	0,9,11
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,10,11
	xor	3,3,4
	add	12,12,8
	xor	5,5,0
	lwz	0,32(7)
	add	8,8,3
	add	8,8,5

	lwz	24,32(31)
	rotrwi	3,12,6
	rotrwi	4,12,11
	and	5,6,12
	xor	3,3,4
	add	15,15,0
	andc	0,14,12
	rotrwi	4,4,14
	or	5,5,0
	add	15,15,24
	xor	3,3,4
	add	15,15,5
	add	15,15,3

	rotrwi	3,8,2
	rotrwi	4,8,13
	and	5,8,9
	and	0,8,10
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,9,10
	xor	3,3,4
	add	11,11,15
	xor	5,5,0
	lwz	0,36(7)
	add	15,15,3
	add	15,15,5

	lwz	25,36(31)
	rotrwi	3,11,6
	rotrwi	4,11,11
	and	5,12,11
	xor	3,3,4
	add	14,14,0
	andc	0,6,11
	rotrwi	4,4,14
	or	5,5,0
	add	14,14,25
	xor	3,3,4
	add	14,14,5
	add	14,14,3

	rotrwi	3,15,2
	rotrwi	4,15,13
	and	5,15,8
	and	0,15,9
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,8,9
	xor	3,3,4
	add	10,10,14
	xor	5,5,0
	lwz	0,40(7)
	add	14,14,3
	add	14,14,5

	lwz	26,40(31)
	rotrwi	3,10,6
	rotrwi	4,10,11
	and	5,11,10
	xor	3,3,4
	add	6,6,0
	andc	0,12,10
	rotrwi	4,4,14
	or	5,5,0
	add	6,6,26
	xor	3,3,4
	add	6,6,5
	add	6,6,3

	rotrwi	3,14,2
	rotrwi	4,14,13
	and	5,14,15
	and	0,14,8
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,15,8
	xor	3,3,4
	add	9,9,6
	xor	5,5,0
	lwz	0,44(7)
	add	6,6,3
	add	6,6,5

	lwz	27,44(31)
	rotrwi	3,9,6
	rotrwi	4,9,11
	and	5,10,9
	xor	3,3,4
	add	12,12,0
	andc	0,11,9
	rotrwi	4,4,14
	or	5,5,0
	add	12,12,27
	xor	3,3,4
	add	12,12,5
	add	12,12,3

	rotrwi	3,6,2
	rotrwi	4,6,13
	and	5,6,14
	and	0,6,15
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,14,15
	xor	3,3,4
	add	8,8,12
	xor	5,5,0
	lwz	0,48(7)
	add	12,12,3
	add	12,12,5

	lwz	28,48(31)
	rotrwi	3,8,6
	rotrwi	4,8,11
	and	5,9,8
	xor	3,3,4
	add	11,11,0
	andc	0,10,8
	rotrwi	4,4,14
	or	5,5,0
	add	11,11,28
	xor	3,3,4
	add	11,11,5
	add	11,11,3

	rotrwi	3,12,2
	rotrwi	4,12,13
	and	5,12,6
	and	0,12,14
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,6,14
	xor	3,3,4
	add	15,15,11
	xor	5,5,0
	lwz	0,52(7)
	add	11,11,3
	add	11,11,5

	lwz	29,52(31)
	rotrwi	3,15,6
	rotrwi	4,15,11
	and	5,8,15
	xor	3,3,4
	add	10,10,0
	andc	0,9,15
	rotrwi	4,4,14
	or	5,5,0
	add	10,10,29
	xor	3,3,4
	add	10,10,5
	add	10,10,3

	rotrwi	3,11,2
	rotrwi	4,11,13
	and	5,11,12
	and	0,11,6
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,12,6
	xor	3,3,4
	add	14,14,10
	xor	5,5,0
	lwz	0,56(7)
	add	10,10,3
	add	10,10,5

	lwz	30,56(31)
	rotrwi	3,14,6
	rotrwi	4,14,11
	and	5,15,14
	xor	3,3,4
	add	9,9,0
	andc	0,8,14
	rotrwi	4,4,14
	or	5,5,0
	add	9,9,30
	xor	3,3,4
	add	9,9,5
	add	9,9,3

	rotrwi	3,10,2
	rotrwi	4,10,13
	and	5,10,11
	and	0,10,12
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,11,12
	xor	3,3,4
	add	6,6,9
	xor	5,5,0
	lwz	0,60(7)
	add	9,9,3
	add	9,9,5

	lwz	31,60(31)
	rotrwi	3,6,6
	rotrwi	4,6,11
	and	5,14,6
	xor	3,3,4
	add	8,8,0
	andc	0,15,6
	rotrwi	4,4,14
	or	5,5,0
	add	8,8,31
	xor	3,3,4
	add	8,8,5
	add	8,8,3

	rotrwi	3,9,2
	rotrwi	4,9,13
	and	5,9,10
	and	0,9,11
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,10,11
	xor	3,3,4
	add	12,12,8
	xor	5,5,0
	add	8,8,3
	add	8,8,5

	li	5,3
	mtctr	5
.align	4
.Lrounds:
	addi	7,7,64
	rotrwi	3,17,7
	rotrwi	4,17,18
	rotrwi	5,30,17
	rotrwi	0,30,19
	xor	3,3,4
	srwi	4,17,3
	xor	5,5,0
	srwi	0,30,10
	add	16,16,25
	xor	3,3,4
	xor	5,5,0
	lwz	0,0(7)
	add	16,16,3
	add	16,16,5
	rotrwi	3,12,6
	rotrwi	4,12,11
	and	5,6,12
	xor	3,3,4
	add	15,15,0
	andc	0,14,12
	rotrwi	4,4,14
	or	5,5,0
	add	15,15,16
	xor	3,3,4
	add	15,15,5
	add	15,15,3

	rotrwi	3,8,2
	rotrwi	4,8,13
	and	5,8,9
	and	0,8,10
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,9,10
	xor	3,3,4
	add	11,11,15
	xor	5,5,0
	add	15,15,3
	add	15,15,5

	rotrwi	3,18,7
	rotrwi	4,18,18
	rotrwi	5,31,17
	rotrwi	0,31,19
	xor	3,3,4
	srwi	4,18,3
	xor	5,5,0
	srwi	0,31,10
	add	17,17,26
	xor	3,3,4
	xor	5,5,0
	lwz	0,4(7)
	add	17,17,3
	add	17,17,5
	rotrwi	3,11,6
	rotrwi	4,11,11
	and	5,12,11
	xor	3,3,4
	add	14,14,0
	andc	0,6,11
	rotrwi	4,4,14
	or	5,5,0
	add	14,14,17
	xor	3,3,4
	add	14,14,5
	add	14,14,3

	rotrwi	3,15,2
	rotrwi	4,15,13
	and	5,15,8
	and	0,15,9
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,8,9
	xor	3,3,4
	add	10,10,14
	xor	5,5,0
	add	14,14,3
	add	14,14,5

	rotrwi	3,19,7
	rotrwi	4,19,18
	rotrwi	5,16,17
	rotrwi	0,16,19
	xor	3,3,4
	srwi	4,19,3
	xor	5,5,0
	srwi	0,16,10
	add	18,18,27
	xor	3,3,4
	xor	5,5,0
	lwz	0,8(7)
	add	18,18,3
	add	18,18,5
	rotrwi	3,10,6
	rotrwi	4,10,11
	and	5,11,10
	xor	3,3,4
	add	6,6,0
	andc	0,12,10
	rotrwi	4,4,14
	or	5,5,0
	add	6,6,18
	xor	3,3,4
	add	6,6,5
	add	6,6,3

	rotrwi	3,14,2
	rotrwi	4,14,13
	and	5,14,15
	and	0,14,8
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,15,8
	xor	3,3,4
	add	9,9,6
	xor	5,5,0
	add	6,6,3
	add	6,6,5

	rotrwi	3,20,7
	rotrwi	4,20,18
	rotrwi	5,17,17
	rotrwi	0,17,19
	xor	3,3,4
	srwi	4,20,3
	xor	5,5,0
	srwi	0,17,10
	add	19,19,28
	xor	3,3,4
	xor	5,5,0
	lwz	0,12(7)
	add	19,19,3
	add	19,19,5
	rotrwi	3,9,6
	rotrwi	4,9,11
	and	5,10,9
	xor	3,3,4
	add	12,12,0
	andc	0,11,9
	rotrwi	4,4,14
	or	5,5,0
	add	12,12,19
	xor	3,3,4
	add	12,12,5
	add	12,12,3

	rotrwi	3,6,2
	rotrwi	4,6,13
	and	5,6,14
	and	0,6,15
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,14,15
	xor	3,3,4
	add	8,8,12
	xor	5,5,0
	add	12,12,3
	add	12,12,5

	rotrwi	3,21,7
	rotrwi	4,21,18
	rotrwi	5,18,17
	rotrwi	0,18,19
	xor	3,3,4
	srwi	4,21,3
	xor	5,5,0
	srwi	0,18,10
	add	20,20,29
	xor	3,3,4
	xor	5,5,0
	lwz	0,16(7)
	add	20,20,3
	add	20,20,5
	rotrwi	3,8,6
	rotrwi	4,8,11
	and	5,9,8
	xor	3,3,4
	add	11,11,0
	andc	0,10,8
	rotrwi	4,4,14
	or	5,5,0
	add	11,11,20
	xor	3,3,4
	add	11,11,5
	add	11,11,3

	rotrwi	3,12,2
	rotrwi	4,12,13
	and	5,12,6
	and	0,12,14
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,6,14
	xor	3,3,4
	add	15,15,11
	xor	5,5,0
	add	11,11,3
	add	11,11,5

	rotrwi	3,22,7
	rotrwi	4,22,18
	rotrwi	5,19,17
	rotrwi	0,19,19
	xor	3,3,4
	srwi	4,22,3
	xor	5,5,0
	srwi	0,19,10
	add	21,21,30
	xor	3,3,4
	xor	5,5,0
	lwz	0,20(7)
	add	21,21,3
	add	21,21,5
	rotrwi	3,15,6
	rotrwi	4,15,11
	and	5,8,15
	xor	3,3,4
	add	10,10,0
	andc	0,9,15
	rotrwi	4,4,14
	or	5,5,0
	add	10,10,21
	xor	3,3,4
	add	10,10,5
	add	10,10,3

	rotrwi	3,11,2
	rotrwi	4,11,13
	and	5,11,12
	and	0,11,6
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,12,6
	xor	3,3,4
	add	14,14,10
	xor	5,5,0
	add	10,10,3
	add	10,10,5

	rotrwi	3,23,7
	rotrwi	4,23,18
	rotrwi	5,20,17
	rotrwi	0,20,19
	xor	3,3,4
	srwi	4,23,3
	xor	5,5,0
	srwi	0,20,10
	add	22,22,31
	xor	3,3,4
	xor	5,5,0
	lwz	0,24(7)
	add	22,22,3
	add	22,22,5
	rotrwi	3,14,6
	rotrwi	4,14,11
	and	5,15,14
	xor	3,3,4
	add	9,9,0
	andc	0,8,14
	rotrwi	4,4,14
	or	5,5,0
	add	9,9,22
	xor	3,3,4
	add	9,9,5
	add	9,9,3

	rotrwi	3,10,2
	rotrwi	4,10,13
	and	5,10,11
	and	0,10,12
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,11,12
	xor	3,3,4
	add	6,6,9
	xor	5,5,0
	add	9,9,3
	add	9,9,5

	rotrwi	3,24,7
	rotrwi	4,24,18
	rotrwi	5,21,17
	rotrwi	0,21,19
	xor	3,3,4
	srwi	4,24,3
	xor	5,5,0
	srwi	0,21,10
	add	23,23,16
	xor	3,3,4
	xor	5,5,0
	lwz	0,28(7)
	add	23,23,3
	add	23,23,5
	rotrwi	3,6,6
	rotrwi	4,6,11
	and	5,14,6
	xor	3,3,4
	add	8,8,0
	andc	0,15,6
	rotrwi	4,4,14
	or	5,5,0
	add	8,8,23
	xor	3,3,4
	add	8,8,5
	add	8,8,3

	rotrwi	3,9,2
	rotrwi	4,9,13
	and	5,9,10
	and	0,9,11
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,10,11
	xor	3,3,4
	add	12,12,8
	xor	5,5,0
	add	8,8,3
	add	8,8,5

	rotrwi	3,25,7
	rotrwi	4,25,18
	rotrwi	5,22,17
	rotrwi	0,22,19
	xor	3,3,4
	srwi	4,25,3
	xor	5,5,0
	srwi	0,22,10
	add	24,24,17
	xor	3,3,4
	xor	5,5,0
	lwz	0,32(7)
	add	24,24,3
	add	24,24,5
	rotrwi	3,12,6
	rotrwi	4,12,11
	and	5,6,12
	xor	3,3,4
	add	15,15,0
	andc	0,14,12
	rotrwi	4,4,14
	or	5,5,0
	add	15,15,24
	xor	3,3,4
	add	15,15,5
	add	15,15,3

	rotrwi	3,8,2
	rotrwi	4,8,13
	and	5,8,9
	and	0,8,10
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,9,10
	xor	3,3,4
	add	11,11,15
	xor	5,5,0
	add	15,15,3
	add	15,15,5

	rotrwi	3,26,7
	rotrwi	4,26,18
	rotrwi	5,23,17
	rotrwi	0,23,19
	xor	3,3,4
	srwi	4,26,3
	xor	5,5,0
	srwi	0,23,10
	add	25,25,18
	xor	3,3,4
	xor	5,5,0
	lwz	0,36(7)
	add	25,25,3
	add	25,25,5
	rotrwi	3,11,6
	rotrwi	4,11,11
	and	5,12,11
	xor	3,3,4
	add	14,14,0
	andc	0,6,11
	rotrwi	4,4,14
	or	5,5,0
	add	14,14,25
	xor	3,3,4
	add	14,14,5
	add	14,14,3

	rotrwi	3,15,2
	rotrwi	4,15,13
	and	5,15,8
	and	0,15,9
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,8,9
	xor	3,3,4
	add	10,10,14
	xor	5,5,0
	add	14,14,3
	add	14,14,5

	rotrwi	3,27,7
	rotrwi	4,27,18
	rotrwi	5,24,17
	rotrwi	0,24,19
	xor	3,3,4
	srwi	4,27,3
	xor	5,5,0
	srwi	0,24,10
	add	26,26,19
	xor	3,3,4
	xor	5,5,0
	lwz	0,40(7)
	add	26,26,3
	add	26,26,5
	rotrwi	3,10,6
	rotrwi	4,10,11
	and	5,11,10
	xor	3,3,4
	add	6,6,0
	andc	0,12,10
	rotrwi	4,4,14
	or	5,5,0
	add	6,6,26
	xor	3,3,4
	add	6,6,5
	add	6,6,3

	rotrwi	3,14,2
	rotrwi	4,14,13
	and	5,14,15
	and	0,14,8
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,15,8
	xor	3,3,4
	add	9,9,6
	xor	5,5,0
	add	6,6,3
	add	6,6,5

	rotrwi	3,28,7
	rotrwi	4,28,18
	rotrwi	5,25,17
	rotrwi	0,25,19
	xor	3,3,4
	srwi	4,28,3
	xor	5,5,0
	srwi	0,25,10
	add	27,27,20
	xor	3,3,4
	xor	5,5,0
	lwz	0,44(7)
	add	27,27,3
	add	27,27,5
	rotrwi	3,9,6
	rotrwi	4,9,11
	and	5,10,9
	xor	3,3,4
	add	12,12,0
	andc	0,11,9
	rotrwi	4,4,14
	or	5,5,0
	add	12,12,27
	xor	3,3,4
	add	12,12,5
	add	12,12,3

	rotrwi	3,6,2
	rotrwi	4,6,13
	and	5,6,14
	and	0,6,15
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,14,15
	xor	3,3,4
	add	8,8,12
	xor	5,5,0
	add	12,12,3
	add	12,12,5

	rotrwi	3,29,7
	rotrwi	4,29,18
	rotrwi	5,26,17
	rotrwi	0,26,19
	xor	3,3,4
	srwi	4,29,3
	xor	5,5,0
	srwi	0,26,10
	add	28,28,21
	xor	3,3,4
	xor	5,5,0
	lwz	0,48(7)
	add	28,28,3
	add	28,28,5
	rotrwi	3,8,6
	rotrwi	4,8,11
	and	5,9,8
	xor	3,3,4
	add	11,11,0
	andc	0,10,8
	rotrwi	4,4,14
	or	5,5,0
	add	11,11,28
	xor	3,3,4
	add	11,11,5
	add	11,11,3

	rotrwi	3,12,2
	rotrwi	4,12,13
	and	5,12,6
	and	0,12,14
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,6,14
	xor	3,3,4
	add	15,15,11
	xor	5,5,0
	add	11,11,3
	add	11,11,5

	rotrwi	3,30,7
	rotrwi	4,30,18
	rotrwi	5,27,17
	rotrwi	0,27,19
	xor	3,3,4
	srwi	4,30,3
	xor	5,5,0
	srwi	0,27,10
	add	29,29,22
	xor	3,3,4
	xor	5,5,0
	lwz	0,52(7)
	add	29,29,3
	add	29,29,5
	rotrwi	3,15,6
	rotrwi	4,15,11
	and	5,8,15
	xor	3,3,4
	add	10,10,0
	andc	0,9,15
	rotrwi	4,4,14
	or	5,5,0
	add	10,10,29
	xor	3,3,4
	add	10,10,5
	add	10,10,3

	rotrwi	3,11,2
	rotrwi	4,11,13
	and	5,11,12
	and	0,11,6
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,12,6
	xor	3,3,4
	add	14,14,10
	xor	5,5,0
	add	10,10,3
	add	10,10,5

	rotrwi	3,31,7
	rotrwi	4,31,18
	rotrwi	5,28,17
	rotrwi	0,28,19
	xor	3,3,4
	srwi	4,31,3
	xor	5,5,0
	srwi	0,28,10
	add	30,30,23
	xor	3,3,4
	xor	5,5,0
	lwz	0,56(7)
	add	30,30,3
	add	30,30,5
	rotrwi	3,14,6
	rotrwi	4,14,11
	and	5,15,14
	xor	3,3,4
	add	9,9,0
	andc	0,8,14
	rotrwi	4,4,14
	or	5,5,0
	add	9,9,30
	xor	3,3,4
	add	9,9,5
	add	9,9,3

	rotrwi	3,10,2
	rotrwi	4,10,13
	and	5,10,11
	and	0,10,12
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,11,12
	xor	3,3,4
	add	6,6,9
	xor	5,5,0
	add	9,9,3
	add	9,9,5

	rotrwi	3,16,7
	rotrwi	4,16,18
	rotrwi	5,29,17
	rotrwi	0,29,19
	xor	3,3,4
	srwi	4,16,3
	xor	5,5,0
	srwi	0,29,10
	add	31,31,24
	xor	3,3,4
	xor	5,5,0
	lwz	0,60(7)
	add	31,31,3
	add	31,31,5
	rotrwi	3,6,6
	rotrwi	4,6,11
	and	5,14,6
	xor	3,3,4
	add	8,8,0
	andc	0,15,6
	rotrwi	4,4,14
	or	5,5,0
	add	8,8,31
	xor	3,3,4
	add	8,8,5
	add	8,8,3

	rotrwi	3,9,2
	rotrwi	4,9,13
	and	5,9,10
	and	0,9,11
	xor	3,3,4
	rotrwi	4,4,9
	xor	5,5,0
	and	0,10,11
	xor	3,3,4
	add	12,12,8
	xor	5,5,0
	add	8,8,3
	add	8,8,5

	bdnz	.Lrounds

	lwz	3,104(1)
	lwz	31,100(1)
	lwz	5,96(1)
	subi	7,7,192

	lwz	16,0(3)
	lwz	17,4(3)
	lwz	18,8(3)
	lwz	19,12(3)
	lwz	20,16(3)
	lwz	21,20(3)
	lwz	22,24(3)
	addi	31,31,64
	lwz	23,28(3)
	add	8,8,16
	add	9,9,17
	stw	31,100(1)
	add	10,10,18
	stw	8,0(3)
	add	11,11,19
	stw	9,4(3)
	add	12,12,20
	stw	10,8(3)
	add	6,6,21
	stw	11,12(3)
	add	14,14,22
	stw	12,16(3)
	add	15,15,23
	stw	6,20(3)
	stw	14,24(3)
	.long	0x7c1f2840
	stw	15,28(3)
	bne	.Lsha2_block_private
	blr
.long	0
.byte	0,12,0x14,0,0,0,0,0
.size	sha256_block_ppc,.-sha256_block_ppc
.align	6
.LPICmeup:
	mflr	0
	bcl	20,31,$+4
	mflr	7
	addi	7,7,56
	mtlr	0
	blr
.long	0
.byte	0,12,0x14,0,0,0,0,0
.space	28
.long	0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5
.long	0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5
.long	0xd807aa98,0x12835b01,0x243185be,0x550c7dc3
.long	0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174
.long	0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc
.long	0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da
.long	0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7
.long	0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967
.long	0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13
.long	0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85
.long	0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3
.long	0xd192e819,0xd6990624,0xf40e3585,0x106aa070
.long	0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5
.long	0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3
.long	0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208
.long	0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2
