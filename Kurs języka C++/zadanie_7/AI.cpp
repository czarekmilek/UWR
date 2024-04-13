#include "AI.hpp"
#include <cstdlib>
#include <iostream>



namespace AI {
    void computerTurn(char(*board)[3]) {
        int row = 0, col = 0;
        bool found = false;
        int center = 1;
        int max_count = 0;

        //  pole leżące bliżej środka planszy jest bardziej preferowane
        if (board[center][center] == ' ' ) {
            row = center;
            col = center;
            found = true;
        }
        else {
            for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 3; j++) {
                    int count = 0;
                    if (board[i][j] == ' ') {
                        if (i == j) count++; // lewa przekątna
                        if (i + j == 2) count++; // prawa przekątna
                        if (i == center) count++; // środek
                        if (j == center) count++; // środek 2

                        if (count > max_count) {
                            max_count = count;
                            row = i;
                            col = j;
                        }
                    }
                }
            }
        }
        if (!found && (max_count == 0 || rand() % 2 == 0)) {
            while (!found) {
                row = rand() % 3;
                col = rand() % 3;
                if (board[row][col] != 'X' && board[row][col] != 'O')
                    found = true;
            }
        }

        std::string colString;

        board[row][col] = 'X';
        if (col == 0) {
            colString = 'a';
        } else if (col == 1) {
            colString = 'b';
        } else {
            colString = 'c';
        }
        std::cout << "Komputer wybral " << row + 1 << " " << colString << std::endl;
    }
}
