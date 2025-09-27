autoload -U compinit
compinit

setopt complete_in_word

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
set -o vi
bindkey '^R' history-incremental-search-backward

setopt inc_append_history share_history

autoload -U colors
colors

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/sensei/.local/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/sensei/.local/opt/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/sensei/.local/opt/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/sensei/.local/opt/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

export PATH=~/.local/bin:$PATH

fpath+=($HOME/.local/share/pure)
autoload -Uz promptinit
zstyle :prompt:pure:user show no
zstyle :prompt:pure:host show no
zstyle :prompt:pure:virtualenv color yellow
zstyle :prompt:pure:git:branch color green
promptinit
prompt pure

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# bun completions
[ -s "/home/sensei/.bun/_bun" ] && source "/home/sensei/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Go workspace
export GOPATH="$HOME/.local/opt/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# Module settings
export GOPROXY=https://proxy.golang.org,direct
export GOSUMDB=sum.golang.org


[ -f "/home/sensei/.ghcup/env" ] && . "/home/sensei/.ghcup/env" # ghcup-env
