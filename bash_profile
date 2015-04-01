# set layout
which setxkbmap && setxkbmap us -variant intl

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
	clear;echo;echo;go install $1 && clear && echo && echo && go vet $1 && clear && echo && echo && golint $1 && echo && echo && go test -cover -race $1
}

function sub {
    echo -n "Opening " $1 "with sublime_text"
    sublime $1 & > /dev/null
}

# In case of local profile conf
if [ -f ~/.bash_profile_local ]
then
    . ~/.bash_profile_local
fi
