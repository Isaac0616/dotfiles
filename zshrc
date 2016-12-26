OS=$(uname)

if [[ $OS == "Linux" ]]; then
    alias gls='ls'
    alias gshuf='shuf'
fi

# print welcome message
if (( $COLUMNS < 120 )); then
    cowsay -W 30 -f ~/.motd/programer.cow "The force is with those who read the source."
else
    MOTD=$HOME/.motd
    cat $MOTD/$(gls -I programer.cow $MOTD | gshuf -n 1) | cowsay -n -f ~/.motd/programer.cow
fi

# antigen
source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

#antigen theme agnoster
antigen theme Isaac0616/agnoster_mr agnoster_mr.zsh-theme

antigen bundle git
antigen bundle autojump
#antigen bundle vi-mode

antigen bundle zsh-users/zsh-syntax-highlighting
#antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-completions src
#antigen bundle tarruda/zsh-autosuggestions

# Tell antigen that you're done.
antigen apply

# vi mode
bindkey -v

# kill the lag
export KEYTIMEOUT=1

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

bindkey '^R' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward

# history substring-search
#zmodload zsh/terminfo
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down
#bindkey "^k" history-substring-search-up
#bindkey "^j" history-substring-search-down


# bind arrow key
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "\e[A" up-line-or-beginning-search
bindkey "\e[B" down-line-or-beginning-search
bindkey "\eOA" up-line-or-beginning-search
bindkey "\eOB" down-line-or-beginning-search


# why need this?
#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# auto-sugestion
#zle-line-init() {
    #zle autosuggest-start
#}
#zle -N zle-line-init

export EDITOR='vim'

#unalias run-help
#autoload run-help
#HELPDIR=/usr/local/share/zsh/help

alias ls='ls -FH'
alias ll='ls -Fla'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias tar="tar --exclude='.DS_Store'"
alias myip='echo "Public IP: $(dig +short myip.opendns.com @resolver1.opendns.com)"; echo "Private IP: $(ipconfig getifaddr en0)"'
alias fucking='sudo'
alias svim='sudo vim'

mcd() {
    mkdir "$@" && cd "$@"
}

shell() {
    ps | grep -e "^`echo $$`" | awk '{ print $4 }'
}

ranger-cd() {
    tempfile=$(mktemp /tmp/temp.XXXX)
    ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
    test -f "$tempfile" &&
        if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
            cd -- "$(cat "$tempfile")"
        fi
        rm -f -- "$tempfile"
}

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

# toggle ASLE
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

#environment variables
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:.
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# disable special creation/extraction of ._* files by tar, etc. on Mac OS X
export COPYFILE_DISABLE=1

if [[ $OS == "Darwin" ]]; then
    export SHELL=/usr/local/bin/zsh
fi

#color
export CLICOLOR=1
#solarized
export LSCOLORS=FxfxbEaEBxxEhEhBaDaCaD

# nvm
export NVM_DIR=~/.nvm
if [[ $OS == "Darwin" ]]; then
    source $(brew --prefix nvm)/nvm.sh
fi
