---
title: "Task 1: Deploy a VWAN Hub"
linkTitle: "Task 1: Deploy a VWAN Hub"
weight: 20
---

## Deploy a VWAN Hub

The initial Virtual WAN setup was already done for you before the session. Now you will deploy a Hub in another Azure Region. The Hub will eventually have a Virtual Network (VNET) associated to it, with a Linux server deployed in the associated VNET.

1. ***Add*** a VWAN Hub.

    - ***Navigate*** to your VWAN's **vwanXX-eastus_VWAN** hubs
    - ***Click*** - "+ New Hub" button

    - ***Select*** - Region "West US"
    - ***Enter*** - Name **vwanXX-vHub2_westus**
    - ***Enter*** - Hub private address space "10.2.0.0/16"
    - ***Select*** - Virtual hub capacity "2 Routing Infrastructure Units, 3 Gbps Router, Supports 2000 VMs"
    - ***Select*** - Hub routing preference "AS Path"
    - ***Click*** - "Next: Site to Site" button

        ![hub1](../images/hub1.jpg)
        ![hub2](../images/hub2.jpg)

    - ***Click*** - "Next: Point to Site" button
    - ***Click*** - "Next: ExpressRoute" button
    - ***Click*** - "Next: Tags" button
    - ***Click*** - "Next: Review + create" button
    - ***Click*** - "Next: Create" button

        ![hub3](../images/hub3.jpg)
        ![hub4](../images/hub4.jpg)
        ![hub5](../images/hub5.jpg)
        ![hub6](../images/hub6.jpg)
        ![hub7](../images/hub7.jpg)

        {{% notice tip %}}A deployment progress screen will be shown followed by a deployment completion screen. Hub deployment can take up to 20 minutes. However you can open the Azure portal in another browser tab and continue with the next task.{{% /notice %}}

        ![hub8](../images/hub8.jpg)
        ![hub9](../images/hub9.jpg)

Continue to ***Next Task***
