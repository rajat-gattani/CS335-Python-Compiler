#include "../include/data.h"
#include "symbol_table.cpp"

extern ste* global_sym_table;
extern vector<vector<string>> instructions;
extern map<string,ste*> class_map;
ste* curr_func_ste;
vector<vector<string>> x86_code;
int str_cnt = 0;
int str_temp=0;
string str_name="";

map<string,string> str_map;
map<string,int> str_id;

stack<int> str_arg;

extern map<string,string> obj_class;

ste* obj_class_ste;

string obj_in_constructor;

void stack_pos2_obj(ste* my_ste, string c){
    if(my_ste->class_offset_map.find(c)!=my_ste->class_offset_map.end()){
        x86_code.push_back({"\tmovq", to_string(my_ste->class_offset_map[c])+"(%r15)",",","%r12"});
    }
    else if(c.find('[')!=string::npos){
        size_t pos = c.find('[');
        // Extract the array name and the index
        string arrayName = c.substr(0, pos);
        string index = c.substr(pos + 1, c.size() - pos - 2);

        x86_code.push_back({"\tmovq", to_string(curr_func_ste->offset_map[index])+"(%rbp)", ",", "%r12"});
        x86_code.push_back({"\taddq", "$8", ",", "%r12"});
        x86_code.push_back({"\tmovq", "%r12", ",", "%r9"}); 
        stack_pos2_obj(my_ste,arrayName);
        x86_code.push_back({"\taddq", "%r9", ",", "%r12"});
        x86_code.push_back({"\tmovq", "0(%r12)", ",", "%r12"});
    }
    else{
        x86_code.push_back({"\tmovq", "$"+c, ",", "%r12"});
    }
}


void stack_pos2(string c){  //r12
    if(curr_func_ste->offset_map.find(c)!= curr_func_ste->offset_map.end()){
        curr_func_ste->offset_map[c];
        x86_code.push_back({"\tmovq", to_string(curr_func_ste->offset_map[c])+"(%rbp)", ",", "%r12"});
    }
    else if(c=="True"){
        x86_code.push_back({"\tmovq", "$1", ",", "%r12"});
    }
    else if(c=="False"){
        x86_code.push_back({"\tmovq", "$0", ",", "%r12"});
    }
    else if(c==""){
        x86_code.push_back({"\tmovq", "$0", ",", "%r12"});
    }
    else if(c.find('\"') != string::npos || c.find('\'') != string::npos){
        string s = c.substr(1, c.size() - 2);  //removed the quotes
        str_cnt++;
        str_temp=1;
        str_name = s; 
        //x86_code.push_back({"\tmovq", "$string"+to_string(str_cnt), ",", "%r12"});     
        x86_code.push_back({"\tlea", "string"+to_string(str_cnt)+"(%rip)", ",", "%r12"});  
    }
    else if(c.find('.')!=string::npos){ 
        size_t pos = c.find('.');
        string obj_name = c.substr(0, pos);
        string attribute = c.substr(pos + 1);
        if(obj_name=="self"){
            stack_pos2_obj(obj_class_ste, attribute);
        }
        else{
            ste* class_ste = class_map[obj_class[obj_name]];
            x86_code.push_back({"\tmovq", to_string(curr_func_ste->offset_map[obj_name])+"(%rbp)", ",", "%r15"});
            stack_pos2_obj(class_ste, attribute);
        }      
    }
    else if(c.find('[')!=string::npos){ //array[3]
        size_t pos = c.find('[');

        // Extract the array name and the index
        string arrayName = c.substr(0, pos);
        string index = c.substr(pos + 1, c.size() - pos - 2);

        stack_pos2(index);
        x86_code.push_back({"\taddq", "$8", ",", "%r12"});
        x86_code.push_back({"\tmovq", "%r12", ",", "%r10"}); 
        stack_pos2(arrayName);
        x86_code.push_back({"\taddq", "%r10", ",", "%r12"}); 
        x86_code.push_back({"\tmovq", "0(%r12)", ",", "%r12"}); 
    }
    else {  //as of now, we are considering onyl constant value here
        x86_code.push_back({"\tmovq", "$"+c, ",", "%r12"});
    }
}


void stack_pos1_obj(ste* my_ste, string b){
    if(my_ste->class_offset_map.find(b)!=my_ste->class_offset_map.end()){
        x86_code.push_back({"\tmovq", to_string(my_ste->class_offset_map[b])+"(%r15)",",","%r11"});
    }
    else if(b.find('[')!=string::npos){
        size_t pos = b.find('[');
        // Extract the array name and the index
        string arrayName = b.substr(0, pos);
        string index = b.substr(pos + 1, b.size() - pos - 2);

        x86_code.push_back({"\tmovq", to_string(curr_func_ste->offset_map[index])+"(%rbp)", ",", "%r11"});
        x86_code.push_back({"\taddq", "$8", ",", "%r11"});
        x86_code.push_back({"\tmovq", "%r11", ",", "%r9"}); 
        stack_pos1_obj(my_ste,arrayName);
        x86_code.push_back({"\taddq", "%r9", ",", "%r11"});
        x86_code.push_back({"\tmovq", "0(%r11)", ",", "%r11"});
    }
    else{
        x86_code.push_back({"\tmovq", "$"+b, ",", "%r11"});
    }
}


