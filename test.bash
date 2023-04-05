#!/bin/bash -xe

openstack compute service list
openstack network agent list
net_id=$(openstack network show private -f json 2>/dev/null | jq -r .id | tr -d "\r\n")
nova boot --image cirros-0.5.2-x86_64-disk --flavor m1.medium --nic net-id=$net_id testvm
sleep 10
nova list
nova list | grep ACTIVE
nova show testvm
nova delete testvm

sudo journalctl --no-pager -n 300 -eu devstack@n-cpu
sudo journalctl --no-pager -n 300 -eu devstack@q-agt
