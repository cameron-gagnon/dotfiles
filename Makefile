UNAME := $(shell uname)

mac: scm_breeze vundle brew_packages zsh sym_link binaries
linux: scm_breeze vundle sym_link binaries
windows: scm_breeze sym_link

zsh: zsh_config

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
	ln -sf ~/dotfiles/.always_forget.txt ~/.always_forget.txt
# assumes vscode is installed on a mac
ifeq ($(UNAME), Darwin)
	ln -sf ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
	ln -sf ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
endif

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


brew_packages:
	packages=(jid fzf); \
	for package in "$$packages[@]"; do \
		brew install $$package; \
	done; \
	$$(brew --prefix)/opt/fzf/install

zsh_config:
	if [ ! -d "$(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then \
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"; \
	fi
	if [ ! -d "$(HOME)/powerlevel10k" ]; then \
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k; \
	fi
	if [ ! -d "$(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then \
		git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions; \
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
