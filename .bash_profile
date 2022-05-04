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
alias r='bin/rails'
alias prettyjson="python -m json.tool"
alias do-that-thang="git checkout main && git pull --autostash --ff-only && bundle && be rake db:migrate"
alias start-driving="git fetch && git hard-reset"
alias git-purge-merged='git branch -d $(git branch --merged=main | grep -v main)'
alias wx="curl wttr.in"
alias radar="open https://radar.weather.gov/?settings=v1_eyJhZ2VuZGEiOnsiaWQiOiJ3ZWF0aGVyIiwiY2VudGVyIjpbLTg2LjE1NSwzOS43NjZdLCJsb2NhdGlvbiI6Wy04Ni4xNSwzOS43NjddLCJ6b29tIjo3fSwiYW5pbWF0aW5nIjpmYWxzZSwiYmFzZSI6InN0YW5kYXJkIiwiYXJ0Y2MiOmZhbHNlLCJjb3VudHkiOmZhbHNlLCJjd2EiOmZhbHNlLCJyZmMiOmZhbHNlLCJzdGF0ZSI6ZmFsc2UsIm1lbnUiOnRydWUsInNob3J0RnVzZWRPbmx5IjpmYWxzZSwib3BhY2l0eSI6eyJhbGVydHMiOjAuOCwibG9jYWwiOjAuNiwibG9jYWxTdGF0aW9ucyI6MC44LCJuYXRpb25hbCI6MC42fX0%3D#/"

# If you installed the SDK via Homebrew, otherwise ~/Library/Android/sdk
export ANDROID_HOME=/usr/local/opt/android-sdk
