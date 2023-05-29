#include "StanGry.hpp"

namespace Game {

    char board[3][3] = { {' ', ' ', ' '}, {' ', ' ', ' '}, {' ', ' ', ' '} };
    int player = 1;

    TicTacToeGame::TicTacToeGame() {
        reset();
    }

    void TicTacToeGame::reset() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                board[i][j] = ' ';
            }
        }
        player = 1;
    }


    void TicTacToeGame::drawBoard() {
        std::cout << "  a   b   c\n";
        std::cout << "1 " << board[0][0] << " | " << board[0][1] << " | " << board[0][2] << std::endl;
        std::cout << "  --+---+--\n";
        std::cout << "2 " << board[1][0] << " | " << board[1][1] << " | " << board[1][2] << std::endl;
        std::cout << "  --+---+--\n";
        std::cout << "3 " << board[2][0] << " | " << board[2][1] << " | " << board[2][2] << std::endl;
    }

    bool checkLine(char a, char b, char c)
    {
        return (a != ' ') && (a == b) && (b == c);
    }

    int TicTacToeGame::checkWin() {
        //proste

        for (int i = 0; i < 3; i++) {
            if (checkLine(board[i][0], board[i][1], board[i][2]))
                return player;
            if (checkLine(board[0][i], board[1][i], board[2][i]))
                return player;
        }

        if (checkLine(board[0][0], board[1][1], board[2][2]))
            return player;
        if (checkLine(board[0][2], board[1][1], board[2][0]))
            return player;

        return 0;
    }

    bool TicTacToeGame::checkTie() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (board[i][j] != 'X' && board[i][j] != 'O')
                    return false;
            }
        }
        return true;
    }

    int getColNumber(std::string colString) {
        int col;
        if (colString != "a" && colString != "b" && colString != "c" && colString != "A" && colString != "B" && colString != "C") {
            std::cout << "Nieprawidłowy argument dla kolumny. \nPodaj numer wiersza i symbol kolumny (no. 2 b): ";
        }
        else {
            if (colString == "a" || colString == "A") {
                col = 1;
            } else if (colString == "b" || colString == "B") {
                col = 2;
            } else {
                col = 3;
            }
        }
        return col;
    }

    void TicTacToeGame::playerTurn() {
        int row = 0, col = 0;
        std::string colString;
        std::cout << "Kolej gracza " << player << ". \nPodaj numer wiersza i symbol kolumny (e.g. 2 b):  ";

        std::cin >> row >> colString;
        col = getColNumber(colString);

        /*
        if (colString != "a" && colString != "b" && colString != "c") {
            std::cout << "Nieprawidłowy argument dla kolumny. \nPodaj numer wiersza i symbol kolumny (no. 2 b): ";
        }
        else {
            if (colString == "a") {
                col = 1;
            } else if (colString == "b") {
                col = 2;
            } else {
                col = 3;
            }
        }
*/

        while (board[row - 1][col - 1] == 'X' || board[row - 1][col - 1] == 'O') {
            std::cout << "Pole jest zajete. \nPodaj numer wiersza i symbol kolumny (np. 2 b): ";
            std::cin >> row >> colString;
            col = getColNumber(colString);
        }

        while (row < 1 || row > 3 ) {
            std::cout << "Nieprawidlowy argument dla wiersza (poza zakresem 1-3). \nPodaj numer wiersza i symbol kolumny (np. 2 b): ";
            std:: cin >> row >> colString;
            col = getColNumber(colString);
        }

        board[row - 1][col - 1] = 'O';
    }
}
