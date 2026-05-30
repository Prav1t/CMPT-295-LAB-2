.section .note.GNU-stack,""
    .global calculate
    .text

calculate:  

    # To save call preserved registers 
    push %rbx # to hold x throughout
    push %r12 # to hold a
    push %r13 # to hold b
    push %r14 # to hold c

    mov %rdi, %rbx # rbx = x

    # a = x + 3
    mov %rbx, %r12 # r12 = x
    add $3, %r12   # r12 = a = x + 3

    # b = f(x, a)
    mov %rbx, %rdi # arg1 = x
    mov %r12, %rsi # arg2 = a
    call f
    mov %rax, %r13 # r13 = b

    # c = f(b, x)
    mov %r13, %rdi # arg1 = b
    mov %rbx, %rsi # arg2 = x
    call f
    mov %rax, %r14 # r14 = c

    # d = f(x, c)
   
    
    mov %rbx, %rcx # rcx = x used the non-preserved register here
    push %rcx # saved rcx on stack before f() destroys it
    mov %rbx, %rdi          
    mov %r14, %rsi         
    call f  
    pop %rcx   # rcx = x after restored from stack
                           

    # return a + b + c + d
    add %r12, %rax          
    add %r13, %rax          
    add %r14, %rax          

    # Now to estore the call-preserved registers 
    pop %r14
    pop %r13
    pop %r12
    pop %rbx

    ret
