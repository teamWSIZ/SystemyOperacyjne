#!/bin/bash

mojaZmienna=12
innaZmienna="User13"

echo $mojaZmienna
echo $innaZmienna

cat /etc/passwd | grep $innaZmienna

# to jest komentarz
echo Pierwszy argument to: $1     #pierwszy argument skryptu
echo Drugi argument to: $2     #drugi argument skryptu
echo Liczba argumentów: $#
echo Wszystkie argumenty $@

## Zmienne, wykonywanie komend linuxa, sprawdzanie czy dały wynik (jakiś) czy pusty
user="tttuuu"
wynik=`cat /etc/passwd | grep $user`

if [[ -z "${wynik}" ]]; then
  echo "User $user nie istnieje na tym systemie"
fi
