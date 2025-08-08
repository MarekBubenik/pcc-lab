#!/bin/bash
# About: Determine if a reboot is required - RPM system
# 

REBOOT_STATUS=""
dnf needs-restarting -r >/dev/null

if [[ "$?" -eq 1 ]]; then
    REBOOT_STATUS="Reboot is required"
else
    REBOOT_STATUS="Reboot is not required"
fi

echo $REBOOT_STATUS