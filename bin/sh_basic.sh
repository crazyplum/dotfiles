alias ls='ls --color'
alias o='ls --color'
alias oa='ls -a'
alias ol='ls -l'
alias al='ls -al'
alias c=pushd
alias d=popd
alias sudo='nocorrect sudo'

export LESS="-FXRS"
export LC_ALL=en_US.UTF-8

DEBEMAIL=$EMAIL
DEBFULLNAME=$FULLNAME
export DEBEMAIL DEBFULLNAME
export GIT_AUTHOR_NAME="$FULLNAME"
export GIT_COMMITTER_NAME="$FULLNAME"

if [ $(uname -s) = 'Darwin' ] && command -v brew >/dev/null ; then
   PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

if [ $(uname -s) = 'Darwin' ] && command -v brew >/dev/null; then
    if brew list | grep -x source-highlight > /dev/null ; then
        export LESSOPEN="| $(brew --prefix source-highlight)/bin/src-hilite-lesspipe.sh %s"
    fi
else
    if command -v src-hilite-lesspipe.sh; then
        export LESSOPEN="| src-hilite-lesspipe.sh %s"
    fi
fi


# SCRIPT_DIR="$(dirname "$(readlink -f $0)")"
