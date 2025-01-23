# NetBSD cloud slave VM images

NetBSD images designed to be called as one-shot slaves (eg. for builders) in cloud environments.
These are configured to allow direct root access via serial console (need to send a single CRLF)
as well as ssh.

WARNING: DO NOT use them for critical services or in public networks without extra protections,
that would be an invitation for abuse!

## Using the images

* edit conf.sh to your needs
* call ./unpack to unpack the compressed and splitted image into runnable qcow
* call ./run-builder to start up the VM
* call ./ssh-builder to call into the already running VM

## How the images are generated

Since there's no practical fully automatic install, we need to do a somewhat
manual install from the ISO image and edit a bunch of configs.

* full installation from ISO image
* * https://cdn.netbsd.org/pub/NetBSD/NetBSD-10.1/images/NetBSD-10.1-amd64.iso
* * enable sshd
* * empty root password
* * 35G disk size
* enable german keyboard in /etc/rc.local
* * wsconsctl -w encoding=de
* sshd config
* * PermitRootLogin=yes
* * PasswordAuthentication=yes
* * PermitEmptyPasswords=yes
* * UsePAM=no
* disable IPv6 (creates extremely long delays)
* * ip6addrctl=YES
* * ip6addrctl_policy="ipv4_prefer"
* enable pkg_add
* * export PKG_PATH="http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/$(uname -p)/$(uname -r|cut -f '1 2' -d.)/All/"
* * pkg_add -4 pkgin
* * pkgin update
* * pkgin install git
* enable serial boot console: /boot.cfg
* * consdev=com0,115200
