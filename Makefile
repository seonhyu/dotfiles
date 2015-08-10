install:
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

setup:
	#mkdir ~/.nvim
	/bin/ln -sf ~/Dropbox/dotfiles/vim/UltiSnips ~/.nvim/UltiSnips
	/bin/ln -sf ~/Dropbox/dotfiles/ctags ~/.ctags
	/bin/ln -sf ~/Dropbox/dotfiles/git/gitconfig ~/.gitconfig
	/bin/ln -sf ~/Dropbox/dotfiles/git/gitignore ~/.gitignore
	/bin/ln -sf ~/Dropbox/dotfiles/vim ~/.nvim
	/bin/ln -sf ~/Dropbox/dotfiles/nvimrc ~/.nvimrc
	/bin/ln -sf ~/Dropbox/dotfiles/tmux.conf ~/.tmux.conf
	/bin/ln -sf ~/Dropbox/dotfiles/vimrc ~/.vimrc
	/bin/ln -sf ~/Dropbox/dotfiles/zshrc ~/.zshrc
