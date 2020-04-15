#
# ~/.profile
#
#PS1='[\u@\h \W]\$ '


if [ -f /usr/share/bash-completion/bash_completion ] && ! shopt -oq posix; then
    . /usr/share/bash-completion/bash_completion
fi

# History control
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100000
HISTFILESIZE=2000000
shopt -s histappend

##alias
alias d='ddgr'
alias ungron='gron --ungron'
alias pip='pip3'
alias python='python3'
alias apt-get='sudo apt-get'
alias :q='exit'
alias v='vim'
alias sv='sudo vim'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias tx='tmux'
alias waf="wafw00f"
alias mscan='sudo masscan -p4443,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,443,7443'
alias python='python3'
alias ll='ls -lsa'
alias hp='httprobe -t 20000 -p 80,81,300,443,591,593,832,981,1010,1311,2082,2087,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5800,6543,7000,7396,7474,8000,8001,8008,8014,8042,8069,8080,8081,8088,8090,8091,8118,8123,8172,8222,8243,8280,8281,8333,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9200,9443,9800,9981,12443,16080,18091,18092,20720,28017'
## export
export TERM=xterm-256color
export EDITOR=/usr/bin/vim
export GOPATH=$HOME/go
export GO111MODULE=on
source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash

## tools
webss(){
xvfb-run webscreenshot --no-xserver --renderer-binary /usr/bin/phantomjs -r phantomjs -i $1 -p $2 -o $3 -s
}

photon(){
python3 /home/aquilonix/tools/Photon/photon.py -u $1 --wayback -l 3 -t 100 -o /home/aquilonix/recon/tripadvisor.com/08042020/  
}

arjun(){
python3 /home/aquilonix/tools/Arjun/arjun.py -u $1 --get -t 200
}

gitrepo(){
{ find .git/objects/pack/ -name "*.idx"|while read i;do git show-index < "$i"|awk '{print $2}';done;find .git/objects/ -type f|grep -v '/pack/'|awk -F'/' '{print $(NF-1)$NF}'; }|while read o;do git cat-file -p $o;done|grep -E $1
}

gr(){
curl -s  https://api.github.com/search/repositories?q=$1 | jq .items | grep git_url | awk -F'/' '{print $3":"$4"/"$5}'| sed 's/\",//g' | xargs -n1 -I{} echo "git@{}"
}

txc(){
tmux attach-session -t $1
}

s3ls(){
aws s3 ls s3://$1
}

s3cp(){
aws s3 cp $2 s3://$1
}

profile(){
vim ~/.profile
}

sprofile(){
source ~/.profile
}

crtsh(){
curl -s https://crt.sh/?Identity=%.$1 | grep ">*.$1" | sed 's/<[/]*[TB][DR]>/\n/g' | grep -vE "<|^[\*]*[\.]*$1" | sort -u | awk 'NF'
}

certprobe(){ #runs httprobe on all the hosts from certspotter
curl -s https://crt.sh/\?q\=\%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe | tee -a ./all.txt
}

certspotter(){ 
curl -s https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1
}

ipinfo(){
curl http://ipinfo.io/$1
}

am(){ #runs amass passively and saves to json
amass enum --passive -d $1 -json $1.json 
jq .name $1.json | sed "s/\"//g"| httprobe -c 60 | tee -a $1-domains.txt
}

dirsearch(){ #runs dirsearch and takes host and extension as arguments
python3 /home/aquilonix/tools/dirsearch/dirsearch.py -u $1 -r -R 3 -t 100 -w /home/aquilonix/tools/dirsearch/db/tw.txt -e html,js,jsx -x 301,302,40
}

corsy(){
python3 ~/tools/corsy/corsy.py -i $1 -t 50
}



# Change up a variable number of directories
# E.g:
#   cu   -> cd ../
#   cu 2 -> cd ../../
#   cu 3 -> cd ../../../
 function cu {
    local count=$1
    if [ -z "${count}" ]; then
        count=1
    fi
    local path=""
    for i in $(seq 1 ${count}); do
        path="${path}../"
    done
    cd $path
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
