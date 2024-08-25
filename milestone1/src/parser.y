%{  
    /*definitions*/
    #include <bits/stdc++.h>
    using namespace std;

    extern int yylex();
    extern int yyparse();
    extern void yyrestart(FILE* file);
    extern FILE* yyin;
    extern int yylineno;
    extern char* yytext;

    char* numtochar( int num){
        string s="0";
        while(num>0){
            s.push_back(num%10+'0');
            num/=10;
        }
        reverse(s.begin(),s.end());
        int n=s.size();
        char* c= (char*)malloc(sizeof(char)*(n+1));
        for( int i=0;i<n;i++){  
            c[i]=s[i];
        }
        c[n]='\0';
        return c;
    }
    int chartonum(char * c){
        int i=0;
        int num=0;
        while(c[i]!='\0'){
            num*=10;
            num+=c[i]-'0';
            i++;
        }
        return num;
    } 
    string chartostring(char* c){
        string s;
        int i=0;
        while(c[i]!='\0'){
            s.push_back(c[i]);
            i++;
        }
        return s;
    }
    struct label{
        int num;
        string l;
        bool terminal;
    } ;
    struct edge{
        int a;
        int b;
        string l;
    };
    vector<int> remove_label;
    vector<label> labels;
    vector<edge> edges;
    extern char* addlabel(string c, bool term = false){  
        int n=labels.size()+1;
        label q;
        q.num=n*10;
        q.l=c;
        q.terminal=term;
        if(c=="TRAILER1" || c=="ATOM1"){
                remove_label.push_back(n*10);
        }
        labels.push_back(q);
        return numtochar(n);
    }
    extern void addedge(char* a, char* b, string l=""){ 
        edge q;
        q.a=chartonum(a);
        q.b=chartonum(b);
        q.l=l;
        edges.push_back(q);
        
    }
    extern stack<int> indent_stack;

    void yyerror(string str);

    void print_ast(){
        cout << "digraph ASTVisual {\n ordering = out ;\n";
        for(auto e: labels){
            string s;
            for( auto e1: e.l){
                if(e1=='\"' || e1=='\\'  ){
                    s.push_back('\\');
                }
                s.push_back(e1);
            } 
            if(s!="ATOM1" && s!="TRAILER1" && e.terminal == false) cout<<e.num<<" [ label=\""<<s<<"\"]\n";
            else if(s!="ATOM1" && s!="TRAILER1" && e.terminal==true) cout<<e.num<<" [ label=\""<<s<<"\", color = \"red\", shape=\"box\"]\n";
        }
        for(auto e: edges){
            string s;

            for( auto e1: e.l){
                if(e1=='\"' || e1=='\\'){
                    s.push_back('\\');
                }
                s.push_back(e1);
            } 
            if(find(remove_label.begin(),remove_label.end(),e.b)==remove_label.end()) cout<<e.a<< " -> "<<e.b << "[ label=\""<<s<<"\"]\n";
        }
        cout << "  }\n";
    }
    
%}

