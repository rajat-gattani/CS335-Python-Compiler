.section .rodata 
.note0: 
	.string "%ld\n" 
	.text 
	.globl main 
L1:
	 
Student.__init__: 
L2:
	 
L3:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L4:
	 
L5:
	 
L6:
	 
L7:
	 
L8:
	 
L9:
	 
	movq %r15 , %r13 
	addq $0 , %r13 
	movq 16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L10:
	 
L11:
	 
	movq %r15 , %r13 
	addq $32 , %r13 
	movq 24(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L12:
	 
L13:
	 
	movq %r15 , %r13 
	addq $24 , %r13 
	movq 32(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L14:
	 
L15:
	 
L16:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L17:
	 
L18:
	 
Student.display_info: 
L19:
	 
L20:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L21:
	 
L22:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string1(%rip) , %rsi 
	mov $6 , %rdx 
	syscall 
.section .data 
string1: .string "Name: " 
.section .text 
L23:
	 
	movq 0(%r15) , %r12 
	movq %r12 , %rdi 
	call puts 
L24:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string2(%rip) , %rsi 
	mov $5 , %rdx 
	syscall 
.section .data 
string2: .string "Age: " 
.section .text 
L25:
	 
	movq 32(%r15) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L26:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string3(%rip) , %rsi 
	mov $7 , %rdx 
	syscall 
.section .data 
string3: .string "Grade: " 
.section .text 
L27:
	 
	movq 24(%r15) , %r12 
	movq %r12 , %rdi 
	call puts 
L28:
	 
L29:
	 
L30:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L31:
	 
L32:
	 
Student.update_grade: 
L33:
	 
L34:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L35:
	 
L36:
	 
L37:
	 
L38:
	 
	movq %r15 , %r13 
	addq $24 , %r13 
	movq 16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L39:
	 
L40:
	 
L41:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L42:
	 
L43:
	 
Student.update_age: 
L44:
	 
L45:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L46:
	 
L47:
	 
L48:
	 
L49:
	 
	movq %r15 , %r13 
	addq $32 , %r13 
	movq 16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L50:
	 
L51:
	 
L52:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L53:
	 
L54:
	 
Student.calculate_birth_year: 
L55:
	 
L56:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $16 , %rsp 
L57:
	 
L58:
	 
L59:
	 
	movq %rbp , %r13 
	subq $8 , %r13 
	movq 16(%rbp) , %r11 
	movq 32(%r15) , %r12 
	subq %r12 , %r11 
	movq %r11 , 0(%r13) 
L60:
	 
L61:
	 
	movq %rbp , %r13 
	subq $16 , %r13 
	movq -8(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L62:
	 
	movq -16(%rbp) , %r12 
	movq %r12 , %r8 
	addq $16 , %rsp 
	popq %rbp 
	ret 
L63:
	 
L64:
	 
L65:
	 
L66:
	 
main: 
L67:
	 
L68:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $120 , %rsp 
L69:
	 
L70:
	 
	movq $40 , %rdi 
	call malloc 
	movq %rax , -8(%rbp) 
L71:
	 
L72:
	 
	lea string4(%rip) , %r11 
	pushq %r11 
.section .data 
string4: .string "12th" 
.section .text 
L73:
	 
	movq $17 , %r11 
	pushq %r11 
L74:
	 
	lea string5(%rip) , %r11 
	pushq %r11 
.section .data 
string5: .string "Alice" 
.section .text 
L75:
	 
	movq -8(%rbp) , %r15 
	call Student.__init__ 
L76:
	 
	addq $24 , %rsp 
L77:
	 
	movq $40 , %rdi 
	call malloc 
	movq %rax , -24(%rbp) 
L78:
	 
L79:
	 
	lea string6(%rip) , %r11 
	pushq %r11 
.section .data 
string6: .string "11th" 
.section .text 
L80:
	 
	movq $16 , %r11 
	pushq %r11 
L81:
	 
	lea string7(%rip) , %r11 
	pushq %r11 
.section .data 
string7: .string "Bob" 
.section .text 
L82:
	 
	movq -24(%rbp) , %r15 
	call Student.__init__ 
L83:
	 
	addq $24 , %rsp 
L84:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string8(%rip) , %rsi 
	mov $30 , %rdx 
	syscall 
.section .data 
string8: .string "Initial Student Information:\n" 
.section .text 
L85:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string9(%rip) , %rsi 
	mov $12 , %rdx 
	syscall 
.section .data 
string9: .string "Student 1:\n" 
.section .text 
L86:
	 
L87:
	 
	movq -8(%rbp) , %r15 
	call Student.display_info 
L88:
	 
	addq $0 , %rsp 
L89:
	 
	movq %r8 , -40(%rbp) 
L90:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string10(%rip) , %rsi 
	mov $12 , %rdx 
	syscall 
.section .data 
string10: .string "Student 2:\n" 
.section .text 
L91:
	 
L92:
	 
	movq -24(%rbp) , %r15 
	call Student.display_info 
L93:
	 
	addq $0 , %rsp 
L94:
	 
	movq %r8 , -48(%rbp) 
L95:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string11(%rip) , %rsi 
	mov $33 , %rdx 
	syscall 
.section .data 
string11: .string "Updating Student Information...\n" 
.section .text 
L96:
	 
L97:
	 
	lea string12(%rip) , %r11 
	pushq %r11 
.section .data 
string12: .string "11th" 
.section .text 
L98:
	 
	movq -8(%rbp) , %r15 
	call Student.update_grade 
L99:
	 
	addq $8 , %rsp 
L100:
	 
	movq %r8 , -56(%rbp) 
L101:
	 
L102:
	 
	movq $17 , %r11 
	pushq %r11 
L103:
	 
	movq -24(%rbp) , %r15 
	call Student.update_age 
L104:
	 
	addq $8 , %rsp 
L105:
	 
	movq %r8 , -64(%rbp) 
L106:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string13(%rip) , %rsi 
	mov $32 , %rdx 
	syscall 
.section .data 
string13: .string "Updated Student Information...\n" 
.section .text 
L107:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string14(%rip) , %rsi 
	mov $12 , %rdx 
	syscall 
.section .data 
string14: .string "Student 1:\n" 
.section .text 
L108:
	 
L109:
	 
	movq -8(%rbp) , %r15 
	call Student.display_info 
L110:
	 
	addq $0 , %rsp 
L111:
	 
	movq %r8 , -72(%rbp) 
L112:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string15(%rip) , %rsi 
	mov $12 , %rdx 
	syscall 
.section .data 
string15: .string "Student 2:\n" 
.section .text 
L113:
	 
L114:
	 
	movq -24(%rbp) , %r15 
	call Student.display_info 
L115:
	 
	addq $0 , %rsp 
L116:
	 
	movq %r8 , -80(%rbp) 
L117:
	 
L118:
	 
	movq %rbp , %r13 
	subq $88 , %r13 
	movq $2024 , %r12 
	movq %r12 , 0(%r13) 
L119:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string16(%rip) , %rsi 
	mov $25 , %rdx 
	syscall 
.section .data 
string16: .string "Calculating Birth Year:\n" 
.section .text 
L120:
	 
L121:
	 
	movq -88(%rbp) , %r11 
	pushq %r11 
L122:
	 
	movq -8(%rbp) , %r15 
	call Student.calculate_birth_year 
L123:
	 
	addq $8 , %rsp 
L124:
	 
	movq %r8 , -96(%rbp) 
L125:
	 
L126:
	 
	movq %rbp , %r13 
	subq $104 , %r13 
	movq -96(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L127:
	 
L128:
	 
	movq -88(%rbp) , %r11 
	pushq %r11 
L129:
	 
	movq -24(%rbp) , %r15 
	call Student.calculate_birth_year 
L130:
	 
	addq $8 , %rsp 
L131:
	 
	movq %r8 , -112(%rbp) 
L132:
	 
L133:
	 
	movq %rbp , %r13 
	subq $120 , %r13 
	movq -112(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L134:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string17(%rip) , %rsi 
	mov $30 , %rdx 
	syscall 
.section .data 
string17: .string "Birth Year for student 1 is : " 
.section .text 
L135:
	 
	movq -104(%rbp) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L136:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string18(%rip) , %rsi 
	mov $30 , %rdx 
	syscall 
.section .data 
string18: .string "Birth Year for student 2 is : " 
.section .text 
L137:
	 
	movq -120(%rbp) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L138:
	 
L139:
	 
L140:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $120 , %rsp 
	popq %rbp 
	ret 
L141:
	 
L142:
	 
L143:
	 
L144:
	 
	addq $0 , %rsp 
L145:
	 
L146:
	 
		mov $60 , %rax 
		movq $0 , %rdi 
		syscall 
format:
	.ascii "%ld\n" 
