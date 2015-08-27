# set layout
which setxkbmap > /dev/null && setxkbmap us -variant intl

# Set FULL COLOR TERM !!
export TERM=xterm-256color

# Set editor as vim
export EDITOR=vim

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
RED='\e[0;31m'          # Red
GREEN='\e[0;32m'        # Green
YELLOW='\e[0;33m'       # Yellow
BLUE='\e[0;34m'         # Blue
PURPLE='\e[0;35m'       # Purple
CYAN='\e[0;36m'         # Cyan
WHITE='\e[0;37m'        # White

# Change shell prompt
PS1="\[$GREEN\]\t\[$RED\]-\[$BLUE\]\u\[$RED\]@\[$BLUE\]\h\[$YELLOW\]\w\[\033[m\]\[$PURPLE\]\$(__git_ps1)\[$WHITE\]
\$ "

# More complexe aliases needing func
function ctest {
clear;echo;echo;go install $1 && clear && echo && echo &&  go vet `go list $1 | grep -v vendor` && clear && echo && echo && for pkg in $(go list $1 |grep -v /vendor/); do golint $pkg; done && echo && echo && go test -cover -race `go list $1 | grep -v /vendor/`
}

function sub {
    echo -n "Opening " $1 "with sublime_text"
    sublime $1 & > /dev/null
}

function dockin {
    docker run -it $* /bin/bash
}

# In case of local profile conf
if [ -f ~/.bash_profile_local ]
then
    . ~/.bash_profile_local
fi