%union{
    char* val;
}
%start file
%type<val> file file_input snippet stmt simple_stmt small_stmt_list small_stmt expr_stmt annassign eq_testlist_star_expr_plus flow_stmt break_stmt continue_stmt return_stmt global_stmt nonlocal_stmt assert_stmt compound_stmt funcdef parameters typedargslist typedarg tfpdef if_stmt while_stmt for_stmt suite nts_star namedexpr_test test or_test and_test not_test comparison comp_op star_expr expr xor_expr and_expr shift_expr arith_expr term term_choice factor factor_choice power atom_expr atom STRING_PLUS testlist_comp named_or_star_list named_or_star trailer subscriptlist subscriptlist_list subscript exprlist expr_or_star_expr_list expr_or_star_expr dictorsetmaker A A_list B B_list classdef arglist argument_list argument testlist testlist_list testlist_star_expr expr_choice_list expr_choice augassign comma_name_star async_stmt async_choice and_test_star not_test_star comp_iter sync_comp_for comp_for comp_if func_body_suite stmt_plus comma_test
%token<val> NEWLINE
%token<val> ASYNC 
%token<val> INDENT 
%token<val> DEDENT
%token<val> ASSIGN_OPERATOR 
%token <val>POWER_OPERATOR
%token<val> SHIFT_OPER
%token<val> FLOOR_DIV_OPER 
%token<val> ARROW_OPER 
%token<val> TYPE_HINT
%token<val> NAME 
%token<val> IF 
%token<val> ELSE 
%token<val> ELIF 
%token<val> WHILE 
%token<val> FOR 
%token<val> IN 
%token<val> AND
%token<val> OR 
%token<val> NOT 
%token<val> BREAK 
%token<val> CONTINUE 
%token<val> RETURN 
%token<val> CLASS 
%token<val> DEF 
%token<val> GLOBAL 
%token<val> NONLOCAL 
%token<val> ASSERT 
%token<val> ATOM_KEYWORDS 
%token<val> STRING 
%token<val> NUMBER 
%token<val> OPEN_BRACKET
%token<val> CLOSE_BRACKET
%token<val> EQUAL
%token<val> SEMI_COLON
%token<val> COLON 
%token<val> COMMA 
%token<val> PLUS 
%token<val> MINUS
%token<val> MULTIPLY
%token<val> DIVIDE
%token<val> REMAINDER
%token<val> ATTHERATE
%token<val> NEGATION
%token<val> BIT_AND
%token<val> BIT_OR
%token<val> BIT_XOR
%token<val> DOT 
%token <val>CURLY_OPEN
%token <val>CURLY_CLOSE
%token<val> SQUARE_OPEN
%token<val> SQUARE_CLOSE
%token<val> LESS_THAN
%token<val> GREATER_THAN
%token<val> EQUAL_EQUAL
%token<val> GREATER_THAN_EQUAL
%token<val> LESS_THAN_EQUAL
%token<val> NOT_EQUAL_ARROW
%token<val> NOT_EQUAL
%token<val> IS
%%

file: file_input {$$=$1; }
        ;

file_input: snippet {$$=$1; }
         ;

snippet: NEWLINE 
    | stmt  { $$=$1; }
    | NEWLINE snippet  { $$=$2; }
    | stmt snippet { $$ = addlabel("SNIPPET"); addedge($$,$1); addedge($$,$2); }
    ; 

funcdef: DEF NAME parameters COLON func_body_suite  { $$ = addlabel("FUNCTION"); $2 = addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2); addedge($$,$3); addedge($$,$5); }
        | DEF NAME parameters ARROW_OPER TYPE_HINT COLON func_body_suite { $$ = addlabel("FUNCTION"); $2 = addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2); addedge($$,$3); $5 = addlabel(string("TYPE\n (")+chartostring($5) + string(")"),true); addedge($$,$5);  addedge($$,$7); }
        | DEF NAME OPEN_BRACKET CLOSE_BRACKET ARROW_OPER TYPE_HINT COLON func_body_suite { $$ = addlabel("FUNCTION"); $2 = addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2); $6 = addlabel(string("TYPE\n (")+chartostring($6) + string(")"),true); addedge($$,$6);  addedge($$,$8); }
        | DEF NAME OPEN_BRACKET CLOSE_BRACKET COLON func_body_suite { $$ = addlabel("FUNCTION"); $2 = addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2); addedge($$,$6); }
        ;

parameters: OPEN_BRACKET typedargslist CLOSE_BRACKET { $$ = $2; }
          ;

typedargslist:  typedarg    { $$=$1; }
    | typedargslist COMMA  typedarg  { $$ = addlabel("ARGUMENTS"); addedge($$,$1); addedge($$,$3); }
    ;

