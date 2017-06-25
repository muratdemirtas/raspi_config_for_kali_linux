#!/usr/bin/env bash

echo  '#####                     (0%)\r'
author="author: murat demirtas"
author="$author <muratdemirtastr@gmail.com> "

echo "Raspberry Pi Config Utility Installer For Kali Linux OS"
echo $author

echo Detecting Operating System and Linux Kernel Version
echo $(uname -a)

is_kali="$(uname -a)"
kali_identifier="kali"

if echo "$is_kali" | grep -q "$kali_identifier"; then
    echo "kali operating system has been detected";
    echo  '########                  (10%)\r'
else
    echo "kali not detected, did you want to contiune?";

    while true
    do
        read user_response
        if [[ $user_response != "yes" && $user_response != "no" ]]
        then
          echo pls only type yes or no
        elif [ $user_response == "yes" ]
        then
          echo "installer running"
          echo  '#########                  (20%)\r'
          break;
        elif [ $user_response == "no" ]
        then
          echo "install operation was cancelled by user"
          exit 1;
        fi
    done

fi

echo "updating repository sources with apt-get update"
apt-get update
echo  '###########                (30%)\r'

if [ $(dpkg-query -W -f='${Status}' raspi-config 2>/dev/null | grep -c "ok installed") -eq 1 ];
then
    echo raspi-config is already installed on your system
    exit

else
    echo "raspi-config is not installed on your system"

            wget http://archive.raspberrypi.org/debian/pool/main/r/raspi-config/raspi-config_20160527_all.deb -P /tmp
            echo  '###############                (40%)\r'
            apt-get install libnewt0.52 whiptail parted triggerhappy lua5.1 alsa-utils -y
             # Auto install dependancies on eg. ubuntu server on RPI
            apt-get install -fy
            echo  '######################         (70%)\r'
            dpkg -i /tmp/raspi-config_20160527_all.deb
            echo  '############################   (80%)\r'

            echo  "checking boot partition for installing raspi config"
            is_boot_sector_mount="$(df -h)"
            boot_identifier="/dev/mmcblk0p1"

            if echo "$is_boot_sector_mount" | grep -q "$boot_identifier";
              then
              echo "boot sector spotted, installing finished"
              echo Raspi-config is now installed, run it by typing: sudo raspi-config
              echo The quieter you become, the more you are able to hear
              echo  '############################(100%)\r'
              exit 0;
            else
                echo "boot sector mounting";
                sudo mount /dev/mmcblk0p1 /boot
                echo "boot sector mounted";
                echo '#############################  (90%)\r'
                echo "boot sector spotted, installing finished"
                echo Raspi-config is now installed, run it by typing: sudo raspi-config
                echo "dont forget type sudo  mount /dev/mmcblk0p1 /boot if you want to run raspi-config after system reboot"
                echo The quieter you become, the more you are able to hear
                echo ############################(100%)\r
                exit 0;
                
           fi

fi






