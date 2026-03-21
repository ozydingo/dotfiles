.PHONY: install install-shell install-git install-claude install-brew activate

install: install-shell install-git install-claude install-brew

install-shell:
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
	cp dotfiles/gitprompt $(HOME)/script/gitprompt
	cp dotfiles/functions/ys $(HOME)/script/functions/ys

install-git:
	cp dotfiles/.gitconfig $(HOME)/.gitconfig

install-claude:
	cp dotfiles/CLAUDE.md $(HOME)/CLAUDE.md
	cp -r dotfiles/dot-claude $(HOME)/.claude

install-brew:
	cp dotfiles/Brewfile $(HOME)/Brewfile

activate: install-shell
	source $(HOME)/.zlogin
