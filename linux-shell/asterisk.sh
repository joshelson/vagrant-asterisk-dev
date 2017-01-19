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
yum install -y epel-release
yum update -y
yum install -y telnet git git-lfs ngrep tcpdump vim nmap fail2ban wget make \
    mlocate rsync screen ntpdate bzip2 iperf yum-fastestmirror man perl \
    perl-Net-SSLeay bc sysstat iftop socat pigz ntp pwgen net-tools hdparm \
    whois crontabs mtr golang htop curl-devel kernel-devel gcc make unzip dkms \
    gcc-c++ binutils patch gdb autoconf automake libtool xmlstarlet python-pip \
    ncurses-devel svn libuuid-devel libxml2-devel sqlite-devel jansson-devel \
    binutils-devel libsrtp-devel lua lua-devel openssl-devel python-twisted-web \
    python-construct python-devel python-yaml python-twisted libpcap-devel \
    opus opus-devel unixODBC unixodbc-devel python-twisted-web

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
