# zmodload zsh/zprof

################################################################################
#                             launch tmux when ssh                             #
################################################################################
if [[ -z "$TMUX" ]] && [ -n "$SSH_CONNECTION" ] && which tmux >& /dev/null; then
    exec tmux new -As main
fi

################################################################################
#                            environment variables                             #
################################################################################
export OS=$(uname)
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:.
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim'

# disable special creation/extraction of ._* files by tar, etc. on Mac OS X
export COPYFILE_DISABLE=1

# for "lukechilds/zsh-nvm"
export NVM_LAZY_LOAD=true

# solarized ls color
export CLICOLOR=1
export LSCOLORS=FxfxbEaEBxxEhEhBaDaCaD
export LS_COLORS="di=1;35:ln=35:so=31;1;44:pi=30;1;44:ex=1;31:bd=0;1;44:cd=37;1;44:su=37;1;41:sg=30;1;43:tw=30;1;42:ow=30;1;43"

if [[ $OS == "Darwin" ]]; then
    export SHELL=/usr/local/bin/zsh
fi

################################################################################
#                                   aliases                                    #
################################################################################
if [[ $OS == "Darwin" ]]; then
    alias shuf='gshuf'
fi

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias ls='ls -FH'
alias ll='ls -Fla'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias tar="tar --exclude='.DS_Store'"
alias myip='echo "Public IP: $(dig +short myip.opendns.com @resolver1.opendns.com)"; echo "Private IP: $(ipconfig getifaddr en0)"'
alias svim='sudo vim'
alias md='mkdir -p'
alias pwn='ssh'
alias :3='echo'
alias tldr='less'
alias fucking='sudo'
alias j='fasd_cd -d'
alias jj='fasd_cd -d -i'

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

# toggle ASLR
if [[ $OS == "Linux" ]]; then
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
source ~/.zplug/init.zsh

zplug "lukechilds/zsh-nvm"
zplug "Isaac0616/emoticon-zsh-theme", as:theme
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

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
setopt hist_ignore_dups # don't put command into the history if they are duplicates of the previous event
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
bindkey '^R' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward

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
# the fuck
fuck () {
    unset -f fuck
    eval "$(thefuck --alias)"
    eval fuck "$@"
}

# fasd
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
