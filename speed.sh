#!/bin/bash

function spinner()
{
    local lines='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $1)" ]; do
        local temp=${lines#?}
        printf "\r [%c]  " "$lines"
        local lines=$temp${lines%"$temp"}
        sleep 0.15
    done
    printf "\r"
}

printf "DigitalOcean Speed Test: (100MB each)\n\n"

# https://www.digitalocean.com/docs/platform/availability-matrix/
for DC in LON1 FRA1 AMS2 AMS3
do
    printf "$DC: \e\n"
    printf "$(wget -O /dev/null http://speedtest-$DC.digitalocean.com/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\e\n" & spinner $!
done


printf "\n\nLinode Speed Test: (100MB each)\n\n"

# https://www.linode.com/speed-test/
for DC in london frankfurt
do
    printf "$DC: \e\n"
    printf "$(wget -O /dev/null http://speedtest.$DC.linode.com/100MB-$DC.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\e\n" & spinner $!
done


printf "\n\nAWS Speed Test: (10MB each)\n\n"

# https://cloudharmony.com/speedtest-for-aws:ec2
for DC in eu-north-1 eu-central-1 eu-west-1 eu-west-2 eu-west-3 eu-north-1 eu-south-1
do
    printf "$DC: \e\n"
    printf "$(wget -O /dev/null http://$DC-ec2.cloudharmony.net/probe/test10mb.jpg 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\e\n" & spinner $!
done


printf "\n\nGCP Speed Test: (10MB each)\n\n"

# https://cloudharmony.com/speedtest-for-google:compute
for DC in europe-north1 europe-west1 europe-west2 europe-west3 europe-west4 europe-west6
do
    printf "$DC: \e\n"
    printf "$(wget -O /dev/null http://$DC-gce.cloudharmony.net/probe/test10mb.jpg 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\e\n" & spinner $!
done


printf "\n\nVultr/Choopa Speed Test: (100MB each)\n\n"

# https://www.vultr.com/resources/faq/#downloadspeedtests
for DC in FRA-DE AMS-NL PAR-FR LON-GB
do
    printf "$DC: \e\n"
    printf "$(wget -O /dev/null http://$DC-ping.vultr.com/vultr.com.100MB.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\e\n" & spinner $!
done
