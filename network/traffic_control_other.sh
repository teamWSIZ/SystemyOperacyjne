#!/bin/sh

tc qdisc del root dev eth4
tc qdisc add dev eth4 root handle 1:0 htb

tc class add dev eth4 parent 1:0 classid 1:1 htb rate 3500kbit ceil 3750kbit

for i in `seq 1 250`
do
   for j in `seq 2 9`
   do
      tc class add dev eth4 parent 1:1 classid 1:$j$i htb rate 100kbit ceil 800kbit
      tc filter add dev eth4 protocol ip parent 1:0 u32 match ip dst 192.168.$j.$i flowid 1:$j$i
      tc qdisc add dev eth4 parent 1:$j$i handle 1$j$i:0 sfq perturb 10
   done
done
