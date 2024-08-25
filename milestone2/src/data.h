#ifndef NODE_H
#define NODE_H

#include <bits/stdc++.h>
// #include <instructions.h>
using namespace std;

typedef struct node
{
    int id;
    int lineno;
    bool isvar;
    char *val;
    char *type;
    char *addr;
    char *type_hint;
    int ins; // stores the starting instruction number of the current node's code
    int num_params = 0;

    char* for_end;
    char* for_start;
    // int last_ins;

    string return_param;
    string atom_type="";
    string class_param="";

    int list_size=0;

    vector<string> func_par_type;

    vector<int> truelist;
    vector<int> falselist;
    vector<int> nextlist;
    vector<struct node *> children;
} NODE;

NODE *create_node(int n_args, ...);

#endif // NODE_H