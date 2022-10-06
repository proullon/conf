
# bash profile should be supler simple and juste load .profile and .bashrc (in that order)


# Loading profile, not call since bash_profile is here
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Loading bashrc, not called by login shell
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Sourcing gitprompt
source ~/.git-prompt.sh
. "$HOME/.cargo/env"
