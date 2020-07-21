#!/usr/bin/bash
set -eu

waitforapt(){
  while fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
     echo "Waiting for other software managers to finish..." 
     sleep 1
  done
}

waitforapt
apt-get -qq update
apt-get -qq install -y ufw

ufw --force reset && \
  ufw allow 6443 && \
  ufw allow ssh && \
  ufw allow in from 192.168.0.0/16 to any && \
  ufw default deny incoming && \
  ufw --force enable