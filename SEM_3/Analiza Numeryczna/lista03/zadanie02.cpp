#include <iostream>
#include <cmath>

std::pair<double, double> org_alg(double a, double b, double c) {
    double delta = b * b - 4 * a * c;
    double x1 = (-b + sqrt(delta)) / (2 * a);
    double x2 = (-b - sqrt(delta)) / (2 * a);
    return std::make_pair(x1, x2);
}

std::pair<double, double> new_alg(double a, double b, double c) {
    double delta = b * b - 4 * a * c;
    double x1, x2;
    
    if (b > 0) {
        x1 = (-b - sqrt(delta)) / (2 * a);
    } else {
        x1 = (-b + sqrt(delta)) / (2 * a);
    }
    
    x2 = c / (a * x1);
    return std::make_pair(x2, x1);
}

int main() {
    std::cout << "Original algorithm:" << std::endl;
    auto org_result1 = org_alg(0.01, 770000, 0.0000077);
    auto org_result2 = org_alg(0.0000000678, 666, 0.00000000001);
    auto org_result3 = org_alg(0.00000000023, 2100000000000, 0.00000000022);
    auto org_result4 = org_alg(0.000001, 100000000, 0.0000001); 

    std::cout << " x_1 = " << org_result1.first << ", \t\tx_2 = " << org_result1.second << std::endl;
    std::cout << " x_1 = " << org_result2.first << ", \t\tx_2 = " << org_result2.second << std::endl;
    std::cout << " x_1 = " << org_result3.first << ", \t\tx_2 = " << org_result3.second << std::endl;
    std::cout << " x_1 = " << org_result4.first << ", \t\tx_2 = " << org_result4.second << std::endl;

    std::cout << std::endl;

    std::cout << "New algorithm:" << std::endl;
    auto new_result1 = new_alg(0.01, 770000, 0.0000077);
    auto new_result2 = new_alg(0.0000000678, 666, 0.00000000001);
    auto new_result3 = new_alg(0.00000000023, 2100000000000, 0.00000000022);
    auto new_result4 = new_alg(0.000001, 100000000, 0.0000001);

    std::cout << " x_1 = " << new_result1.first << ", \t\tx_2 = " << new_result1.second << std::endl;
    std::cout << " x_1 = " << new_result2.first << ", \tx_2 = " << new_result2.second << std::endl;
    std::cout << " x_1 = " << new_result3.first << ", \tx_2 = " << new_result3.second << std::endl;
    std::cout << " x_1 = " << new_result4.first << ", \t\tx_2 = " << new_result4.second << std::endl;

    return 0;
}
