---
title: "Task 1: East-West Network Traffic"
linkTitle: "Task 1: East-West Network Traffic"
weight: 1
---


In this task, the student will create FortiGate firewall policies to allow east-west network traffic.


1. ***Disable*** Probe Response on each FortiGate's port1 interface

    Both interfaces on the FortiGate may have **Probe Response** configured to respond to the Azure Internal Load Balancer Health Probes. This can cause traffic to take an unexpected path to the FortiGate. Ensure only the FortiGate interface that is expecting Spoke VNET traffic is responding to Load Balancer Heath Probes.

    - ***Navigate*** to Network -> Interfaces
    - ***Double-Click*** port1
    - ***Uncheck*** Probe Response
    - ***Click*** "OK"

        ![proberesponse1](../images/proberesponse1.jpg)

        ![proberesponse2](../images/proberesponse2.jpg)

### Spoke to Spoke traffic

1. ***Ping*** between Linux Spoke VMs.

    - ***Open*** a serial console connections to each Linux Spoke VM and ping the other Spoke VM
        - Linux-Spoke1-VM - `ping 172.16.1.4`
        - Linux-Spoke2-VM - `ping 192.168.1.4`

    Neither ping will be successful because the FortiGate is not allowing traffic from port2 to port2, even though port2 would be considered *trusted* since the traffic is all internal. This is the FortiGate's ability to micro-segment the traffic.

    However, the traffic from each VM **does reach the FortiGate**, but it is dropped. Firewall Policies are required to allow traffic to pass from port2 to port2.

1. ***View*** ping traffic from Spoke VMs reaching the FortiGates

    - ***Open*** each FortiGate in a browser tab/window
    - ***Open*** FortiGate CLI
    - ***Run*** CLI command `diagnose sniffer packet port2 'icmp' 4 0 a`
      - **4** - means: print header of packets with interface name
      - **0** - means: continuous output
      - **a** - means: absolute UTC time, yyyy-mm-dd hh:mm:ss.ms

        Linux-Spoke1_VM | Linux-Spoke2_VM
        :-:|:-:
        ![eastwestping1](../images/eastwestping1.jpg) | ![eastwestping2](../images/eastwestping2.jpg)

        FortiGate 0 | FortiGate 1
        :-:|:-:
        ![fgtpingdiag1](../images/fgtpingdiag1.jpg) | ![fgtpingdiag2](../images/fgtpingdiag2.jpg)

    The ping traffic is only on one FortiGate, this is because the internal load balancer sends traffic from the Spokes to one of the FortiGates for inspection.

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

        ![firewall1](../images/firewall1.jpg)


4. ***Ping*** between Linux Spoke VMs and confirm connectivity.
        - Linux-Spoke1-VM - `ping 172.16.1.4`
        - Linux-Spoke2-VM - `ping 192.168.1.4`


        Linux-Spoke1_VM | Linux-Spoke2_VM
        :-:|:-:
        ![eastwestping3](../images/eastwestping3.jpg) | ![eastwestping4](../images/eastwestping4.jpg)

        FortiGate 0 | FortiGate 1
        :-:|:-:
        ![fgtpingdiag3](../images/fgtpingdiag3.jpg) | ![fgtpingdiag4](../images/fgtpingdiag4.jpg)


Continue to ***Chapter 5 - Task 2: North-South Network Traffic***
