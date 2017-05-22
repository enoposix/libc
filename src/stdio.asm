%include "sys.inc.asm"
%include "string.inc.asm"
%include "math.inc.asm"

; void itoa10(int n, char s[24]) {
;     int i, sign;
;     sign = n;
;     i = 0;
;     do {
;         s[i++] = abs(n % 10) + '0';
;     } while ( n /= 10 );
;     if (sign < 0)
;         s[i++] = '-';
    
;     s[i] = '\0';
;     strrev(s);
; }
global _itoa10
_itoa10:
    push rbp
    mov rbp, rsp
    push r10
    push r11
    push rdi
    push rsi
    mov r10, rdi
    mov r11, rsi
.loop:
    mov rax, r10
    mov rcx, 0xA
    cqo
    idiv rcx
    mov rdi, rdx
    mov r10, rax
    call _abs
    add rax, '0'
    mov [r11], rax
    inc r11
    test r10, r10
    jnz .loop
    mov rax, [rsp+0x8]
    cmp rax, 0x0
    jge .out
    mov byte [r11], '-'
    inc r11
.out:
    mov byte [r11], 0x0
    pop rdi
    call _strrev
    sub rsp, 0x8
    pop r11
    pop r10
    mov rsp, rbp
    pop rbp
    ret

; int puts(const char *s);
global _puts
_puts:
    push rbp
    mov rbp, rsp
    push rdi
    call _strlen
    pop rsi
    mov rdx, rax
    mov rax, SYS_write
    mov rdi, 0x1
    syscall
    mov rsp, rbp
    pop rbp
    ; returns syscalls' return value
    ret

; int putchar(int c);
global _putchar
_putchar:
    push rbp
    mov rbp, rsp
    push rdi
    mov rax, SYS_write
    mov rsi, rsp
    mov rdi, 0x1
    mov rdx, 0x1
    syscall
    pop rax
    mov rsp, rbp
    pop rbp
    ret