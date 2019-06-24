#!/bin/bash

info()
{
    echo "usage: vm-inst.sh [-n VM name] [-r RAM] [-c vcpus] [-d hard drive name] [-g hard drive size in GB]"
}

ram=2048
num_cpu=2
hd_size=60

while getopts ":n:r:c:d:g:" arg; do
    case ${arg} in
        n)      vm=$OPTARG      ;;
        r)      ram=$OPTARG     ;;
        c)      num_cpu=$OPTARG ;;
        d)      hd=$OPTARG      ;;
        g)      hd_size=$OPTARG ;;
        ?)      info
                exit            ;;
    esac
done
shift $((OPTIND -1))

if [ -z "$vm" ]; then
    info
    exit
fi

echo "Building VM"

sudo virt-install --name $vm \
                  --ram $ram \
                  --disk path=./$hd,size=$hd_size \
                  --vcpus $num_cpu \
                  --os-type linux --os-variant generic \
                  --network bridge=br0 \
                  --graphics none --console pty,target_type=serial \
                  --location '/home/chris/isos/CentOS-7-x86_64-Minimal-1810.iso' \
                  --extra-args 'console=ttySO,115200n8 serial' -x ks=ftp://172.16.0.100/pub/ks.cfg
