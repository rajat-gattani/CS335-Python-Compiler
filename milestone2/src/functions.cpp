#include<bits/stdc++.h>
#include "symbol_table.cpp"
using namespace std;

// void searchAST(NODE* node){
//     if(node == NULL) return;
    


//     for(int i = 0; i < node->children.size(); i++){
//         string child_node_addr = node->children[i]->addr;
//         if(child_node_addr == "Class"){
            
//         }
//         searchAST(node->children[i]);
//     }

// }

void setup_global_sym_table(ste* curr_ste){
    insert_entry_same_scope(curr_ste, "ATOM_KEYWORDS", "True", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "ATOM_KEYWORDS", "False", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "ELSE", "else", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "ATOM_KEYWORDS", "None", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "BREAK", "break", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "IN", "in", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "CLASS", "class", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "IS", "is", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "RETURN", "return", "RESERVED KEYWORD", -1, -1);\
    insert_entry_same_scope(curr_ste, "AND", "and", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "CONTINUE", "continue", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "FOR", "for", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "DEF", "def", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "WHILE", "while", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "GLOBAL", "global", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "NOT", "not", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "ELIF", "elif", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "IF", "if", "RESERVED KEYWORD", -1, -1);
    insert_entry_same_scope(curr_ste, "OR", "or", "RESERVED KEYWORD", -1, -1);
}