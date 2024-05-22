#include <iostream>
#include <vector>
#include <map>
#include <set>

using namespace std;

class Node{
protected:
        vector<Node*> children;
public:
    virtual string toStr(){
        return "node";
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
    virtual string toStr() override{

        return name;
    }
};

class Unary : public Node{
protected:
    Node *value;
    char operation;
public:
    Unary(Node *v, char op){
        value = v;
        operation = op;
    }
    virtual string toStr() override{
        string aux;
        aux.push_back(operation);
        return aux;
    }
};

class BinaryOp : public Node{
protected:
    Node *value1;
    Node *value2;
    char operation;
public:
    BinaryOp(Node *v1, Node *v2, char op){
        value1 = v1;
        value2 = v2;
        operation = op;
    }
    virtual string toStr() override{
        string aux;
        aux.push_back(operation);
        return aux;
    }
};

class Print{
protected:
    Node *value;

public:
    Print(Node *v){
        value = v;
    }

    virtual string toStr() {
        return "print";
    }
};

class Scan{
    protected:
        Node *value;
    
    public:
        Scan(Node *v){
            value = v;
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

class If{
    protected:
        Node *value;

    public:
        If(Node *v){
            value = v;
        }

        virtual string toStr(){
            return "if";
        }
};

//class Else

class Loop{
    protected:
        Node *value;

    public:
        Loop(Node *v){
            value = v;
        }

        virtual string toStr(){
            return "loop";
        }
};

class Break{
    protected:
        Node *value;
    
    public:
        Break(Node *v){
            value = v;
        }

        virtual string toStr(){
            return "break";
        }
};

class True{
    protected:
        Node *value;

    public:
        True(Node *v){
            value = v;
        }

        virtual string toStr(){
            return "true";
        }
};

class False{
    protected:
        Node *value;

    public:
        False(Node *v){
            value = v;
        }

        virtual string toStr(){
            return "false";
        }
};

class TipoInt{
    protected:
        Node *value;
    public:
        TipoInt(Node *v){
            value = v;
        }

        virtual string toStr(){
            return "int";
        }
};

class TipoFloat{
    protected:
        Node *value;

    public:
        TipoFloat(Node *v){
            value = v;
        }

        virtual string toStr(){
            return "float";
        }
};

class TipoString{
    protected:
        Node *value;
    
    public:
        TipoString(Node *v){
            value = v;
        }

        virtual string toStr(){
            return "string";
        }
};

class TipoChar{
    protected:
        Node *value;
    public:
        TipoChar(Node *v){
            value = v;
        }

        virtual string toStr(){
            return "char";
        }
};

class TipoBool{
    protected:
        Node *value;

    public:
        TipoBool(Node *v){
            value = v;
        }

        virtual string toStr(){
            return "bool";
        }
};