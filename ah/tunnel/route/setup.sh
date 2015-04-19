#!/bin/bash

keying_material1=0x0123456789012345678901234567890123456789
keying_material2=0x9876543210987654321098765432109876543210

ip netns add ns1
ip netns add ns2
ip link add name veth1 type veth peer name veth2
ip link set dev veth1 netns ns1
ip link set dev veth2 netns ns2
ip netns exec ns1 ip link set dev veth1 up
ip netns exec ns2 ip link set dev veth2 up
ip netns exec ns1 ip address add 192.168.1.1/30 dev veth1
ip netns exec ns2 ip address add 192.168.1.2/30 dev veth2
ip netns exec ns1 ip link add name vti1 type vti local 192.168.1.1 remote 192.168.1.2 key 1
ip netns exec ns2 ip link add name vti2 type vti local 192.168.1.2 remote 192.168.1.1 key 1
ip netns exec ns1 ip link set dev vti1 up
ip netns exec ns2 ip link set dev vti2 up
ip netns exec ns1 ip xfrm policy add dir in mark 1 tmpl src 192.168.1.2 dst 192.168.1.1 proto ah spi 256 mode tunnel
ip netns exec ns1 ip xfrm policy add dir out mark 1 tmpl src 192.168.1.1 dst 192.168.1.2 proto ah spi 257 mode tunnel
ip netns exec ns2 ip xfrm policy add dir in mark 1 tmpl src 192.168.1.1 dst 192.168.1.2 proto ah spi 257 mode tunnel
ip netns exec ns2 ip xfrm policy add dir out mark 1 tmpl src 192.168.1.2 dst 192.168.1.1 proto ah spi 256 mode tunnel
ip netns exec ns1 ip xfrm state add src 192.168.1.1 dst 192.168.1.2 proto ah spi 257 auth 'hmac(sha1)' $keying_material2 mode tunnel
ip netns exec ns1 ip xfrm state add src 192.168.1.2 dst 192.168.1.1 proto ah spi 256 auth 'hmac(sha1)' $keying_material1 mode tunnel
ip netns exec ns2 ip xfrm state add src 192.168.1.1 dst 192.168.1.2 proto ah spi 257 auth 'hmac(sha1)' $keying_material2 mode tunnel
ip netns exec ns2 ip xfrm state add src 192.168.1.2 dst 192.168.1.1 proto ah spi 256 auth 'hmac(sha1)' $keying_material1 mode tunnel
ip netns exec ns1 ip address add 172.16.1.1/24 dev lo
ip netns exec ns2 ip address add 172.16.2.1/24 dev lo
ip netns exec ns1 ip route add 172.16.2.0/24 dev vti1
ip netns exec ns2 ip route add 172.16.1.0/24 dev vti2
