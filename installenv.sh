#!/bin/bash
set -x
set -v
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

source local/bin/my-utils.sh

echo "***********************"
echo "Installing apt packages"
sudo add-apt-repository --yes ppa:jonathonf/vim
sudo add-apt-repository --yes ppa:git-core/ppa
sudo apt-get update
sudo apt install --yes build-essential libncurses6 gdebi tree curl \
                    python3-pip ripgrep xsel xclip fonts-powerline ncdu \
                    universal-ctags fd-find ranger cowsay fortune git vim-gtk3

echo "*************************************"
echo "Installing Powerline (update .bashrc)"
pip3 install --user psutil
pip3 install --user powerline-status
PWRLN_REPO_ROOT="$(pip3 show powerline-status | awk '{if ($1=="Location:") print $2}')"
PWRLN_PATH="$PWRLN_REPO_ROOT"/powerline
cp -f config_files/tmux-default.json "$PWRLN_PATH"/config_files/themes/tmux/default.json

printf "\npowerline-daemon -q\nPOWERLINE_BASH_CONTINUATION=1\n" >> ~/.bashrc
printf "POWERLINE_BASH_SELECT=1\n" >> ~/.bashrc
printf "source %s/powerline/bindings/bash/powerline.sh\n" "$PWRLN_REPO_ROOT" >> ~/.bashrc

echo "******************************"
echo "Installing FZF and Vim Plugins"
cp config_files/vimrc ~/.vimrc
vim -c "qa"
vim -c "PlugInstall" -c "qa"

echo "********************************"
echo "Installing bat (cat replacement)"
installdeb $(ghrelease sharkdp bat "bat_.*_amd64.deb")

echo "****************"
echo "Installing delta"
installdeb $(ghrelease dandavison delta "git-delta_.*_amd64.deb")

echo "*********************"
echo "Installing bat-extras"
git clone https://github.com/eth-p/bat-extras.git
cd bat-extras
./build.sh --install --prefix=~/.local
cd ..

echo "****************"
echo "Updating .bashrc"
printf "\nexport EDITOR=\"vim\"\n"
printf "\nsource ~/.local/bin/forgit.sh\n" >> ~/.bashrc
printf "source ~/.local/bin/cd_git_root.sh\n" >> ~/.bashrc
printf "source ~/.local/bin/fzf_git_functions.sh\n" >> ~/.bashrc
printf "source ~/.local/bin/fzf_git_keybindings.sh\n" >> ~/.bashrc
printf "source ~/.local/bin/my-utils.sh\n" >> ~/.bashrc
printf "source ~/.local/bin/fzf-bash-completion.sh\n" >> ~/.bashrc
printf "bind -x '\"\\\\t\": fzf_bash_completion'\n" >> ~/.bashrc
printf "\nexport FORGIT_COPY_CMD='xsel -b'\n" >> ~/.bashrc

printf "export FZF_DEFAULT_COMMAND='fdfind --type file --follow --color=always'\n" >> ~/.bashrc
printf "export FZF_DEFAULT_OPTS='--ansi'\n" >> ~/.bashrc
printf "export FZF_CTRL_T_COMMAND="'"$FZF_DEFAULT_COMMAND"'"\n" >> ~/.bashrc
printf "export FZF_CTRL_T_OPTS=\"--height 40% --layout reverse --preview 'bat --style=numbers --color=always --line-range :500 {}'\"\n" >> ~/.bashrc
printf "export FZF_ALT_C_OPTS=\"--preview 'tree -C {} | head -200'\"\n" >> ~/.bashrc

echo "********************"
echo "Copying Config Files"
mkdir -p ~/.local/bin
curl -o ~/.local/bin/fzf-bash-completion.sh -L 'https://raw.githubusercontent.com/lincheney/fzf-tab-completion/master/bash/fzf-bash-completion.sh'
curl -o ~/.local/bin/forgit.sh -L 'https://git.io/forgit'
cp ./local/bin/* ~/.local/bin
cp ./local/share/konsole/* ~/.local/share/konsole
cp config_files/tmux.conf ~/.tmux.conf
cp config_files/bash_aliases ~/.bash_aliases

echo "************************"
echo "Adding git configuration"
git config --global core.editor "vim"
git config --global core.pager "delta"
git config --global alias.addm 'add -u'
git config --global alias.br 'branch'
git config --global alias.ba 'branch -av'
git config --global alias.bd 'branch -d'
git config --global alias.bD 'branch -D'
git config --global alias.ci 'commit'
git config --global alias.cia 'commit --amend'
git config --global alias.f 'fetch -p'
git config --global alias.m 'merge'
git config --global alias.ma 'merge --abort'
git config --global alias.mc 'merge --continue'
git config --global alias.co 'checkout'
git config --global alias.cob 'checkout -b'
git config --global alias.lg 'log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
git config --global alias.la '"!git config -l | sed -r -n '\''s/alias.//p'\''"'
git config --global alias.p 'push'
git config --global alias.po 'push origin'
git config --global alias.puo 'push -u origin'
git config --global alias.re 'reset'
git config --global alias.rh 'reset HEAD'
git config --global alias.reh 'reset --hard'
git config --global alias.rem 'reset --mixed'
git config --global alias.res 'reset --soft'
git config --global alias.rehh 'reset --hard HEAD'
git config --global alias.remh 'reset --mixed HEAD'
git config --global alias.resh 'reset --soft HEAD'
git config --global alias.s 'status'
git config --global delta.line-numbers "true"
git config --global delta.side-by-side "true"
git config --global delta.navigate "true"
git config --global delta.keep-plus-minus-markers "true"
git config --global delta.inspect-raw-lines "true"
git config --global diff.tool "vimdiff"
git config --global diff.colorMoved "default"
git config --global difftool.prompt "false"
git config --global interactive.diffFilter "delta --color-only"
