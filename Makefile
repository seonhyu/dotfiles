install:
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
	ln -sfv ~/dotfiles/vim/snippets ~/.vim/snippets

setup:
	/bin/ln -sfv ~/dotfiles/vimrc		~/.vimrc
