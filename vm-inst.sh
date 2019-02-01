#!/bin/bash

# vm_installer - A script that automates a KVM installation using CentOS 7 and kickstart in /var/ftp/pub/ks.cfg

info()
{
	echo "usage: vm-inst.sh [-i] | [-n VM name ] [-r RAM] [-c vcpus] [-d hard drive name] [-g hd size in GB] | [-h]"
}

# Main

interactive=

while getopts ":n:r:c:d:g:" arg; do
	case ${arg} in
		n )		vm=${OPTARG}      ;;
		r )		ram=${OPTARG}     ;;
		c )		num_cpu=$OPTARG   ;;
		d )		hd=$OPTARG        ;;
		g )		hd_size=$OPTARG   ;;
		\?)		info 
				exit		      ;;
	esac
done
shift $((OPTIND -1))

#if [ "$interactive" = "1" ]; then

#	echo "_______________"
#	echo "VM Installation"
#	echo "_______________"

#	echo "Enter the name of the VM:" 
#	read vm

#	echo "Enter the amount of RAM in MB:"
#	read ram

#	echo "Enter the name of the storage drive:"
#	read hd

#	echo "How large did you want the disk (in GB)?"
#	read hd_size

#	echo "Enter the number of CPU cores:"
#	read num_cpu
#fi

echo "Building VM"

sudo virt-install --name $vm \
		  --ram $ram \
		  --disk path=./$hd,size=$hd_size \
		  --vcpus $num_cpu \
		  --os-type linux --os-variant generic \
		  --network bridge=br0 \
		  --graphics none --console pty,target_type=serial \
		  --location '/home/chris/isos/CentOS-7-x86_64-Minimal-1810.iso' \
		  --extra-args 'console=ttyS0,115200n8 serial' -x ks=ftp://10.0.0.100/pub/ks.cfg

