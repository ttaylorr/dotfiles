## .dotfiles

These are Taylor's dotfiles.  They may not be that useful to you, but they are useful to him!

To begin, `git clone` this repo into your home directory.

Once cloned, simply execute the `./scripts/bootstrap.sh` script to create all symlinks and install necessary things.

### contributing

To add a new section to the .dotfiles, create a directory with all the assets that you'll need.  The file that will be invoked by the installer is always called `install.sh`.  To ensure that the installation happens at the right time, just pop a line with the name of the directory into `scripts/utils/install_checklist`.

Enjoy!


