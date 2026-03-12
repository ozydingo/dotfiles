.PHONY: install

install:
	mkdir -p $(HOME)/script/functions

	cp dotfiles/.zshrc $(HOME)/.zshrc
	cp dotfiles/.zlogin $(HOME)/.zlogin
	@if [ "$$(hostname -s)" = "3PLAY-ML-ASchwartz" ]; then \
		cp dotfiles/.zlogin.local.3PLAY-ML-ASchwartz $(HOME)/.zlogin.local; \
		echo ""; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		echo "!!! WARNING: app3-specific local dotfile additions were overwritten. !!!"; \
		echo "!!! Re-run the app3 dev setup script now to restore local additions. !!!"; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		echo ""; \
	fi
	cp dotfiles/.gitconfig $(HOME)/.gitconfig
	cp dotfiles/Brewfile $(HOME)/Brewfile
	cp dotfiles/CLAUDE.md $(HOME)/CLAUDE.md

	cp dotfiles/gitprompt $(HOME)/script/gitprompt
	cp dotfiles/functions/ys $(HOME)/script/functions/ys

	@# @gh copilot -h &> /dev/null && gh alias set ai --clobber "copilot suggest -t shell" || echo "copilot not found; skipping"
	@# @gh copilot -h &> /dev/null && gh alias set explain --clobber "copilot explain" || echo "copilot not found; skipping"

activate: install
	source $(HOME)/.zlogin
