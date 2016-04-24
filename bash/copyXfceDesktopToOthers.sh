#!/bin/sh

function setupUser {
  USER=$1
  adduser $USER
  echo $USER:xxxxxxxxxx | chpasswd
  cp -r /home/pm/.config /home/$USER
  chown -R $USER:$USER /home/$USER
}

for i in {1..10}; 
do 
  setupUser user$i
done
