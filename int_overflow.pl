#!/usr/bin/perl

# Author: James Attard [jattard@palominodb.com]
# Date: October 2012
#
# This program was developed to review the max values of integer fields
# in an attempt to anticipate an overflow catastrophe which might result
# in the planet to rotate anticlockwise.
#
# Copyright (c) PalominoDB 2012.
#

use strict;
use warnings;
use DBI;

# Main program
main();

# Subroutines
sub main {
  
  # Initialize constants
  my $tinyint = 127;
  my $smallint = 32767;
  my $mediumint = 8388607;
  my $int = 2147483647;
  my $bigint = 9223372036854775807;
  
  my $tinyint_us = 255;
  my $smallint_us = 65535;
  my $mediumint_us = 16777215;
  my $int_us = 4294967295;
  my $bigint_us = 18446744073709551615;
  
  # Initialize connections to database
  my $dbn="dbi:mysql:information_schema:localhost:3306";
  my $dbh=DBI->connect($dbn, "root", "pass") or die "Unable to connect: $DBI::errstr\n";
  my $select_query="select table_schema, table_name, column_name, column_type from columns where table_schema = 'ebonydb' and column_type like '%int%'";
  my $select_h = $dbh->prepare($select_query) or die "Unable to prepare: $DBI::errstr\n";
  $select_h->execute() or die "Unable to execute: $DBI::errstr\n";

  while ( my @row = $select_h->fetchrow_array) {
    
    # Retrieve table structure metadata
    my $table_schema = $row[0];
    my $table_name = $row[1];
    my $column_name = $row[2];
    my $column_type = $row[3];
    
    # Retrieve max value of integer
    my $select_max="select max($column_name) from $table_schema.$table_name";
    my $select_h2 = $dbh->prepare($select_max) or die "Unable to prepare: $DBI::errstr\n";
    $select_h2->execute() or die "Unable to execute: $DBI::errstr\n";
    my $max_int = $select_h2->fetchrow_array;
    $select_h2->finish();
 
    # Initialize dubious fields
    if (!defined $max_int) {
        $max_int=0;
    }
    
    my $unsigned = 0;
    if ($column_type =~ /unsigned/) {
      $unsigned = 1;
    }
   
    # Discard type format
    ( my $int_type ) = $column_type =~ /([^\(]*)/;
       
    # Calculate overflow percentage:
    my $of_pct = 0;
    if ($unsigned == 0) {
      if ($int_type eq "tinyint") { $of_pct = ($max_int/$tinyint)*100;}
      elsif ($int_type eq "smallint") { $of_pct = ($max_int/$smallint)*100;}
      elsif ($int_type eq "mediumint") { $of_pct = ($max_int/$mediumint)*100;}
      elsif ($int_type eq "int") { $of_pct = ($max_int/$int)*100;}
      elsif ($int_type eq "bigint") { $of_pct = ($max_int/$bigint)*100;}
      else { $of_pct = 0 }
    }
    else {
      if ($int_type eq "tinyint") { $of_pct = ($max_int/$tinyint_us)*100;}
      elsif ($int_type eq "smallint") { $of_pct = ($max_int/$smallint_us)*100;}
      elsif ($int_type eq "mediumint") { $of_pct = ($max_int/$mediumint_us)*100;}
      elsif ($int_type eq "int") { $of_pct = ($max_int/$int_us)*100;}
      elsif ($int_type eq "bigint") { $of_pct = ($max_int/$bigint_us)*100;}
      else { $of_pct = 0 }      
    }
                
    # Insert review information into palomino schema in a time series fashion
    my $insert_review="insert into palomino.int_overflow values (\'$table_schema\', \'$table_name\', \'$column_name\', \'$int_type\', $max_int, $of_pct, now\(\))";
    my $select_h3 = $dbh->prepare($insert_review) or die "Unable to prepare: $DBI::errstr\n";
    $select_h3->execute() or die "Unable to execute: $DBI::errstr\n";
  }
  
  # Save the environment and close connections to database
  $select_h->finish();  
  $dbh->disconnect;
  
}
