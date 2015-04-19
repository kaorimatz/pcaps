#!/bin/bash

ip netns delete ns1
ip netns delete ns2
modprobe -r fou
modprobe -r ipip
