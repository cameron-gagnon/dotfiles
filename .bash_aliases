# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cos='ssh cgagnon@cosmos.eecs.umich.edu -p 47923'
alias reset_audio="pulseaudio -k && sudo alsa force-reload"
alias g+="g++ -std=c++14 -Wall -Werror -Wvla -Wextra -pedantic -O3"


# input: default git command. Ex. "git commit -m"
# output: scm_breeze aliasas for git command. Ex. "gcm = git commit -m"
function lscm() {
    list_aliases $@
}

#login for linux terminal on CAEN Servers
alias caen='sshpass -f ~/.secret.txt ssh cgagnon@login-course.engin.umich.edu'
alias e='exit'
alias v='vim'
alias o='open'
alias ls='ls -Ga'
alias l='ll -a'
alias c='clear'
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias most="history | cut -c 8- | sort | uniq -c | sort"
alias edit="v ~/.bash_aliases"
alias u='. ~/.bash_aliases'
alias mod='chmod +x'
alias lab='cd ~/src/ctf/labyrenth'
alias burp='java -jar -Xmx1024m ~/Downloads/burpsuite_free_v1.7.03.jar'
alias act='. venv/bin/activate'
alias pnu='cd ~/src/projammin/pnu/'
alias ctf='cd ~/src/ctf/'
alias pico='cd ~/src/ctf/pico/'
alias col='cd ~/src/college/W17'
alias 494='col && 494-W17/494_projects/crapscrapers'
alias 398='col && 398-W17'
alias 496='col && 496-W17'
alias T496='col && TC-496-W17'
alias 485='col && 485-W17/485_projects/eecs485-p3'
alias 385='col && 385-W17'
alias gcm='git commit -m '
alias go='git checkout'
alias c4='col && 398-W17/c4cs.github.io'
alias vedit='v ~/.vimrc'
alias grep='grep --color=auto --exclude-dir venv --exclude-dir .git $@'