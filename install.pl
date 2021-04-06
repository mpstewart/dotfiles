#!/bin/perl
# install.pl - install comfy env stuff
use strict;
use warnings;
use v5.10;

use FindBin;
use lib "$FindBin::Bin/lib";

use MS::Setup qw( install_repo run );

use Env  qw( HOME       );
use Carp qw( croak carp );

# things we are configuring
my @installing = qw(
  tmux
  vim
  zsh
);

# things we depend on
my @deps = qw(
  git
  stow
);


sub main {
  say 'Verifying dependencies...';
  run("which $_", silent => 1) for (@installing, @deps);

  # list so we have predictable execution order
  my @operations = (
    [vim  => \&setup_vim   ],
    [tmux => \&setup_tmux  ],
    [zsh  => \&setup_zsh   ],
    [go   => \&setup_goenv ],
  );

  foreach my $op (@operations) {
    my ($prog, $setup) = @$op;
    say "\nSetting up $prog...";
    $setup->();
    say "Done.\n";
  }

  return 0;
}

sub setup_vim {
  install_repo(
    'VundleVim/Vundle.vim.git',
    "$HOME/.vim/bundle/Vundle.vim"
  );

  _unpack_config('vim');
  run("mkdir -p $HOME/.vim/swapfiles/");

  run('vim +PluginInstall +qall');
}

sub setup_tmux {
  install_repo(
    'tmux-plugins/tpm',
    "$HOME/.tmux/plugins/tpm"
  );

  _unpack_config('tmux');

  say "Installing tmux plugins...";
  run("$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh");
}

sub setup_zsh {
  install_repo(
    'mpstewart/oh-my-zsh',
    "$HOME/.oh-my-zsh"
  );

  _unpack_config('zsh');
}

sub setup_goenv {
  install_repo('syndbg/goenv', '~/.goenv');
}



sub _unpack_config { run('stow '.$_[0]) }

exit main();
