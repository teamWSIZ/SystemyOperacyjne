#!/bin/bash

setupUser() {
  USER=$1
  echo "Creating user" 
  echo $USER
  useradd -m $USER
  echo $USER:blablabla | chpasswd
  cp -r /home/ttt/.config /home/$USER
  chown -R $USER:$USER /home/$USER
}

for i in {1..50}; 
do 
    setupUser user$i
done
