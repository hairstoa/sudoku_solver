
def get_file_path(args):
    if len(args) == 1:
        print("Invalid use. Example: main path/to/sudoku/file\n")
        quit()
    else:
        return args[1]

def read_file(path):
    file = open(path, "r")
    lines = file.readlines()
    file.close()

    return lines

def sudoku_board(args):

    path = get_file_path(args)
    board = read_file(path)

    for x in range(len(board)):
        board[x] = board[x].replace(" ","")
        board[x] = board[x].replace("\n","")
        string = board[x]
        num_array = []

        for char in string:
            num_array.append(char)

        board[x] = num_array

    return board

def valid_x(board, number, row):
    for y in range(len(board[row])):
        if board[row][y] == str(number):
            return False

    return True

def valid_y(board, number, column):
    for x in range(len(board)):
        if board[x][column] == str(number):
            return False

    return True

def valid_group(board, number, row, column):
    local_y = row - row % 3
    local_x = column - column % 3

    for y in range(3):
        for x in range(3):
            if board[y + local_y][x + local_x] == str(number):
                return False

    return True

def valid(board, number, row, column):
    return valid_x(board, number, row) and valid_y(board, number, column) and valid_group(board, number, row, column)

def sudoku_solve(board):
    for row in range(len(board)):
        for column in range(len(board[row])):
            if board[row][column] == str(0):
                for num in range(1, len(board[row]) + 1):
                    if valid(board, num, row, column):
                        board[row][column] = str(num)
                        if sudoku_solve(board):
                            return True
                        else:
                            board[row][column] = str(0)
                return False
    return True


def sudoku_print(board):

    for index_y in range(len(board)):
        row_string = ""
        if index_y == 3 or index_y == 6:
            print("---+---+---")
        for index_x in range(len(board[index_y])):
            if index_x == 3 or index_x == 6:
                row_string = row_string + "|"
            row_string = row_string + board[index_y][index_x]

        print(row_string)

