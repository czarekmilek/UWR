#include <cmath>
#include <iostream>

double fun_org(double x)
{
    double res = log2(x) - 2;
    return res;
}

double fun(double x)
{
    double res = log2(x/4.0);
    return res;
}

int main()
{
    printf("Our org result estimation: %.27lf\n", fun_org(3.99999999999));
    printf("Our org result estimation: %.27lf\n", fun_org(3.999999999999));
    printf("Our org result estimation: %.27lf\n", fun_org(3.9999999999999));
    printf("Our org result estimation: %.27lf\n", fun_org(3.99999999999999));
    printf("Our org result estimation: %.27lf\n\n", fun_org(3.999999999999999));
    
    printf("Our new result estimation: %.27lf\n", fun(3.99999999999));;
    printf("Our new result estimation: %.27lf\n", fun(3.999999999999));;
    printf("Our new result estimation: %.27lf\n", fun(3.9999999999999));;
    printf("Our new result estimation: %.27lf\n", fun(3.99999999999999));;
    printf("Our new result estimation: %.27lf\n", fun(3.999999999999999));;


    //  std::cout << "Our new result estimation: " << fun_org(3.999999999999999) << std::endl;
    //  std::cout << "Our new result estimation: " << fun(3.999999999999999) << std::endl;

}