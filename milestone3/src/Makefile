python_compiler: parser.tab.c lex.yy.c 
	g++ parser.tab.c lex.yy.c -o python_compiler -lfl
parser.tab.c: parser.y
	bison -t -d -v parser.y
lex.yy.c: lexer.l parser.tab.h
	flex -i lexer.l