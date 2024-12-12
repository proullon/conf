# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# editor alias
alias vim="nvim"
alias bim="nvim"

# git aliases
alias lg="git log --graph --all --decorate"
alias gt="git status"
alias gd="git diff"
alias gg="git grep -n"
alias gp="git pull --prune"
alias gc="git checkout"
alias gm="git checkout main"
alias br="git branch"
alias perm="stat -c %a %a %n"

# kube alias
alias k="kubectl"

# tmux alias
alias tls="tmux -2 list-session"
alias ta="tmux -2 attach-session -t"
alias tn="tmux -2 new -s"

export PATH=$PATH:/opt/rocm/bin
export PATH=$PATH:/home/proullon/go/bin
export PATH=$PATH:/home/proullon/.local/bin
