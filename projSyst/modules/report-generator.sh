#!/bin/bash

DATE=$(date +%F)
REPORT="./data/report-$DATE.txt"
BLOCKED="./logs/blocked.ips.log"
GEOLOG="./logs/geolocated.log"

mkdir -p ./data

{
  echo "Daily Security Report - $DATE"
  echo "============================="
  echo "\nBlocked IPs:"
  cat $BLOCKED
  echo "\nAll Geolocated Entries:"
  cat $GEOLOG
} > $REPORT

echo "[+] Report generated: $REPORT"
