#!/bin/bash

export PORT=5001
export MIX_ENV=prod
export GIT_PATH=/home/tasksmanager2/src/tasksmanager2

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "tasksmanager2" ]; then
	echo "Error: must run as user 'tasksmanager2'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tasksmanager2 ]; then
	echo mv ~/www/tasksmanager2 ~/old/$NOW
	mv ~/www/tasksmanager2 ~/old/$NOW
fi

mkdir -p ~/www/tasksmanager2
REL_TAR=~/src/tasksmanager2/_build/prod/rel/tasksmanager/releases/0.0.1/tasksmanager.tar.gz
(cd ~/www/tasksmanager2 && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/tasksmanager2/src/tasksmanager2/start.sh
CRONTAB

#. start.sh
