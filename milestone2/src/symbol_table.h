#include<bits/stdc++.h>

using namespace std;

typedef struct symbol_table_entry{
    string token, lexeme, type; //for variables
    int lineno; //for variables, functions, classes
    int isvar = 0;  //check if it is a variable
    string return_type = "None", id;  //for functions, classes
    int num_params;        //for functions, classes
    int is_func_class = 0;  //check if it is a function/class
    struct symbol_table_entry* next = NULL;    //pointer to next entry in the same symbol table
    struct symbol_table_entry* prev = NULL;    //pointer to previous entry in the same symbol table
    struct symbol_table_entry* next_scope = NULL;  //pointer to the head of the next scope
    struct symbol_table_entry* prev_scope = NULL;  //pointer to the head of the previous scope    
    int width = 0;  //width of the variable
    int offset = 0;  //offset of the variable
    int list_size=0;
    vector<string>func_par_type;
} ste ;

// typedef struct symbol_table_map_entry {
//     ste* entry;
//     string return_type,id;
//     int num_params;
//     struct symbol_table_map_entry * next;
// } stme;


