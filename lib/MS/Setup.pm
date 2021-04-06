package MS::Setup;
use strict;
use warnings;
use v5.10;

use Carp;

use base 'Exporter';

our @EXPORT_OK = qw(
  install_repo
  run
);

# downloads a git repo to the intended destination
sub install_repo {
  my ($repo, $destination) = @_;
  my $github = 'git@github.com';
  $repo = "$github:$repo";
  run("git clone $repo $destination");
}

# run the command with the given args
sub run {
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

1;
