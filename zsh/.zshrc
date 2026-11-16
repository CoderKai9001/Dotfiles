# ---------- zsh-autocomplete (must load before omz/compinit) ----------
# Live completion menu while typing: Down arrow enters the list, arrows move,
# Enter accepts. Up arrow opens a searchable history menu.
source "$HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# ---------- Oh My Zsh ----------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster" # set by `omz`
DISABLE_AUTO_UPDATE="true"       # update manually with: omz update

# zsh-completions must be on fpath before compinit (run by omz)
fpath+=("$ZSH/custom/plugins/zsh-completions/src")

# zsh-syntax-highlighting must be last
plugins=(
  git
  sudo                           # Esc Esc to prefix last command with sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ---------- History ----------
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE EXTENDED_HISTORY

# ---------- Behaviour ----------
setopt AUTO_CD INTERACTIVE_COMMENTS
bindkey -e                       # emacs-style keys (Ctrl-A/E/R etc.)

# omz's key-bindings override zsh-autocomplete's arrows; restore them:
# Down = move into the completion menu, Up = history menu.
bindkey -M emacs '^[[A' up-line-or-search   '^[OA' up-line-or-search \
                 '^[[B' down-line-or-select '^[OB' down-line-or-select

# ---------- Autosuggestions ----------
ZSH_AUTOSUGGEST_STRATEGY=(history)  # 'completion' strategy clashes with zsh-autocomplete
bindkey '^ ' autosuggest-accept  # Ctrl-Space accepts (Right arrow / End also work)

# ---------- Colours (was provided by /etc/zshrc) ----------
eval "$(dircolors -b)"

# ---------- Aliases ----------
alias ll='ls -lah --color=auto'
alias ls='ls --color=auto'
