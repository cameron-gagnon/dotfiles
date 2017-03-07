PLUGINS="ctrlp scm_breeze"

install: .bashrc .vimrc ctrlp $(PLUGINS)
	ln -sf ~/dotfiles/.bashrc ~/.bashrc
	ln -sf ~/dotfiles/.vimrc ~/.vimrc
	ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

lite: .bashrc.lite .vimrc.lite $(PLUGINS)
	cp .bashrc.lite .bashrc
	cp .vimrc.lite .vimrc
	ln -sf ~/dotfiles/.bashrc ~/.bashrc
	ln -sf ~/dotfiles/.vimrc ~/.vimrc
	ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

ctrlp:
	git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim

scm_breeze:
	git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
	~/.scm_breeze/install.sh
	source ~/.bashrc
