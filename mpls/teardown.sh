#!/bin/bash

ovs-ofctl -O OpenFlow13 del-flows bridge1
ovs-ofctl -O OpenFlow13 del-flows bridge2
ovs-vsctl del-port bridge1 host1
ovs-vsctl del-port bridge2 host2
ip link delete dev veth12
ip netns delete ns1
ip netns delete ns2
ovs-vsctl del-br bridge1
ovs-vsctl del-br bridge2
systemctl stop openvswitch

modprobe -r openvswitch
