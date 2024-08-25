#include "../include/symbol_table.h"



int get_width(string TYPE_HINT){
    if(TYPE_HINT == "int"){
        return 4;
    }
    else if(TYPE_HINT== "float"){
        return 8;
    }
    else if(TYPE_HINT == "bool"){
        return 1;
    }
    else if(TYPE_HINT == "None"){
        return 0;
    } 
    else if(TYPE_HINT == "list[int]"){
        return 8;
    }
    else if(TYPE_HINT == "list[float]"){
        return 8;
    }
    else if(TYPE_HINT == "list[bool]"){
        return 8;
    }
    else if(TYPE_HINT == "list[None]"){
        return 8;
    }
    return 0;
    
}

ste* insert_entry_same_scope(ste* curr_ste, string token,string lexeme,string type,int lineno, int isvar, int list_size=0){
    ste* new_entry = new ste;
    new_entry->token = token;
    new_entry->lexeme = lexeme;
    new_entry->type = type;
    new_entry->lineno = lineno;
    new_entry->isvar = isvar;
    new_entry->list_size = list_size;

    if(type == "int"||type == "float"||type == "bool"||type == "None"){
        new_entry->width = get_width(type);
    }
    else{
        new_entry->width = get_width(type)*(list_size);
    }
    new_entry->offset = curr_ste->offset + curr_ste->width;

    // new_entry->next = NULL;
    new_entry->prev = curr_ste;
    curr_ste->next = new_entry;
    return new_entry;
}

ste* insert_entry_new_scope(ste* curr_ste) {
    ste* new_entry = new ste;
    // new_entry->token = token;
    // new_entry->lexeme = id;
    // new_entry->return_type = return_type;
    // new_entry->lineno = lineno;
    // new_entry->is_func_class = is_func_class;

    new_entry->prev = curr_ste;
    curr_ste->next = new_entry;

    ste* head_scope = new ste;
    head_scope->lexeme = "scope_head";
    head_scope->type = "SCOPE_HEAD";
    head_scope->prev_scope = new_entry;
    new_entry->next_scope = head_scope;

    return head_scope;
}

void populate_new_scope(ste* curr_ste, string token, string id,int num_params, int lineno, int is_func_class, string return_type="None") {
    curr_ste->token = token;
    curr_ste->lexeme = id;
    curr_ste->type = token; //added
    curr_ste->return_type = return_type;
    curr_ste->num_params = num_params;
    curr_ste->lineno = lineno;
    curr_ste->is_func_class = is_func_class;
}

void populate_fun_par_type(ste* current_ste, vector<string> use){
    current_ste->func_par_type = use;
}

ste* get_prev_scope(ste* curr_ste){
    ste* temp = curr_ste;
    while(temp->lexeme != "scope_head"){
        temp = temp->prev;
    }
    return temp->prev_scope;
}

void print_ste(ste* curr,int level)
{
    for (int i = 0; i < level; i++)
    {
        cout<<"-> ";
    }
    cout<<curr->lexeme<<" "<<curr->type<<endl;
    if (curr->next_scope != NULL)
    {
        print_ste(curr->next_scope,level+1);
    }
    if (curr->next != NULL)
    {
        print_ste(curr->next,level);
    }
}

ste* lookup(ste* lookup_ste, string lexeme)
{
    if (lookup_ste->type=="global_head")
        return NULL;
    if (lookup_ste->lexeme==lexeme)
        return lookup_ste;
    if (lookup_ste->prev_scope!=NULL)
        return lookup(lookup_ste->prev_scope,lexeme);
    if (lookup_ste->prev!=NULL)
        return lookup(lookup_ste->prev,lexeme);
    return NULL;
}

ste* same_lookup(ste* lookup_ste, string lexeme)
{
    if (lookup_ste == NULL)
        return NULL;
    if (lookup_ste->lexeme==lexeme)
        return lookup_ste;
    if (lookup_ste->prev!= NULL)
        return same_lookup(lookup_ste->prev,lexeme);
    return NULL;
}

ste* rev_lookup(ste* lookup_ste, string lexeme){
    if (lookup_ste == NULL)
        return NULL;
    if (lookup_ste->lexeme==lexeme)
        return lookup_ste;
    if (rev_lookup(lookup_ste->next_scope,lexeme)!=NULL)
        return rev_lookup(lookup_ste->next_scope,lexeme);
    if (rev_lookup(lookup_ste->next,lexeme)!=NULL)
        return rev_lookup(lookup_ste->next,lexeme);
    return NULL;
} 

ste* single_rev_lookup(ste* lookup_ste, string lexeme){
    if (lookup_ste == NULL)
        return NULL;
    if (lookup_ste->lexeme==lexeme)
        return lookup_ste;
    if (lookup_ste->next!=NULL)
        return single_rev_lookup(lookup_ste->next,lexeme);
    return NULL;
}
