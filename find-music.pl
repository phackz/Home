#!/usr/bin/perl
use v5.010;
use strict;
use warnings;

use File::Find::Rule;
use File::Path;
use File::Copy;
use Cwd;

# Things to do:
# - Create logging of what's sync'd to were
# - Write get opts to pick directory's from command line to sync, switch for 
#   movies, music, resume's etc. add overrides to default directories.
# - Auto grab where drive is mounted instead of  


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

my $remote_count = 0;
my $local_count = 0;

foreach my $file (@files_remote){
  $remote_count += 1 ;     
}
foreach my $file (@files_local){
  $local_count += 1;
}

say "local: $local_count";
say "remote: $remote_count";

sub grab_files {
  my $dir = shift;
  my @files_temp;
  my @files = File::Find::Rule->file()
			      ->name( qr/\.(mp3|wma|ogg|wav|jpg)$/ )	
 			      ->in($dir);
  foreach my $file (@files) {
    $file =~ s/$dir\///;
    push(@files_temp, $file);
  }
  my @return = sort{ lc($a) cmp lc($b) } @files_temp;
  return(@return);
}

sub check_differences {
  my $local = shift;
  my $remote = shift;

}
