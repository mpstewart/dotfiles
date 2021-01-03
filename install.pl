#!/bin/perl
# install.pl - install comfy env stuff
use strict;
use warnings;
use v5.10;

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
  _run("which $_", silent => 1) for (@installing, @deps);

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
  _install_repo(
    'VundleVim/Vundle.vim.git',
    "$HOME/.vim/bundle/Vundle.vim"
  );

  _unpack_config('vim');
  _run("mkdir -p $HOME/.vim/swapfiles/");

  _run('vim +PluginInstall +qall');
}

sub setup_tmux {
  _install_repo(
    'tmux-plugins/tpm',
    "$HOME/.tmux/plugins/tpm"
  );

  _unpack_config('tmux');

  say "Installing tmux plugins...";
  _run("$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh");
}

sub setup_zsh {
  _install_repo(
    'mpstewart/oh-my-zsh',
    "$HOME/.oh-my-zsh"
  );

  _unpack_config('zsh');
}

sub setup_goenv {
  _install_repo('syndbg/goenv', '~/.goenv');
}

sub _install_repo {
  my ($repo, $destination) = @_;
  my $github = 'git@github.com';
  $repo = "$github:$repo";
  _run("git clone $repo $destination");
}

sub _run {
  my ($cmd, %args) = @_;

  my $silent = !! $args{silent};
  if ($silent) {
    $cmd .= " 1>/dev/null"
  }

  say "Running $cmd" unless $silent;

  my $lethal = !! $args{'lethal'};

  system($cmd) && do {
    my $msg = "Unable to $cmd = $?";
    if ($lethal) {
      croak $msg;
    } else {
      carp $msg;
    }
  };
}

sub _unpack_config { _run('stow '.$_[0]) }

exit main();
