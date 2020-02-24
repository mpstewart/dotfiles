#!/bin/perl
# install.pl - install comfy env stuff
use strict;
use warnings;

use Carp         qw( carp croak );
use Cwd          qw( abs_path   );
use Env          qw( HOME       );
use File::Which;

sub main
{
  install_vundle();
  install_oh_my_zsh();
  fix_vim_swapfile();
  unpack_dotfiles();

  return 0;
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

sub unpack_dotfiles
{
  my @progs = qw(
    vim
    zsh
    tmux
  );

  # make sure we have stow
  system('stow --version 1>/dev/null') && do {
      die "Doesn't look like stow is available. Exiting.";
  };

  for my $program (@progs) {
    system(stow => $program) && do {
      die "Unable to unpack $program $?";
    };
  }
}

exit main();
