.section .rodata 
.note0: 
	.string "%ld\n" 
	.text 
	.globl main 
L1:
	 
ShiftReduceParser.__init__: 
L2:
	 
L3:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $8 , %rsp 
L4:
	 
L5:
	 
L6:
	 
L7:
	 
	movq %r15 , %r13 
	addq $0 , %r13 
	movq 16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L8:
	 
L9:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq $10 , %r12 
	movq %r12 , 0(%r13) 
L10:
	 
L11:
	 
L12:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $8 , %rsp 
	popq %rbp 
	ret 
L13:
	 
L14:
	 
LR0Parser.__init__: 
L15:
	 
L16:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $8 , %rsp 
L17:
	 
L18:
	 
L19:
	 
L20:
	 
L21:
	 
	movq %r15 , %r13 
	addq $8 , %r13 
	movq 16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L22:
	 
L23:
	 
	movq 24(%rbp) , %r11 
	pushq %r11 
L24:
	 
	call ShiftReduceParser.__init__ 
L25:
	 
	addq $8 , %rsp 
L26:
	 
L27:
	 
L28:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $8 , %rsp 
	popq %rbp 
	ret 
L29:
	 
L30:
	 
CLRParser.__init__: 
L31:
	 
L32:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $8 , %rsp 
L33:
	 
L34:
	 
L35:
	 
L36:
	 
L37:
	 
	movq %r15 , %r13 
	addq $8 , %r13 
	movq 16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L38:
	 
L39:
	 
	movq 24(%rbp) , %r11 
	pushq %r11 
L40:
	 
	call ShiftReduceParser.__init__ 
L41:
	 
	addq $8 , %rsp 
L42:
	 
L43:
	 
L44:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $8 , %rsp 
	popq %rbp 
	ret 
L45:
	 
L46:
	 
LALRParser.__init__: 
L47:
	 
L48:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $8 , %rsp 
L49:
	 
L50:
	 
L51:
	 
L52:
	 
L53:
	 
L54:
	 
	movq %r15 , %r13 
	addq $16 , %r13 
	movq 16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L55:
	 
L56:
	 
	movq 32(%rbp) , %r11 
	pushq %r11 
L57:
	 
	movq 24(%rbp) , %r11 
	pushq %r11 
L58:
	 
	call CLRParser.__init__ 
L59:
	 
	addq $16 , %rsp 
L60:
	 
L61:
	 
L62:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $8 , %rsp 
	popq %rbp 
	ret 
L63:
	 
L64:
	 
LALRParser.print_name: 
L65:
	 
L66:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L67:
	 
L68:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string1(%rip) , %rsi 
	mov $9 , %rdx 
	syscall 
.section .data 
string1: .string "SLR name:" 
.section .text 
L69:
	 
	movq 0(%r15) , %r12 
	movq %r12 , %rdi 
	call puts 
L70:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string2(%rip) , %rsi 
	mov $9 , %rdx 
	syscall 
.section .data 
string2: .string "CLR name:" 
.section .text 
L71:
	 
	movq 8(%r15) , %r12 
	movq %r12 , %rdi 
	call puts 
L72:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string3(%rip) , %rsi 
	mov $10 , %rdx 
	syscall 
.section .data 
string3: .string "LALR name:" 
.section .text 
L73:
	 
	movq 16(%r15) , %r12 
	movq %r12 , %rdi 
	call puts 
L74:
	 
L75:
	 
L76:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L77:
	 
L78:
	 
main: 
L79:
	 
L80:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $32 , %rsp 
L81:
	 
L82:
	 
	movq $24 , %rdi 
	call malloc 
	movq %rax , -8(%rbp) 
L83:
	 
L84:
	 
	lea string4(%rip) , %r11 
	pushq %r11 
.section .data 
string4: .string "Shift-Reduce" 
.section .text 
L85:
	 
	lea string5(%rip) , %r11 
	pushq %r11 
.section .data 
string5: .string "CLR" 
.section .text 
L86:
	 
	lea string6(%rip) , %r11 
	pushq %r11 
.section .data 
string6: .string "LALR" 
.section .text 
L87:
	 
	movq -8(%rbp) , %r15 
	call LALRParser.__init__ 
L88:
	 
	addq $24 , %rsp 
L89:
	 
L90:
	 
	lea string7(%rip) , %r11 
	pushq %r11 
.section .data 
string7: .string "Mohak" 
.section .text 
L91:
	 
	lea string8(%rip) , %r11 
	pushq %r11 
.section .data 
string8: .string "Rajat" 
.section .text 
L92:
	 
	lea string9(%rip) , %r11 
	pushq %r11 
.section .data 
string9: .string "Dhruv" 
.section .text 
L93:
	 
	movq -8(%rbp) , %r15 
	call LALRParser.__init__ 
L94:
	 
	addq $24 , %rsp 
L95:
	 
	movq %r8 , -24(%rbp) 
L96:
	 
L97:
	 
	movq -8(%rbp) , %r15 
	call LALRParser.print_name 
L98:
	 
	addq $0 , %rsp 
L99:
	 
	movq %r8 , -32(%rbp) 
L100:
	 
L101:
	 
L102:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $32 , %rsp 
	popq %rbp 
	ret 
L103:
	 
L104:
	 
L105:
	 
L106:
	 
	addq $0 , %rsp 
L107:
	 
L108:
	 
		mov $60 , %rax 
		movq $0 , %rdi 
		syscall 
format:
	.ascii "%ld\n" 
