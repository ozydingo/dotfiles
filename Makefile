.PHONY: install

install:
	mkdir -p $(HOME)/script/functions

	cp shell/zshrc $(HOME)/.zshrc
	cp shell/zlogin $(HOME)/.zlogin
	cp config/.gitconfig $(HOME)/.gitconfig
	cp config/Brewfile $(HOME)/Brewfile

	cp shell/gitprompt $(HOME)/script/gitprompt
	cp shell/functions/ys $(HOME)/script/functions/ys

	gh alias set ai --clobber "copilot suggest -t shell"
	gh alias set explain --clobber "copilot explain"
