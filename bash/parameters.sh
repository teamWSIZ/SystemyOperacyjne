#Uwagi nt. ekspansji parametrów:
#http://linux.die.net/man/1/bash

#Listy:
for i in {1,2,3}; do echo $i; done

## Brace expansion
#Custom list generation
echo a{x,y,z}b
echo a{x,y,z}{1,2}

#Integers:
echo {1..10}

#To avoid conflicts with parameter expansion, the string ${ is not considered eligible for brace expansion.

#Usages
mkdir /usr/local/src/bash/{old,new,dist,bugs}
plan{2012..2015}{1,2}

## Parameter expansion
${pp:2}     #offset, :from:len - len can be specified
${pp#pre}   #prefix removal
${pp%suf}   #suffix removal
${pp/from/to} #substitution

## Command expansion
$(command)

## Arithmetic expansion
$((expression))

## Pattern matching
 ls -ld _plan201[12]*   #1 or 2

