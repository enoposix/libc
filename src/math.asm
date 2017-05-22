; int abs(int x) {
;     return x > 0 ? x : -x; 
; }
global _abs
_abs:
    push rdi
    fild qword [rsp]
    fabs
    fistp qword [rsp]
    pop rax
; (x + x >> 63) ^ x >> 63
;    mov rax, rdi
;    shr rdi, 0x3F ; 64 - 1
;    add rax, rdi
;    xor rax, rdi
; (x ^ x >> 63) - x >> 63
;    mov rax, rdi
;    shr rdi, 0x3F ; 64 - 1
;    xor rax, rdi
;    sub rax, rdi
    ret