.section .rodata 
.note0: 
	.string "%ld\n" 
	.text 
	.globl main 
L1:
	 
Animal.__init__: 
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
	 
	movq %r15 , %r13 
	addq $0 , %r13 
	movq 16(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L9:
	 
L10:
	 
	movq %r15 , %r13 
	addq $8 , %r13 
	movq 24(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L11:
	 
L12:
	 
L13:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L14:
	 
L15:
	 
Animal.make_sound: 
L16:
	 
L17:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L18:
	 
L19:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string1(%rip) , %rsi 
	mov $22 , %rdx 
	syscall 
.section .data 
string1: .string "Generic animal sound\n" 
.section .text 
L20:
	 
L21:
	 
L22:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L23:
	 
L24:
	 
Animal.describe: 
L25:
	 
L26:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L27:
	 
L28:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string2(%rip) , %rsi 
	mov $5 , %rdx 
	syscall 
.section .data 
string2: .string "Name:" 
.section .text 
L29:
	 
	movq 0(%r15) , %r12 
	movq %r12 , %rdi 
	call puts 
L30:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string3(%rip) , %rsi 
	mov $4 , %rdx 
	syscall 
.section .data 
string3: .string "Age:" 
.section .text 
L31:
	 
	movq 8(%r15) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L32:
	 
L33:
	 
L34:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L35:
	 
L36:
	 
Dog.__init__: 
L37:
	 
L38:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $8 , %rsp 
L39:
	 
L40:
	 
L41:
	 
L42:
	 
L43:
	 
L44:
	 
	movq 24(%rbp) , %r11 
	pushq %r11 
L45:
	 
	movq 16(%rbp) , %r11 
	pushq %r11 
L46:
	 
	call Animal.__init__ 
L47:
	 
	addq $16 , %rsp 
L48:
	 
L49:
	 
	movq %r15 , %r13 
	addq $16 , %r13 
	movq 32(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L50:
	 
L51:
	 
L52:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $8 , %rsp 
	popq %rbp 
	ret 
L53:
	 
L54:
	 
Dog.make_sound: 
L55:
	 
L56:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L57:
	 
L58:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string4(%rip) , %rsi 
	mov $7 , %rdx 
	syscall 
.section .data 
string4: .string "Woof!\n" 
.section .text 
L59:
	 
L60:
	 
L61:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L62:
	 
L63:
	 
Dog.describe: 
L64:
	 
L65:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L66:
	 
L67:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string5(%rip) , %rsi 
	mov $5 , %rdx 
	syscall 
.section .data 
string5: .string "Name:" 
.section .text 
L68:
	 
	movq 0(%r15) , %r12 
	movq %r12 , %rdi 
	call puts 
L69:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string6(%rip) , %rsi 
	mov $4 , %rdx 
	syscall 
.section .data 
string6: .string "Age:" 
.section .text 
L70:
	 
	movq 8(%r15) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L71:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string7(%rip) , %rsi 
	mov $6 , %rdx 
	syscall 
.section .data 
string7: .string "Breed:" 
.section .text 
L72:
	 
	movq 16(%r15) , %r12 
	movq %r12 , %rdi 
	call puts 
L73:
	 
L74:
	 
L75:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L76:
	 
L77:
	 
Cat.__init__: 
L78:
	 
L79:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $8 , %rsp 
L80:
	 
L81:
	 
L82:
	 
L83:
	 
L84:
	 
L85:
	 
	movq 24(%rbp) , %r11 
	pushq %r11 
L86:
	 
	movq 16(%rbp) , %r11 
	pushq %r11 
L87:
	 
	call Animal.__init__ 
L88:
	 
	addq $16 , %rsp 
L89:
	 
L90:
	 
	movq %r15 , %r13 
	addq $16 , %r13 
	movq 32(%rbp) , %r12 
	movq %r12 , 0(%r13) 
L91:
	 
L92:
	 
L93:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $8 , %rsp 
	popq %rbp 
	ret 
L94:
	 
L95:
	 
Cat.make_sound: 
L96:
	 
L97:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L98:
	 
L99:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string8(%rip) , %rsi 
	mov $7 , %rdx 
	syscall 
.section .data 
string8: .string "Meow!\n" 
.section .text 
L100:
	 
L101:
	 
L102:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L103:
	 
L104:
	 
Cat.describe: 
L105:
	 
L106:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L107:
	 
L108:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string9(%rip) , %rsi 
	mov $5 , %rdx 
	syscall 
.section .data 
string9: .string "Name:" 
.section .text 
L109:
	 
	movq 0(%r15) , %r12 
	movq %r12 , %rdi 
	call puts 
L110:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string10(%rip) , %rsi 
	mov $4 , %rdx 
	syscall 
.section .data 
string10: .string "Age:" 
.section .text 
L111:
	 
	movq 8(%r15) , %r12 
	movq %r12 , %rsi 
	lea .note0(%rip) , %rax 
	movq %rax , %rdi 
	xor %rax , %rax 
	call printf@plt 
L112:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string11(%rip) , %rsi 
	mov $6 , %rdx 
	syscall 
.section .data 
string11: .string "Color:" 
.section .text 
L113:
	 
	movq 16(%r15) , %r12 
	movq %r12 , %rdi 
	call puts 
L114:
	 
L115:
	 
L116:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L117:
	 
L118:
	 
Kitten.__init__: 
L119:
	 
L120:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $8 , %rsp 
L121:
	 
L122:
	 
L123:
	 
L124:
	 
L125:
	 
L126:
	 
	movq 32(%rbp) , %r11 
	pushq %r11 
L127:
	 
	movq 24(%rbp) , %r11 
	pushq %r11 
L128:
	 
	movq 16(%rbp) , %r11 
	pushq %r11 
L129:
	 
	call Cat.__init__ 
L130:
	 
	addq $24 , %rsp 
L131:
	 
L132:
	 
L133:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $8 , %rsp 
	popq %rbp 
	ret 
L134:
	 
L135:
	 
Kitten.make_sound: 
L136:
	 
L137:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L138:
	 
L139:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string12(%rip) , %rsi 
	mov $16 , %rdx 
	syscall 
.section .data 
string12: .string "Kitten sounds!\n" 
.section .text 
L140:
	 
L141:
	 
L142:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L143:
	 
L144:
	 
Puppy.__init__: 
L145:
	 
L146:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $8 , %rsp 
L147:
	 
L148:
	 
L149:
	 
L150:
	 
L151:
	 
L152:
	 
	movq 32(%rbp) , %r11 
	pushq %r11 
L153:
	 
	movq 24(%rbp) , %r11 
	pushq %r11 
L154:
	 
	movq 16(%rbp) , %r11 
	pushq %r11 
L155:
	 
	call Dog.__init__ 
L156:
	 
	addq $24 , %rsp 
L157:
	 
L158:
	 
L159:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $8 , %rsp 
	popq %rbp 
	ret 
L160:
	 
L161:
	 
Puppy.make_sound: 
L162:
	 
L163:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $0 , %rsp 
L164:
	 
L165:
	 
	mov $1 , %rax 
	mov $1 , %rdi 
	lea string13(%rip) , %rsi 
	mov $15 , %rdx 
	syscall 
.section .data 
string13: .string "Puppy sounds!\n" 
.section .text 
L166:
	 
L167:
	 
L168:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $0 , %rsp 
	popq %rbp 
	ret 
L169:
	 
L170:
	 
main: 
L171:
	 
L172:
	 
	pushq %rbp 
	movq %rsp , %rbp 
	subq $128 , %rsp 
L173:
	 
L174:
	 
	movq $24 , %rdi 
	call malloc 
	movq %rax , -8(%rbp) 
L175:
	 
L176:
	 
	lea string14(%rip) , %r11 
	pushq %r11 
.section .data 
string14: .string "Labrador" 
.section .text 
L177:
	 
	movq $3 , %r11 
	pushq %r11 
L178:
	 
	lea string15(%rip) , %r11 
	pushq %r11 
.section .data 
string15: .string "Buddy" 
.section .text 
L179:
	 
	movq -8(%rbp) , %r15 
	call Dog.__init__ 
L180:
	 
	addq $24 , %rsp 
L181:
	 
	movq $24 , %rdi 
	call malloc 
	movq %rax , -24(%rbp) 
L182:
	 
L183:
	 
	lea string16(%rip) , %r11 
	pushq %r11 
.section .data 
string16: .string "Calico" 
.section .text 
L184:
	 
	movq $2 , %r11 
	pushq %r11 
L185:
	 
	lea string17(%rip) , %r11 
	pushq %r11 
.section .data 
string17: .string "Whiskers" 
.section .text 
L186:
	 
	movq -24(%rbp) , %r15 
	call Cat.__init__ 
L187:
	 
	addq $24 , %rsp 
L188:
	 
	movq $24 , %rdi 
	call malloc 
	movq %rax , -40(%rbp) 
L189:
	 
L190:
	 
	lea string18(%rip) , %r11 
	pushq %r11 
.section .data 
string18: .string "Golden Retriever" 
.section .text 
L191:
	 
	movq $1 , %r11 
	pushq %r11 
L192:
	 
	lea string19(%rip) , %r11 
	pushq %r11 
.section .data 
string19: .string "Max" 
.section .text 
L193:
	 
	movq -40(%rbp) , %r15 
	call Puppy.__init__ 
L194:
	 
	addq $24 , %rsp 
L195:
	 
	movq $24 , %rdi 
	call malloc 
	movq %rax , -56(%rbp) 
L196:
	 
L197:
	 
	lea string20(%rip) , %r11 
	pushq %r11 
.section .data 
string20: .string "White" 
.section .text 
L198:
	 
	movq $1 , %r11 
	pushq %r11 
L199:
	 
	lea string21(%rip) , %r11 
	pushq %r11 
.section .data 
string21: .string "Fluffy" 
.section .text 
L200:
	 
	movq -56(%rbp) , %r15 
	call Kitten.__init__ 
L201:
	 
	addq $24 , %rsp 
L202:
	 
L203:
	 
	movq -8(%rbp) , %r15 
	call Dog.make_sound 
L204:
	 
	addq $0 , %rsp 
L205:
	 
	movq %r8 , -72(%rbp) 
L206:
	 
L207:
	 
	movq -8(%rbp) , %r15 
	call Dog.describe 
L208:
	 
	addq $0 , %rsp 
L209:
	 
	movq %r8 , -80(%rbp) 
L210:
	 
L211:
	 
	movq -24(%rbp) , %r15 
	call Cat.make_sound 
L212:
	 
	addq $0 , %rsp 
L213:
	 
	movq %r8 , -88(%rbp) 
L214:
	 
L215:
	 
	movq -24(%rbp) , %r15 
	call Cat.describe 
L216:
	 
	addq $0 , %rsp 
L217:
	 
	movq %r8 , -96(%rbp) 
L218:
	 
L219:
	 
	movq -56(%rbp) , %r15 
	call Kitten.make_sound 
L220:
	 
	addq $0 , %rsp 
L221:
	 
	movq %r8 , -104(%rbp) 
L222:
	 
L223:
	 
	movq -56(%rbp) , %r15 
	call Cat.describe 
L224:
	 
	addq $0 , %rsp 
L225:
	 
	movq %r8 , -112(%rbp) 
L226:
	 
L227:
	 
	movq -40(%rbp) , %r15 
	call Puppy.make_sound 
L228:
	 
	addq $0 , %rsp 
L229:
	 
	movq %r8 , -120(%rbp) 
L230:
	 
L231:
	 
	movq -40(%rbp) , %r15 
	call Dog.describe 
L232:
	 
	addq $0 , %rsp 
L233:
	 
	movq %r8 , -128(%rbp) 
L234:
	 
L235:
	 
L236:
	 
	movq $0 , %r12 
	movq %r12 , %r8 
	addq $128 , %rsp 
	popq %rbp 
	ret 
L237:
	 
L238:
	 
L239:
	 
L240:
	 
	addq $0 , %rsp 
L241:
	 
L242:
	 
		mov $60 , %rax 
		movq $0 , %rdi 
		syscall 
format:
	.ascii "%ld\n" 
