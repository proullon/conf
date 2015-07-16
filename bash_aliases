export BROWSER='/usr/bin/chromium'
export XTERM='/bin/bash'
export EDITOR='/usr/bin/vim'

# Mnemo aliases
alias size='du -h -d 1'
alias docker-cleanup='docker rm $(docker ps -q -a --filter="dangling=true");docker rmi $(docker images -q -a --filter "dangling=true")'

# editor alias
alias emacs='emacs -nw'
alias sublime='sublime_text'
alias ne='emacs'
alias bim='vim'
alias v='vim -c "NERDTree" .'

# go aliases
alias lcd='cd ~/work/src/github.com/$USER/'

# git aliases
alias g='git gui &'
alias k='gitk --all &'
alias lg='git log --graph --all --decorate'
alias gt='git status'
alias gd='git diff'

# some more ls aliases
alias sl='ls'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias token='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;'
