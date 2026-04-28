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

The Domain Controller (DC01) was assigned a static IP address to act as a stable and reliable network anchor.

![DC01 Static IP](../Evidence/Infrastructure/DC01_Static_IP_Configuration.png)

---

### DHCP Deployment

A DHCP scope was configured to dynamically assign IP addresses to client machines while protecting infrastructure ranges through exclusions.

![DHCP Scope](../Evidence/Networking/DHCP_Scope_Exclusion_Pool.png)

---

### DNS Configuration (Forward + Reverse Lookup)

A complete DNS structure was implemented to support both forward and reverse name resolution within the SteenCorp network.

- Forward Lookup Zone: `SteenCorp.local`
- Reverse Lookup Zone: `192.168.10.0/24`

This enables:
- Hostname → IP resolution
- IP → Hostname resolution

#### Reverse Lookup Zone Implementation

A Reverse Lookup Zone was created to support PTR (Pointer) records, enabling IP-based identification of hosts.

![DNS Reverse Lookup](../Evidence/Networking/DNS_Reverse_Lookup_PTR_Record.png)

---

### DHCP Reservation (Controlled Addressing)

A DHCP reservation was implemented to ensure the Windows 11 workstation consistently receives the same IP address while still using DHCP.

- Reserved IP: `192.168.10.101`
- Bound to client MAC address

This reflects real-world enterprise environments where predictable addressing is required without sacrificing centralized control.

![DHCP Reservation](../Evidence/Networking/Windows_Server_DHCP_Reservation_Config.png)

---

## Issues & Troubleshooting

### VMware DHCP Conflict

During initial testing, the client machine received an incorrect IP address from VMware’s internal DHCP service (192.168.217.x range), instead of the intended SteenCorp network.

This resulted in:
- Incorrect subnet assignment
- Improper DNS configuration
- Failed communication with the Domain Controller

![VMware DHCP Conflict](../Evidence/Validation/DHCP_Validation_VMware_Conflict.png)

---

### DHCP Renewal Failure

An attempt to renew the IP configuration failed because the client adapter was still configured with a static IP.

This prevented DHCP from issuing a valid lease.

![DHCP Renewal Failure](../Evidence/Validation/DHCP_Validation_Fail_Static_Adapter.png)

---

### IP Conflict & BAD_ADDRESS Detection

During DHCP testing, an IP conflict was detected and marked as a **BAD_ADDRESS** within the DHCP scope.

This indicated:
- Duplicate IP detection by DHCP
- Network interference from VMware NAT configuration

![DHCP Conflict Detection](../Evidence/Networking/DHCP_IP_Conflict_Detection.png)

![BAD ADDRESS](../Evidence/Networking/DHCP_Server_Bad_Address_Quarantine.png)

---

## Resolution

The networking conflict was resolved through a structured troubleshooting process:

- Identified VMware NAT as an external DHCP source
- Isolated the lab using a dedicated LAN Segment
- Eliminated competing DHCP broadcasts
- Reconfigured client adapter for DHCP
- Implemented DHCP reservation for consistency

### VMware Network Isolation

The lab environment was moved to an internal LAN segment to simulate an isolated enterprise network.

![VMware LAN Isolation](../Evidence/Infrastructure/VMware_Internal_LAN_Segment_Isolation.png)

![VMware NAT Conflict](../Evidence/Infrastructure/VMware_NAT_Configuration_Conflict.png)

---

## Validation (Current State)

### Final Network State Verification

After full troubleshooting and reconfiguration, the network reached a stable and functional state.

Key validation results:

- Client receives IP from DHCP scope (`192.168.10.101`)
- DHCP Server = `192.168.10.10 (DC01)`
- DNS Server = `192.168.10.10`
- Gateway = `192.168.10.1`
- No duplicate IP conflicts
- Domain communication confirmed

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

The following enhancements will complete Phase 3:

- DNS Forwarders configuration (external resolution)
- Reverse lookup validation via nslookup
- Routing table analysis using `route print`
- Network path verification using `tracert`
- ARP table validation (`arp -a`)
- Advanced DHCP validation and monitoring

Additional validation and evidence will be added as these components are implemented.
