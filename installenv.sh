#!/bin/bash

echo ***********************
echo Installing apt packages
sudo apt install automake autoconf build-essential pkg-config libevent-dev libncurses5-dev links git gdebi tree curl silversearcher-ag tmux python3-pip ranger

echo ********************
echo Installing Powerline
# https://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
echo "Install Powerline local or system-wide? (system-wide has problems)"
select opt in "local" "system"; do
  case $opt in
    local )
      mkdir -p ~/.local/share/fonts/ && mv PowerlineSymbols.otf ~/.local/share/fonts/
      fc-cache -vf ~/.local/share/fonts
      mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
      pip3 install --user psutil
      pip3 install --user powerline-status
      break
      ;;
    system )
      sudo mv PowerlineSymbols.otf /usr/share/fonts/
      sudo fc-cache -vf
      sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
      sudo pip3 install psutil
      sudo pip3 install powerline-status
      break
      ;;
  esac
done

PWRLN_REPO_ROOT="$(pip3 show powerline-status | awk '{if ($1=="Location:") print $2}')"
PWRLN_PATH="$PWRLN_REPO_ROOT"/powerline

cp -f tmux-default.json "$PWRLN_PATH"/config_files/themes/tmux/default.json

printf "\npowerline-daemon -q\nPOWERLINE_BASH_CONTINUATION=1\n" >> ~/.bashrc
printf "POWERLINE_BASH_SELECT=1\n" >> ~/.bashrc
printf ". %s/powerline/bindings/bash/powerline.sh\n" "$PWRLN_REPO_ROOT" >> ~/.bashrc

echo **************************
echo Installing Universal Ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
sudo make install
cd ..

echo *******************************
echo Installing FZF and Vim Pluggins
cp .vimrc ~/.vimrc
vim -c "PlugInstall" -c "qa"

echo ***************
echo Installing Tmux
cp .tmux.conf ~/.tmux.conf

echo *********************
echo Installing PathPicker
git clone https://github.com/facebook/PathPicker.git
cd debian
./package.sh
sudo gdebi ../fpp_0.7.2_noarch.deb

