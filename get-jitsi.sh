#!/bin/sh
echo "Get Jitsi FOSS Skype replacement script"
echo "(C) Thom Hastings 2009-2014 New BSD license"
echo
echo "Downloading & installing Jitsi..."
cd ~
MACHINE_TYPE=`uname -m`
echo -e "Machine type is \e[37m$MACHINE_TYPE\e[0m"
if [ ${MACHINE_TYPE} = 'x86_64' ]
then
  echo "Downloading 64-bit..."
  URL="https://download.jitsi.org/jitsi/debian/jitsi_2.5-latest_amd64.deb"
else
  echo "Downloading 32-bit..."
  URL="https://download.jitsi.org/jitsi/debian/jitsi_2.5-latest_i386.deb"
fi
FILE="jitsi.deb"
wget "$URL" -O $FILE && echo "Installing..." && sudo dpkg -i $FILE
echo "Cleaning up..."
rm $FILE
echo
echo -e "\e[32mDONE\e[0m"
