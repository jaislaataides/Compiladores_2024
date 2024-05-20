%{
int yyerror(const char *s);
int yylex(void);
%}

%define parse.error verbose

%token TOK_IDENT
%token TOK_PRINT
%token TOK_BOOL
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
%token TOK_MENOROU
%token TOK_MAIOROU
%token TOK_OR 
%token TOK_AND

%start program

%%

program : globals;

globals : globals global{
}

globals : global{
}

global : atribuition | loop | print | selection | break{
}

atribuition : TOK_IDENT '=' numeric_expression ';'{
}

atribuition: TOK_IDENT '=' tok ';'{
}

tok : factor{
}

tok : bool{
}

tok : TOK_STRING{
}

tok : TOK_CHAR{
}

numeric_expression : numeric_expression '+' numeric_term{
} 

numeric_expression : numeric_expression '-' numeric_term{
}

numeric_expression : numeric_term{
}

numeric_term : numeric_term '*' numeric_factor{
}

numeric_term : numeric_term '/' numeric_factor{
}

numeric_term : numeric_factor{
}

numeric_factor : '(' numeric_expression ')'{
}

numeric_factor : TOK_IDENT{
}

numeric_factor : TOK_INT{
}

numeric_factor : TOK_FLOAT{
}

numeric_factor : unary{
} 

unary : '-' numeric_factor{
}

print : TOK_PRINT '(' factor ')'';'{
}

print : TOK_PRINT '(' condition ')'';'{
}

print : TOK_PRINT '(' numeric_expression ')'';'{
}

print : TOK_PRINT '(' TOK_STRING ')'';'{
}

selection : TOK_IF '(' condition ')' '{' global '}'{
}

selection : TOK_IF '(' condition ')' '{' global '}' TOK_ELSE '{' global '}'{
}

selection : TOK_IF '(' condition ')' '{' global '}' TOK_ELSE selection {    
}

condition : condition TOK_OR condition{
}

condition: condition TOK_AND condition {
}

condition : bool{
}

bool : TOK_TRUE{
}

bool : TOK_FALSE{
}

condition : factor logic_operator factor{
}

factor : numeric_factor{
}

factor : TOK_CHAR{
}

factor : TOK_STRING{
}

logic_operator : TOK_DIFERENTE{
}

logic_operator : TOK_IGUAL{
}

logic_operator : '<'{
}

logic_operator : TOK_MENOROU{
}

logic_operator : '>'{
}

logic_operator : TOK_MAIOROU{
}

loop : TOK_LOOP '(' TOK_INT ';' TOK_INT ';' TOK_INT ')''{' global '}'{
}

loop : TOK_LOOP '(' condition ')''{' global '}'{
}

loop : TOK_LOOP '(' bool ')''{' global '}'{
}

break : TOK_BREAK ';'{
}

%%