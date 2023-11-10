install: sym_link plugins misc binaries

plugins: scm_breeze vundle

misc: always_forget

zsh: zsh_syntax_highlighting

.PHONY: binaries

tpm:
	if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
	fi

sym_link:
	ln -sf ~/dotfiles/.bashrc.full ~/.bashrc
	ln -sf ~/dotfiles/.zshrc.full ~/.zshrc
	ln -sf ~/dotfiles/.tmux.conf.full ~/.tmux.conf
	ln -sf ~/dotfiles/.bash_aliases.full ~/.bash_aliases
	ln -sf ~/dotfiles/.vimrc.full ~/.vimrc
	ln -sf ~/dotfiles/.gitconfig.full ~/.gitconfig

scm_breeze:
	if [ ! -d "$(HOME)/.scm_breeze" ]; then \
		git clone https://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze; \
		~/.scm_breeze/install.sh; \
		. ~/.bashrc; \
	fi
vundle:
	if [ ! -d "$(HOME)/.vim/bundle/Vundle.vim" ]; then \
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; \
	fi

auto-jump:
	git clone https://github.com/wting/autojump.git
	cd autojump
	./install.py

always_forget:
	ln -sf ~/dotfiles/.always_forget.txt ~/.always_forget.txt

brew_install:
	for package in jid; do \
		brew install $$package; \
	done

zsh_syntax_highlighting:
	if [ ! -d "$(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then \
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"; \
	fi


binaries:
	mkdir -p ~/bin
	for directory in ~/dotfiles/scripts ~/dotfiles/binaries; do \
		for script in $$(ls -p $$directory | grep -v /); \
		do \
			ln -sf $$directory/$$script ~/bin/$${script%.*}; \
		done \
	done

	echo "installing der-ascii"
	go install github.com/google/der-ascii/cmd/...@latest

pr_file_checker:
	cd ~/dotfiles/pr-file-checker; \
		go build -o prfc main.go; \
		ln -sf ~/dotfiles/pr-file_checker/prfc ~/bin/prfc
