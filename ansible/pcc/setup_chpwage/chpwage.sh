#!/bin/sh

for i in root mb; do
        chage -M 90 -E $(/bin/date -d +180days +%F) -I 30 -d $(date -d -1days +%F) ${i} || continue
done
