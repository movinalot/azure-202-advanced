---
title: "Task 4: BGP & Routing Intent"
linkTitle: "Task 4: BGP & Routing Intent"
weight: 4
---

In task four, the student will configure BGP on the FortiGates and enable Routing Intent from the Azure hub portal.

### Configure BGP

1. ***Confirm*** the private address space of the vWAN hub

    The private address space of the vWAN hub is needed to create a summary route from the private address range to the secondary interfaces of the FortiGate NVAs to establish BGP peering.

    The FortiGates are deployed with BGP peers already configured and ready to go online after the static route is enabled.

    - ***Navigate*** to your Hub **vwanXX-training_VWAN**
    - ***View*** Hub Address space

        ![](../images/4_4-bgp-routing-intent-1.PNG)

1. View FortiGate BGP Peer status

    - ***Open*** each FortiGate in a browser tab/window
    - **Open** FortiGate CLI
    - **Run** CLI command `get router info bgp summary` to view BGP Peer status

        ![bgp0](../images/bgp0.jpg)

1. ***Determine*** FortiGate NVA port2 Gateway

    Static routes are needed on the FortiGates to enable BGP, a component required to setup the static route is the gateway address of the FortiGate's port2 interface.

    Every subnet in Azure uses the first address in the subnet as the gateway. For example, in the subnet 10.1.1.0/24 Azure uses 10.1.1.1 as the subnet gateway.

    - ***Click*** on Network
    - ***Click*** on Interfaces
    - ***View*** the assigned address of port2 and determine the gateway

    In the screenshot below, the port2 IP address is 10.1.112.5/255.255.255.128 (/25)
    - Network address is **10.1.112.0**
    - Gateway address is **10.1.112.1**

        ![](../images/4_4-bgp-routing-intent-2.PNG)

1. ***Configure*** Static Routes on each FortiGate

    Two static routes are required on each FortiGate

    - A static route to the virtual hub routers through the gateway of port2
    - A Static route for the internal Azure load balancer probes

    - ***Click*** Network
    - ***Click*** Static Routes
    - ***Click*** Create New

        ![bgp3](../images/bgp3.jpg)

1. Create a static route

    - ***Enter*** Destination - `10.1.0.0/16`
    - ***Enter*** Gateway Address - `10.1.112.1`
    - ***Select*** Interface - **port2**
    - ***Click*** "OK"

        ![bgp4](../images/bgp4.jpg)

1. Repeat the process to add a static route for the Azure internal load balancer health probe

    Refer to the overall [](../images/1_1-az-vwan-single-hub-ra.PNG) for the internal load balancer placement. Health probes enable the Azure load balancer to know if a FortiGate is in a state to forward traffic.

    The static route destination below is the default Azure load balancer health probe destination.

    - ***Enter*** Destination: `168.63.129.16/32`
    - ***Enter*** Gateway Address: `10.1.112.1`
    - ***Select*** Interface: **port2**
    - ***Enter*** Administrative Distance: `5`
    - ***Click*** "OK"

1. ***Repeat*** the commands on the other FortiGate

    When completed the static routes of each FortiGate should look similar to the screenshot below.

    ![bgp5](../images/bgp5.jpg)

1. ***Verify*** BGP communication between FortiGate NVAs

    After configuring the static routes on both FortiGates BGP peers are reachable.

    - ***Verify*** BGP communication between FortiGate NVAs in the CLI.
    - **Open** FortiGate CLI
    - **Run** CLI command `get router info bgp summary`

        ![bgp6](../images/bgp6.jpg)

    More information about FortiGate static routes and BGP can be found in [Fortinet documents](https://docs.fortinet.com/document/fortigate-public-cloud/7.4.0/azure-vwan-ngfw-deployment-guide/860717/configuring-static-routes-and-enabling-bgp-on-fortigate-nvas).

### Enable Routing Intent

Routing Intent and Routing Policies allow you to configure the Virtual WAN hub to forward Internet-bound and Private (Point-to-site VPN, Site-to-site VPN, ExpressRoute, Virtual Network and Network Virtual Appliance) Traffic to an Azure Firewall, Next-Generation Firewall Network Virtual Appliance (NGFW-NVA) or security software-as-a-service (SaaS) solution deployed in the virtual hub.

1. ***Enable*** Routing Intent

    - ***Navigate*** - to your Hub - vwanXX-vHub1_eastus
    - ***Click*** - "Routing Intent and Routing Policies"
    - ***Select*** - for "Internet traffic" - Network Virtual Appliance
    - ***Select*** - for "Private traffic" - Network Virtual Appliance
    - ***Select*** - for **both** "Next Hop Resources" - your cluster name (the only selection in the dropdown)
    - ***Click*** - "Save" to update Routing Intent

        ![bgp7](../images/bgp7.jpg)

Continue to ***Chapter 4 - Task 5: VNET Peering and Verifying Routing***
