#include <stdio.h>

#define MAIORQUE(a, b) (a) > (b) ? a : b

int main()
{
    if(MAIORQUE(5, 3))
        printf("5 > 3");
}