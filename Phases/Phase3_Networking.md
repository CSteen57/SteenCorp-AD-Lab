# Phase 3 – Networking & Domain Connectivity

## Objective

Configure and validate the core networking services for the SteenCorp domain environment, including IP addressing, DHCP, DNS, and client connectivity.

This phase focused on making sure the Windows Server domain controller and Windows 11 client could communicate correctly on the lab network, while also troubleshooting real network issues caused by virtualization settings and DHCP conflicts.

---

## Overview

Phase 3 moved the lab beyond basic Active Directory setup and into network service validation.

The goal was to make the environment behave like a controlled internal business network where the domain controller provides core services for client machines.

Key areas covered:

- IP addressing plan
- Static IP configuration for DC01
- DHCP scope creation
- DHCP reservation testing
- DNS forward and reverse lookup configuration
- DNS forwarders
- Client IP validation
- VMware network troubleshooting
- DHCP conflict troubleshooting
- Final domain connectivity validation

This phase became one of the most important parts of the lab because several issues appeared that required actual troubleshooting instead of just following a setup checklist.

---

## IP Addressing Scheme

I planned the lab network before configuring DHCP so the environment would have a predictable structure.

| Category | Range | Purpose |
|---|---|---|
| Network | `192.168.10.0/24` | Lab subnet |
| Gateway | `192.168.10.1` | Default gateway |
| Core Infrastructure | `192.168.10.2–10` | Domain Controller, DNS, DHCP |
| Server Tier | `192.168.10.11–20` | Reserved for future servers |
| Static Range | `192.168.10.21–99` | Reserved static assignments |
| DHCP Range | `192.168.10.100–200` | Client workstation leases |

The domain controller was assigned a static IP address so clients could reliably use it for DNS and DHCP services.

---

## Domain Controller Network Configuration

DC01 was configured with a static IP address.

Expected DC01 configuration:

| Setting | Value |
|---|---|
| IP Address | `192.168.10.10` |
| DNS Server | `192.168.10.10` |
| Role | Domain Controller, DNS, DHCP |

![DC01 Static IP](../Evidence/Infrastructure/DC01_Static_IP_Configuration.png)

---

## DHCP Deployment

I configured DHCP on DC01 so Windows client machines could automatically receive valid IP addresses from the lab network.

The DHCP scope was created for the client range:

```text
192.168.10.100–192.168.10.200
```

![DHCP Scope](../Evidence/Networking/DHCP_Scope_Exclusion_Pool.png)

---

## DNS Configuration

DNS was configured to support the Active Directory domain and allow internal hostname resolution.

Configured zones:

- Forward Lookup Zone: `steencorp.local`
- Reverse Lookup Zone: `192.168.10.0/24`

The reverse lookup zone allowed IP addresses to resolve back to hostnames, which helped validate DNS from both directions.

![DNS Reverse Lookup](../Evidence/Networking/DNS_Reverse_Lookup_PTR_Record.png)

---

## DHCP Reservation

I also configured a DHCP reservation for a workstation to simulate a common business use case where a specific device needs to keep the same IP address.

![DHCP Reservation](../Evidence/Networking/Windows_Server_DHCP_Reservation_Config.png)

---

# Issue 1 – Client Received the Wrong IP Address

During testing, the Windows client received an unexpected IP address in this range:

```text
192.168.217.x
```

This was not part of the planned SteenCorp subnet.

Expected subnet:

```text
192.168.10.0/24
```

The incorrect address showed that the client was receiving DHCP from the wrong source.

![VMware Conflict](../Evidence/Validation/DHCP_Validation_VMware_Conflict.png)

---

## Troubleshooting Steps

I started with basic DHCP troubleshooting from the client:

```cmd
ipconfig /release
ipconfig /renew
ipconfig /all
```

During troubleshooting, I found that the client adapter configuration was not behaving as expected and the workstation was not cleanly receiving its address from the SteenCorp DHCP scope.

![Static Adapter Issue](../Evidence/Validation/DHCP_Validation_Fail_Static_Adapter.png)

---

# Issue 2 – DHCP IP Conflict

While validating DHCP, the DHCP server detected a conflict involving:

```text
192.168.10.101
```

The DHCP console showed a `BAD_ADDRESS` entry.

This indicated that the DHCP server detected an address conflict and quarantined the address instead of assigning it normally.

![DHCP Conflict](../Evidence/Networking/DHCP_IP_Conflict_Detection.png)

![BAD ADDRESS](../Evidence/Networking/DHCP_Server_Bad_Address_Quarantine.png)

