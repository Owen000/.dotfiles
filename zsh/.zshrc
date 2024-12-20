# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments
unsetopt BEEP

# History in cache directory:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zshistory"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

fzmv-widget() {
   ~/fzmv.sh
}

zle -N fzmv-widget
bindkey '^f' fzmv-widget

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

#My Cool Aliases
alias cat='batcat --paging=never'
alias gcfw='~/.config/git/worktreesetup.sh'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias cnf='cd ~/.config/'
alias vcnf='cd ~/.config/nvim/'
alias ls='ls --color'
alias getall='kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n'

alias clip='/mnt/c/Windows/System32/clip.exe'

function gitnewbranch() {
  git checkout -b $1 && git push --set-upstream origin $1
}
alias gnb='gitnewbranch'

export EDITOR='nvim'

export BAT_THEME="ansi"

export PATH="/mnt/c/Windows:$PATH"
export PATH=$PATH:/snap/bin
export KEYPAIRS=/home/dev/.ssh/keypairs/

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#ebdbb2,hl:#458588 --color=fg+:#ebdbb2,bg+:#3c3836,gutter:-1,hl+:#83a598 --color=info:#afaf87,prompt:#fabd2f,pointer:#83a598 --color=marker:#b8bb26,spinner:#b16286,header:#83a598'

source ~/.config/zsh/plugins/F-Sy-H/F-Sy-H.plugin.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export XDG_CONFIG_HOME="$HOME/.config"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

export PATH=$PATH:/home/dev/.local/bin
export PATH="$HOME/nvim-linux64/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH=$PATH:$(go env GOPATH)/bin

eval "$(zoxide init --cmd cd zsh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

setopt HIST_IGNORE_SPACE

. "$HOME/.cargo/env"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
