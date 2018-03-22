# 1 Ubuntu配置

<!-- TOC -->

- [1 Ubuntu配置](#1-ubuntu配置)
    - [1.1 终端命令符](#11-终端命令符)
    - [1.2 git配置](#12-git配置)
        - [1.2.1 账号配置](#121-账号配置)
        - [1.2.2 git乱码问题](#122-git乱码问题)
        - [1.2.2 设置https的git库账号密码缓存](#122-设置https的git库账号密码缓存)
    - [1.3 Android工具安装](#13-android工具安装)

<!-- /TOC -->

## 1.1 终端命令符

普通用户模式：
> PS1="\[\033[0;33m\]┌┼─ \[\033[0;36m\]\u\[\033[0m\]@\H\[\033[0m\033[0;33m\] ─┤├─ \[\033[0m\]\t \d\[\033[0;33m\] ─┤├─ \[\033[0;36m\]\w\[\033[0;33m\] ─┤ \n│\[\033[0;37m\] Suspend Process:\j Command Counts: \#\n\[\033[0;33m\]└┼─\[\033[0m\033[0;32m\]\$\[\033[0m\033[0;33m\]─┤▶\[\033[0m\]"
预览：

![普通用户终端显示](material/user.png)

Root用户模式：
> PS1="\[\033[0;31m\]┌┼─ \[\033[0;36;41m\]\u\[\033[0;41m\]@\H\[\033[0;31m\] ─┤├─ \[\033[0m\]\t \d\[\033[0;31m\] ─┤├─ \[\033[0;36m\]\w\[\033[0;31m\] ─┤ \n│\[\033[0;35m\] Suspend Process:\j Command Counts: \#\n\[\033[0;31m\]└┼─\[\033[0;32;41m\]\\$\[\033[0;31m\]─┤▶\[\033[0m\]"

预览：

![Root用户终端显示](material/Root.png)

``` shell
if [ `id -u` -eq 0 ]; then
    PS1="\[\033[0;31m\]┌┼─ \[\033[0;36;41m\]\u\[\033[0;41m\]@\H\[\033[0;31m\] ─┤├─ \[\033[0m\]\t \d\[\033[0;31m\] ─┤├─ \[\033[0;36m\]\w\[\033[0;31m\] ─┤ \n│\[\033[0;35m\] Suspend Process:\j Command Counts: \#\n\[\033[0;31m\]└┼─\[\033[0;32;41m\]\\$\[\033[0;31m\]─┤▶\[\033[0m\]"
else
    PS1="\[\033[0;33m\]┌┼─ \[\033[0;36m\]\u\[\033[0m\]@\H\[\033[0m\033[0;33m\] ─┤├─ \[\033[0m\]\t \d\[\033[0;33m\] ─┤├─ \[\033[0;36m\]\w\[\033[0;33m\] ─┤ \n│\[\033[0;37m\] Suspend Process:\j Command Counts: \#\n\[\033[0;33m\]└┼─\[\033[0m\033[0;32m\]\$\[\033[0m\033[0;33m\]─┤▶\[\033[0m\]"
fi
```

设置终端标题
> PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"

提供编译程序必须软件包的列表信息
> sudo apt-get install build-essential

## 1.2 git配置

### 1.2.1 账号配置

    > git config --global user.email "CyrilTaylor@foxmail.com"
    > git config --global user.name "Cyril Taylor"

### 1.2.2 git乱码问题

   _[在git中出现中文乱码的解决方案](http://blog.csdn.net/tyro_java/article/details/53439537)_

- 在cygwin中，使用git add添加要提交的文件的时候，如果文件名是中文，会显示形如 274\232\350\256\256\346\200\273\347\273\223.png 的乱码。

    解决方案：在bash提示符下输入：
    > git config --global core.quotepath false

    core.quotepath设为false的话，就不会对0x80以上的字符进行quote。中文显示正常。

- 在MsysGit中，使用git log显示提交的中文log乱码。
    解决方案：
    设置git gui的界面编码
    > git config --global gui.encoding utf-8

- 设置 commit log 提交时使用 utf-8 编码，可避免服务器上乱码，同时与linux上的提交保持一致！
    >git config --global i18n.commitencoding utf-8

- 使得在 $ git log 时将 utf-8 编码转换成 gbk 编码，解决Msys bash中git log 乱码。
    >git config --global i18n.logoutputencoding gbk

- 使得 git log 可以正常显示中文（配合i18n.logoutputencoding = gbk)，在 /etc/profile 中添加：export LESSCHARSET=utf-8

### 1.2.2 设置https的git库账号密码缓存

```shell
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
```

## 1.3 Android工具安装

```shell
    sudo apt install build-essential bc g++-multilib libc6-dev lib32ncurses5 lib32ncurses5-dev lib32z1 unzip flex zip flex bison gperf curl zlib1g zlib1g-dev tofrodos libxml2-utils policycoreutils tree phablet-tools git openjdk-8-jdk repo
    sudo apt remove android-tools-adb android-tools-fastboot
```

[test](E:\TechNote\C_C++\C C++常用关键字解析\C C++常用关键字解析.md)
