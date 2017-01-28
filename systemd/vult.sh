#!/bin/bash

#Skrypt pozwalający na wykonanie komend przy starcie/zatrzymaniu systemu

start() {
  echo "Start" >> /scripts/vult.log
}

stop() {
  echo "Stop" >> /scripts/vult.log
}


case $1 in
  start|stop) "$1" ;;
esac
