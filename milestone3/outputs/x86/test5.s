.section .rodata 
.note0: 
	.string "%ld\n" 
	.text 
	.globl main 
L1:
	 
merge: 
L2:
	 
L3:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $216 , %rsp 
L4:
	 
L5:
	 
L6:
	 
L7:
	 
L8:
	 
L9:
	 
L10:
	 
L11:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq 24(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L12:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq 40(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L13:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq 24(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L14:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq -16(%rbp) , %r11 
	movq -24(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L15:
	 
	movq -32(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L17 
L16:
	 
	jmp L22 
L17:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq -16(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L18:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -16(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L19:
	 
	movq -40(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r14 
	movq 48(%rbp) , %r11 
	addq %r14 , %r11 
	movq %r11 , %r13 
	movq -48(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 16(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L20:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq -16(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L21:
	 
	jmp L14 
L22:
	 
L23:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq 24(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L24:
	 
	movq %rbp , %r13 
	subq $64 , %r13 
	movq 32(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L25:
	 
L26:
	 
	movq %rbp , %r13 
	subq $72 , %r13 
	movq -64(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L27:
	 
L28:
	 
	movq %rbp , %r13 
	subq $80 , %r13 
	movq 24(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L29:
	 
	movq %rbp , %r13 
	subq $88 , %r13 
	movq -56(%rbp) , %r11 
	movq 32(%rbp) , %r12 
	cmpq %r11 , %r12 
	setge %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L30:
	 
	movq -88(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L32 
L31:
	 
	jmp L54 
L32:
	 
	movq %rbp , %r13 
	subq $96 , %r13 
	movq -72(%rbp) , %r11 
	movq 40(%rbp) , %r12 
	cmpq %r11 , %r12 
	setge %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L33:
	 
	movq -96(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L35 
L34:
	 
	jmp L54 
L35:
	 
	movq %rbp , %r13 
	subq $104 , %r13 
	movq -56(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L36:
	 
	movq %rbp , %r13 
	subq $112 , %r13 
	movq -72(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L37:
	 
	movq %rbp , %r13 
	subq $120 , %r13 
	movq -104(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r9 
	movq 48(%rbp) , %r11 
	addq %r9 , %r11 
	movq 0(%r11) , %r11 
	movq -112(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 48(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	cmpq %r11 , %r12 
	setge %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L38:
	 
	movq -120(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L40 
L39:
	 
	jmp L46 
L40:
	 
	movq %rbp , %r13 
	subq $128 , %r13 
	movq -80(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L41:
	 
	movq %rbp , %r13 
	subq $136 , %r13 
	movq -56(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L42:
	 
	movq -128(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r14 
	movq 16(%rbp) , %r11 
	addq %r14 , %r11 
	movq %r11 , %r13 
	movq -136(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 48(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L43:
	 
	movq %rbp , %r13 
	subq $144 , %r13 
	movq -56(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L44:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -144(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L45:
	 
	jmp L51 
L46:
	 
	movq %rbp , %r13 
	subq $152 , %r13 
	movq -80(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L47:
	 
	movq %rbp , %r13 
	subq $160 , %r13 
	movq -72(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L48:
	 
	movq -152(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r14 
	movq 16(%rbp) , %r11 
	addq %r14 , %r11 
	movq %r11 , %r13 
	movq -160(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 48(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L49:
	 
	movq %rbp , %r13 
	subq $168 , %r13 
	movq -72(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L50:
	 
	movq %rbp , %r13 
	subq $72 , %r13 
	movq -168(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L51:
	 
	movq %rbp , %r13 
	subq $176 , %r13 
	movq -80(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L52:
	 
	movq %rbp , %r13 
	subq $80 , %r13 
	movq -176(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L53:
	 
	jmp L29 
L54:
	 
	movq %rbp , %r13 
	subq $184 , %r13 
	movq -56(%rbp) , %r11 
	movq 32(%rbp) , %r12 
	cmpq %r11 , %r12 
	setge %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L55:
	 
	movq -184(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L57 
L56:
	 
	jmp L65 
L57:
	 
	movq %rbp , %r13 
	subq $192 , %r13 
	movq -80(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L58:
	 
	movq %rbp , %r13 
	subq $200 , %r13 
	movq -56(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L59:
	 
	movq -192(%rbp) , %r11 
	addq $8 , %r11 
	movq %r11 , %r14 
	movq 16(%rbp) , %r11 
	addq %r14 , %r11 
	movq %r11 , %r13 
	movq -200(%rbp) , %r12 
	addq $8 , %r12 
	movq %r12 , %r10 
	movq 48(%rbp) , %r12 
	addq %r10 , %r12 
	movq 0(%r12) , %r12 
	movq %r12 , 0(%r13) 
L60:
	 
	movq %rbp , %r13 
	subq $208 , %r13 
	movq -56(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L61:
	 
	movq %rbp , %r13 
	subq $56 , %r13 
	movq -208(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L62:
	 
	movq %rbp , %r13 
	subq $216 , %r13 
	movq -80(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L63:
	 
	movq %rbp , %r13 
	subq $80 , %r13 
	movq -216(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L64:
	 
	jmp L54 
L65:
	 
L66:
	 
L67:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $216 , %rsp 
	popq %rbp 
	ret 
L68:
	 
L69:
	 
merge_sort: 
L70:
	 
L71:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $56 , %rsp 
L72:
	 
L73:
	 
L74:
	 
L75:
	 
L76:
	 
L77:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq 24(%rbp) , %r11 
	movq 32(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L78:
	 
	movq -8(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L80 
L79:
	 
	jmp L110 
L80:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq 24(%rbp) , %r11 
	movq 32(%rbp) , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L81:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -16(%rbp) , %r11 
	movq $2 , %r12 
	movq $0 , %rdx 
	movq %r11 , %rax 
	divq %r12 
	movq %rax , 0(%r13) 
L82:
	 
L83:
	 
	movq %rbp , %r13 
	subq $32 , %r13 
	movq -24(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L84:
	 
L85:
	 
	movq 40(%rbp) , %r11 
	pushq %r11 
L86:
	 
	movq -32(%rbp) , %r11 
	pushq %r11 
L87:
	 
	movq 24(%rbp) , %r11 
	pushq %r11 
L88:
	 
	movq 16(%rbp) , %r11 
	pushq %r11 
L89:
	 
	call merge_sort 
L90:
	 
	addq $32 , %rsp 
L91:
	 
	movq %r8 , -40(%rbp) 
L92:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -32(%rbp) , %r11 
	movq $1 , %r12 
	addq %r12 , %r11 
	movq %r11 , 0(%r13) 
L93:
	 
L94:
	 
	movq 40(%rbp) , %r11 
	pushq %r11 
L95:
	 
	movq 32(%rbp) , %r11 
	pushq %r11 
L96:
	 
	movq -48(%rbp) , %r11 
	pushq %r11 
L97:
	 
	movq 16(%rbp) , %r11 
	pushq %r11 
L98:
	 
	call merge_sort 
L99:
	 
	addq $32 , %rsp 
L100:
	 
	movq %r8 , -56(%rbp) 
L101:
	 
L102:
	 
	movq 40(%rbp) , %r11 
	pushq %r11 
L103:
	 
	movq 32(%rbp) , %r11 
	pushq %r11 
L104:
	 
	movq -32(%rbp) , %r11 
	pushq %r11 
L105:
	 
	movq 24(%rbp) , %r11 
	pushq %r11 
L106:
	 
	movq 16(%rbp) , %r11 
	pushq %r11 
L107:
	 
	call merge 
L108:
	 
	addq $40 , %rsp 
L109:
	 
	movq %r8 , -64(%rbp) 
L110:
	 
L111:
	 
L112:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $56 , %rsp 
	popq %rbp 
	ret 
L113:
	 
L114:
	 
print_list: 
L115:
	 
L116:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $24 , %rsp 
L117:
	 
L118:
	 
L119:
	 
L120:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $0 , %r12 
	movq %r12 , 0(%r13) 
L121:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq -8(%rbp) , %r11 
	movq 24(%rbp) , %r12 
	cmpq %r11 , %r12 
	setg %al 
	movzbq %al , %r11 
	movq %r11 , 0(%r13) 
L122:
	 
	movq -16(%rbp) , %r11 
	cmpq $0 , %r11 
	jne L124 
L123:
	 
	jmp L128 
L124:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -8(%rbp) , %r11 
	movq $8 , %r12 
	imulq %r12 , %r11 
	movq %r11 , 0(%r13) 
L125:
	 
	movq -24(%rbp) , %r12 
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
	addq $24 , %rsp 
	popq %rbp 
	ret 
L131:
	 
L132:
	 
main: 
L133:
	 
L134:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $56 , %rsp 
L135:
	 
L136:
	 
	movq $64 , %rdi 
	call malloc 
L137:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq %rax , 0(%r13) 
	movq $7 , %r12 
	movq %r12 , 0(%rax) 
	movq $38 , %r12 
	movq %r12 , 8(%rax) 
	movq $27 , %r12 
	movq %r12 , 16(%rax) 
	movq $43 , %r12 
	movq %r12 , 24(%rax) 
	movq $3 , %r12 
	movq %r12 , 32(%rax) 
	movq $9 , %r12 
	movq %r12 , 40(%rax) 
	movq $82 , %r12 
	movq %r12 , 48(%rax) 
	movq $10 , %r12 
	movq %r12 , 56(%rax) 
L138:
	 
	movq -8(%rbp) , %r12 
	movq 0(%r12) , %r8 
L139:
	 
	movq %r8 , -16(%rbp) 
L140:
	 
L141:
	 
	movq %rbp , %r13 
	subq $24 , %r13 
	movq -16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L142:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string1(%rip) , %rsi 
	mov $16 , %rdx 
	syscall 
.section .data 
string1: .string "Original list:\n" 
.section .text 
L143:
	 
L144:
	 
	movq -24(%rbp) , %r11 
	pushq %r11 
L145:
	 
	movq -8(%rbp) , %r11 
	pushq %r11 
L146:
	 
	call print_list 
L147:
	 
	addq $16 , %rsp 
L148:
	 
	movq %r8 , -32(%rbp) 
L149:
	 
	movq $64 , %rdi 
	call malloc 
L150:
	 
	movq %rbp , %r13 
	subq $40 , %r13 
	movq %rax , 0(%r13) 
	movq $7 , %r12 
	movq %r12 , 0(%rax) 
	movq $0 , %r12 
	movq %r12 , 8(%rax) 
	movq $0 , %r12 
	movq %r12 , 16(%rax) 
	movq $0 , %r12 
	movq %r12 , 24(%rax) 
	movq $0 , %r12 
	movq %r12 , 32(%rax) 
	movq $0 , %r12 
	movq %r12 , 40(%rax) 
	movq $0 , %r12 
	movq %r12 , 48(%rax) 
	movq $0 , %r12 
	movq %r12 , 56(%rax) 
L151:
	 
	movq %rbp , %r13 
	subq $48 , %r13 
	movq -24(%rbp) , %r11 
	movq $1 , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L152:
	 
L153:
	 
	movq -40(%rbp) , %r11 
	pushq %r11 
L154:
	 
	movq -48(%rbp) , %r11 
	pushq %r11 
L155:
	 
	movq $0 , %r11 
	pushq %r11 
L156:
	 
	movq -8(%rbp) , %r11 
	pushq %r11 
L157:
	 
	call merge_sort 
L158:
	 
	addq $32 , %rsp 
L159:
	 
	movq %r8 , -56(%rbp) 
L160:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string2(%rip) , %rsi 
	mov $14 , %rdx 
	syscall 
.section .data 
string2: .string "Sorted list:\n" 
.section .text 
L161:
	 
L162:
	 
	movq -24(%rbp) , %r11 
	pushq %r11 
L163:
	 
	movq -8(%rbp) , %r11 
	pushq %r11 
L164:
	 
	call print_list 
L165:
	 
	addq $16 , %rsp 
L166:
	 
	movq %r8 , -64(%rbp) 
L167:
	 
L168:
	 
L169:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $56 , %rsp 
	popq %rbp 
	ret 
L170:
	 
L171:
	 
L172:
	 
L173:
	 
	addq $0 , %rsp 
L174:
	 
L175:
	 
		mov $60 , %rax 
		movq $0 , %rdi 
		syscall 
format:
	.ascii "%ld\n" 
