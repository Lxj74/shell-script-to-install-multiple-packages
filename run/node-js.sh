#!/bin/bash

# Install
# wget --no-cache -O - https://raw.githubusercontent.com/natancabral/ubuntu-bash-script-config-lamp/main/run/node-js.sh | bash

# Color Reset
Color_Off='\033[0m'       # Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

remove_nodejs() {

  nodeVersion=`node -v`
  echo -e "\n ${Cyan} Current Node version is${Color_Off} ${Green}${nodeVersion}${Color_Off}"

  echo -e "\n ${Cyan} Removing Node ... ${Color_Off}"
  # snap packages
  sudo snap remove node npm
  sudo apt remove node npm -y
  # sudo apt purge --auto-remove nodejs npm --force-yes
  
  echo -e "\n ${Cyan} Removing Nodejs --force-yes... ${Color_Off}"
  sudo snap remove node --allow --yes
  sudo apt remove node --allow --yes
  sudo snap remove nodejs --allow --yes
  sudo apt remove nodejs --allow --yes
  sudo snap remove npm --allow --yes
  sudo apt remove npm --allow --yes

  echo -e "\n ${Cyan} Removing Node-Legacy... ${Color_Off}"
  sudo apt remove -y node npm nodejs nodered nodejs-legacy --allow --yes

  echo -e "\n ${Cyan} Force AutoRemove... ${Color_Off}"
  sudo apt autoremove --allow --yes

  echo -e "\n ${Cyan} Removing source ... ${Color_Off}"
  # remove node source from /etc/apt/sources.list.d
  sudo rm -rf /etc/apt/sources.list.d/nodesource.list
  sudo rm -rf /etc/apt/sources.list.d/nodesource.list.save

  echo -e "\n ${Cyan} NVM has been installed. run 'source ~/.bashrc' to use it right away. \n  Use 'nvm install --lts' to install and use LTS version of Node.. ${Color_Off}"
}

install_nvm() {

  echo -e "\n ${Cyan} Installing NVM (Node Version Manager, manage multiple versions nodejs).. ${Color_Off}"
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.35.0/install.sh | bash
  sudo apt install npm -y

  # make sure the source lines added to `~/.bashrc` are loaded in current terminal
  # otherwise the rest of the script will give a 'nvm: command not found' error
  # source ${HOME}/.bashrc

  # confirm nvm install
  # echo -e "\n\n ----- NVM $(nvm --version) is installed .. "

  # install the node versions
  # nvm install node # install Latest
  #nvm install --lts # install LTS version

  # select the version you want to use
  # nvm use node # use Latest
  # nvm use --lts # use LTS version

  # installing a version for the first time also uses and sets it as default

  # exit successfully
  #exit 0
}

install_nodejs() {

  # install latest
  # echo -e "
  # ${Color_Cyan}Downloading latest Node.js ARM-version.. ${Color_Off}"
  # cd /tmp/
  # wget https://node-arm.herokuapp.com/node_latest_armhf.deb
  # echo -e "${Color_Cyan}Installing Node.js .. this will take a while .. ${Color_Off}"
  # sudo dpkg -i node_latest_armhf.deb
  # cleanup
  # echo -e "
  # ${Color_Cyan}Cleaning up .. ${Color_Off}"
  # rm -rf /tmp/node_latest_armhf.deb
  # sudo apt autoremove -y

  # First, you'll need NodeJS and NPM:
  echo -e "${Cyan}Run bash setup Node.js 12.x .. ${Color_Off}"
  sudo apt install curl
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

  echo -e "${Cyan}Installing Node, Node.js, Node-red .. this will take a while .. ${Color_Off}"
  # sudo snap install node --classic --channel=9/stable -y
  sudo apt install node -y 
  sudo apt install nodejs -y 
  sudo apt install nodered -y 
  # sudo snap install node --classic --channel=edge # last version

  # Passo 3. Mais tarde, se você precisar atualizar o programa, use:
  sudo snap refresh node
  sudo npm i npm@latest -g
  sudo apt dist-upgrade node -y
  sudo apt dist-upgrade nodejs -y

  # Passo 4. Depois, se for necessário, desinstale o programa, usando o comando abaixo;
  # sudo snap remove node
}

remove_nodejs
install_nvm
install_nodejs

# confirm version
nodeVersion=`node -v`
echo -e "\n ${Green} Successfully installed. Node.js version is: ${nodeVersion} ${Color_Off}"

# update
sudo apt update

# TODO
# CHECK IF NODE IS INSTALLED BEFORE TRYING TO REMOVE IT
# Check if the bash profile is called `.bashrc` (Ubuntu) or `.bash_profile` (macOS)

# FONT
# https://github.com/aamnah/bash-scripts/blob/master/install/nvm.sh
