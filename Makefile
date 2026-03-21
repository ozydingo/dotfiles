.PHONY: install shell git claude brew activate

install: shell git claude brew

shell:
	mkdir -p $(HOME)/script/functions
	cp home/.zshrc $(HOME)/.zshrc
	cp home/.zlogin $(HOME)/.zlogin
	@if echo "$$(hostname -s)" | grep -qi "3play"; then \
		cp local/3play/.zlogin.local $(HOME)/.zlogin.local; \
		echo ""; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		echo "!!! WARNING: app3-specific local dotfile additions were overwritten. !!!"; \
		echo "!!! Re-run the app3 dev setup script now to restore local additions. !!!"; \
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"; \
		echo ""; \
	fi
	cp home/gitprompt $(HOME)/script/gitprompt
	cp home/functions/ys $(HOME)/script/functions/ys

git:
	cp home/.gitconfig $(HOME)/.gitconfig

claude:
	cp home/CLAUDE.md $(HOME)/CLAUDE.md
	cp -r home/dot-claude $(HOME)/.claude

brew:
	cp home/Brewfile $(HOME)/Brewfile

activate: shell
	source $(HOME)/.zlogin
