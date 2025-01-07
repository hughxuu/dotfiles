export ZSH="$HOME/.oh-my-zsh"

# git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
ZSH_THEME="spaceship"

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)

# https://ohmyz.sh/
source $ZSH/oh-my-zsh.sh

# -------------------------------- #
# https://github.com/antfu/dotfiles
# -------------------------------- #

# -------------------------------- #
# Node Package Manager
# -------------------------------- #
# https://github.com/antfu/ni

alias nio="ni --prefer-offline"
alias s="nr start || nr serve"
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
# `~/i` for my main folder
# `~/i/c` for codes
# `~/i/f` for forks
# `~/i/r` for reproductions (repros)
# `~/i/w` for workspace folder
# ......
# -------------------------------- #


function i() {
  cd ~/i/$1
}

function repros() {
  cd ~/i/r/$1
}

function forks() {
  cd ~/i/f/$1
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
function clonec() {
  cd ~/i/c && clone "$@" && code . && cd ~2
}

function cloner() {
  repros && clone "$@" && code . && cd ~2
}

function clonef() {
  forks && clone "$@" && code . && cd ~2
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

#-----------------------------------------------------------------------------------------------------------------

# -------------------------------- #
# hughxu config
# -------------------------------- #
# daily update and cleanup alias
alias up='brew update && brew upgrade && brew cu -a -y && brew cleanup && mas upgrade'
# open zshrc file in vscode
alias czsh='cd ~ && code ~/.zshrc'
# Open another wechat
alias wechat='open -n /Applications/WeChat.app/Contents/MacOS/WeChat'
# open cross-source chrome
alias occ='open -n /Applications/Google\ Chrome.app/ --args --disable-web-security  --user-data-dir=/Users/xuch/i/w/chromedev'
# open cross-source wechat-web-devtools
alias owc='open -n /Applications/wechatwebdevtools.app --args --disable-web-security --user-data-dir=/Users/xuch/i/w/MywechattoolUserData'
# mac-cleanup cache  https://github.com/mac-cleanup/mac-cleanup-py
alias clean='mac-cleanup -n'
alias cpu='sudo mactop'
alias cls='clear'

# cancel paste auto-escaping
DISABLE_MAGIC_FUNCTIONS=true

# fnm https://github.com/Schniz/fnm
eval "$(fnm env --use-on-cd)"

___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

# pnpm
export PNPM_HOME="/Users/xuch/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/xuch/.bun/_bun" ] && source "/Users/xuch/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export EDITOR="code"

source <(fzf --zsh)

PATH=~/.console-ninja/.bin:$PATH

# Added by Windsurf
export PATH="/Users/xuch/.codeium/windsurf/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(pyenv virtualenv-init -)"
