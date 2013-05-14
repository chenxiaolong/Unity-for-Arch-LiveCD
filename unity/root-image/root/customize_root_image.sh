#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /bin/zsh root
cp -aT /etc/skel/ /root/

useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/zsh arch

chmod 750 /etc/sudoers.d
chmod 440 /etc/sudoers.d/g_wheel
chown -R 0:0 /etc/sudoers.d

sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist

# Enable Unity-for-Arch repositories by default
cat >> /etc/pacman.conf << EOF

[Unity-for-Arch]
SigLevel = Optional TrustAll
Server = http://dl.dropbox.com/u/486665/Repos/Unity-for-Arch/\$arch

[Unity-for-Arch-Extra]
SigLevel = Optional TrustAll
Server = http://dl.dropbox.com/u/486665/Repos/Unity-for-Arch-Extra/\$arch

[Unity-for-Arch-LiveCD]
SigLevel = Optional TrustAll
Server = http://dl.dropbox.com/u/486665/Repos/Unity-for-Arch-LiveCD/\$arch
EOF

#sed 's#\(^ExecStart=-/sbin/agetty\)#\1 --autologin root#;
#     s#\(^Alias=getty.target.wants/\).\+#\1autologin@tty1.service#' \
#     /usr/lib/systemd/system/getty@.service > /etc/systemd/system/autologin@.service

#systemctl disable getty@tty1.service
#systemctl enable multi-user.target pacman-init.service autologin@.service dhcpcd.service

systemctl enable graphical.target pacman-init.service NetworkManager.service lightdm.service
