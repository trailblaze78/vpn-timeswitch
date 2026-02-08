# vpn-timeswitch
Simple service tool that automatically switches system timezone to match your ip address location. Only tested on ProtonVPN GUI and on Arch Linux, but this version should also support other vpn services and Linux Repos. More versions are in development, especially for Windows and Mac, possibly an app for mobile in the future. Please any suggestion or advice is welcome: jerry.co45@tutamail.com

WARNING <br>
This version is still under development. <br>
The installer will set set up a files in system folders, therefore it is necessary running with root permissions. <br>
The installer will enable NTP Synchronisation to ensure correct time-date settings<br>
This program requires systemd enabled

How does it work? 
The tool is made out of 3 services (2 of which act as a trigger) and a script + installation script.

Process:<br>
1)During the installation, the user will be prompted tp decide a default timezone (it should be set to your real timezone), and the user will be required to input the name of the network interface used by their VPN service. Example: ProtonVPN uses "proton0" as default interface name, wireguard used "wg0" and so on. If you are not sure about your vpn network interface, before running the installer, run "ip a" while connected to your VPN and check the name of their interface.<br>
2)After installation, the main trigger (vpn-tz@.service) service starts everytime the network interface specified durin installation comes up or goes down. This trigger will start the script.<br>
3)The script will send a request to an IP geolocation website, at then it will use the response of the request to run a "timedatectl set" command to synchronize your systemtimezone to the VPN IP address<br>
4)When disconnecting from the VPN, the script will run again, setting the systemctl back to the real one.<br>
5)The default timezone is used in case connection get disrupted while connected to the vpn, in the case if you disconnect without internet and the script runs without a response from the IP geolocation website, it will set the system timezone to the timezone you selected manually.<br>
6)Another service (timeboot.service) acts as a trigger on boot to restore the system to you original IP, in case the previous session went down without triggering the script.<br><br>

N.B. The tool uses the services offered by https://ipwho.is in their free tier, in order to operate so it is for now limited to 10,000 requests per day. It should be enough for the current usage load it's getting but I'm planning to set up my own webserver capable of geolocating ip addresses.<br>

Donate if you can:<br>

<a href="https://buymeacoffee.com/thermalstudios">Buy me a coffee!</a> <br /> - BTC: bc1qgqalhkzry7hf93rxw4luewwkh34ef5mqng84gc <br />- Monero: 4AjbTUoYTXRWcUopezn6vEEzpY5KuyMQd73CFxFNryZ8AVS7kqxPAnW4rt7hpVi3bWSeddstpVsAkgZtFgBKmat3FQAmKm