void stack_pos1(string b){  //r11
    if(curr_func_ste->offset_map.find(b)!= curr_func_ste->offset_map.end()){
        curr_func_ste->offset_map[b];
        x86_code.push_back({"\tmovq", to_string(curr_func_ste->offset_map[b])+"(%rbp)", ",", "%r11"});
    }
    else if(b=="True"){
        x86_code.push_back({"\tmovq", "$1", ",", "%r11"});
    }
    else if(b=="False"){
        x86_code.push_back({"\tmovq", "$0", ",", "%r11"});
    }
    else if(b==""){
        x86_code.push_back({"\tmovq", "$0", ",", "%r11"});
    }
    else if(b.find('.')!=string::npos){ 
        size_t pos = b.find('.');
        string obj_name = b.substr(0, pos);
        string attribute = b.substr(pos + 1);
        if(obj_name=="self"){
            stack_pos1_obj(obj_class_ste, attribute);
        }
        else{
            ste* class_ste = class_map[obj_class[obj_name]];
            x86_code.push_back({"\tmovq", to_string(curr_func_ste->offset_map[obj_name])+"(%rbp)", ",", "%r15"});
            stack_pos1_obj(class_ste, attribute);
        }      
    }
    else if(b.find('\"') != string::npos || b.find('\'') != string::npos){
        string s = b.substr(1, b.size() - 2);  //removed the quotes
        str_cnt++;
        str_temp=1;
        str_name = s;
        // str_arg.push(str_cnt);
        x86_code.push_back({"\tlea", "string"+to_string(str_cnt)+"(%rip)", ",", "%r11"}); 
        // x86_code.push_back({"\tmovq", "string"+to_string(str_cnt), ",", "%r11"});  
    }
    else if(b.find('[')!=string::npos){
        size_t pos = b.find('[');

        // Extract the array name and the index
        string arrayName = b.substr(0, pos);
        string index = b.substr(pos + 1, b.size() - pos - 2);

        stack_pos1(index);
        x86_code.push_back({"\taddq", "$8", ",", "%r11"});
        x86_code.push_back({"\tmovq", "%r11", ",", "%r9"}); 
        stack_pos1(arrayName);
        x86_code.push_back({"\taddq", "%r9", ",", "%r11"});
        x86_code.push_back({"\tmovq", "0(%r11)", ",", "%r11"});
    }
    else {  //as of now, we are considering onyl constant value here
        x86_code.push_back({"\tmovq", "$"+b, ",", "%r11"});
    }
}


void stack_pos_lhs_obj(ste* my_ste, string b){
    if(my_ste->class_offset_map.find(b)!=my_ste->class_offset_map.end()){ 
        // cerr<<"mac"<<endl; 
        x86_code.push_back({"\tmovq", "%r15", ",", "%r13"});
        x86_code.push_back({"\taddq", "$"+to_string(my_ste->class_offset_map[b]), ",", "%r13"});
    }
    else if(b.find('[')!=string::npos){
        // cerr<<"yes"<<endl;
        size_t pos = b.find('[');
        // Extract the array name and the index
        string arrayName = b.substr(0, pos);
        string index = b.substr(pos + 1, b.size() - pos - 2);

        x86_code.push_back({"\tmovq", to_string(curr_func_ste->offset_map[index])+"(%rbp)", ",", "%r11"});
        x86_code.push_back({"\taddq", "$8", ",", "%r11"});
        x86_code.push_back({"\tmovq", "%r11", ",", "%r14"});
        stack_pos1_obj(my_ste,arrayName);
        x86_code.push_back({"\taddq", "%r14", ",", "%r11"});
        x86_code.push_back({"\tmovq", "%r11", ",", "%r13"});        
    }
}


void stack_pos_lhs(string b){   //r13
    if(curr_func_ste->offset_map.find(b)!= curr_func_ste->offset_map.end()){
        x86_code.push_back({"\tmovq", "%rbp", ",", "%r13"}); 
        if(curr_func_ste->offset_map[b]>0){
            x86_code.push_back({"\taddq", "$"+to_string(curr_func_ste->offset_map[b]), ",","%r13"});
        }
        else{
            x86_code.push_back({"\tsubq", "$"+to_string(-1*curr_func_ste->offset_map[b]), ",", "%r13"});
        }
    }
    else if(b.find('.')!=string::npos){ 
        size_t pos = b.find('.');
        string obj_name = b.substr(0, pos);
        string attribute = b.substr(pos + 1);
        if(obj_name=="self"){
            stack_pos_lhs_obj(obj_class_ste,attribute);
        }
        else{
            // cerr<<"here "<<obj_name<<" "<<attribute<<endl;
            ste* class_ste = class_map[obj_class[obj_name]];
            x86_code.push_back({"\tmovq", to_string(curr_func_ste->offset_map[obj_name])+"(%rbp)", ",", "%r15"});
            stack_pos_lhs_obj(class_ste,attribute);
        }
    }
    else if(b.find('[')!=string::npos){
        size_t pos = b.find('[');

        // Extract the array name and the index
        string arrayName = b.substr(0, pos);
        string index = b.substr(pos + 1, b.size() - pos - 2);

        stack_pos1(index);
        x86_code.push_back({"\taddq", "$8", ",", "%r11"});
        x86_code.push_back({"\tmovq", "%r11", ",", "%r14"}); 
        stack_pos1(arrayName);
        x86_code.push_back({"\taddq", "%r14", ",", "%r11"});
        x86_code.push_back({"\tmovq", "%r11", ",", "%r13"});
    }
}


