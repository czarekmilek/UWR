#include "stdio.h"
#include "math.h"

double f(double x, double a, int r){
    return pow(x - a, r);
}
double fd(double x, double a, int r){
    return r*pow(x-a, r-1);
}

double g(double x, double a, int r){
    return pow(f(x, a, r), 1/r);
}
double gd(double x, double a, int r){
    return (1/r)*(pow(f(x, a, r), (1/r)-1)*fd(x, a, r));
}

double newtons_method(double xn, int r, double a, int steps, int approx){

    int result = (int)((sqrt(a)) * approx); // miejsca po przecinku, liczba zależna od approx
    printf("---- What we want: %d -----\nWhat we get:\n", result);

    printf("xn: \t%d\n", (int)(xn * approx));
    printf("xn+1: \t%d\n", (int)((xn - g(xn, a, r)/gd(xn, a, r)) * approx));
    printf("--------------------------\n");
    
    if (result == (int)(xn * approx))
    {
        printf("Iterations: %d\n", steps);
        // return (double)(xn*approx);
        return xn;
    }
    // jeśli przesadziliśmy
    else if (steps > 10){
        printf("Wrong starting point...\nAfter %i steps we have: ", steps);
        return xn;
    }
    else {
        return newtons_method((1.0/2.0)*(xn + (a/xn)), r, a,  steps + 1, approx);
    }
}

int main(void){
    printf("%lf\n", newtons_method(3.0, 3, 3.0, 0, 1e9));
    return 0;
}