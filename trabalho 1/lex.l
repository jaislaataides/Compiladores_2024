%{  
#include <stdio.h>
#include "sin.tab.h"

int yyerror(const char *s);
%}

%option yylineno

%%

[ \t\r\n] { /* ignora */ }

"//".*\n { /* ignora */ }

"gru" {return TOK_PRINT;}

"chasy" {return TOK_IF;}

"ditto" {return TOK_ELSE;}

"pwede" {return TOK_LOOP;}

"stopa" {return TOK_BREAK;}

"+" { return '+'; }
"-" { return '-'; }
"*" { return '*'; }
"/" { return '/'; }
"(" { return '('; }
")" { return ')'; }
";" { return ';'; }
"!=" { return TOK_DIFERENTE;}
"=" { return '='; }
"<=" { return TOK_MENOROU;}
">=" { return TOK_MAIOROU;}
"==" { return TOK_IGUAL;}
">" {return '>';}
"<" {return '<';}
\{ { return '{'; }
\} { return '}'; }

"kan pai" {return TOK_TRUE;}

"bee do" {return TOK_FALSE;}

\"[a-zA-Z_' ']+\" {return TOK_STRING;}

[a-zA-Z_][a-zA-Z0-9_]* {return TOK_IDENT;}

\'[a-zA-Z]\' {return TOK_CHAR;}

[0-9]+\.[0-9]* {return TOK_FLOAT;}

[0-9]+ {return TOK_INT;}

. {
    printf("Simbolo nao reconhecido%c\n", yytext[0]);
    }

%%

int yywrap() {
    return 1;
}

int yyerror(const char *s){
    printf("Erro de sintaxe na linha %d: %s\n", yylineno, s);
    return 1;
}

int main(int argc, char *argv[]){

    if(argc <=1){
        printf("Sintaxe: %s nome_do_programa\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (yyin == NULL){
        printf("Não foi possível abrir o arquivo %s.\n", argv[1]);
        return 1;
    }

    yyparse();

    if (yyin)
        fclose(yyin);

    return 0;
}