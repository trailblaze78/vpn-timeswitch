#usr/bin/env bash
    sleep 2;
    CODE=$(curl -o /dev/null -s -w "%%{http_code}\n" https://www.google.com);
    TZ=$(curl -s https://ipinfo.io/timezone);

    #validate result
    if [ "$CODE" = "200" ] && [ -n "$TZ" ]; then
        timedatectl set-timezone "$TZ";
    else
        timedatectl set-timezone Europe/London;
    fi
