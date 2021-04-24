# Source your .bashrc
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

eval "$(rbenv init -)"

# Use sqlite from homebrew
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# Use python from brew
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Include python executable in path
export PATH="/Users/ross/Library/Python/2.7/bin:$PATH"

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\t \w\[\033[32m\]\$(parse_git_branch)\[\033[00m\] \n$ "

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

alias be='bundle exec'
alias prettyjson="python -m json.tool"
alias do-that-thang="git checkout master && git pull && bundle && be rake db:migrate"
alias wttr="curl wttr.in"

# If you installed the SDK via Homebrew, otherwise ~/Library/Android/sdk
export ANDROID_HOME=/usr/local/opt/android-sdk
