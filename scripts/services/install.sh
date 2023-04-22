#!/bin/bash
cp rc.local /etc/rc.local
chmod +x /etc/rc.local
cp rc-local.service /etc/systemd/system/rc.local.service
systemctl enable rc-local.service
systemctl start rc-local.service
