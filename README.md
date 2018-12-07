# vm_installer
Script for installing VM in KVM/QEMU


Make sure that KVM/QEMU is installed for your system. Common setups:

## CentOS
https://www.cyberciti.biz/faq/how-to-install-kvm-on-centos-7-rhel-7-headless-server/

## Ubuntu
https://help.ubuntu.com/community/KVM/Installation

Be sure to setup bridged networking, too, otherwise this one won't very well. You can call your bridge whatever you want, I chose br0. 

Most of these commands are option, you can find what works best for you or make it more efficient. I like watching the terminal scroll or leaving it up to check for errors, but really as long as the "reboot" option is there it'll finish after a little while. 


