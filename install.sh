#!/usr/bin/env bash
# Set up these dotfiles on a machine: install omz + plugins + tpm, then symlink
# configs into place. Safe to re-run. Existing files are moved to *.pre-dotfiles.
set -euo pipefail

DOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {  # link <source in dotfiles> <target>
  local src="$DOT/$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then return; fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then mv "$dst" "$dst.pre-dotfiles"; echo "backed up $dst"; fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"; echo "linked $dst"
}

clone() {  # clone <url> <dir> [tag]
  [ -d "$2" ] || git clone --depth=1 ${3:+--branch "$3"} -q "$1" "$2"
}

# --- zsh: oh-my-zsh + plugins
clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
P="$HOME/.oh-my-zsh/custom/plugins"
clone https://github.com/zsh-users/zsh-autosuggestions     "$P/zsh-autosuggestions"
clone https://github.com/zsh-users/zsh-syntax-highlighting "$P/zsh-syntax-highlighting"
clone https://github.com/zsh-users/zsh-completions         "$P/zsh-completions"
# pinned: main branch (Sep 2026) doesn't show the live menu; 26.08.04 does
clone https://github.com/marlonrichert/zsh-autocomplete    "$P/zsh-autocomplete" 26.08.04

# --- tmux plugin manager
clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# --- symlinks
link zsh/.zshrc       "$HOME/.zshrc"
link zsh/.zshenv      "$HOME/.zshenv"
link tmux/.tmux.conf  "$HOME/.tmux.conf"
link git/.gitconfig   "$HOME/.gitconfig"
link nixos            "$HOME/nixos"
for c in ghostty niri alacritty kitty gtk-3.0 gtk-4.0 mimeapps.list; do
  link "config/$c" "$HOME/.config/$c"
done

# --- noctalia: copied, not linked (it rewrites the file on save)
mkdir -p "$HOME/.local/state/noctalia"
[ -f "$HOME/.local/state/noctalia/settings.toml" ] ||
  cp "$DOT/noctalia/settings.toml" "$HOME/.local/state/noctalia/settings.toml"

"$HOME/.tmux/plugins/tpm/bin/install_plugins" >/dev/null || true

echo
echo "Done. NixOS config is in ~/nixos (git repo). Apply it with:"
echo "  sudo nixos-rebuild switch --flake ~/nixos#nixos"
