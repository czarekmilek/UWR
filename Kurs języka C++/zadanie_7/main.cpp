#include "UI.hpp"
#include <iostream>

using namespace UI;

int main() {

    char PlayAgain = '1';

    do {
        srand(time(nullptr));
        playGame();
        std::cout << "\nCzy chcesz zagrac ponownie? (Tak - wpisz 1, Nie - wpisz cokolwiek innego): ";
        std::cin >> PlayAgain;
        if ((PlayAgain) != '1') {
            std::cout << "Gra zostala zamknieta";
        }

    } while (PlayAgain == '1');
    return 0;
}