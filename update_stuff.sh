#!/bin/bash -e

function displayHeader {
  echo ''
  echo '**********'
  echo '**********' $1
  echo '**********'
  echo ''
}

LOG=/Users/virginio/log/update_stuff.log

echo '' > $LOG # Clear logfile
displayHeader 'Execution date: '$(date +"%Y-%m-%d") 1>> $LOG

displayHeader 'GEMS' 1>> $LOG
/Users/virginio/.rbenv/shims/gem update 1>> $LOG
/Users/virginio/.rbenv/shims/gem clean 1>> $LOG

displayHeader 'BREW' 1>> $LOG
/usr/local/bin/brew update 1>> $LOG
/usr/local/bin/brew upgrade 1>> $LOG

displayHeader 'VIM' 1>> $LOG
/usr/bin/vim -c PluginUpdate -c quitall >> $LOG 2>&1
