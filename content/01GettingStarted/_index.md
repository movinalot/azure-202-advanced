---
title: "Chapter 1 Secure vWAN Lab - Overview"
menuTitle: "Chapter 1: Overview"
weight: 10
---

## Overview of your environment (15 min)

Azure Virtual WAN is a networking service that brings many networking, security, and routing functionalities together to provide a single operational interface.

Features of an Azure Virtual WAN include:

- Branch connectivity (via connectivity automation from Virtual WAN Partner devices such as SD-WAN or VPN CPE).
- Site-to-site VPN connectivity.
- Remote user VPN connectivity (point-to-site).
- Private connectivity (ExpressRoute).
- Intra-cloud connectivity (transitive connectivity for virtual networks).
- VPN ExpressRoute inter-connectivity.
- Routing, Azure Firewall, and encryption for private connectivity.

This session covers the following:

- FortiGate deployment into a VWAN Hub
- East-West Inspection between workloads in VNETs peered to the Hub
- North-South inspection between workloads in VNETs peered to the Hub and the Internet

Additionally, if desired and time permits:

- Setting up IPSEC tunnels to Branch FortiGates and ping across your cloud environment from your Branch VM.

Environment network diagram for reference:

![networkdiagram1](./images/networkdiagram.png)
