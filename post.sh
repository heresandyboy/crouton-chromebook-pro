#!/bin/sh

echo "POST INSTALL SCRIPT

";

printf "Install now? (y/n): "
read install_now;
if [ $install_now != "y" ]; then
  echo "No problem!  Please just run me again whenever you wish to install Visual Studio Code.";
  exit;
fi;

#cd ~/Downloads;

echo "Entering chroot to install Visual Studio Code, you may need to enter the chronos password if you've previously changed it, and/or the password you entered above for the chroot!";
sudo sh /media/removable/SD\ Card/bin/enter-chroot -n linux sudo -S sh -c "$( curl -s https://raw.githubusercontent.com/heresandyboy/crouton-chromebook-pro/master/apt.sh )";
if [ $? -eq 0 ]; then
  echo "APT install script complete.";
else
  echo "APT install script failed.";
  exit 1;
fi;

echo "Removing any existing 'code' alias from ~/.bashrc...";
if [ -e ~/.bashrc ]; then sudo sed -i.bak '/alias code=/d' ~/.bashrc; fi;
echo "Done!"

CODE_EXECUTABLE_NAME="code";

echo "Removing existing 'code' aliases...";
sudo sed -i '/^alias code/d' ~/.bashrc;
echo "Done!";

echo "Aliasing 'code'..."
sudo echo "alias code=\"sudo sh '/media/removable/SD Card/bin/startxiwi' -n linux ${CODE_EXECUTABLE_NAME}\"" >> ~/.bashrc;
echo "Done!"

echo "Aliasing 'linux'..."
sudo echo "alias linux=\"sudo sh '/media/removable/SD Card/bin/startunity -n linux\"" >> ~/.bashrc;
echo "Done!"

echo "Reloading .bashrc...";
. ~/.bashrc;
echo "Done!";

echo "

To run Visual Studio Code from now on perform the following steps:

1) Press Ctrl+Alt+T on your keyboard to open a crosh shell.
2) Type (without the quotes!) \"shell\" and press return.
3) Type (without the quotes!) \"code\" and press return.

";

