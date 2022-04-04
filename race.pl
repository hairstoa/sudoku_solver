#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper;

sub getTimes {
  my @repeat = (1..$ARGV[0]);
 
  for my $i (@repeat) {
  # Run the Perl Sudoku Solver
  system "time --output=times_perl.txt -a ./main.pl sample3.txt";
  
  sleep(1);
  
  #Run the Python Sudoku Solver
  system "time --output=times_python.txt -a ./main.py sample3.txt";
 
  sleep(1);
  }
}

sub calculateAverage {
  my ($fname) = @_;
  
  open(FH, $fname) or die("File $fname not found");

  my $count = 0.0;
  my $times = 0.0;
  while ( my $line = <FH> ) {
      if ($line =~ /^(\d+.\d+)user /) {
        $times += $1;
        $count += 1.0;
      }
  }
  my $average = $times / $count;
  return $average;
}

if ($ARGV[0]){
  # Uncomment to run programs and generate time files;
  # getTimes();
  
  # Open the results file 
  my $file_perl = '/home/ahairston/projects/scripts/sudoku/times_perl.txt';
  my $file_python = '/home/ahairston/projects/scripts/sudoku/times_python.txt';
  my $average_perl = calculateAverage($file_perl);
  my $average_python = calculateAverage($file_python);
  
  # Format output
  my $perlVersion = `perl --version | grep -o '(.*)' | head -1`;
  $perlVersion = substr $perlVersion, 2, 6;
  my $pythonVersion = `python -c 'import sys; print(".".join(map(str, sys.version_info[0:3])))'`;
  print "\nA sudoku solver was implemented in Python and Perl. Which one is faster? \n\n";
  print "--- PERL ----\n";
  print "Version: $perlVersion \n";
  print "Average time (ms) for $ARGV[0] trials:\n $average_perl\n\n"; 
  print "--- PYTHON ---\n";
  print "Version: $pythonVersion";
  print "Average time (ms) for $ARGV[0] trials:\n $average_python\n\n"; 
}
else {
  die "Please specify the number fo tests to run.\n";
}

exit();
