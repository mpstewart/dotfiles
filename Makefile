install:
	./install.pl

clean:
	rm -rf ~/.vim/bundle/* ~/.vim/swapfiles ~/.oh-my-zsh ~/.tmux/ ~/.goenv

compile:
	perl -c install.pl
