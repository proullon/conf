# mnemo aliases
alias size = du -h -d 1

# editor alias
alias emacs = emacs -nw
alias ne = emacs
alias vim = term=screen-256color nvim
alias bim = nvim
alias v = nvim -c "nerdtree" .

alias cdc = cd
alias ccd = cd

# editor alias
alias vim = nvim
alias bim = nvim
alias v = nvim -c "nerdtree" .

# git aliases
alias lg = git log --graph --all --decorate
alias gt = git status
alias gd = git diff
alias gg = git grep -n
alias gp = git pull --prune
alias gc = git checkout
alias gm = git checkout main
alias br = git branch
alias perm = stat -c %a %a %n

# kube alias
alias k = kubectl

# tmux alias
alias tls = tmux -2 list-session
alias ta = tmux -2 attach-session -t 
alias tn = tmux -2 new -s 

alias gal = galacticad --home /mnt/ssd/galactica

