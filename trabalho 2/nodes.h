#include <iostream>
#include <vector>
#include <map>
#include <set>

extern int errorcount;
extern int yylineno;
extern char *build_file_name;

using namespace std;

class Node{
protected:
    int lineno;

public:
    vector<Node *> children;
    
    Node(){
        lineno = yylineno;
    }

    int getLineNo(){
        return lineno;
    }

    virtual string toStr(){
        return "stmt";
    }

    void append(Node *n){
        children.push_back(n);
    }

    vector<Node *> &getChildren(){
        return children;
    }
};

class Program : public Node{
public:
    virtual string toStr() override{
        return "Program";
    }
};

class Integer : public Node{
protected:
    int value;
public:
    Integer(const int v){
        value = v;
    }
    virtual string toStr() override{

        return to_string(value);
    }
};

class Float : public Node{
protected:
    int value;
public:
    Float(const float v){
        value = v;
    }
    virtual string toStr() override{

        return to_string(value);
    }
};

class Ident : public Node{
    protected:
        string name;

    public:
        Ident(const string n){
            name = n;
        }

        string getName(){
            return name;
        }

        virtual string toStr() override{

            return name;
        }
};

class Unary : public Node{
protected:
    Node *value;
    char operation;

public:
    Unary(Node *v, char op)
    {
        value = v;
        operation = op;
        children.push_back(v);
    }

    virtual string toStr() override
    {
        string aux;
        aux.push_back(operation);
        return aux;
    }
};

class BinaryOp : public Node{
    protected:
        Node *value1;
        char operation;
        Node *value2;
    public:
        BinaryOp(Node *v1, char op, Node *v2){
            value1 = v1;
            operation = op;
            value2 = v2;
            children.push_back(v1);
            children.push_back(v2);
        }
        virtual string toStr() override{
            string aux;
            aux.push_back(operation);
            return aux;
        }
};

class BinaryOpp : public Node{
protected:
    Node *value1;
    string operation;
    Node *value2;
public:
    BinaryOpp(Node *v1, string op, Node *v2){
        value1 = v1;
        value2 = v2;
        operation = op;
        children.push_back(v1);
        children.push_back(v2);
    }
    virtual string toStr() override{
        return operation;
    }
};

class Print : public Node{
    protected:
        string value;

    public:
        Print(string v){
            value = v;
        }

        virtual string toStr() {
            return "print";
        }
};

class PrintNode : public Node{
    protected:
        Node *value;

    public:
        PrintNode(Node *v){
            value = v;
        }

        virtual string toStr() {
            return "print";
        }
};


class Scan : public Node{
    protected:
        Node *type;
    
    public:
        Scan(Node *t) : type(t){
            children.push_back(type);
        }

        Node getType(){
            return *type;
        }

        virtual string toStr(){
            return "scan";
        }
};

class String : public Node {
    protected:
        string value;
    public:
        String(string v){
            value = v;
        }
        virtual string toStr(){
            return value;
        }
};

class Char : public Node {
    protected:
        char value;
    public:
        Char(char v){
            value = v;
        }

        virtual string toStr(){
            string aux;
            aux.push_back(value);
            return aux;
        }
};

class Bool : public Node{
    protected:
        bool value;
    public:
        Bool(bool v){
            value = v;
        }

        virtual string toStr(){
            return ""+value;
        }
};

class If : public Node{
    protected:
        Node *condition;
        Node *body;

    public:
        If(Node *c, Node *b) : condition(c), body(b){
            children.push_back(condition);
            children.push_back(body);
        }

        virtual string toStr(){
            return "if";
        }
};

class IfElse : public Node{
    protected:
        Node *condition;
        Node *body;
        Node *head;

    public:
        IfElse(Node *c, Node *h, Node *b) : condition(c), head(h), body(b){
            children.push_back(condition);
            children.push_back(head);
            children.push_back(body);
        }

        virtual string toStr(){
            return "ifelse";
        }
};

