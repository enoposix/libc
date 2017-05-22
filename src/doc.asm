; easy to copy skeleton
skeleton:
    push rbp
    mov rbp, rsp

    mov rsp, rbp
    pop rbp
    ret

; This function is written to illustrate how a 'complex' function should look.
; a function which only uses the scratch registers doesn't need any of this.
doc_func:
    ; save frame pointer
    push rbp
    mov rbp, rsp

    ; illustrate order of register arguments
    xchg rdi, rdi
    xchg rsi, rsi
    xchg rdx, rdx
    xchg rcx, rcx
    xchg r8, r8
    xchg r9, r9

    ; If you assume a function with 6+3 arguments the stack layout is as
    ; follows:
    ;
    ; old rip register      [rbp+8]
    ; old rbp register      [rbp]    <-- rbp points here
    ; argument 0            [rbp-8]
    ; argument 1            [rbp-16]
    ; argument 2            [rbp-24]
    ; saved register rbx    [rbp-32]
    ; saved register r12    [rbp-40]
    ; saved register r13    [rbp-48]
    ; saved register r14    [rbp-56]
    ; saved register r15    [rbp-64] <-- rsp points here

    ; save callee saved regs
    push rbx
    push r12
    push r13
    push r14
    push r15

    ; main function body

    ; return registers
    mov rax, 0
    mov rdi, 0

    ; restore callee saved regs
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx

    ; restore frame pointer
    mov rsp, rbp
    pop rbp
    ret