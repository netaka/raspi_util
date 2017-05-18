#!/bin/bash

sudo npm install -g n
n stable
sudo apt-get purge -y nodejs npm

sudo npm install -g homebridge homebridge-netatmo homebridge-irkit \
                    homebridge-ifttt homebridge-lifx-lan \
                    homebridge-sonybraviatv homebridge-cmd
sudo npm install -g twitter dotenv ps4-waker

echo export NODE_PATH=`npm root -g` >> ~/.bashrc
source ~/.bashrc

HOMEBRIDGE_UNIT_STR=`cat << EOS
[Unit]
Description = homebridge

[Service]
ExecStart = /usr/local/bin/homebridge
User = $USER
Restart = always
Type = simple

[Install]
WantedBy = multi-user.target
EOS
`

echo "$HOMEBRIDGE_UNIT_STR" > homebridge.service
sudo mv homebridge.service /etc/systemd/system/

sudo systemctl enable homebridge
sudo systemctl start homebridge
