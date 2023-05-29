#pragma once
#include <iostream>

namespace Game {
    class TicTacToeGame {
    public:
        char board[3][3];
        int player;
        TicTacToeGame();
        void reset();
        void drawBoard();
        int checkWin();
        bool checkTie();
        void playerTurn();
    };
}
