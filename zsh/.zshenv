# Skip NixOS's generated /etc/zshrc: it runs compinit and loads its own copies of
# autosuggestions/syntax-highlighting, which conflict with zsh-autocomplete + omz.
# Everything it sets up is handled in ~/.zshrc instead.
NOSYSZSHRC=1
