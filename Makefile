install: sym_link plugins misc binaries

plugins: scm_breeze vundle

misc: always_forget

.PHONY: binaries

sym_link:
	ln -sf ~/dotfiles/.bashrc.full ~/.bashrc
	ln -sf ~/dotfiles/.bash_aliases.full ~/.bash_aliases
	ln -sf ~/dotfiles/.vimrc.full ~/.vimrc
	ln -sf ~/dotfiles/.gitconfig.full ~/.gitconfig

scm_breeze:
	if [ ! -d $("$HOME/.scm_breeze") ]; then \
		git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze; \
		~/.scm_breeze/install.sh; \
		. ~/.bashrc; \
	fi
vundle:
	if [ ! -d $("$HOME/.vim/bundle") ]; then \
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; \
	fi


always_forget:
	ln -sf ~/dotfiles/.always_forget.txt ~/.always_forget.txt

binaries:
	# https://github.com/simeji/jid
	ln -sf ~/dotfiles/binaries/jid ~/bin/jid
