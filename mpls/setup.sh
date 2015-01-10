#!/bin/bash

systemctl start openvswitch
ovs-vsctl add-br bridge1
ovs-vsctl add-br bridge2
ovs-vsctl set Bridge bridge1 protocols=OpenFlow13
ovs-vsctl set Bridge bridge2 protocols=OpenFlow13
ip netns add ns1
ip netns add ns2
ip link add name veth12 type veth peer name veth21
ovs-vsctl add-port bridge1 veth12
ovs-vsctl add-port bridge2 veth21
ovs-vsctl add-port bridge1 host1 -- set Interface host1 type=internal
ovs-vsctl add-port bridge2 host2 -- set Interface host2 type=internal
ip link set dev host1 netns ns1
ip link set dev host2 netns ns2
ip link set dev veth12 up
ip link set dev veth21 up
ip netns exec ns1 ip link set dev host1 up
ip netns exec ns2 ip link set dev host2 up
ip netns exec ns1 ip address add 192.168.1.1/30 dev host1
ip netns exec ns2 ip address add 192.168.1.2/30 dev host2
port_veth12=$(ovs-vsctl --bare --column=ofport find Interface name=veth12)
port_veth21=$(ovs-vsctl --bare --column=ofport find Interface name=veth21)
port_host1=$(ovs-vsctl --bare --column=ofport find Interface name=host1)
port_host2=$(ovs-vsctl --bare --column=ofport find Interface name=host2)
ovs-ofctl -O OpenFlow13 add-flow bridge1 "table=0,in_port=$port_host1,eth_type=0x0800,actions=push_mpls:0x8847,set_mpls_label:16,output:$port_veth12"
ovs-ofctl -O OpenFlow13 add-flow bridge1 "table=0,in_port=$port_veth12,eth_type=0x8847,mpls_bos=1,actions=pop_mpls:0x0800,output:$port_host1"
ovs-ofctl -O OpenFlow13 add-flow bridge2 "table=0,in_port=$port_host2,eth_type=0x0800,actions=push_mpls:0x8847,set_mpls_label:17,output:$port_veth21"
ovs-ofctl -O OpenFlow13 add-flow bridge2 "table=0,in_port=$port_veth21,eth_type=0x8847,mpls_bos=1,actions=pop_mpls:0x0800,output:$port_host2"
