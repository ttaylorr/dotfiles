-include config.mak

.DEFAULT_GOAL = all

DESTDIR ?= $(HOME)

ifndef MACOS
ifeq ($(shell uname -s), Darwin)
	MACOS=YesPlease
endif
endif

include bash/rules.mak
include zsh/rules.mak
ifdef MACOS
ifdef BREW
include brew/rules.mak
endif # BREW
include alacritty/rules.mak
endif # MACOS
include bin/rules.mak
include git/rules.mak
include vim/rules.mak
include editorconfig/rules.mak
ifndef NO_MUTT
include msmtp/rules.mak
include mutt/rules.mak
endif # NO_MUTT
ifdef MACOS
include defaults/rules.mak
include skhd/rules.mak
include yabai/rules.mak
endif # MACOS

.PHONY : all
all : install $(POST_INSTALL)

# from brian m. carlson.
.PHONY : install
install:
	@printf "%s %s\n" $(INSTALL_PAIRS) | (set -e; while read src dest; do \
		if [ -d "$$src" ]; then \
			printf "%8s %s\n" "DIR" "$(DESTDIR)/$$dest"; \
			mkdir -p "$(DESTDIR)/$$dest"; \
			printf "%8s %s -> %s\n" "SYNC" "$$src" "$(DESTDIR)/$$dest"; \
			rsync -a --exclude '*.mak' "$$src/" "$(DESTDIR)/$$dest/"; \
		else \
			printf "%8s %s -> %s\n" "CP" "$$src" "$(DESTDIR)/$$dest"; \
			mkdir -p $$(dirname "$(DESTDIR)/$$dest"); \
			cp -pr "$$src" "$(DESTDIR)/$$dest"; \
		fi; \
	done)
