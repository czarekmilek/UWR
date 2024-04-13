#include "stdio.h"
#include "math.h"

double newtons_method(double xn, double a, int steps, int approx){

    int result = (int)((sqrt(a)) * approx); // miejsca po przecinku, liczba zależna od approx
    printf("---- What we want: %d -----\nWhat we get:\n", result);

    printf("xn: \t%d\n", (int)(xn * approx));
    printf("xn+1: \t%d\n", (int)((1.0/2.0)*(xn + (a/xn))) * approx);
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
        return newtons_method((1.0/2.0)*(xn + (a/xn)), a,  steps + 1, approx);
    }
}

int main(void){
    printf("%lf\n", newtons_method(3.0, 3.0, 0, 1e9));
    return 0;
}