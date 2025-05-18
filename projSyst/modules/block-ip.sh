#!/bin/bash

INPUT="./logs/geolocated.log"
BLACKLIST="./data/blacklist.txt"
BLOCKED="./logs/blocked-ips.log"

mkdir -p ./logs
> $BLOCKED

while IFS="," read -r IP COUNT COUNTRY; do
  if [[ $COUNT -ge 5 ]]; then
    if ! grep -q "$IP" $BLACKLIST; then
      sudo iptables -A INPUT -s $IP -j DROP
      echo "$IP, $COUNT, $COUNTRY" >> $BLOCKED
    fi
  fi
done < $INPUT

echo "[+] Blocking done."


