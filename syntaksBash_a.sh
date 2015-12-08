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

for i in {1..10}; do
  echo ${i}
done

# Sprawdzanie czy pewna operacja się udała czy nie; po wykonaniu operacji zmienna $? zawiera 0, jeśli
# operacja się udała, lub 1, jeśli operacja nie udała się
rm tegoPlikuNapewnoNieMa
if [[ $? -eq 1 ]]; then
  echo "Poprzednia operacja nie udała się!"
else
  echo "Usunięto plik"
fi



