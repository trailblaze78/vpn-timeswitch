#!/usr/bin/env bash
    sleep 2;

    . /etc/vpn-tz.conf
    FALLBACK_TZ="${DEFAULT_TZ}"
    
    CODE=$(curl -o /dev/null -fs --max-time 5 -w "%{http_code}\n" https://www.google.com);
    TZ=$(curl -s "https://ipwho.is/?fields=timezone" | grep -oP '"id":\s*"\K[^"]+');

    #validate result
    if [ "$CODE" = "200" ] && [ -n "$TZ" ]; then
        timedatectl set-timezone "$TZ";
    else
        timedatectl set-timezone "$FALLBACK_TZ"
    fi