---

## Root Cause

The DHCP and addressing issues were caused by virtualization network configuration.

Root causes included:

- VMware NAT networking was still active
- A secondary DHCP source was present
- The client was not isolated to the intended lab network
- Multiple virtual networks were interfering with the SteenCorp DHCP scope

This created a realistic troubleshooting scenario where the server-side DHCP configuration was not the only thing that mattered. The virtual network underneath the lab also had to be configured correctly.

---

## Solution – Network Isolation

To resolve the conflict, I moved the lab onto an isolated internal VMware LAN segment.

This allowed DC01 to become the controlled DHCP and DNS source for the lab network.

Actions taken:

- Switched the lab to an internal LAN segment
- Removed VMware NAT DHCP interference
- Renewed the client DHCP lease
- Confirmed the client received an address from the correct subnet

![LAN Isolation](../Evidence/Infrastructure/VMware_Internal_LAN_Segment_Isolation.png)

![NAT Conflict](../Evidence/Infrastructure/VMware_NAT_Configuration_Conflict.png)

---

## DHCP Result

After isolating the network and renewing the lease, DHCP worked as intended.

Final DHCP result:

| Setting | Value |
|---|---|
| Client IP | `192.168.10.101` |
| DHCP Server | `192.168.10.10` |
| DNS Server | `192.168.10.10` |
| Subnet | `192.168.10.0/24` |

At this point, DC01 was correctly handling DHCP for the client workstation.

---

# DNS Troubleshooting

After DHCP was working, I still needed to validate DNS.

DNS resolution was inconsistent during testing, so I restarted and refreshed DNS-related services and records.

Commands used:

```powershell
Stop-Service DNS
ipconfig /flushdns
Start-Service DNS
ipconfig /registerdns
```

![DNS Reset](../Evidence/Validation/PowerShell_DNS_Reset_Script.png)

---

## DNS Forwarders

DNS forwarders were configured so DC01 could forward external DNS requests.

Configured forwarders:

- `8.8.8.8`
- `1.1.1.1`

![DNS Forwarders](../Evidence/Networking/DNS_Forwarders_Validated.png)

---

## DNS Validation

I validated DNS by testing both hostname and reverse lookup behavior.

Commands used:

```cmd
nslookup dc01
nslookup 192.168.10.10
```

Successful DNS validation confirmed that the client could resolve the domain controller by name and that the reverse lookup record was working.

![NSLookup](../Evidence/Validation/NSLookup_Internal_External_Success.png)

---

## Final Network State

The final workstation network configuration matched the intended lab design.

| Setting | Value |
|---|---|
| Client IP | `192.168.10.101` |
| DHCP Server | `192.168.10.10` |
| DNS Server | `192.168.10.10` |
| Default Gateway | `192.168.10.1` |
| Domain | `steencorp.local` |

![Final Validation](../Evidence/Validation/Final_VIP_Workstation_IP_Verification.png)

---

## Validation Summary

Final validation confirmed:

- DC01 had a static IP address
- DHCP scope was configured
- Client received an IP from the correct DHCP range
- VMware NAT DHCP interference was removed
- DHCP conflict detection was observed and documented
- DNS forward lookup was configured
- DNS reverse lookup was configured
- DNS forwarders were configured
- Client workstation used DC01 for DNS
- The lab network was ready for later security and help desk troubleshooting scenarios

---

## Why This Matters

This phase showed that Active Directory depends heavily on healthy networking.

Even when the domain controller, users, and policies are configured correctly, the environment can still fail if DHCP, DNS, or virtual networking are misconfigured.

The issues in this phase also helped support later help desk scenarios, especially DNS and hostname troubleshooting.

---

## Outcome

By the end of Phase 3, the SteenCorp lab had a stable internal network foundation.

Completed outcome:

- Planned IP addressing scheme implemented
- DC01 configured with a static IP
- DHCP deployed and validated
- DHCP reservation configured
- DNS forward and reverse lookup configured
- DNS forwarders configured
- VMware NAT DHCP conflict identified
- Network isolation implemented
- Client workstation received the correct DHCP lease
- Final network settings validated from the client side

---

## Key Takeaways

- IP planning is important before building network services
- Active Directory depends heavily on DNS
- DHCP must come from the correct source
- Virtual environments can create hidden networking conflicts
- `BAD_ADDRESS` entries can indicate DHCP conflict detection
- DNS should be validated from the client side, not just from the server
- Network isolation helps create a controlled lab environment
- Troubleshooting DHCP and DNS builds real help desk and network support skills
