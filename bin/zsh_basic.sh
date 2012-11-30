alias ls='ls --color'
alias o='ls --color'
alias oa='ls -a'
alias ol='ls -l'
alias al='ls -al'
alias c=pushd
alias d=popd

export LESS="-FXRS"
export EDITOR="ec"
export PATH="/Users/joe/bin:/home/joe/bin:/usr/local/bin:$PATH"

if command -v brew ; then
   PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

export LC_ALL=en_US.UTF-8
