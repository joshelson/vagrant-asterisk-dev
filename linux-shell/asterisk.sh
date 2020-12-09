#!/bin/bash

echo "Running core linux setup"

# Disable selinux
setenforce 0
sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/selinux/config

# Install base/common packages
if ! yum list installed git-lfs 2> /dev/null; then
  curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
fi
dnf install -y epel-release
dnf install dnf-plugins-core
dnf update -y
dnf --enablerepo=powertools install -y telnet git git-lfs ngrep tcpdump \
    vim nmap fail2ban wget make indent valgrind libedit-devel cmake \
    mlocate rsync screen chrony bzip2 iperf3 man perl perl-Net-SSLeay bc \
    sysstat iftop socat pigz pwgen net-tools hdparm lksctp-tools lksctp-tools-devel \
    whois crontabs mtr golang htop curl-devel kernel-devel gcc make unzip dkms \
    gcc-c++ binutils patch gdb autoconf automake libtool xmlstarlet python3-pip \
    ncurses-devel svn libuuid-devel libxml2-devel sqlite-devel jansson-devel \
    binutils-devel libsrtp-devel lua lua-devel openssl-devel python3 \
    python3-devel python3-yaml python3-twisted libpcap-devel \
    opus opus-devel unixODBC unixODBC-devel 

# CentOS 8 Not Found:
# libsrtp-devel lua-devel libpcap-devel unixodbc-devel libedit-devel

pip3 install twisted

# Setup global bash profile additions
cat <<EEEEOF >/etc/profile.d/options.sh

alias vi=vim
alias ls='ls --color=auto -al'
alias ng='ngrep -qt -W byline -d eth0 -v "^OPTIONS|CSeq: 102 OPTIONS|^SUBSCRIBE|CSeq: [0-9]* SUBSCRIBE" port 5060'

#change the prompt
PS1='[${debian_chroot:+($debian_chroot)}\[\033[00;36m\]\u\[\033[00m\]@\h:\w\$]'

TZ='America/Denver'; export TZ
PATH=$PATH:/usr/local/bin
EEEEOF

cat <<EOF >/etc/motd

                             _      _        _____              
   /\        _              (_)    | |      (____ \             
  /  \   ___| |_  ____  ____ _  ___| |  _    _   \ \ ____ _   _ 
 / /\ \ /___)  _)/ _  )/ ___) |/___) | / )  | |   | / _  ) | | |
| |__| |___ | |_( (/ /| |   | |___ | |< (   | |__/ ( (/ / \ V / 
|______(___/ \___)____)_|   |_(___/|_| \_)  |_____/ \____) \_/  
                                                                

EOF

# Set timezone
timedatectl set-timezone America/Denver

# Stop/Disable firewalld if it exists
if systemctl status firewalld > /dev/null; then
  echo "stopping/disabling firewalld"
  systemctl disable firewalld
  systemctl stop firewalld
fi

echo "Finished core linux setup"
