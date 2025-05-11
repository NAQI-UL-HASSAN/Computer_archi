addi x3, x0, 37
addi x10, x0, 32
and x1, x3, x10
sw x10, 4(x10)
lw x9, 4(x10)
beq x10, x10, here
or x5, x10, x3
addi x15, x0, 21
here: sub x5, x10, x3