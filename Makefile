install: .bashrc .vimrc
	ln -sf ~/dotfiles/.bashrc ~/.bashrc
	ln -sf ~/dotfiles/.vimrc ~/.vimrc
	ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

lite: .bashrc.lite .vimrc.lite
	mv .bashrc.lite .bashrc
	mv .vimrc.lite .vimrc
	ln -sf ~/dotfiles/.bashrc ~/.bashrc
	ln -sf ~/dotfiles/.vimrc ~/.vimrc
	ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
