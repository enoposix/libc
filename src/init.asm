section .text

%define UNIX(i) i + 0x2000000
extern _main

global start
start:
    call _main
    mov rdi, rax
    mov rax, UNIX(1)
    syscall
    ret

