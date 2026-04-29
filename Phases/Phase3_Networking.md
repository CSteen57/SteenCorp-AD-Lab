# Phase 3 – Networking & Domain Connectivity

---

## Objective
Configure and validate core networking services (DHCP & DNS) within the SteenCorp lab, and troubleshoot real-world connectivity and resolution issues.

---

## Overview

Phase 3 transitions the lab from isolated systems into a fully functional network.

In this phase, I:
- Designed a structured IP addressing scheme
- Configured the Domain Controller (DC01) as the central DHCP and DNS authority
- Implemented forward and reverse DNS lookup
- Diagnosed and resolved real networking issues

This phase focuses heavily on **troubleshooting and validation**, which are critical in real IT environments.

---

## IP Addressing Scheme

| Category | Range | Purpose |
|--------|------|--------|
| Network | 192.168.10.0/24 | Lab subnet |
| Gateway | 192.168.10.1 | Default gateway |
| Core Infrastructure | 192.168.10.2–10 | DC, DNS |
| Server Tier | 192.168.10.11–20 | Future servers |
| Static Range | 192.168.10.21–99 | Reserved |
| DHCP Range | 192.168.10.100–200 | Client devices |

**Design Considerations:**
- Static IPs for critical services
- DHCP for scalability
- Centralized DNS
- Segmentation to prevent conflicts

---

## Implementation

### Domain Controller Configuration

![DC01 Static IP](../Evidence/Infrastructure/DC01_Static_IP_Configuration.png)

---

### DHCP Deployment

![DHCP Scope](../Evidence/Networking/DHCP_Scope_Exclusion_Pool.png)

---

### DNS Configuration

- Forward Lookup Zone: `SteenCorp.local`
- Reverse Lookup Zone: `192.168.10.0/24`

![DNS Reverse Lookup](../Evidence/Networking/DNS_Reverse_Lookup_PTR_Record.png)

---

### DHCP Reservation

![DHCP Reservation](../Evidence/Networking/Windows_Server_DHCP_Reservation_Config.png)

---

## Issue 1 – DHCP Not Working

During testing, the client machine received an IP in:

`192.168.217.x`

This indicated:
- The client was not receiving DHCP from DC01
- Another DHCP service was active on the network

![VMware DHCP Conflict](../Evidence/Validation/DHCP_Validation_VMware_Conflict.png)

---

### Initial Troubleshooting

Attempted:
- `ipconfig /release`
- `ipconfig /renew`

This failed.

Further inspection revealed:
- The client adapter was still set to a static IP

![DHCP Static Adapter Issue](../Evidence/Validation/DHCP_Validation_Fail_Static_Adapter.png)

---

## Issue 2 – BAD_ADDRESS Conflict

After enabling DHCP, a new issue appeared:

- IP `192.168.10.101` marked as BAD_ADDRESS

This indicated:
- IP conflict on the network
- DHCP correctly preventing assignment

![DHCP Conflict](../Evidence/Networking/DHCP_IP_Conflict_Detection.png)
![BAD ADDRESS](../Evidence/Networking/DHCP_Server_Bad_Address_Quarantine.png)

---

## Root Cause

Investigation revealed:

- VMware NAT adapter was still active
- VMware had its own DHCP service running
- Lab environment was connected to multiple networks

This caused:
- Incorrect IP assignment
- DHCP conflicts
- Network instability

---

## Solution – Network Isolation

To resolve the issue:

- Moved all VMs to a custom LAN segment
- Disabled VMware NAT influence
- Rebooted the client
- Renewed DHCP

![LAN Isolation](../Evidence/Infrastructure/VMware_Internal_LAN_Segment_Isolation.png)
![NAT Conflict](../Evidence/Infrastructure/VMware_NAT_Configuration_Conflict.png)

---

## Result

- DHCP requests handled by DC01 only
- No IP conflicts
- Client received correct IP:
  `192.168.10.101`

---

## DNS Issue – Inconsistent Resolution

After DHCP was fixed, DNS resolution was inconsistent.

Some lookups worked, others failed.

---

## DNS Fix

Reset and re-registered DNS:

`Stop-Service DNS`  
`ipconfig /flushdns`  
`Start-Service DNS`  
`ipconfig /registerdns`

![DNS Reset](../Evidence/Validation/PowerShell_DNS_Reset_Script.png)

---

## DNS Forwarders

Configured external resolution:

- 8.8.8.8
- 1.1.1.1

![DNS Forwarders](../Evidence/Networking/DNS_Forwarders_Validated.png)

---

## Validation

Tested using:

`nslookup dc01`  
`nslookup 192.168.10.10`

![NSLookup](../Evidence/Validation/NSLookup_Internal_External_Success.png)

Results:
- Internal resolution ✔
- Reverse lookup ✔
- External resolution ✔

---

## Final Network State

- IP: `192.168.10.101`
- DHCP: `192.168.10.10`
- DNS: `192.168.10.10`
- Gateway: `192.168.10.1`

![Final Validation](../Evidence/Validation/Final_VIP_Workstation_IP_Verification.png)

---

## Key Takeaways

- IP planning is critical before deployment
- Virtual environments can introduce hidden network conflicts
- DHCP and DNS must be tightly controlled
- Network isolation is essential in lab environments
- Troubleshooting is as important as configuration

---
