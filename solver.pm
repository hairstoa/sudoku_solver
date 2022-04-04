#!/usr/bin/perl

package Solver;
use strict;
use warnings;

use Data::Dumper;

# our @ISA = qw ( Exporter );
# our @EXPORT = qw ( solveBoard printBoard ); 

#my @board = (
#  [ 7, 0, 2, 0, 5, 0, 6, 0, 0],
#  [ 0, 0, 0, 0, 0, 3, 0, 0, 0],
#  [ 1, 0, 0, 0, 0, 9, 5, 0, 0],
#  [ 8, 0, 0, 0, 0, 0, 0, 9, 0],
#  [ 0, 4, 3, 0, 0, 0, 7, 5, 0],
#  [ 0, 9, 0, 0, 0, 0, 0, 0, 8], 
#  [ 0, 0, 9, 7, 0, 0, 0, 0, 5],
#  [ 0, 0, 0, 2, 0, 0, 0, 0, 0],
#  [ 0, 0, 7, 0, 4, 0, 2, 0, 3],
#);

my $GRID_SIZE = 9;

# Parameters: int[][] board, int number, int row
# Returns: Boolean
sub checkRow {
  # my ( @board, $number, $row ) = @_;
   my @board = @{$_[0]};
   my $number = $_[1];
   my $row = $_[2];
   
  my @temp_row = @{$board[$row]};
  for my $square ( @temp_row){
    if ( $square == $number) {
      return 1;
    }
  }
    return 0;
}

# Parameters: int[][] board, int number, int column
# Returns: Boolean
sub checkColumn {
  # my ( @board, $number, $column ) = @_;
   my @board = @{$_[0]};
   my $number = $_[1];
   my $column = $_[2];
  
  for my $row (@board) {
    # my @this_row = (@{$row});
    if (@{$row}[$column] == $number) {
      return 1;
    }
  }
    return 0;
}

# Parameters: int[][] board, int number, int row, int column
# Returns: Boolean
sub checkBox {
  # my ( @board, $number, $column ) = @_;
  my @board = @{$_[0]};
  my $number = $_[1];
  my $row = $_[2];
  my $column = $_[3];
   
  # Get the local start coordinates for the number
  # based on the row and column location of the number
  my $local_row = $row - $row % 3;
  my $local_column = $column - $column % 3;

  # Search the box from the coordinates
  for (my $i = $local_row; $i < $local_row + 3; $i++) {
    for (my $j = $local_column; $j < $local_column + 3; $j++) {
      if ($board[$i][$j] == $number) {
        return 1;
      }
    } 
  }
  return 0;
}

# Check the box, row, and column for a valid placement
# The placement is valid if the row, column, and 3 x 3
# nine-drant does not contain the number
sub checkBoard {
  my @board = @{ $_[0]};
  my $number = $_[1];
  my $row = $_[2];
  my $column = $_[3];
  if ( !checkRow(\@board, $number, $row) &&
       !checkColumn(\@board, $number, $column) &&
       !checkBox(\@board, $number, $row, $column)) {
    return 1;
  }
  return 0;
}

# Loop through the entire board checking for valid possibilities
sub solveBoard {
  my @board = @{ $_[0]};
  
  for (my $row = 0; $row < $GRID_SIZE; $row++) {
    for (my $column = 0; $column < $GRID_SIZE; $column++) {
       if ($board[$row][$column] == 0) {
         for (my $numberTest = 1; $numberTest <= $GRID_SIZE; $numberTest++) {
           if (checkBoard(\@board, $numberTest, $row, $column) == 1) {
             $board[$row][$column] = $numberTest;
             # Recursive calls to solveBoard check every square of the grid for empty spaces
             # If there is a valid placement in an empty space, the first numberTest will
             # be placed.
             if (solveBoard(\@board) == 1) {
               return 1;
            }
            # If there is no valid placement, set the square to 0 to try another number there
            else {
              $board[$row][$column] = 0;
            }
          }
        }
        return 0; # Unable to place valid number in square
      }
    }
  }
  return 1;
}

sub printBoard {
  my @board = @{ $_[0]};
  for my $row (@board) {
    for my $column (@{$row}){
      print $column . " ";
     }
    print "\n";
  }   
}

1;

# printBoard(\@board);
# if (solveBoard(\@board) == 1) {
#   print "Sudoku is solved!" . "\n";
# }
# else {
#     print "Sudoku is unsolvable" . "\n";
# }
# printBoard(\@board);