typedarg: tfpdef   { $$=$1; }
        | tfpdef EQUAL test  { $$ = addlabel(string("EQUAL\n")+"(=)"); addedge($$,$1); addedge($$,$3); }
        ;

tfpdef: NAME { $$ = addlabel(string("NAME\n (")+chartostring($1) + string(")"),true); }
        | NAME COLON TYPE_HINT  {  $$ = addlabel("PARAMETER"); $1 = addlabel(string("NAME\n (")+chartostring($1) + string(")"),true); addedge($$,$1); $3 = addlabel(string("TYPE\n (")+chartostring($3) + string(")"),true); addedge($$,$3); }
        ; 

stmt: simple_stmt       {$$=$1; }
    | compound_stmt  {$$=$1; }
    ;      

simple_stmt: small_stmt_list SEMI_COLON NEWLINE { $$ = $1; }
                | small_stmt_list  NEWLINE { $$=$1; }
            ; 

small_stmt_list: small_stmt     { $$=$1;  }
               | small_stmt_list SEMI_COLON small_stmt      { $$ = addlabel("SMALL_STMT_LIST"); addedge($$,$1); addedge($$,$3); }
               ;

small_stmt: expr_stmt       {$$=$1;  }
            | flow_stmt     { $$=$1; } 
            | global_stmt       { $$=$1; }
            | nonlocal_stmt     { $$=$1; }
            | assert_stmt       {$$=$1;  }
            ; 

expr_stmt:  testlist_star_expr annassign {  $$ = addlabel("EXPRESSION_STMT"); addedge($$,$1); addedge($$,$2); }
              | testlist_star_expr augassign testlist { $$ = $2; addedge($$,$1);  addedge($$,$3); }
              | eq_testlist_star_expr_plus {$$=$1; }
        ; 

eq_testlist_star_expr_plus: testlist_star_expr { $$=$1; }
                                | testlist_star_expr EQUAL eq_testlist_star_expr_plus     { $$ = addlabel(string("EQUAL\n")+"(=)"); addedge($$,$1); addedge($$,$3); }
        ;

annassign: COLON test   { $$=$2; }
            | COLON test EQUAL testlist_star_expr   { $$ = addlabel(string("EQUAL\n")+"(=)");  addedge($$,$2); addedge($$,$4); }
            ;

testlist_star_expr: expr_choice_list { $$=$1; }
                        | expr_choice_list COMMA  {  $$=$1; }
                    ;

expr_choice_list : expr_choice  { $$=$1; }
                    | expr_choice_list COMMA expr_choice    { $$ = addlabel("EXPR_CHOICE"); addedge($$,$1); addedge($$,$3); }
                    ;

expr_choice : test  { $$=$1; }
                |star_expr  { $$=$1; }
                ;

augassign: ASSIGN_OPERATOR  { $$ = addlabel(string("ASSIGN_OP\n (")+chartostring($1)+string(")")); }
            ;

flow_stmt: break_stmt   { $$=$1; }
            | continue_stmt     {$$=$1; }
            | return_stmt    { $$=$1; }
            ;   
break_stmt: BREAK   { $$ = addlabel(string("BREAK\n")+"(break)",true); }
            ;
continue_stmt: CONTINUE     { $$ = addlabel(string("CONTINUE\n")+"(continue)",true); }
                ;
return_stmt: RETURN     { $$ = addlabel(string("RETURN\n")+"(return)",true); }
            | RETURN testlist_star_expr     { $$ = addlabel("RETURN"); addedge($$,$2); }
            ;

global_stmt: GLOBAL NAME    { $$ = addlabel("GLOBAL_NAME"); $2 = addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2,"GLOBAL") ; }
            | GLOBAL NAME comma_name_star {  $$ = addlabel("GLOBAL_NAME"); $2 = addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2,"GLOBAL") ; addedge($$,$3); }
            ;
