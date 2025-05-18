#!/bin/bash

INPUT="./logs/parsed-auth.log"
OUTPUT="./logs/geolocated.log"
API_URL="http://ip-api.com/csv"

mkdir -p ./logs
> "$OUTPUT"

while IFS=',' read -r IP COUNT; do
    if [[ -n "$IP" ]]; then
        GEO=$(curl -s "$API_URL/$IP?fields=country")
        COUNTRY=${GEO:-Unknown}
        echo "$IP,$COUNT,$COUNTRY" >> "$OUTPUT"
    fi
done < "$INPUT"

echo "[+] Geolocation done."
