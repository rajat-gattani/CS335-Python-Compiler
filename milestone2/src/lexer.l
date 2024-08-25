%option yylineno
%option noyywrap

%{
    #include <bits/stdc++.h>
    // #include "data.h"
    // #include "data.cpp"
    // #include "symbol_table.h"
    #include "data.cpp"
    using namespace std;
    #include "parser.tab.h"

    stack<int> indent_stack;
    int newline_return=0;
    int dedent_count = 0;
    int line_joining_counter = 0;

    void noding(char* yytext,string type=""){
        yylval.elem = create_node(1, strdup(yytext));
        yylval.elem->lineno = yylineno;
        if(type=="bool"){
            yylval.elem->type = strdup("bool");
            yylval.elem->atom_type = strdup("bool");
        }
        else if(type=="NUMBER"){
            for(int i=0;i<strlen(yytext);i++){
                if(yytext[i]=='.'){
                    yylval.elem->type = strdup("float");
                    yylval.elem->atom_type = strdup("float");
                    return;     
                }
            }
            yylval.elem->type = strdup("int");
            yylval.elem->atom_type = "int";
        }
    }
    
%}

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
D_NAME            "__name__"
D_MAIN            "__main__"

PRIMITVE_TYPE     "int"|"float"|"str"|"bool"
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
NONE              "None"
LEN               "len"
PRINT             "print"
SELF              "self"

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

