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
        echo '    PS1="\[\033[0;31m\]\u\[\033[0;31m\]@\H\[\033[0;35m\]-\[\033[0;32m\]\t \d\[\033[0;35m\]-\[\033[0;31m\]\w\n\[\033[0;35m\]Suspend Process:\j Command Counts: \#\n\[\033[0;31m\]\\$\[\033[0;35m\]->\[\033[0m\]"' >> ~/.bashrc
        echo "else" >> ~/.bashrc
        echo '    PS1="\[\033[0;33m\]\u\[\033[0;33m\]@\H\[\033[0;36m\]-\[\033[0;32m\]\t \d\[\033[0;36m\]-\[\033[0;33m\]\w\n\[\033[0;37m\]Suspend Process:\j Command Counts: \#\n\[\033[0;32m\]\$\[\033[0;33m\]->\[\033[0m\]"' >> ~/.bashrc
        echo "fi" >> ~/.bashrc
        echo 'PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"' >> ~/.bashrc
        echo "" >> ~/.bashrc
    fi
fi

sudo apt update
sudo apt full-upgrade
# sudo apt-get install software-properties-common
# sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt install build-essential bc g++-multilib libc6-dev lib32ncurses5 lib32ncurses5-dev lib32z1 unzip flex zip flex bison gperf curl zlib1g zlib1g-dev tofrodos libxml2-utils policycoreutils tree phablet-tools git openjdk-8-jdk repo libncurses5-dev libssl-dev openssl zlibc minizip libidn11-dev libidn11
if [ 'WSL' == ${DISTRO} ]; then
    sudo apt remove android-tools-adb android-tools-fastboot
fi

if [ 'Ubuntu' == ${DISTRO} ]; then
    sudo apt install wine-dev
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
