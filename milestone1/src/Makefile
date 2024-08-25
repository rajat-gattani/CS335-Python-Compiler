myASTGenerator: parser.tab.c lex.yy.c 
	g++ parser.tab.c lex.yy.c -o myASTGenerator -lfl
parser.tab.c: parser.y
	bison -t -d -v parser.y
lex.yy.c: lexer.l parser.tab.h
	flex -i lexer.l