.globl _start

.data
a: .word -1, 22, 8, 35, 5, 4, 11, 2, 1, 78
newline: .string "\n"
space: .string " "

.text
_start:
la t0, a #t0 = array address
li a4 1#sub use
li t1, 0
li t2, 9
Print_before:
bgt t1, t2, Print_end#util print all
slli a1, t1, 2
add a1, t0, a1
li a7, 1
lw a0, 0(a1)
ecall
li a7, 4
la a0, space
li a7, 4
ecall
addi t1, t1, 1
j Print_before
Print_end:
la a0, newline
li a7, 4
ecall

li a1, 9 # hi
li a2, 0 # lo
jal ra, Quicksort 

Print:
li t1, 0
li t2, 9
Print_after:
bgt t1, t2, exit
slli a1, t1, 2
add a1, t0, a1
li a7, 1
lw a0, 0(a1)
ecall
li a7, 4
la a0, space
ecall
addi t1, t1, 1
j Print_after


Quicksort:
addi sp, sp, -16 #4 stack 
sw t2, 12(sp)#p
sw a1, 8(sp)
sw a2, 4(sp)
sw ra, 0(sp)
bge a2, a1, Quicksort_end#if lo >=hi end
#if lo < hi then	
jal ra, PARTITION#p ¡ö partition(A, lo, hi);
sub a1, t2, a4#quicksort(A, lo, p - 1);
jal ra, Quicksort
addi a2, t2, 1#quicksort(A, p + 1, hi);
lw a1, 8(sp)#update the value
jal ra, Quicksort
Quicksort_end:
lw t2, 12(sp)#restore
lw a1, 8(sp)
lw a2, 4(sp)
lw ra, 0(sp)
addi sp, sp, 16#stack
jalr zero, 0(ra)#back

PARTITION:
addi sp, sp, -4#stack
sw ra, 0(sp)
slli t1, a1, 2
add t1, t0, t1
lw t1, 0(t1)# pivot
sub t2, a2, a4	#use t2  as i = lo-1
addi t3, a2,0  # use t3 as j
sub t4, a1, a4	#use t4 as hi -1
loop:
bgt t3, t4, loop_end#if j > hi-1 then finish the loop
slli t5, t3, 2 #use t5 as a[j] A[j]Swap v[k] and v[k+1]
add t5, t0, t5 	
lw t6, 0(t5) 
bgt t6, t1, if_end #if A[j] ? pivot then finish if
addi t2, t2, 1 # i = i + 1
#Swap a[i] and a[j](t5)
slli a5, t2, 2 
add a5, t0, a5 			
lw a6, 0(a5) 			
sw t6, 0(a5) 		
sw a6, 0(t5) 		
if_end:
addi t3, t3, 1#j++
j loop
loop_end:#swap A[i+1] with A[hi]
addi t2, t2, 1#i++
#swap
slli a5, t2, 2
add a5, t0, a5
lw a6, 0(a5)
slli t5, a1, 2
add t5, t0, t5
lw t6, 0(t5)
sw t6, 0(a5) 
sw a6, 0(t5)

lw ra, 0(sp)
addi sp, sp, 4#stack
jalr zero, 0(ra)#back



exit:
