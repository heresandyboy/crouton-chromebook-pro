#!/bin/sh

echo "RUNNING APT.SH to install packages"

echo "APT Detecting architecture...";
MACHINE_MTYPE="$(uname -m)";
ARCH="${MACHINE_MTYPE}";
REPO_VENDOR="microsoft";

echo "Ensuring curl is installed";
apt-get install -y curl;

echo "Installing Visual Studio Code...";
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code # or code-insiders

if [ $? -eq 0 ]; then
  echo "Visual Studio Code install complete.";
else
  echo "Visual Studio Code install failed.";
  exit 1;
fi;

echo "Installing git...";
apt-get install -y git;

if [ $? -eq 0 ]; then
  echo "git install complete.";
else
  echo "git install failed.";
  exit 1;
fi;

echo "Installing software-properties-common...";
apt-get install -y software-properties-common;

if [ $? -eq 0 ]; then
  echo "software-properties-common install complete.";
else
  echo "software-properties-common install failed.";
  exit 1;
fi;

echo "Installing synaptic...";
apt-get install -y synaptic;

if [ $? -eq 0 ]; then
  echo "synaptic install complete.";
else
  echo "synaptic install failed.";
  exit 1;
fi;

echo "Installing gimp gnome-terminal file-roller gedit unity-tweak-tool software-center vlc browser-plugin-vlc openshot...";
apt-get install -y gimp;

if [ $? -eq 0 ]; then
  echo "gimp install complete.";
else
  echo "gimp install failed.";
  exit 1;
fi;

echo "Installing steam...";
wget http://media.steampowered.com/client/installer/steam.deb
apt-get install gdebi-core
gdebi steam.deb

if [ $? -eq 0 ]; then
  echo "steam install complete.";
else
  echo "steam install failed.";
  exit 1;
fi;

echo "Installing any dependencies that may have been missed...";
apt-get install -y -f;

if [ $? -eq 0 ]; then
  echo "Missed dependency install complete.";
else
  echo "Missed dependency install failed.";
  exit 1;
fi;

echo "

Installation complete!

You can start code at any time by calling \"${code_executable_name}\" within a terminal.

A shortcut should also now be available in your desktop menus (depending on your distribution).

";

