#!/bin/bash
printf "Ping Test (dns & ntp hosts) : \n"
for DC in \
    LT-87.247.68.60 \
    LT-ns1.telecom.lt \
    UK-1.uk.pool.ntp.org \
    UK-ntp2a.mcc.ac.uk \
    UK-213.123.251.87 \
    RU-94.158.96.2 \
    RU-94.100.86.238 \
    RU-81.211.96.62 \
    RU-84.237.112.130 \
    BG-95.158.129.2 \
    BG-0.bg.pool.ntp.org \
    ES-194.224.52.36 \
    ES-0.es.pool.ntp.org \
    IT-89.96.244.166 \
    IT-0.it.pool.ntp.org \
    IE-185.228.169.9 \
    IE-0.ie.pool.ntp.org
do
    ip=$(echo $DC | cut -d"-" -f2)
    printf "$DC: \t$(ping -i .2 -c 10 -q $ip | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done

printf "\nDigitalOcean Ping Test:\n"

# https://www.digitalocean.com/docs/platform/availability-matrix/
for DC in \
    LON1 \
    FRA1 \
    AMS2 \
    AMS3
do
    printf "$DC: \t$(ping -i .2 -c 10 -q speedtest-$DC.digitalocean.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done

printf "\nLinode Ping Test:\n"

# https://www.linode.com/speed-test/
for DC in london frankfurt
do
    printf "$DC: \t$(ping -i .2 -c 10 -q speedtest.$DC.linode.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done

printf "\nAWS Ping Test:\n"
# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html
for DC in \
    Stockholm.eu-north-1 \
    Frankfurt.eu-central-1 \
    Ireland.eu-west-1 \
    London.eu-west-2 \
    Milan.eu-south-1 \
    Paris.eu-west-3
do
    loc=$(echo $DC | cut -d"." -f2)
    printf "$DC: \t$(ping -i .2 -c 10 -q ec2.$loc.amazonaws.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done


