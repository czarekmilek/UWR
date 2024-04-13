#include <iostream>
#include <cmath>
using namespace std;

//3,141592 <- tyle ma wyjść
//3.141590 <- 4 poza, 500 tys, działania na double
//3.141588 <- dla 4 poza, 250 tys. działania na double
//3.141588 <- dla 4 w, 250 tys, działania na double
//3.141590 <- dla 4 w 500tys, działania na double
//3.141592 <- dla 4 w dla 4mln, działania na double
//3.141592 <- dla 4 w ,dla 2mln, działania na double
//3.141592 <- dla 4 poza, dla 2 mln, działania na double
//3.141593 <- dla 4 poza, dla 2mln - 1, działania na double
double  pi_seq(int a){
    double acc = 0.0;
    for (int i = 0; i < a; i++){
        acc += (pow((-1.0), i)/(2.0*i + 1.0));
    }
    return 4*acc;
}


int main(void){
    printf("Double precision %.20lf \n", pi_seq(1999999));
    printf("Double precision %.20lf \n", pi_seq(2000000));
    printf("Double precision %.20lf \n", pi_seq(2000001));
}