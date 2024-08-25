.section .rodata 
.note0: 
	.string "%ld\n" 
	.text 
	.globl main 
L1:
	 
bubbleSort: 
L2:
	 
L3:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $136 , %rsp 
L4:
	 
L5:
	 
L6:
	 
L7:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L8:
	 
L9:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L10:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L11:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -8(%rbp) , %r11 
	movq $5 , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L12:
	 
	movq -24(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L14 
L13:
	 
	jmp L45 
L14:
	 
L15:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L16:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq $4 , %r11 
	movq -8(%rbp) , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L17:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L18:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -16(%rbp) , %r11 
	movq -40(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L19:
	 
	movq -48(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L21 
L20:
	 
	jmp L40 
L21:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -16(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L22:
	 
	movq %rbp , %r13 
	subq $64 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L23:
	 
	movq %rbp , %r13 
	subq $72 , %r13 
	movq -64(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L24:
	 
	movq %rbp , %r13 
	subq $80 , %r13 
	movq -56(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r9 
	movq 16(%rbp) , %r11 
	addq %r9 , %r11 
	movq 0(%r11) , %r11 
	movq -72(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	cmpq %r11 , %r12 
	setl %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L25:
	 
	movq -80(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L27 
L26:
	 
	jmp L38 
L27:
	 
	movq %rbp , %r13 
	subq $88 , %r13 
	movq -16(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L28:
	 
L29:
	 
	movq %rbp , %r13 
	subq $96 , %r13 
	movq -88(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L30:
	 
	movq %rbp , %r13 
	subq $104 , %r13 
	movq -16(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L31:
	 
	movq %rbp , %r13 
	subq $112 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L32:
	 
	movq %rbp , %r13 
	subq $120 , %r13 
	movq -112(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L33:
	 
	movq -104(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r14 
	movq 16(%rbp) , %r11 
	addq %r14 , %r11 
	movq %r11 , %r13 
	movq -120(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L34:
	 
	movq %rbp , %r13 
	subq $128 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L35:
	 
	movq %rbp , %r13 
	subq $136 , %r13 
	movq -128(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L36:
	 
	movq -136(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r14 
	movq 16(%rbp) , %r11 
	addq %r14 , %r11 
	movq %r11 , %r13 
	movq -96(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L37:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq $1 , %r12 
	movq %r12 , 0(%r13) 
L38:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L39:
	 
	jmp L18 
L40:
	 
	movq -32(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L43 
L41:
	 
	jmp L42 
L42:
	 
	jmp L45 
L43:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq -8(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L44:
	 
	jmp L11 
L45:
	 
L46:
	 
L47:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $136 , %rsp 
	popq %rbp 
	ret 
L48:
	 
L49:
	 
main: 
L50:
	 
L51:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $64 , %rsp 
L52:
	 
L53:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $0 , %r11 
	movq $2 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L54:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $0 , %r11 
	movq $9 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L55:
	 
	movq $48 , %rdi 
	call malloc 
L56:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq %rax , 0(%r13) 
	movq $5 , %r12 
	movq %r12 , 0(%rax) 
	movq -8(%rbp) , %r12 
	movq %r12 , 8(%rax) 
	movq $45 , %r12 
	movq %r12 , 16(%rax) 
	movq $0 , %r12 
	movq %r12 , 24(%rax) 
	movq $11 , %r12 
	movq %r12 , 32(%rax) 
	movq -16(%rbp) , %r12 
	movq %r12 , 40(%rax) 
L57:
	 
L58:
	 
	movq -24(%rbp) , %r11 
	pushq %r11 
L59:
	 
	call bubbleSort 
L60:
	 
	addq $8 , %rsp 
L61:
	 
	movq %r8 , -32(%rbp) 
L62:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string1(%rip) , %rsi 
	mov $34 , %rdx 
	syscall 
.section .data 
string1: .string "Sorted Array in Ascending Order:\n" 
.section .text 
L63:
	 
L64:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L65:
	 
	movq -24(%rbp) , %r12 
	movq 0(%r12) , %r8 
L66:
	 
	movq %r8 , -48(%rbp) 
L67:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L68:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -40(%rbp) , %r11 
	movq -48(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L69:
	 
	movq -56(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L71 
L70:
	 
	jmp L75 
L71:
	 
	movq %rbp , %r13 
	subq $64 , %r13 
	movq -40(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L72:
	 
	movq -64(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq -24(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L73:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq -40(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L74:
	 
	jmp L68 
L75:
	 
L76:
	 
L77:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $64 , %rsp 
	popq %rbp 
	ret 
L78:
	 
L79:
	 
L80:
	 
L81:
	 
	addq $0 , %rsp 
L82:
	 
L83:
	 
		mov $60 , %rax 
		movq $0 , %rdi 
		syscall 
format:
	.ascii "%ld\n" 
