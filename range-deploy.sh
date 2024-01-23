#!/bin/bash 

users=$1
templates=(96969 20014)
node="dale"
pool="CrimeWave"

# adds leading 0s to user number for vmid
for id in $(seq -f "%03g" 2 $users)
do 
    for template in ${!templates[@]} 
    do
        #this is the number of the box for the user (so if you clone 12 templates they'd have 900200 thru 900211)
        printf -v boxnumber "%02d" $template 
        # converts ID to base10 from base10 to remove leading 0s
        #echo "clone ${templates[$template]} with vmid 9$id$boxnumber on $node in $pool named $id-${templates[$template]}"
        pvesh create /nodes/$node/qemu/${templates[$template]}/clone -newid 9$id$boxnumber -pool $pool -name $id-${templates[$template]}
        #echo "config 9$id$boxnumber net0 to have vlan tag $((10#$id))"
        pvesh create /nodes/$node/qemu/9$id$boxnumber/config -net0 "virtio,bridge=vmbr2,firewall=0,tag=$((10#$id))"
    done
done
