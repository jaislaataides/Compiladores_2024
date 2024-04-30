%{
# include <stdio.>
%}

%%

"//".*\n { }

"print" { }

"+" {}
"-" {}
"*" {}
"/" {}
"=" {}
"(" {}
")" {}
";" {}

[a-zA-Z_] [a-zA-Z0-9_] { }

[0-9]+\.[0-9]* { }

[0-9]+ { }

. { 
printf("simbolo nao reconhecido %c\n", yytext[0]);
}


%%

int main(){
}
