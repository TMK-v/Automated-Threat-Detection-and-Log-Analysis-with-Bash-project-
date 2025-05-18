#!/bin/bash

LOG_FILE="/var/log/auth.log"
OUTPUT="./logs/parsed-auth.log"
WHITELIST="./data/whitelist.txt"

mkdir -p ./logs
> "$OUTPUT"
grep "Failed password" $LOG_FILE | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | while read COUNT IP; do
  if ! grep -q "$IP" $WHITELIST; then
    echo "$IP $COUNT" >> $OUTPUT
  fi
done

echo "[+] Auth log parsed."
