# Phase 3 – Networking & Domain Connectivity (In Progress)

## Status
🚧 Currently in development

## Objective
Build and validate core networking functionality within the SteenCorp lab environment.

---

## SteenCorp IP Schema

Before implementation, a structured IP Address Management (IPAM) plan was created to simulate a real-world enterprise network design.

| Category              | Range / Address        | Purpose                                  |
|----------------------|----------------------|------------------------------------------|
| Network              | 192.168.10.0/24      | Core lab subnet (254 usable addresses)   |
| Gateway              | 192.168.10.1         | Default gateway (VMware virtual router)  |
| Core Infrastructure  | 192.168.10.2–10      | Domain Controllers, DNS Servers          |
| Server Tier          | 192.168.10.11–20     | File, Print, and Application Servers     |
| Static Range         | 192.168.10.21–50     | Reserved for infrastructure devices      |
| DHCP Range           | 192.168.10.100–200   | Dynamic allocation for client machines   |

### Design Notes
- Infrastructure devices use static IPs to ensure consistent availability  
- Clients receive IP addresses dynamically via DHCP  
- DNS is centralized on the Domain Controller for domain resolution  
- Subnetting follows a structured allocation model to support scalability  

---

## Implementation

- Assigned static IP configuration to Domain Controller (DC01)  
- Configured DNS role for internal domain resolution  
- Deployed DHCP service with controlled address scope  
- Defined IP exclusions to protect infrastructure devices  
- Configured Windows 11 client for DHCP-based addressing  

---

## DHCP Deployment & Conflict Resolution

During implementation, a critical networking issue was encountered where VMware’s built-in DHCP service was assigning IP addresses outside of the intended SteenCorp subnet.

### Issue Identified
- Client received IP: `192.168.217.x` (VMware NAT network)  
- Expected subnet: `192.168.10.0/24`  
- Result: Client could not properly communicate with domain services  

### Root Cause
- VMware DHCP service was active and overriding intended network configuration  
- Domain Controller DHCP scope was not being utilized  

---

### Resolution Steps

1. **Configured Static IP on Domain Controller (DC01)**
   - IP Address: `192.168.10.10`  
   - Subnet Mask: `255.255.255.0`  
   - Gateway: `192.168.10.1`  
   - DNS: `127.0.0.1`  

2. **Configured DHCP Scope on DC01**
   - Scope Range: `192.168.10.100 – 192.168.10.200`  
   - Exclusions: `192.168.10.1 – 192.168.10.99`  
   - Gateway: `192.168.10.1`  
   - DNS Server: `192.168.10.10`  

3. **Adjusted VMware Network Configuration**
   - Identified VMware DHCP conflict  
   - Ensured lab network used intended subnet instead of NAT range  

4. **Reconfigured Client Network Adapter**
   - Set to obtain IP address automatically (DHCP)  

5. **Validated DHCP Assignment**
   - Used:
     ```
     ipconfig /release
     ipconfig /renew
     ipconfig /all
     ```

---

### Final Result

- Client successfully received:
  - IP: `192.168.10.100`  
  - Gateway: `192.168.10.1`  
  - DNS: `192.168.10.10`  

- Domain communication restored  
- DHCP fully controlled by Domain Controller  

---

### Key Takeaways

- DHCP conflicts can silently break domain connectivity  
- Virtualization platforms introduce hidden networking layers  
- Proper IP planning prevents infrastructure overlap  
- Always validate:
  - IP address range  
  - Gateway  
  - DNS source  

---

## Validation

- Successful ping tests between client and Domain Controller  
- Verified DNS resolution and domain suffix assignment  
- Confirmed DHCP lease assignment from DC01  
- Validated domain authentication via `whoami` and login context  

---

## Summary

Phase 3 established the foundational networking layer of the SteenCorp environment.

The lab transitioned from isolated virtual machines into a structured, domain-connected network by assigning a static identity to the Domain Controller (DC01) and configuring it as the authoritative source for DNS and DHCP services.

A DHCP scope was implemented to dynamically assign IP addresses to client systems while reserving a protected range for infrastructure components. During this process, a conflict with VMware’s DHCP service was identified and resolved, reinforcing the importance of network control and validation.

The phase concluded with successful client-to-domain communication, verifying that the Windows 11 workstation was receiving proper network configuration and authentication services directly from the SteenCorp server.

---

## Upcoming Evidence
Screenshots and validation outputs will continue to be added as this phase is finalized.
