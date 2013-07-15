#!/usr/bin/perl
use v5.010;
use strict;
use warnings;

use File::Find::Rule;
use File::Path;
use File::Copy;
use Cwd;

my $home1 = "/home/pman";
my $home2 = "/home/rpothier";
my $home_music_dir;

my $remote_drive = "/run/media/pman/Seagate Expansion Drive/Music";

if ( -d $home1 ) {
  $home_music_dir = "$home1/Music";
} elsif ( -d $home2 ) {
  $home_music_dir = "$home2/Music";
} else {
  say "Error setting home directory";
  exit 1;
}

if ( ! -d $remote_drive ) {
  say "Couldn't find external HDD";
  exit 1;
}

my @files_local = grab_files($home_music_dir);
my @files_remote = grab_files($remote_drive);

foreach my $file (@files_remote){
  say $file;     
}

sub grab_files {
  my $dir = shift;
  my @return;
  my @files = File::Find::Rule->file()
			      ->name( qr/\.(mp3|wma|ogg|wav|jpg)$/ )	
 			      ->in($dir);
  foreach my $file (@files) {
    $file =~ s/$dir\///;
    push(@return, $file);
  }
  return(@return);
}