nonlocal_stmt: NONLOCAL NAME     { $$ = addlabel("NONLOCAL_NAME"); $2 = addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2,"NONLOCAL") ; }
            | NONLOCAL NAME comma_name_star { $$ = addlabel("NONLOCAL_NAME"); $2 = addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2,"NONLOCAL") ; addedge($$,$3); }
            ;    
        
assert_stmt: ASSERT test  { $$ = addlabel(string("ASSERT\n") + "(assert)"); addedge($$,$2); }
                | ASSERT test comma_test  { $$ = addlabel("ASSERT"); addedge($$,$2); addedge($$,$3);  }
            ;
comma_name_star: COMMA NAME    { $$ = addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); }
                | COMMA NAME comma_name_star    { $$ = addlabel("NAME_LIST"); $2 = addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2); addedge($$,$3); }
                ;
compound_stmt: if_stmt      { $$=$1; }
                | while_stmt    { $$=$1; }
                | for_stmt  { $$=$1; }
                | funcdef   { $$=$1; }
                | classdef  { $$=$1; }
                | async_stmt    {$$=$1; }
                ;
async_stmt: ASYNC async_choice  { $$ = addlabel("ASYNC"); addedge($$,$2); }
            ;
async_choice : funcdef  { $$=$1; }
            | for_stmt  { $$=$1;  }
            ;

if_stmt: IF namedexpr_test COLON suite     { $$ = addlabel("IF"); addedge($$,$2,"EXPRESSION"); addedge($$,$4,"SUITE"); }
            | IF namedexpr_test COLON suite ELSE COLON suite   { $$ = addlabel("IF_ELSE"); addedge($$,$2,"IF_EXPR"); addedge($$,$4,"IF_SUITE"); addedge($$,$7,"ELSE_SUITE"); }
            | IF namedexpr_test COLON suite nts_star    { $$ = addlabel("IF_ELIF"); addedge($$,$2,"EXPRESSION"); addedge($$,$4,"IF_SUITE"); addedge($$,$5,"ELIF"); }
            | IF namedexpr_test COLON suite nts_star ELSE COLON suite   {$$ = addlabel("IF_ELIF_ELSE"); addedge($$,$2,"IF_EXPR"); addedge($$,$4,"IF_SUITE"); addedge($$,$5,"ELIF"); addedge($$,$8,"ELSE_SUITE");}
        ;
while_stmt: WHILE namedexpr_test COLON suite   { $$ = addlabel("WHILE"); addedge($$,$2,"EPRESSION"); addedge($$,$4,"SUITE"); }
                | WHILE namedexpr_test COLON suite ELSE COLON suite  { $$ = addlabel("WHILE"); addedge($$,$2,"EPRESSION"); addedge($$,$4,"SUITE"); addedge($$,$7,"SUITE");  }
            ;
for_stmt: FOR exprlist IN testlist COLON suite    {$$ = addlabel("FOR_IN"); addedge($$,$2,"EPRESSION_LS"); addedge($$,$4,"TEST_LS"); addedge($$,$6,"SUITE"); }
                | FOR exprlist IN testlist COLON suite ELSE COLON suite   {$$ = addlabel("FOR_IN_ELSE"); addedge($$,$2,"EPRESSION_LS"); addedge($$,$4,"TEST_LS"); addedge($$,$6,"SUITE"); addedge($$,$9,"SUITE"); }
            ;
suite: simple_stmt  { $$=$1; }
            | NEWLINE INDENT stmt_plus DEDENT   { $$=$3; }
            | NEWLINE INDENT stmt_plus NEWLINE DEDENT   { $$=$3; }
            ;

nts_star : ELIF namedexpr_test COLON suite  { $$=addlabel("ELIF"); addedge($$,$2,"EXPRESSION"); addedge($$,$4,"SUITE"); }
            | ELIF namedexpr_test COLON suite nts_star  {$$=addlabel("ELIF"); addedge($$,$2,"EXPRESSION"); addedge($$,$4,"SUITE"); addedge($$,$5);}
            ;
