# macOS Sierra does not auto-load your `ssh-agent` like all previous versions of
# OS X.
if [ -x "$(which ssh-add)" ]; then
  ssh-add &> /dev/null
fi
