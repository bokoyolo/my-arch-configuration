#!/bin/bash
echo "Installing the necessary components"
{
  pacman -Sy --noconfirm sudo nano zsh;
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
}&>/dev/null
echo "Creating a user"
{
  useradd -m -G wheel -s /bin/zsh boko;
  echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.tmp;
}&>/dev/null
echo "Installing DE"
{
  pacman -Sy --noconfirm archlinux-keyring;
  pacman -Sy --noconfirm gnome;
  pacman -Sy --noconfirm papirus-icon-theme;
}&>/dev/null
echo "Installing pamac"
{
  echo '[archlinuxcn]' >> /etc/pacman.conf;
  echo 'Server = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf;
  pacman-key --keyserver hkps://keys.openpgp.org --recv-keys 6E58E886A8E07538A2485FAED6A4F386B4881229;
  pacman-key --lsign-key 6E58E886A8E07538A2485FAED6A4F386B4881229;
  pacman -U https://vmi394248.contaboserver.net/fcgu/fcgu-mirrorlist-1-1-any.pkg.tar.zst
  echo '[fcgu]' >> /etc/pacman.conf;#gnome unstable
  echo 'Include = /etc/pacman.d/fcgu-mirrorlist' >> /etc/pacman.conf;
  pacman -Sy && sudo pacman -S --noconfirm archlinuxcn-keyring;
  pacman -Sy --noconfirm yay;
  yay -S --noconfirm pamac-all;
}&>/dev/null
echo "Installing driver for wifi adapter"
{
  sudo pacman -S --noconfirm linux-headers dkms git;
  git clone https://github.com/morrownr/8821au-20210708.git;
  cd 8821au-20210708;
  no | sudo ./install-driver.sh;
}&>/dev/null
echo "Installing browser"
{
  yay -S --noconfirm brave-bin
}&>/dev/null
echo "Now you need to enter the password for your user"
passwd boko
echo "Basic system setup is complete"
sleep 1
echo "Don't forget to configure zsh"
sleep 1
echo "The computer will restart in 15 seconds"
sleep 15
reboot
