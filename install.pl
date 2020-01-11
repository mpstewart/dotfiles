#!/bin/perl
# install.pl - unpack dotfiles to home directory
use strict;
use warnings;

use Cwd qw( abs_path );
use Env qw( HOME     );

# move everything from the archive directory to the home directory
for my $file (glob('*')) {
  my ($archive_file, $home_file) = map {
    "$_/$file"
  } (abs_path(), $HOME);

  system(cp => '-r', $archive_file, $home_file ) == 0
    || die "error during copy: $?";
}

# turns out, the easiest way to 'skip' files during a recursive copy is to just
# copy everything and delete what you would have skipped
unlink map {
  "$HOME/$_"
} ($0);

exit 0;
