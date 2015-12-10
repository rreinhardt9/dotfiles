# Source your .bashrc
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \w\[\033[32m\]$(parse_git_branch)\[\033[00m\] \n$ "

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

alias be='bundle exec'