namedexpr_test: test    { $$=$1; }
                ;
test: or_test   { $$=$1;  }
        | or_test IF or_test ELSE test  { $$=addlabel("IF_ELSE"); addedge($$,$1,"OR_TEST"); addedge($$,$3,"OR_TEST"); addedge($$,$5,"TEST"); }
        ;
or_test: and_test    { $$=$1; }
        | and_test_star OR and_test    { $$ = addlabel(string("OR\n")+"(or)"); addedge($$,$1); addedge($$,$3); }
        ;
and_test_star : and_test_star OR and_test { $$ = addlabel(string("OR\n")+"(or)"); addedge($$,$1); addedge($$,$3); }
                | and_test   { $$=$1; }
        ;

and_test: not_test  { $$=$1; }
        | not_test_star AND not_test    { $$ = addlabel(string("AND\n")+"(and)"); addedge($$,$1); addedge($$,$3); }
        ;
not_test_star : not_test_star AND not_test  { $$ = addlabel(string("AND\n")+"(and)"); addedge($$,$1); addedge($$,$3); }
            | not_test   { $$=$1; }
            ;

not_test: NOT not_test   { $$ = addlabel(string("NOT\n")+"(not)"); addedge($$,$2); }
            | comparison    { $$=$1;  }
            ;

comparison: expr  { $$=$1; }
            | expr comp_op comparison  { $$ = $2; addedge($$,$1); addedge($$,$3); }

comp_op: LESS_THAN  { $$ = addlabel(string("LESS_THAN\n")+"(<)"); }
    | GREATER_THAN  { $$ = addlabel(string("GREATER_THAN\n")+"(>)"); }
    | EQUAL_EQUAL   { $$ = addlabel(string("EQUAL_EQUAL\n")+"(==)"); }
    | GREATER_THAN_EQUAL    { $$ = addlabel(string("GREATER_THAN_EQUAL\n")+"(>=)"); }
    | LESS_THAN_EQUAL   { $$ = addlabel(string("LESS_THAN_EQUAL\n")+"(<=)"); }
    | NOT_EQUAL_ARROW   { $$ = addlabel(string("NOT_EQUAL_ARROW\n")+"(!=)"); }
    | NOT_EQUAL    { $$ = addlabel(string("NOT_EQUAL\n")+"(!=)"); }
    | IN    { $$ = addlabel(string("IN\n")+"(in)"); }
    | NOT IN    { $$ = addlabel(string("NOT_IN\n")+"(not in)"); }
    | IS    { $$ = addlabel(string("IS\n")+"(is)"); }
    | IS NOT    { $$ = addlabel(string("IS_NOT\n")+"(is not)"); }
    ;

star_expr: MULTIPLY expr    { $$ = addlabel("STAR_EXPR"); $1 = addlabel(string("MULTIPLY\n")+"(*)"); addedge($$,$1); addedge($$,$2); }
            ;

expr: xor_expr    { $$=$1; }
        | xor_expr BIT_OR expr    { $$ = addlabel(string("BIT_OR\n")+"(|)"); addedge($$,$1); addedge($$,$3); }
        ;

xor_expr: and_expr { $$=$1; }
          | and_expr BIT_XOR xor_expr { $$ = addlabel(string("BIT_XOR\n")+"(^)"); addedge($$,$1); addedge($$,$3); }
        ;

and_expr: shift_expr   { $$=$1; }
         | shift_expr BIT_AND and_expr   { $$ = addlabel(string("BIT_AND\n")+"(&)"); addedge($$,$1); addedge($$,$3); }    
        ;

shift_expr: arith_expr   { $$=$1; }
            | arith_expr SHIFT_OPER shift_expr   { $$ = addlabel(string("SHIFT_OPER\n (")+ chartostring($2) + string(")")); addedge($$,$1); addedge($$,$3); }
        ;

