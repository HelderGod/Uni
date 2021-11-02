.globl main
.data
Comando: .space 5
Erro:	.string "?"
#Texto:	.space 32

.text
#----------------------------------------------------
getint:
	addi sp, sp, -8
	sw ra, 0(sp)
	sw s0, 4(sp)
	lui a0, 0x10010
	
INT:	
	lb t0,0(a0)	
	addi a0,a0,1
	li t2,'\n'
	beq t0,t2,Ext

	li t1,48
	bne t0,t1,I1
	addi t4,zero,0
	jal Soma
I1:	li t1,49
	bne t0,t1,I2
	addi t4,zero,1
	jal Soma
I2:	li t1,50
	bne t0,t1,I3
	addi t4,zero,2
	jal Soma
I3:	li t1,51
	bne t0,t1,I4
	addi t4,zero,3
	jal Soma
I4:	li t1,52
	bne t0,t1,I5
	addi t4,zero,4
	jal Soma
I5:	li t1,53
	bne t0,t1,I6
	addi t4,zero,5
	jal Soma
I6:	li t1,54
	bne t0,t1,I7
	addi t4,zero,6
	jal Soma
I7:	li t1,55
	bne t0,t1,I8
	addi t4,zero,7
	jal Soma
I8:	li t1,56
	bne t0,t1,I9
	addi t4,zero,8
	jal Soma
I9:	li t1,57
	bne t0,t1,ISC
	addi t4,zero,9
	jal Soma
ISC:	
	jal INT
Soma:
	add t6,zero,t5
	slli t5,t5,1
	add t5,t5,t6
	slli t5,t5,1
	add t5,t5,t4
	jal INT

Ext:
	mv a0, t5
	lw ra, 0(sp)
	lw s0, 4(sp)
	addi sp, sp, 8
	ret
#---------------------------------------------------------------------------------	
insert_at_pos:
	bgt a6, a3, error	
	li t5, 0
	mv t2, a2		#está no registo a seguir à ultima linha
	addi t2, t2, -32		#endereço base da última linha
	mv t4, a6		#parte inteira do comando
	addi t4, t4, -1
	lui t6,0x10040

Read:	
	li t3, 64
	jal blank_data
	li a7, 8
	li a1,31
	lui a0,0x10010
	ecall
	lb t1, 0(a0)
	beq t1, a4, EXR

Go:				#linha desejada
	beq t4,t5, C	
	addi t6,t6,32
	addi t5,t5,1
	jal Go
	
blank_data:	lui a0, 0x10010
		
Go1:		sb a5, 0(a0)
		addi a0, a0, 1
		addi t3, t3, -1
		bne t3, zero, Go1
		ret

C:
	li t3,31

B:
	lb t1, 0(t2)
	sb t1, 32(t2)
	addi t3, t3, -1
	addi t2, t2, 1
	bne t3, zero, B
	addi t2, t2, -64
	addi t4, t4, 1
	bne t4, a3, C
	addi a6, a6, 1
	li t3, 31
	lui a0, 0x10010
SET:
	lb t1, 0(a0)
	sb t1, 0(t6)
	addi a0, a0, 1
	addi t6, t6, 1
	addi t3, t3, -1
	bne t3, zero, SET
	#addi s11, s11, 1	#contador de vezes que a insertMiddle foi chamada
	addi a2, a2, 32
	addi a3, a3, 1
	jal insert_at_pos

EXR:
	#lw ra,0(sp)
	#addi sp, sp, 8
	#li s11, 0
	#ret
	jal initialize



#----------------------------------------------------------------------------------
insert:
	#addi sp, sp, -4
	#sw ra, 0(sp)

	bgt a6, zero, insert_at_pos
	li a7, 8
	li a1, 31
	mv a0, a2
	ecall
	lb t0, 0(a0)
	beq t0, a4, IEXIT
	addi a2, a2, 32
	addi a3, a3, 1
	jal insert

IEXIT:
	sb a5, 0(a0)
	addi a0, a0, 1
	sb a5, 0(a0)
	#lw ra,0(sp)
	#addi sp,sp,4
	#ret
	jal initialize
#----------------------------------------------------------------------------------	
delete_end:
	bgt a6, zero, delete_at_pos
	mv t2,a2
	addi t2,t2,-32
	li t3, 31
DE:
	sb a5, 0(t2)
	addi t2,t2,1
	addi t3,t3,-1
	bne t3,zero,DE
	addi a3,a3,-1
	addi a2, a2, -32
	jal initialize
#----------------------------------------------------------------------------------
#P0:	mv t2, s3

P1:	li t3, 31

P2:	lb t1, 32(t6)
	sb t1, 0(t6)
	addi t6, t6, 1
	addi t3, t3, -1
	bne t3, zero, P2
	addi t4, t4, 1
	blt t4, a3, P1
	ret

push_back:	#addi t4, a6, -1		#parte inteira da instrução
		li t5, 0
		lui t6, 0x10040
	
P3:		beq t4, t5, P1	
		addi t6, t6, 32		#linha desejada
		addi t5, t5, 1
		j P3
#----------------------------------------------------------------------------------
delete_at_pos:

	bgt a6, a3, error
	addi t4, a6, -1
	lui t6, 0x10040
	li t5, 0
	
