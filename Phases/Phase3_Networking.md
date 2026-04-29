# Phase 3 – Networking & Domain Connectivity

## Objective
Configure and validate DHCP and DNS services while troubleshooting real-world network issues.

---

## Overview

This phase transitions the lab into a fully networked environment.

Key implementations:
- Structured IP addressing
- DHCP deployment
- DNS configuration
- Real-world troubleshooting

---

## IP Addressing Scheme

| Category | Range | Purpose |
|--------|------|--------|
| Network | 192.168.10.0/24 | Lab subnet |
| Gateway | 192.168.10.1 | Default gateway |
| Core Infrastructure | 192.168.10.2–10 | DC, DNS |
| Server Tier | 192.168.10.11–20 | Future servers |
| Static Range | 192.168.10.21–99 | Reserved |
| DHCP Range | 192.168.10.100–200 | Clients |

---

## Implementation

### Domain Controller Configuration

![DC01 Static IP](../Evidence/Infrastructure/DC01_Static_IP_Configuration.png)

---

### DHCP Deployment

![DHCP Scope](../Evidence/Networking/DHCP_Scope_Exclusion_Pool.png)

---

### DNS Configuration

- Forward Lookup Zone: SteenCorp.local  
- Reverse Lookup Zone: 192.168.10.0/24  

![DNS Reverse Lookup](../Evidence/Networking/DNS_Reverse_Lookup_PTR_Record.png)

---

### DHCP Reservation

![DHCP Reservation](../Evidence/Networking/Windows_Server_DHCP_Reservation_Config.png)

---

## Issue 1 – DHCP Not Working

Client received IP:
192.168.217.x

Indicates:
- Wrong DHCP server  
- Network misconfiguration  

![VMware Conflict](../Evidence/Validation/DHCP_Validation_VMware_Conflict.png)

---

### Troubleshooting

- ipconfig /release  
- ipconfig /renew  

Discovered:
- Adapter was set to static  

![Static Adapter Issue](../Evidence/Validation/DHCP_Validation_Fail_Static_Adapter.png)

---

## Issue 2 – IP Conflict

- BAD_ADDRESS detected for 192.168.10.101  

Indicates DHCP conflict detection working properly.

![DHCP Conflict](../Evidence/Networking/DHCP_IP_Conflict_Detection.png)
![BAD ADDRESS](../Evidence/Networking/DHCP_Server_Bad_Address_Quarantine.png)

---

## Root Cause

- VMware NAT enabled  
- Secondary DHCP present  
- Multiple networks active  

---

## Solution – Network Isolation

- Switched to internal LAN segment  
- Removed NAT interference  
- Renewed DHCP  

![LAN Isolation](../Evidence/Infrastructure/VMware_Internal_LAN_Segment_Isolation.png)
![NAT Conflict](../Evidence/Infrastructure/VMware_NAT_Configuration_Conflict.png)

---

## Result

- DHCP handled by DC01  
- No conflicts  
- Valid IP assigned:
  192.168.10.101  

---

## DNS Issue

Resolution inconsistent.

---

## DNS Fix

Stop-Service DNS  
ipconfig /flushdns  
Start-Service DNS  
ipconfig /registerdns  

![DNS Reset](../Evidence/Validation/PowerShell_DNS_Reset_Script.png)

---

## DNS Forwarders

- 8.8.8.8  
- 1.1.1.1  

![DNS Forwarders](../Evidence/Networking/DNS_Forwarders_Validated.png)

---

## Validation

nslookup dc01  
nslookup 192.168.10.10  

![NSLookup](../Evidence/Validation/NSLookup_Internal_External_Success.png)

---

## Final Network State

- IP: 192.168.10.101  
- DHCP: 192.168.10.10  
- DNS: 192.168.10.10  
- Gateway: 192.168.10.1  

![Final Validation](../Evidence/Validation/Final_VIP_Workstation_IP_Verification.png)

---

## Key Takeaways

- IP planning is critical  
- Virtual environments can cause hidden conflicts  
- DHCP and DNS must be controlled  
- Network isolation is essential  
- Troubleshooting is a core skill  
