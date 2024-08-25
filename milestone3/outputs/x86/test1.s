.section .rodata 
.note0: 
	.string "%ld\n" 
	.text 
	.globl main 
L1:
	 
testing.loop_func1: 
L2:
	 
L3:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $80 , %rsp 
L4:
	 
L5:
	 
L6:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $3 , %r12 
	movq %r12 , 0(%r13) 
L7:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -8(%rbp) , %r11 
	movq $8 , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L8:
	 
	movq -24(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L10 
L9:
	 
	jmp L34 
L10:
	 
L11:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq 16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L12:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L13:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq -16(%rbp) , %r11 
	movq $10 , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L14:
	 
	movq -40(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L16 
L15:
	 
	jmp L26 
L16:
	 
L17:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq $5 , %r12 
	movq %r12 , 0(%r13) 
L18:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -16(%rbp) , %r11 
	movq $5 , %r12 
	cmpq %r11 , %r12 
	sete %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L19:
	 
	movq -56(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L21 
L20:
	 
	jmp L24 
L21:
	 
	movq %rbp , %r13 
	subq $64 , %r13 
	movq -48(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L22:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -64(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L23:
	 
	jmp L26 
L24:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L25:
	 
	jmp L13 
L26:
	 
	movq %rbp , %r13 
	subq $72 , %r13 
	movq -32(%rbp) , %r11 
	movq $2 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L27:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq -72(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L28:
	 
	movq %rbp , %r13 
	subq $80 , %r13 
	movq -32(%rbp) , %r11 
	movq $7 , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L29:
	 
	movq -80(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L31 
L30:
	 
	jmp L32 
L31:
	 
	jmp L34 
L32:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq -8(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L33:
	 
	jmp L7 
L34:
	 
	movq -16(%rbp) , %r12 
	movq %r12 , %r8 
	addq $80 , %rsp 
	popq %rbp 
	ret 
L35:
	 
L36:
	 
L37:
	 
L38:
	 
testing.loop_func2: 
L39:
	 
L40:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $80 , %rsp 
L41:
	 
L42:
	 
L43:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $3 , %r12 
	movq %r12 , 0(%r13) 
L44:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -8(%rbp) , %r11 
	movq $8 , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L45:
	 
	movq -24(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L47 
L46:
	 
	jmp L72 
L47:
	 
L48:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq 16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L49:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L50:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq -16(%rbp) , %r11 
	movq $10 , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L51:
	 
	movq -40(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L53 
L52:
	 
	jmp L64 
L53:
	 
L54:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq $5 , %r12 
	movq %r12 , 0(%r13) 
L55:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -16(%rbp) , %r11 
	movq $5 , %r12 
	cmpq %r11 , %r12 
	sete %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L56:
	 
	movq -56(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L58 
L57:
	 
	jmp L62 
L58:
	 
	movq %rbp , %r13 
	subq $64 , %r13 
	movq -48(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L59:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -64(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L60:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L61:
	 
	jmp L50 
L62:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L63:
	 
	jmp L50 
L64:
	 
	movq %rbp , %r13 
	subq $72 , %r13 
	movq -32(%rbp) , %r11 
	movq $2 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L65:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq -72(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L66:
	 
	movq %rbp , %r13 
	subq $80 , %r13 
	movq -32(%rbp) , %r11 
	movq $7 , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L67:
	 
	movq -80(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L69 
L68:
	 
	jmp L70 
L69:
	 
	jmp L72 
L70:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq -8(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L71:
	 
	jmp L44 
L72:
	 
	movq -16(%rbp) , %r12 
	movq %r12 , %r8 
	addq $80 , %rsp 
	popq %rbp 
	ret 
L73:
	 
L74:
	 
L75:
	 
L76:
	 
main: 
L77:
	 
L78:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $32 , %rsp 
L79:
	 
L80:
	 
	movq $0 , %rdi 
	call malloc 
	movq %rax , -8(%rbp) 
L81:
	 
L82:
	 
	movq -8(%rbp) , %r15 
L83:
	 
	addq $0 , %rsp 
L84:
	 
L85:
	 
	movq $5 , %r11 
	pushq %r11 
L86:
	 
	movq -8(%rbp) , %r15 
	call testing.loop_func1 
L87:
	 
	addq $8 , %rsp 
L88:
	 
	movq %r8 , -24(%rbp) 
L89:
	 
	movq -24(%rbp) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L90:
	 
L91:
	 
	movq $5 , %r11 
	pushq %r11 
L92:
	 
	movq -8(%rbp) , %r15 
	call testing.loop_func2 
L93:
	 
	addq $8 , %rsp 
L94:
	 
	movq %r8 , -32(%rbp) 
L95:
	 
	movq -32(%rbp) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L96:
	 
L97:
	 
L98:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $32 , %rsp 
	popq %rbp 
	ret 
L99:
	 
L100:
	 
L101:
	 
L102:
	 
	addq $0 , %rsp 
L103:
	 
L104:
	 
		mov $60 , %rax 
		movq $0 , %rdi 
		syscall 
format:
	.ascii "%ld\n" 
