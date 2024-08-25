%option yylineno
%option noyywrap

%{
    #include <bits/stdc++.h>
    using namespace std;
    #include "parser.tab.h"

    stack<int> indent_stack;
    int newline_return=0;
    int dedent_count = 0;
    int line_joining_counter = 0;
    extern char* addlabel(string c);
    extern void print_ast();
    
%}

ASYNC       "async"
NEWLINE      \n|\r\n 
WS          [ \t\f\r]
COMMENT     #[^\n\r\n]*
PLUS        "+"
MINUS       "-"
MULTIPLY    "*"
DIVIDE      "/"
REMAINDER   "%"
ATTHERATE   "@"
NEGATION    "~"
BIT_AND     "&"
BIT_XOR     "^"
BIT_OR      "|"
DOT         "."
LESS_THAN       "<"
GREATER_THAN    ">"
EQUAL_EQUAL     "=="
GREATER_THAN_EQUAL  ">="
LESS_THAN_EQUAL     "<="
NOT_EQUAL       "!="
NOT_EQUAL_ARROW     "<>"
IN                "in"
NOT             "not"
IS             "is"

ASSIGN_OPERATOR   "+="|"-="|"*="|"/="|"%="|"**="|"&="|"|="|"^="|"<<="|">>="|"//="

POWER_OPERATOR    "**"
SHIFT_OPER        "<<"|">>"
FLOOR_DIV_OPER    "//"
ARROW_OPER        "->"
COMMA             ","
COLON             ":"
SEMI_COLON        ";"
OPEN_BRACKET      "("
CLOSE_BRACKET     ")"
CURLY_OPEN        "{"
CURLY_CLOSE       "}"
SQUARE_OPEN       "["
SQUARE_CLOSE      "]"
EQUAL             "="

PRIMITVE_TYPE     "int"|"float"|"str"|"bool"|"complex"|"bytes"|"bytearray"|"NoneType"|"None"
TYPE_HINT          {PRIMITVE_TYPE}|List\[{PRIMITVE_TYPE}\]

IF                "if"
ELSE              "else"
ELIF              "elif"
WHILE             "while"
FOR               "for"
AND               "and"
OR                "or"
BREAK             "break"
CONTINUE          "continue"
RETURN            "return"
CLASS             "class"
DEF               "def"
GLOBAL            "global"
NONLOCAL          "nonlocal"
ASSERT            "assert"

