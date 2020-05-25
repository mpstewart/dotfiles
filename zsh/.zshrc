# :<zsh-setup>
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mpstewart"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(
  wd
  git
)

source $ZSH/oh-my-zsh.sh
# :</zsh-setup>

# :<env-setup>
export LANG=en_US.UTF-8
export EDITOR=vim # <3 vim
# export PAGER='vim -u /home/mstewart/.vl.vimrc -'
set -o vi
# :</env-setup>

# :<aliases>
alias zork="source $HOME/.zshrc"
alias ..="cl .."
alias ...="cl ../.."
alias cx="chmod +x"
alias e="vim ~/.zshrc; source ~/.zshrc"
alias j='journal'
alias clearswap='rm -rf ~/.vim/swapfiles/*'
alias gs='git status'
alias gco='git checkout'
alias git\ cram='git add . -u && git commit --amend --no-edit'
alias sd='sudo systemctl'
alias regtest='surf regex101.com'
alias perldoc='carton exec -- perldoc'
alias flex='carton exec -- perl -Ilib -MFlexy -MData::Dump'
alias tls='tmux list-sessions'
alias tat='tmux attach-session -t'
alias tnew='tmux new-session -s'
alias vl='vim -u ~/.vl.vimrc -'
# :</aliases>
#
# :<functions>
function psearch () {
  pamac search $1 | less
}
# :</functions>

# :<functions>
mkcd () {
  mkdir $1
  cd    $1
}
# :</functions>

## Uncomment if using goenv
# :<go-setup>
# export GOENV_ROOT="$HOME/.goenv"
# export PATH="$GOENV_ROOT/bin:$PATH"
# export PATH="~/go/1.13.6/bin:$PATH"
# :</go-setup>

## Uncomment if using plenv
# :<perl-setup>
# export PATH=$HOME/.plenv/bin:$PATH
# eval "$(plenv init -)"
# :</perl-setup>

# :<path-setup>
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/scripts:$PATH
export PnATH=$GOBIN:$GOROOT/bin:$PATH
export PATH=$HOME/go/1.13.5/bin:$PATH
export PATH=$HOME/new/bin:$PATH
export PATH=$HOME/watchman/bin:$PATH
export PATH=$HOME/dotfiles/scripts:$PATH
# :</path-setup>


## Uncomment is using goenv
# Keep this near the bottom, as it munges $PATH
# eval "$(goenv init -)"
# export PATH=/bin:/sbin:/usr/bin:/usr/local/bin:$HOME/bin


# The rest is just useful stuff from
# https://wiki.archlinux.org/index.php/Bash/Functions

extract() {
  local c e i

  (($#)) || return

  for i; do
    c=''
    e=1

    if [[ ! -r $i ]]; then
      echo "$0: file is unreadable: \`$i'" >&2
      continue
    fi

    case $i in
      *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
      c=(bsdtar xvf);;
      *.7z)  c=(7z x);;
      *.Z)   c=(uncompress);;
      *.bz2) c=(bunzip2);;
      *.exe) c=(cabextract);;
      *.gz)  c=(gunzip);;
      *.rar) c=(unrar x);;
      *.xz)  c=(unxz);;
      *.zip) c=(unzip);;
      *)     echo "$0: unrecognized file extension: \`$i'" >&2
      continue;;
    esac

    command "${c[@]}" "$i"
    ((e = e || $?))
  done
  return "$e"
}

# cd and ls together
cl() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null; ls
	else
		echo "bash: cl: $dir: Directory not found"
	fi
}
todo() {
    if [[ ! -f $HOME/.todo ]]; then
        touch "$HOME/.todo"
    fi

    if ! (($#)); then
        cat "$HOME/.todo"
    elif [[ "$1" == "-l" ]]; then
        nl -b a "$HOME/.todo"
    elif [[ "$1" == "-c" ]]; then
        > $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.todo"
        eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
        read -p "Type a number to remove: " number
        sed -i ${number}d $HOME/.todo "$HOME/.todo"
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi
}

# make commands bold on execution
preexec() { printf "\e[0m"; }
