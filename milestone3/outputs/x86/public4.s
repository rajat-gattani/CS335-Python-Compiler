.section .rodata 
.note0: 
	.string "%ld\n" 
	.text 
	.globl main 
L1:
	 
binarySearch: 
L2:
	 
L3:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $96 , %rsp 
L4:
	 
L5:
	 
L6:
	 
L7:
	 
L8:
	 
L9:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq 32(%rbp) , %r11 
	movq 40(%rbp) , %r12 
	cmpq %r11 , %r12 
	setge %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L10:
	 
	movq -8(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L12 
L11:
	 
	jmp L33 
L12:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq 40(%rbp) , %r11 
	movq 32(%rbp) , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L13:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -16(%rbp) , %r11 
	movq $2 , %r12 
	movq $0 , %rdx 
	movq %r11 , %rax 
	divq %r12 
	movq %rax , 0(%r13) 
L14:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq 32(%rbp) , %r11 
	movq -24(%rbp) , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L15:
	 
L16:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq -32(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L17:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -40(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L18:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -48(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r9 
	movq 16(%rbp) , %r11 
	addq %r9 , %r11 
	movq 0(%r11) , %r11 
	movq 24(%rbp) , %r12 
	cmpq %r11 , %r12 
	sete %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L19:
	 
	movq -56(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L21 
L20:
	 
	jmp L23 
L21:
	 
	movq -40(%rbp) , %r12 
	movq %r12 , %r8 
	addq $96 , %rsp 
	popq %rbp 
	ret 
L22:
	 
	jmp L32 
L23:
	 
	movq %rbp , %r13 
	subq $64 , %r13 
	movq -40(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L24:
	 
	movq %rbp , %r13 
	subq $72 , %r13 
	movq -64(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r9 
	movq 16(%rbp) , %r11 
	addq %r9 , %r11 
	movq 0(%r11) , %r11 
	movq 24(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L25:
	 
	movq -72(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L27 
L26:
	 
	jmp L30 
L27:
	 
	movq %rbp , %r13 
	subq $80 , %r13 
	movq -40(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L28:
	 
	movq %rbp , %r13 
	addq $32 , %r13 
	movq -80(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L29:
	 
	jmp L32 
L30:
	 
	movq %rbp , %r13 
	subq $88 , %r13 
	movq -40(%rbp) , %r11 
	movq $1 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L31:
	 
	movq %rbp , %r13 
	addq $40 , %r13 
	movq -88(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L32:
	 
	jmp L9 
L33:
	 
	movq %rbp , %r13 
	subq $96 , %r13 
	movq $0 , %r11 
	movq $1 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L34:
	 
	movq -96(%rbp) , %r12 
	movq %r12 , %r8 
	addq $96 , %rsp 
	popq %rbp 
	ret 
L35:
	 
L36:
	 
L37:
	 
L38:
	 
main: 
L39:
	 
L40:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $40 , %rsp 
L41:
	 
L42:
	 
	movq $64 , %rdi 
	call malloc 
L43:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq %rax , 0(%r13) 
	movq $7 , %r12 
	movq %r12 , 0(%rax) 
	movq $3 , %r12 
	movq %r12 , 8(%rax) 
	movq $4 , %r12 
	movq %r12 , 16(%rax) 
	movq $5 , %r12 
	movq %r12 , 24(%rax) 
	movq $6 , %r12 
	movq %r12 , 32(%rax) 
	movq $7 , %r12 
	movq %r12 , 40(%rax) 
	movq $8 , %r12 
	movq %r12 , 48(%rax) 
	movq $9 , %r12 
	movq %r12 , 56(%rax) 
L44:
	 
	movq -8(%rbp) , %r12 
	movq 0(%r12) , %r8 
L45:
	 
	movq %r8 , -16(%rbp) 
L46:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L47:
	 
L48:
	 
	movq -24(%rbp) , %r11 
	pushq %r11 
L49:
	 
	movq $0 , %r11 
	pushq %r11 
L50:
	 
	movq $4 , %r11 
	pushq %r11 
L51:
	 
	movq -8(%rbp) , %r11 
	pushq %r11 
L52:
	 
	call binarySearch 
L53:
	 
	addq $32 , %rsp 
L54:
	 
	movq %r8 , -32(%rbp) 
L55:
	 
L56:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq -32(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L57:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq $0 , %r11 
	movq $1 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L58:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -40(%rbp) , %r11 
	movq -48(%rbp) , %r12 
	cmpq %r11 , %r12 
	setne %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L59:
	 
	movq -56(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L61 
L60:
	 
	jmp L64 
L61:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string1(%rip) , %rsi 
	mov $28 , %rdx 
	syscall 
.section .data 
string1: .string "Element is present at index:" 
.section .text 
L62:
	 
	movq -40(%rbp) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L63:
	 
	jmp L65 
L64:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string2(%rip) , %rsi 
	mov $22 , %rdx 
	syscall 
.section .data 
string2: .string "Element is not present" 
.section .text 
L65:
	 
L66:
	 
L67:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $40 , %rsp 
	popq %rbp 
	ret 
L68:
	 
L69:
	 
L70:
	 
L71:
	 
	addq $0 , %rsp 
L72:
	 
L73:
	 
		mov $60 , %rax 
		movq $0 , %rdi 
		syscall 
format:
	.ascii "%ld\n" 
