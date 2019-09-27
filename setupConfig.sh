#! /bin/bash
####################################
## Kernelpanic environment config ##
## Setting up:			  ##
##  	- Bash prompt (PS1)       ##
##      - Install some tools      ##
##  	- vimrc config	          ##
##  	- i3, i3lock & i3blocks   ##
##  	- rofi	                  ##
##  	- Adding fonts            ##
##  	- Setting up SLiM         ##
##  	- Wallpaper               ##
##  	- Install dark GTK theme  ##
##  	- Disable terminal beep   ##
##  	- Setting i3 default      ##
####################################

# Colors
RED='\033[0;31m'
ORANGE='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


# Configure bash prompt
BASHRC=$(cat ~/.bashrc)
if [[ $BASHRC == *"\$(tput sgr0)\]\[\033[38;5;166m\]"* ]]; then
  printf "${GREEN}Bash prompt already correct\n${NC}"
else
  printf "${GREEN}Modifying bash prompt\n${NC}"
  echo "export PS1=\"\[\033[38;5;160m\] \[\$(tput sgr0)\]\[\033[38;5;166m\]\\\\$\[\$(tput sgr0)\]\[\033[38;5;178m\]\w\[\$(tput sgr0)\]: \"" >> ~/.bashrc
fi

# Installing tools
printf "${GREEN}Installing tools\n${NC}"
sudo apt-get -y install git vim >> /dev/null


# Configure vimrc
printf "${GREEN}Overwriting vimrc with vimrc.conf\n${NC}"
cat Files/vimrc.conf > ~/.vimrc

############
##   I3   ##
## + more ##
############
# Install required packages
printf "${GREEN}Installing i3 i3blocks i3lock feh compton rofi scrot and thunar\n${NC}"
sudo apt-get -y install i3 i3blocks i3lock feh compton rofi thunar scrot >> /dev/null
sudo apt-get -y install slim

# Creating i3 config dir
printf "${GREEN}Creating i3 diretory\n${NC}"
mkdir -p ~/.config/i3

# Configure i3 
printf "${GREEN}Overwriting i3 config with i3.conf\n${NC}"
cp Files/i3.conf ~/.config/i3/config
printf "${GREEN}Overwriting i3 blocks config with i3blocks.conf\n${NC}"
cp Files/i3blocks.conf ~/.config/i3/
printf "${GREEN}Adding lockscreen script\n${NC}"
cp Files/lock.sh ~/.config/i3/
cp Files/lock-flat.png ~/.config/i3/
printf "${GREEN}Adding battery script\n${NC}"
cp Files/battery.conf ~/.config/i3/


# Configure rofi
printf "${GREEN}Overwriting rofi config with rofi.conf\n${NC}"
mkdir -p ~/.config/rofi
sudo cp Files/rofi.conf ~/.config/rofi/rofi.conf

# Adding fonts
printf "${GREEN}Adding fonts to .fonts\n${NC}"
mkdir -p ~/.fonts/
cp Files/FontAwesome-webfont.ttf ~/.fonts/
cp Files/FontAwesome.otf ~/.fonts/
cp Files/SFFont.rtf ~/.fonts/

# Configure login manager (slim)
printf "${GREEN}Configuring SLiM (login manager)\n${NC}"
mkdir -p /usr/share/slim/themes/kernelpanic
sudo cp Files/slim.conf /etc/slim.conf 
sudo cp Files/slim_background.jpg /usr/share/slim/themes/kernelpanic/background.jpg
sudo cp Files/slim_panel.png /usr/share/slim/themes/kernelpanic/panel.png
sudo cp Files/slim_kernelpanic.conf /usr/share/slim/themes/kernelpanic/slim.theme
sed -i "s/current_theme .*/current_theme kernelpanic/g" /etc/slim.conf

# Configuring wallpaper
printf "${GREEN}Copying wallpaper\n${NC}"
cp Files/slim_background.jpg ~/.wallpaper.png

# Installing GTK dark theme (globally)
printf "${GREEN}Copying GTK theme\n${NC}"
mkdir -p ~/.themes
sudo cp -R Files/GTK-dark-theme /usr/share/themes/dark-theme

# TODO: Configure GRUB?


############
## TWEAKS ##
############
# Disable bell sound
printf "${GREEN}Disabling the terminal bell\n${NC}"
if [ -f "/etc/inputrc" ]; then
    INPUTRC=$(cat /etc/inputrc)
    if [[ $INPUTRC == *"# set bell-style none"* ]]; then
        sudo echo "set bell-style none" >> /etc/inputrc
    fi
else
    sudo echo "set bell-style none" > /etc/inputrc
fi


# Making sure i3 start after login
printf "${GREEN}Set default WM to i3\n${NC}"
cp Files/xsession.conf ~/.xsession


printf "${GREEN}###### DONE ######\n${NC}"
printf "${GREEN}Some optional settings can be set in ~/.config/i3/config and i3blocks.conf\n${NC}"
printf "${GREEN}Also run the tweak tool to change the GTK theme in the GUI (didn't create the full auto way yet)\n${NC}"

