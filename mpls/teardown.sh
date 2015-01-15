#!/bin/bash

ovs-vsctl del-br bridge1
ovs-vsctl del-br bridge2
ip link delete dev veth12
ip netns delete ns1
ip netns delete ns2
systemctl stop openvswitch
modprobe -r openvswitch
