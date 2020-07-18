## RiSC-16 assembly multiplication algorithm (FPGA)
## by Yavuz Selim Tozlu

#begin
	lw 		r1,r0,a #r1=a , multiplicand
	lw 		r2,r0,b #r2=b , multiplier
	addi 	r5,r0,0
	
	beq 	r0,r1,done #zero detected
	beq 	r0,r2,done #zero detected


	addi 	r3,r0,1 #r3=1 (0000 0000 0000 0001), global mask


loop1: beq 	r0,r3,done1 #are we done?
	nand 	r4,r2,r3 #AND r2 with the mask, store in r4
	nand 	r4,r4,r4
	beq 	r4,r3,set_mask #branch if the bit is set
	add 	r3,r3,r3 #left shift the mask
	beq 	r0,r0,loop1 #if not, keep looping

set_mask: addi 	r6,r0,1 #r6=1 (0000 0000 0000 0001), local mask
	add 	r7,r1,r0
	beq 	r0,r0,loop2
	
shift_mask: add r3,r3,r3
	add 	r5,r5,r7
	beq 	r0,r0,loop1

loop2: beq	r6,r3,shift_mask #check if we reached the mask
	add 	r7,r7,r7
	add 	r6,r6,r6 #shift the local mask
	beq 	r0,r0 loop2 #rewind

done1: sw 	r5,r0,1

done2: lw 	r5,r0,1
	beq 	r0,r0,done2

a: .fill 12 #operands
b: .fill 5

#end
