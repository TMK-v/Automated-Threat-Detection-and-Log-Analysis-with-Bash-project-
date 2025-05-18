
#!/bin/bash

# Main controller script

echo "[+] Starting Log Analyzer..."

bash ./modules/parse-authlog.sh
bash ./modules/ip-geolocate.sh
bash ./modules/block-ip.sh
bash ./modules/report-generator.sh

echo "[+] Log Analyzer finished."


