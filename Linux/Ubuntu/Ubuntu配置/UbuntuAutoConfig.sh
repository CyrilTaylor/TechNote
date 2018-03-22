#!/bin/bash

# set prompt
if [ -f ~/.bashrc ]; then
    cat ~/.bashrc | grep -s "# Custom Prompt with Cyril Style"
    if [ 0 != $? ]; then
        
        echo "" >> ~/.bashrc
        echo "# Custom Prompt with Cyril Style" >> ~/.bashrc
        echo "if [ \`id -u\` -eq 0 ]; then" >> ~/.bashrc
        echo '    PS1="\[\033[0;31m\]┌┼─ \[\033[0;36;41m\]\u\[\033[0;41m\]@\H\[\033[0;31m\] ─┤├─ \[\033[0m\]\t \d\[\033[0;31m\] ─┤├─ \[\033[0;36m\]\w\[\033[0;31m\] ─┤ \n│\[\033[0;35m\] Suspend Process:\j Command Counts: \#\n\[\033[0;31m\]└┼─\[\033[0;32;41m\]\\$\[\033[0;31m\]─┤▶\[\033[0m\]"' >> ~/.bashrc
        echo "else" >> ~/.bashrc
        echo '    PS1="\[\033[0;33m\]┌┼─ \[\033[0;36m\]\u\[\033[0m\]@\H\[\033[0m\033[0;33m\] ─┤├─ \[\033[0m\]\t \d\[\033[0;33m\] ─┤├─ \[\033[0;36m\]\w\[\033[0;33m\] ─┤ \n│\[\033[0;37m\] Suspend Process:\j Command Counts: \#\n\[\033[0;33m\]└┼─\[\033[0m\033[0;32m\]\$\[\033[0m\033[0;33m\]─┤▶\[\033[0m\]"' >> ~/.bashrc
        echo "fi" >> ~/.bashrc
        echo 'PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"' >> ~/.bashrc
        echo "" >> ~/.bashrc
    fi
fi

sudo apt update
sudo apt full-upgrade
# sudo apt-get install software-properties-common
# sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt install build-essential bc g++-multilib libc6-dev lib32ncurses5 lib32ncurses5-dev lib32z1 unzip flex zip flex bison gperf curl zlib1g zlib1g-dev tofrodos libxml2-utils policycoreutils tree phablet-tools git openjdk-8-jdk repo
sudo apt remove android-tools-adb android-tools-fastboot

# git configuration
git config --global user.email "CyrilTaylor@foxmail.com"
git config --global user.name "Cyril Taylor"
git config --global core.quotepath false
#git config --global gui.encoding utf-8
#git config --global i18n.commitencoding utf-8

# setup for android build environment
# sudo apt install openjdk-8-jdk
sudo update-alternatives --config java
sudo update-alternatives --config javac

# if [ ! -d ~/bin ]; then
#     mkdir ~/bin
# fi
# curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
# chmod a+x ~/bin/repo

