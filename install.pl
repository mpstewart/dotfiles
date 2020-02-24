#!/bin/perl
# install.pl - install comfy env stuff
use strict;
use warnings;

use Carp         qw( carp croak );
use Cwd          qw( abs_path   );
use Env          qw( HOME       );
use File::Which;

my $CURL = which 'curl';
my $WGET = which 'wget';

sub main
{
    install_vundle();
    install_oh_my_zsh();
    fix_vim_swapfile();
}

sub install_vundle
{
  my $cmd = 'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim';

  system($cmd) && do {
    die "Error installing vundle: $?";
  };
}

sub install_oh_my_zsh
{
  my $cmd = 'git clone https://github.com/mpstewart/oh-my-zsh ~/.oh-my-zsh';

  system($cmd) && do {
    die "Error installing oh-my-zsh $?";
  };
}

sub fix_vim_swapfile
{
  system(mkdir => -p => "~/.vim/swapfiles/") && do {
    die "Unable to create swapfile directory: $?";
  };
}

sub
