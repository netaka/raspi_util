#!/bin/bash

npm install -g n
n stable
apt-get purge -y nodejs npm

npm install -g homebridge homebridge-netatmo homebridge-irkit \
               homebridge-ifttt homebridge-lifx-lan \
               homebridge-sonybraviatv homebridge-cmd
npm install -g twitter dotenv ps4-waker

echo export NODE_PATH=`npm root -g` >> ~/.bashrc
source ~/.bashrc

HOMEBRIDGE_UNIT_STR=`cat << EOS
[Unit]
Description = homebridge

[Service]
ExecStart = /usr/local/bin/homebridge
Restart = always
Type = simple

[Install]
WantedBy = multi-user.target
EOS
`

echo "HOMEBRIDGE_UNIT_STR" > /etc/systemd/system/homebridge.service

systemctl enable homebridge
systemctl start homebridge
