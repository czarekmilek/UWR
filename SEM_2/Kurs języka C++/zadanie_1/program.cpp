#include <iostream>
#include <string>
#include <vector>
#include <utility>

using namespace std;

// Funkcja przekształcająca liczbę w postaci binarnej na rzymską
string bin2rzym(int x) {
    const vector<pair<int, string>> rzym = {
        {1000, "M"}, {900, "CM"}, {500, "D"}, {400, "CD"},
        {100, "C"}, {90, "XC"}, {50, "L"}, {40, "XL"},
        {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"}, {1, "I"}
    };

    string res = "";
    for (const auto& p : rzym) {
        while (x >= p.first) {
            res += p.second;
            x -= p.first;
        }
    }
    return res;
}

int main(int argc, const char* argv[]) {
    for (int i = 1; i < argc; i++) {
        try {
            int x = stoi(argv[i]);
            if (x < 1 || x > 3999) {
                clog << "Liczba spoza zakresu: " << argv[i] << endl;
                continue;
            }
            cout << bin2rzym(x) << endl;
        } catch (invalid_argument) {
            clog << "Niepoprawny argument: " << argv[i] << endl;
        }
    }
    
    return 0;
}
