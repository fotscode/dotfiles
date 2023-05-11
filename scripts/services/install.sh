#!/bin/bash
sudo cp rc.local /etc/rc.local
sudo chmod +x /etc/rc.local
sudo cp rc-local.service /etc/systemd/system/rc.local.service
systemctl enable rc-local.service
systemctl start rc-local.service
