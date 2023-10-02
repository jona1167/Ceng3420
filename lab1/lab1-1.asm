.globl _start
.data
var1: .byte 15
var2: .byte 19
newline:  .string "\n"

.text
_start:
li a7, 1 # print var1
la a0, var1 
ecall 

li a7, 4 # print newline
la a0, newline  
ecall

li a7, 1 # print var2
la a2, var2 
ecall 

li a7, 4# print newline
la a0, newline  
ecall

#Increase var1 by 1
lb t0, var1
addi t0, t0, 1
la a0, var1
sb t0, 0(a0)
li a7, 1
lb a0, var1
ecall

li a7, 4# print newline
la a0, newline  
ecall

lb t1, var2 #multiply var2 by 4
li t2, 4
mul t1, t1, t2
la a0, var2
sb t1, 0(a0)
li a7, 1
lb a0, var2
ecall

li a7, 4# print newline
la a0, newline  
ecall

#swap
la a1, var1
la a2, var2
lb t3, var2
lb t4, var1

sb t3, 0(a1)
sb t4, 0(a2)

li a7, 1# print var1
lb a0, var1
ecall

li a7, 4# print newline
la a0, newline  
ecall

li a7, 1# print var2
lb a0, var2
ecall

li a7, 10 #exit
ecall 
