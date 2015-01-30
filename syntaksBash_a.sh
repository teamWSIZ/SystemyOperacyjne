#!/bin/bash

mojaZmienna=12
innaZmienna="User13"

echo $mojaZmienna
echo $innaZmienna

cat /etc/passwd | grep $innaZmienna
