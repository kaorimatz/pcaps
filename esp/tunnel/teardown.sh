#!/bin/bash

ip netns exec ns1 ip link delete dev veth1
ip netns delete ns1
ip netns delete ns2
