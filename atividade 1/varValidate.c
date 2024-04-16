#include <stdio.h>

#define MAX 100

int firstValid(char c);
int allCharsValid(char *str);

int main() {
    char var[MAX];

    while (fgets(var, MAX, stdin) != NULL) 
    {
        if(firstValid(var[0]) && allCharsValid(var))
        {
            printf("valida\n");
        }
        else{
            printf("invalida\n");
        }
    }
    
    return 0;
}

int firstValid(char c)
{
    if (c >= 65 && c <= 90)
        return 1;
    if (c >= 97 && c <= 122)
        return 1;
    if (c == 95)
        return 1;
    return 0;
}

int allCharsValid(char *str)
{
    while (*str != '\0' && *str != 10) 
    {
        if(*str < 48 || *str > 122)
            return 0;
        if(*str > 57 && *str < 65)
            return 0;
        if(*str != 95 && (*str > 90 && *str < 97))
            return 0;
        str++;
    }
    return 1;
}