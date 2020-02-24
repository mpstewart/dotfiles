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
set -o vi
# :</env-setup>

# :<aliases>
alias zork="source $HOME/.zshrc"
alias ..="cd .."
alias ...="cd ../.."
alias cx="chmod +x"
alias e="vim ~/.zshrc; source ~/.zshrc"
# :</aliases>

# :<functions>
mkcd () {
  mkdir $1
  cd    $1
}
# :</functions>

# :<go-setup>
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
# :</go-setup>

# :<path-setup>
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/scripts:$PATH
export PATH=$GOBIN:$GOROOT/bin:$PATH
export PATH=$HOME/go/1.13.5/bin:$PATH
# :</path-setup>


# Keep this near the bottom, as it munges $PATH
# eval "$(goenv init -)"
# export PATH=/bin:/sbin:/usr/bin:/usr/local/bin:$HOME/bin


