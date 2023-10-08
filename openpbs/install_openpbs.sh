#!/bin/bash
# Installation OpenPBS script created for Ubuntu 20.04
apt-get update -y && apt-get upgrade -y
mkdir -p /home/developer/Downloads
cd /home/developer/Downloads
apt-get install -y gcc make libtool libhwloc-dev libx11-dev \
  libxt-dev libedit-dev libical-dev ncurses-dev perl \
  postgresql-server-dev-all postgresql-contrib python3-dev tcl-dev tk-dev swig \
  libexpat-dev libssl-dev libxext-dev libxft-dev autoconf \
  automake g++
apt-get install -y expat libedit2 postgresql python3 postgresql-contrib sendmail-bin \
  sudo tcl tk libical3 postgresql-server-dev-all wget unzip
wget https://github.com/openpbs/openpbs/archive/refs/heads/master.zip \
    && unzip master.zip \
    && cd openpbs-master \
    && ./autogen.sh \
    && ./configure --prefix=/opt/pbs --enable-ptl \
    && ./configure --prefix=/opt/pbs --libexecdir=/opt/pbs/libexec \
    && make \
    && sudo make install \
    && sudo /opt/pbs/libexec/pbs_postinstall \
    && sudo sed -i 's/PBS_START_MOM=0/PBS_START_MOM=1/' /etc/pbs.conf \
    && sudo chmod 4755 /opt/pbs/sbin/pbs_iff /opt/pbs/sbin/pbs_rcp

