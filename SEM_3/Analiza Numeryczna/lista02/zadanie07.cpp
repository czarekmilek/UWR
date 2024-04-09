#include <cmath>
#include <iostream>

double fun(double x)
{
    double res = 4046.0 / (sqrt(pow(x, 14) + 1.0) + 1.0);
    return res;
}

double fun_org(double x)
{
    double res = 4046.0 * (sqrt(pow(x, 14) + 1.0) - 1.0) / pow(x, 14);
    return res;
}

int main()
{
    std::cout << "Our original result: " << fun_org(0.001) << std::endl;
    std::cout << "Our new result estimation: " << fun(0.001) << std::endl;
}