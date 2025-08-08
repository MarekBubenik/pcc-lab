#!/bin/bash
# Setup crontab: */1 * * * *     bash /home/*****/ostools_report/merger.sh
#

loc=$(dirname "$0")/reports
dest=$(dirname "$0")/report_$(date +'%Y-%m-%d').csv
files=($loc/*)

head -n 1 "${files[0]}" > $dest
for i in $loc/*.csv;do
    tail -n+2 $i >> $dest
done
rm $loc/*.csv