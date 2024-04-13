#include <iostream>
#include <cmath>
using namespace std;


double f(double x){
        return 4046*(sqrt(pow(x, 14) + 1) - 1)/ pow(x, 14);
}

int main(){
    for (double i = 2; i > 0; i -= 0.01){
        cout << i << ": " << f(i) << endl;
    }
    cout << "\n<><><><><><><><><><><><><><><><\n";
    for (double i = 0.19; i > 0; i -= 0.001){
        cout << i << ": " << f(i) << endl;
    }
}