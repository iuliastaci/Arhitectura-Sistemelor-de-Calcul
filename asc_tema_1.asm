SECTION .data
    formatin: db "%d", 0
    formatout: db "The result is: %d", 10, 0 

    a: times 4 db 0 
    b: times 4 db 0  
    fin: times 4 db 0

    msg1 db  "Enter first number:  ", 0xA,0xD   ;inseamna \n si \r
    len1 equ $ - msg1
    msg2 db  "Enter second number: ", 0xA,0xD
    len2 equ $ - msg2
    
SECTION .text
   global _main 
   extern scanf 
   extern printf     

global main

main:

    ;afisare mesaj 1
    mov eax, 4	;system call number (sys_write)
    mov ebx, 1    ;file descriptor (stdout)
    mov ecx, msg1
    mov edx, len1
    int 80h    ;call kernel
    
    ;citire a
    sub esp, 4
   mov [esp], dword a
   sub esp, 4
   mov [esp], dword formatin
   call scanf
   add esp, 8
  
    ;afisare mesaj 2
    mov eax, 4	;system call number (sys_write)
    mov ebx, 1    ;file descriptor (stdout)
    mov ecx, msg2
    mov edx, len2
    int 80h    ;call kernel

 ;citire b
   sub esp, 4
   mov [esp], dword b
   sub esp, 4
   mov [esp], dword formatin
   call scanf
   add esp, 8

   mov ebx,0

   ;imapartirea
   mov edx,0
   mov eax, [a]
   mov ecx, [b]
   div ecx  ; ax/bl
   mov [fin], eax

    
    ;afisare 
   mov ebx, dword [fin]
   sub esp, 4
   mov [esp], ebx
   sub esp, 4
   mov [esp], dword formatout
   call printf                            
   add esp, 8

    ;exit
    mov     eax, 1
    int     0x80