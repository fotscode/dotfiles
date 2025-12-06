#!/bin/bash

sleep 2
killall mako
sleep 1
swaync
swaync-client -df
