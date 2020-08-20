-include config.mak

.DEFAULT_GOAL = all

DESTDIR ?= $(HOME)

include bash/rules.mak
include zsh/rules.mak
ifeq ($(filter-out undefined,$(foreach v,NO_MACOS NO_HOMEBREW,$(origin $(v)))),)
include brew/rules.mak
endif
include bin/rules.mak
include git/rules.mak
include vim/rules.mak
include editorconfig/rules.mak
ifndef NO_MUTT
include msmtp/rules.mak
include mutt/rules.mak
include urlview/rules.mak
endif
ifndef NO_MACOS
include defaults/rules.mak
include skhd/rules.mak
include yabai/rules.mak
endif

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
