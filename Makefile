.DEFAULT_GOAL: all
.PHONY: all dotfiles homebrew iterm2 nvm tools zsh

all: tools dotfiles

tools: homebrew iterm2 nvm zsh

dotfiles:
	ln -nfsv $(CURDIR)/git/gitconfig $(HOME)/.gitconfig
	ln -nfsv $(CURDIR)/git/gitignore_global $(HOME)/.gitignore_global
	ln -nfsv $(CURDIR)/vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json
	ln -nfsv $(CURDIR)/zsh/zshrc $(HOME)/.zshrc
	ln -nfsv $(CURDIR)/zsh/themes/nenu.zsh-theme $(HOME)/.oh-my-zsh/themes/nenu.zsh-theme

homebrew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle

iterm2:
	defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$(CURDIR)/iterm2"
	defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

nvm:
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

zsh:
	sudo echo $(which zsh) >> /etc/shells
	chsh -s $(which zsh)
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
