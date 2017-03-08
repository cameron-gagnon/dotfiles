plugins: ctrlp scm_breeze

install: .bashrc .vimrc sym_link plugins

lite: .bashrc.lite .vimrc.lite _lite_cp sym_link plugins

_lite_cp:
	cp .bashrc.lite .bashrc
	cp .vimrc.lite .vimrc

sym_link:
	ln -sf ~/dotfiles/.bashrc ~/.bashrc
	ln -sf ~/dotfiles/.bash_aliases ~/.bash_aliases
	ln -sf ~/dotfiles/.vimrc ~/.vimrc
	ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

ctrlp:
	git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim

scm_breeze:
	git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
	~/.scm_breeze/install.sh
	. ~/.bashrc
