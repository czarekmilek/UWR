def rozwiazanie_sudoku(s):
    def good_position(board, row, column, number):
        for i in range(9):
            if board[row][i] == number or board[i][column] == number:
                return False

        row_start, column_start = 3 * (row // 3), 3 * (column // 3)
        for i in range(row_start, row_start + 3):
            for j in range(column_start, column_start + 3):
                if board[i][j] == number:
                    return False

        return True

    def solve(board):
        for row in range(9):
            for column in range(9):
                if board[row][column] == 0:
                    for number in range(1, 10):
                        if good_position(board, row, column, number):
                            board[row][column] = number
                            if solve(board):
                                return True
                            board[row][column] = 0
                    return False
        return True

    if solve(s):
        return s
    else:
        return None

def print_sudoku(s):
    for i in range(9):
        if i % 3 == 0 and i != 0:
            print("- - - - - - - - - - - -")
        for j in range(9):
            if j % 3 == 0 and j != 0:
                print("|", end=" ")
            print(s[i][j], end=" ")
        print()


print("Rozwiązalne sudoku:")
print("(Przykład z treści zadania z usuniętynu niektórymi wartościami)")
print("-------------------")
partial_sudoku = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9]
]
print_sudoku(partial_sudoku)
print("-------------------\nROZWIĄZANE SUDOKU\n-------------------")
rozwiązanie = rozwiazanie_sudoku(partial_sudoku)
if rozwiązanie:
    print_sudoku(rozwiązanie)
else:
    print("Brak poprawnego rozwiązania.")

print("\n---------------------------\nPrzykład nierozwiązalnego sudoku:\n---------------------------")
print("Przykład ze strony: https://www.sudokudragon.com/unsolvable.htm")
unsolvable_sudoku = [
    [5, 1, 6, 8, 4, 9, 7, 3, 2],
    [3, 0, 7, 6, 0, 5, 0, 0, 0],
    [8, 0, 9, 7, 0, 0, 0, 6, 5],
    [1, 3, 5, 0, 6, 0, 9, 0, 7],
    [4, 7, 2, 5, 9, 1, 0, 0, 6],
    [9, 6, 8, 3, 7, 0, 0, 5, 0],
    [2, 5, 3, 1, 8, 6, 0, 7, 4],
    [6, 8, 4, 2, 0, 7, 5, 0, 0],
    [7, 9, 1, 0, 8, 0, 6, 0, 8]
]
print_sudoku(unsolvable_sudoku)
print("-------------------\nROZWIĄZANE SUDOKU\n-------------------")

rozwiązanie = rozwiazanie_sudoku(unsolvable_sudoku)
if rozwiązanie:
    print_sudoku(rozwiązanie)
else:
    print("Brak poprawnego rozwiązania.")
