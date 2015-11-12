# --------------------- #
# Environment variables #
# --------------------- #

export EDITOR="vim"
export PATH=/usr/local/sbin:/usr/local/bin:/usr/local/opt/mysql55/bin/:/Users/virginio/bin:"/Applications/VMware Fusion.app/Contents/Library":/Applications/riak/rel/riak/bin:$PATH
export NODE_PATH=/usr/local/lib/node_modules

# http://www.geekology.co.za/blog/2009/04/enabling-bash-terminal-directory-file-color-highlighting-mac-os-x/
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export DOCKER_CERT_PATH=/Users/virginio/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://192.168.59.103:2376

# colored grep
export GREP_OPTIONS='--color=auto'

# see http://mywiki.wooledge.org/BashFAQ/088#preview
HISTFILESIZE=400000000 # Size of the history file
HISTSIZE=10000 # Size of the history in memory
PROMPT_COMMAND="history -a" # this command will be executed after each exectuted command
export HISTSIZE PROMPT_COMMAND
shopt -s histappend # this enables appending commands immediately to the history

# ------- #
# Aliases #
# ------- #

# Reload the .bash_profile
alias rl="source ~/.bash_profile"

alias l='ls -FAlah'
alias b="bundle exec"
alias g="git"
alias ducks='du -cks * | sort -nr | grep -v total | head -n 10'
alias vim='mvim -v'

# --------- #
# Functions #
# --------- #

function vmware () {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "please provide vm name and action {start|stop|restart|...}"
    return
  fi
  vmrun $2 ~/Documents/Virtual\ Machines.localized/$1.vmwarevm/$1.vmx nogui
}

function cdl() {
  cd $1; l
}

# ---------------- #
# Auto completions #
# ---------------- #

# This was prompted to be installed by the cdargs brew formula
if [ -f /usr/local/etc/bash_completion.d/cdargs-bash.sh ];
then
  source /usr/local/etc/bash_completion.d/cdargs-bash.sh
fi

# bash-completion: http://bash-completion.alioth.debian.org/
# Installed via Homebrew
if [ -f `brew --prefix`/usr/local/etc/bash_completion ]; then
    . `brew --prefix`/usr/local/etc/bash_completion
fi

source ~/.git-completion.sh

source ~/projects/dotfiles/tmuxinator-completion.sh

# ---------- #
# The prompt #
# ---------- #
#
PS1='\[\033[0;36m\][\W$(__git_ps1 " (%s)")]\[\033[0m\] '

# ---- #
# Misc #
# ---- #

# Add rbenv's shims directory to $PATH and set up Bash autocompletion
if which rbenv &> /dev/null; then
  eval "$(rbenv init -)"
fi

# Use vi bindings instead of the default emacs bindings
# To list the current bindings user "bind -P"
# set -o vi

source /usr/local/opt/nvm/nvm.sh

ssh-add
