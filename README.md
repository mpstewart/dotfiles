# dotfiles
These are my dotfiles, and also some scripts I've written that have come in handy. The idea is that I can just clone this repo anywhere, then run `install.pl` to unpack everything and make myself at `$HOME`.

## scripts

### conf
`conf` is a perl script that opens all of my dotfiles in [vim tabs](https://vim.fandom.com/wiki/Using_tab_pages) for easy editing. No attempts are made to support other editors.

It supports arguments:
```bash
# open files for one program
conf zsh
# open files for many programs
conf zsh tmux
# open all registered files
conf
```

You can extend this script by editing the `%CONFIGS` hash to contain the files you want. Keys will be used to parse args, and you should generally use the program name, though this is not enforced by any means. You can also associate multiple files with a program by separating filenames with spaces in the value.

## todo
I'd like to support some kind of versioning, in case I end up on a system with an old `tmux`, for example. This will be added on an as-needed basis, if at all.

A comfortable environment for me also requires `oh-my-zsh`,`vundle`, and lately `zsh-plugin-manager`. I would like to add support for automatically installing these tools, as well.

