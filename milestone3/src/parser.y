%{  
    /*definitions*/
    #include <bits/stdc++.h>
    // #include "data.h"
    // #include "symbol_table.cpp"
    #include "x86.cpp"
    // #include "functions.cpp"
    using namespace std;

    extern int yylex();
    extern int yyparse();
    extern void yyrestart(FILE* file);
    extern FILE* yyin;
    extern int yylineno;
    extern char* yytext;
    void yyerror(string str);
    extern stack<int> indent_stack;
    stack<int> loopStack;
    stack<string> iterStack;
    // stack<string> paramStack;

    //map<NODE*,map<string,int>> global_offset;

    int instCount;
    vector<vector<string>> instructions;
    vector<int> makelist(int i);
    void backpatch(vector<int> p, int i);
    void backpatch_str(vector<int> p, string str);
    void create_ins(int type,string i,string op,string arg1,string arg2);
    vector<int> merge(vector<int> p1, vector<int> p2);
    void vector_copy(vector<string> v1,vector<string> v2);
    string newTemp();
    char* str_to_ch(string s);
    int tempCount;
    fstream code_out;
    string typecast(string , string, string);

    // map<string,ste> global_sym_table;
    ste* global_sym_table = new ste;   //pointer to the head(initialising entry) of the global symbol table
    ste* current_ste = global_sym_table;   //pointer to current symbol table entry (initialised to pointer of head of the global symbol table)  
    map<string, ste*> class_map;

    int endline=0;

    int funcOffset = 0;

    int inClass = 0;
    int ischild = 0;
    string className;
    unordered_map <string, int> typeMap;
    int isatom=0;
    int incheck=0;
    int isinsquare =0;


    //m3 start
    int stack_offset=16;    //8 bytes for rbp and 8 bytes for rip
    map<string, int> offset_map;
    map<string,string> class_parent;
    map<string,int> class_offset_map;
    int class_offset =0;
    string curr_class="";
    // map<string, int> string_map_mohak;
    map<string, string> obj_class;
    //m3 end

    char* numtochar( int num){  
        char* c = new char[100];
        int i=0;
        while(num>0){
            c[i] = num%10 + '0';
            num/=10;
            i++;
        }
        c[i]='\0';
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
%}

%union{
    struct node *elem;
}

%start file

%type<elem> class_declare M N file snippet stmt simple_stmt small_stmt_list small_stmt expr_stmt eq_testlist_star_expr_plus flow_stmt break_stmt continue_stmt return_stmt global_stmt compound_stmt funcdef parameters typedargslist typedarg tfpdef if_stmt while_stmt for_stmt suite nts_star test or_test and_test not_test comparison comp_op expr xor_expr and_expr shift_expr arith_expr term term_choice factor factor_choice power atom_expr atom STRING_PLUS trailer classdef arglist argument_list argument testlist testlist_list comma_name_star and_test_star not_test_star stmt_plus
%type<elem> for_test func_name func_ret_type while_expr else_scope else_if_scope if_scope while_scope for_scope if_expr
%type<elem> range_stmt for_core class_body_suite funcdef_plus d_expr S T for_else_N obj_dec
%token<elem> RANGE NEWLINE INDENT DEDENT ASSIGN_OPERATOR POWER_OPERATOR SHIFT_OPER FLOOR_DIV_OPER ARROW_OPER TYPE_HINT NAME IF ELSE ELIF WHILE FOR IN AND OR NOT BREAK CONTINUE RETURN CLASS DEF GLOBAL ATOM_KEYWORDS STRING OPEN_BRACKET CLOSE_BRACKET EQUAL SEMI_COLON COLON COMMA PLUS MINUS MULTIPLY DIVIDE REMAINDER ATTHERATE NEGATION BIT_AND BIT_OR BIT_XOR DOT CURLY_OPEN CURLY_CLOSE SQUARE_OPEN SQUARE_CLOSE LESS_THAN GREATER_THAN EQUAL_EQUAL GREATER_THAN_EQUAL LESS_THAN_EQUAL NOT_EQUAL_ARROW NOT_EQUAL IS
%token<elem> TRUE FALSE NUMBER NONE LEN PRINT D_MAIN D_NAME SELF 

%%


M: %empty{
        $$ = create_node(1, "Marker Non-terminal M");
        $$->ins = instCount+1;
}
;

N: %empty{
        $$ = create_node(1, "Marker Non-terminal N");
        $$->nextlist = makelist(instCount+1);
        create_ins(0, "goto", "", "", "");
}
;

for_else_N: %empty{
        $$ = create_node(1, "Marker Non-terminal for_else_N");
        create_ins(1, iterStack.top(), "+", iterStack.top(), "1");
        // $$->ins=instCount;
        $$->nextlist = makelist(instCount+1);
        create_ins(0, "goto", "", "", "");
}
;

file: snippet {
                $$ = $1;
                endline = instCount+1;
                create_ins(0, "EOF", "", "", "");
            }
            ;

snippet: NEWLINE {
       $$=$1;
	   $$->ins = instCount+1;
    }
    | stmt  { 
        $$=$1;
    }
    | NEWLINE snippet  { 
        $$=$2;
    }
    | stmt snippet {  
        $$ = create_node(3, "snippet", $1, $2);
        $$->ins = $1->ins;
        $$->lineno = $1->lineno;
    }
    ; 

funcdef: DEF func_name parameters COLON suite {
            $$ = create_node(6, "funcdef", $1, $2, $3, $4, $5);

            //STE code start
            current_ste = get_prev_scope(current_ste);
            populate_new_scope(current_ste, "FUNCTION", $2->addr, $3->num_params, $1->lineno, 1);
            //STE code end

			// create_ins(0,$5->return_param,"=","PopParam","");
            create_ins(0,"Stackpointer -"+to_string(funcOffset),"","","");
            funcOffset=0;
            create_ins(0,"goto","ra","","");
            create_ins(0, "return", "", "", "");

            create_ins(0,"EndFunc","","","");
            backpatch_str($5->nextlist, "ra");
            // thisTemps.push(reg1);

            //populate in symbol table
            populate_fun_par_type(current_ste,$3->func_par_type);

            //m3 start
            $$->stack_width = $5->stack_width;
            current_ste->stack_width = $$->stack_width;
            current_ste->offset_map = offset_map;
            stack_offset = 16;
            offset_map.clear();
            //m3 end

        }
        | DEF func_name parameters ARROW_OPER func_ret_type COLON suite {
            $$ = create_node(8, "funcdef", $1, $2, $3, $4, $5,$6,$7);

            current_ste = get_prev_scope(current_ste);
            populate_new_scope(current_ste, "FUNCTION", $2->addr, $3->num_params, $1->lineno, 1,$5->addr);
            // thisTemps.pop();
			// create_ins(0,$2->return_func,"=","PopParam","");
            create_ins(0,"Stackpointer -"+to_string(funcOffset),"","","");
            funcOffset=0;
            create_ins(0,"goto","ra","","");
            if(chartostring($5->addr) == "None"){
                //cerr<<"return instruction created"<<endl;
                create_ins(0, "return", "", "", "");
            }
            create_ins(0,"EndFunc","","","");

            //populate in symbol table
            populate_fun_par_type(current_ste,$3->func_par_type);

            //m3 start
            $$->stack_width = $7->stack_width;
            current_ste->stack_width = $$->stack_width;
            current_ste->offset_map = offset_map;
            stack_offset = 16;
            offset_map.clear();
            
            //m3 end
        }
        | DEF func_name OPEN_BRACKET CLOSE_BRACKET T COLON suite {
            $$ = create_node(8, "funcdef", $1, $2, $3, $4, $5,$6,$7);
            current_ste = get_prev_scope(current_ste);
            populate_new_scope(current_ste, "FUNCTION", $2->addr, 0, $1->lineno, 1);

            // thisTemps.pop();
			// create_ins(0,$2->return_func,"=","PopParam","");
            create_ins(0,"Stackpointer -"+to_string(funcOffset),"","","");
            funcOffset=0;
            create_ins(0,"goto","ra","","");
            create_ins(0, "return", "", "", "");

            create_ins(0,"EndFunc","","","");

            //m3 start
            $$->stack_width = $7->stack_width;
            current_ste->stack_width = $$->stack_width;
            current_ste->offset_map = offset_map;
            stack_offset = 16;
            offset_map.clear();
            //m3 end
        }
        | DEF func_name OPEN_BRACKET CLOSE_BRACKET ARROW_OPER func_ret_type T COLON suite{
            $$ = create_node(10, "funcdef", $1, $2, $3, $4, $5,$6,$7,$8,$9);
            current_ste = get_prev_scope(current_ste);
            populate_new_scope(current_ste, "FUNCTION", $2->addr, 0, $1->lineno, 1,$6->addr);

            // thisTemps.pop();
			// create_ins(0,$2->return_func,"=","PopParam","");
            create_ins(0,"Stackpointer -"+to_string(funcOffset),"","","");
            funcOffset=0;
            create_ins(0,"goto","ra","","");
            if(chartostring($6->addr) == "None"){
                create_ins(0, "return", "", "", "");
            }
            create_ins(0,"EndFunc","","","");

            //m3 start
            $$->stack_width = $9->stack_width;
            current_ste->stack_width = $$->stack_width;
            current_ste->offset_map = offset_map;
            stack_offset = 16;
            offset_map.clear();
            
            //m3 end
        }
        ;

T: %empty{
        stack_offset = 8;
}

func_name: NAME 
    {   
        $$=$1;

        if(inClass==0) create_ins(0,chartostring($1->addr)+":","","","");
        else create_ins(0,className+"."+chartostring($1->addr)+":","","","");

        create_ins(0,"BeginFunc","","","");
        // paramStack.pop(); //popping return address
        create_ins(0,"PushParam","RBP","","");
        create_ins(0,"ra","=","PopParam","");

        //STE code start
        ste* lookup_ste = current_ste;
        //here I am adding it should not be init
        if(lookup(lookup_ste, $1->addr) == NULL || chartostring($1->addr) == "__init__"){
            current_ste = insert_entry_new_scope(current_ste);
            ste* help = current_ste->prev_scope;
            populate_new_scope(help, "FUNCTION", $1->addr, 0, 0, 1);
        }
        else if(same_lookup(lookup_ste, $1->addr) == NULL){
            current_ste = insert_entry_new_scope(current_ste);
            ste* help = current_ste->prev_scope;
            populate_new_scope(help, "FUNCTION", $1->addr, 0, 0, 1);
        }
        else{ //print_ste(global_sym_table, 0);
            cerr<<"Error: Function "<<$1->addr<<" already declared in same scope at line number " << lookup(lookup_ste, $1->addr)->lineno << "\n";
            exit(1);
        }
        //STE code end

    }
    /* | D_INIT {
        $$=$1;

        if(inClass==0) create_ins(0,chartostring($1->addr)+":","","","");
        else create_ins(0,className+"."+chartostring($1->addr)+":","","","");

        create_ins(0,"BeginFunc","","","");
        // paramStack.pop(); //popping return address
        create_ins(0,"ra","=","PopParam","");

        //STE code start
        ste* lookup_ste = current_ste;
        if(lookup(lookup_ste, $1->addr) == NULL){
            current_ste = insert_entry_new_scope(current_ste);
            ste* help = current_ste->prev_scope;
            populate_new_scope(help, "FUNCTION", $1->addr, 0, 0, 1);
        }
        else{
            cerr<<"Error: Function "<<$1->addr<<" already declared\n";
            exit(1);
        }
    } */
    ;

func_ret_type: TYPE_HINT{
        $$=$1;
        get_prev_scope(current_ste)->return_type = $1->addr;
    }
    | NONE{
        $$=$1;
        get_prev_scope(current_ste)->return_type = "None";
    }
    ;

parameters: OPEN_BRACKET typedargslist CLOSE_BRACKET {  
            $$ = create_node(4, "parameters", $1, $2, $3);
            $$->ins = $2->ins;
            $$->num_params = $2->num_params;
            $$->lineno = $1->lineno;

            get_prev_scope(current_ste)->num_params = $$->num_params;
            get_prev_scope(current_ste)->func_par_type = $2->func_par_type;

            //handle vector of par type 
            $$->func_par_type = $2->func_par_type;

            //m3 tsart
            //$$->stack_width = $2->stack_width;
            stack_offset=8;
            //m3 end 
        }
        | OPEN_BRACKET SELF COMMA typedargslist CLOSE_BRACKET {
            $$ = create_node(6, "parameters", $1, $2, $3, $4, $5);
            $$->ins = $4->ins;
            $$->num_params = $4->num_params;
            $$->lineno = $1->lineno;
            get_prev_scope(current_ste)->num_params = $$->num_params;
            get_prev_scope(current_ste)->func_par_type = $4->func_par_type;
            //handle vector of par type 
            $$->func_par_type = $4->func_par_type;
            //m3 tsart
            //$$->stack_width = $4->stack_width;
            stack_offset=8;
            //m3 end 
        }
        | OPEN_BRACKET SELF CLOSE_BRACKET {
            $$ = create_node(3, "parameters", $1, $2, $3);
            $$->ins = instCount+1;
            $$->num_params = 0;
            $$->lineno = $1->lineno;

            //m3 start
            //check while class
            stack_offset=8;
            //m3 end
        }
        ;

typedargslist:  typedarg    {  
            $$=$1;
            $$->num_params=1;
            $$->ins = instCount+1;
            
            // paramStack.pop();
            create_ins(0,$1->addr,"=","PopParam","");

        }
        | typedargslist COMMA  typedarg  {  
            $$ = create_node(4, "typedargslist", $1, $2, $3);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            $$->num_params = $1->num_params + 1;
            $$->ins = instCount+1;
            // paramStack.pop();
            create_ins(0,$3->addr,"=","PopParam","");

            //handle vector of par type 
            $$->func_par_type = $1->func_par_type;
            for(int i=0;i < $3->func_par_type.size(); i++){
                $$->func_par_type.push_back($3->func_par_type[i]);
            }

        }
        /* | SELF {
            $$=$1;
            $$->ins = instCount+1;
            //$$->num_params=0;
        } */
        ;

typedarg: tfpdef   {  
            $$=$1;
        }
        | tfpdef EQUAL test {  
            $$ = create_node(4, "typedarg", $1, $2, $3);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            create_ins(0, $1->addr, $2->addr, $3->addr, "");    //is this instruction needed?????

            //typecheck
            //curretnly doing only for LHS, checked for LHS
            if(lookup(current_ste, $1->addr) == NULL){
                cerr<<"Error: Undeclared variable "<<$1->addr<<" on line "<<$1->lineno<<"\n";
                exit(1);
            }
            else{
                //Type_checking
                string ret_type=typecast($1->atom_type,$3->atom_type,$2->addr);
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in formal argument assignment on line "<<$1->lineno<<"\n";
                    exit(1);
                }
            }
            //typecheck end

            //handle vector of par type 
            $$->func_par_type = $1->func_par_type;

            //m3 start
            //$$->stack_width = $1->stack_width + $3->stack_width;
            $$->addr = $1->addr;
            //m3 end
        }
        ;

