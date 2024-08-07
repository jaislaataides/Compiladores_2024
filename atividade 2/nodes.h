#include <iostream>
#include <vector>
#include <map>
#include <set>

using namespace std;

class Node {
protected:
    vector<Node*> children;

public:
    virtual string toStr() {
        return "stmts";
    }
    void append(Node *n) {
        children.push_back(n);
    }
    vector<Node*>& getChildren(){
        return children;
    }
};

class Program : public Node{
public:
    virtual string toStr() override{
        return "Program";
    }
};

class Integer : public Node {
protected:
    int value;
public:
    Integer(const int v) {
        value = v;
    }

    virtual string toStr() override {
        return to_string(value);
    }
};

class Float : public Node {
protected:
    float value;
public:
    Float(const float v) {
        value = v;
    }

    virtual string toStr() override {
        return to_string(value);
    }
};

class Ident : public Node {
protected:
    string name;
public:
    Ident(const string n) {
        name = n;
    }

    virtual string toStr() override {
        return name;
    }
};

class Variable : public Node {
protected:
    string name;
    Node *value;
public:
    Variable(const string n, Node *v) {
        name = n;
        value = v;
        children.push_back(v);
    }

    virtual string toStr() override {
        return name + "=";
    }
};

class Unary : public Node {
protected:
    Node *value;
    char operation;

public:
    Unary(Node *v, char op) {
       value = v;
       operation = op;
       children.push_back(v);
    }

    virtual string toStr() override {
        string aux;
        aux.push_back(operation);
        return aux;
    }
};

class BinaryOp : public Node {
protected:
    Node *value1;
    Node *value2;
    char operation;

public:
    BinaryOp(Node *v1, Node *v2, char op) {
       value1 = v1;
       value2 = v2;
       operation = op;
       children.push_back(v1);
       children.push_back(v2);
    }

    virtual string toStr() override {
        string aux;
        aux.push_back(operation);
        return aux;
    }
};

class Print : public Node {
protected:
    Node *value;

public:
    Print(Node *v) {
        value = v;
        children.push_back(v);
    }

    virtual string toStr() {
        return "print";
    }
};

void printf_tree_recursive(Node *noh){
    for(Node *c : noh->getChildren()){
        printf_tree_recursive(c);
    }
    
    cout << "N" << (long int)noh << "[label=\"" << 
    noh->toStr() << "\"];" << endl;

    for(Node *c : noh->getChildren()){
        cout << "N" << (long int)noh << "--" << 
        "N" << (long int)c << ";" << endl;
    }

}

void printf_tree(Node *root){
    cout << "graph {" << endl;
    printf_tree_recursive(root);
    cout << "}" << endl;
}