# ttaylorr/dotfiles

These are my dotfiles.

To install, clone this repository into your home directory and run `make`:

```ShellSession
$ git clone git@github.com:ttaylorr/dotfiles.git ~/.dotfiles
$ make -C ~/.dotfiles
```

## Overview

Dotfiles are grouped topically into different sub-directories. Each
sub-directory contains contains a `rules.mak` file which is included from the
top-level `Makefile`.

These `rules.mak` files specify a list of `$INSTALL_PAIRS`, where each tuple
represents the source and destination location. When you run `make`, the
top-level `Makefile` guesses how to sync between the source and destination, by
either running `cp -pr` or `rsync -a`.

## Installation

To install these dotfiles, run `make`. There are a couple of build-time options:

- `MACOS`: if defined, installs macOS-specific configuration, such as Homebrew,
  Alacritty, skhd, and yabai. If undefined, this value is inferred based on the
  output of `uname -s`.
- `BREW`: if defined, installs the Homebrew packages listed in `brew/Brewfile`.
  Must be used in conjunction with `MACOS=YesPlease`.
- `NO_MUTT`: if defined, does not install mutt or related configuration.
