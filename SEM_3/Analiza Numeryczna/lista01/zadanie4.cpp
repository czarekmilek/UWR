#include <iostream>
using namespace std;

double seq(int n){
    if (n == 0){
        return 1;
    } else if (n == 1){
        return -(1/9.0);
    }else {
        return (80.0/9.0)*seq(n-1) + seq(n-2);
    }
}

double seqc(int n){
    double acc = 1;
    for (int i = 0; i <= n; i++){
        acc *= -(1/9.0);
    }
    return acc;
}


int main(void){
    for (int i = 2; i <= 40; i++){
        printf("Double precision seq index: %d value: \t%lf \n", i, seq(i));
    }
    for (int i = 2; i <= 50; i++){
        printf("Double precision seqc index: %d value: \t%.10lf \n", i, seqc(i));
    }
    
}