arith_expr: term { $$=$1; }
            | arith_expr PLUS term { $$ = addlabel(string("PLUS\n")+"(+)"); addedge($$,$1); addedge($$,$3); }
            | arith_expr MINUS term { $$ = addlabel(string("MINUS\n")+"(-)"); addedge($$,$1); addedge($$,$3); }
        ;
term: factor {$$=$1;}
        | term term_choice factor { $$ = $2; addedge($$,$1); addedge($$,$3); }
        ;

term_choice : MULTIPLY      { $$ = addlabel(string("MULTIPLY\n")+"(*)"); }
            |ATTHERATE      { $$ = addlabel(string("ATTHERATE\n")+"(@)");}
            |DIVIDE         { $$ = addlabel(string("DIVIDE\n")+"(/)");}
            |REMAINDER      { $$ = addlabel(string("REMAINDER\n")+"(%)");}
            |FLOOR_DIV_OPER    { $$ = addlabel(string("FLOOR_DIV_OP\n")+"(//)");}
            ;

factor: factor_choice factor        { $$ = $1; addedge($$,$2); }
        | power     { $$=$1; }
        ;
factor_choice : PLUS        {$$ = addlabel(string("PLUS\n")+"(+)",true); }   
                |MINUS      {$$ = addlabel(string("MINUS\n")+"(-)",true);  } 
                |NEGATION   {$$ = addlabel(string("NEGATION\n")+"(~)",true); }
                ; 
power: atom_expr        { $$=$1; }
        | atom_expr POWER_OPERATOR factor   { $$ = addlabel(string("POWER_OP\n")+"(**)"); addedge($$,$1); addedge($$,$3); }
        ;

atom_expr: atom { $$=$1; }
        | atom_expr trailer { $$ = addlabel("ATOM_EXPR"); addedge($$,$1); addedge($$,$2); }
        | atom_expr DOT NAME {$$=addlabel("."); addedge($$,$1); $3=addlabel(string("NAME\n (")+chartostring($3) + string(")"),true); addedge($$,$3); }
        ;

atom: OPEN_BRACKET testlist_comp CLOSE_BRACKET  { $$=$2; }
    | OPEN_BRACKET CLOSE_BRACKET    {$$=addlabel("ATOM1"); }
    | SQUARE_OPEN testlist_comp SQUARE_CLOSE    {$$=$2; }
    | SQUARE_OPEN SQUARE_CLOSE  {$$=addlabel("ATOM1"); }
    | CURLY_OPEN dictorsetmaker CURLY_CLOSE     {$$=$2; }
    | CURLY_OPEN CURLY_CLOSE    {$$=addlabel("ATOM1");  }
    | NAME      {$$=addlabel(string("NAME\n (")+chartostring($1) + string(")"),true);  }
    | NUMBER        {$$=addlabel(string("NUMBER\n (")+chartostring($1) + string(")"),true); }
    | STRING_PLUS       {$$=$1; }
    | ATOM_KEYWORDS     {$$=addlabel(string("ATOM_KEYWORD\n (")+chartostring($1) + string(")"),true); }
    | TYPE_HINT     {$$=addlabel(string("TYPE\n (")+chartostring($1) + string(")"),true);  }
    ;
STRING_PLUS: STRING     {$$=addlabel(string("STRING\n (")+chartostring($1) + string(")"),true); }   
            | STRING STRING_PLUS    { $$=addlabel("STRING_PLUS"); $1=addlabel(string("STRING\n (")+chartostring($1) + string(")"),true); addedge($$,$1); addedge($$,$2,"STR_PLUS"); }
            ;

testlist_comp: named_or_star comp_for       { $$ = addlabel("TESTLIST_COMP"); addedge($$,$1); addedge($$,$2); }
        | named_or_star_list                { $$=$1; }
        | named_or_star_list COMMA          { $$=$1; }
        ;
