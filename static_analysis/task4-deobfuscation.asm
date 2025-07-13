section .data
  data dd 0x8a, 0x101, 0x11e, 0x178, 0x163, 0x108, 0x136, 0x101, 0x104, 0x12d, 0x178, 0x17f , 0x165, 0x11d, 0x171, 0x136, 0x101, 0x171, 0x17f, 0x135, 0x163, 0x11b, 0x178, 0x11e, 0x127, 0x3f, 0x12b
  data_len equ 28

  flag_msg db 'FLAG: ', 0
  nl db 0xA, 0

section .bss
  decoded_flag resb 32

section .text
  global _start

_start:
  xor esi, esi

loop:
  cmp esi, data_len
  jge show_flag

  mov eax, [data + esi * 4]         ; Cargar valores obfuscados
  xor eax, 0x55                     ; Operacion XOR con 0x55
  sub eax, 7
  mov ebx, 3 
  cdq
  idiv ebx

  mov [decoded_flag + esi], al

  inc esi 
  jmp loop

show_flag:
  mov byte[decoded_flag + data_len], 0

  mov eax, 4
  mov ebx, 1 
  mov ecx, flag_msg
  mov edx, 6
  int 0x80

  mov eax, 4
  mov ebx, 1 
  mov ecx, decoded_flag
  mov edx, data_len
  int 0x80

  mov eax, 4
  mov ebx, 1 
  mov ecx, nl
  mov edx, 1 
  int 0x80

  mov eax, 1 
  xor ebx, ebx
  int 0x80
