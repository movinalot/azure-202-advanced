---
title: "Task 1: FortiGate NVA Deployment"
linkTitle: "Task 1: FortiGate NVA Deployment"
weight: 1
---

In task one, you will deploy a FortiGate NVA into the vWAN hub that you have been assigned to.

1. ***Click*** on VWAN **vwanXX-eastus_VWAN** in your Resource Group. **XX** is the number of your allocated environment.

    ![vwan1](../images/vwan1.jpg)

1. ***Click*** on "Hubs" in the "Connectivity" section of the left-hand navigation. A hub in EastUS has already been deployed.

    ![vwan2](../images/vwan2.jpg)

1. ***Click*** on the Hub

1. ***View*** information about Hub

    - Name
    - Location (Region)
    - Private Address Space

1. ***Check*** statuses

    - Hub status: **Succeeded**
    - Routing status: **Provisioned**

        ![vwan3](../images/vwan3.jpg)

        {{% notice warning %}}Note: please move on to the next step **only** if Hub and Routing status have green checks.{{% /notice %}}

1. ***Click*** on "Network Virtual Appliance in the "Third party providers" section of the left-hand navigation.
1. ***Click*** the button "Create network virtual appliance"
1. ***Select*** fortinet-sdwan-and-ngfw
1. ***Click*** "Create". proceed to leave site to redirect to Marketplace.

    - If a warning is displayed about "Leaving" the **site** or **page** ***Click*** the "Leave" button

        ![vwan4](../images/vwan4.jpg)

1. ***Click*** "Create" on the Marketplace listing for "**Azure Virtual WAN Secured by Fortinet FortiGate**"

    ![vwan5](../images/vwan5.jpg)

1. **Basics Tab values**

    - ***Select*** - Resource Group - **vwanXX-training** -- *Be sure to select your Resource Group*
    - ***Select*** - Region - **East US** -- *Should already be defaulted to the correct region*
    - ***Enter*** - FortiGate administrative username - ```fortixperts```
    - ***Enter*** - password - ```Fortixperts2024!```
    - ***Confirm*** - password - ```Fortixperts2024!```
    - ***Enter*** - FortiGate Name Prefix - **vwanXX** -- *Be sure to enter your allocated environment number for XX.*
    - ***Select*** - FortiGate License Type - "**Pay As you Go (PAYG)**"
    - ***Select*** - FortiGate Image Version - "**7.4.X**" -- *Be sure to select the highest 7.4 version.*
    - ***Select*** - Azure vWan deployment type - "**SDWAN + NGFW (Hybrid)**"
    - ***Enter*** - Application Name - **vwanXX** -- *Be sure to enter your allocated environment number for XX.*
    - ***Update*** - Managed Resource Group - Append "**_vwanXX**" to the provided name -- *Be sure to enter your allocated environment number for XX.*
    - ***Click*** - "**Next**"

        ![vwan6](../images/vwan6.jpg)

1. **FortiGate in Virtual WAN Specific Parameters Tab values**

    - ***Select*** Virtual WAN Hub - select vwanXX-vHub1_eastus -- **Be sure to enter your allocated environment number for XX.**
    - ***Leave*** all other items as is
    - ***Click*** "Next"

        ![vwan7](../images/vwan7.jpg)

1. **PublicIP Verification Tab values**

    - ***Click*** "Next"

        ![vwan8](../images/vwan8.jpg)

1. **Tags Tab values**

    - ***Click*** "Next"

        ![vwan9](../images/vwan9.jpg)

1. **Review + create Tab values**

    - ***Scroll*** down to agree to the terms and conditions
    - ***Click*** "Create"

        ![vwan10](../images/vwan10.jpg)

        {{% notice info %}}The FortiGate NVAs take about 15 minutes to deploy. Grab a refreshment and relax! You will see the screen belows when the deployment is progressing and complete.{{% /notice %}}

        ![vwan11](../images/vwan11.jpg)
        ![vwan12](../images/vwan12.jpg)

Continue to ***Chapter 4 - Task 2: Configure FGSP***
