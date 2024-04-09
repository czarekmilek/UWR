#include <iostream>
#include <cmath>
using namespace std;

float ffloat(float x){   
    return 14*(1-(cosf(17 * x))/powf(x,2));
}

double fdouble(double x){   
    return 14*(1-(cos(17 * x))/pow(x,2));
}

int main(){
    cout << "======== FLOAT =========" << endl;
    for(float i = 11; i <= 20; i++){
        cout << ffloat(powf(10, -i)) << endl;
    }
    cout << "======== DOUBLE =========" << endl;
    for(double i = 11; i <= 20; i++){
    cout << fdouble(powf(10, -i)) << endl;
    }

    return 0;
}
