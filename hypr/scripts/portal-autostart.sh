#!/bin/bash

# INCREASED DELAY to ensure Hyprland has fully initialized
sleep 5

# Stop any potentially lingering or conflicting portals
systemctl --user stop xdg-desktop-portal-hyprland.service
systemctl --user stop xdg-desktop-portal-gtk.service
systemctl --user stop xdg-desktop-portal.service

# Start the correct portal implementation via systemctl
systemctl --user start xdg-desktop-portal-hyprland.service
sleep 1 # Small delay between starting the hyprland backend and the generic wrapper
systemctl --user start xdg-desktop-portal.service