tfpdef: NAME {  
            $$=$1;
			$$->ins = instCount+1;
            
            if(lookup(current_ste, $1->addr) == NULL){
                cerr<<"Error: Undeclared variable "<<$1->addr<<" on line "<<$1->lineno<<"\n";
                exit(1);
            }
            else{
                $$->atom_type = lookup(current_ste, $1->addr)->type;
            }
        }
        | NAME COLON TYPE_HINT {  
            $$ = create_node(4, "tfpdef", $1, $2, $3); 
			$$->ins = instCount+1;
            $$->addr = $1->addr;
            $$->lineno = $1->lineno;

            //Type check start 
            $1->atom_type = $3->addr; //see type kya hai exactly
            $$->atom_type = $3->addr; 
            //symbol table entry me type niche daal dia hai
            //Type check end

            //STE code start
            ste* lookup_ste = current_ste;
            //print_ste(lookup_ste, 0);
            if(lookup(lookup_ste, $1->addr) == NULL){
                current_ste = insert_entry_same_scope(current_ste, "VARIABLE", $1->addr, $3->addr, $1->lineno, 1);
            }
            else if(same_lookup(lookup_ste, $1->addr) == NULL){
                current_ste = insert_entry_same_scope(current_ste, "VARIABLE", $1->addr, $3->addr, $1->lineno, 1);
            }
            
            else{ 
                cerr<<"Error: Variable "<<$1->addr<<" already declared on line "<<lookup(lookup_ste, $1->addr)->lineno<<"\n";
                exit(1);
            }
            //STE code end 

            //handle vector of par type 
            $$->func_par_type.push_back(chartostring($3->addr));

            //m3 start 
            //$$->stack_width = 8;
            offset_map[chartostring($1->addr)] = stack_offset;
            stack_offset+=8;
            //m3 end
        }
        ;

stmt: simple_stmt       { 
        	$$=$1;
        }
        | compound_stmt     { 
            $$=$1; 
        }
        ;

simple_stmt: small_stmt_list SEMI_COLON NEWLINE {  
            $$=$1;
        }
        | small_stmt_list  NEWLINE {  
            $$=$1;
        }
        ; 

small_stmt_list: small_stmt     {   
            $$=$1;
        }
        | small_stmt_list SEMI_COLON small_stmt      {  
            $$ = create_node(3, "small_stmt_list", $1, $2, $3);
            $$->ins = $1->ins;
            $$->nextlist = merge($1->nextlist, $3->nextlist);
            $$->lineno = $1->lineno;

            //M3 start
            $$->stack_width = $1->stack_width + $3->stack_width;
            //M3 end
        }
        ;

small_stmt: expr_stmt       {  
           $$=$1;
        }
        | flow_stmt     {  
           $$=$1;
        }
        | global_stmt       {  
            $$=$1;
        }
        ;

expr_stmt: test ASSIGN_OPERATOR test { 
            $$ = create_node(4, "expr_stmt", $1, $2, $3);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
             
            string oper="";
            int i=0;
            while($2->addr[i]!='='){
                oper.push_back($2->addr[i]);
                i++;
            }

            //typecheck
                string ret_type=typecast($1->atom_type,$3->atom_type,$2->addr);
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in assignment on line number "<<$1->lineno<<"\n";
                    exit(1);
                }
                string temp = newTemp();
                if(ret_type != $3->atom_type){
                    create_ins(1, temp, oper,chartostring($1->addr) ,chartostring($3->addr));
                    // create_ins(1, temp, oper,chartostring($1->addr) ,"("+ret_type+")"+chartostring($3->addr));
                    create_ins(0, $1->addr, "=", temp, "");
                }
                else if(ret_type != $1->atom_type){
                    create_ins(1, temp, oper, chartostring($1->addr),chartostring($3->addr));
                    // create_ins(1, temp, oper, "("+ret_type+")"+chartostring($1->addr),chartostring($3->addr));
                    create_ins(0, $1->addr, "=", temp, "");
                }
                else{
                    create_ins(1, temp, oper, $1->addr, $3->addr);
                    create_ins(0, $1->addr, "=", temp, "");
                }
            //typecheck done

            //m3 start
            $$->stack_width = 8 + $1->stack_width + $3->stack_width;
            offset_map[temp] = -stack_offset;
            stack_offset+=8;
            //m3end
        }
        | test COLON TYPE_HINT ASSIGN_OPERATOR test { // Is this rule really required?  x:int += 5
            $$ = create_node(4, "expr_stmt", $1, $2, $3);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            

            //runtime support start
            funcOffset += get_width($3->addr);
            create_ins(0, "Stackpointer +"+to_string(get_width($3->addr)), "", "", "");
            //runetime support end

            //STE code start
            ste* lookup_ste = current_ste;
            if(lookup(lookup_ste, $1->addr) == NULL){
                current_ste = insert_entry_same_scope(current_ste, "VARIABLE", $1->addr, $3->addr, $1->lineno, 1);
            }
            else{
                cerr<<"Error: Variable "<<$1->addr<<" already declared on line "<<lookup(lookup_ste, $1->addr)->lineno<<"\n";
                exit(1);
            }
            //STE code end

            //Type checking
            $1->atom_type = $3->addr;
            string oper="";
            int i=0;
            while($4->addr[i]!='='){
                oper.push_back($4->addr[i]);
                i++;
            }
            //Type checking end
            //typecheck
                string ret_type=typecast($1->atom_type,$5->atom_type,$4->addr);
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                string temp = newTemp();
                if(ret_type != $5->atom_type){
                    create_ins(1, temp, oper, chartostring($1->addr),chartostring($5->addr));
                    // create_ins(1, temp, oper, chartostring($1->addr),"("+ret_type+")"+chartostring($5->addr));
                    create_ins(0, $1->addr, "=", temp, "");
                }
                else if(ret_type != $1->atom_type){
                    create_ins(1, temp, oper, chartostring($1->addr),chartostring($5->addr));
                    // create_ins(1, temp, oper, "("+ret_type+")"+chartostring($1->addr),chartostring($5->addr));
                    create_ins(0, $1->addr, "=", temp, "");
                }
                else{
                    create_ins(1, temp, oper, $1->addr, $5->addr);
                    create_ins(0, $1->addr, "=", temp, "");
                }
            //typecheck done

            //M3 START
            $$->stack_width = 8 + 8 + $1->stack_width + $5->stack_width;
            offset_map[chartostring($1->addr)] = -stack_offset;
            stack_offset+=8;
            offset_map[temp] = -stack_offset;
            stack_offset+=8;
            //M3 END

        }
        /*| test COLON test ASSIGN_OPERATOR test {  
            $$ = create_node(4, "expr_stmt", $1, $2, $3);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            // Here add instruction 

            //STE code start
            ste* lookup_ste = current_ste;
            if(lookup(lookup_ste, $1->addr) == NULL){
                current_ste = insert_entry_same_scope(current_ste, "VARIABLE", $1->addr, $3->addr, $1->lineno, 1);
            }
            else{
                cerr<<"Error: Variable "<<$1->addr<<" already declared on line "<<lookup(lookup_ste, $1->addr)->lineno<<"\n";
                exit(1);
            }
            //STE code end

            //m3 start pending

            //m3 end

        }*/
        | testlist {
			$$=$1;
        }
        | test EQUAL eq_testlist_star_expr_plus{
            $$ = create_node(4, "eq_testlist_star_expr_plus", $1, $2, $3);
			$$->ins = $1->ins;
            $$->lineno = $1->lineno;
			// create_ins(0, $1->addr, $2->addr, $3->addr, ""); 

            if(chartostring($1->type) == "self_call"){
                //cout<<"test eq testlistex: "<<$1->atom_type<<" "<<$3->atom_type<<endl;
                ste* lookup_ste = lookup(current_ste, $1->class_param);

                if(lookup_ste == NULL){
                    cerr<<"Error: Variable "<<$1->class_param<<" not declared on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                else{
                    //cout<<"lookup_ste->type: "<<lookup_ste->type<<" $3->atom_type: "<<$3->atom_type<<endl;
                    if(lookup_ste->type != $3->atom_type){
                        cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                        exit(1);
                    }
                    else{
                        create_ins(0, $1->addr, "=", $3->addr, "");
                    }
                }
            }
            else if(chartostring($1->type)=="object_call"){
                if($1->atom_type != $3->atom_type){
                    cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                }
                else{
                    create_ins(0, $1->addr, "=", $3->addr, "");  
                }
            }
            
            else{
            //typecheck
                string ret_type=typecast($1->atom_type,$3->atom_type,"=");
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                if(ret_type != $3->atom_type){
                    create_ins(0, $1->addr, "=", chartostring($3->addr),"");
                    // create_ins(0, $1->addr, "=", "("+ret_type+")"+chartostring($3->addr),"");
                }
                else{
                    create_ins(0, $1->addr, $2->addr, $3->addr, "");
                }
            }
            //typecheck done

            //M3 START
            $$->stack_width = $1->stack_width + $3->stack_width;
            //m3 end
        }
        
        | test COLON TYPE_HINT EQUAL eq_testlist_star_expr_plus{
            $$ = create_node(4, "eq_testlist_star_expr_plus", $1, $2, $3);
			$$->ins = $1->ins;
            $$->lineno = $1->lineno;
            //runtime support
            funcOffset += get_width($3->addr);
            string st=str_to_ch($3-> addr);

            string check = chartostring($5->addr);

            if(st=="str" && check.find("\"") != string::npos){  //x:str = "hello"
                // string_map_mohak[chartostring($1->addr)] = $5->str_len;
                create_ins(0, "Heapalloc",to_string(chartostring($5->addr).size()-2), "", "");
            }
            // else if(st=="str"){ //y:str = x
            //     string_map_mohak[chartostring($1->addr)] = string_map_mohak[chartostring($5->addr)];
            //     create_ins(0, "Heapalloc",to_string(string_map_mohak[chartostring($5->addr)]), "", "");
            //     if($5->atom_type == "str"){
            //         $5->addr = str_to_ch(chartostring($5->addr)+":str");
            //     }
            // }

            if(st == "int" || st == "float" || st == "bool" || st == "str") {
                create_ins(0, "Stackpointer +"+to_string(get_width($3->addr)), "", "", "");
            }
            // cout<<"yes "<<$3->addr<<endl;

			//create_ins(0, $1->addr, $4->addr, $5->addr, ""); 
            $1->atom_type = $3->addr;
            if(chartostring($1->type) == "self_call"){
                ste* prev_ste = get_prev_scope(current_ste);
                ste* prev_prev_ste = prev_ste->prev;
                prev_prev_ste = insert_entry_same_scope(prev_prev_ste, "VARIABLE", $1->class_param,$3->addr, $1->lineno,1);
                prev_prev_ste->next = prev_ste;
                prev_ste->prev = prev_prev_ste;

                string ret_type=typecast($1->atom_type,$5->atom_type,"=");
                
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                if(ret_type != $5->atom_type){
                    create_ins(0, $1->addr, "=", chartostring($5->addr),"");
                    // create_ins(0, $1->addr, "=", "("+ret_type+")"+chartostring($5->addr),"");
                    
                }
                else{
                    create_ins(0, $1->addr, "=", $5->addr, "");
                }
            }

            //STE code start
            else{
                ste* lookup_ste = current_ste;
                if(lookup(lookup_ste, $1->addr) == NULL){

                    int list_len = $5->list_par_type.size();

                    if(list_len != 0){
                        string list_type = "";
                        int i=0;
                        while($3->addr[i] != '['){
                            i++;
                        }
                        i++;
                        while($3->addr[i] != ']'){
                            list_type.push_back($3->addr[i]);
                            i++;
                        }
                        string check="";

                        for(i=0;i<list_len;i++){
                            check = typecast(list_type,$5->list_par_type[i],"=");
                            if(check=="Error"){
                                cerr<<"Error: Type mismatch in list assignment on line "<<$1->lineno<<"\n";
                                exit(1);
                            }
                        }

                        create_ins(0, $1->addr, "=", $5->addr, "");

                    }
                    else{
                        string ret_type=typecast($1->atom_type,$5->atom_type,"=");
                
                        if(ret_type == "Error"){
                            cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                            exit(1);
                        }
                        if(ret_type != $5->atom_type){
                            create_ins(0, $1->addr, "=", chartostring($5->addr),"");
                            // create_ins(0, $1->addr, "=", "("+ret_type+")"+chartostring($5->addr),"");
                        }
                        else{
                            create_ins(0, $1->addr, "=", $5->addr, "");
                        }
                    }

                    current_ste = insert_entry_same_scope(current_ste, "VARIABLE", $1->addr, $3->addr, $1->lineno, 1, $5->list_size);
                }
                else{

                    cerr<<"Error: Variable "<<$1->addr<<" already declared on line "<<lookup(lookup_ste, $1->addr)->lineno<<"\n";
                    exit(1);
                }
            }
            //STE code end
            //M3 START
            
            // for __init__ function and when it is self, it should not add so see that 
            //but there may be possibility of t0 setting up here, think!!
            if(chartostring($1->type) == "self_call"){
                // I need class and I think it should run always , not sure
                if(curr_class!=""){
                    ste* pre_class = class_map[curr_class];
                    pre_class->class_offset_map[$1->class_param]=class_offset;
                    class_offset += 8;
                }
            }
            else{
                $$->stack_width = 8 + $1->stack_width + $5->stack_width;
                offset_map[chartostring($1->addr)] = -stack_offset;
                stack_offset+=8;
            }
            

            //M3 END
        }
        /*| test COLON test EQUAL eq_testlist_star_expr_plus{
            $$ = create_node(7, "eq_testlist_star_expr_plus", $1, $2, $3,$4,$5,$6);
			$$->ins = $1->ins;
            $$->lineno = $1->lineno;
			create_ins(0, $1->addr, $5->addr, $6->addr, ""); 

            //runtime support
            // create_ins(0, "Stackpointer +xxx", "", "", "");
            // create_ins(0,"call memalloc 1","","","");
            // create_ins(0,"Stackpointer -yyy","","","");



            $1->atom_type = $3->addr;
            if(chartostring($1->type) == "self_call"){
                ste* prev_ste = get_prev_scope(current_ste);
                ste* prev_prev_ste = prev_ste->prev;
                prev_prev_ste = insert_entry_same_scope(prev_prev_ste, "VARIABLE", $1->class_param,$3->addr, $1->lineno,1);
                prev_prev_ste->next = prev_ste;
                prev_ste->prev = prev_prev_ste;
            }

            //STE code start
            else{
                ste* lookup_ste = current_ste;
                if(lookup(lookup_ste, $1->addr) == NULL){
                    current_ste = insert_entry_same_scope(current_ste, "OBJECT", $1->addr, $3->addr, $1->lineno, 1, $6->list_size);
                }
                else{
                    cerr<<"Error: Variable "<<$1->addr<<" already declared on line "<<lookup(lookup_ste, $1->addr)->lineno<<"\n";
                    exit(1);
                }
            }
            //m3 start pending
                // do we have do handle like self.a : LALRPARSER = LALRPARSER('abc',...);
            //m3 end

        }*/
        | obj_dec EQUAL eq_testlist_star_expr_plus{
            $$ = create_node(4, "expr_stmt", $1, $2, $3);
			$$->ins = $1->ins;
            $$->lineno = $1->lineno;
			// create_ins(0, $1->obj_name, $2->addr, $3->addr, ""); 

            //runtime support
            // create_ins(0, "Stackpointer +xxx", "", "", "");
            // create_ins(0,"call memalloc 1","","","");
            // create_ins(0,"Stackpointer -yyy","","","");



            // $1->atom_type = str_to_ch($1->class_name);
            
            if(chartostring($1->type) == "self_call"){
                ste* prev_ste = get_prev_scope(current_ste);
                ste* prev_prev_ste = prev_ste->prev;
                prev_prev_ste = insert_entry_same_scope(prev_prev_ste, "VARIABLE", $1->class_param,$1->class_name, $1->lineno,1);
                prev_prev_ste->next = prev_ste;
                prev_ste->prev = prev_prev_ste;
            }

            //STE code start
            else{
                ste* lookup_ste = current_ste;
                if(lookup(lookup_ste, $1->obj_name) == NULL){
                    current_ste = insert_entry_same_scope(current_ste, "OBJECT", $1->obj_name, $1->class_name, $1->lineno, 1, $3->list_size);
                }
                else{
                    cerr<<"Error: Variable "<<$1->obj_name<<" already declared on line "<<lookup(lookup_ste, $1->obj_name)->lineno<<"\n";
                    exit(1);
                }
            }
            //m3 start pending
                // do we have do handle like self.a : LALRPARSER = LALRPARSER('abc',...);
                $$->stack_width = $1->stack_width + $3->stack_width;
            //m3 end

        }
        
    ;