class LoopFor : public Node{
    protected:
        Node *initial;
        Node *condition;
        Node *step;
        Node *action;

    public:
        LoopFor(Node *i, Node *c, Node *s, Node *a) : initial(i), condition(c), 
        step(s), action(a){
            children.push_back(initial);
            children.push_back(condition);
            children.push_back(step);
            children.push_back(action);
        }

        virtual string toStr(){
            return "loop";
        }
};

class LoopWhile : public Node{
    protected:
    Node *condition;
    Node *body;

    public:
        LoopWhile(Node *c, Node *b) : condition(c), body(b){
            children.push_back(condition);
            children.push_back(body);
        }
        
        virtual string toStr(){
            return "loop";
        }
};

class Variable : public Node{
    protected:
        Ident *ident;
        Node *type;
        Node *value;

    public:
        Variable(Ident *i, Node *t, Node *v) : ident(i), type(t), value(v){
            children.push_back(type);
            children.push_back(value);
        }

        string getTypeName(){
            return type->toStr();
        }

        Node getType(){
            return *type;
        }

        string getName(){
            return ident->getName();
        }

        void setValue(Node *v){
            value = v;
        }

        virtual string toStr(){
            return ident->getName();
        }
};

class Atribuition : public Node{
    protected:
        Ident *ident;
        Node *value;

    public:
        Atribuition(Ident *i, Node *v) : ident(i), value(v){
            children.push_back(value);
        }

        virtual string toStr(){
            return ident->toStr();
        }
};

class AtribuitionScan : public Node{
    protected:
        Ident *ident;
        Node *type;

    public:
        AtribuitionScan(Ident *i, Node *t) : ident(i), type(t){
            /*Função que escaneia*/
            /*atribuição através do valor obtido*/
        }

        virtual string toStr(){
            return ident->toStr();
        }
};

class True : public Node{
    public:
        virtual string toStr(){
            return "true";
        }
};

class False : public Node{
    public:
        virtual string toStr(){
            return "false";
        }
};

class TipoInt : public Node{
    public:
        TipoInt(){}
        virtual string toStr(){
            return "int";
        }
};

class TipoFloat : public Node{
    public:
        TipoFloat(){}
        virtual string toStr(){
            return "float";
        }
};

class TipoString : public Node{
    public:
        TipoString(){}
        virtual string toStr(){
            return "string";
        }
};

class TipoChar : public Node{
    public:
        TipoChar(){}
        virtual string toStr(){
            return "char";
        }
};

class TipoBool : public Node{
    public:
        TipoBool(){}
        virtual string toStr(){
            return "bool";
        }
};

void printf_tree_recursive(Node *noh){
    for (Node *c : noh->getChildren()){
        printf_tree_recursive(c);
    }
    cout << "N" << (long int)noh << "[label=\"" << noh->toStr() << "\"];" << endl;

    // imprime as ligações c/ os filhos
    for (Node *c : noh->getChildren()){
        cout << "N" << (long int)noh << "--" << "N" << (long int)c << ";" << endl;
    }
}

void printf_tree(Node *root){
    cout << "graph {" << endl;
    printf_tree_recursive(root);
    cout << "}" << endl;
}

class CheckVarDecl {
private:
    set<string> symbols;

public:
    CheckVarDecl() {}

    void check(Node *node){
        for (Node *c : node->getChildren()){
            check(c);
        }

        if(Ident *id = dynamic_cast<Ident*>(node)){// cria a variavel id e verifica se o nome dela esta na tabela de simbolos
            if(symbols.count(id->getName())<=0){
                cout << build_file_name
                     << ":"
                     << id->getLineNo()
                     << ":0: erro semantico : "
                     << id->getName()
                     << " nao declarado."
                     << endl;
                errorcount++;
            }
        }
        Variable *var = dynamic_cast<Variable*>(node);//outro metodo
        if(var){
            symbols.insert(var->getName());
        }
    }
};

