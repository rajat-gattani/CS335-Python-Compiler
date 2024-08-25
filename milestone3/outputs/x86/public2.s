.section .rodata 
.note0: 
	.string "%ld\n" 
	.text 
	.globl main 
L1:
	 
compute_min: 
L2:
	 
L3:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $72 , %rsp 
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
	 
	movq 16(%rbp) , %r12 
	movq 0(%r12) , %r8 
L11:
	 
	movq %r8 , -24(%rbp) 
L12:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L13:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq -16(%rbp) , %r11 
	movq -24(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L14:
	 
	movq -32(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L16 
L15:
	 
	jmp L30 
L16:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq -8(%rbp) , %r11 
	movq $0 , %r12 
	cmpq %r11 , %r12 
	setl %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L17:
	 
	movq -40(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L19 
L18:
	 
	jmp L22 
L19:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -16(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L20:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq -48(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L21:
	 
	jmp L28 
L22:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -16(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L23:
	 
	movq %rbp , %r13 
	subq $64 , %r13 
	movq -56(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r9 
	movq 16(%rbp) , %r11 
	addq %r9 , %r11 
	movq 0(%r11) , %r11 
	movq -8(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L24:
	 
	movq -64(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L26 
L25:
	 
	jmp L28 
L26:
	 
	movq %rbp , %r13 
	subq $72 , %r13 
	movq -16(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L27:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq -72(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L28:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L29:
	 
	jmp L13 
L30:
	 
	movq -8(%rbp) , %r12 
	movq %r12 , %r8 
	addq $72 , %rsp 
	popq %rbp 
	ret 
L31:
	 
L32:
	 
L33:
	 
L34:
	 
compute_avg: 
L35:
	 
L36:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $48 , %rsp 
L37:
	 
L38:
	 
L39:
	 
L40:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L41:
	 
L42:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L43:
	 
	movq 16(%rbp) , %r12 
	movq 0(%r12) , %r8 
L44:
	 
	movq %r8 , -24(%rbp) 
L45:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L46:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq -16(%rbp) , %r11 
	movq -24(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L47:
	 
	movq -32(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L49 
L48:
	 
	jmp L54 
L49:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq -16(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L50:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -8(%rbp) , %r11 
	movq -40(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L51:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq -48(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L52:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L53:
	 
	jmp L46 
L54:
	 
	movq -8(%rbp) , %r12 
	movq %r12 , %r8 
	addq $48 , %rsp 
	popq %rbp 
	ret 
L55:
	 
L56:
	 
L57:
	 
L58:
	 
main: 
L59:
	 
L60:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $56 , %rsp 
L61:
	 
L62:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $0 , %r11 
	movq $2 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L63:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $0 , %r11 
	movq $9 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L64:
	 
	movq $48 , %rdi 
	call malloc 
L65:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq %rax , 0(%r13) 
	movq $5 , %r12 
	movq %r12 , 0(%rax) 
	movq -8(%rbp) , %r12 
	movq %r12 , 8(%rax) 
	movq $3 , %r12 
	movq %r12 , 16(%rax) 
	movq $0 , %r12 
	movq %r12 , 24(%rax) 
	movq $11 , %r12 
	movq %r12 , 32(%rax) 
	movq -16(%rbp) , %r12 
	movq %r12 , 40(%rax) 
L66:
	 
L67:
	 
	movq -24(%rbp) , %r11 
	pushq %r11 
L68:
	 
	call compute_min 
L69:
	 
	addq $8 , %rsp 
L70:
	 
	movq %r8 , -32(%rbp) 
L71:
	 
L72:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq -32(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L73:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string1(%rip) , %rsi 
	mov $15 , %rdx 
	syscall 
.section .data 
string1: .string "Minimum value: " 
.section .text 
L74:
	 
	movq -40(%rbp) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L75:
	 
L76:
	 
	movq -24(%rbp) , %r11 
	pushq %r11 
L77:
	 
	call compute_avg 
L78:
	 
	addq $8 , %rsp 
L79:
	 
	movq %r8 , -48(%rbp) 
L80:
	 
L81:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -48(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L82:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string2(%rip) , %rsi 
	mov $11 , %rdx 
	syscall 
.section .data 
string2: .string "Sum value: " 
.section .text 
L83:
	 
	movq -56(%rbp) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L84:
	 
L85:
	 
L86:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $56 , %rsp 
	popq %rbp 
	ret 
L87:
	 
L88:
	 
L89:
	 
L90:
	 
	addq $0 , %rsp 
L91:
	 
L92:
	 
		mov $60 , %rax 
		movq $0 , %rdi 
		syscall 
format:
	.ascii "%ld\n" 
