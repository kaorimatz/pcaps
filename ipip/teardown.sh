#!/bin/bash

ip netns exec ns1 ip link delete tunl1
ip netns exec ns2 ip link delete tunl2
ip netns exec ns1 ip link delete dev veth1
ip netns delete ns1
ip netns delete ns2

modprobe -r ipip
