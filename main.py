#!/usr/bin/env python3
import sys

from lib import *

board = sudoku_board(sys.argv)
print("=======Input Board=======")
sudoku_print(board)
print()

if sudoku_solve(board):
    print("=======Solved!===========")
else:
    print("=======Unsolvable!=======")
sudoku_print(board)