obj_dec: test COLON test {
    $$= create_node(4,"Obj_eq",$1,$2,$3);
    $$->ins = $1->ins;
    $$->lineno = $1->lineno;

    if(chartostring($1->type) == "self_call"){
        $$->class_param = $1->class_param;
    }
    //cerr<<$1->addr<<endl;
    $$->obj_name = $1->addr;
    // cerr<<"out"<<endl;
    $$->class_name = $3->addr;
    $$->type = $1->type;

    if(class_map.find(chartostring($3->addr))!=class_map.end()){
        $$->stack_width = 8 + $1->stack_width + $3->stack_width;
        offset_map[chartostring($1->addr)] = -stack_offset;
        stack_offset+=8;

        //create instructions 
        create_ins(0,"create_obj",to_string(class_map[chartostring($3->addr)]->class_width),$1->addr,"");
        obj_class[chartostring($1->addr)] = chartostring($3->addr);
    }
    else{
        cerr<<"Error: Class "<<$3->addr<<" not defined on line "<<$1->lineno<<"\n";
        exit(1);
    }


};



eq_testlist_star_expr_plus: test {
            $$=$1;
        }
        | test EQUAL eq_testlist_star_expr_plus{
            $$ = create_node(4, "eq_testlist_star_expr_plus", $1, $2, $3);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            //create_ins(0, $1->addr, $2->addr, $3->addr, "");
            $$->addr = $1->addr;    //x=y=z
            //typecheking start
                $$->atom_type = $1->atom_type;
                //Type_checking
                string ret_type=typecast($1->atom_type,$3->atom_type,"=");
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                if(ret_type != $3->atom_type){
                    create_ins(0, $1->addr, "=", chartostring($3->addr),"");
                    // create_ins(0, $1->addr, "=", "("+ret_type+")"+chartostring($3->addr),"");
                }
                else{
                    create_ins(0, $1->addr, $2->addr, $3->addr, "");
                }
            //typecheck done

            //M3 START
            $$->stack_width = $1->stack_width + $3->stack_width;
            //M3 END
        }
        ;

flow_stmt: break_stmt   {  
            $$=$1;
        }
        | continue_stmt     {  
            $$=$1;
        }
        | return_stmt    {  
            $$=$1;
        }
        ;

break_stmt: BREAK   {  
            $$=$1;
            $$->ins = instCount+1; 
            //cout<<$$->ins;
            create_ins(0, "goto", "", "", "");
            $$->nextlist = makelist($$->ins);
            // int temp = loopStack.top();
            // loopStack.pop();
            // if(loopStack.size()!=0)create_ins(0, "goto", to_string(loopStack.top()), "", "");
            // loopStack.push(temp);
        }
        ;
continue_stmt: CONTINUE     {  
            $$=$1;
            $$->ins = instCount+1;
            create_ins(1, iterStack.top(), "+", iterStack.top(), "1");
            create_ins(0, "goto", to_string(loopStack.top()), "", "");
        }
        ;
return_stmt: RETURN     {  
            $$=$1;
            //create_ins(0,"return","","","");

        }
        | RETURN test     {  
            $$ = $2; //ye saih hai?
            $$->ins = $2->ins; //ye bhi??

            if(get_prev_scope(current_ste)->return_type != $2->atom_type){
                cerr<<"Error: Return type mismatch on line "<<$1->lineno<<"\n";
                exit(1);
            }
            
            // m3 commented 3 lines
            // $$->return_param = str_to_ch(newTemp());
            // create_ins(0,$$->return_param,"=",$2->addr,"");
            // create_ins(0,"return",$$->return_param,"","");
            create_ins(0,"return",$2->addr,"","");
            //m3 end
        } 
        ;   

global_stmt:GLOBAL NAME    {  
            $$ = create_node(3, "global_stmt", $1, $2);
            $$->ins = instCount+1;
            $$->lineno = $1->lineno;
                       
        }
        | GLOBAL NAME comma_name_star {   
            $$ = create_node(4, "global_stmt", $1, $2, $3);
            $$->ins = $3->ins;
            $$->lineno = $1->lineno;
        }
        ;

comma_name_star: COMMA NAME    {  
            $$ = create_node(3, "comma_name_star", $1, $2);
            $$->ins = instCount+1;
            $$->lineno = $1->lineno;
        }
        | COMMA NAME comma_name_star    {  
            $$ = create_node(4, "comma_name_star", $1, $2, $3);
            $$->ins = $3->ins;
            $$->lineno = $1->lineno;
        }
        ;
compound_stmt: if_stmt      { 
            $$=$1;  
        }
        | while_stmt   {  
            $$=$1;
            iterStack.pop();
            loopStack.pop();
        }
        | for_stmt     {  
            $$=$1;
            iterStack.pop();
            loopStack.pop();
        }
        | funcdef      {  
            $$=$1;
        }
        | classdef     {  
           $$=$1;
        }
        ;  

if_stmt: if_scope if_expr COLON M suite     {  
           $$=create_node(6, "if_stmt", $1, $2, $3, $4, $5);
           $$->ins = $2->ins;
           backpatch($2->truelist, $4->ins);
           $$->lineno = $1->lineno;

           //changed here
           //$$->nextlist = merge($2->falselist, $5->nextlist);
              $$->nextlist = $5->nextlist;
              backpatch($2->falselist, instCount+1);
            //change end
            //STE code start
            // current_ste = get_prev_scope(current_ste);  
            //STE code end

            //M3 start
            $$->stack_width = $2->stack_width + $5->stack_width;
            //M3 end

        }
        | if_scope if_expr COLON M suite N else_scope COLON M suite   {  
            $$ = create_node(11, "if_else_stmt", $1,$2, $3, $4, $5, $6, $7, $8, $9, $10);
            $$->lineno = $1->lineno;
            backpatch($2->truelist, $4->ins);
            backpatch($2->falselist, $9->ins);
            vector<int> temp = merge($5->nextlist, $6->nextlist);
            //$$->nextlist = merge(temp, $10->nextlist);
            $$->nextlist = $10->nextlist;
            backpatch(temp,instCount+1);

            //STE code start
            // current_ste = get_prev_scope(current_ste);
            //STE code end

            //M3 start
            $$->stack_width = $2->stack_width + $5->stack_width + $10->stack_width;
            //M3 end

        }
        | if_scope if_expr COLON M suite N nts_star    {  
            $$ = create_node(8, "if_elif_stmt", $1,$2, $3, $4, $5, $6, $7);
            backpatch($2->truelist, $4->ins);
            $$->lineno = $1->lineno;
            backpatch($2->falselist, $7->ins);     
            vector<int> temp = merge($5->nextlist, $6->nextlist);
            //$$->nextlist = merge(temp, $7->nextlist); 
            $$->nextlist= $7->nextlist;
            backpatch(temp,instCount+1);

            //m3 start
            $$->stack_width = $2->stack_width + $5->stack_width + $7->stack_width; 
              
            //m3 end
        }
        | if_scope d_expr COLON suite {
            $$ = create_node(5, "if_stmt", $1, $2, $3, $4);
            $$->ins = $2->ins;

            //m3 start
            $$->stack_width = $4->stack_width;
            //m3 end
        } 
        ;

if_expr: test{
        $$ = $1;
        incheck=0;
    }
    ;

d_expr : D_NAME EQUAL_EQUAL STRING {
            incheck=0;
            string dunder = chartostring($3->addr);
            if(dunder != "\"__main__\""){
                cerr<<"Error: Dunder name should be __main__\n";
                exit(1);
            }
            else{
                $$->ins = instCount;
            }
        }

if_scope: IF{
        $$=$1;
        incheck=1;
        // current_ste = insert_entry_new_scope(current_ste);
        // populate_new_scope(current_ste->prev_scope, "IF", "IF", 0, $1->lineno, 0);
    }
    ;

else_scope: ELSE{
        $$=$1;
        //STE code start
        // current_ste = get_prev_scope(current_ste);
        // current_ste = insert_entry_new_scope(current_ste);
        // populate_new_scope(current_ste->prev_scope, "ELSE", "ELSE", 0, $1->lineno, 1);

        //STE code end
    }
    ;

else_if_scope: ELIF{
        $$=$1;
        incheck=1;
        //STE code start
        // current_ste = get_prev_scope(current_ste);
        // current_ste = insert_entry_new_scope(current_ste);
        // populate_new_scope(current_ste->prev_scope, "ELSE_IF", "ELSE_IF", 0, $1->lineno, 1);
        //STE code end
    }
    ;
    

nts_star : else_if_scope if_expr COLON M suite  {  
            $$=create_node(6, "elif_stmt", $1, $2, $3, $4, $5);
            $$->ins = $2->ins;
            $$->lineno = $1->lineno;
            backpatch($2->truelist, $4->ins);
            //$$->nextlist = merge($2->falselist, $5->nextlist);
            backpatch($2->falselist,instCount+1);
            $$->nextlist = $5->nextlist;

            //STE code start
            // current_ste = get_prev_scope(current_ste);
            //STE code end

            //M3 start
            $$->stack_width = $2->stack_width + $5->stack_width;
            //M3 end
        }
        | else_if_scope if_expr COLON M suite N nts_star  {  
            $$ = create_node(8, "elif_stmt", $1, $2, $3, $4, $5, $6, $7);
            $$->ins = $2->ins;
            $$->lineno = $1->lineno;
            backpatch($2->truelist, $4->ins);
            backpatch($2->falselist, $7->ins);
            //$$->nextlist = merge($5->nextlist, merge($6->nextlist, $7->nextlist));
            backpatch(merge($6->nextlist, $5->nextlist),instCount+1);
            $$->nextlist = $7->nextlist;

            //m3 start
            $$->stack_width = $2->stack_width + $5->stack_width + $7->stack_width;

            //m3 end
        }
        | else_if_scope if_expr COLON M suite N else_scope COLON M suite  {  
            $$ = create_node(11, "elif_else_stmt", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10);
            $$->ins = $2->ins;
            $$->lineno = $1->lineno;
            backpatch($2->truelist, $4->ins);
            backpatch($2->falselist, $9->ins);
            //$$->nextlist = merge($5->nextlist, merge($6->nextlist,$10->nextlist));
            backpatch(merge($6->nextlist,$5->nextlist),instCount+1);
            $$->nextlist = $10->nextlist;

            //STE code start
            // current_ste = get_prev_scope(current_ste);
            //STE code end

            //m3 start
            $$->stack_width = $2->stack_width + $5->stack_width + $10->stack_width;
            //m3 end
        }
        ;
        
while_stmt: while_scope M while_expr COLON M suite   {  
            $$ = create_node(7, "while_stmt", $1, $2, $3, $4, $5, $6);
            $$->ins = $2->ins;
            $$->lineno = $1->lineno;
            //$$->nextlist = $3->falselist;
            create_ins(0, "goto", to_string($2->ins), "", "");
            backpatch($3->truelist, $5->ins);
            backpatch($6->nextlist, instCount+1);
            backpatch($3->falselist, instCount+1);
            //STE code start
            // current_ste = get_prev_scope(current_ste);
            //STE code end

            //M3 start
            $$->stack_width =$3->stack_width + $6->stack_width;
            //M3 end
        }
		| while_scope M while_expr COLON M suite N else_scope COLON M suite  {   
			$$ = create_node(12, "while_else_stmt", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11);
			$$->ins = $2->ins;
            // create_ins(0,$$->return_param,"=",$2->addr,"");
            // create_ins(0,"return",$$->return_param,"","");
            $$->lineno = $1->lineno;
			backpatch($7->nextlist, $2->ins);
			backpatch($6->nextlist, $10->ins);
			backpatch($3->truelist, $5->ins);
			backpatch($3->falselist, $10->ins);
			$$->nextlist = $11->nextlist; //verify //verified 

            //STE code start
            // current_ste = get_prev_scope(current_ste);
            //STE code end

            //m3 start
            $$->stack_width =$3->stack_width+ $6->stack_width + $11->stack_width;
            //m3 end
        }
        ;

