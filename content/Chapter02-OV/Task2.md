---
title: "Task 2: VNET-to-VNET Traffic"
linkTitle: "Task 2: VNET-to-VNET Traffic"
weight: 30
---

## VNET-to-VNET Traffic

To be part of and Azure Virtual WAN, Azure Virtual Networks need to be connected to the Azure Virtual WAN Hub. Prior to VNETs being connected to a VWAN, virtual machines in the VNET will route their traffic based on Azure default routing, user defined routing in Azure Route Tables, or Routes advertised by the Azure Route Server.

Two "Spoke" VNETs have been deployed in the Azure environment, each with a Spoke virtual machine (VM). The Spoke VNETs just stand-alone VNETs whose VMs cannot communicate with each other without setting up, VNET Peering and Routing.

Determine that the Spoke VMs cannot communicate with each other.

### Spoke Virtual Networks (VNETs) and Virtual Machines (VMs)

1. ***View*** the Spoke VNETs Address Space

    - Spoke1-vHub1_VNET with address space 192.168.1.0/24
    - Spoke2-vHub1_VNET with address space 172.16.1.0/24

        ![vnets1](../images/vnets1.jpg)

    VNET assigned address space can be view by:
    - ***Clicking*** on a VNET
    - ***Clicking*** "Address space" in the left-hand navigation

        VNET **Spoke2-vHub1_VNET** is shown below.
        ![vnets2](../images/vnets2.jpg)

1. ***View*** the private IP addresses of the Spoke VNETs Linux VMs

    - Linux-Spoke1_VM IP `192.168.1.4`
    - Linux-Spoke2_VM IP `172.16.1.4`

        ![linuxvms](../images/linuxvms.jpg)

        Linux-Spoke1_VM        | Linux-Spoke2_VM
        :-------------------------:|:-------------------------:
        ![linuxvm1](../images/linuxvm1.jpg) |  ![linuxvm2](../images/linuxvm2.jpg)

1. ***Access*** the Serial console on Linux-Spoke1_VM view

    - ***Scroll*** to the bottom of the left-hand navigation on the Linux-Spoke1_VM resource page
    - ***Expand*** the "Help" section (if not already expanded)
    - ***Click*** "Serial console"

    A serial console session will start in the right-hand pane

1. ***Login*** to Linux-Spoke1_VM

    - username `fortixperts`
    - password `Fortixperts2024!`

1. ***Ping*** Linux-Spoke2_VM

    - `ping 172.16.1.4`

        ![linuxvm1serial](../images/linuxvm1serial.jpg)

1. ***Ping*** Linux-Spoke1_VM from Linux-Spoke2_VM

    - ***Repeat*** previous steps to access the serial console of ***Linux-Spoke2_VM***

1. ***Ping*** an Internet resource

    - `ping 8.8.8.8`

    **Both ping tests will fail, these resources are unable to access each other and resources on the Internet.**

Continue to ***Next Task***
