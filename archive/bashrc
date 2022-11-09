echo "[40;32m---------------------------------------[0m"
echo "[40;32m-- Isaac! Welcom to the Coding World --[0m"
echo "[40;32m---------------------------------------[0m"

#print_pre_prompt ()
#{
#PS1L=$PWD
#if [[ $PS1L/ = "$HOME"/* ]]; then PS1L=\~${PS1L#$HOME}; fi
#PS1R=$USER@$HOSTNAME
#printf "%s%$(($COLUMNS-${#PS1L}))s" "$PS1L" "$PS1R"
#}
#PROMPT_COMMAND=print_pre_prompt

if [[ ${EUID} == 0 ]] ; then
    sq_color="\[\033[0;31m\]"
    err_color="\[\033[0;36m\]"
else
    sq_color="\[\033[0;36m\]"
    err_color="\[\033[0;31m\]"
fi

#PS1="$sq_color\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[01;37m\]\342\234\227$sq_color]\342\224\200\")[\[\033[01;37m\]\t$sq_color]\342\224\200[\[\033[01;37m\]\u@\h$sq_color]\n\342\224\224\342\224\200\342\224\200> \[\033[01;37m\]\W$sq_color $ \[\033[01;37m\]>>\\[\\033[0m\\] "

PS1="$sq_color\342\224\217\342\224\201 \$([[ \$? != 0 ]] && echo \"[$err_color\342\234\227$sq_color]\342\224\200\")[\[\e[0;32m\]\u$sq_color@\[\e[0;33m\]\h$sq_color]\342\224\200[\[\e[1;31m\]\t$sq_color]\342\224\200[\[\e[1;35m\]\w\[\e$sq_color]\[\e[0;31m\]
$sq_color\342\224\227\342\224\201\342\224\201\342\236\224 ⌘ \[\e[0m\]"

#PS1="\[\e[1;34m\]⎲ [\[\e[0;32m\]\u\[\e[1;34m\]@\[\e[0;33m\]\h\[\e[1;34m\]:\[\e[0;34m\]\w\[\e[1;34m\]]\[\e[0;31m\]
#\[\e[1;34m\]⎳ \342\224\201\342\224\201\342\236\224 ⌘ \[\e[0m\]"

#right align

#set_before_prompt()
#{
#printf "%$(tput cols)s\b\b\b\b\b\b\b\b\b" " "
#}

#PROMPT_COMMAND=set_before_prompt

#PS1="$sq_color[\[\e[1;31m\]\t$sq_color]`printf "\r"`\342\224\217\342\224\201 \$([[ \$? != 0 ]] && echo \"[$err_color\342\234\227$sq_color]\342\224\200\")[\[\e[0;32m\]\u$sq_color@\[\e[0;33m\]\h$sq_color]\342\224\200[\[\e[1;35m\]\w\[\e$sq_color]\[\e[0;31m\]
#$sq_color\342\224\227\342\224\201\342\224\201\342\236\224 ⌘ \[\e[0m\]"
PS2="$sq_color> \[\e[0m\]"
unset sq_color
unset err_color

#color
export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad
#solarized
export LSCOLORS=FxfxbEaEBxxEhEhBaDaCaD

#alias
alias ls='ls -F'
alias ll='ls -Fla'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mysqlstart='sudo /Library/StartupItems/MySQLCOM/MySQLCOM start'
alias mysqlrestart='sudo /Library/StartupItems/MySQLCOM/MySQLCOM restart'
alias mysqlstop='sudo /Library/StartupItems/MySQLCOM/MySQLCOM stop'
alias vim='/usr/local/bin/vim'
alias vimdiff='/usr/local/bin/vimdiff'
alias tar="tar --exclude='.DS_Store'"

#environment variables
PATH=/usr/local/bin:/usr/local/mysql/bin:/usr/local/gradle-1.9/bin:$PATH:.

# disable special creation/extraction of ._* files by tar, etc. on Mac OS X
COPYFILE_DISABLE=1; export COPYFILE_DISABLE

# ctags cscope
function buildtag() {
    ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .

    find $(pwd) -name *.cc -or -name *.cpp -or -name *.c -or -name *.h -or -name *.java > cscope.files
    cscope -bq
}
