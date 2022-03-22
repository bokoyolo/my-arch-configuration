#!/bin/bash
echo "Installing kde"
{
  sudo pacman -Sy --noconfig plasma plasma-desktop okular dolphine konsole spectacle gwenview ksysguard sddm
  sudo pacman -Rs --noconfig gnome
  sudo systemctl disable gdm
  sudo systemctl enable sddm
  sudo systemctl stop gdm
  sudo systemctl start sddm
}&>/dev/null
