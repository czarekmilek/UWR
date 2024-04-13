#include "UI.hpp"

using namespace Game;

namespace UI {
    void playGame() {
        TicTacToeGame game;
        std::cout << "Kolko i krzyzyk" << std::endl;
        int winner = 0;
        bool tie = false;
        while (!winner && !tie) {
            game.drawBoard();
            if (game.player == 1)
                game.playerTurn();
            else
                AI::computerTurn(&game.board[0]);
            winner = game.checkWin();
            tie = game.checkTie();
            game.player = 3 - game.player; // zmiana gracza (1 -> 2 lub 2 -> 1)
        }
        game.drawBoard();
        if (winner)
            std::cout << "Gracz " << winner << " wygral!" << std::endl;
        else {
            std::cout << "Remis!" << std::endl;
        }
        return;
    }
}






