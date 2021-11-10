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
	if [ ! -d "$(HOME)/.scm_breeze" ]; then \
		git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze; \
		~/.scm_breeze/install.sh; \
		. ~/.bashrc; \
	fi
vundle:
	if [ ! -d "$($HOME)/.vim/bundle" ]; then \
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; \
	fi

auto-jump:
	git clone git://github.com/wting/autojump.git
	cd autojump
	./install.py

always_forget:
	ln -sf ~/dotfiles/.always_forget.txt ~/.always_forget.txt

brew_install:
	for package in jid; do \
		brew install $$package; \
	done

binaries:
	mkdir -p ~/bin
	for directory in ~/dotfiles/scripts ~/dotfiles/binaries; do \
		for script in $$(ls -p $$directory | grep -v /); \
		do \
			ln -sf $$directory/$$script ~/bin/$${script%.*}; \
		done \
	done
