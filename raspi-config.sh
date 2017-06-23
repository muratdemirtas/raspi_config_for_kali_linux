#!/bin/sh



# this script must be run with root priviliges.
if [ "$(whoami)" != "root" ]; then
  whiptail --msgbox "this script must be run with root priviliges.type sudo ./raspi-config.sh" $WT_HEIGHT $WT_WIDTH
  exit
fi

# check dpkg database for raspi-config already installed.
if [ $(dpkg-query -W -f='${Status}' raspi-config 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
  whiptail --msgbox "Raspi-config is already installed, try upgrading it within raspi-config..." 10 60

else
  wget http://archive.raspberrypi.org/debian/pool/main/r/raspi-config/raspi-config_20160527_all.deb -P /tmp
  apt-get install libnewt0.52 whiptail parted triggerhappy lua5.1 alsa-utils -y
  # Auto install dependancies on eg. ubuntu server on RPI
  apt-get install -fy
  dpkg -i /tmp/raspi-config_20160527_all.deb
  whiptail --msgbox "Raspi-config is now installed, run it by typing: sudo raspi-config" 10 60
fi

exit
