#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#~~~ aliases ~~~#
alias grep='grep --color=auto'
alias pac="sudo pacman"
alias SS="sudo systemctl"
alias v="vim"
alias sv="sudo vim"
alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

#~~~~wordpress instance~~~#
wordpressbox(){
gcloud beta compute ssh --zone "us-central1-a" "wordpress" --project "supple-outlet-271111"
}

#~~~ vps ~~~#
reconbox(){
ssh aquilonix
}

#~~~~ git repo ~~~#
gitrep(){
eval `ssh-agent`
ssh-add ~/.ssh/Jhan\ Thng
}

##source
source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash


## export
export TERM=xterm-256color
export findomain_fb_token="417214048996312|mQL98eKGkoR6-cOLME360E8OZbM"
export findomain_spyse_token="MFbuz0wkHZX9qfKrfnVfdXmgfFgWvm6q"
export VariableName="26f963a7ffa28bf3e16a0783b07bea8cbb8b07e12ec2e04903e422a1beda123b"
export EDITOR=/usr/bin/vim

## tools
profile(){
vim ~/.bashrc
}

sprofile(){
source ~/.bashrc
}

fd(){
findomain  -t $1 -o
}

crtsh(){
curl -s https://crt.sh/?Identity=%.$1 | grep ">*.$1" | sed 's/<[/]*[TB][DR]>/\n/g' | grep -vE "<|^[\*]*[\.]*$1" | sort -u | awk 'NF'
}

dirsearch(){
cd ~/tools/dirsearch*
python3 dirsearch.py -u $1 -e $2 -t 200 -x 400,404,500 -w $3
cd ~/
}

am(){
amass enum -passive -d $1 -json $1.json
jq .name $1.json | sed "s/\"//g"| httprobe -c 60 | tee -a $1-domain.txt
}

xmind(){
/home/aquilonix/Xmind/XMind_amd64/XMind &
}

burp(){
java -noverify -Dpython.cachedir=/tmp -Xbootclasspath/p:/home/aquilonix/tools/BurpSuitePro/core/burp1.7/BurpSuite-Keygen.jar -jar /home/aquilonix/tools/BurpSuitePro/core/burp1.7/BurpSuite-Pro-v1.7.37.jar
} 

# 'Safe' version of __git_ps1 to avoid errors on systems that don't have it
function gitPrompt {
  command -v __git_ps1 > /dev/null && __git_ps1 " (%s)"
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

# Patent Pending Prompt
export PS1="${nameC}\u${atC}@${hostC}\h:${pathC}\w${gitC}\$(gitPrompt)${pointerC}▶${normalC} "