export BROWSER='/usr/bin/firefox'
export XAUTHORITY='/home/proullon/.Xauthority'
export XTERM='/bin/bash'
export EDITOR='/usr/bin/vim'

# mnemo aliases

# alias fucking keyboard
alias ccd='cd'
alias lls='ls'

alias size='du -h -d 1'
alias docker-cleanup='docker rm $(docker ps -q -a --filter="dangling=true");docker rmi $(docker images -q -a --filter "dangling=true")'
alias netscan='nmap -sP 192.168.1.1/24'

# tmux aliases
alias ta='tmux attach-session -t'
alias tn='tmux new-session -s'
alias tl='tmux list-sessions'

# editor alias
alias emacs='emacs -nw'
alias sublime='sublime_text'
alias ne='emacs'
alias vim='TERM=screen-256color nvim'
alias bim='nvim'
alias v='nvim -c "NERDTree" .'

# go aliases
alias cdc='cd'
alias ccd='cd'

# git aliases
alias lg='git log --graph --all --decorate'
alias gt='git status'
alias gd='git diff'
alias gg='git grep -n'
alias gp='git stash; git pull --prune; git stash pop'
alias gc='git checkout'
alias gm='git stash; git checkout master; git stash pop'
alias gdev='git stash; git checkout develop; git stash pop'
alias br='git branch'
alias gcb='git checkout -b'
alias rmtag='echo "git tag -d <tag_name>; git push --delete origin <tag_name>"'

# some more ls aliases
alias ls='ls'
alias sl='ls'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -cf'
alias ks='ls'

alias t2='tree -h -d -l 2'
alias t1='tree -h -d -l 1'
alias t='t2'

alias perm="stat -c '%a %a %n'"

alias k='kubectl'

# tmux
alias tls='tmux -2 list-session'
alias ta='tmux -2 attach-session -t '
alias tn='tmux -2 new -s '

# add local not-versionned alias
if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi
