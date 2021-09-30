#!/usr/bin/env sh
set -e
URL="https://location.services.mozilla.com/v1/geolocate?key=geoclue"
LATLONG="$(curl "$URL" | jq -r '.location| "\(.lat):\(.lng)"')"

redshift -l "$LATLONG" -t 4800:3000 -b 1 1
