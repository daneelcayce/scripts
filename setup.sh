#!/bin/bash

# setup.sh
# Post-install script for Debian boxes, run after some local network stuff
# Daniel Alexander <xandernaut@gmail.com>
# Updated February 2018
# Note: needs to be run with sudo


# first, get rid of firefox-esr (and tell Debian not to install Chromium)
apt-get update
apt-get remove --purge firefox-esr chromium

echo "Installing repository things..."
# install stuff from repositories
apt-get install -y git build-essential fp-compiler pandoc unzip musescore pidgin

# install Atom and Firefox
echo "Installing Atom..."
wget -O atom-amd64.deb https://atom.io/download/deb
dpkg --install atom-amd64.deb
wget -O firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/58.0.1/linux-x86_64/en-US/firefox-58.0.1.tar.bz2
mkdir ~/.local/applications
tar jxf firefox.tar.bz2 -C ~/.local/applications
echo export PATH="~/.local/applications:~/.local/applications/firefox:$PATH" >> ~/.bashrc
source ~/.bashrc

# clean up
rm atom-amd64.deb
rm firefox.tar.bz2

# install Atom packages
apm install language-pascal busy-signal build build-fpc
apm install city-lights-ui city-lights-syntax city-lights-icons

# install IBM Plex fonts
cd /tmp
wget "https://github.com/IBM/type/archive/master.zip"
unzip master.zip
rm master.zip
cd type-master
mkdir -p /usr/share/fonts/truetype/ibm-plex
cp /tmp/type-master/fonts/*/desktop/pc/*.ttf /usr/share/fonts/truetype/ibm-plex/.
fc-cache -fv

# overwrite some configuration files for Atom and Cinnamon
cat atom/init.coffee > ~/.atom/init.coffee
cat atom/config.cson > ~/.atom/config.cson
cat cinnamon/calendar/13.json > ~/.cinnamon/configs/calendar@cinnamon.org/13.json
cat cinnamon/menu/16.json > ~/.cinnamon/configs/menu@cinnamon.org/16.json
cat cinnamon/notifications/notifications@cinnamon.org.json > ~/.cinnamon/configs/notifications@cinnamon.org/notifications@cinnamon.org.json
cat cinnamon/power/power@cinnamon.org.json > ~/.cinnamon/configs/power@cinnamon.org/power@cinnamon.org.json
cat cinnamon/sound/sound@cinnamon.org.json > ~/.cinnamon/configs/sound@cinnamon.org/sound@cinnamon.org.json
cat cinnamon/user/5.json > ~/.cinnamon/configs/user@cinnamon.org/5.json

# Install wordgrinder, using script
./wordgrinder-install

# clean up
apt autoremove

exit
