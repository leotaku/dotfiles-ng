#!/usr/bin/env sh
set -e
URL="https://location.services.mozilla.com/v1/geolocate?key=geoclue"
LATLONG="$(curl "$URL" | jq -r '.location | "\(.lat):\(.lng)"')"
if [ -z "$LATLONG" ]; then
    LATLONG="48.217:16.3944"
fi

redshift -l "$LATLONG" -t 4800:2000 -b 1 1
