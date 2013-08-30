export M2_HOME=/Users/virginio/Java/maven-3
export PATH=$M2_HOME/bin:/usr/local/bin:/Users/virginio/bin:"/Applications/VMware Fusion.app/Contents/Library":$PATH
export NODE_PATH=/usr/local/lib/node_modules
eval "$(rbenv init -)"
source /usr/local/Cellar/cdargs/1.35/contrib/cdargs-bash.sh
source ~/.git-completion.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

if [ -f `brew --prefix`/usr/local/etc/bash_completion ]; then
    . `brew --prefix`/usr/local/etc/bash_completion
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# http://www.geekology.co.za/blog/2009/04/enabling-bash-terminal-directory-file-color-highlighting-mac-os-x/
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

alias be="bundle exec"
alias ducks='du -cks * | sort -nr | grep -v total | head -n 10'
alias vim='mvim -v'

function vmware () {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "please provide vm name and action {start|stop|restart|...}"
    return
  fi
  vmrun $2 ~/Documents/Virtual\ Machines.localized/$1.vmwarevm/$1.vmx nogui
}