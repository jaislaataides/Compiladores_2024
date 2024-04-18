#include <stdio.h>

#define MAIORQUE(a, b) (a) > (b) ? a : b

int main()
{
    if(MAIORQUE(40, 35))
        printf("40 > 35");
}