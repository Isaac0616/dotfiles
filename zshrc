# zmodload zsh/zprof

################################################################################
#                             launch tmux when ssh                             #
################################################################################
if [[ -z "$TMUX" ]] && [ -n "$SSH_CONNECTION" ] && [ -t 1 ] && which tmux >& /dev/null; then
    exec tmux-next new -As main
fi

################################################################################
#                            environment variables                             #
################################################################################
export OS=$(uname)
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'

export PATH="$HOMEBREW_PREFIX/bin":/usr/local/bin:/usr/local/sbin:$PATH:$GOROOT/bin:$GOPATH/bin
if [[ $OS == "Linux" ]]; then
    export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
    export MANPATH=/home/linuxbrew/.linuxbrew/share/man:$MANPATH
    export INFOPATH=/home/linuxbrew/.linuxbrew/share/info:$INFOPATH
fi
if [[ $OS == "Darwin" ]]; then
    export PATH=/usr/local/opt/ruby/bin:$PATH
    export PATH=`gem environment gemdir`/bin:$PATH
    # DocSend
    export PATH="$HOMEBREW_PREFIX/opt/imagemagick@6/bin:$PATH"
    export PATH=$HOME/src/elaine/bin:$PATH
    export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi
export PATH=/opt/dropbox-override/bin:$PATH

# disable special creation/extraction of ._* files by tar, etc. on Mac OS X
export COPYFILE_DISABLE=1

# for "lukechilds/zsh-nvm"
# export NVM_LAZY_LOAD=true

# solarized ls color
export CLICOLOR=1
export LSCOLORS=FxfxbEaEBxxEhEhBaDaCaD
export LS_COLORS="di=1;35:ln=35:so=31;1;44:pi=30;1;44:ex=1;31:bd=0;1;44:cd=37;1;44:su=37;1;41:sg=30;1;43:tw=30;1;42:ow=30;1;43"

if [[ $OS == "Darwin" ]]; then
    export SHELL="$HOMEBREW_PREFIX/bin/zsh"
    export s=/Users/poning/src/server
    export GOPATH=$GOPATH:/Users/poning/src/server/go
    # DocSend
    export PGHOST=localhost
fi

if [[ $OS == "Linux" ]]; then
    export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
fi

# DocSend
export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi

################################################################################
#                                   aliases                                    #
################################################################################
if [[ $OS == "Darwin" ]]; then
    alias shuf='gshuf'
    alias timeout='gtimeout'
    alias ls='ls -FH'
    alias ll='ls -Fla'
    alias tab='open . -a iterm'
    alias ssh='ssh -o "XAuthLocation=/opt/X11/bin/xauth"'
    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
    alias fuck-mac='find . -name ".DS_Store" -type f -delete'
    alias python=python3
fi

if [[ $OS == "Linux" ]]; then
    alias tmux='tmux-next'
    alias ls='ls --color=auto -FH'
    alias ll='ls --color=auto -Fla'
fi

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias tar="tar --exclude='.DS_Store'"
alias myip='echo "Public IP: $(dig +short myip.opendns.com @resolver1.opendns.com)"; echo "Private IP: $(ipconfig getifaddr en0)"'
alias svim='sudo vim'
alias md='mkdir -p'
alias pwn='ssh'
alias :3='echo'
# alias tldr='less'
alias fucking='sudo'
alias vim='nvim'
# alias j='fasd_cd -d'
# alias jj='fasd_cd -d -i'

################################################################################
#                                  functions                                   #
################################################################################
# shortcut for vagrant global-status
vagrant() {
    if [[ $@ == "gs" ]]; then
        command vagrant global-status
    else
        command vagrant "$@"
    fi
}

# mkdir and cd
mcd() {
    mkdir "$@" && cd "$@"
}

# print current shell
shell() {
    ps | grep -e "^`echo $$`" | awk '{ print $4 }'
}

# colorful man
man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

if [[ $OS == "Darwin" ]]; then
    # kill all chrome tabs
    fuck-chrome() {
        ps ux | \
        grep '[C]hrome Helper --type=renderer' | \
        grep -v extension-process | \
        tr -s ' ' | \
        cut -d ' ' -f2 | \
        xargs kill
    }
fi

if [[ $OS == "Linux" ]]; then
    # toggle ASLR
    aslr() {
      if [[ $1 == "off" ]]; then
          echo 0 | sudo tee /proc/sys/kernel/randomize_va_space > /dev/null
      elif [[ $1 == "on" ]]; then
          echo 2 | sudo tee /proc/sys/kernel/randomize_va_space > /dev/null
      fi

      if [[ $(cat /proc/sys/kernel/randomize_va_space) == "0" ]]; then
          echo "off"
      elif [[ $(cat /proc/sys/kernel/randomize_va_space) == "2" ]]; then
          echo "on"
      elif [[ $(cat /proc/sys/kernel/randomize_va_space) == "1" ]]; then
          echo "partial"
      fi
    }
fi

# cross platform open command
function o() {
  emulate -L zsh
  setopt shwordsplit

  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   open_cmd='xdg-open' ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  # don't use nohup on OSX
  if [[ "$OSTYPE" == darwin* ]]; then
    $open_cmd "$@" &>/dev/null
  else
    nohup $open_cmd "$@" &>/dev/null
  fi
}

