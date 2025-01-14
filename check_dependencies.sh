#!/bin/bash

#
# Installs dependencies for Ubuntu/Debian
# 

echo ">>>>>>> Checking dependencies ..."

dependencies=(ffmpeg libcurl4-gnutls-dev libxml2-dev libssl-dev libmysqlclient-dev libcairo2-dev libgtk2.0-dev xvfb xauth xfonts-base libxt-dev libgconf2-4 npm)
uninstalled_dependencies=()
debian_check=$(which apt)

if [ "" == "$debian_check" ]; then
	echo "You do not seem to run Ubuntu or Debian."
	echo ""
	echo "Please install the equivalent packages to following packages:"
	echo "${dependencies[@]}"
	read -p "Press enter to continue"
	exit
fi

for d in "${dependencies[@]}"; do 
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $d|grep "install ok installed")
	echo "Checking for $d: $PKG_OK"
	
	if [ "" == "$PKG_OK" ]; then
		uninstalled_dependencies+=($d)
	fi
done

if [ ! -z "$uninstalled_dependencies" ]; then
	echo "Following packages need to be installed: ${uninstalled_dependencies[@]}"
    sudo apt install "${uninstalled_dependencies[@]}"
fi
