install:
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

setup:
	/bin/ln -sf ~/dotfiles/vimrc ~/.vimrc
	/bin/ln -sf ~/dotfiles/.zsh ~/.zsh
	/bin/ln -sf ~/dotfiles/vim/snippets ~/.vim/snippets
