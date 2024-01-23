#!/bin/bash 

users=$1
templates=(96969 20014)
node="dale"
pool="CrimeWave"

# adds leading 0s to user number for vmid
for id in $(seq -f "%05g" 2 $users)
do 
    for template in ${!templates[@]} 
    do 
        # converts ID to base10 from base10 to remove leading 0s
        #echo "clone ${templates[$template]} with vmid $id on $node in $pool named $id-${templates[$template]}"
        pvesh create /nodes/$node/qemu/${templates[$template]}/clone -newid 9$id -pool $pool -name $id-${templates[$template]}
        #echo "config $id net0 to have vlan tag $((10#$id))"
        pvesh create /nodes/$node/qemu/9$id/config -net0 "virtio,bridge=vmbr2,firewall=0,tag=$((10#id))"
    done
done
