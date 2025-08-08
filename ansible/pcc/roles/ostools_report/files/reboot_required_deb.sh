#!/bin/bash
# About: Determine if a reboot is required - DEB system
# 

REBOOT_STATUS=""
REBOOT_FILE=/var/run/reboot-required

if [[ -e $REBOOT_FILE ]]; then
        REBOOT_STATUS="Reboot is required"
    else
        REBOOT_STATUS="Reboot is not required"
fi

echo $REBOOT_STATUS