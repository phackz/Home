#!/usr/bin/perl
use v5.010;
use strict;
use warnings;
use File::Find::Rule;
use File::Path;
use File::Copy;

my $home1 = "/home/pman";
my $home2 = "/home/rpothier";
my $home_music_dir;

if ( -d $home1 ) {
  $home_music_dir = "$home1/Music";
} elsif ( -d $home2 ) {
  $home_music_dir = "$home2/Music";
} else {
  say "Error setting home directory";
  exit 1;
}

sub grab_files {
  my $dir = shift;

  my @files = File::Find::Rule->file()
			      ->name( qr/\.(mp3|wma|ogg|wav|jpg)$/ )	
			      ->in($dir);
}

sub write_file_list {
  my $files = shift;

}

my @files = grab_files($home_music_dir);


foreach my $file (@files){
  say $file;
}
