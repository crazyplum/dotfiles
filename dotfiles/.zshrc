export DOTFILES_ROOT=$HOME/dotfiles
source "$DOTFILES_ROOT/dotfiles-conf.sh"

# Path to your oh-my-zsh configuration.
ZSH=~/.oh-my-zsh


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
#ZSH_THEME="powerline"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias zshrc="vim ~/.zshrc"
# alias reloadzsh="source ~/.zshrc"
# alias t="cd /tools"
# alias py="ipython"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

POWERLINE_FULL_CURRENT_PATH="true"
POWERLINE_SHOW_GIT_ON_RIGHT="true"
POWERLINE_RIGHT_A="%M"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git debian django virtualenvwrapper pip python urltools autojump)
# plugins=(git pip python virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# source $DOTFILES_ROOT/bin/sh_basic.sh

# Path to self-defined python modules
# PYMODULE="/Users/Maxis/projects/pymodules"

export PATH="$HOME/bin:/usr/local/bin:$PATH"
# export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYMODULE"
# export PROJECT_HOME="$HOME/projects"

if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
fi

export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

eval `dircolors $DOTFILES_ROOT/submodule/dircolors-solarized/dircolors.256dark`

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
source /Users/crazyplum/.rvm/scripts/rvm
PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting
