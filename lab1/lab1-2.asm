.globl _start

.data
a: .word -1, 22, 8, 35, 5, 4, 11, 2, 1, 78
newline: .string "\n"

.text
_start:
la t0, a #base array address store in t0				
lw t1, 8(t0) #swap the 3 elment to the last one
lw t2, 36(t0)
sw t1, 36(t0)
sw t2, 8(t0)

li a0, 0 #lo
li a1, 9 #hi
li a4, 1 #for use in sub

PARTITION:
lw t1, 36(t0) #use t1 as pivot the 3 element
sub t2, a0, a4 #tuse t2  as i = lo-1
addi t3, a0,0 #use t3 as j 
sub t4, a1, a4 #use t4 as hi -1
loop:
bgt t3, t4, loop_end #if j > hi-1 then finish the loop
slli t5, t3, 2 #use t5 as a[j] A[j]Swap v[k] and v[k+1]
add t5, t0, t5
lw t6, 0(t5)
		
bgt t6,t1, if_end #if A[j] ? pivot then finish if
addi t2, t2, 1 # i = i + 1
#Swap a[i] and a[j](t5)
slli a2, t2, 2 
add a2, t0, a2
lw a3, 0(a2)
sw t6, 0(a2)
sw a3, 0(t5)
if_end:
addi t3, t3, 1 #j++
j loop
	
loop_end:#swap A[i+1] with A[hi]
addi t2, t2, 1#i++
#swap
slli a2, t2, 2#i
add a2, t0, a2
lw t4, 0(a2)
	
slli t5, a1, 2#hi
add t5, t0, t5
lw t6, 0(t5)
	
sw t6, 0(a2) 
sw t4, 0(t5)
j print


print:
addi t1, a0,0 #0
addi t2, a1,0 #9
ploop:
bgt t1, t2, exit1
slli a1, t1, 2
add a1, t0, a1
li a7, 1
lw a0, 0(a1)
ecall
li a7, 4
la a0, newline
ecall
addi t1, t1, 1
j ploop


exit1:#Exit and restoring registers
lw ra, 16(sp)
lw s3, 12(sp)
lw s2, 8(sp)
lw s1, 4(sp)
lw s0, 0(sp)
addi sp, sp, 20