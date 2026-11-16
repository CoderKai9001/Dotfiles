# dotfiles

| Path | Lives at | How |
|---|---|---|
| `nixos/` | `~/nixos` | symlink (own git repo → github nix-flakes) |
| `zsh/.zshrc`, `zsh/.zshenv` | `~/` | symlink |
| `tmux/.tmux.conf` | `~/` | symlink |
| `git/.gitconfig` | `~/` | symlink |
| `config/{ghostty,niri,alacritty,kitty,gtk-3.0,gtk-4.0,mimeapps.list}` | `~/.config/` | symlink |
| `noctalia/settings.toml` | `~/.local/state/noctalia/` | **copy** — re-copy after changing settings |

Not stored here (installed by `install.sh`): oh-my-zsh, zsh plugins, tpm and tmux plugins.

## New machine

```sh
git clone <this repo> ~/dotfiles && ~/dotfiles/install.sh
sudo nixos-rebuild switch --flake ~/nixos#nixos
```

`hardware-configuration.nix` is machine-specific and read from `/etc/nixos/`.

## Saving noctalia settings

```sh
cp ~/.local/state/noctalia/settings.toml ~/dotfiles/noctalia/
```