Get_pos_delete:
	beq t4, t5, D
	addi t6, t6, 32
	addi t5, t5, 1
	jal Get_pos_delete

D:	
	li t3, 31
DD:
	sb a5, 0(t6)
	addi t6, t6, 1
	addi t3, t3, -1
	bne t3, zero, DD
	jal push_back
	addi a3, a3, -1
	addi a2, a2, -32
	jal initialize
	
#----------------------------------------------------------------------------------
change_at_pos:
	#addi sp, sp, -4
	#sw ra, 0(sp)

	bgt a6, a3, error
	#addi a6,a6,-1
	addi t4, a6, -1
	lui t6, 0x10040

Get_pos_change:		beq t4, zero, Y1
			addi t6, t6, 32		#linha desejada
			addi t4, t4, -1
			j Get_pos_change
			
Y1:	li t3, 31
	li a7, 8
	li a1, 31
	lui a0, 0x10010
	ecall
	lb t0, 0(a0)
	beq t0, a4, initialize
	
Y2:	lb t0, 0(a0)
	addi a0, a0, 1
	sb t0, 0(t6)
	addi t6, t6, 1
	addi t3, t3, -1
	bne t3, zero, Y2
	jal append_at_pos

#----------------------------------------------------------------------------------
change_last:
	addi sp, sp, -4
	sw ra, 0(sp)
	bgt a6, zero, change_at_pos
	mv t2, a2
	addi t2, t2, -32
	addi t3, zero, 31

Z1:	li t3, 31
	li a7, 8
	li a1, 31
	lui a0, 0x10010
	ecall
	lb t0, 0(a0)
	beq t0, a4, initialize
Z2:
	lb t0, 0(a0)
	addi a0, a0, 1
	sb t0, 0(t2) 
	addi t2, t2, 1
	addi t3, t3, -1
	bne t3, zero, Z2
	jal insert
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
#---------------------------------------------------------------------------------
append_at_pos:
	beq a6, zero, insert
	bgt a6, a3, error
	li t5,0
	mv t2, a2		#está no registo a seguir à ultima linha
	addi t2,t2,-32		#endereço base da última linha
	mv t4, a6		#parte inteira do comando
	lui t6, 0x10040
	
Read_append:	
	li t3, 64
	jal blank_data
	li a7, 8
	li a1, 31
	lui a0, 0x10010
	ecall
	lb t0,0(a0)
	beq t0, a4, EXR
 
Go_append:	beq t4, t5, W1
		addi t6, t6, 32		#linha seguinte à desejada
		addi t5, t5, 1
		j Go_append
	
W1:	li t3, 31
	
W2:
	lb t1,0(t2)
	sb t1,32(t2)
	addi t3,t3,-1
	addi t2,t2,1
	bne t3,zero,W2
	addi t2,t2,-64
	addi t4, t4, 1
	bne t4, a3, W1
	addi a6, a6, 1
	li t3,31
	lui a0,0x10010
	
W3:
	lb t0, 0(a0)
	sb t0, 0(t6)
	addi a0,a0,1
	addi t6, t6, 1
	addi t3, t3, -1
	bne t3, zero, W3
	addi a2, a2, 32
	addi a3, a3, 1
	jal append_at_pos
	
#----------------------------------------------------------------------------------
X0:	li t0, '%'
	lui t1, 0x10010
	lb t4, 0(t1)
	beq t4, t0, print_everything
	ret
print:
	beq a3, zero, error
	jal X0
	mv t2, a2
	addi t2, t2, -32
	
X1:	li a7, 4
	mv a0, t2
	ecall
	jal initialize
	
#----------------------------------------------------------------------------------
print_everything:
	mv t3, a3
	lui t6, 0x10040

X2:	li a7, 4
	mv a0, t6
	ecall
	addi t3, t3, -1
	addi t6, t6, 32
	bne t3, zero, X2
	jal initialize
#----------------------------------------------------------------------------------
quit:
	li a7, 10
	ecall
	
#----------------------------------------------------------------------------------
error:		
	li a7, 4
	la a0, Erro
	ecall
	jal initialize
#----------------------------------------------------------------------------------
instruct:
	lb a0, 0(s0)
	li t0, 'i'
	beq a0, t0, insert
	li t0, 'a'
	beq a0, t0, append_at_pos
	li t0, 'c'
	beq a0, t0, change_last
	li t0, 'd'
	beq a0, t0, delete_end
	li t0, 'p'
	beq a0, t0, print
	li t0, 'Q'
	beq a0, t0, quit
	addi s0, s0, 1
	bne a0, a5, instruct
	li a7, 4
	la a0, Erro
	ecall
	ret
#----------------------------------------------------------------------------------

initialize:
	#addi sp, sp, -4
	#sw ra, 0(sp)
	
	li a7, 8
	la a0, Comando
	li a1, 4
	ecall
	mv s0, a0		#endereço da instrução
	jal getint
	mv a6, a0		#parte inteira do comando
	jal instruct
	#j initialize

#----------------------------------------------------------------------------------
main:
	li a3, 0		#line
	li a4, '.'
	li a5, '\0'
	li a7, 9
	li a0, 1024
	ecall
	mv a2, a0
	jal initialize
	li t0, 0
