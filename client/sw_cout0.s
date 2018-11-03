#sw,255,,,here is for comment.

addi $2,$0,0x43

#mem[0x30000004] << $2
addi $3,$0,3
sll $3,$3,28
sw $2,4($3)
addi $2,$0,0xffff
sw $2,4($3)
JR $0
