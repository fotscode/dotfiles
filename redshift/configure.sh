#!/bin/bash
curl "https://location.services.mozilla.com/v1/geolocate?key=geoclue" > location

echo "[redshift]" > redshift.conf
echo "location-provider=manual" >> redshift.conf
echo "" >> redshift.conf
echo "[manual]" >> redshift.conf
cat location | tr "{}" "\n" | grep lat | tr "\",:ng" " \n=on" | tr -d " " >> redshift.conf

rm location

