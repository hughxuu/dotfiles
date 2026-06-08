export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

plugins=(
  git
  zsh-z
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)

# https://ohmyz.sh/
source $ZSH/oh-my-zsh.sh

# -------------------------------- #
# Node Package Manager
# -------------------------------- #
# https://github.com/antfu/ni

alias nio="ni --prefer-offline"
alias s="nr start"
alias d="nr dev"
alias b="nr build"
alias bw="nr build --watch"
alias t="nr test"
alias tu="nr test -u"
alias tw="nr test --watch"
alias w="nr watch"
alias p="nr play"
alias c="nr typecheck"
alias lint="nr lint"
alias lintf="nr lint --fix"
alias release="nr release"
alias re="nr release"
alias np='nr preview'
alias dh='nr dev:h5'

# -------------------------------- #
# Git
# -------------------------------- #

# Use github/hub
alias git=hub

# Go to project root
alias grt='cd "$(git rev-parse --show-toplevel)"'

alias gs='git status'
alias gp='git push'
alias gpf='git push --force'
alias gpft='git push --follow-tags'
alias gpl='git pull --rebase'
alias gcl='git clone'
alias gst='git stash'
alias grm='git rm'
alias gmv='git mv'

alias main='git checkout main'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch'
alias gbd='git branch -d'

alias grb='git rebase'
alias grbom='git rebase origin/master'
alias grbc='git rebase --continue'

alias gl='git log'
alias glo='git log --oneline --graph'

alias grh='git reset HEAD'
alias grh1='git reset HEAD~1'

alias ga='git add'
alias gA='git add -A'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git add -A && git commit -m'
alias gfrb='git fetch origin && git rebase origin/master'

alias gxn='git clean -dn'
alias gx='git clean -df'

alias gsha='git rev-parse HEAD | pbcopy'

alias ghci='gh run list -L 1'

function glp() {
  git --no-pager log -$1
}

function gd() {
  if [[ -z $1 ]] then
    git diff --color | diff-so-fancy
  else
    git diff --color $1 | diff-so-fancy
  fi
}

function gdc() {
  if [[ -z $1 ]] then
    git diff --color --cached | diff-so-fancy
  else
    git diff --color --cached $1 | diff-so-fancy
  fi
}

# -------------------------------- #
# Directories
#
# I put
# `~/i` for main folder
# `~/f` for forks
# `~/r` for repros
# `~/w` for workspace
# -------------------------------- #

function i() {
  cd ~/i/$1
}

function r() {
  cd ~/r/$1
}

function f() {
  cd ~/f/$1
}

function wf(){
  if [[ -z $1 ]] then
    echo "Usage: wf < dir_name >"
    cd ~/w/ && ls
    return 1
  fi
  cd ~/w/$1
}

function pr() {
  if [ $1 = "ls" ]; then
    gh pr list
  else
    gh pr checkout $1
  fi
}

function dir() {
  mkdir $1 && cd $1
}

function clone() {
  if [[ -z $2 ]] then
    hub clone "$@" && cd "$(basename "$1" .git)"
  else
    hub clone "$@" && cd "$2"
  fi
}

# Clone to ~/i and cd to it
function clonei() {
  i && clone "$@" && code . && cd ~2
}

function cloner() {
  r && clone "$@" && code . && cd ~2
}

function clonef() {
  f && clone "$@" && code . && cd ~2
}

function codei() {
  i && code "$@" && cd -
}

function serve() {
  if [[ -z $1 ]] then
    live-server dist
  else
    live-server $1
  fi
}

function localproxy() {
  export http_proxy="http://127.0.0.1:8888"
  export https_proxy="http://127.0.0.1:8888"
  echo "HTTP Proxy on"
}

# set surge proxy
function proxyon(){
  export https_proxy=http://127.0.0.1:6152;
  export http_proxy=http://127.0.0.1:6152;
  export all_proxy=socks5://127.0.0.1:6153
  echo "Surge Proxy on"
}
# unset surge proxy
function proxyoff() {
  unset http_proxy
  unset https_proxy
  echo "Surge Proxy off"
}

# daily update and cleanup alias
alias up='vp upgrade && vp up -g && brew update && brew upgrade && brew cu -a -y && brew cleanup'
# backup homebrew packages
alias backup='brew bundle dump --describe --force --file="~/r/dotfiles/Brewfile"'
alias ozsh='code ~/.zshrc'
# open cross-source chrome
alias ocsc='open -n /Applications/Google\ Chrome.app/ --args --disable-web-security  --user-data-dir=/Users/xuch/w/chromedev'
# open cross-source wechat-web-devtools
alias ocsw='open -n /Applications/wechatwebdevtools.app --args --disable-web-security --user-data-dir=/Users/xuch/w/MywechattoolUserData'
alias net="networkQuality"
alias ip="ipconfig getifaddr en0"
alias cls='clear'


# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin