#include <math.h>
#include <stdio.h>

double series(double x)
{
    return  (pow(17.0, 2.0) * pow(x, 2.0) / 2)
            - (pow(17.0, 4.0) * pow(x, 4.0) / 24) 
            + (pow(17.0, 6.0) * pow(x, 6.0) / 720);
}

double formula(double x)
{
    return 14 * series(x) / pow(x, 2);
}

int main(void)
{
    for (int i = 11; i <= 20; i++)
    {
        printf("Double precision for i = %i -> %lf \n", i, formula(pow(10, -i)));
    }
}