#include "../include/data.h"
#include <cstdarg>

int num=0;

NODE* create_node(int n_args, ...)
{
    NODE *element = (NODE *)calloc(1, sizeof(NODE));
    element->id=num++;
    string s="";
    char* temp=new char[1];
    strcpy(temp, s.c_str());
    element->type=temp;

    NODE*child;
    va_list valist;
    va_start(valist, n_args); 
    element->addr = strdup(va_arg(valist, const char*));
    
    for (int i = 1; i < n_args; i++) {
        child = va_arg(valist, NODE*);
        element->children.push_back(child);
    }
    va_end(valist);
    
    return element;
}

void add_children(NODE* parent, int n_args, ...)
{
    NODE*child;
    va_list valist;
    va_start(valist, n_args); 
    for (int i = 0; i < n_args; i++) {
        child = va_arg(valist, NODE*);
        parent->children.push_back(child);
    }
    va_end(valist);
}