void create_x86(){    

    x86_code.push_back({".section", ".rodata"});
    x86_code.push_back({".note0:"});
    x86_code.push_back({"\t.string", "\"%ld\\n\""});
    x86_code.push_back({"\t.text"});
    x86_code.push_back({"\t.globl", "main"});

    for(int i=0; i<instructions.size(); i++){
        if(str_temp){
            x86_code.push_back({".section", ".data"});
            x86_code.push_back({"string"+to_string(str_cnt)+":", ".string","\""+str_name+"\""});
            x86_code.push_back({".section", ".text"});
            str_temp=0;
            str_name="";
        }
        x86_code.push_back({"L"+to_string(i+1)+":\n\t"});
        if(instructions[i][0]=="1"){   //type 1 instruction     // a = b op c
            string a = instructions[i][1];
            string op = instructions[i][2];
            string b = instructions[i][3];
            string c = instructions[i][4];

            string s1,s2;

            if((instructions[i][3].find('\"') != string::npos || instructions[i][3].find('\'') != string::npos) && (instructions[i][4].find('\"') != string::npos || instructions[i][4].find('\'') != string::npos) ){
                s1 = instructions[i][3].substr(1, instructions[i][3].size() - 2);  //removed the quotes
                s2 = instructions[i][4].substr(1, instructions[i][4].size() - 2);  //removed the quotes
            }
            else if((instructions[i][3].find('\"') != string::npos || instructions[i][3].find('\'') != string::npos )&& str_map.find(instructions[i][4]) != str_map.end()){
                s1 = instructions[i][3].substr(1, instructions[i][3].size() - 2);  //removed the quotes
                s2 = str_map[instructions[i][4]];
            }
            else if((instructions[i][4].find('\"') != string::npos || instructions[i][4].find('\'') != string::npos) && str_map.find(instructions[i][3]) != str_map.end()){
                s2 = instructions[i][4].substr(1, instructions[i][4].size() - 2);  //removed the quotes
                s1 = str_map[instructions[i][3]];
            }
            else if(str_map.find(instructions[i][3]) != str_map.end() && str_map.find(instructions[i][4]) != str_map.end()){
                s1 = str_map[instructions[i][3]];
                s2 = str_map[instructions[i][4]];
            }

            if(!s1.empty() && !s2.empty()){
                stack_pos_lhs(a);
                if(op == "=="){
                    if(s1 == s2){
                        x86_code.push_back({"\tmovq", "$1", ",", "%r11"});
                    }
                    else{
                        x86_code.push_back({"\tmovq", "$0", ",", "%r11"});
                    }
                    x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
                }
                else if(op == "!="){
                    if(s1 != s2){
                        x86_code.push_back({"\tmovq", "$1", ",", "%r11"});
                    }
                    else{
                        x86_code.push_back({"\tmovq", "$0", ",", "%r11"});
                    }
                    x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
                }
                else if(op == "<"){
                    if(s1 < s2){
                        x86_code.push_back({"\tmovq", "$1", ",", "%r11"});
                    }
                    else{
                        x86_code.push_back({"\tmovq", "$0", ",", "%r11"});
                    }
                    x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
                }
                else if(op == ">"){
                    if(s1 > s2){
                        x86_code.push_back({"\tmovq", "$1", ",", "%r11"});
                    }
                    else{
                        x86_code.push_back({"\tmovq", "$0", ",", "%r11"});
                    }
                    x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
                }
                else if(op == "<="){
                    if(s1 <= s2){
                        x86_code.push_back({"\tmovq", "$1", ",", "%r11"});
                    }
                    else{
                        x86_code.push_back({"\tmovq", "$0", ",", "%r11"});
                    }
                    x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
                }
                else if(op == ">="){
                    if(s1 >= s2){
                        x86_code.push_back({"\tmovq", "$1", ",", "%r11"});
                    }
                    else{
                        x86_code.push_back({"\tmovq", "$0", ",", "%r11"});
                    }
                    x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
                }
                else if(op == "+"){
                    string s = s1+s2;  //removed the quotes
                    str_cnt++;
                    str_id[s] = str_cnt;
                    str_name = s;
                    str_temp=1;
                    x86_code.push_back({"\tlea", "string"+to_string(str_cnt)+"(%rip)", ",", "%r11"}); 
                    x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
                }
            }

            else{

            stack_pos_lhs(a);
            stack_pos1(b);
            stack_pos2(c);

            if(op == "+"){
                x86_code.push_back({"\taddq", "%r12", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == "-"){
                x86_code.push_back({"\tsubq", "%r12", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == "*"){
                x86_code.push_back({"\timulq", "%r12", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == "/"){  //test these
                x86_code.push_back({"\tmovq", "$0", ",", "%rdx"});
                x86_code.push_back({"\tmovq", "%r11", ",", "%rax"});
                x86_code.push_back({"\tdivq", "%r12"});
                x86_code.push_back({"\tmovq", "%rax", ",", "0(%r13)"});
            }
            else if(op == "%"){
                x86_code.push_back({"\tmovq", "$0", ",", "%rdx"});
                x86_code.push_back({"\tmovq", "%r11", ",", "%rax"});
                x86_code.push_back({"\tdivq", "%r12"});
                x86_code.push_back({"\tmovq", "%rdx", ",", "0(%r13)"});
            }
            else if(op == "//"){    //same as division because float need not to be done
                x86_code.push_back({"\tmovq", "$0", ",", "%rdx"});
                x86_code.push_back({"\tmovq", "%r11", ",", "%rax"});
                x86_code.push_back({"\tdivq", "%r12"});
                x86_code.push_back({"\tmovq", "%rax", ",", "0(%r13)"});
            }
            else if(op == "**"){
                x86_code.push_back({"\tmovq", "$1", ",", "%rdx"});
                x86_code.push_back({"\tmovq", "%r12", ",", "%rbx"});
                x86_code.push_back({"\tcmpq", "$0", ",", "%rbx"});
                x86_code.push_back({"\tje", "L"+to_string(i)+"_M"+to_string(i+2)});
                x86_code.push_back({"L"+to_string(i)+"_M"+to_string(i+1)+":"});
                x86_code.push_back({"\timulq", "%r11", ",", "%rdx"});
                x86_code.push_back({"\tdecq", "%rbx"});
                x86_code.push_back({"\tcmpq", "$0", ",", "%rbx"});
                x86_code.push_back({"\tjne", "L"+to_string(i)+"_M"+to_string(i+1)});
                x86_code.push_back({"L"+to_string(i)+"_M"+to_string(i+2)+":"});
                x86_code.push_back({"\tmovq", "%rdx", ",", "0(%r13)"});
            }
            else if(op == "<<"){
                x86_code.push_back({"\tmovq", "%r12", ",", "%rbx"});
                x86_code.push_back({"\tmovq", "%r11", ",", "%rdx"});
                x86_code.push_back({"\tmovq", "$0", ",", "%r12"});
                x86_code.push_back({"\tcmpq", "%rbx", ",", "%r12"});
                x86_code.push_back({"\tje", "L"+to_string(i)+"_M"+to_string(i+2)});
                x86_code.push_back({"L"+to_string(i)+"_M"+to_string(i+1)+":"});
                x86_code.push_back({"\tshlq", "$1", ",", "%rdx"});
                x86_code.push_back({"\tincq", "%r12"});
                x86_code.push_back({"\tcmpq", "%rbx", ",", "%r12"});
                x86_code.push_back({"\tjne", "L"+to_string(i)+"_M"+to_string(i+1)});
                x86_code.push_back({"L"+to_string(i)+"_M"+to_string(i+2)+":"});
                x86_code.push_back({"\tmovq", "%rdx", ",", "0(%r13)"});
            }
            else if(op == ">>"){
                x86_code.push_back({"\tmovq", "%r12", ",", "%rbx"});
                x86_code.push_back({"\tmovq", "%r11", ",", "%rdx"});
                x86_code.push_back({"\tmovq", "$0", ",", "%r12"});
                x86_code.push_back({"\tcmpq", "%rbx", ",", "%r12"});
                x86_code.push_back({"\tje", "L"+to_string(i)+"_M"+to_string(i+2)});
                x86_code.push_back({"L"+to_string(i)+"_M"+to_string(i+1)+":"});
                x86_code.push_back({"\tshrq", "$1", ",", "%rdx"});
                x86_code.push_back({"\tincq", "%r12"});
                x86_code.push_back({"\tcmpq", "%rbx", ",", "%r12"});
                x86_code.push_back({"\tjne", "L"+to_string(i)+"_M"+to_string(i+1)});
                x86_code.push_back({"L"+to_string(i)+"_M"+to_string(i+2)+":"});
                x86_code.push_back({"\tmovq", "%rdx", ",", "0(%r13)"});
            }
            else if(op == "<"){  // if a<b then see wrt b
                x86_code.push_back({"\tcmpq", "%r11", ",", "%r12"});
                x86_code.push_back({"\tsetg", "%al"});
                x86_code.push_back({"\tmovzbq", "%al", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == ">"){
                x86_code.push_back({"\tcmpq", "%r11", ",", "%r12"});
                x86_code.push_back({"\tsetl", "%al"});
                x86_code.push_back({"\tmovzbq", "%al", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == "<="){
                x86_code.push_back({"\tcmpq", "%r11", ",", "%r12"});
                x86_code.push_back({"\tsetge", "%al"});
                x86_code.push_back({"\tmovzbq", "%al", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == ">="){
                x86_code.push_back({"\tcmpq", "%r11", ",", "%r12"});
                x86_code.push_back({"\tsetle", "%al"});
                x86_code.push_back({"\tmovzbq", "%al", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == "=="){
                x86_code.push_back({"\tcmpq", "%r11", ",", "%r12"});
                x86_code.push_back({"\tsete", "%al"});
                x86_code.push_back({"\tmovzbq", "%al", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == "!="){
                x86_code.push_back({"\tcmpq", "%r11", ",", "%r12"});
                x86_code.push_back({"\tsetne", "%al"});
                x86_code.push_back({"\tmovzbq", "%al", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == "<>"){    //same as !=
                x86_code.push_back({"\tcmpq", "%r11", ",", "%r12"});
                x86_code.push_back({"\tsetne", "%al"});
                x86_code.push_back({"\tmovzbq", "%al", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == "&"){
                x86_code.push_back({"\tandq", "%r12", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == "|"){
                x86_code.push_back({"\torq", "%r12", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
            else if(op == "^"){
                x86_code.push_back({"\txorq", "%r12", ",", "%r11"});
                x86_code.push_back({"\tmovq", "%r11", ",", "0(%r13)"});
            }
        }
        }
        else{   //type 0 instruction

            // to get if instruction is a start of function
            // once check here, class ke functions are like class.funcname and here this doesnt work now
            if(instructions[i][1][instructions[i][1].size()-1] == ':'){
                // cerr<<"entered"<<endl;
                string func_name="";
                string s = instructions[i][1];
                size_t pos = s.find('.'); // Find the position of the first period
                if (pos != string::npos) {
                    s = s.substr(pos + 1); // Get the substring after the first period
                    for(int l=0;l<s.size()-1;l++){
                        func_name.push_back(s[l]);
                    } 
                    // cerr<<instructions[i][1].substr(0,pos)<<endl;
                    curr_func_ste=single_rev_lookup(class_map[instructions[i][1].substr(0,pos)]->next_scope,func_name);
                    // cerr<<curr_func_ste->lexeme<<endl;
                    obj_class_ste = class_map[instructions[i][1].substr(0,pos)];
                }
                else{
                    for(int l=0;l<instructions[i][1].size()-1;l++){
                        func_name.push_back(instructions[i][1][l]);
                    }   
                    curr_func_ste=single_rev_lookup(global_sym_table,func_name);
                }
                x86_code.push_back({instructions[i][1]});
            }

            else if(instructions[i][1]=="BeginFunc"){
                //nothing needs to be done here
            }

            else if(instructions[i][2]=="RBP"){
                x86_code.push_back({"\tpushq", "%rbp"});
                x86_code.push_back({"\tmovq", "%rsp", ",", "%rbp"}); 
                x86_code.push_back({"\tsubq", "$"+to_string(curr_func_ste->stack_width), ",", "%rsp"});
            }

            else if(instructions[i][3]=="PopParam"){
                //ignore
            }

            else if(instructions[i][1]=="StackPointer"){
                //ignore
            }

            else if(instructions[i][1]=="return"){  //handle return None
                stack_pos2(instructions[i][2]);
                x86_code.push_back({"\tmovq", "%r12", ",", "%r8"}); //r8 register stores the return value

                x86_code.push_back({"\taddq", "$"+to_string(curr_func_ste->stack_width), ",", "%rsp"});
                x86_code.push_back({"\tpopq", "%rbp"});
                x86_code.push_back({"\tret"});
            }

            else if(instructions[i][1]=="goto" && instructions[i][2]=="ra"){
                // x86_code.push_back({"\taddq", "$"+to_string(curr_func_ste->stack_width), ",", "%rsp"});
                // x86_code.push_back({"\tpop", "%rbp"});
                // x86_code.push_back({"\tret"});
            }

            else if(instructions[i][1]=="PopParamAll"){ 
                //cerr<<instructions[i][2]<<"here1"<<endl;
                int num_params = stoi(instructions[i][2]);
                num_params = num_params*8;
                x86_code.push_back({"\taddq", "$"+to_string(num_params), ",", "%rsp"});
            }

            else if(instructions[i][1]=="PushParamra"){
                //nothing needs to be done, rip is counter register and it automatically updates
            }

            else if(instructions[i][1]=="PushParam"){   //parameter push
                stack_pos1(instructions[i][2]);
                x86_code.push_back({"\tpushq", "%r11"});
            }

            else if(instructions[i][1]=="PopParamra"){
                if(curr_func_ste!=NULL){    // instruction[i][2] will always be a variable
                    int this_offset = curr_func_ste->offset_map[instructions[i][2]];
                    x86_code.push_back({"\tmovq", "%r8", ",", to_string(this_offset)+"(%rbp)"});
                }
            }

            else if(instructions[i][2] == "len"){
                stack_pos2(instructions[i][3]);
                x86_code.push_back({"\tmovq","0(%r12)",",","%r8"});
            }

            else if(instructions[i][2] == "printstr"){
                if(str_map.find(instructions[i][3]) != str_map.end()){
                    string s = instructions[i][3];  //removed the quotes
                    // x86_code.push_back({"\tmov", "$1", ",", "%rax"});
                    // x86_code.push_back({"\tmov", "$1",",","%rdi"});
                    // x86_code.push_back({"\tlea", "string"+to_string(str_id[s])+"(%rip)",",","%rsi"});
                    // x86_code.push_back({"\tmov", "$"+to_string(str_map[s].size()+1),",","%rdx"});
                    // x86_code.push_back({"\tsyscall"});

                    x86_code.push_back({"\tlea", "string"+to_string(str_id[s])+"(%rip)",",","%rdi"});
                    x86_code.push_back({"\tcall puts"});

                }
                else if(instructions[i][3].find('\"') != string::npos || instructions[i][3].find('\'') != string::npos){
                    string s = instructions[i][3].substr(1, instructions[i][3].size() - 2);  //removed the quotes
                    str_cnt++;
                    str_id[s] = str_cnt;
                    str_name = s;
                    str_temp=1;
                    x86_code.push_back({"\tmov", "$1", ",", "%rax"});
                    x86_code.push_back({"\tmov", "$1",",","%rdi"});
                    x86_code.push_back({"\tlea", "string"+to_string(str_cnt)+"(%rip)",",","%rsi"});
                    x86_code.push_back({"\tmov", "$"+to_string(s.size()),",","%rdx"});
                    x86_code.push_back({"\tsyscall"});
                }
                else{
                    stack_pos2(instructions[i][3]);

                    x86_code.push_back({"\tmovq", "%r12",",","%rdi"});
                    x86_code.push_back({"\tcall puts"});
                }
            }

            else if(instructions[i][2]=="print"){
                //cerr<<instructions[i][3]<<" "<<str_temp<<endl;

                if(str_temp==0){
                stack_pos2(instructions[i][3]);

                x86_code.push_back({"\tmovq", "%r12", ",", "%rsi"});
                x86_code.push_back({"\tlea", ".note0(%rip)",",", "%rax"});
                x86_code.push_back({"\tmovq", "%rax", ",", "%rdi"});
                x86_code.push_back({"\txor", "%rax", ",", "%rax"});
                x86_code.push_back({"\tcall", "printf@plt"}); 

                }


                // if(str_map.find(instructions[i][3]) != str_map.end()){
                //     string s = instructions[i][3];  //removed the quotes
                //     // x86_code.push_back({"\tmov", "$1", ",", "%rax"});
                //     // x86_code.push_back({"\tmov", "$1",",","%rdi"});
                //     // x86_code.push_back({"\tlea", "string"+to_string(str_id[s])+"(%rip)",",","%rsi"});
                //     // x86_code.push_back({"\tmov", "$"+to_string(str_map[s].size()+1),",","%rdx"});
                //     // x86_code.push_back({"\tsyscall"});

                //     x86_code.push_back({"\tlea", "string"+to_string(str_id[s])+"(%rip)",",","%rdi"});
                //     x86_code.push_back({"\tcall puts"});

                // }
                // else{
                //     stack_pos2(instructions[i][3]);
                //     if(str_temp==0){
                //         x86_code.push_back({"\tmovq", "%r12", ",", "%rsi"});
                //         x86_code.push_back({"\tlea", ".note0(%rip)",",", "%rax"});
                //         x86_code.push_back({"\tmovq", "%rax", ",", "%rdi"});
                //         x86_code.push_back({"\txor", "%rax", ",", "%rax"});
                //         x86_code.push_back({"\tcall", "printf@plt"}); 
                //     }
                //     else if(str_temp==1){
                //         string s = instructions[i][3].substr(1, instructions[i][3].size() - 2);  //removed the quotes
                //         str_name = s;

                //         x86_code.push_back({"\tmov", "$1", ",", "%rax"});
                //         x86_code.push_back({"\tmov", "$1",",","%rdi"});
                //         x86_code.push_back({"\tlea", "string"+to_string(str_cnt)+"(%rip)",",","%rsi"});
                //         x86_code.push_back({"\tmov", "$"+to_string(s.size()),",","%rdx"});
                //         x86_code.push_back({"\tsyscall"});
                //     }
                // }
            }

            else if(instructions[i][1]=="create_obj"){
                obj_in_constructor = instructions[i][3];
                x86_code.push_back({"\tmovq", "$"+instructions[i][2], ",", "%rdi"});
                x86_code.push_back({"\tcall", "malloc"});
                x86_code.push_back({"\tmovq", "%rax", ",", to_string(curr_func_ste->offset_map[instructions[i][3]])+"(%rbp)"});
            }

            else if(instructions[i][1]=="call"){
                if(instructions[i][3] != "main"){
                    if(instructions[i][2]=="self"){ //self function calls only, not attributes
                        string s = instructions[i][3];
                        size_t pos = s.find('.'); // Find the position of the first period
                        string obj_name;
                        string func_name;
                        if (pos != std::string::npos) {
                            obj_name = s.substr(0, pos); // Trim the string up to the first period
                            func_name = s.substr(pos + 1);
                        }
                        
                        ste* class_ste = obj_class_ste;
                        ste* c_ste=single_rev_lookup(class_ste->next_scope, func_name);
                        //cerr<<c_ste->lexeme<<endl;
                        if(c_ste!=NULL){
                            x86_code.push_back({"\tcall", class_ste->lexeme+"."+func_name});
                        }
                        else{
                            c_ste = lookup(class_ste, func_name);
                            while(c_ste->lexeme!="scope_head"){
                                c_ste = c_ste->prev;
                            }
                            c_ste = c_ste->prev_scope;
                            if(c_ste!=NULL){
                                x86_code.push_back({"\tcall", c_ste->lexeme+"."+func_name});
                            }
                            else{
                                cerr<<"Error: Function "<<func_name<<" not declared"<<endl;
                            }
                        }
                    }
                    else if(instructions[i][2]=="obj"){
                        // cerr<<"entered"<<endl;
                        string s = instructions[i][3];
                        size_t pos = s.find('.'); // Find the position of the first period
                        string obj_name;
                        string func_name;
                        if (pos != std::string::npos) {
                            obj_name = s.substr(0, pos); // Trim the string up to the first period
                            func_name = s.substr(pos + 1);
                        }
                        
                        x86_code.push_back({"\tmovq", to_string(curr_func_ste->offset_map[obj_name])+"(%rbp)", ",", "%r15"});

                        ste* class_ste = class_map[obj_class[obj_name]]; 
                        // cerr<<instructions[i][3]<<"yes"<<endl;
                        obj_class_ste = class_ste;
                        // cerr<<class_ste->lexeme<<endl;
                        ste* c_ste=single_rev_lookup(class_ste->next_scope, func_name);
                        if(c_ste!=NULL){
                            x86_code.push_back({"\tcall", class_ste->lexeme+"."+func_name});
                        }
                        else{
                            c_ste = lookup(class_ste, func_name);
                            while(c_ste->lexeme!="scope_head"){
                                c_ste = c_ste->prev;
                            }
                            c_ste = c_ste->prev_scope;
                            if(c_ste!=NULL){
                                x86_code.push_back({"\tcall", c_ste->lexeme+"."+func_name});
                            }
                            else{
                                cerr<<"Error: Function "<<func_name<<" not declared"<<endl;
                            }

                        }

                    }
                    else if(instructions[i][2]=="class"){
                        ste* class_ste = class_map[instructions[i][3]];
                        ste* c_ste=single_rev_lookup(class_ste->next_scope, "__init__");

                        x86_code.push_back({"\tmovq", to_string(curr_func_ste->offset_map[obj_in_constructor])+"(%rbp)", ",", "%r15"});
                        
                        if(c_ste != NULL){  //__init__ will be present in every class
                            x86_code.push_back({"\tcall",instructions[i][3]+".__init__"});
                        }
                    }
                    else if(instructions[i][2]=="class_func"){
                        
                        x86_code.push_back({"\tcall",instructions[i][3]+".__init__"});
                        
                    }
                    else if(instructions[i][2]=="function"){
                        x86_code.push_back({"\tcall", instructions[i][3]});
                    }
                }
            }

            //to see when funcends
            else if(instructions[i][1]=="EndFunc"){
                curr_func_ste = NULL;
            }

            else if(instructions[i][1]=="if"){ //True ke liye alag se
                stack_pos1(instructions[i][2]);
                x86_code.push_back({"\tcmpq", "$0", ",", "%r11"});
                x86_code.push_back({"\tjne", "L"+instructions[i][5]});
            }

            else if(instructions[i][1]=="goto"){
                if(instructions[i][2]!=""){
                    x86_code.push_back({"\tjmp","L"+instructions[i][2]});
                }
                else if(instructions[i][3]!=""){
                    x86_code.push_back({"\tjmp","L"+instructions[i][3]});
                }
                else if(instructions[i][4]!=""){
                    x86_code.push_back({"\tjmp","L"+instructions[i][4]});
                }
                else if(instructions[i][5]!=""){
                    x86_code.push_back({"\tjmp","L"+instructions[i][5]});
                }
            }

            else if(instructions[i][1] == "Heapalloc"){ //heapalloc numberofelements
                //cerr<<instructions[i][2]<<endl;
                x86_code.push_back({"\tmovq", "$"+to_string(stoi(instructions[i][2])*8+8), ",", "%rdi"});
                x86_code.push_back({"\tcall", "malloc"});
            }

            else if(instructions[i][3].size()!=0 && instructions[i][3][0]=='['){
                // cerr<<"here"<<endl;
                // there may be case like instructions[i][1] = self.array so handle that    //done

                stack_pos_lhs(instructions[i][1]);
                x86_code.push_back({"\tmovq", "%rax", ",", "0(%r13)"});

                int array_index_bytes=0;
                string s = instructions[i][3];
                s = s.substr(1, s.size() - 2);  //removed the brackets

                stringstream ss(s);
                string item;
                vector<string> substrings;

                // Split by comma
                while (std::getline(ss, item, ',')) {
                    substrings.push_back(item);
                }

                int len=substrings.size();
                //x86_code.push_back({"\tmovq", "$"+to_string(substrings.size()), ",", to_string(array_index_bytes)+"(%rax)"});
                x86_code.push_back({"\tmovq", "$"+to_string(len), ",", "%r12"});
                x86_code.push_back({"\tmovq", "%r12", ",", to_string(array_index_bytes)+"(%rax)"});
                array_index_bytes+=8;
                

                // Now, substrings vector contains the substrings
                for (const auto element : substrings) {
                    // cerr<<element<<endl;
                    stack_pos2(element);
                    x86_code.push_back({"\tmovq", "%r12", ",", to_string(array_index_bytes)+"(%rax)"});
                    array_index_bytes+=8;
                }
            }

            else if(instructions[i][3].size()!=0 && (instructions[i][3][0]=='\"' || instructions[i][3][0]=='\'')){

                //x86_code.push_back({"\tmovq", "%rax", ",", to_string(curr_func_ste->offset_map[instructions[i][1]])+"(%rbp)"});
                string s = instructions[i][3].substr(1, instructions[i][3].size() - 2);  //removed the quotes

                str_map[instructions[i][1]] = s;
                str_name = s;
                str_cnt++;
                str_temp=1;
                str_id[instructions[i][1]] = str_cnt;

                x86_code.push_back({"\tlea", "string"+to_string(str_cnt)+"(%rip)", ",", "%r12"});
                x86_code.push_back({"\tmovq", "%r12", ",", to_string(curr_func_ste->offset_map[instructions[i][1]])+"(%rbp)"});

                // int str_index_bytes=0;

                // for(int j=0;j<s.size();j++){
                //     stack_pos2(to_string((int)s[j]));
                //     x86_code.push_back({"\tmovq", "%r12", ",", to_string(str_index_bytes)+"(%rax)"});
                //     str_index_bytes+=8;
                // }

                //x86_code.push_back({"\tmovq", "$string"+to_string(str_cnt), ",", "%r12"});
            }

            // else if(instructions[i][1].size()!=0 && instructions[i][1].find(':')!=string::npos){
            //     string s = instructions[i][1];
            //     //cerr<<s<<endl;
            //     size_t pos = s.find(':'); // Find the position of the first colon
            //     if (pos != std::string::npos) {
            //         s = s.substr(0, pos); // Trim the string up to the first colon
            //     }
                
            //     x86_code.push_back({"\tmovq", "%rax", ",", to_string(curr_func_ste->offset_map[s])+"(%rbp)"});
            //     int len = str_map[instructions[i][3]].size();
            //     int str_index_bytes=0;
            //     x86_code.push_back({"\tmovq", "$"+to_string(len), ",", "%r12"});
            //     x86_code.push_back({"\tmovq", "%r12", ",", to_string(str_index_bytes)+"(%rax)"});
            //     str_index_bytes+=8;

            //     //cerr<<instructions[i][3]<<endl;
            //     stack_pos_lhs(instructions[i][3]);
            //     for(int j=0;j<len;j++){
            //         x86_code.push_back({"\taddq", "$8", ",", "%r13"});
            //         x86_code.push_back({"\taddq", "$8", ",", "%rax"});
            //         x86_code.push_back({"\tmovq", "0(%r13)", ",", "%r15"});
            //         x86_code.push_back({"\tmovq", "%r15", ",", "0(%rax)"});
            //         //cerr<<"pushed char"<<j<<endl;
            //     }
            // }

            else if(instructions[i][2]=="="){
                //here also in if else you have to handle different types of c
                //handle swapped = false type
                // cerr<<instructions[i][3]<<endl;
                if(str_map.find(instructions[i][3]) != str_map.end()){
                    //cerr<<"here "<<(i+1)<<" "<<str_map[instructions[i][3]]<<endl;
                    // cerr<<i+1<<endl;
                    //cerr<<"hello"<<endl;
                    str_map[instructions[i][1]] = str_map[instructions[i][3]];
                    str_cnt++;
                    str_temp=1;
                    str_name = str_map[instructions[i][3]];
                    str_id[instructions[i][1]] = str_cnt;
                }
                else{
                    stack_pos_lhs(instructions[i][1]);
                    stack_pos2(instructions[i][3]);
                    x86_code.push_back({"\tmovq", "%r12", ",", "0(%r13)"});
                }
            }

            else if(instructions[i][1]=="EOF"){
                x86_code.push_back({"\t\tmov", "$60",",", "%rax"});
                x86_code.push_back({"\t\tmovq", "$0",",", "%rdi"});
                x86_code.push_back({"\t\tsyscall"});
            }
        }
        // cout<<i+1<<"done"<<endl;
    }
   
    x86_code.push_back({"format:\n\t.ascii", "\"%ld\\n\""});

    

}