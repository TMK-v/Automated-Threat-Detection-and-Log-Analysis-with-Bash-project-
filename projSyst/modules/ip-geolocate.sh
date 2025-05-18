#!/bin/bash

INPUT="./logs/parsed-auth.log"
OUTPUT="./logs/geolocated.log"
API_URL="http://ip-api.com/csv"

mkdir -p ./logs
> "$OUTPUT"

while read -r IP COUNT; do
    if [[ -n "$IP" ]]; then
        # Get response like "United States,8.8.8.8"
        RESPONSE=$(curl -s "$API_URL/$IP?fields=country,query")
        
        COUNTRY=$(echo "$RESPONSE" | cut -d',' -f1)
        IP_CHECK=$(echo "$RESPONSE" | cut -d',' -f2)

        if [[ "$IP_CHECK" == "$IP" ]]; then
            echo "$IP,$COUNT,$COUNTRY" >> "$OUTPUT"
        else
            echo "$IP,$COUNT,Unknown" >> "$OUTPUT"
        fi
    fi
done < "$INPUT"

echo "[+] Geolocation done."

