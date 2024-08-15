---
title: "North South Inspection "
menuTitle: "2 - Spoke to Internet Traffic"
weight: 3
---

## North South Inspection

Can traffic pass from a spoke to the Internet?

### Spoke to Internet traffic

1. ***Ping*** from the Linux Spoke VMs to the Internet

    - ***Open*** a serial console connections to each Linux Spoke VM and ping the other Spoke VM
        - Linux-Spoke1-VM - `ping 8.8.8.8`
        - Linux-Spoke2-VM - `ping 8.8.8.8`

    Neither ping will be successful because the FortiGate is not allowing traffic from port2 to port1, even though port2 would be considered *trusted* since the traffic is all internal. This is the FortiGate's ability to micro-segment the traffic.

    However, the traffic from each VM **does reach the FortiGate**, but it is dropped. Firewall Policies are required to allow traffic to pass from port2 to port2.

1. ***View*** ping traffic from Spoke VMs reaching the FortiGates

    - ***Open*** each FortiGate in a browser tab/window
    - ***Open*** FortiGate CLI
    - ***Run*** CLI command `diagnose sniffer packet any 'icmp' 4 0 a`
      - **4** - means: print header of packets with interface name
      - **0** - means: continuous output
      - **a** - means: absolute UTC time, yyyy-mm-dd hh:mm:ss.ms

    FortiGate 0 | FortiGate 1
    :-:|:-:
    this one | that one

    Linux-Spoke1_VM        | Linux-Spoke2_VM
    :-:|:-:
    ![eastwestping1](../images/eastwestping1.jpg) | ![eastwestping2](../images/eastwestping2.jpg)

1. ***Create*** Firewall policies **on both** FortiGates to allow traffic to pass from port2 to port2 (Spoke to Spoke)

    The FortiGates can be setup to sync configuration information. If one of the FortiGates was designated as the Primary configuration supplier and the other as a Secondary, any changes made to the Primary would be replicated to the secondary.

    Configuration Synchronization was not enabled on the FortiGates as part of this session.

    - ***Navigate*** to "Policy & Objects"
    - ***Click*** Firewall Policy
    - ***Click*** Create new
        Attribute | Value
        -|-
        Name | **port2_to_port2**
        Incoming interface | **port2**
        Outgoing interface | **port2**
        Source | **all**
        Destination | **all**
        Schedule | **always**
        Service | **ALL**
        NAT | **enabled**
        IP pool configuration | **Use Outgoing Interface Address**
        Enable this policy | **enabled**
    - ***Click*** "OK"

    Linux-Spoke1_VM | Linux-Spoke2_VM
    :-:|:-:
    ![eastwestping3](../images/eastwestping3.jpg) | ![eastwestping4](../images/eastwestping4.jpg)

Continue to ***Task 2***