<INITIAL>^[ ]*   {
            int indent = 0;
            for (int i = 0; i < strlen(yytext); i++) {
                if (yytext[i] == ' ') {
                    indent++;
                }
            }
            if(indent%2==1){
                fprintf(stderr, "IndentationError: unindent does not match any outer indentation level\n");
                // print_ast();
                exit(1);
            }
            else{
                indent = indent/2;
                if (indent > indent_stack.top()) {
                    indent_stack.push(indent);
                    noding(yytext); return INDENT;
                } else if (indent < indent_stack.top()) {
                    while (indent < indent_stack.top()) {
                        indent_stack.pop();
                        if (indent_stack.empty()) {
                            fprintf(stderr, "IndentationError: unexpected indent\n");
                            // print_ast();
                            exit(1);
                        }
                        dedent_count++;
                    }
                    if (indent != indent_stack.top()) {
                        fprintf(stderr, "IndentationError: unindent does not match any outer indentation level\n");
                        // print_ast();
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
                        noding(yytext); return DEDENT;
                    }
                    else{
                        BEGIN(INITIAL);
                    }
                }

<INITIAL,IMPLICIT_LINE_JOINING>{COMMENT}         {/* ignore */ }
<INITIAL,IMPLICIT_LINE_JOINING>{LESS_THAN}       {noding(yytext);return LESS_THAN; }
<INITIAL,IMPLICIT_LINE_JOINING>{GREATER_THAN}    {noding(yytext); return GREATER_THAN; }
<INITIAL,IMPLICIT_LINE_JOINING>{EQUAL_EQUAL}     {noding(yytext); return EQUAL_EQUAL; }
<INITIAL,IMPLICIT_LINE_JOINING>{GREATER_THAN_EQUAL}  {noding(yytext); return GREATER_THAN_EQUAL; }
<INITIAL,IMPLICIT_LINE_JOINING>{LESS_THAN_EQUAL}     {noding(yytext); return LESS_THAN_EQUAL; }
<INITIAL,IMPLICIT_LINE_JOINING>{NOT_EQUAL}       {noding(yytext); return NOT_EQUAL; }
<INITIAL,IMPLICIT_LINE_JOINING>{NOT_EQUAL_ARROW}  {noding(yytext); return NOT_EQUAL_ARROW; }
<INITIAL,IMPLICIT_LINE_JOINING>{IS}              {noding(yytext); return IS; }
<INITIAL,IMPLICIT_LINE_JOINING>{IN}    { noding(yytext); return IN;}
<INITIAL,IMPLICIT_LINE_JOINING>{NOT}  { noding(yytext); return NOT;}
<INITIAL,IMPLICIT_LINE_JOINING>{ASSIGN_OPERATOR}   { noding(yytext); return ASSIGN_OPERATOR;}
<INITIAL,IMPLICIT_LINE_JOINING>{POWER_OPERATOR}    {noding(yytext); return POWER_OPERATOR; }
<INITIAL,IMPLICIT_LINE_JOINING>{SHIFT_OPER}       { noding(yytext); return SHIFT_OPER; }
<INITIAL,IMPLICIT_LINE_JOINING>{FLOOR_DIV_OPER}    { noding(yytext); return FLOOR_DIV_OPER; }
<INITIAL,IMPLICIT_LINE_JOINING>{ARROW_OPER}        { noding(yytext); return ARROW_OPER;}
<INITIAL,IMPLICIT_LINE_JOINING>{PLUS}            { noding(yytext); return PLUS;}
<INITIAL,IMPLICIT_LINE_JOINING>{MINUS}           {noding(yytext); return MINUS;}
<INITIAL,IMPLICIT_LINE_JOINING>{MULTIPLY}        {noding(yytext); return MULTIPLY;}
<INITIAL,IMPLICIT_LINE_JOINING>{DIVIDE}          {noding(yytext); return DIVIDE;}
<INITIAL,IMPLICIT_LINE_JOINING>{REMAINDER}       {noding(yytext); return REMAINDER;}
<INITIAL,IMPLICIT_LINE_JOINING>{ATTHERATE}       {noding(yytext); return ATTHERATE;}
<INITIAL,IMPLICIT_LINE_JOINING>{NEGATION}        {noding(yytext); return NEGATION;}
<INITIAL,IMPLICIT_LINE_JOINING>{BIT_AND}         {noding(yytext); return BIT_AND;}
<INITIAL,IMPLICIT_LINE_JOINING>{BIT_XOR}         {noding(yytext); return BIT_XOR;}
<INITIAL,IMPLICIT_LINE_JOINING>{BIT_OR}          {noding(yytext); return BIT_OR;}
<INITIAL,IMPLICIT_LINE_JOINING>{DOT}             {noding(yytext); return DOT;}
<INITIAL,IMPLICIT_LINE_JOINING>{COMMA}            {noding(yytext); return COMMA;}
<INITIAL,IMPLICIT_LINE_JOINING>{COLON}            {noding(yytext); return COLON;}
<INITIAL,IMPLICIT_LINE_JOINING>{SEMI_COLON}           {noding(yytext); return SEMI_COLON;}
<INITIAL,IMPLICIT_LINE_JOINING>{OPEN_BRACKET}         {line_joining_counter++; BEGIN(IMPLICIT_LINE_JOINING); noding(yytext); return OPEN_BRACKET;}
<INITIAL,IMPLICIT_LINE_JOINING>{CLOSE_BRACKET}          {line_joining_counter--; if(line_joining_counter==0)BEGIN(INITIAL); noding(yytext); return CLOSE_BRACKET;}
<INITIAL,IMPLICIT_LINE_JOINING>{EQUAL}                  {noding(yytext); return EQUAL;}
<INITIAL,IMPLICIT_LINE_JOINING>{CURLY_OPEN}             {line_joining_counter++; BEGIN(IMPLICIT_LINE_JOINING); noding(yytext); return CURLY_OPEN;}
<INITIAL,IMPLICIT_LINE_JOINING>{CURLY_CLOSE}           {line_joining_counter--; if(line_joining_counter==0)BEGIN(INITIAL); noding(yytext); return CURLY_CLOSE;}
<INITIAL,IMPLICIT_LINE_JOINING>{SQUARE_OPEN}           {line_joining_counter++; BEGIN(IMPLICIT_LINE_JOINING); noding(yytext); return SQUARE_OPEN;}
<INITIAL,IMPLICIT_LINE_JOINING>{SQUARE_CLOSE}         {line_joining_counter--; if(line_joining_counter==0)BEGIN(INITIAL); noding(yytext); return SQUARE_CLOSE;}
<INITIAL,IMPLICIT_LINE_JOINING>{STRING}             {noding(yytext);  return STRING;}
<INITIAL,IMPLICIT_LINE_JOINING>{TYPE_HINT}         {noding(yytext); return TYPE_HINT; }
<INITIAL>\\[\n\t\ ]+  { /* ignore */ } 

<INITIAL,IMPLICIT_LINE_JOINING>{IF}        { noding(yytext); return IF;}
<INITIAL,IMPLICIT_LINE_JOINING>{ELSE}    {noding(yytext);  return ELSE;}
<INITIAL,IMPLICIT_LINE_JOINING>{ELIF}  {noding(yytext);  return ELIF;}
<INITIAL,IMPLICIT_LINE_JOINING>{WHILE}  { noding(yytext); return WHILE;}
<INITIAL,IMPLICIT_LINE_JOINING>{FOR}    {noding(yytext);  return FOR;}
<INITIAL,IMPLICIT_LINE_JOINING>{AND}  {noding(yytext);  return AND;}
<INITIAL,IMPLICIT_LINE_JOINING>{OR}    {noding(yytext);  return OR;}
<INITIAL,IMPLICIT_LINE_JOINING>{BREAK}  { noding(yytext); return BREAK;}
<INITIAL,IMPLICIT_LINE_JOINING>{CONTINUE}  {noding(yytext);  return CONTINUE;}
<INITIAL,IMPLICIT_LINE_JOINING>{RETURN}  {noding(yytext);  return RETURN;}
<INITIAL,IMPLICIT_LINE_JOINING>{CLASS}  {noding(yytext);  return CLASS;}
<INITIAL,IMPLICIT_LINE_JOINING>{DEF}    {noding(yytext);  return DEF;}
<INITIAL,IMPLICIT_LINE_JOINING>{GLOBAL}  { noding(yytext); return GLOBAL;}
<INITIAL,IMPLICIT_LINE_JOINING>"..."|"True"|"False"  {noding(yytext,"bool");  return ATOM_KEYWORDS;}
<INITIAL,IMPLICIT_LINE_JOINING>{NONE}  {noding(yytext);  return NONE;}
<INITIAL,IMPLICIT_LINE_JOINING>{LEN}  {noding(yytext);  return LEN;}
<INITIAL,IMPLICIT_LINE_JOINING>{PRINT}  {noding(yytext);  return PRINT;}
<INITIAL,IMPLICIT_LINE_JOINING>{D_NAME}  {noding(yytext);  return D_NAME;}
<INITIAL,IMPLICIT_LINE_JOINING>{D_MAIN}  {noding(yytext);  return D_MAIN;}
<INITIAL,IMPLICIT_LINE_JOINING>{SELF}  {noding(yytext);  return SELF;}
<INITIAL,IMPLICIT_LINE_JOINING>{NUMBER}    { noding(yytext,"NUMBER");  return NUMBER;}
<INITIAL,IMPLICIT_LINE_JOINING>"range"      { noding(yytext); return RANGE;}
<INITIAL,IMPLICIT_LINE_JOINING>{NAME}      { noding(yytext); return NAME;}
<INITIAL>{NEWLINE}[ ]*/{NEWLINE}   {}
<INITIAL>{NEWLINE}[ ]*{COMMENT}/{NEWLINE}   { }
<INITIAL>{NEWLINE}/" "   {noding(yytext); return NEWLINE;}
<INITIAL>{NEWLINE}   {   
                if(indent_stack.top()==0){
                    noding(yytext); return NEWLINE;
                }
                else{
                    while (indent_stack.top()>0) {
                        newline_return=1;
                        indent_stack.pop();
                        if (indent_stack.empty()) {
                            fprintf(stderr, "IndentationError: unexpected indent\n");
                            // print_ast();
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
                        noding(yytext); return NEWLINE;
                    }
                    else if(dedent_count>0){
                        dedent_count--;
                        unput('\n');
                        noding(yytext); 
                        return DEDENT;
                    }
                    else{
                        BEGIN(INITIAL);
                    }
                }

<IMPLICIT_LINE_JOINING,INITIAL>{WS} {}

<INITIAL,IMPLICIT_LINE_JOINING>. { 
                                    fprintf(stderr, "Invalid character %s at line number: %d\n", yytext, yylineno);
                                    // print_ast(); 
                                    exit(1); 
                                }


%%
