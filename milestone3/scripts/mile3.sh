bison -d -t -v parser.y
flex -i lexer.l
g++ lex.yy.c parser.tab.c -o output -lfl

./output ../tests/mile3.py
