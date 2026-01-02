#!/usr/bin/env bash
 
 #validation block
if [ "$EUID" -ne 0 ]; then
    echo "Error: This installer needs to be run as root."
    exit1
fi

if ! command -v systemctl >/dev/null 2>&1; then
    echo "Error: systemd is not available on this system."
    exit1
fi

if ! command -v nmcli >/dev/null 2>&1; then
    echo "Error: NetworkManager (nmcli) is not available on this system."
    exit1
fi

if ! command systemctl is-active NetworkManager >/dev/null 2>&1; then
    echo "Error: NetworkManager is not running."
    exit1
fi

 #installation block
SERVICE_SRC="./system/vpntime.service"
SERVICE_DST="/etc/systemd/system/vpntime.service"
install -m 644 "$SERVICE_SRC" "$SERVICE_DST"
systemctl daemon-reload
systemctl enable vpntime.service

 #dispatcher block
DISPATCHER_SRC="./trigger/proton-trigger"
DISPATCHER_DST="/etc/NetworkManager/dispatcher.d/proton-trigger"
mkdir -p /etc/NetworkManager/dispatcher.d
install -m 755 "$DISPATCHER_SRC" "$DISPATCHER_DST"
systemctl restart NetworkManager

 #closing status