stringprefix       "r"|"u"|"R"|"U"|"f"|"F"|"fr"|"Fr"|"fR"|"FR"|"rf"|"rF"|"Rf"|"RF"
shortstringcharsingle    [^\\\n\']
shortstringchardouble    [^\\\n\"]
longstringcharsingle     [^\\\']
longstringchardouble     [^\\\"]
stringescapeseq          \\.
shortstringitemsingle    {shortstringcharsingle}|{stringescapeseq}
shortstringitemdouble    {shortstringchardouble}|{stringescapeseq}
longstringitemsingle     {longstringcharsingle}|{stringescapeseq}
longstringitemdouble     {longstringchardouble}|{stringescapeseq}
shortstringsingle        \'{shortstringitemsingle}*\'
shortstringdouble        \"{shortstringitemdouble}*\"
longstringsingle         \'\'\'{longstringitemsingle}*\'\'\'
longstringdouble         \"\"\"{longstringitemdouble}*\"\"\"
stringliteral      {stringprefix}?({shortstringsingle}|{shortstringdouble}|{longstringsingle}|{longstringdouble})

bytesprefix         "b"|"B"|"br"|"Br"|"bR"|"BR"|"rb"|"rB"|"Rb"|"RB"
shortbytescharsingle       [^\\\n\']
shortbyteschardouble       [^\\\n\"]
longbytescharsingle       [^\\\']
longbyteschardouble       [^\\\"]
bytesescapeseq      \\.
shortbytesitemsingle      {shortbytescharsingle}|{bytesescapeseq}
shortbytesitemdouble      {shortbyteschardouble}|{bytesescapeseq}
longbytesitemsingle       {longbytescharsingle}|{bytesescapeseq}
longbytesitemdouble       {longbyteschardouble}|{bytesescapeseq}
shortbytessingle          \'{shortbytesitemsingle}*\'
shortbytesdouble          \"{shortbytesitemdouble}*\"
longbytessingle           \'\'\'{longbytesitemsingle}*\'\'\'
longbytesdouble           \"\"\"{longbytesitemdouble}*\"\"\"
bytesliteral        {bytesprefix}?({shortbytessingle}|{shortbytesdouble}|{longbytessingle}|{longbytesdouble})

STRING             {stringliteral}|{bytesliteral}

NZ_DIG      [1-9]
DIG         [0-9]
BIN_DIG     [0-1]
OCT_DIG     [0-7]
DEC_INT     {NZ_DIG}("_"?{DIG})*|"0"+("_"?"0")*
BIN_INT     "0"("b"|"B")("_"?{BIN_DIG})+
OCT_INT     "0"("o"|"O")("_"?{OCT_DIG})+
HEX_INT     "0"("x"|"X")("_"?{HEX_DIG})+
HEX_DIG     {DIG}|[A-F]|[a-f]
INT         {DEC_INT}|{BIN_INT}|{OCT_INT}|{HEX_INT}
DIGIT_PART  {DIG}("_"?{DIG})*
FRACTION    \.{DIGIT_PART}
EXPONENT    ("E"|"e")[+-]?{DIGIT_PART}
POINT_FLOAT {DIGIT_PART}{0,1}{FRACTION}|{DIGIT_PART}\.
EXPONENT_FLOAT  ({DIGIT_PART}|{POINT_FLOAT}){EXPONENT}
FLOAT_NUM   {POINT_FLOAT}|{EXPONENT_FLOAT}
IMAG_NUM    ({FLOAT_NUM}|{DIGIT_PART})("J"|"j")
NUMBER     {INT}|{FLOAT_NUM}|{IMAG_NUM}

ID_START    [A-Za-z_]
ID_CONTINUE     [A-Za-z_0-9]
NAME      {ID_START}{ID_CONTINUE}*

%x INDENT_STATE
%x DEDENT_STATE
%x IMPLICIT_LINE_JOINING


%%

<INITIAL,IMPLICIT_LINE_JOINING>{ASYNC}             {return ASYNC;}
<INITIAL>^[ ]*   {
            int indent = 0;
            for (int i = 0; i < strlen(yytext); i++) {
                if (yytext[i] == ' ') {
                    indent++;
                }
            }
            if(indent%2==1){
                fprintf(stderr, "IndentationError: unindent does not match any outer indentation level\n");
                print_ast();
                exit(1);
            }
            else{
                indent = indent/2;
                if (indent > indent_stack.top()) {
                    indent_stack.push(indent);
                    return INDENT;
                } else if (indent < indent_stack.top()) {
                    while (indent < indent_stack.top()) {
                        indent_stack.pop();
                        if (indent_stack.empty()) {
                            fprintf(stderr, "IndentationError: unexpected indent\n");
                            print_ast();
                            exit(1);
                        }
                        dedent_count++;
                    }
                    if (indent != indent_stack.top()) {
                        fprintf(stderr, "IndentationError: unindent does not match any outer indentation level\n");
                        print_ast();
                        exit(1);
                    }
                    unput('\n');
                    BEGIN(INDENT_STATE);
                }
            }
        }

<INDENT_STATE>[\n]  { 
                    if(dedent_count>0){
                        dedent_count--;
                        unput('\n');
                        return DEDENT;
                    }
                    else{
                        BEGIN(INITIAL);
                    }
                }

<INITIAL,IMPLICIT_LINE_JOINING>{COMMENT}         {/* ignore */ }
<INITIAL,IMPLICIT_LINE_JOINING>{LESS_THAN}       {return LESS_THAN; }
<INITIAL,IMPLICIT_LINE_JOINING>{GREATER_THAN}    {return GREATER_THAN; }
<INITIAL,IMPLICIT_LINE_JOINING>{EQUAL_EQUAL}     {return EQUAL_EQUAL; }
<INITIAL,IMPLICIT_LINE_JOINING>{GREATER_THAN_EQUAL}  {return GREATER_THAN_EQUAL; }
<INITIAL,IMPLICIT_LINE_JOINING>{LESS_THAN_EQUAL}     {return LESS_THAN_EQUAL; }
<INITIAL,IMPLICIT_LINE_JOINING>{NOT_EQUAL}       {return NOT_EQUAL; }
<INITIAL,IMPLICIT_LINE_JOINING>{NOT_EQUAL_ARROW}  {return NOT_EQUAL_ARROW; }
<INITIAL,IMPLICIT_LINE_JOINING>{IS}              {return IS; }
<INITIAL,IMPLICIT_LINE_JOINING>{IN}    { return IN;}
<INITIAL,IMPLICIT_LINE_JOINING>{NOT}  { return NOT;}
<INITIAL,IMPLICIT_LINE_JOINING>{ASSIGN_OPERATOR}   { yylval.val=strdup(yytext);return ASSIGN_OPERATOR;}
<INITIAL,IMPLICIT_LINE_JOINING>{POWER_OPERATOR}    {return POWER_OPERATOR; }
<INITIAL,IMPLICIT_LINE_JOINING>{SHIFT_OPER}       { yylval.val=strdup(yytext);return SHIFT_OPER; }
<INITIAL,IMPLICIT_LINE_JOINING>{FLOOR_DIV_OPER}    { return FLOOR_DIV_OPER; }
<INITIAL,IMPLICIT_LINE_JOINING>{ARROW_OPER}        { return ARROW_OPER;}
<INITIAL,IMPLICIT_LINE_JOINING>{PLUS}            { return PLUS;}
<INITIAL,IMPLICIT_LINE_JOINING>{MINUS}           {return MINUS;}
<INITIAL,IMPLICIT_LINE_JOINING>{MULTIPLY}        {return MULTIPLY;}
<INITIAL,IMPLICIT_LINE_JOINING>{DIVIDE}          {return DIVIDE;}
<INITIAL,IMPLICIT_LINE_JOINING>{REMAINDER}       {return REMAINDER;}
<INITIAL,IMPLICIT_LINE_JOINING>{ATTHERATE}       {return ATTHERATE;}
<INITIAL,IMPLICIT_LINE_JOINING>{NEGATION}        {return NEGATION;}
<INITIAL,IMPLICIT_LINE_JOINING>{BIT_AND}         {return BIT_AND;}
<INITIAL,IMPLICIT_LINE_JOINING>{BIT_XOR}         {return BIT_XOR;}
<INITIAL,IMPLICIT_LINE_JOINING>{BIT_OR}          {return BIT_OR;}
<INITIAL,IMPLICIT_LINE_JOINING>{DOT}             {return DOT;}
<INITIAL,IMPLICIT_LINE_JOINING>{COMMA}            {return COMMA;}
<INITIAL,IMPLICIT_LINE_JOINING>{COLON}            {return COLON;}
<INITIAL,IMPLICIT_LINE_JOINING>{SEMI_COLON}           {return SEMI_COLON;}
<INITIAL,IMPLICIT_LINE_JOINING>{OPEN_BRACKET}         {line_joining_counter++; BEGIN(IMPLICIT_LINE_JOINING);return OPEN_BRACKET;}
<INITIAL,IMPLICIT_LINE_JOINING>{CLOSE_BRACKET}          {line_joining_counter--; if(line_joining_counter==0)BEGIN(INITIAL); return CLOSE_BRACKET;}
<INITIAL,IMPLICIT_LINE_JOINING>{EQUAL}                  {return EQUAL;}
<INITIAL,IMPLICIT_LINE_JOINING>{CURLY_OPEN}             {line_joining_counter++; BEGIN(IMPLICIT_LINE_JOINING); return CURLY_OPEN;}
<INITIAL,IMPLICIT_LINE_JOINING>{CURLY_CLOSE}           {line_joining_counter--; if(line_joining_counter==0)BEGIN(INITIAL);return CURLY_CLOSE;}
<INITIAL,IMPLICIT_LINE_JOINING>{SQUARE_OPEN}           {line_joining_counter++; BEGIN(IMPLICIT_LINE_JOINING);return SQUARE_OPEN;}
<INITIAL,IMPLICIT_LINE_JOINING>{SQUARE_CLOSE}         {line_joining_counter--; if(line_joining_counter==0)BEGIN(INITIAL);return SQUARE_CLOSE;}
<INITIAL,IMPLICIT_LINE_JOINING>{STRING} {yylval.val=strdup(yytext); return STRING;}
<INITIAL,IMPLICIT_LINE_JOINING>{TYPE_HINT}         { yylval.val=strdup(yytext); return TYPE_HINT; }
<INITIAL>\\[\n\t\ ]+  { /* ignore */ } 

<INITIAL,IMPLICIT_LINE_JOINING>{IF}        { return IF;}
<INITIAL,IMPLICIT_LINE_JOINING>{ELSE}    { return ELSE;}
<INITIAL,IMPLICIT_LINE_JOINING>{ELIF}  { return ELIF;}
<INITIAL,IMPLICIT_LINE_JOINING>{WHILE}  { return WHILE;}
<INITIAL,IMPLICIT_LINE_JOINING>{FOR}    { return FOR;}
<INITIAL,IMPLICIT_LINE_JOINING>{AND}  { return AND;}
<INITIAL,IMPLICIT_LINE_JOINING>{OR}    { return OR;}
<INITIAL,IMPLICIT_LINE_JOINING>{BREAK}  { return BREAK;}
<INITIAL,IMPLICIT_LINE_JOINING>{CONTINUE}  { return CONTINUE;}
<INITIAL,IMPLICIT_LINE_JOINING>{RETURN}  { return RETURN;}
<INITIAL,IMPLICIT_LINE_JOINING>{CLASS}  { return CLASS;}
<INITIAL,IMPLICIT_LINE_JOINING>{DEF}    { return DEF;}
<INITIAL,IMPLICIT_LINE_JOINING>{GLOBAL}  { return GLOBAL;}
<INITIAL,IMPLICIT_LINE_JOINING>{NONLOCAL}  { return NONLOCAL;}
<INITIAL,IMPLICIT_LINE_JOINING>{ASSERT}  { return ASSERT;}
<INITIAL,IMPLICIT_LINE_JOINING>"..."|"True"|"False"|"None"  {yylval.val=strdup(yytext); return ATOM_KEYWORDS;}
<INITIAL,IMPLICIT_LINE_JOINING>{NUMBER}    { yylval.val=strdup(yytext); return NUMBER;}
<INITIAL,IMPLICIT_LINE_JOINING>{NAME}              {yylval.val=strdup(yytext); return NAME;}
<INITIAL>{NEWLINE}[ ]*/{NEWLINE}   {}
<INITIAL>{NEWLINE}[ ]*{COMMENT}/{NEWLINE}   { }
<INITIAL>{NEWLINE}/" "   {return NEWLINE;}
<INITIAL>{NEWLINE}   {   
                if(indent_stack.top()==0){
                    return NEWLINE;
                }
                else{
                    while (indent_stack.top()>0) {
                        newline_return=1;
                        indent_stack.pop();
                        if (indent_stack.empty()) {
                            fprintf(stderr, "IndentationError: unexpected indent\n");
                            print_ast();
                            exit(1);
                        }
                        dedent_count++;
                    }
                    unput('\n');
                    BEGIN(DEDENT_STATE);
                }
            }

<DEDENT_STATE>[\n]  { 
                    if(newline_return==1){
                        newline_return=0;
                        unput('\n');
                        return NEWLINE;
                    }
                    else if(dedent_count>0){
                        dedent_count--;
                        unput('\n');
                        return DEDENT;
                    }
                    else{
                        BEGIN(INITIAL);
                    }
                }

<IMPLICIT_LINE_JOINING,INITIAL>{WS} {}

<INITIAL,IMPLICIT_LINE_JOINING>. { 
                                    fprintf(stderr, "Invalid character %s at line number: %d\n", yytext, yylineno);
                                    print_ast(); 
                                    exit(1); 
                                }


%%
