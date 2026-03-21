.PHONY: install

install:
	mkdir -p $(HOME)/script/functions

	cp dotfiles/.zshrc $(HOME)/.zshrc
	cp dotfiles/.zlogin $(HOME)/.zlogin
	@if echo "$$(hostname -s)" | grep -qi "3play"; then \
		cp local/3play/.zlogin.local $(HOME)/.zlogin.local; \
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
	cp -r dotfiles/dot-claude $(HOME)/.claude

	cp dotfiles/gitprompt $(HOME)/script/gitprompt
	cp dotfiles/functions/ys $(HOME)/script/functions/ys

	@# @gh copilot -h &> /dev/null && gh alias set ai --clobber "copilot suggest -t shell" || echo "copilot not found; skipping"
	@# @gh copilot -h &> /dev/null && gh alias set explain --clobber "copilot explain" || echo "copilot not found; skipping"

activate: install
	source $(HOME)/.zlogin
