#!/bin/bash

modprobe l2tp_eth
modprobe l2tp_ip

ip netns add ns1
ip netns add ns2
ip link add name veth1 type veth peer name veth2
ip link set dev veth1 netns ns1
ip link set dev veth2 netns ns2
ip netns exec ns1 ip link set dev veth1 up
ip netns exec ns2 ip link set dev veth2 up
ip netns exec ns1 ip address add 192.168.1.1/30 dev veth1
ip netns exec ns2 ip address add 192.168.1.2/30 dev veth2
ip netns exec ns1 ip l2tp add tunnel tunnel_id 1 peer_tunnel_id 1 encap ip local 192.168.1.1 remote 192.168.1.2
ip netns exec ns2 ip l2tp add tunnel tunnel_id 1 peer_tunnel_id 1 encap ip local 192.168.1.2 remote 192.168.1.1
ip netns exec ns1 ip l2tp add session tunnel_id 1 session_id 1 peer_session_id 1
ip netns exec ns2 ip l2tp add session tunnel_id 1 session_id 1 peer_session_id 1
ip netns exec ns1 ip link set dev l2tpeth0 up
ip netns exec ns2 ip link set dev l2tpeth0 up
ip netns exec ns1 ip link add name veth10 type veth peer name veth11
ip netns exec ns2 ip link add name veth20 type veth peer name veth21
ip netns exec ns1 ip link set dev veth10 up
ip netns exec ns1 ip link set dev veth11 up
ip netns exec ns2 ip link set dev veth20 up
ip netns exec ns2 ip link set dev veth21 up
ip netns exec ns1 ip link add name bridge1 type bridge
ip netns exec ns2 ip link add name bridge2 type bridge
ip netns exec ns1 ip link set dev bridge1 up
ip netns exec ns2 ip link set dev bridge2 up
ip netns exec ns1 ip link set l2tpeth0 master bridge1
ip netns exec ns2 ip link set l2tpeth0 master bridge2
ip netns exec ns1 ip link set veth10 master bridge1
ip netns exec ns2 ip link set veth20 master bridge2
ip netns exec ns1 ip address add 172.16.1.1/24 dev veth11
ip netns exec ns2 ip address add 172.16.1.2/24 dev veth21
