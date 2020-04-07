#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /usr/share/bash-completion/bash_completion ] && ! shopt -oq posix; then
    . /usr/share/bash-completion/bash_completion
fi
 
# History control
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100000
HISTFILESIZE=2000000
shopt -s histappend

#~~~ aliases ~~~#
alias ll='ls -la'
alias pac='sudo pacman'
alias grep='grep --color=auto'
alias :q="exit"
alias SS="sudo systemctl"
alias v="vim"
alias sv="sudo vim"
alias ls='ls --color=auto'
alias svm='sudo virt-manager'
alias tx='tmux'
alias aqx='cd ~/src/github.com/aquilonix'
alias sqlmap='python ~/tools/sqlmap/sqlmap.py'
alias burp='java -noverify -Dpython.cachedir=/tmp -Xbootclasspath/p:/home/aquilonix/tools/BurpSuitePro/core/burp1.7/BurpSuite-Keygen.jar -jar /home/aquilonix/tools/BurpSuitePro/core/burp1.7/BurpSuite-Pro-v1.7.37.jar'
alias hackthebox='sudo openvpn ~/hackthebox/aquilonix.ovpn'
alias py='python3.8'
#PS1='[\u@\h \W]\$ '

#~~~~wordpress instance~~~#
wordpressbox(){
gcloud beta compute ssh --zone "us-central1-a" "wordpress" --project "supple-outlet-271111"
}

#~~~ vps ~~~#
reconbox(){
ssh aquilonix
}


##source
source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash

## export
export TERM=xterm-256color
export findomain_fb_token=""
export findomain_spyse_token=""
export VariableName=""
export EDITOR=/usr/bin/vim

## tools
mscan(){ #runs masscan
sudo masscan -p4443,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,443,744 $1
}

jsparser(){
python2 /home/aquilonix/tools/JSParser/handler.py
}

dirsearch(){
python ~/tools/dirsearch/dirsearch.py -u $1 -e $2 -t 50 -b
}
gr(){
curl -s  https://api.github.com/search/repositories?q=$1 | jq .items | grep git_url | awk -F'/' '{print $3":"$4"/"$5}'| sed 's/\",//g' | xargs -n1 -I{} echo "git@{}"
}

txc(){
tmux attach-session -t $1
}

profile(){
vim ~/.bashrc
}

sprofile(){
source ~/.bashrc
}

crtsh(){
curl -s https://crt.sh/?Identity=%.$1 | grep ">*.$1" | sed 's/<[/]*[TB][DR]>/\n/g' | grep -vE "<|^[\*]*[\.]*$1" | sort -u | awk 'NF'
}

am(){
amass enum -passive -d $1 -json $1.json
jq .name $1.json | sed "s/\"//g"| httprobe -c 60 | tee -a $1-domain.txt
}

bp(){
burp & exit
} 

s3ls(){
aws s3 ls s3://$1
}

s3cp(){
aws s3 cp $2 s3://$1
}

# Colours have names too. Stolen from Arch wiki
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

# Prompt colours
atC="${txtpur}"
nameC="${txtpur}"
hostC="${txtpur}"
pathC="${txtgrn}"
gitC="${txtpur}"
pointerC="${txtgrn}"
normalC="${txtwht}"

# Red name for root
if [ "${UID}" -eq "0" ]; then
  nameC="${txtred}"
fi

gitPrompt() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

#Patent Pending Prompt
export PS1="${nameC}\u${atC}@${hostC}\h:${pathC}\w${gitC}\$(gitPrompt)${pointerC}▶${normalC} "

#set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent"
    touch $SSH_ENV
    chmod 600 "${SSH_ENV}"
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' >> "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

# source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    kill -0 $SSH_AGENT_PID 2>/dev/null || {
        start_agent
        }
    else
        start_agent
fi
