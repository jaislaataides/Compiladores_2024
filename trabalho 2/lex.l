%{  
#include <stdio.h>
#include <stdlib.h>

char *build_file_name;
bool force_print_tree = false;
class Node;
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

"baboi" {return TOK_SCAN;}

"nah" {return TIPO_BOOL;}

"dul" {return TIPO_INT;}

"sae" {return TIPO_FLOAT;}

"po ka" {return TIPO_CHAR;}

"bello" {return TIPO_STRING;}

"||" { return TOK_OR;}
"&&" { return TOK_AND;}
"+" { return '+'; }
"-" { return '-'; }
"*" { return '*'; }
"/" { return '/'; }
"^" { return '^';}
"(" { return '('; }
")" { return ')'; }
";" { return ';'; }
"!=" { return TOK_DIFERENTE;}
"=" { return '='; }
"<=" { return TOK_MEOI;}
">=" { return TOK_MAOI;}
"==" { return TOK_IGUAL;}
">" {return '>';}
"<" {return '<';}
\{ { return '{'; }
\} { return '}'; }

"kan pai" {
    return TOK_TRUE;
}

"bee do" {
    return TOK_FALSE;
}

\'\'[a-zA-Z_' '0-9]+\'\' {
	yylval.str = strndup(yytext,yyleng);
    return TOK_STRING;
}

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.str = strndup(yytext,yyleng);
	return TOK_IDENT;
}

\'[a-zA-Z]\' {
    yylval.chr = yytext[1];
	return TOK_CHAR;
}

[0-9]+\.[0-9]* {
    yylval.flt = atof(yytext);
	return TOK_FLOAT;
}

[0-9]+ {
    yylval.itg = atoi(yytext);
	return TOK_INT;
}

. {
printf("simbolo nao reconhecido %c\n", yytext[0]);
}

%%

int yywrap(){
    return 1;
}

extern int errorcount;
extern int yydebug;

int yyerror(const char *s){
    printf("%s:%d:0: %s\n",build_file_name, yylineno, s);
	errorcount++;
    return 1;
}

int main(int argc, char *argv[]) {
	if(argc <= 1) {
		printf("Sintaxe: %s nome_do_programa\n", argv[0]);
		return 1;
	}
	
	int build_file_id=1;

	if(strcmp(argv[1], "-f")==0){
		force_print_tree = true;
		build_file_id++;
	}
	
	yydebug = 0;
	if(strcmp(argv[1], "-d")==0){
		yydebug = 1;
		build_file_id++;
	}

	build_file_name = argv[build_file_id];

	yyin = fopen(argv[build_file_id], "r");
	if(yyin == NULL){
		printf("Não foi possivel abrir o arquivo %s.\n", argv[1]);
		return 1;
	}
	
	
	yyparse();
	
	if(yyin)
		fclose(yyin);
		
	return 0;
}