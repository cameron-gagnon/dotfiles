install: .bashrc .vimrc sym_link plugins

plugins: ctrlp scm_breeze

lite: .bashrc.lite .vimrc.lite sym_link_lite plugins

sym_link_lite:
	ln -sf ~/dotfiles/.bashrc.lite ~/.bashrc
	ln -sf ~/dotfiles/.bash_aliases.full ~/.bash_aliases
	ln -sf ~/dotfiles/.vimrc.lite ~/.vimrc
	ln -sf ~/dotfiles/.gitconfig.full ~/.gitconfig

ctrlp:
	git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim

scm_breeze:
	git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
	~/.scm_breeze/install.sh
	. ~/.bashrc
