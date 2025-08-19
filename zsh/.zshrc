# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
ZSH_DISABLE_COMPFIX=true
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$PATH:/opt/nvim-linux64/bin"


# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias c='clear'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias wc='cd /mnt/c/Users/vighn'
alias wd='cd /mnt/d'
alias onedrive='cd /mnt/c/Users/vighn/OneDrive\ -\ Indian\ Institute\ of\ Technology\ Bombay/IITB'
alias ct='eza --tree --color=always --icons=always --level=3 --git-ignore --git'
alias cat="batcat --theme Dracula --color always"
alias ovpn="sudo openvpn --config IITBADV.ovpn > /dev/null"
alias ovpn-kill="sudo pkill openvpn"

# Customize fzf options
export FZF_DEFAULT_OPTS="--height 80% --layout reverse --border rounded --inline-info"
export FZF_CTRL_T_OPTS=$FZF_DEFAULT_OPTS' --preview="batcat --theme Dracula --color always {}"'
export FZF_ALT_C_OPTS=$FZF_DEFAULT_OPTS' --preview="eza --tree --color=always --icons=always --level=3 {}"'
export FZF_CTRL_R_OPTS=$FZF_DEFAULT_OPTS' --sort --exact'
export FZF_COMPLETION_OPTS=$FZF_DEFAULT_OPTS

# Use fd instead of find for faster searches (if fd is installed)
export fzfCMD='fdfind'
export FZF_DEFAULT_COMMAND='$fzfCMD --type f'
export FZF_CTRL_T_COMMAND='$fzfCMD --type f'
export FZF_ALT_C_COMMAND='$fzfCMD --type d'

alias fd='fdfind --type d'
alias ff='fdfind --type f'
alias fcd='cd $(fd | fzf --preview="eza --tree --color=always --icons=always --level=3 {}")'
alias fvim='nvim $(ff | fzf --preview="batcat --theme Dracula --color always {}")'

. "$HOME/.local/bin/env"
