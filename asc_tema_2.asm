extern printf
extern scanf

section .data
x dq 2.0
a dq 1.0
b dq 1.0
a1 dq 1.0

f_ecuatie db "(%f+%f)/2 = %f",10,0

f_read db "%lf\n",0

msg1 db "Calculam (a+b)/2:", 9,10
len1 equ $ - msg1

msg3 db "Introduce a si b:", 9,10
len3 equ $ - msg3

section .bss
section .text

global main
main:

push rbp
mov rbp, rsp

mov ecx, 0
mov edx, 0
mov ecx, msg1
mov edx, len1
mov ebx, 1 
mov eax, 4
int 0x80

;afisam msg 3
mov ecx, 0
mov edx, 0
mov ecx, msg3
mov edx, len3
mov ebx, 1 
mov eax, 4
int 0x80

;citim a
mov rdi, f_read
mov rax, 0 
mov rsi, a
call scanf
movsd qword [a], xmm0

;copiem valoarea lui a in a1
movsd xmm0, [a]
movsd qword [a1], xmm0

;citim b
mov rdi, f_read
mov rax, 0 
mov rsi, b
call scanf
movsd qword [b], xmm0

; adunam b la valoarea lui a, salvam rezultatul in a
movsd xmm0, [a]
addsd xmm0, [b]
movsd [a], xmm0 

;impartim a+b la x, care are valoarea 2
movsd xmm0, [a]
divsd xmm0, [x] 
movsd [a], xmm0

;afisam rezultatul ecuatiei
mov ecx, 0
mov edx, 0
mov rdi,f_ecuatie
movsd xmm0, [a1]
movsd xmm1, [b]
movsd xmm2, [a]
mov rax, 3 
call printf

;inchidem programul
mov rsp, rbp
pop rbp 
ret