#include <cmath>
#include <iostream>

double fun_org(double x){
    return ( (atan(x) - x) / pow(x, 3) );
    }


double fun(double x)
{
    return ( -(1.0/3.0) + (pow(x, 2.0)/5.0) - (pow(x, 4.0)/7.0) + (pow(x, 6.0)/9.0) );
}

int main()
{
    printf("Our org result estimation: %.27lf\n", fun_org(0.000000000000000000001)); //straciliśmy całą dokładność
    printf("Our new result estimation: %.27lf\n", fun(0.000000000000000000001));
}