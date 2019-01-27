Apps Docs
=========

### Roles
Used packages docs and tutorials which I use to create roles in this ansible script.

* bluetooth -
[1](https://wiki.archlinux.org/index.php/bluetooth#Installation),
[2](https://wiki.archlinux.org/index.php/Bluetooth_headset#Headset_via_Bluez5/PulseAudio)
* backlight - [1](https://gitlab.com/wavexx/acpilight)
* docker - [post installation tips](https://docs.docker.com/install/linux/linux-postinstall/)
* spacemacs - [installation](https://wiki.archlinux.org/index.php/Spacemacs#Installation)
* usb - [mount to /media tutorial](https://wiki.archlinux.org/index.php/udisks#Tips_and_tricks)


### Modules
Used ansible modules
* ansible-aur, aur ansible installator module - [github](https://github.com/kewlfft/ansible-aur.git)


### Others
* Spark, arch installation ansible scripts - [github](https://github.com/pigmonkey/spark)


### Rules
If you want's to add new rule, get smallest exists, decrease it, and use it in new rule.

#### Udev
Rules path: /etc/udev/rules.d
* 99-udisks2 - `install_usb` role
* 98-backlight - `install_backlight` role

#### Polkit
Rules path: /etc/polkit-1/rules.d
* 51-blueman - `install_bluetooth` role

#### Security
Rules path: /etc/security/limits.d
* 99-realtime - `install_audio` role
