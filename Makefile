install: .bashrc .vimrc
	ln -sf ~/dotfiles/.bashrc ~/.bashrc
	ln -sf ~/dotfiles/.vimrc ~/.vimrc
	ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

lite: .bashrc.lite .vimrc.lite
	cp .bashrc.lite .bashrc
	cp .vimrc.lite .vimrc
	ln -sf ~/dotfiles/.bashrc ~/.bashrc
	ln -sf ~/dotfiles/.vimrc ~/.vimrc
	ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
