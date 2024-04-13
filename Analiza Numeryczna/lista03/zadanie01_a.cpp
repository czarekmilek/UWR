#include <cmath>
#include <iostream>

double fun_org(long double x)
{
    double res = pow((pow(x, 3) + sqrt(pow(x, 6) + pow(2023, 2))), -1);
    return res;
}

double fun(double x)
{
    if(x < 0){
        double res = ( ( sqrt(pow(x, 6) + pow(2023, 2) ) + abs(pow(x, 3)) ) / pow(2023, 2) );
        return res;
    }
    else{
        double res = fun_org(x);
        return res;
    }
}

int main()
{
    /*
    for(long double i = 0.0; i > -7000.0; i-=100.0){
        std::cout << "Our original result for i = " << i << ": " << fun_org(i) << std::endl;
        std::cout << "Our new result for i = " << i << ": " << fun(i) << std::endl;
    }
    */
std::cout << "Our org result estimation for -100: " << fun_org(-100) << std::endl;
std::cout << "Our new result estimation for -100: " << fun(-100) << std::endl;
// std::cout << "Our n2w result estimation for -1 000: " << fun1(-1000) << std::endl;

std::cout << "Our org result estimation for -100 000: " << fun_org(-100000) << std::endl;
std::cout << "Our new result estimation for -100 000: " << fun(-100000) << std::endl;
// std::cout << "Our n2w result estimation for -1 000: " << fun1(-100000) << std::endl;

std::cout << "Our org result estimation for -1 000 000: " << fun_org(-1000000) << std::endl;
std::cout << "Our new result estimation for -1 000 000: " << fun(-1000000) << std::endl;
// std::cout << "Our n2w result estimation for -1 000: " << fun1(-1000000) << std::endl;

// std::cout << "\nOur org result estimation for 1 000: " << fun_org(1000) << std::endl;
// std::cout << "Our new result estimation for 1 000: " << fun(1000) << std::endl;

// std::cout << "Our org result estimation for 100 000: " << fun_org(100000) << std::endl;
// std::cout << "Our new result estimation for 100 000: " << fun(100000) << std::endl;

std::cout << "\nOur org result estimation for 1 000 000: " << fun_org(1000000) << std::endl;
std::cout << "Our new result estimation for 1 000 000: " << fun(1000000) << std::endl;

std::cout << "\nOur org result estimation for -1e7: " << fun_org(-1e7) << std::endl;
std::cout << "Our new result estimation for -1e7: " << fun(-1e7) << std::endl;

}

/*
double fun2(double x)
{
    double res = (sqrt(pow(x, 6) + pow(2023, 2) + abs(pow(x, 3))))/(pow(2023, 2));
    return res;
}
*/
