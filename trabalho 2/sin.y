%{
#include "nodes.h"

int yyerror(const char *s);
int yylex(void);

int errorcount=0;
extern bool force_print_tree;
%}

%define parse.error verbose
%define parse.trace

%union {
    char *str;
    int itg;
    double flt;
    char chr;
    Node *node;
}

%token TOK_IDENT
%token TOK_PRINT
%token TOK_SCAN
%token TOK_INT
%token TOK_FLOAT
%token TOK_STRING
%token TOK_CHAR
%token TOK_IF
%token TOK_ELSE
%token TOK_LOOP
%token TOK_BREAK
%token TOK_TRUE
%token TOK_FALSE
%token TOK_IGUAL
%token TOK_DIFERENTE
%token TOK_MEOI
%token TOK_MAOI
%token TOK_OR 
%token TOK_AND
%token TIPO_INT
%token TIPO_FLOAT
%token TIPO_STRING
%token TIPO_CHAR
%token TIPO_BOOL

%type<str> TOK_IDENT TOK_STRING TOK_SCAN 
%type<chr> TOK_CHAR
%type<itg> TOK_INT 
%type<flt> TOK_FLOAT

%type<node> globals global tok numeral numeric_expression numeric_term numeric_factor
 declaration atribuition selection unary print condition bool loop type initial

%printer { fprintf(yyo, "%s", $$);} <str>
%printer { fprintf(yyo, "%d", $$);} <itg>
%printer { fprintf(yyo, "%f", $$);} <flt>

%start program

%%

program : globals {
    Node *program = new Program();
    program-> append($globals);

    CheckVarDecl cvd;
    cvd.check(program);

    if (errorcount > 0)
        cout << errorcount << " error(s) found" << endl;
    if (force_print_tree || errorcount == 0)
        printf_tree(program);
    else
        cout << "Errors found, not printing the tree." << endl;
}

globals : globals[gg] global {
               $gg->append($global);
               $$ = $gg;
          }
        | global {
               Node *n = new Node();
               n->append($global);
               $$ = n;
          }

global : declaration {$$ = $declaration;}
    | atribuition {$$ = $atribuition;} 
    | loop {$$ = $loop;}
    | print {$$ = $print;}
    | selection {$$ = $selection;}

declaration : type TOK_IDENT[str] '=' tok ';'{
    $$ = new Variable(new Ident($str), $type, $tok) ;
} 

atribuition: TOK_IDENT[str] '=' tok ';'{
    $$ = new Atribuition(new Ident($str), $tok);
}

atribuition : TOK_IDENT[str] '=' TOK_SCAN '(' type ')'';'{
    $$ = new AtribuitionScan(new Ident($str), $type);
}

type : TIPO_INT[str]{
    $$ = new TipoInt();
}

type : TIPO_FLOAT[str]{
    $$ = new TipoFloat();
}

type : TIPO_STRING[str]{
    $$ = new TipoString();
}

type : TIPO_BOOL[str]{
    $$ = new TipoBool();
}

type : TIPO_CHAR[str]{
    $$ = new TipoChar();
}

tok : TOK_STRING[str]{
    $$ = new String($str);
}

tok : condition{
    $$ = $condition;
}

tok : TOK_CHAR[chr]{
    $$ = new Char($chr);
}

numeric_expression : numeric_expression[e1] '+' numeric_term[t1]{
    $$ = new BinaryOp($e1, '+', $t1);
} 

numeric_expression : numeric_expression[e1] '-' numeric_term[t1]{
    $$ = new BinaryOp($e1, '-', $t1);
}

numeric_expression : numeric_term{
    $$ = $numeric_term;
}

numeric_term : numeric_term[t1] '*' numeric_factor[f1]{
    $$ = new BinaryOp($t1, '*', $f1);
}

numeric_term : numeric_term[t1] '/' numeric_factor[f1]{
    $$ = new BinaryOp($t1, '/', $f1);
}

numeric_term : numeric_factor{
    $$ = $numeric_factor;
}

numeric_factor : numeric_factor[f1] '^' numeral[n]{
    $$ = new BinaryOp($f1, '^', $n);
}

numeric_factor : numeral{
    $$ = $numeral;
}

numeral : '(' numeric_expression ')'{
    $$ = $numeric_expression;
}

numeral : TOK_IDENT[str]{
    $$ = new Ident($str);
}

numeral : TOK_INT[itg]{
    $$ = new Integer($itg);
}

numeral : TOK_FLOAT[flt]{
    $$ = new Float($flt);
}

numeral : unary{
    $$ = $unary;
} 

unary : '-' numeral{
    $$ = new Unary($numeral, '-');
}

print : TOK_PRINT '(' numeric_expression ')'';'{
    $$ = new PrintNode($numeric_expression);
}

print : TOK_PRINT '(' TOK_STRING[str] ')'';'{
    $$ = new Print($str);
}

selection : TOK_IF '(' condition ')' '{' globals '}'{
    $$ = new If($condition, $globals);
}

selection : TOK_IF '(' condition ')' '{' globals[glob] '}' TOK_ELSE '{' globals[glob_glob] '}'{
    $$ = new IfElse($condition, $glob, $glob_glob);
}


condition : numeric_factor[f1] TOK_MEOI numeric_factor[f2]{
        $$ = new BinaryOpp($f1, "<=", $f2);
    }
    | numeric_factor[f1] TOK_MAOI numeric_factor[f2] {
        $$ = new BinaryOpp($f1, ">=", $f2);
    }
    | numeric_factor[f1] TOK_IGUAL numeric_factor[f2]{
        $$ = new BinaryOpp($f1, "==", $f2);
    }
    | numeric_factor[f1] TOK_DIFERENTE numeric_factor[f2]{
        $$ = new BinaryOpp($f1, "!=", $f2);
    }
    | numeric_factor[f1] '<' numeric_factor[f2]{
        $$ = new BinaryOp($f1, '<', $f2);
    }
    | numeric_factor[f1] '>' numeric_factor[f2]{
        $$ = new BinaryOp($f1, '>', $f2);
    }

condition : '(' condition[c1] TOK_OR condition[c2] ')'{
    $$ = new BinaryOpp($c1, "||", $c2);
}

condition: '(' condition[c1] TOK_AND condition[c2] ')' {
    $$ = new BinaryOpp($c1, "&&", $c2);
}

condition : numeric_expression{
    $$ = $numeric_expression;
}

condition : bool{
    $$ = $bool;
}

bool : TOK_TRUE{
    $$ = new True();
}

bool : TOK_FALSE{
    $$ = new False();
}

loop : TOK_LOOP '(' initial  condition ';' numeric_expression ')''{' globals '}'{
    $$ = new LoopFor($initial, $condition, $numeric_expression, $globals);

}

loop : TOK_LOOP '(' condition ')''{' globals '}'{
    $$ = new LoopWhile($condition, $globals);
}

initial : declaration {$$ = $declaration;}
    | atribuition{$$ = $atribuition;}

%%