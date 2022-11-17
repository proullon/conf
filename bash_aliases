export BROWSER='/usr/bin/firefox'
export XAUTHORITY='/home/proullon/.Xauthority'
export XTERM='/bin/bash'
export EDITOR='/usr/bin/vim'

# mnemo aliases
alias size='du -h -d 1'
alias docker-cleanup='docker rm $(docker ps -q -a --filter="dangling=true");docker rmi $(docker images -q -a --filter "dangling=true")'

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
alias gp='git pull --prune'
alias gc='git checkout'
alias gm='git checkout master'
alias br='git branch'

# some more ls aliases
alias ls='ls --color'
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

# jupyter
alias jupyter="docker run -d --name jupyter -p 10000:8888 --user root   -e CHOWN_HOME=yes -e CHOWN_HOME_OPTS='-R'  -v /home/proullon/work/ops/jupyter:/home/jovyan/work jupyter/datascience-notebook:r-4.1.3 && docker logs -f jupyter"

# tmux
alias tls='tmux -2 list-session'
alias ta='tmux -2 attach-session -t '
alias tn='tmux -2 new -s '

# add local not-versionned alias
if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi
