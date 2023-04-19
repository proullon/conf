# mnemo aliases
alias size='du -h -d 1'
alias docker-cleanup='docker rm $(docker ps -q -a --filter="dangling=true");docker rmi $(docker images -q -a --filter "dangling=true")'

# editor alias
alias emacs='emacs -nw'
alias sublime='sublime_text'
alias ne='emacs'
alias vim='term=screen-256color nvim'
alias bim='nvim'
alias v='nvim -c "nerdtree" .'

# go aliases
alias lcd='cd ~/work/src/github.com/$user/'
alias cdc='cd'
alias ccd='cd'

# git aliases
alias g='git gui &'
alias lg='git log --graph --all --decorate'
alias gt='git status'
alias gd='git diff'
alias gg='git grep -n'
alias gp='git pull --prune'
alias gc='git checkout'
alias gm='git checkout master'
alias br='git branch'

# some more ls aliases
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

alias ssb='ssh proullon@bastion.roullon.fr'
alias crdb='cockroach --certs-dir=/home/proullon/work/ops/crdb/certs --host=crdb.roullon.fr'
alias ssagf='ssh ubuntu@147.135.133.170'
alias ssminecraft='ssh ubuntu@149.202.162.105'

# add Go
let-env PATH = ($env.PATH | append "/usr/local/go/bin")
let-env PATH = ($env.PATH | append "/home/proullon/go/bin")
let-env EDITOR = "nvim"

# editor alias
alias vim = nvim
alias bim = nvim
alias v = nvim -c "nerdtree" .

# git aliases
alias g = git gui &
alias lg = git log --graph --all --decorate
alias gt = git status
alias gd = git diff
alias gg = git grep -n
alias gp = git pull --prune
alias gc = git checkout
alias gm = git checkout master
alias br = git branch
alias perm = stat -c %a %a %n

# kube alias
alias k = kubectl

# tmux alias
alias tls = tmux -2 list-session
alias ta = tmux -2 attach-session -t 
alias tn = tmux -2 new -s 

# rust
let-env PATH = ($env.PATH | prepend '/home/proullon/.cargo/bin')

alias ssb = ssh proullon@bastion.roullon.fr
alias crdb = cockroach --certs-dir=/home/proullon/work/ops/crdb/certs --host=crdb.roullon.fr
alias ssagf = ssh ubuntu@147.135.133.170
alias ssminecraft = ssh ubuntu@149.202.162.105

alias kafka-ui = docker run -p 9090:8080 --name kafka-ui -e KAFKA_CLUSTERS_0_NAME=kafka.bliink.io -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=34.79.109.248:9092,35.233.30.14:9092,35.195.193.230:9092 -d provectuslabs/kafka-ui:latest
alias hugodev = hugo serve -D --bind 0.0.0.0 -b http://213.32.77.148
