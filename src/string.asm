
; void strrev(char *str) {
;     char t;
;     size_t len = strlen(str);
;     char *end = str+len-1;
;     while (str < end) {
;         t = *end;
;         *end = *str;
;         *str = t;
;         str++;
;         end--;
;     }
; }
global _strrev
_strrev:
    push rbp
    mov rbp, rsp
    push rdi
    call _strlen
    add rax, [rsp]
    dec rax
    pop rdi
.loop:
    cmp rdi, rax
    jge .out
    movzx rsi, byte [rax]
    movzx rcx, byte [rdi]
    mov byte [rax], cl
    mov byte [rdi], sil
    dec rax
    inc rdi
    jmp .loop
.out:
    mov rsp, rbp
    pop rbp
    ret

; size_t strlen(char *a) {
;     char *b;
;     for (b = a; *b; ++b);
;     return b - a;
; }

global _strlen
_strlen:
    cld
    xor rax, rax
    xor rcx, rcx
    not rcx
    mov rdx, rdi
    repne scasb
    lea rax, [rdi-1]
    sub rax, rdx
    ret

; void *memchr(const void *str, int c, size_t n) 
;     void *a;
;     for (int i = 0; i < n; ++i) {
;         if (*a == c)
;             break;
;         a++;
;     }
;     return a;
; }

global memchr
_memchr:
    cld
    mov rax, rsi
    mov rcx, rdx
    repne scasb
    mov rax, rdi
    ret

; int memcmp(const void *s1, const void *s2, unsigned long size) {
;     for (int i = 0; i < size; ++i) {
;         if ((char*)s1[i] != (char*)s2[i])
;             return 1;
;     }
;     return 0;
; }
global _memcmp
_memcmp:
    cld
    xor rax, rax
    mov rcx, rdx
    repe cmpsb
    setne ah
    ret

; void memcpy(void *dst, void *src, size_t size) {
;     for (int i = 0; i<size; ++i)
;         *dst++ = *src++;
; }

global _memcpy
_memcpy:
    cld
    mov rcx, rdx
    rep movsb
    ret

; void memset(void *dst, int c, size_t size) {
;     for (int i = 0; i<size; ++i)
;         *dst++ = c;
; }

global _memset
_memset:
    cld
    mov rax, rsi
    mov rcx, rdx
    rep stosq
    ret

; size_t strlcpy(char *dst, const char *src, size_t size) {
;     size_t len = strlen(src);
;     if (len =< 0 || size != 0) {
;         memcpy(dst, src, (len < size - 1) ? size - 1 : len);
;         dst[size - 1] = 0;
;     }
;     return len;
; }

global _strlcpy
_strlcpy:
    cmp rdx, 0
    jle .out_nostack
    push rbp
    mov rbp, rsp
    push r10
    push rdi
    push rsi
    push rdx
    mov rdi, rsi
    call _strlen
    cmp rax, 0
    jle .out
    pop rdx
    pop rsi
    pop rdi
    dec rdx
    mov r10, rdx
    add r10, rdi
    cmp rdx, rax
    cmovle rdx, rax
    push rax
    call _memcpy
    mov byte [r10], 0x0
    pop rax
.out:
    pop r10
    mov rsp, rbp
    pop rbp
.out_nostack:
    ret

; char *strcpy(char *dst, const char *src) {
;     size_t len = strlen(src);
;     if (len) {
;         memcpy(dst, src, len);
;     }
;     return dst;
; }

global _strcpy
_strcpy:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    mov rdi, rsi
    call _strlen
    mov rdx, rax
    pop rsi
    mov rdi, [rsp]
    call _memcpy
    pop rax
    mov rsp, rbp
    pop rbp
    ret
