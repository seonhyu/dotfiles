install:
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
	git clone https://github.com/olivierverdier/zsh-git-prompt.git .zsh/git-prompt
	git clone https://github.com/zsh-users/zsh-history-substring-search.git .zsh/history-substring-search
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git .zsh/syntax-highlighting

setup:
	/bin/ln -sf ~/dotfiles/vimrc ~/.vimrc
	/bin/ln -sf ~/dotfiles/.zsh ~/.zsh
	/bin/ln -sf ~/dotfiles/vim/snippets ~/.vim/snippets