while_scope: WHILE {
        $$=$1;
        incheck=1;
        // current_ste = insert_entry_new_scope(current_ste);
        // populate_new_scope(current_ste->prev_scope, "WHILE", "WHILE", 0, $1->lineno, 0);
    }
    ;

while_expr: test   { 
            $$=$1;
            $$->ins = $1->ins;
            iterStack.push($$->addr);
            loopStack.push($$->ins);
            incheck=0;
            // cout<<"out of while_test"<<endl;
        }
        ;
for_stmt: for_scope for_core COLON M suite    { 
            $$ = create_node(6, "for_stmt", $1, $2, $3, $4, $5);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;

            //print
            // cout<<instCount<<endl;
            //print end

            backpatch($2->truelist, $4->ins);
            //removed now
            //$$->nextlist = $2->falselist;   //check this filling //checked

            // create_ins(1, $2->for_it, "+", $2->for_it, "1");
            // backpatch($5->nextlist, instCount); //suite nextlist will be patched to update statement of for loop
            create_ins(1, $2->addr, "+", $2->addr, "1");
            create_ins(0, "goto", to_string($2->ins), "", "");
                //commented one is old
                    //backpatch($5->nextlist, $2->ins); //suite nextlist will be patched to update statement of for loop
                    backpatch($5->nextlist, instCount+1); 
                //end
            backpatch($2->falselist, instCount+1); //ye add karke do entry ho gayi
            
            
            //backpatch($5->nextlist, instCount+1); 

            //STE code start
            // current_ste = get_prev_scope(current_ste);
            //STE code end   


            //M3 start
            $$->stack_width = $2->stack_width + $5->stack_width;
            //m3 end
        }
        | for_scope for_core COLON M suite for_else_N ELSE COLON M suite   { 
            $$ = create_node(11, "for_else_stmt", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;

            $10->nextlist = merge($10->nextlist, makelist(instCount+1));
            create_ins(0, "goto", "", "", "");
            
            // create_ins(1, $2->for_it, "+", $2->for_it, "1");
            backpatch($6->nextlist, instCount+1); 
            backpatch($5->nextlist, instCount+1);
            // backpatch($6->nextlist, $2->ins); 
            // backpatch($5->nextlist, $2->ins);
            create_ins(0, "goto", to_string($2->ins), "", "");

            backpatch($2->truelist, $4->ins);
            backpatch($2->falselist, $9->ins);

            $$->nextlist = $10->nextlist; //verify

            //STE code start
            // current_ste = get_prev_scope(current_ste);
            //STE code end

            //m3 start
            $$->stack_width = $2->stack_width + $5->stack_width + $10->stack_width;

            //m3 end
        }
        ;

for_core: expr IN range_stmt   { 
            
            $$ = create_node(3, "for_core", $1, $2, $3);

            $$->lineno = $1->lineno;


            // create_ins(0, $1->addr, "=", to_string(chartonum($3->for_start)), "");

            create_ins(0, $1->addr, "=", $3->for_start, "");


            // create_ins(0, $1->addr, "=", to_string(chartonum($3->for_start)-1), "");

            // create_ins(1, $1->addr, "+", $1->addr, "1");
            string temp = newTemp();
            create_ins(1, temp, "<", $1->addr, $3->for_end);
            iterStack.push($1->addr);
            loopStack.push(instCount);
            $$->ins = instCount;
            $$->truelist = makelist(instCount+1);
            $$->falselist = makelist(instCount+2);
            create_ins(0, "if", temp, "goto", "");
            create_ins(0, "goto", "", "", "");

            //m3 start
            $$->stack_width = 8 + $1->stack_width + $3->stack_width;
            offset_map[temp]=-stack_offset;
            stack_offset += 8;
            
            $$->addr = $1->addr;
            //m3 end
        }
        ;

for_scope: FOR {
        $$=$1;
        //STE code start
        //loopStack.push($$->ins);
        // current_ste = insert_entry_new_scope(current_ste);
        // populate_new_scope(current_ste->prev_scope, "FOR", "FOR", 0, $1->lineno, 0);
        //STE code end
    }
    ;

range_stmt: RANGE OPEN_BRACKET for_test CLOSE_BRACKET {
            $$ = create_node(5, "range_stmt", $1, $2, $3, $4);
            $$->ins = $3->ins;
            $$->lineno = $1->lineno;
            $$->for_end = $3->addr;
            $$->for_start = strdup("0");

            //m3 start
            $$->stack_width = $3->stack_width;
            //m3 end
        }
        | RANGE OPEN_BRACKET for_test COMMA for_test CLOSE_BRACKET {
            $$ = create_node(7, "range_stmt", $1, $2, $3, $4, $5, $6);
            $$->ins = $3->ins;
            $$->lineno = $1->lineno;
            $$->for_end = $5->addr;
            $$->for_start = $3->addr;
            
            //m3 start
            $$->stack_width = $3->stack_width + $5->stack_width;
            //m3 end
        }
        ;

for_test : test {
            $$=$1;
            $$->ins = $1->ins;
            //loopStack.push($$->ins);
        }
        ;

suite: simple_stmt  {
            $$=$1;
        }
        | NEWLINE INDENT stmt_plus DEDENT   {
            $$=$3;
        }
        | NEWLINE INDENT stmt_plus NEWLINE DEDENT   { 
            $$=$3;
        }
        ;


test: or_test   { 
            $$=$1;
        }
        ;

or_test: and_test    { 
            $$=$1;
        }
        | and_test_star OR M and_test    {  
            $$ = create_node(5, "or_test", $1, $2, $3, $4);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            backpatch($1->falselist, $3->ins);
            $$->truelist = merge($1->truelist, $4->truelist);
            $$->falselist = $4->falselist;

            //m3 start
            $$->stack_width = $1->stack_width + $4->stack_width;
            //m3 end
        }
        ;
and_test_star : and_test_star OR M and_test {
            $$ = create_node(5, "and_test_star", $1, $2, $3, $4);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            backpatch($1->falselist, $3->ins);
            $$->truelist = merge($1->truelist, $4->truelist);
            $$->falselist = $4->falselist;

            //m3 start
            $$->stack_width = $1->stack_width + $4->stack_width;
            //m3 end
        }
        | and_test   { 
            $$=$1;
        }
        ;

and_test: not_test  {
            $$=$1;
        }
        | not_test_star AND M not_test    {  
            $$ = create_node(5, "and_test", $1, $2, $3, $4);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            backpatch($1->truelist, $3->ins);
            $$->falselist = merge($1->falselist, $4->falselist);
            $$->truelist = $4->truelist;

            //m3 start
            $$->stack_width = $1->stack_width + $4->stack_width;
            //m3 end
        }
        ;
not_test_star : not_test_star AND M not_test  { 
            $$ = create_node(5, "not_test_star", $1, $2, $3, $4);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            backpatch($1->truelist, $3->ins);
            $$->falselist = merge($1->falselist, $4->falselist);
            $$->truelist = $4->truelist;

            //m3 start
            $$->stack_width = $1->stack_width + $4->stack_width;
            //m3 end
        }
        | not_test   { 
            $$=$1;
        }
        ;

not_test: NOT not_test   { 
            $$ = create_node(3, "not_test", $1, $2);
            $$->ins = $2->ins;
            $$->lineno = $1->lineno;
            $$->truelist = $2->falselist;
            $$->falselist = $2->truelist;

            //m3 start
            $$->stack_width = $2->stack_width;
            //m3 end
        }
        | comparison    { 
            $$=$1;

            // cout<< "in comp "<<$$->addr<<endl;
            // cout<<"isatom = "<<isatom<<" "<<incheck<<" "<<yytext<<endl;
            if(isatom && incheck && !isinsquare){
                $$->truelist = makelist(instCount+1);
                $$->falselist = makelist(instCount+2);
                create_ins(0, "if", $$->addr, "goto", "");
                // cout<<"checking "<<$$->addr<<endl;
                create_ins(0, "goto", "", "", "");
            }
        }
        | TRUE{
            $$=$1;
            $$->truelist = makelist(instCount+1);
            create_ins(0, "goto", "", "", "");
        }
        | FALSE{
            $$=$1;
            $$->falselist = makelist(instCount+2);
            create_ins(0, "goto", "", "", "");
        }
;

comparison: expr  {
            $$=$1;
            
        }
        | expr comp_op comparison  { 
            $$=create_node(4, "comparison", $1, $2, $3);
            if(incheck) isatom=0;
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            $$->addr = str_to_ch(newTemp());
            // cout<<"checking2 "<<$$->addr<<endl;
            create_ins(1, $$->addr, $2->addr, $1->addr, $3->addr);
            $$->truelist = makelist(instCount+1);
            $$->falselist = makelist(instCount+2);
            $$->atom_type = "bool";
            //typechecking error
               if(($1->atom_type == "str" && $3->atom_type != "str") || ($1->atom_type != "str" && $3->atom_type == "str")){
                    cerr<<"Error: Type mismatch in comparison on line "<<$1->lineno<<"\n";
                    exit(1);
               }
            //typechecking error end
            if(incheck){
                create_ins(0, "if", $$->addr, "goto", "");
                create_ins(0, "goto", "", "", "");
            }

            //m3 start
            $$->stack_width = 8 + $1->stack_width + $3->stack_width;
            offset_map[chartostring($$->addr)]=-stack_offset;
            stack_offset += 8;
            //m3 end
        }
        
;

comp_op: LESS_THAN  {
        $$ = $1;
    }
    | GREATER_THAN  { 
       $$ = $1;
    }
    | EQUAL_EQUAL   { 
        $$ = $1;
    }
    | GREATER_THAN_EQUAL    { 
        $$ = $1;
    }
    | LESS_THAN_EQUAL   {
        $$ = $1;
    }
    | NOT_EQUAL_ARROW   {
        $$ = $1;
    }
    | NOT_EQUAL    {
       $$ = $1;
    }
    | IN    {  
        $$ = $1;
    }
    | NOT IN    { 
        $$ = create_node(3, "NOT IN", $1, $2);
        $$->lineno = $1->lineno;
    }
    | IS    { 
        $$ = $1;
    }
    | IS NOT    { 
        $$ = create_node(3, "IS NOT", $1, $2);
        $$->lineno = $1->lineno;
    }
    ;

expr: xor_expr    { 
            $$=$1;
        }
        | xor_expr BIT_OR expr    {  
            $$ = create_node(4, "expr", $1, $2, $3);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
            //$$->addr = str_to_ch(newTemp());
            //create_ins(1, $$->addr, $2->addr, $1->addr, $3->addr);

            //type_checking
            //Type_checking
            string ret_type=typecast($1->atom_type,$3->atom_type,"|");
            if(ret_type == "Error"){
                cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                exit(1);
            }
            $$->addr = str_to_ch(newTemp());
            if(ret_type != $3->atom_type){
                create_ins(1, $$->addr, "|", $1->addr, str_to_ch(chartostring($3->addr)));
                // create_ins(1, $$->addr, "|", $1->addr, str_to_ch("("+ret_type+")"+chartostring($3->addr)));
                $$->atom_type = $1->atom_type;
            }
            else if(ret_type != $1->atom_type){
                create_ins(1, $$->addr, "|", str_to_ch(chartostring($1->addr)),$3->addr);
                // create_ins(1, $$->addr, "|", str_to_ch("("+ret_type+")"+chartostring($1->addr)),$3->addr);
                $$->atom_type = $3->atom_type;
            }
            else{
                create_ins(1, $$->addr, "|", $1->addr,$3->addr);
                $$->atom_type = $1->atom_type;
            }
            //typecheck end

            //m3 start
            $$->stack_width = 8 + $1->stack_width + $3->stack_width;
            offset_map[chartostring($$->addr)]=-stack_offset;
            stack_offset += 8;
            //m3 end
        }
        ;

xor_expr: and_expr { 
            $$ = $1;
        }
        | and_expr BIT_XOR xor_expr    {  
            $$ = create_node(4, "xor_expr", $1, $2, $3);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            //$$->addr = str_to_ch(newTemp());
            //create_ins(1, $$->addr, $2->addr, $1->addr, $3->addr);

            //type_checking
            //Type_checking
            string ret_type=typecast($1->atom_type,$3->atom_type,"^");
            if(ret_type == "Error"){
                cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                exit(1);
            }
            $$->addr = str_to_ch(newTemp());
            if(ret_type != $3->atom_type){
                create_ins(1, $$->addr, "^", $1->addr, str_to_ch(chartostring($3->addr)));
                // create_ins(1, $$->addr, "^", $1->addr, str_to_ch("("+ret_type+")"+chartostring($3->addr)));
                $$->atom_type = $1->atom_type;
            }
            else if(ret_type != $1->atom_type){
                create_ins(1, $$->addr, "^", str_to_ch(chartostring($1->addr)),$3->addr);
                // create_ins(1, $$->addr, "^", str_to_ch("("+ret_type+")"+chartostring($1->addr)),$3->addr);
                $$->atom_type = $3->atom_type;
            }
            else{
                create_ins(1, $$->addr, "^", $1->addr,$3->addr);
                $$->atom_type = $1->atom_type;
            }
            //typecheck end

            //m3 start
            $$->stack_width = 8 + $1->stack_width + $3->stack_width;
            offset_map[chartostring($$->addr)]=-stack_offset;
            stack_offset += 8;
            //m3 end
        }
        ;

and_expr: shift_expr   { 
            $$ = $1;
            
        }
        | shift_expr BIT_AND and_expr   {  
            $$ = create_node(4, "and_expr", $1, $2, $3);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            //$$->addr = str_to_ch(newTemp());
            //create_ins(1, $$->addr, $2->addr, $1->addr, $3->addr);
            
            //type_checking
                //Type_checking
                string ret_type=typecast($1->atom_type,$3->atom_type,"&");
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                $$->addr = str_to_ch(newTemp());
                if(ret_type != $3->atom_type){
                    create_ins(1, $$->addr, "&", $1->addr, str_to_ch(chartostring($3->addr)));
                    // create_ins(1, $$->addr, "&", $1->addr, str_to_ch("("+ret_type+")"+chartostring($3->addr)));
                    $$->atom_type = $1->atom_type;
                }
                else if(ret_type != $1->atom_type){
                    create_ins(1, $$->addr, "&", str_to_ch(chartostring($1->addr)),$3->addr);
                    // create_ins(1, $$->addr, "&", str_to_ch("("+ret_type+")"+chartostring($1->addr)),$3->addr);
                    $$->atom_type = $3->atom_type;
                }
                else{
                    create_ins(1, $$->addr, "&", $1->addr,$3->addr);
                    $$->atom_type = $1->atom_type;
                }
            //typecheck end

            //m3 start
            $$->stack_width = 8 + $1->stack_width + $3->stack_width;
            offset_map[chartostring($$->addr)]=-stack_offset;
            stack_offset += 8;
            //m3 end
        }
        ;

shift_expr: arith_expr   { 
                $$ = $1; 
            }
            | arith_expr SHIFT_OPER shift_expr   { 
                $$ = create_node(4, "shift_expr", $1, $2, $3);
                $$->ins = $1->ins;
                $$->lineno = $1->lineno;
                // $$->addr = str_to_ch(newTemp());
                // create_ins(1, $$->addr, $2->addr, $1->addr, $3->addr);

                //Type_checking
                string ret_type=typecast($1->atom_type,$3->atom_type,$2->addr);
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                if(ret_type != $3->atom_type){
                    $$->addr = str_to_ch(newTemp());
                    create_ins(1, $$->addr, $2->addr, $1->addr, str_to_ch(chartostring($3->addr)));
                    // create_ins(1, $$->addr, $2->addr, $1->addr, str_to_ch("("+ret_type+")"+chartostring($3->addr)));
                    $$->atom_type = $1->atom_type;
                }
                else if(ret_type != $1->atom_type){
                    $$->addr = str_to_ch(newTemp());
                    create_ins(1, $$->addr, $2->addr, str_to_ch(chartostring($1->addr)), $3->addr );
                    // create_ins(1, $$->addr, $2->addr, str_to_ch("("+ret_type+")"+chartostring($1->addr)), $3->addr );
                    $$->atom_type = $3->atom_type;
                }
                else{
                    $$->addr = str_to_ch(newTemp());
                    create_ins(1, $$->addr, $2->addr, $1->addr,$3->addr);
                    $$->atom_type = $1->atom_type;
                }
            //typecheck end

            //m3 start
            $$->stack_width = 8 + $1->stack_width + $3->stack_width;
            offset_map[chartostring($$->addr)]=-stack_offset;
            stack_offset += 8;
            //m3 end
            }
        ;

arith_expr: term { 
                $$ = $1;
            }
            | arith_expr PLUS term { 
                
                $$ = create_node(4, "arith_expr", $1, $2, $3);
                $$->ins = $1->ins;
                $$->lineno = $1->lineno;
                //$$->addr = str_to_ch(newTemp());
                //create_ins(1, $$->addr, $2->addr, $1->addr, $3->addr);
                //type_checking
                //Type_checking
                string ret_type=typecast($1->atom_type,$3->atom_type,"+");
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                if(ret_type != $3->atom_type){
                    //string temp = newTemp(); 
                    $$->addr = str_to_ch(newTemp()); 
                    create_ins(1, $$->addr, "+", $1->addr,str_to_ch(chartostring($3->addr)));
                    // create_ins(1, $$->addr, "+", $1->addr,str_to_ch("("+ret_type+")"+chartostring($3->addr)));
                    $$->atom_type = $1->atom_type;
                }
                else if(ret_type != $1->atom_type){
                    //string temp = newTemp();
                    $$->addr = str_to_ch(newTemp()); 
                    create_ins(1, $$->addr, "+", str_to_ch(chartostring($1->addr)),$3->addr);
                    // create_ins(1, $$->addr, "+", str_to_ch("("+ret_type+")"+chartostring($1->addr)),$3->addr);
                    $$->atom_type = $3->atom_type;
                }
                else{
                    //string temp = newTemp();
                    $$->addr = str_to_ch(newTemp()); 
                    create_ins(1, $$->addr, "+", $1->addr,$3->addr);
                    $$->atom_type = $1->atom_type;
                }
                //typecheck end

                //m3 start
                $$->stack_width = 8 + $1->stack_width + $3->stack_width;
                offset_map[chartostring($$->addr)]=-stack_offset;
                stack_offset += 8;
                //m3 end
            }
            | arith_expr MINUS term { 
                $$ = create_node(4, "arith_expr", $1, $2, $3);
                $$->ins = $1->ins;
                $$->lineno = $1->lineno;
                //$$->addr = str_to_ch(newTemp());
                //create_ins(1, $$->addr, $2->addr, $1->addr, $3->addr);

                //type_checking
                //Type_checking
                string ret_type=typecast($1->atom_type,$3->atom_type,"-");
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                if(ret_type != $3->atom_type){
                    //string temp = newTemp();
                    $$->addr = str_to_ch(newTemp());
                    create_ins(1, $$->addr, "-", $1->addr,str_to_ch(chartostring($3->addr)));
                    // create_ins(1, $$->addr, "-", $1->addr,str_to_ch("("+ret_type+")"+chartostring($3->addr)));
                    $$->atom_type = $1->atom_type;
                }
                else if(ret_type != $1->atom_type){
                    //string temp = newTemp();
                    $$->addr = str_to_ch(newTemp());
                    create_ins(1, $$->addr, "-", str_to_ch(chartostring($1->addr)),$3->addr);
                    // create_ins(1, $$->addr, "-", str_to_ch("("+ret_type+")"+chartostring($1->addr)),$3->addr);
                    $$->atom_type = $3->atom_type;
                }
                else{
                    //string temp = newTemp();
                    $$->addr = str_to_ch(newTemp());
                    create_ins(1, $$->addr, "-", $1->addr,$3->addr);
                    $$->atom_type = $1->atom_type;
                }
            //typecheck end
                //m3 start
                $$->stack_width = 8 + $1->stack_width + $3->stack_width;
                offset_map[chartostring($$->addr)]=-stack_offset;
                //cout<<offset_map["t0"]<<endl;
                stack_offset += 8;
                //m3 end
            }
        ;
term: factor {
            $$ = $1; 
        }
        | term term_choice factor {
            $$ = create_node(4, "term", $1, $2, $3);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            // $$->addr = str_to_ch(newTemp());
            // create_ins(1, $$->addr, $2->addr, $1->addr, $3->addr);

            //type_checking
                //Type_checking
                string ret_type=typecast($1->atom_type,$3->atom_type,$2->addr);
                //cout<<$1->atom_type<<" "<<$3->atom_type<<" "<<ret_type<<endl;
                if(ret_type == "Error"){
                    cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                if(ret_type != $3->atom_type){
                    //string temp = newTemp();
                    $$->addr = str_to_ch(newTemp());
                    create_ins(1, $$->addr, $2->addr, $1->addr,str_to_ch(chartostring($3->addr)));
                    // create_ins(1, $$->addr, $2->addr, $1->addr,str_to_ch("("+ret_type+")"+chartostring($3->addr)));
                    $$->atom_type = $1->atom_type;
                }
                else if(ret_type != $1->atom_type){
                    //string temp = newTemp();
                    $$->addr = str_to_ch(newTemp());
                    create_ins(1, $$->addr, $2->addr, str_to_ch(chartostring($1->addr)),$3->addr);
                    // create_ins(1, $$->addr, $2->addr, str_to_ch("("+ret_type+")"+chartostring($1->addr)),$3->addr);
                    $$->atom_type = $3->atom_type;
                }
                else{
                    //string temp = newTemp();
                    $$->addr = str_to_ch(newTemp());
                    create_ins(1, $$->addr, $2->addr, $1->addr,$3->addr);
                    $$->atom_type = $1->atom_type;
                }
            //typecheck end

            //m3 start
            $$->stack_width = 8 + $1->stack_width + $3->stack_width;
            offset_map[chartostring($$->addr)]=-stack_offset;
            stack_offset += 8;
            //m3 end
        
		}
        ;

term_choice : MULTIPLY      { 
            $$ = $1;
        }
        |ATTHERATE      { 
            $$ = $1;
        }
        |DIVIDE         { 
            $$ = $1;
        }
        |REMAINDER      { 
            $$ = $1;
        }
        |FLOOR_DIV_OPER    { 
            $$ = $1;
        }
        ;

factor: factor_choice factor        {  
            $$ = create_node(3, "factor", $1, $2);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            $$->addr = str_to_ch(newTemp());
            $$->atom_type = $2->atom_type;
            create_ins(1, $$->addr, $1->addr,"", $2->addr);

            if($2->atom_type=="str"){
                cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                exit(1);
            }

            //m3 start
            $$->stack_width = 8 + $2->stack_width;
            offset_map[chartostring($$->addr)]=-stack_offset;
            stack_offset += 8;
            //m3 end
        }
        | power     { 
            $$ = $1;
        }
        ;
factor_choice : PLUS        {
            $$=$1;
        }
        | MINUS      { 
            $$=$1;
        }
        | NEGATION   { 
            $$=$1;
        }
        ;
power: atom_expr        { 
            $$ = $1;
        }
        | atom_expr POWER_OPERATOR factor   { 
            $$ = create_node(4, "power", $1, $2, $3);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            $$->addr = str_to_ch(newTemp());
            create_ins(1, $$->addr, $2->addr, $1->addr, $3->addr);

            if($1->atom_type=="str" || $3->atom_type=="str"){
                cerr<<"Error: Type mismatch in assignment on line "<<$1->lineno<<"\n";
                exit(1);
            }

            //m3 start
            $$->atom_type = $1->atom_type;
            $$->stack_width = 8 + $1->stack_width + $3->stack_width;
            offset_map[chartostring($$->addr)]=-stack_offset;
            stack_offset += 8;
            //m3 end
        }
        ;

atom_expr: atom {  
            $$ = $1;  
        }
        | atom_expr trailer {   //this is function call
            $$ = create_node(3, "atom_expr", $1, $2);
            $$->ins = $1->ins;
            $$->lineno = $1->lineno;
            string temp = newTemp();
            $$->addr = str_to_ch(temp);
            //create_ins(0, temp, "=" ,"call "+chartostring($1->addr), "");
            // create_ins(0,"call",chartostring($1->addr),"","");
            // create_ins(0,"PopParamAll",to_string($2->num_params),"","");
            // create_ins(0, "PopParamra", temp, "", "");
            backpatch($2->nextlist, instCount);

            ste* function_ste = new ste;
            if(chartostring($1->type) == "self_call"){
                ste* lookup_ste = lookup(current_ste, $1->class_param);
                function_ste=lookup_ste;
                //print_ste(global_sym_table,0);
                if(lookup_ste == NULL){
                    cerr<<"Error: Function in selfcall "<<$1->class_param<<" not declared in class on line "<< $1->lineno <<"\n";
                    exit(1);
                }

                create_ins(0,"call","self",chartostring($1->addr),"");
                create_ins(0,"PopParamAll",to_string($2->num_params),"","");
                create_ins(0, "PopParamra", temp, "", "");
                $$->atom_type = lookup_ste->return_type;
            }
            
            else if(chartostring($1->type) == "class_call"){ //cerr<<$1->addr<<endl;
                string class_name = "";
                int i=0;
                while($1->addr[i] != '.'){
                    class_name.push_back($1->addr[i]);
                    i++;
                }

                if(class_map.find(class_name) == class_map.end()){
                    cerr<<"Error: Class "<<class_name<<" not declared on line "<<$1->lineno<<"\n";
                    exit(1);
                }
                ste* class_ste = class_map[class_name];
                    //cout<<"atom_exprr: class call "<<class_name<<endl;
            
                  //here
                    ste* lookup_ste = single_rev_lookup(class_ste->next_scope, $1->class_param); 
                    if(lookup_ste == NULL){
                        lookup_ste = lookup(class_ste->next_scope, $1->class_param);
                    }
                    if(lookup_ste == NULL){
                        cerr<<"Error: Function "<<$1->class_param<<" not declared in class "<<class_name<<" at line "<<$1->lineno<<"\n";
                        exit(1);
                    }

 create_ins(0,"call","class_func",class_name,"");  
 create_ins(0,"PopParamAll",to_string($2->num_params),"","");          

                    //print_ste(lookup_ste,0);
                    //cout<<lookup_ste->type<<endl;
                    // if(lookup_ste->type != "FUNCTION"){
                    //     cerr<<"Error: "<<$1->class_param<<" is not a function\n";
                    //     exit(1);
                    // }
                    //cout<< lookup_ste->return_type<< "in classfunc"<<endl;
                    function_ste=lookup_ste;
                    $$->atom_type = lookup_ste->return_type;
                    //cout<<$$->atom_type<<endl;
                
            }
            else if(chartostring($1->type) == "object_call"){ 
                $$->type = str_to_ch("object_call");
                //cout<<"in object call"<<endl;
                //typecheck handle
                string object_name = "";
                int i=0;
                while($1->addr[i] != '.'){
                    object_name.push_back($1->addr[i]);
                    i++;
                }
                i++;
                ste* lookup_ste = lookup(current_ste, object_name);
                if(class_map.find(lookup_ste->type) == class_map.end()){
                    cerr<<"Error: Class "<<lookup_ste->type<<" not declared in line "<<$1->lineno<<"\n";
                    exit(1);
                }
                else{
                    lookup_ste = class_map[lookup_ste->type];
                }
                string func_name = "";
                while($1->addr[i] != '\0'){
                    func_name.push_back($1->addr[i]);
                    i++;
                } 
                //cout<<"function name: "<<func_name<<endl;
                //single rev matlab usi scope me dekhega, hume usi me chahiye kyuki
                lookup_ste = lookup_ste->next_scope;
                ste* lookup_ste2 = single_rev_lookup(lookup_ste, func_name);
                if(lookup_ste2 == NULL){
                    lookup_ste2 = lookup(lookup_ste, func_name);
                }
                if(lookup_ste2 == NULL){
                    cerr<<"Error: Function "<<func_name<<" not declared in object "<<object_name<<" at line "<<$1->lineno<<"\n";
                    exit(1);
                }
                else{
                    if(lookup_ste2->type != "FUNCTION"){
                        cerr<<"Error: "<<func_name<<" is not a function, line: "<<$1->lineno<<"\n";
                        exit(1);
                    }
                    function_ste=lookup_ste2;
                    $$->atom_type = lookup_ste2->return_type;
                }

                create_ins(0,"call","obj",chartostring($1->addr),"");
                create_ins(0,"PopParamAll",to_string($2->num_params),"","");
                create_ins(0, "PopParamra", temp, "", "");

            }
            else if(chartostring($1->type) == "class_constructor"){ 
                //LALRparser(self,"abc") is type wale
                $$->type = str_to_ch("class_constructor");

                //// cout<<"check: "<<$1->addr<<endl;
                $$->atom_type = ($1->addr);
                //// cout<<$$->atom_type<<endl;
                // $$->atom_type = "object";


                //add 3ac for calling constructor if required// I think it will be in test colon test equal eqtes

                //see that the parameters passed are correct and type checking
                ste* lookup_ste;
                if(class_map.find(chartostring($1->addr))==class_map.end()){
                    cerr<<"Error: Class "<<$1->addr<<" not declared on line "<<$1->lineno<<"\n";
                }
                else{
                    lookup_ste=class_map[chartostring($1->addr)];
                }
                lookup_ste=single_rev_lookup(lookup_ste->next_scope,"__init__");
                if(lookup_ste == NULL){ 
                    function_ste->num_params = 0;
                }
                else{
                    function_ste=lookup_ste;
                } 
                create_ins(0,"call","class",chartostring($1->addr),"");
                create_ins(0,"PopParamAll",to_string($2->num_params),"","");
                // create_ins(0, "PopParamra", temp, "", "");
            }
            else{ 
            //typecheck
                $$->type = str_to_ch("function_call");
                ste* lookup_ste = lookup(current_ste, $1->addr);
                // cout<<"in";
                if(lookup_ste == NULL){ //print_ste(current_ste,2);
                    
                    cerr<<"Error: Function "<<$1->addr<<" not declared on line "<<$1->lineno<<"\n";
                    exit(1);
                } //else wala part is by chatgpt
                else{
                    //Type_checking
                    //cout<<lookup_ste->type<<endl;
                    if(lookup_ste->type != "FUNCTION"){
                        cerr<<"Error: "<<$1->addr<<" is not a function at line "<<$1->addr<<"\n";
                        exit(1);
                    }
                    function_ste=lookup_ste;
                    $$->atom_type = lookup_ste->return_type;
                    // cout<<"in atm_func"<<endl;
                    //cout<<function_ste->num_params<<endl;
                }
                create_ins(0,"call","function",chartostring($1->addr),"");
                create_ins(0,"PopParamAll",to_string($2->num_params),"","");
                create_ins(0, "PopParamra", temp, "", "");
            }
            //endtypecheck

            //function ke parameters ka type check idhar 
            //cout<<$2->func_par_type.size()<<" "<<function_ste->func_par_type.size()<<endl;
            if(function_ste->num_params != $2->num_params){ 
                //cout<<"Checking number of parameters: "<<function_ste->num_params<<" "<<$2->num_params<<endl;
                cerr<<"Error: Number of parameters mismatch on line "<<$1->lineno<<"\n";
                exit(1);
            }
            //cout<<"para check start"<<endl;
            for(int i=0;i< $2->func_par_type.size();i++){ //cout<<function_ste->func_par_type.size()<<endl;
                //cout<<$2->func_par_type[i]<<" "<< function_ste->func_par_type[i]<<endl;
                if($2->func_par_type[i] != function_ste->func_par_type[i]){
                    cerr<<"Error: Mismatch of a parameter in function: "<<function_ste->lexeme<<" at line "<<$1->lineno<<"\n";
                    exit(1);
                }
            }
            //cout<<"para check end"<<endl;

            //m3 start
            $$->stack_width = 8 + $1->stack_width;
            offset_map[temp]=-stack_offset;
            stack_offset += 8;
            //m3 end

        }
        | atom_expr SQUARE_OPEN S test SQUARE_CLOSE{   //array access
            $$ = create_node(6, "atom_expr", $1, $2, $3, $4, $5);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
  
            ste* function_ste = new ste;
            // if(chartostring($1->type) == "self_call"){
            //     ste* lookup_ste = lookup(current_ste, $1->class_param);
            //     function_ste=lookup_ste;
            //     create_ins(1,$$->addr,"*",$4->addr,"8");
            //     $$->addr = str_to_ch(chartostring($1->addr) + "["+chartostring($$->addr)+"]");
            // }
  
 //changes here too and ek baar poora atom_expr DOT NAME compare karke update kar dena
            //$$->atom_type= $1->atom_type; //check this
            string temp = str_to_ch(newTemp());
            $$->addr = str_to_ch(temp);
            //cout<<"in atom_expr "<<temp<<endl;
            // create_ins(1, $$->addr, "*", $4->addr, to_string(get_width(lookup(current_ste, $1->addr)->type)));
            create_ins(1, $$->addr, "*", $4->addr,"8");
            
            $$->addr = str_to_ch(chartostring($1->addr) + "["+chartostring($$->addr)+"]");

//till here some changes were made
//added this
        int i=0;
        string array_type="";
        while($1->type[i] != '['){
            i++;
        }
        i++;
        while($1->type[i] != ']'){
            array_type.push_back($1->type[i]);
            i++;
        }
        if($4->atom_type != "int"){
            cerr<<"Error: Array index is not an integer at line "<<$1->lineno<<"\n";
            exit(1);
        }
        $$->atom_type = array_type;


//till here


//commented this

            //typechecking handle and $$->atom_type also
            // $$->type= str_to_ch("array_element");
            // cerr<<$1->class_param<< " yes"<<endl;
            // ste* lookup_ste = lookup(current_ste, $1->class_param);
            // // cerr<<"no"<<endl;
            // int i=0;
            // string array_type="";
            // while(lookup_ste->type[i] != '['){
            //     i++;
            // }
            // i++;
            // while(lookup_ste->type[i] != ']'){
            //     array_type.push_back(lookup_ste->type[i]);
            //     i++;
            // }
            // if($4->atom_type != "int"){
            //     cerr<<"Error: Array index is not an integer at line "<<$1->lineno<<"\n";
            //     exit(1);
            // }
            // $$->atom_type = array_type;

//till here


            //cout<<$$->atom_type<<endl;
             //check this suppose a[2] hai to hum a ka type dekhenge

             //m3 start
            $$->stack_width = 8 + $1->stack_width + $4->stack_width;
            offset_map[temp]=-stack_offset;
            stack_offset += 8;
            isinsquare=0;
            //m3 end

        }
        | atom_expr DOT NAME { 
            // cout<<"symbol table in atom_expr"<<endl; 
            // print_ste(global_sym_table,0);
            $$ = create_node(4, "atom_expr", $1, $2, $3);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
            $$->addr = str_to_ch(chartostring($1->addr) + "." + chartostring($3->addr));

            //typechecking handle and $$->addtype also

            //for objects like in sirs testcase3 obj.print_name() or obj.x 
            ste*  lookup_ste = lookup(current_ste, $1->addr);
            if(lookup_ste == NULL){
                cerr<<"Error: Object "<<$1->addr<<" not declared at line "<<$1->lineno<<"\n";
                exit(1);
            }
            //cout<<lookup_ste->token<<endl;
             if(lookup_ste -> token == "OBJECT"){ 
                $$->type = str_to_ch("object_call");
                //see what else to do
                lookup_ste = class_map[obj_class[chartostring($1->addr)]];
                ste* lookup_ste1 = single_rev_lookup(lookup_ste->next_scope, $3->addr);
                if(lookup_ste1 == NULL){
                    lookup_ste1 = lookup(lookup_ste,$3->addr);
                }
                if(lookup_ste1 != NULL){ 
                    $$->atom_type = lookup_ste1->type;
                    $$->class_param = $3->addr;
                }
            }
            //here it ends
            else{
                $$->type = str_to_ch("class_call");
                //cout<<$1->addr<<endl; 
                //print_ste(global_sym_table,0);
                //here also should I check using class map? may be no because abhi jaha current_ste hai waha se kuch class shyd access na ho paye 
                ste* lookup_ste = lookup(current_ste, $1->addr);
                if(lookup_ste == NULL){
                    cerr<<"Error: Class "<<$1->addr<<" not declared on line "<<$1->lineno<<"\n";
                    exit(1);
                } //else wala part is by chatgpt
                else{
                    //Type_checking
                    if(lookup_ste->type != "CLASS"){ //public3 wala part me lalrparser ka type yaha khali aa rha check
                        //cout<<"check "<<lookup_ste->lexeme<<" "<<lookup_ste->type<<endl;
                        lookup_ste = lookup(current_ste, lookup_ste->type);
                        //cout<<"check lexeme "<<lookup_ste->lexeme<<endl;
                        //why we are setting $$->addr again
                        $$->addr = str_to_ch(lookup_ste->lexeme + "." + chartostring($3->addr));
                    }
                    $$->class_param = ($3->addr);
                    //we need to get atom_type here, //it will be only for already defined
                    //function wale ka to upar trailer me jaake set ho jayega, yaha pe hume sirf normal wale ka nikalna hoga (kisi object ka)
                }
            }

            //m3 start pending $$->atom_type in else
                //$$->stack_width = get_width($3->atom_type) + $1->stack_width;
            //m3 end
            
            //add this
            ste* lookup_ste2 = lookup(current_ste,$1->addr);
            if(lookup_ste2 ->token == "OBJECT"){  
                string classname= lookup_ste2 -> type;
                lookup_ste2 = class_map[classname]; //symboltable entry of class
                ste* attribute = single_rev_lookup(lookup_ste2->next_scope,$3->addr);
                if(attribute == NULL){ 
                    attribute = lookup(lookup_ste2,$3->addr);  
                }
                if(attribute!= NULL){  
                    $$->atom_type = attribute->type;
                }
                else{
                    cerr<<"Error: "<<$3->addr<<" not declared in class of object "<<$1->addr<<endl;
                    exit(1);
                }
            }
            //add this


        }
        | LEN OPEN_BRACKET test CLOSE_BRACKET { 
            $$ = create_node(5, "atom_expr", $1, $2, $3, $4);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
            //$$->addr = str_to_ch("len("+chartostring($3->addr)+")");
            $$->atom_type = "int";
            int list_size;

            if(chartostring($3->type) == "NAME"){
                    ste* lookup_ste = lookup(current_ste, $3->addr);
                    if(lookup_ste == NULL){
                        cerr<<"Error: List "<<$3->addr<<" not declared at line "<<$3->lineno<<"\n";
                        exit(1);
                    }
                }
            else{
                if($3->atom_type != "list[int]" && $3->atom_type != "list[float]" && $3->atom_type != "list[str]" && $3->atom_type != "list[bool]"){
                    cerr<<"Error: len() can only be applied to list of int, float, str or bool at line "<<$3->lineno<<"\n";
                    exit(1);
                }
            }

            // if($3->type == str_to_ch("NAME")){
            //     ste* lookup_ste = lookup(current_ste, $3->addr);
            //     list_size = lookup_ste->list_size;
            // }
            // else{    
            //     list_size = $3->list_size;
            // }
            create_ins(0, "call", "len", $3->addr, "");
            string temp = newTemp();
            create_ins(0, "PopParamra", temp, "","");
            $$->addr = str_to_ch(temp);

            $$->stack_width = 8 + $2->stack_width;
            offset_map[temp]=-stack_offset;
            stack_offset += 8;

        }
        | PRINT OPEN_BRACKET test CLOSE_BRACKET { 
            $$ = create_node(5, "atom_expr", $1, $2, $3, $4);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
            //$$->addr = str_to_ch("print("+chartostring($3->addr)+")");
            $$->atom_type = "None";
            // create_ins(0, "PushParam", $3->addr, "", "");


            if($3->atom_type == "str"){
                create_ins(0, "call", "printstr", $3->addr, "");
            }
            else{
                create_ins(0, "call", "print", $3->addr, "");
            }


            //create_ins(0, "call", "print", $3->addr, "");


            // create_ins(0, "PopParamAll", "1", "", "");

            //m3 start
            $$->stack_width = $3->stack_width;
            //m3 end
        }
        | SELF DOT NAME {
            $$ = create_node(4, "atom_expr", $1, $2, $3);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
            $$->addr = str_to_ch("self."+chartostring($3->addr));

            $$->type = str_to_ch("self_call");

            ste* lookup_ste = lookup(current_ste, $3->addr);
            //include error rule
            $$->class_param = $3->addr;
            
            //we need to get atom_type here, 
            //function wale ka to upar trailer me jaake set ho jayega, yaha pe hume sirf normal wal eka nikalna hoga
            ste* lookup_ste2 = lookup(current_ste,"self");
            string classname= lookup_ste2 -> token;
            lookup_ste2 = class_map[classname];
            //print_ste(lookup_ste2,0);
            ste* attribute = single_rev_lookup(lookup_ste2->next_scope,$3->addr);     //FOR INHERITANCE
            if(attribute == NULL){
                attribute = lookup(lookup_ste2,$3->addr);
            }
            if(attribute!= NULL){ 
                $$->atom_type = attribute->type;
            }
            //cout<<"self dot name: "<< $$->atom_type<<endl;

        }
        ;

S: %empty   {
    isinsquare=1;
}
;
//Removed some rules form atom, I dont think they are required
atom: 
    OPEN_BRACKET testlist CLOSE_BRACKET  { 
        $$=$2;      
        incheck=0;
    }
    | OPEN_BRACKET CLOSE_BRACKET    {
        $$ = create_node(3, "atom", $1, $2);
        $$->lineno = $1->lineno;
        $$->ins = instCount+1;
    }
    
    | SQUARE_OPEN S testlist SQUARE_CLOSE    { 
        $$ = $3;
        isinsquare=0;
        $$->atom_type = "list["+$3->atom_type+"]";
        string type = "";
        int i=0;
        while($3->atom_type[i] != '['){
            i++;
        }
        i++;
        while($3->atom_type[i] != ']'){
            type.push_back($3->atom_type[i]);
            i++;
        }
        create_ins(0,"Heapalloc", to_string($3->list_size), "", "");
        funcOffset += get_width(type) * $3->list_size;
    }
    | SQUARE_OPEN S SQUARE_CLOSE  {
        $$ = create_node(4, "atom", $1, $2, $3);
        $$->lineno = $1->lineno;
        $$->ins = instCount+1;
        isinsquare=0;
    }

    | CURLY_OPEN CURLY_CLOSE    { 
        $$ = create_node(3, "atom", $1, $2);
        $$->lineno = $1->lineno;
        $$->ins = instCount+1;
    }
    | 
    NAME      {
        if(incheck) isatom=1;
        $$->type = str_to_ch("NAME");  //is this required?
        $$ = $1;
        $$->ins = instCount+1;

        //cout<< $1->addr<<endl;
        //here we are adding the atom_type if it exists in the symbol table
        ste* lookup_ste = lookup(current_ste, $1->addr);
        //cout<< $1->addr<<endl;
        if( lookup_ste ){
            if(lookup_ste->is_func_class){  //class will not be parsed from here
                $$->atom_type = lookup_ste->return_type;
            }
            else{
                $$->atom_type = lookup_ste->type;
            }
        }
        //is else required

        //for constructor part I am adding here 
        string class_name = "";
        if(class_map.find(chartostring($1->addr)) != class_map.end()){
            class_name = chartostring($1->addr);
            $$->type = str_to_ch("class_constructor");
            // $$->atom_type = "object";
            $$->atom_type = ($1->addr);
        }
    }
    | NUMBER       { 
        if(incheck) isatom=1;
        $$ = $1;
        $$->ins = instCount+1;
        // cout<<$$->atom_type<<endl;
    }
    | STRING_PLUS       { 
       $$ = $1;
    }
    | ATOM_KEYWORDS     { 
        if(incheck) isatom=1;
        $$->atom_type="bool";
        $$->type=str_to_ch("bool");
        $$ = $1;
        $$->ins = instCount+1;
    }
    | NONE      { 
        $$ = $1;
        $$->ins = instCount+1;
        $$->atom_type="None";
    }
    /* | SELF {
        $$ = $1;
        $$->ins = instCount+1;
        $$->atom_type="self";
    } */
    ;
STRING_PLUS: STRING     {
            $$ = $1;
			$$->ins = instCount+1;
            $$->type=str_to_ch("str");
            $$->atom_type="str";

            //m3 start
            //cout<<$1->addr<<endl;
            $$->str_len = chartostring($1->addr).size()-2;
            //cout<<$$->str_len<<endl;
            //m3 end
        }
        | STRING STRING_PLUS    { 
            $$ = create_node(3, "STRING_PLUS", $1, $2);
            $$->lineno = $1->lineno;
            $$->ins = $2->ins;
            $$->atom_type="str";
            $$->type=str_to_ch("str");

            //m3 start
            $$->str_len = $1->str_len + $2->str_len;
            //m3 end

        }
        ;

trailer: OPEN_BRACKET CLOSE_BRACKET  { 
            $$ = create_node(3, "trailer", $1, $2);
            $$->lineno = $1->lineno;
            $$->ins = instCount+1;

            create_ins(0, "PushParamra", "", "", "");
            $$->nextlist = makelist(instCount);
        }
        | OPEN_BRACKET arglist CLOSE_BRACKET  {
            $$=$2;

            //func_par_type
            $$->func_par_type = $2->func_par_type;
        }
        | OPEN_BRACKET SELF COMMA arglist CLOSE_BRACKET  {
            $$=$4;

            //func_par_type
            $$->func_par_type = $4->func_par_type;
        }
        | OPEN_BRACKET SELF CLOSE_BRACKET {
            $$ = create_node(4, "trailer", $1, $2, $3);
            $$->lineno = $1->lineno;
            $$->ins = instCount+1;
        }
        ;

 /* trailer2: SQUARE_OPEN test SQUARE_CLOSE{
            $$=$2;
            
        }
        ; */

testlist: testlist_list    { 
            //cout<<$1->atom_type<<endl; 
            $$ = $1;
            if(isinsquare) $$-> addr = str_to_ch(chartostring($1->addr) + "]");
            else $$-> addr = $1->addr;
        }
        | testlist_list COMMA   {
            $$=create_node(3,"testlist",$1,$2);
            $$->lineno = $1->lineno;
            $$->ins = $1 -> ins;
            $$->list_size = $1->list_size;
            $$->atom_type = $1->atom_type;
            if(isinsquare) $$-> addr = str_to_ch(chartostring($1->addr) + "]");
            else $$-> addr = $1->addr;

            //M3 start
            $$->stack_width = $1->stack_width;
            //M3 end
        }
        ;
testlist_list: test         {
            $$ = $1;
            $$->list_size = 1;
            if(isinsquare){
                $$-> addr = str_to_ch( "[" + chartostring($1->addr));
                $$->list_par_type.push_back($1->atom_type);
            }
            else $$-> addr = $1->addr;
            

            // //function parameters check 
            // $$->func_par_type.push_back($1->atom_type);
        }
        | test COLON TYPE_HINT{
            $$ = create_node(4, "testlist_list", $1, $2, $3);
            $$->addr = $1->addr;
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
            $$->list_size = 1;
            $1->atom_type = $3->addr;
            //$$->atom_type = "list["+$1->atom_type+"]"; //ye kyu kia hai bc
            $$->atom_type = $3->addr; //ye karke wo lassi wla test case pass hua
            //STE code start
            ste* lookup_ste = current_ste;
            if(lookup(lookup_ste, $1->addr) == NULL){
                current_ste = insert_entry_same_scope(current_ste, "VARIABLE", $1->addr, $3->addr, $1->lineno, 1);
            }
            else{
                cerr<<"Error: Variable "<<$1->addr<<" already declared at line "<<lookup(lookup_ste, $1->addr)->lineno<<"\n";
                exit(1);
            }
            //STE code end

            // //function parameters check 
            // $$->func_par_type.push_back(chartostring($3->addr));

            //m3 start
            $$->stack_width = 8 + $1->stack_width;
            offset_map[chartostring($1->addr)] = -stack_offset;
            stack_offset += 8;
            //m3 end

        }
        | testlist_list COMMA test  { 
            $$ = create_node(4, "testlist_list", $1, $2, $3);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
            $$->list_size = $1->list_size + 1;
            //cout<<$1->addr<<endl;
            $$-> addr = str_to_ch(chartostring($1->addr) + "," + chartostring($3->addr));
            $$->atom_type = $1->atom_type;
            //$$->atom_type = "list["+$3->atom_type+"]";
            //cout<<$$->addr<<endl;
            // cout<<$3->atom_type<<endl;

            $$->list_par_type = $1->list_par_type;
            $$->list_par_type.push_back($3->atom_type);

            // //function parameters check 
            // $$->func_par_type = $1->func_par_type;
            // $$->func_par_type.push_back($3->atom_type);

            //m3 start
            $$->stack_width = $1->stack_width + $3->stack_width;
            //m3 end
        }
        | testlist_list COMMA test COLON TYPE_HINT { 
            $$ = create_node(6, "testlist_list", $1, $2, $3, $4, $5);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;

            $3->atom_type = $5->addr;
            //$$->atom_type = "list["+$3->atom_type+"]";
            $$->atom_type = $1->atom_type;

            $$->list_size = $1->list_size + 1;
            $$-> addr = str_to_ch(chartostring($1->addr) + "," + chartostring($3->addr));
            $$->list_par_type = $1->list_par_type;
            $$->list_par_type.push_back($3->atom_type);

            //STE code start
            ste* lookup_ste = current_ste;
            if(lookup(lookup_ste, $3->addr) == NULL){
                current_ste = insert_entry_same_scope(current_ste, "VARIABLE", $3->addr, $5->addr, $3->lineno, 1);
            }
            else{
                cerr<<"Error: Variable "<<$3->addr<<" already declared on line "<<lookup(lookup_ste, $3->addr)->lineno<<"\n";
                exit(1);
            }
            //STE code end

            // //function parameters check 
            // $$->func_par_type = $1->func_par_type;
            // $$->func_par_type.push_back(chartostring($5->addr));

            //m3 start
            $$->stack_width = $1->stack_width + $3->stack_width + get_width($5->addr);
            offset_map[chartostring($3->addr)] = -stack_offset;
            stack_offset += get_width($5->addr);
            //m3 end
        }
        ;   

/* classdef: CLASS class_name COLON class_body_suite      { 
            $$ = create_node(5, "classdef", $1, $2, $3,$4);
            $$->ins = $2->ins;
            current_ste = get_prev_scope(current_ste);
            populate_new_scope(current_ste, "CLASS", $2->addr, 0, $1->lineno, 1);
        }
        | CLASS class_name OPEN_BRACKET CLOSE_BRACKET COLON class_body_suite      { 
            $$ = create_node(7, "classdef", $1, $2, $3,$4,$5,$6);
            $$->ins = $2->ins;
            current_ste = get_prev_scope(current_ste);
            populate_new_scope(current_ste, "CLASS", $2->addr, 0, $1->lineno, 1);
        }
        | CLASS class_name OPEN_BRACKET argument CLOSE_BRACKET COLON class_body_suite        { 
            $$ = create_node(8, "classdef", $1, $2, $3,$4,$5,$6,$7);
            $$->ins = $2->ins;
            // cout<<"s11"<<endl;
            // print_ste(current_ste,0);
            current_ste = get_prev_scope(current_ste);
            // cout<<"s12"<<endl;
            // print_ste(current_ste,0);
            // cout<<"s13"<<endl;
            // current_ste = lookup(current_ste, $4->addr);
            populate_new_scope(current_ste, "CLASS", $2->addr, $4->num_params, $1->lineno, 1);
            // print_ste(current_ste,0);
            // cout<<"s14"<<endl;
            // current_ste = get_prev_scope(current_ste);

        }
        ; */

//new
classdef: CLASS class_declare COLON class_body_suite{
            $$ = create_node(5, "classdef", $1, $2, $3,$4);
            $$->lineno = $1->lineno;
            $$->ins = $2->ins;
            //yaha condition check ki class declare kaunsa use ho rha hai
            if(ischild==0){
                current_ste = get_prev_scope(current_ste);
                populate_new_scope(current_ste, "CLASS", $2->addr, 0, $1->lineno, 1);
                //class_map[className]=current_ste; 
            }
            else{
                ischild=0;
                current_ste = get_prev_scope(current_ste);
                populate_new_scope(current_ste, "CLASS", $2->addr, 0, $1->lineno, 1);
                current_ste= lookup(current_ste, "global_head");
                while(current_ste->next!=NULL){
                    current_ste = current_ste->next;
                }
            }

            //m3start
            ste* class_ste = class_map[chartostring($2->addr)];
            class_ste->class_width = class_offset;
            class_offset = 0;
            curr_class="";
            //m3 end
        }
        ;  

class_declare:  NAME {
            $$=$1;
            inClass=1;
            className = chartostring($1->addr);


            //STE code start
            ste* lookup_ste = current_ste;
            if(class_map.find(chartostring($1->addr)) == class_map.end()){
                current_ste = insert_entry_new_scope(current_ste);
                class_map[chartostring($1->addr)]=current_ste->prev_scope;
                current_ste = insert_entry_same_scope(current_ste,chartostring($1->addr),"self","CLASS",$1->lineno,0);
            }
            else{
                cerr<<"Error: Class "<<$1->addr<<" already declared on line "<<class_map[chartostring($1->addr)] ->lineno<<"\n";
                exit(1);
            }
            //STE code end 

            //m3 start
            curr_class = chartostring($1->addr);
            // class_offset = 8;
            //mm3 end
        }
        | NAME OPEN_BRACKET CLOSE_BRACKET{
            $$=$1;
            inClass=1;
            className = chartostring($1->addr);


            //STE code start
            ste* lookup_ste = current_ste;
            if(class_map.find(chartostring($1->addr)) == class_map.end()){
                current_ste = insert_entry_new_scope(current_ste);
                class_map[chartostring($1->addr)]=current_ste->prev_scope;
                current_ste = insert_entry_same_scope(current_ste,chartostring($1->addr),"self","CLASS",$1->lineno,0);
            }
            else{
                cerr<<"Error: Class "<<$1->addr<<" already declared at line "<<class_map[chartostring($1->addr)]->lineno<<"\n";
                exit(1);
            }
            //STE code end 

            //m3 start
            curr_class = chartostring($1->addr);
            // class_offset = 8;
            //mm3 end
        }    
        | NAME OPEN_BRACKET argument CLOSE_BRACKET{
            $$ = create_node(5, "class_declare", $1, $2, $3, $4);
            $$->lineno = $1->lineno;
            $$->ins = $3->ins;
            $$->addr = $1->addr;
            inClass=1;
            ischild=1; 
            className = chartostring($1->addr);
            // cout<<"in class dec: "<<chartostring($3->addr)<<endl;
            if(class_map.find(chartostring($3->addr)) == class_map.end()){
                cerr<<"Error: Class "<<$3->addr<<" not declared at line "<<$3->lineno<<"\n";
                exit(1);
            }
            else{
                current_ste = class_map[chartostring($3->addr)];
                if(current_ste!=NULL )current_ste = current_ste->next_scope;
            }
            if(current_ste== NULL){
                cerr<<"Error: Class "<<$3->addr<<" not declared at line "<<$3->lineno<<"\n";
                exit(1);
            }
            while(current_ste->next!=NULL){
                current_ste = current_ste->next;
            }
            ste* lookup_ste = current_ste;
            if(class_map.find(chartostring($1->addr)) == class_map.end()) {
                current_ste = insert_entry_new_scope(current_ste);
                class_map[chartostring($1->addr)]=current_ste->prev_scope;
                current_ste = insert_entry_same_scope(current_ste,chartostring($1->addr),"self","CLASS",$1->lineno,0);
            }
            else{
                cerr<<"Error: Class "<<$1->addr<<" already declared at line "<<class_map[chartostring($1->addr)]->lineno<<"\n";
                exit(1);
            }

            //m3 start
            class_parent[chartostring($1->addr)]=chartostring($3->addr);
            ste* child_ste = class_map[chartostring($1->addr)];
            ste* parent_ste = class_map[chartostring($3->addr)];
            child_ste->class_offset_map = parent_ste->class_offset_map;
            class_offset = parent_ste->class_width;
            curr_class = chartostring($1->addr);
            //m3 end

        }      
        ;
//new end

/* class_declare: NAME OPEN_BRACKET argument CLOSE_BRACKET {
            $$ = create_node(5, "class_declare", $1, $2, $3, $4);
            $$->ins = $3->ins;
            inClass=1;
            current_ste = lookup(current_ste, $3->addr)->next_scope;
            if(current_ste= NULL){
                cerr<<"Error: Class "<<$3->addr<<" not declared\n";
                exit(1);
            }
            while(current_ste->next!=NULL){
                current_ste = current_ste->next;
            }
            ste* lookup_ste = current_ste;
            if(lookup(lookup_ste, $1->addr) == NULL){
                current_ste = insert_entry_new_scope(current_ste);
                current_ste = insert_entry_same_scope(current_ste,"self","self","CLASS",$1->lineno,0);
            }
            else{
                cerr<<"Error: Class "<<$1->addr<<" already declared\n";
                exit(1);
            }

} */


class_body_suite: NEWLINE INDENT funcdef_plus DEDENT    { 
            $$=$3;
            inClass=0;
        }
        | NEWLINE INDENT funcdef_plus NEWLINE DEDENT    { 
            $$=$3;
            inClass=0;
        }
        ;

funcdef_plus: funcdef  { 
            $$=$1;
        }
        | funcdef_plus funcdef   { 
            $$=create_node(3,"funcdef_plus",$1,$2);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
        }
        ;

/* class_name: NAME {
        $$=$1;
        inClass=1;
        className = chartostring($1->addr);


        //STE code start
        ste* lookup_ste = current_ste;
        if(lookup(lookup_ste, $1->addr) == NULL){
            current_ste = insert_entry_new_scope(current_ste);
            current_ste = insert_entry_same_scope(current_ste,chartostring($1->addr),"self","CLASS",$1->lineno,0);
        }
        else{
            cerr<<"Error: Class "<<$1->addr<<" already declared at line "<<lookup(lookup_ste, $1->addr)->lineno<<"\n";
            exit(1);
        }
        //STE code end 
}; */



arglist: argument_list     { 
            $$=$1;
        }
        /* | argument_list COMMA    { 
            $$=$1;
        } */
        ;
argument_list: argument     { 
            $$=$1;
            $$->num_params=1;

            //create_ins(0, "PushParam", "RBP", "", "");
            $$->ins = instCount+1;
            $$->nextlist = makelist(instCount+1);
            create_ins(0, "PushParamra", "", "", "");
            create_ins(0, "PushParam", $1->addr, "", "");
        
        }
        | argument COMMA argument_list  { 
            $$ = create_node(4, "argument_list", $1, $2, $3);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
            $$->num_params = $3->num_params + 1;

            create_ins(0, "PushParam", $1->addr, "", "");
            $$->nextlist = $3->nextlist;

            //function par type
            $$->func_par_type = $1->func_par_type;
            for(int i=0;i< $3->func_par_type.size();i++){
                $$->func_par_type.push_back($3->func_par_type[i]);
            }

            //m3 start
            $$->stack_width = $1->stack_width + $3->stack_width;
            //m3 end
        }
        ;

argument: test  {
            $$=$1;
            //for function parameter typecheck
            $$->func_par_type.push_back($1->atom_type);
        }
        | test EQUAL test   { 
            $$ = create_node(4, "argument", $1, $2, $3);
            $$->lineno = $1->lineno;
            $$->ins = $1->ins;
            create_ins(0, $1->addr, $2->addr, $3->addr, "");

            //for function parameter typecheck
            $$->func_par_type.push_back($1->atom_type);

            //m3 start
            $$->stack_width = $1->stack_width + $3->stack_width;
            //m3 end
        }
        ;


stmt_plus: stmt     {
            $$=$1;
        }
        | stmt stmt_plus    { 
            
            $$=create_node(3,"stmt_plus",$1,$2);
            $$->lineno = $1->lineno;
			$$->ins = $1 -> ins;
            $$->nextlist = merge($1->nextlist, $2->nextlist);
            //$$->nextlist = $2->nextlist;

            //m3 start
            $$->stack_width = $1->stack_width+$2->stack_width;
            //m3 end
        }

%%

void yyerror(string str){
    fprintf(stderr, "Error: %s at line number %d offending token: %s\n", str.c_str(), yylineno, yytext);
    exit(1);
}

char* str_to_ch(string s)
{
	char* result_chr = new char[s.size()+1];
	strcpy(result_chr,s.c_str());
	return result_chr;
}

vector<int> makelist(int i){
	return vector<int>{i};
}

void create_ins(int type,string i,string op,string arg1,string arg2){
	vector<string> instruction{to_string(type),i,op,arg1,arg2};
	instructions.push_back(instruction);
    /* cout<<instruction.size()<<endl; */
	instCount++;
}

void backpatch(vector<int>p, int i){
	for(int j=0;j<p.size();j++)
		instructions[p[j]-1].push_back(to_string(i));
}

void backpatch_str(vector<int>p, string str){
	for(int j=0;j<p.size();j++)
		instructions[p[j]-1].push_back(str);
}

vector<int> merge(vector<int> p1, vector<int> p2){
        vector<int> merged;
        merged.reserve(p1.size() + p2.size());
        merged.insert(merged.end(), p1.begin(), p1.end());
        merged.insert(merged.end(), p2.begin(), p2.end());
	return merged;
}

string newTemp(){
	return "t"+to_string(tempCount++);
}

void MakeIRFile(ofstream& code_out)
{
	int tabs=0;
	for(int i=0;i<instructions.size();i++)
	{
		if(instructions[i][1]=="EndFunc") tabs--;
		//cout << i+1 << "\t" << string(tabs,'\t');
		code_out << i+1 << "\t" << string(tabs,'\t');
		if(instructions[i][0]=="0")
		{
			for(int j=1;j<instructions[i].size();j++)
			{
                if((instructions[i][j]) == "goto"){
                    if(instructions[i].size()==5 && instructions[i][j+1]==""){ 
                        instructions[i].push_back(to_string(endline));
                    }
                }				
                //cout << instructions[i][j] << (instructions[i][j].length()?" ":"");
				code_out << instructions[i][j] << (instructions[i][j].length()?" ":"");
			}
			if(instructions[i][1]=="BeginFunc") tabs++;
		}
		else
		{
			//cout << instructions[i][1] << " = " << instructions[i][3] << " " << instructions[i][2] << " " << instructions[i][4];
			code_out << instructions[i][1] << " = " << instructions[i][3] << " " << instructions[i][2] << " " << instructions[i][4];
		}
		//cout << endl;
		code_out << endl;
	}
}

void vector_copy(vector<string> v1,vector<string> v2){
    for(int i=0;i<v1.size();i++){
        v2.push_back(v1[i]);
    }
}

string typecast(string typ1,string typ2,string op)
{
	bool valid = (typeMap.find(typ1)!= typeMap.end()) && (typeMap.find(typ2)!= typeMap.end());
	int t1,t2;
	if (valid)
	{	
		t1=typeMap[typ1];
		t2=typeMap[typ2];
	}
	if (op=="=" )
	{
		if (valid)
		{
			if (t1>=t2)
				return typ1;
			else
				return "Error";
		}
		else
		{
			if (typ1==typ2)
				return typ1;
			else
				return "Error";
		}
	}
	if (op =="-" )
	{
		if (valid)
		{
			if (t1>=t2)
				return typ1;
			else
				return typ2;
		}
		else
		{
			if (typ1==typ2)
				return typ1;
			else
				return "Error";
		}
	}
	if(op=="+")
	{
		if (valid)
		{
			if (t1>=t2)
				return typ1;
			else 
				return typ2;
		}
		else
		{
			if (typ1=="String" || typ2=="String")
				return "String";
			if (typ1==typ2)
				return typ1;
			else
				return "Error";
		}
	}
	if (op==">" || op == "<" || op=="<=" || op==">=" || op=="==" || op=="!=")
	{
		if (valid)
		{
			return "bool";
		}
		else
		{
			if (typ1==typ2) //for string
				return "bool";
			else
				return "Error";
		}
	}
	if (op=="&&" || op=="||")
	{
		if (typ1==typ2 && typ1=="bool")
			return "bool";
		else
			return "Error";
	}
	if (op=="*" || op=="/" || op=="%")
	{
		if (valid)
		{
			if (t1>=t2)
				return typ1;
			else
				return typ2;
		}
		else
		{
			return "Error";
		}
	}
	if (op=="&" || op=="|" || op=="^" || op=="<<" || op==">>")
	{
		if (valid)
		{
			if (t1>=t2)
				return typ1;
			else
				return typ2;
		}
		else
		{
			return "Error";
		}
	}

	if (op=="+=")
	{
		if (valid)
		{
			if (t1>=t2)
				return typ1;
			else
				return "Error";
		}
		else
		{
			/* if (typ1=="String")
				return "String"; */
			if (typ1==typ2)
				return typ1;
			else
				return "Error";
		}
	}
	if (op=="-=" || op=="*=" || op=="/=" || op=="%=" || op=="&=" || op=="|=" || op=="^=" || op=="<<=" || op==">>=" || op=="//=" || op=="**=")
    {
        if (valid)
        {
            if (t1>=t2)
                return typ1;
            else
                return "Error";
        }
        else
        {
            return "Error";
        }
    }
	
	if (typ1 == typ2)
		return typ1;
	if (typ1 == "" || typ2 == "")
		return typ1+typ2;
	return "Error";

}

ste* setup_global_sym_table(ste* curr_ste){
    curr_ste->lexeme = "global_head";
    curr_ste->type = "GLOBAL_HEAD";
    curr_ste = insert_entry_same_scope(curr_ste, "BOOL", "True", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "BOOL", "False", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "ELSE", "else", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "NONE", "None", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "BREAK", "break", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "IN", "in", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "CLASS", "class", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "IS", "is", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "RETURN", "return", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "AND", "and", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "CONTINUE", "continue", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "FOR", "for", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "DEF", "def", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "WHILE", "while", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "GLOBAL", "global", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "NOT", "not", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "ELIF", "elif", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "IF", "if", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "OR", "or", "RESERVED_KEYWORD", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "LEN", "len", "RESERVED_FUNCTION", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "PRINT", "print", "RESERVED_FUNCTION", -1, -1);
    curr_ste = insert_entry_same_scope(curr_ste, "RANGE", "range", "RESERVED_FUNCTION", -1, -1);
    return curr_ste;
}

void printToCSV(ste* curr,int level,int sublevel,ofstream& fout){
    if(curr->lexeme != "global_head" && curr->lexeme != "scope_head" && curr->type != "RESERVED_KEYWORD" && curr->type != "RESERVED_FUNCTION"){
        fout<<level<<","<<sublevel<<","<<curr->token<<","<<curr->lexeme<<","<<curr->type<<","<<curr->lineno<<","<<curr->is_func_class<<","<<curr->return_type<<","<<curr->stack_width<<","<<endl;
        /* fout<<"size="<<curr->offset_map.size()<<endl;
        for (const auto& pair : curr->offset_map) {
            fout << pair.first << " => " << pair.second << endl;
        }
        fout<<endl; */
    }
    if (curr->next_scope != NULL)
    {   
        printToCSV(curr->next_scope,level+1,0,fout);
    }
    if (curr->next != NULL)
    {
        printToCSV(curr->next,level,sublevel+1,fout);
    }
}


int main(int argc, char* argv[]){    
    /* cout<<"Hello\n"; */
    FILE* yyin = fopen(argv[1],"r");
    yyrestart(yyin); 

    bool inset = false, outset = false;
    indent_stack.push(0);

    typeMap["None"] = 0;
    typeMap["bool"] = 1;
	typeMap["int"] = 1;
	typeMap["float"] = 3;
	typeMap["str"] = 4;

    typeMap["list[int]"] = 6;
    typeMap["list[bool]"] = 6;
    typeMap["list[float]"] = 7;
    typeMap["list[str]"] = 8;

    string srcfile="";
    yyrestart(yyin);

    for (int i=0; i< argc; i++){
        if (strcmp(argv[i], "-help") == 0){
            cerr<<"Usage: make\n ./python_compiler [-help] [-input <filename>] [-output <filename>] [-verbose]\n";
            cerr<< "Example: ./python_compiler -input input.txt -output output.txt\n";
        }
        else if (strcmp(argv[i], "-input") == 0){
            yyin = fopen(argv[i+1], "r");
            int j=3;
            while(argv[i+1][j] != '/'){
                j++;
            }
            j++;
            while(argv[i+1][j] != '.'){
                srcfile.push_back(argv[i+1][j]);
                j++;
            }

            yyrestart(yyin);
            inset = true;
        }
        /* else if (strcmp(argv[i], "-output") == 0){
            freopen(argv[i+1], "w", stdout);
            outset = true;
        } */
        else if (strcmp(argv[i], "-verbose") == 0){
            cerr<<"Verbose Output directed to parser.output\n";
        }
    }
    if (!inset){
        cerr<< "Input not set, see help\n";
        return 0;
    }
    /* if (!outset){
        cerr<< "Output not set, see help\n";
        return 0;
    }  */

    instCount=0;
    tempCount=0;
    /* yydebug=1;  */
    current_ste = setup_global_sym_table(current_ste);
    /* cout<<"Parsing Started\n"; */
    yyparse();
    fclose(yyin); 


// Create 3AC file
    ofstream code_out;
    string filename1 = "../outputs/3AC/"+srcfile+".txt";
    //cout<<filename1<<endl;
    code_out.open(filename1);
    MakeIRFile(code_out);

// CSV code
    ofstream fout;
    string filename = "../outputs/SymTab/"+srcfile+".csv";
    //cout<<filename<<endl;
    fout.open(filename);

    fout<<"Level,Sublevel,Token,Lexeme,Type,Line Number,Is Function/Class,Return Type\n";

    printToCSV(global_sym_table,0,-22,fout);

// Close the output file
    code_out.close();
    fout.close();

/*--------------------------------------------------------------*/

    //m3 start
    ofstream m3_out;
    string filename2 = "../outputs/x86/"+srcfile+".s";
    m3_out.open(filename2);
    create_x86();
    // Print the x86_code
    for(const auto& line : x86_code){
        for(const auto& part : line){
            m3_out << part << " ";
        }
        m3_out << endl;
    }
    m3_out.close();
    //m3 end

    return 0;

}