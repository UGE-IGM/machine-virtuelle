#!/bin/bash -x

# Add fr locales
sed 's/^# fr_FR.UTF-8/fr_FR.UTF-8/' -i /etc/locale.gen
sed 's/^# en_US.UTF-8/en_US.UTF-8/' -i /etc/locale.gen
locale-gen
localectl set-locale LANG=fr_FR.UTF-8
localectl set-keymap fr

# Update cache
apt-get --yes update

# Install VBox Guest Additions Deps
apt -yt buster-backports install fasttrack-archive-keyring
echo "deb https://fasttrack.debian.net/debian/ buster-fasttrack main contrib" > /etc/apt/sources.list.d/fasttrack.list
echo "deb https://fasttrack.debian.net/debian/ buster-backports main contrib" >> /etc/apt/sources.list.d/fasttrack.list
apt-get update
apt-get --yes install virtualbox-guest-utils

# Install graphical suite
apt-get --yes install gnome gdm3

# Install discord
wget -cq https://dl.discordapp.net/apps/linux/0.0.16/discord-0.0.16.deb
dpkg -i discord-0.0.16.deb
apt-get --yes --fix-broken install 

# Install Sublimetext
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add
echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list
apt-get --yes update
apt-get --yes install sublime-text

# Install some packages
apt-get --yes install \
  build-essential \
  pkg-config \
  doxygen \
  git \
  libglib2.0-0 \
  libc++1 \
  libmlv3 \
  libmlv3-dev \
  libsdl2-ttf-2.0-0 \
  libsdl2-ttf-dev \
  libsdl-gfx1.2-5 \
  libsdl-image1.2 \
  libsdl-mixer1.2 \
  libsdl-ttf2.0-0 \
  libsdl1.2debian \
  libtool \
  libxml2-dev \
  libxml2-doc \
  xml2

# Install for BDD
apt-get --yes install php7.3 postgresql python3-flask

# Cleanup
apt-get --yes autoremove
apt-get --yes clean

# Setup padawan/jedi
userdel -r padawan # clean
useradd -m -s /bin/bash  padawan
usermod -aG sudo,vboxsf padawan
chpasswd <<< padawan:jedi
