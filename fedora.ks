#version=DEVEL
zerombr
ignoredisk --only-use=sda
#autopart --type=lvm

# Partition clearing information
clearpart --all --initlabel
part /boot --fstype ext4 --size=250
part swap --size=1024
part pv.01 --size=1 --grow
volgroup vg_root pv.01
logvol / --vgname vg_root --name root --fstype=ext4 --size=10240
logvol /tmp --vgname vg_root --name tmp --size=500 --fsoptions="nodev,nosuid,noexec"
logvol /var --vgname vg_root --name var --size=1024
logvol /var/log --vgname vg_root --name log --size=1024
logvol /var/log/audit --vgname vg_root --name audit --size=1024
logvol /home --vgname vg_root --name home --size=1024 --grow --fsoptions="nodev"
bootloader --location=mbr --driveorder=vda --append="selinux=1 audit=1"
reboot

# Use text or graphical install #graphical
text

# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'

# System language
lang en_US.UTF-8

# Use a network install
# url --url="http://mirror.math.princeton.edu/pub/fedora/linux/releases/test/30_Beta/Workstation/x86_64/os/"
url --url="http://mirror.math.princeton.edu/pub/fedora/linux/releases/29/Workstation/x86_64/os/"

# Network information
network  --hostname=localhost.localdomain --onboot yes --device eth0 --bootproto dhcp --ipv6 auto

# Root password
rootpw --iscrypted $6$wS5RvJtjyRSJXlCB$zFwYwXHCa1JM9pSDXq0SFZnAvvu7nlJbzrQ7mRbfbzr/h.wP5sAn4cX.kN4C/RkdMf9lhr6cttYJqHrF/sScc/
user --groups=wheel --name=lnxdork --password=$6$mLo33pzMPMUY.gbp$ko0JUNM0azdbrdotyfZ4QdkoZPxwMXtyOjsDdKpRXfV3mSu9csXjXhIDTNyPi9Gj/3kYx3cnkpfQtqEFIolGn/ --iscrypted --gecos="lnxdork"

# X Window System configuration information
xconfig  --startxonboot

# Run the Setup Agent on first boot
# firstboot --enable

# System services
services --enabled="chronyd","sshd"

# System timezone
timezone America/New_York --isUtc

firewall --enabled --ssh
authconfig --enableshadow --passalgo=sha512
selinux --enforcing

%packages --ignoremissing
@^minimal-environment
%end

%addon com_redhat_kdump --disable --reserve-mb='128'
%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end

%post
dnf groupinstall "base-x" -y
dnf install -y git curl scrot neovim feh conky postfix rsyslog
dnf install i3lock i3status dmenu i3 powerline xfce4-terminal bash-completion -y

curl -sSL https://raw.githubusercontent.com/lnxdork/machine/master/20-intel.conf > /etc/X11/xorg.conf.d/20-intel.conf
curl -sSL https://raw.githubusercontent.com/lnxdork/machine/master/xorg.conf > /etc/X11/xorg.conf

echo "Authorized use only. All activity may be monitored and reported." > /etc/motd
echo "Authorized use only. All activity may be monitored and reported." > /etc/issue
echo "Authorized use only. All activity may be monitored and reported." > /etc/issue.net
sed -i 's/^PASS_MAX_DAYS.*$/PASS_MAX_DAYS 90/' /etc/login.defs
sed -i 's/^PASS_MIN_DAYS.*$/PASS_MIN_DAYS 7/' /etc/login.defs
sed -i 's/^PASS_WARN_AGE.*$/PASS_WARN_AGE 7/' /etc/login.defs
echo "Unauthorized access is prohibited." > /etc/ssh/sshd_banner
echo "Banner /etc/ssh/sshd_banner" >> /etc/ssh/sshd_config

dnf -y upgrade

%end
