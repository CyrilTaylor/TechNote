#!/usr/bin/env bash

getKernelVersionName()
{
    kvName=(`uname -v`)
    if [[ ${kvName[0]} =~ "Ubuntu" ]]; then
        DISTRO='Ubuntu'
    elif [[ ${kvName[0]} =~ "Microsoft" ]]; then
        DISTRO='WSL'
    else
        DISTRO='unknow'
    fi
}
getKernelVersionName

# set prompt
if [ -f ~/.bashrc ]; then
    cat ~/.bashrc | grep -s "# Custom Prompt with Cyril Style"
    if [ 0 != $? ]; then
        echo "" >> ~/.bashrc
        echo "# Custom Prompt with Cyril Style" >> ~/.bashrc
        echo "if [ \`id -u\` -eq 0 ]; then" >> ~/.bashrc
        echo '    PS1="\[\e[5;31m\]\u\[\e[5;31m\]@\H\[\e[0;35m\] - \[\e[0;32m\]\t \d\[\e[0;35m\] - \[\e[1;31m\]\w\n\[\e[0;35m\]Suspend Process:\j Command Counts: \#\n\[\e[0;31m\]\\$\[\e[0;35m\]->\[\e[0m\]"' >> ~/.bashrc
        echo "elif [ \`id -u\` -le 1000 ]; then" >> ~/.bashrc
        echo '    PS1="\[\e[0;33m\]\u\[\e[0;33m\]@\H\[\e[0;36m\] - \[\e[0;32m\]\t \d\[\e[0;36m\] - \[\e[0;33m\]\w\n\[\e[0;37m\]Suspend Process:\j Command Counts: \#\n\[\e[0;32m\]\$\[\e[0;33m\]->\[\e[0m\]"' >> ~/.bashrc
        echo "else" >> ~/.bashrc
        echo '    PS1="\[\e[0;32m\]\u\[\e[0;32m\]@\H\[\e[0;36m\] - \[\e[0;32m\]\t \d\[\e[0;36m\] - \[\e[0;32m\]\w\n\[\e[0;37m\]Suspend Process:\j Command Counts: \#\n\[\e[0;32m\]\$\[\e[0;33m\]->\[\e[0m\]"' >> ~/.bashrc
        echo "fi" >> ~/.bashrc
        echo 'PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"' >> ~/.bashrc
        echo "" >> ~/.bashrc
    fi
fi

sudo apt update
sudo apt full-upgrade
# sudo apt-get install software-properties-common
# sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt install -y build-essential bc g++-multilib libc6-dev lib32ncurses5 lib32ncurses5-dev lib32z1 unzip flex vim zip flex bison gperf curl zlib1g zlib1g-dev tofrodos libxml2-utils policycoreutils tree repo git openjdk-8-jdk repo libncurses5-dev libssl-dev openssl zlibc minizip libidn11-dev libidn11
if [ 'WSL' == ${DISTRO} ]; then
    sudo apt remove -y android-tools-adb android-tools-fastboot
fi

if [ 'Ubuntu' == ${DISTRO} ]; then
    #VSCode
    wget https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable -O ~/vscode_latest_stable.deb
    sudo dpkg -i ~/vscode_latest_stable.deb
    rm -rf ~/vscode_latest_stable.deb
    #Chrome
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/google-chrome-stable_current_amd64.deb
    sudo dpkg -i ~/google-chrome-stable_current_amd64.deb
    rm -rf ~/google-chrome-stable_current_amd64.deb
    sudo apt install -y wine-dev
fi

# git configuration
git config --global user.email "CyrilTaylor@foxmail.com"
git config --global user.name "Cyril Taylor"
git config --global core.quotepath false
# Password caching, The credential helper only works when you clone an HTTPS repository URL
# Set git to use the credential memory cache
git config --global credential.helper cache
# Set the cache to timeout after 1 hour (setting is in seconds)
# git config --global credential.helper 'cache --timeout=3600'

# git config --global gui.encoding utf-8
# git config --global i18n.commitencoding utf-8

# setup for android build environment
sudo update-alternatives --config java
sudo update-alternatives --config javac
