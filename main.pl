#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

BEGIN {push @INC, 'lib'};
use Solver;

sub main {
 my $filename = $_[0];
 my @board = (
    [ 7, 0, 2, 0, 5, 0, 6, 0, 0],
    [ 0, 0, 0, 0, 0, 3, 0, 0, 0],
    [ 1, 0, 0, 0, 0, 9, 5, 0, 0],
    [ 8, 0, 0, 0, 0, 0, 0, 9, 0],
    [ 0, 4, 3, 0, 0, 0, 7, 5, 0],
    [ 0, 9, 0, 0, 0, 0, 0, 0, 8],
    [ 0, 0, 9, 7, 0, 0, 0, 0, 5],
    [ 0, 0, 0, 2, 0, 0, 0, 0, 0],
    [ 0, 0, 7, 0, 4, 0, 2, 0, 3],
  );

    # Read from file
    @board = Solver::readBoard($filename);
    Solver::printBoard(\@board);
      if (Solver::solveBoard(\@board) == 1) {
        print "Sudoku is solved!" . "\n";
      }
      else {
          print "Sudoku is unsolvable" . "\n";
      }
      Solver::printBoard(\@board);
}

if ( @ARGV[0]) {
  main(@ARGV[0]);
}
else { 
  die "Please specify a file name from the command line.";
}

exit();
