---
title: "VNET Peering & Verification"
menuTitle: "Task 6 - VNETs & Verification"
weight: 30
---

## Task 6

### Peer Spoke VNETS to Hub

FortiGates are ready to inspect network traffic. Network traffic is coming from or going to workloads in the Spoke VNETs. In order for the FortiGates to managed the traffic the Spoke VNETs must be peered to the VWAN Hub.

1. Peer Spoke1 VNET to hub

    - ***Navigate*** to your Virtual Wan - **vwanXX-eastus_VWAN**
    - ***Click*** "Virtual network connections"
    - ***Click*** "+ Add connection"

    - ***Enter*** - "Connection name" - `Spoke1`
    - ***Select*** - "Hubs" - your Hub -**vwanXX-vHub1_eastus**
    - ***Select*** - "Resource group" - your Resource - **vwanXX-training**
    - ***Select*** - "Virtual Network" - Spoke 1's VNET - **Spoke1-vHub1_VNET**
    - ***Click*** - "Create"

    ![peering1](../images/peering1.jpg)

1. Peer Spoke2 VNET to hub

    - ***Navigate*** to your Virtual Wan - **vwanXX-eastus_VWAN**
    - ***Click*** "Virtual network connections"
    - ***Click*** "+ Add connection"

    - ***Enter*** - "Connection name" - `Spoke2`
    - ***Select*** - "Hubs" - your Hub -**vwanXX-vHub1_eastus**
    - ***Select*** - "Resource group" - your Resource - **vwanXX-training**
    - ***Select*** - "Virtual Network" - Spoke 2's VNET - **Spoke2-vHub1_VNET**
    - ***Click*** - "Create"

    ![peering2](../images/peering2.jpg)

1. Click Add connection at the top and fill in the details for both Spoke1 and Spoke2 as shown below.

![bgp5](../images/bgp5.png)

1. Once the peering is complete, the VCN table should like below.

![bgp6](../images/bgp6.png)

### Time to verify your work

1. Check the Hub default route table. To check the effective routes, VWAN >> East US - hub >> Effective Routes. 

The default route and RFC1918 routes will have NVA group as next hop.

![bgp7](../images/bgp7.png)

1. on the Fortigate, we can see that Hub will be BGP advertising VNET's to Fortigate. You can use `get router info routing-table all`

![bgp8](../images/bgp8.png)

1. Check the effective routes on Spoke Virtual machines by clicking Effective routes on Linux VM's NIC.

![bgp9](../images/bgp9.png)

The effective routes next Hop IP is the IP address of Internal Load balancer that gets deployed along with managed application.

Continue to Chapter 2
