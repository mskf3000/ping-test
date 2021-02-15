#!/bin/bash
printf "mtr test ($1 passes): "
for DC in \
    LT-ns1.serveriai.lt \
    UK-1.uk.pool.ntp.org \
    RU-94.100.86.238 \
    BG-95.158.129.2 \
    ES-194.224.52.36 \
    IT-89.96.244.166 \
    IE-185.228.169.9 
do
    ip=$(echo $DC | cut -d"-" -f2)
    printf "\n\n $DC \n"
    mtr -w -c 1 $ip
done
