---
title: "Task 3: VNET-to-VNET Traffic"
linkTitle: "Task 3: VNET-to-VNET Traffic"
weight: 3
---

To be part of an Azure Virtual WAN, Azure VNETs need to be peered to the Azure vWAN hub. Prior to VNETs being peered to a vWAN hub, virtual machines in the VNET will route their traffic based on Azure default routing services such as user defined routing (UDR) or routes advertised by an Azure Route Server.

Two spoke VNETs have been deployed in your assigned resource group, each with a Linux virtual machine (VM). The spoke VNETs are just stand-alone VNETs which means the Linux VMs in one spoke cannot communicate with Linux VMs in the other spoke without setting up VNET peering with the hub and configuring routing.

In this task, the student will confirm that each Linux VM cannot communicate between VNETs and the Internet.

1. To view the assigned VNET address space, navigate from your assigned resource group to each VNET - **"Spoke1-vHub1_VNET"** and **"Spoke2-vHub1_VNET"**.

    ![](../images/4_3-confirm-vnet-to-vnet-1.PNG)

2. VNET assigned address space can be determined by clicking on a VNET and viewing the **"Address space"** value on the right side of the "Overview" pane.

VNET **Spoke1-vHub1_VNET** is shown below.
    ![](../images/4_3-confirm-vnet-to-vnet-2.PNG)

3. Repeat the above steps to determine the **"Address space"** for **Spoke2-vHub1_VNET**.

4. To view the private IP addresses of the spoke VNET Linux VMs, navigate from your assigned resource group to each Linux VM - **"Linux-Spoke1_VM"** and **"Linux-Spoke2_VM"**.

    ![](../images/4_3-confirm-vnet-to-vnet-3.PNG)
    Linux-Spoke1_VM        | Linux-Spoke2_VM
    :-------------------------:|:-------------------------:
    ![linuxvm1](../images/linuxvm1.jpg) |  ![](../images/4_3-confirm-vnet-to-vnet-4.PNG)

5. Access the serial console on the Linux-Spoke1_VM.

    - Scroll to the bottom of the left-hand navigation on the ***Linux-Spoke1_VM*** resource page
    - Expand the **"Help"** section (if not already expanded)
    - Click **"Serial console"**.  A serial console session will start in the right-hand pane.

6. Login to Linux-Spoke1_VM:

    - username `fortixperts`
    - password `Fortixperts2024!`

7. Ping Linux-Spoke2_VM:

    - `ping 192.168.2.4`

        ![](../images/4_3-confirm-vnet-to-vnet-5.PNG)

8. Ping Linux-Spoke1_VM from Linux-Spoke2_VM:

    - Repeat previous steps to access the serial console of ***Linux-Spoke2_VM***

9. Ping an Internet resource from both Linux VMs:

    - `ping 8.8.8.8`

    **Both ping tests will fail, these resources are unable to access each other and resources on the Internet.**

Continue to ***Chapter 4 - Task 4: BGP & Routing Intent***
