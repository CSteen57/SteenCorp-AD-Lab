# Phase 3 – Networking & Domain Connectivity (In Progress)

## Status
🚧 In Progress

---

## Objective
Build and validate core networking functionality within the SteenCorp lab environment by establishing structured IP addressing, centralized DNS, and controlled DHCP services.

---

## Overview

Phase 3 represents the transition from isolated virtual machines into a functional enterprise network.

In this phase:
- A structured IP Address Management (IPAM) plan was designed
- The Domain Controller (DC01) was configured as the central authority
- DHCP services were implemented for dynamic client configuration
- DNS services were expanded to include forward and reverse lookup
- Real-world networking issues were encountered and resolved

This phase emphasizes not just configuration, but **troubleshooting and validation**, which are critical skills in real IT environments.

---

## SteenCorp IP Schema

A structured IP addressing plan was created before implementation:

| Category              | Range / Address        | Purpose                                  |
|----------------------|----------------------|------------------------------------------|
| Network              | 192.168.10.0/24      | Core lab subnet                          |
| Gateway              | 192.168.10.1         | Default gateway                          |
| Core Infrastructure  | 192.168.10.2–10      | Domain Controller, DNS                   |
| Server Tier          | 192.168.10.11–20     | Future servers                           |
| Static Range         | 192.168.10.21–50     | Reserved infrastructure                  |
| DHCP Range           | 192.168.10.100–200   | Client devices                           |

### Design Notes
- Static IPs ensure consistent availability for critical services
- DHCP enables scalable client configuration
- DNS is centralized on the Domain Controller
- Structured addressing prevents IP conflicts

---

## Implementation

### Domain Controller Static Configuration

![DC01 Static IP](../Evidence/Infrastructure/DC01_Static_IP_Configuration.png)

---

### DHCP Deployment

![DHCP Scope](../Evidence/Networking/DHCP_Scope_Exclusion_Pool.png)

---

### DNS Configuration (Forward + Reverse Lookup)

A complete DNS structure was implemented to support both forward and reverse name resolution within the SteenCorp network.

- Forward Lookup Zone: `SteenCorp.local`
- Reverse Lookup Zone: `192.168.10.0/24`

#### Reverse Lookup Zone Implementation

![DNS Reverse Lookup](../Evidence/Networking/DNS_Reverse_Lookup_PTR_Record.png)

---

### DHCP Reservation (Controlled Addressing)

![DHCP Reservation](../Evidence/Networking/Windows_Server_DHCP_Reservation_Config.png)

---
## Issues & Troubleshooting

### DHCP Issue – Wrong Network

When I first configured DHCP, the Windows 11 client was not getting an IP from my DC.  

Instead, it was pulling an address in the `192.168.217.x` range.

At that point I knew:
- That’s not my subnet (`192.168.10.0/24`)
- Something else was acting as DHCP

![VMware DHCP Conflict](../Evidence/Validation/DHCP_Validation_VMware_Conflict.png)

---

### First Attempt – Renewing DHCP

I tried forcing a renewal using:

`ipconfig /release`  
`ipconfig /renew`

That failed.

After checking the adapter, I realized the client was still set to a **static IP**, so DHCP wasn’t even being used.

![DHCP Renewal Failure](../Evidence/Validation/DHCP_Validation_Fail_Static_Adapter.png)

---

### Second Issue – BAD_ADDRESS

After switching to DHCP, I ran into another issue:

- The IP `192.168.10.101` was marked as **BAD_ADDRESS**

![DHCP Conflict Detection](../Evidence/Networking/DHCP_IP_Conflict_Detection.png)
![BAD ADDRESS](../Evidence/Networking/DHCP_Server_Bad_Address_Quarantine.png)

This told me:
- Something on the network was already using that IP
- DHCP was correctly detecting a conflict and blocking it

---

### Root Cause

At this point I checked VMware networking and found:

- The NAT adapter was still active
- VMware was running its own DHCP service
- My lab machines were effectively on two networks at once

That explained:
- Wrong subnet earlier
- IP conflicts now

---

### Final Fix – Network Isolation

To fix it, I:

- Moved all VMs to a **custom LAN segment**
- Removed VMware NAT from the equation entirely
- Rebooted the client
- Renewed DHCP again

![VMware LAN Isolation](../Evidence/Infrastructure/VMware_Internal_LAN_Segment_Isolation.png)
![VMware NAT Conflict](../Evidence/Infrastructure/VMware_NAT_Configuration_Conflict.png)

After that:
- DHCP came from DC01 only
- No more conflicts
- Client pulled `192.168.10.101` correctly

---

## DNS Implementation & Troubleshooting

### Issue – DNS Not Resolving Properly

Even after DHCP was working, DNS didn’t behave consistently.

Some lookups worked, others didn’t.

I suspected:
- stale records
- or DNS service issues

---

### Fix – Reset DNS + Re-register

I ran:

`Stop-Service DNS`  
`ipconfig /flushdns`  
`Start-Service DNS`  
`ipconfig /registerdns`

![DNS Reset](../Evidence/Validation/PowerShell_DNS_Reset_Script.png)

---

### DNS Forwarders

Then I configured forwarders so the DC could resolve external domains:

- 8.8.8.8  
- 1.1.1.1  

![DNS Forwarders](../Evidence/Networking/DNS_Forwarders_Validated.png)

---

### Validation

I verified everything using:

`nslookup dc01`  
`nslookup 192.168.10.10`

![NSLookup Validation](../Evidence/Validation/NSLookup_Internal_External_Success.png)

Now:
- Internal resolution works
- Reverse lookup works
- External resolution works

---

## Final Validation

At the end:

- IP = `192.168.10.101`  
- DHCP = `192.168.10.10`  
- DNS = `192.168.10.10`  
- Gateway = `192.168.10.1`  

![Final DHCP Success](../Evidence/Validation/Final_VIP_Workstation_IP_Verification.png)

---

## Key Takeaways

- Proper IP planning is critical before deployment  
- Virtual environments can introduce hidden network conflicts  
- DHCP and DNS must be tightly controlled in enterprise environments  
- Troubleshooting is as important as initial configuration  
- Network isolation is essential for lab accuracy and stability  

---

## Next Steps (Planned)

- DNS Forwarders validation refinement  
- Routing table analysis (`route print`)  
- Network path verification (`tracert`)  
- ARP table validation (`arp -a`)  
- Recursive vs Iterative DNS concepts 