named_or_star_list : named_or_star      { $$=$1; }
                    | named_or_star_list COMMA named_or_star    { $$ = addlabel("NAMED_LIST"); addedge($$,$1); addedge($$,$3); }
                    ;
named_or_star : namedexpr_test    { $$=$1; }
                | star_expr     { $$=$1; }
                ;

trailer: OPEN_BRACKET CLOSE_BRACKET  {  $$ = addlabel("TRAILER1");  }
        | OPEN_BRACKET arglist CLOSE_BRACKET  {  $$ = $2; }
        | SQUARE_OPEN subscriptlist SQUARE_CLOSE        { $$ = $2; }
        ;

subscriptlist: subscriptlist_list      { $$=$1; }
                | subscriptlist_list COMMA     { $$=$1; }
            ;
subscriptlist_list: subscript       {$$=$1; }
                    | subscriptlist_list COMMA subscript    { $$ = addlabel("SUBSCRIPT_LIST"); addedge($$,$1); addedge($$,$3); }
                    ;
subscript: test     {$$=$1; }
        | COLON     {$$=addlabel("DELIM\n(:)",true);  }
        | COLON test     { $$=$2; }
        | test COLON     {$$=$1; }
        | test COLON test     {$$=addlabel("SUBSCRIPT"); addedge($$,$1,"TEST"); addedge($$,$3,"TEST"); }
        ;
exprlist: expr_or_star_expr_list   {$$=$1; }
        | expr_or_star_expr_list COMMA  {$$=$1; }
        ;
expr_or_star_expr_list: expr_or_star_expr   {$$=$1; } 
                        | expr_or_star_expr_list COMMA expr_or_star_expr    {$$=addlabel("EXPR_OR_STAR_LIST"); addedge($$,$1,"EXPR_OR_STAR_list"); addedge($$,$3,"EXPR_OR_STAR"); }
                        ;
expr_or_star_expr: expr         {$$=$1; }
                | star_expr     {$$=$1; }
                ;
testlist: testlist_list    {$$=$1; }
        | testlist_list COMMA   {$$= $1; }
        ;
testlist_list: test         {$$=$1; }
            | testlist_list COMMA test  {$$=addlabel("TESTLIST_LIST"); addedge($$,$1,"TESTLIST_list"); addedge($$,$3,"TEST"); }
            ;
dictorsetmaker: A comp_for   {$$=addlabel("DICTORSETMAKER"); addedge($$,$1,"A"); addedge($$,$2,"COMP_FOR"); }
            | A_list      {$$=$1; }
            | A_list COMMA      {$$=$1; }
            | B comp_for       {$$=addlabel("DICTORSETMAKER"); addedge($$,$1,"B"); addedge($$,$2,"COMP_FOR"); }
            | B_list       {$$=$1; }
            | B_list COMMA      {$$=$1; }
            ;

A: test COLON test  { $$=addlabel("A"); addedge($$,$1,"TEST"); addedge($$,$3,"TEST"); }
    | POWER_OPERATOR expr   {$$=addlabel(string("POWER_OP\n")+"(**)"); addedge($$,$2); }
    ;
A_list: A    {$$=$1; }
        | A_list COMMA A    {$$=addlabel("A_LIST"); addedge($$,$1,"A_list"); addedge($$,$3,"A");}
        ;
B: test  {$$=$1; }
    | star_expr     {$$=$1; }
    ;
B_list: B   {$$=$1; }
        | B_list COMMA B    {$$=addlabel("B_LIST"); addedge($$,$1,"B_list"); addedge($$,$3,"B"); }
        ;

