#!/bin/bash
# Skrypt do zapinania pliku /root/test/drive jako/do /dev/loop4, i montowania calosci
# w kartotece /mnt/aa

# Po zapisaniu pliku dodac atrybut wykonywalnosci, tzn. "chmod +x skryptLosetup.sh"
# potem, bedac w kartotece pliku, mozna go uruchomic piszac "./skryptLosetup.sh <argument>"

if [[ $# -eq 0 ]]; then
  echo "Podaj 1 argument"
  exit
fi


if [[ $1 == "S" ]]; then
  echo "Starting loop devices"
  losetup /dev/loop4 /root/test/drive
  mount /dev/loop4 /mnt/aa
elif [[ $1 == "Stop" ]]; then
  echo "Stopping loop drive"
  umount /dev/loop4
  losetup -d /dev/loop4
fi
  
