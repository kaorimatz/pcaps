#!/bin/bash

ip netns exec ns1 ip link delete gre1
ip netns exec ns2 ip link delete gre2
ip netns exec ns1 ip link delete dev veth1
ip netns delete ns1
ip netns delete ns2

modprobe -r ip_gre
