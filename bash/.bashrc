# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

bgtask() {
  local log_file="nohup.log"
  local command=""

  # Parse flags
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -l | --log)
      log_file="$2"
      shift 2
      ;;
    *)
      command+=" $1"
      shift
      ;;
    esac
  done
  # Ensure log directory exists
  mkdir -p "$(dirname "$log_file")"
  # Log the command and timestamp
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >>"$log_file"
  echo -e $command $log_file
  nohup $command >"$log_file" 2>&1 &
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ct='eza --tree --color=always --icons=always --level=3'
alias cat='batcat --theme=Dracula --color=always'
alias t2c='tmux save-buffer - | xclip -selection clipboard'
alias cdoc='mkdir docs && ln -s $(pwd)/docs ~/Documents/Notes/$(basename $(pwd))'

# Customize fzf options
export FZF_DEFAULT_OPTS="--height 80% --layout reverse --border rounded"
export FZF_CTRL_T_OPTS=$FZF_DEFAULT_OPTS' --preview="batcat --theme=Dracula --color=always {}"'
export FZF_ALT_C_OPTS=$FZF_DEFAULT_OPTS' --preview="eza --tree --color=always --icons=always --level=3 {}"'

# Use fd instead of find for faster searches (if fd is installed)
export fzfCMD='fdfind --no-ignore --exclude "node_modules" --exclude __pycache__'
export FZF_DEFAULT_COMMAND='$fzfCMD --type f'
export FZF_CTRL_T_COMMAND='$fzfCMD --type f'
export FZF_ALT_C_COMMAND='$fzfCMD --type d'

alias fd='fdfind --type d --no-ignore --exclude "node_modules" --exclude __pycache__'
alias ff='fdfind --type f --no-ignore --exclude "node_modules" --exclude __pycache__'
alias fcd='cd $(fd | fzf --preview="eza --tree --color=always --icons=always --level=3")'
alias fcode='code $(ff | fzf --preview="batcat --theme=Dracula --color=always {}")'
alias fvim='nvim $(ff | fzf --preview="batcat --theme=Dracula --color=always {}")'

eval "$(starship init bash)"
eval "$(thefuck --alias tf)"
source /usr/share/doc/fzf/examples/key-bindings.bash

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
. "$HOME/.cargo/env"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH="$PATH:/opt/nvim-linux64/bin"

# Created by `pipx` on 2024-11-24 06:45:07
export PATH="$PATH:/home/kugelblitz/.local/bin"
neofetch --ascii_distro Debian --disable resolution wm icons gpu packages --cpu_temp C