################################################################################
#                               welcome message                                #
################################################################################
if (( $COLUMNS < 120 )); then
    cowsay -W 30 -f ~/.motd/programer.cow "The force is with those who read the source."
else
    MOTD=$HOME/.motd
    cat $(ls $MOTD/force* | shuf -n 1) | cowsay -n -f ~/.motd/programer.cow
fi

################################################################################
#                                    zplug                                     #
################################################################################
# alias git=/usr/local/bin/git
source ~/.zplug/init.zsh
# unalias git

zplug "lukechilds/zsh-nvm"
zplug "Isaac0616/emoticon-zsh-theme", as:theme
zplug "zsh-users/zsh-completions"
zplug "plugins/gitfast", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# zplug load --verbose
zplug load

## manually load
# source ~/.zplug/repos/lukechilds/zsh-nvm/zsh-nvm.plugin.zsh
# source ~/.zplug/repos/Isaac0616/emoticon-zsh-theme/emoticon.zsh-theme
# fpath=(~/.zplug/repos/zsh-users/zsh-completions/src $fpath)
# autoload -Uz compinit
# if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  # compinit
# else
  # compinit -C
# fi
# source ~/.zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


################################################################################
#                                 zsh settings                                 #
################################################################################
## completion
setopt auto_menu # show completion menu on successive tab press
zstyle ':completion:*:*:*:*:*' menu select # highlight the selection

# fuzzy completion
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# use ls-colors for path eompletions
function _set-list-colors() {
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    unfunction _set-list-colors
}
sched 0 _set-list-colors  # deferred since LC_COLORS might not be available yet

## command history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history # append to history file instead of replacing it
setopt extended_history # save each command’s beginning timestamp and the duration to the history file
setopt hist_expire_dups_first # remove duplicated history first
setopt hist_ignore_dups # do not put command into the history if they are duplicates of the previous event
setopt inc_append_history # write to the history file immediately, not when the shell exits
setopt share_history #  share history between all sessions

## directories
setopt auto_pushd # make cd push the old directory onto the directory stack
setopt pushd_ignore_dups # don’t push multiple copies of the same directory onto the directory stack.
setopt pushdminus # exchanges the meanings of '+' and '-' for pushd and popd

## jobs
setopt long_list_jobs # list jobs in the long format by default.

## vi mode
bindkey -v

# kill the lag when switching mode
export KEYTIMEOUT=1

## bindkey
# history
bindkey '^R' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward
# edit command line
autoload edit-command-line;
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

# bind arrow key
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "\e[A" up-line-or-beginning-search
bindkey "\e[B" down-line-or-beginning-search
bindkey "\eOA" up-line-or-beginning-search
bindkey "\eOB" down-line-or-beginning-search


################################################################################
#                                   plugins                                    #
################################################################################
# gitfast
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1

# the fuck
fuck () {
    unset -f fuck
    eval "$(thefuck --alias)"
    eval fuck "$@"
}

# fasd
# if [[ $OS == "Darwin" ]]; then
    # # export _FASD_BACKENDS="native spotlight"
    # export _FASD_BACKENDS="native"
# fi
# fasd_cache="$HOME/.fasd-init-zsh"
# if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  # fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
# fi
# source "$fasd_cache"
# unset fasd_cache

# tldr
export TLDR_COLOR_BLANK="white"
export TLDR_COLOR_NAME="cyan"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="green"
export TLDR_COLOR_COMMAND="red"
export TLDR_COLOR_PARAMETER="white"
export TLDR_CACHE_ENABLED=1
export TLDR_CACHE_MAX_AGE=720

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# fzf solarized colors
_gen_fzf_default_opts() {
    local base03="234"
    local base02="235"
    local base01="240"
    local base00="241"
    local base0="244"
    local base1="245"
    local base2="254"
    local base3="230"
    local yellow="136"
    local orange="166"
    local red="160"
    local magenta="125"
    local violet="61"
    local blue="33"
    local cyan="37"
    local green="64"

    # Comment and uncomment below for the light theme.

    # Solarized Dark color scheme for fzf
    export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
    "
    ## Solarized Light color scheme for fzf
    #export FZF_DEFAULT_OPTS="
    #  --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
    #  --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
    #"
}
_gen_fzf_default_opts

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bip() {
  local inst=$(brew search | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}


## Install or open the webpage for the selected application  Install or o
# using brew cask search as input source
# and display a info quickview window for the currently marked application
install() {
    local token
    token=$(brew search --casks | fzf-tmux --query="$1" +m --preview 'brew cask info {}')

    if [ "x$token" != "x" ]
    then
        echo "(I)nstall or open the (h)omepage of $token"
        read input
        if [ $input = "i" ] || [ $input = "I" ]; then
            brew cask install $token
        fi
        if [ $input = "h" ] || [ $input = "H" ]; then
            brew cask home $token
        fi
    fi
}

# j() {
    # [ $# -gt 0 ] && fasd_cd -d "$*" && return
    # local dir
    # dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
# }

headers() {
  curl -s -o /dev/null -D - "$@" | grep -v -e '^[[:space:]]*$' | tail -n +2 | sort --ignore-case
}

# zprof