classdef: CLASS NAME COLON suite      {$$=addlabel("CLASS"); $2=addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2); addedge($$,$4); }
        | CLASS NAME OPEN_BRACKET CLOSE_BRACKET COLON suite      {$$=addlabel("CLASS"); $2=addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2); addedge($$,$6); }
        | CLASS NAME OPEN_BRACKET arglist CLOSE_BRACKET COLON suite      {$$=addlabel("CLASS"); $2=addlabel(string("NAME\n (")+chartostring($2) + string(")"),true); addedge($$,$2); addedge($$,$4); addedge($$,$7);}
        ;

arglist: argument_list     {$$=$1; }
        | argument_list  COMMA   {$$=$1; }
        ;
argument_list: argument     {$$=$1; }
            | argument_list COMMA argument  { $$=addlabel("ARGUMENT_LIST"); addedge($$,$1,"ARG_LIST"); addedge($$,$3,"ARG"); }
argument: test  {$$=$1; }
    | test comp_for     {$$=addlabel("ARGUEMENT"); addedge($$,$1); addedge($$,$2); }
    | test EQUAL test   { $$=addlabel(string("EQUAL\n")+"(=)"); addedge($$,$1); addedge($$,$3); }
    | POWER_OPERATOR test   { $$=addlabel(string("POWER_OPER\n")+"(**)"); addedge($$,$2); }
    | MULTIPLY test     { $$=addlabel(string("MULTIPLY\n")+"(*)"); addedge($$,$2); }
    ;

comp_iter: comp_for     {$$=$1; }
            | comp_if   {$$=$1; }
            ;
sync_comp_for: FOR exprlist IN or_test      {$$=addlabel("FOR_IN"); addedge($$,$2); addedge($$,$4); }
                | FOR exprlist IN or_test comp_iter     {$$=addlabel("FOR_IN"); addedge($$,$2); addedge($$,$4); addedge($$,$5); }
                ;
comp_for: sync_comp_for     {$$=$1; }
        | ASYNC sync_comp_for   {$$=addlabel("ASYNC"); addedge($$,$2); }
        ;
comp_if: IF or_test         {$$=addlabel("IF"); addedge($$,$2,"OR_TEST"); }
        | IF or_test comp_iter  {$$=addlabel("IF"); addedge($$,$2); addedge($$,$3); }
        ;
func_body_suite: simple_stmt    {$$=$1; }
                | NEWLINE INDENT stmt_plus DEDENT   {$$=$3; }
                | NEWLINE INDENT stmt_plus NEWLINE DEDENT   {$$=$3; }
                ;

stmt_plus: stmt     {$$=$1; }
        | stmt stmt_plus    {$$=addlabel("MANY_STMT"); addedge($$,$1); addedge($$,$2); }

comma_test: COMMA test  {$$=$2; }
        ;
%%

void yyerror(string str){
    fprintf(stderr, "Error: %s at line number %d offending token: %s\n", str.c_str(), yylineno, yytext);
    print_ast();
    exit(1);
}

int main(int argc, char* argv[]){    
    yydebug=1;
    FILE* yyin; 
    bool inset = false, outset = false;
    indent_stack.push(0);

    for (int i=0; i< argc; i++){
        if (strcmp(argv[i], "-help") == 0){
            cerr<<"Usage: ./run.sh [-help] [-input <filename>] [-output <filename>] [-verbose]\n";
            cerr<< "Example: ./myASTGenerator -input input.txt -output output.txt\n";
        }
        else if (strcmp(argv[i], "-input") == 0){
            yyin = fopen(argv[i+1], "r");
            yyrestart(yyin);
            inset = true;
        }
        else if (strcmp(argv[i], "-output") == 0){
            freopen(argv[i+1], "w", stdout);
            outset = true;
        }
        else if (strcmp(argv[i], "-verbose") == 0){
            cerr<<"Verbose Output directed to parser.output\n";
        }
    }
    if (!inset){
        cerr<< "Input not set, see help\n";
        return 0;
    }
    if (!outset){
        cerr<< "Output not set, see help\n";
        return 0;
    } 
    yyparse(); 
    print_ast();
    fclose(yyin); 
    return 0;

}