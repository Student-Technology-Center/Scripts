#!/bin/bash

# Specify session name paths
export SessionName="stc"
export STCPath='/home/stc/WWUSTC/'
export DevSTCPath='/home/stc/devWWUSTC/'

tmux has-session -t $SessionName 2>/dev/null
if [ "$?" -eq 0 ]
then
  exit 1
fi

# Create a new tmux session, -s specifies the name, -d allows us to create the session without attaching to it
su -c "tmux new -d -s $SessionName" stc

# We send a command to the first tab of our tmux session to create a new tab named "django-server" at the specified path.
# -c specifies the path of the window
# -n specifies the name of the window
# C-m is tmux way of entering the command
su -c 'tmux send-keys -t $SessionName:0 "tmux new-window -c $STCPath -n django-server" C-m' stc
# We sleep for 250ms to allow the window to be created before we send a command to it.
# $SessionName:1 specifies the first window of our session, keep in mind that windows start at 0
sleep 0.25
# tmux send-keys -t $SessionName:1 "sudo ./start.sh" C-m
sleep 0.25

su -c 'tmux send-keys -t $SessionName:0 "tmux new-window -c $DevSTCPath -n dev-django-server" C-m' stc
sleep 0.25
su -c 'tmux send-keys -t $SessionName:2 "./start.sh wwustc.com 8000" C-m' stc
sleep 0.25

# Same situation here, we create a new window and run a script located in the path
su -c 'tmux send-keys -t $SessionName:0 "tmux new-window -c $STCPath -n update-scripts" C-m' stc
sleep 0.25
su -c 'tmux send-keys -t $SessionName:3 "tmux split-window" C-m' stc
sleep 0.25
su -c 'tmux send-keys -t $SessionName:3.0 "./loop_update.sh 60" C-m' stc
sleep 0.25
su -c 'tmux send-keys -t $SessionName:3.1 "cd ../devWWUSTC/" C-m' stc
sleep 0.25
su -c 'tmux send-keys -t $SessionName:3.1 "./loop_update.sh 10" C-m' stc
sleep 0.25

su -c 'tmux send-keys -t $SessionName:0 "cd /home/stc/" C-m' stc
