.section .rodata 
.note0: 
	.string "%ld\n" 
	.text 
	.globl main 
L1:
	 
heapify: 
L2:
	 
L3:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $176 , %rsp 
L4:
	 
L5:
	 
L6:
	 
L7:
	 
L8:
	 
L9:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq 32(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L10:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $2 , %r11 
	movq 32(%rbp) , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L11:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L12:
	 
L13:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq -24(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L14:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq $2 , %r11 
	movq 32(%rbp) , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L15:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -40(%rbp) , %r11 
	movq $2 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L16:
	 
L17:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -48(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L18:
	 
	movq %rbp , %r13 
	subq $64 , %r13 
	movq -32(%rbp) , %r11 
	movq 24(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L19:
	 
	movq -64(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L21 
L20:
	 
	jmp L27 
L21:
	 
	movq %rbp , %r13 
	subq $72 , %r13 
	movq -32(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L22:
	 
	movq %rbp , %r13 
	subq $80 , %r13 
	movq -8(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L23:
	 
	movq %rbp , %r13 
	subq $88 , %r13 
	movq -72(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r9 
	movq 16(%rbp) , %r11 
	addq %r9 , %r11 
	movq 0(%r11) , %r11 
	movq -80(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	cmpq %r11 , %r12 
	setl %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L24:
	 
	movq -88(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L26 
L25:
	 
	jmp L27 
L26:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq -32(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L27:
	 
	movq %rbp , %r13 
	subq $96 , %r13 
	movq -56(%rbp) , %r11 
	movq 24(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L28:
	 
	movq -96(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L30 
L29:
	 
	jmp L36 
L30:
	 
	movq %rbp , %r13 
	subq $104 , %r13 
	movq -56(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L31:
	 
	movq %rbp , %r13 
	subq $112 , %r13 
	movq -8(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L32:
	 
	movq %rbp , %r13 
	subq $120 , %r13 
	movq -104(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r9 
	movq 16(%rbp) , %r11 
	addq %r9 , %r11 
	movq 0(%r11) , %r11 
	movq -112(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	cmpq %r11 , %r12 
	setl %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L33:
	 
	movq -120(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L35 
L34:
	 
	jmp L36 
L35:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq -56(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L36:
	 
	movq %rbp , %r13 
	subq $128 , %r13 
	movq -8(%rbp) , %r11 
	movq 32(%rbp) , %r12 
	cmpq %r11 , %r12 
	setne %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L37:
	 
	movq -128(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L39 
L38:
	 
	jmp L53 
L39:
	 
	movq %rbp , %r13 
	subq $144 , %r13 
	movq 32(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L40:
	 
	movq %rbp , %r13 
	subq $136 , %r13 
	movq -144(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L41:
	 
	movq %rbp , %r13 
	subq $152 , %r13 
	movq 32(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L42:
	 
	movq %rbp , %r13 
	subq $160 , %r13 
	movq -8(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L43:
	 
	movq -152(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r14 
	movq 16(%rbp) , %r11 
	addq %r14 , %r11 
	movq %r11 , %r13 
	movq -160(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L44:
	 
	movq %rbp , %r13 
	subq $168 , %r13 
	movq -8(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L45:
	 
	movq -168(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r14 
	movq 16(%rbp) , %r11 
	addq %r14 , %r11 
	movq %r11 , %r13 
	movq -136(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L46:
	 
L47:
	 
	movq -8(%rbp) , %r11 
	pushq %r11 
L48:
	 
	movq 24(%rbp) , %r11 
	pushq %r11 
L49:
	 
	movq 16(%rbp) , %r11 
	pushq %r11 
L50:
	 
	call heapify 
L51:
	 
	addq $24 , %rsp 
L52:
	 
	movq %r8 , -176(%rbp) 
L53:
	 
L54:
	 
L55:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $176 , %rsp 
	popq %rbp 
	ret 
L56:
	 
L57:
	 
heap_sort: 
L58:
	 
L59:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $160 , %rsp 
L60:
	 
L61:
	 
L62:
	 
	movq 16(%rbp) , %r12 
	movq 0(%r12) , %r8 
L63:
	 
	movq %r8 , -8(%rbp) 
L64:
	 
L65:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq -8(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L66:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq -16(%rbp) , %r11 
	movq $2 , %r12 
	movq $0 , %rdx 
	movq %r11 , %rax 
	divq %r12 
	movq %rax , 0(%r13) 
L67:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L68:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq -24(%rbp) , %r11 
	movq -32(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L69:
	 
	movq -40(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L71 
L70:
	 
	jmp L85 
L71:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -16(%rbp) , %r11 
	movq $2 , %r12 
	movq $0 , %rdx 
	movq %r11 , %rax 
	divq %r12 
	movq %rax , 0(%r13) 
L72:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -48(%rbp) , %r11 
	movq $1 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L73:
	 
	movq %rbp , %r13 
	subq $64 , %r13 
	movq -56(%rbp) , %r11 
	movq -24(%rbp) , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L74:
	 
L75:
	 
	movq %rbp , %r13 
	subq $72 , %r13 
	movq -64(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L76:
	 
L77:
	 
	movq -72(%rbp) , %r11 
	pushq %r11 
L78:
	 
	movq -16(%rbp) , %r11 
	pushq %r11 
L79:
	 
	movq 16(%rbp) , %r11 
	pushq %r11 
L80:
	 
	call heapify 
L81:
	 
	addq $24 , %rsp 
L82:
	 
	movq %r8 , -80(%rbp) 
L83:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -24(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L84:
	 
	jmp L68 
L85:
	 
	movq %rbp , %r13 
	subq $88 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L86:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L87:
	 
	movq %rbp , %r13 
	subq $96 , %r13 
	movq -24(%rbp) , %r11 
	movq -88(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L88:
	 
	movq -96(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L90 
L89:
	 
	jmp L109 
L90:
	 
	movq %rbp , %r13 
	subq $104 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L91:
	 
	movq %rbp , %r13 
	subq $112 , %r13 
	movq -104(%rbp) , %r11 
	movq -24(%rbp) , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L92:
	 
	movq %rbp , %r13 
	subq $72 , %r13 
	movq -112(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L93:
	 
	movq %rbp , %r13 
	subq $128 , %r13 
	movq $0 , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L94:
	 
	movq %rbp , %r13 
	subq $120 , %r13 
	movq -128(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L95:
	 
	movq %rbp , %r13 
	subq $136 , %r13 
	movq $0 , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L96:
	 
	movq %rbp , %r13 
	subq $144 , %r13 
	movq -72(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L97:
	 
	movq -136(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r14 
	movq 16(%rbp) , %r11 
	addq %r14 , %r11 
	movq %r11 , %r13 
	movq -144(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L98:
	 
	movq %rbp , %r13 
	subq $152 , %r13 
	movq -72(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L99:
	 
	movq -152(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r14 
	movq 16(%rbp) , %r11 
	addq %r14 , %r11 
	movq %r11 , %r13 
	movq -120(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L100:
	 
L101:
	 
	movq $0 , %r11 
	pushq %r11 
L102:
	 
	movq -72(%rbp) , %r11 
	pushq %r11 
L103:
	 
	movq 16(%rbp) , %r11 
	pushq %r11 
L104:
	 
	call heapify 
L105:
	 
	addq $24 , %rsp 
L106:
	 
	movq %r8 , -160(%rbp) 
L107:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -24(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L108:
	 
	jmp L87 
L109:
	 
L110:
	 
L111:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $160 , %rsp 
	popq %rbp 
	ret 
L112:
	 
L113:
	 
printArray: 
L114:
	 
L115:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $32 , %rsp 
L116:
	 
L117:
	 
L118:
	 
	movq 16(%rbp) , %r12 
	movq 0(%r12) , %r8 
L119:
	 
	movq %r8 , -16(%rbp) 
L120:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L121:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -8(%rbp) , %r11 
	movq -16(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L122:
	 
	movq -24(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L124 
L123:
	 
	jmp L128 
L124:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq -8(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L125:
	 
	movq -32(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L126:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq -8(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L127:
	 
	jmp L121 
L128:
	 
L129:
	 
L130:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $32 , %rsp 
	popq %rbp 
	ret 
L131:
	 
L132:
	 
main: 
L133:
	 
L134:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $40 , %rsp 
L135:
	 
L136:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $0 , %r11 
	movq $11 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L137:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq $0 , %r11 
	movq $5 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L138:
	 
	movq $56 , %rdi 
	call malloc 
L139:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq %rax , 0(%r13) 
	movq $6 , %r12 
	movq %r12 , 0(%rax) 
	movq $12 , %r12 
	movq %r12 , 8(%rax) 
	movq -8(%rbp) , %r12 
	movq %r12 , 16(%rax) 
	movq $13 , %r12 
	movq %r12 , 24(%rax) 
	movq -16(%rbp) , %r12 
	movq %r12 , 32(%rax) 
	movq $6 , %r12 
	movq %r12 , 40(%rax) 
	movq $7 , %r12 
	movq %r12 , 48(%rax) 
L140:
	 
L141:
	 
	movq -24(%rbp) , %r11 
	pushq %r11 
L142:
	 
	call heap_sort 
L143:
	 
	addq $8 , %rsp 
L144:
	 
	movq %r8 , -32(%rbp) 
L145:
	 
L146:
	 
	movq -24(%rbp) , %r11 
	pushq %r11 
L147:
	 
	call printArray 
L148:
	 
	addq $8 , %rsp 
L149:
	 
	movq %r8 , -40(%rbp) 
L150:
	 
L151:
	 
L152:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $40 , %rsp 
	popq %rbp 
	ret 
L153:
	 
L154:
	 
L155:
	 
L156:
	 
	addq $0 , %rsp 
L157:
	 
L158:
	 
		mov $60 , %rax 
		movq $0 , %rdi 
		syscall 
format:
	.ascii "%ld\n" 
