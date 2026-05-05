# Phase 3 – Networking & Domain Connectivity

## Objective

Configure and validate the core networking services for the SteenCorp domain environment, including IP addressing, DHCP, DNS, internal domain connectivity, and client internet access.

This phase focused on making sure the Windows Server domain controller and Windows 11 domain clients could communicate correctly on the lab network while also troubleshooting real network issues caused by virtualization settings, DHCP conflicts, DNS behavior, and VMware NAT routing.

## Key Takeaways

- IP planning is important before building network services
- Active Directory depends heavily on DNS
- DHCP must come from the correct source
- Virtual environments can create hidden networking conflicts
- `BAD_ADDRESS` entries can indicate DHCP conflict detection
- DNS should be validated from the client side, not just from the server
- A working internal domain network does not automatically mean clients have a valid internet route
- VMware NAT can provide the upstream gateway while DC01 continues handling DHCP and DNS
- DHCP Scope Option 003 controls the gateway clients receive
- Help desk tickets can expose infrastructure design gaps that should be documented back into the original lab
- Troubleshooting DHCP, DNS, and routing builds real help desk and network support skills
- A stable IP, DNS, DHCP, and gateway foundation is required before adding more advanced segmentation or access control concepts

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
- Internal domain connectivity validation
- Post-build internet connectivity remediation after SteenDesk Ticket #006

This phase became one of the most important parts of the lab because several issues appeared that required actual troubleshooting instead of simply following a setup checklist.

---

## Network Design Summary

The SteenCorp lab uses a single flat domain network for the original Active Directory environment.

| Component | Current Design |
|---|---|
| Domain | `steencorp.local` |
| Domain Controller | `DC01` |
| DC01 IP Address | `192.168.10.10` |
| Subnet | `192.168.10.0/24` |
| DHCP Server | `192.168.10.10` |
| DNS Server | `192.168.10.10` |
| Current Default Gateway | `192.168.10.2` |
| VMware Network | NAT-backed `VMnet8` |
| VMware DHCP | Disabled |
| Client DHCP Range | `192.168.10.100–192.168.10.200` |

DC01 remains the authoritative DHCP and DNS server for the SteenCorp domain. VMware provides the upstream NAT gateway only.

---

## IP Addressing Scheme

I planned the lab network before configuring DHCP so the environment would have a predictable structure.

| Category | Range / Value | Purpose |
|---|---|---|
| Network | `192.168.10.0/24` | SteenCorp lab subnet |
| Original Planned Gateway | `192.168.10.1` | Initial default gateway value used during the internal-only design |
| Current VMware NAT Gateway | `192.168.10.2` | Validated VMware NAT gateway after Ticket #006 |
| Domain Controller | `192.168.10.10` | DC01, DNS, DHCP |
| Server Tier | `192.168.10.11–20` | Reserved for future servers |
| Static Range | `192.168.10.21–99` | Reserved static assignments |
| DHCP Range | `192.168.10.100–200` | Client workstation leases |

The domain controller was assigned a static IP address so clients could reliably use it for DNS and DHCP services.

> Note: The original Phase 3 design used `192.168.10.1` as the planned default gateway. During SteenDesk Ticket #006, VMware NAT settings confirmed that the active VMware NAT gateway for the corrected `VMnet8` network was `192.168.10.2`. The subnet, DC01 IP, DNS design, and DHCP client range remained unchanged.

> Note: This Phase 3 design represents the original SteenCorp internal/domain network before VLAN segmentation was introduced. The `192.168.10.0/24` subnet later became the trusted Corporate LAN in the separate SteenCorp Network Segmentation Lab. In that follow-up project, additional networks were added for Guest devices and Internal Servers using `192.168.20.0/24` and `192.168.30.0/24`.

---

## Domain Controller Network Configuration

DC01 was configured with a static IP address.

Current DC01 configuration:

| Setting | Value |
|---|---|
| IP Address | `192.168.10.10` |
| Subnet Mask | `255.255.255.0` |
| Default Gateway | `192.168.10.2` |
| Preferred DNS | `127.0.0.1` |
| Role | Domain Controller, DNS, DHCP |

The server uses itself for DNS because Active Directory depends on internal DNS. External DNS resolution is handled through DNS forwarders, not by placing public DNS directly on client workstations.

![DC01 Static IP](../../Evidence/Infrastructure/DC01_Static_IP_Configuration.png)

---

## DHCP Deployment

I configured DHCP on DC01 so Windows client machines could automatically receive valid IP addresses from the lab network.

The DHCP scope was created for the client range:

```text
192.168.10.100–192.168.10.200
```

Current DHCP design:

| DHCP Setting | Value |
|---|---|
| DHCP Server | `192.168.10.10` |
| Scope Network | `192.168.10.0/24` |
| Client Range | `192.168.10.100–192.168.10.200` |
| Option 003 Router | `192.168.10.2` |
| Option 006 DNS Server | `192.168.10.10` |
| Option 015 DNS Domain Name | `steencorp.local` |
| VMware DHCP | Disabled |

![DHCP Scope](../../Evidence/Networking/DHCP_Scope_Exclusion_Pool.png)

---

## DNS Configuration

DNS was configured to support the Active Directory domain and allow internal hostname resolution.

Configured zones:

- Forward Lookup Zone: `steencorp.local`
- Reverse Lookup Zone: `192.168.10.0/24`

The reverse lookup zone allowed IP addresses to resolve back to hostnames, which helped validate DNS from both directions.

![DNS Reverse Lookup](../../Evidence/Networking/DNS_Reverse_Lookup_PTR_Record.png)

---

## DHCP Reservation

I also configured a DHCP reservation for a workstation to simulate a common business use case where a specific device needs to keep the same IP address.

![DHCP Reservation](../../Evidence/Networking/Windows_Server_DHCP_Reservation_Config.png)

---

## Issue 1 – Client Received the Wrong IP Address

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

![VMware Conflict](../../Evidence/Validation/DHCP_Validation_VMware_Conflict.png)

---

## Troubleshooting Steps

I started with basic DHCP troubleshooting from the client:

```cmd
ipconfig /release
ipconfig /renew
ipconfig /all
```

During troubleshooting, I found that the client adapter configuration was not behaving as expected and the workstation was not cleanly receiving its address from the SteenCorp DHCP scope.

![Static Adapter Issue](../../Evidence/Validation/DHCP_Validation_Fail_Static_Adapter.png)

---

## Issue 2 – DHCP IP Conflict

While validating DHCP, the DHCP server detected a conflict involving:

```text
192.168.10.101
```

The DHCP console showed a `BAD_ADDRESS` entry.

This indicated that the DHCP server detected an address conflict and quarantined the address instead of assigning it normally.

![DHCP Conflict](../../Evidence/Networking/DHCP_IP_Conflict_Detection.png)

![BAD ADDRESS](../../Evidence/Networking/DHCP_Server_Bad_Address_Quarantine.png)

---

## Root Cause – DHCP Conflict

The DHCP and addressing issues were caused by virtualization network configuration.

Root causes included:

- VMware NAT networking was still active
- A secondary DHCP source was present
- The client was not isolated to the intended lab network
- Multiple virtual networks were interfering with the SteenCorp DHCP scope

This created a realistic troubleshooting scenario where the server-side DHCP configuration was not the only thing that mattered. The virtual network underneath the lab also had to be configured correctly.

---

## Solution Stage 1 – Network Isolation

To resolve the DHCP conflict, I originally moved the lab onto an isolated internal VMware LAN Segment.

This allowed DC01 to become the controlled DHCP and DNS source for the lab network.

Actions taken:

- Switched the lab to an internal LAN Segment
- Removed VMware NAT DHCP interference
- Renewed the client DHCP lease
- Confirmed the client received an address from the correct subnet
- Confirmed DC01 was handling DHCP and DNS for the client workstation

![LAN Isolation](../../Evidence/Infrastructure/VMware_Internal_LAN_Segment_Isolation.png)

![NAT Conflict](../../Evidence/Infrastructure/VMware_NAT_Configuration_Conflict.png)

This solved the DHCP conflict and created a stable internal domain network. However, the isolated LAN Segment did not provide a working internet route for domain clients. That limitation was later discovered and corrected during SteenDesk Ticket #006.

---

## DHCP Result After Initial Isolation

After isolating the network and renewing the lease, DHCP worked as intended.

Initial DHCP result:

| Setting | Value |
|---|---|
| Client IP | `192.168.10.101` |
| DHCP Server | `192.168.10.10` |
| DNS Server | `192.168.10.10` |
| Subnet | `192.168.10.0/24` |

At this point, DC01 was correctly handling DHCP for the client workstation.

---

## DNS Troubleshooting

After DHCP was working, I still needed to validate DNS.

DNS resolution was inconsistent during testing, so I restarted and refreshed DNS-related services and records.

Commands used:

```powershell
Stop-Service DNS
ipconfig /flushdns
Start-Service DNS
ipconfig /registerdns
```

![DNS Reset](../../Evidence/Validation/PowerShell_DNS_Reset_Script.png)

---

## DNS Forwarders

DNS forwarders were configured so DC01 could forward external DNS requests.

Configured forwarders:

- `8.8.8.8`
- `1.1.1.1`

![DNS Forwarders](../../Evidence/Networking/DNS_Forwarders_Validated.png)

---

## DNS Validation

I validated DNS by testing both hostname and reverse lookup behavior.

Commands used:

```cmd
nslookup dc01
nslookup 192.168.10.10
```

Successful DNS validation confirmed that the client could resolve the domain controller by name and that the reverse lookup record was working.

![NSLookup](../../Evidence/Validation/NSLookup_Internal_External_Success.png)

---

## Post-Phase Update – Ticket #006 Internet Connectivity Remediation

After Phase 3 was completed, the SteenDesk Help Desk Simulation introduced Ticket #006: Mike Ross could sign into the domain and reach internal resources, but could not access the internet.

Troubleshooting confirmed:

- The workstation received a valid DHCP lease from DC01
- The workstation used DC01 as its DNS server
- The workstation could ping DC01 at `192.168.10.10`
- `nslookup google.com` resolved through `dc01.steencorp.local`
- Ping to the configured gateway failed
- Ping to external IP `8.8.8.8` failed
- Google resolved to an IP address, but traffic could not route externally

This showed that DNS was working, but routing/NAT was failing.

### Ticket #006 Root Cause

The VMware review showed the cause:

| System | Adapter Configuration Before Ticket #006 Fix |
|---|---|
| DC01 | LAN Segment + separate NAT adapter |
| Workstation 1 | LAN Segment only |
| Workstation 2 | LAN Segment only |

DC01 had internet access through its own NAT adapter, but that did not automatically route internet access for client workstations.

Because DC01 was not configured as a router/NAT server, the domain clients had no valid internet path.

### Ticket #006 Network Correction

The lab was updated from an isolated LAN Segment to VMware NAT-backed `VMnet8`.

| Setting | Updated Value |
|---|---|
| VMware Network | `VMnet8` |
| VMware Network Type | NAT |
| VMware DHCP | Disabled |
| Lab Subnet | `192.168.10.0/24` |
| VMware NAT Gateway | `192.168.10.2` |
| DC01 Static IP | `192.168.10.10` |
| DC01 Role | DHCP and DNS |
| DHCP Option 003 Router | `192.168.10.2` |
| DHCP Option 006 DNS | `192.168.10.10` |

This preserved the original lab subnet and DC01 services while adding working internet access for domain clients.

### Ticket #006 Validation

Validation after the Ticket #006 correction confirmed:

- DC01 could reach the VMware NAT gateway
- DC01 could reach external IP `8.8.8.8`
- DC01 could resolve and ping `google.com`
- Mike Ross's workstation received gateway `192.168.10.2`
- Mike Ross's workstation continued using DC01 for DNS
- Mike Ross's workstation could reach internal and external resources
- Browser internet access worked from Mike Ross's workstation
- Workstation 2 was also validated to confirm the fix applied beyond one user
- A secondary manual DNS issue on Workstation 2 was found and corrected
- Browser internet access worked from both tested workstations


Related Help Desk Ticket:

[SteenDesk Ticket #006 – Mike Ross Cannot Access Internet](https://github.com/CSteen57/SteenDesk_Help_Desk_Simulation/blob/main/Helpdesk_Tickets/Tickets/Ticket006_Mike_Ross_Cannot_Access_Internet.md)

---

## Current Final Network State

The original Phase 3 final state validated internal domain networking. After Ticket #006, the network was updated to support both internal domain connectivity and external internet access.

| Setting | Value |
|---|---|
| Client IP Example | `192.168.10.101` |
| DHCP Server | `192.168.10.10` |
| DNS Server | `192.168.10.10` |
| Default Gateway | `192.168.10.2` |
| Domain | `steencorp.local` |
| VMware Network | NAT-backed `VMnet8` |
| VMware DHCP | Disabled |

The original planned gateway was `192.168.10.1`, but VMware NAT settings confirmed the active NAT gateway as `192.168.10.2` after the Ticket #006 remediation.

The screenshot below shows the original internal DHCP/DNS validation from Phase 3. The final gateway value was later updated during Ticket #006.

![Final Validation](../../Evidence/Validation/Final_VIP_Workstation_IP_Verification.png)

---

## Validation Summary

Final validation confirmed:

- DC01 had a static IP address
- DHCP scope was configured
- Client received an IP from the correct DHCP range
- VMware NAT DHCP interference was identified
- DHCP conflict detection was observed and documented
- DNS forward lookup was configured
- DNS reverse lookup was configured
- DNS forwarders were configured
- Client workstation used DC01 for DNS
- The original isolated LAN Segment supported controlled internal domain communication
- Ticket #006 later identified that the isolated LAN Segment did not provide client internet access
- The lab was updated to VMware NAT-backed `VMnet8`
- VMware DHCP remained disabled
- DC01 remained the DHCP and DNS server
- DHCP Scope Option 003 Router was updated to `192.168.10.2`
- Domain clients could reach both internal domain resources and external internet resources
- The lab network was ready for later security and help desk troubleshooting scenarios
- The network foundation later expanded into a separate Packet Tracer segmentation lab
- VLAN segmentation and guest isolation concepts were documented in a follow-up networking project

---

## Relationship to Network Segmentation Lab

Phase 3 established the original SteenCorp internal network using the `192.168.10.0/24` subnet.

That network later became the trusted Corporate LAN in the separate SteenCorp Network Segmentation Lab.

| Design Stage | Network | Subnet | Purpose |
|---|---|---|---|
| Phase 3 Domain Network | Flat domain network | `192.168.10.0/24` | Original domain network for DC01 and domain clients |
| Segmentation Lab | Corporate was ready for later security and help desk troubleshooting scenarios
- The network foundation later expanded into a separate Packet Tracer segmentation lab
- VLAN segmentation and guest isolation VLAN 10 | `192.168.10.0/24` | Trusted employee/domain network |
| Segmentation Lab | Guest VLAN 20 | `192.168.20.0/24` | Isolated guest/untrusted network |
| Segmentation Lab | Server VLAN 30 | `192.168.30.0/24` | Internal server network |

The segmentation lab does not replace the Phase 3 network design. It expands the same foundation into a more secure segmented model using VLANs, trunking, router-on-a-stick, and ACL-based guest isolation.

Related project:

[SteenCorp Network Segmentation Lab](https://github.com/CSteen57/SteenCorp_Network_Segmentation_Lab)

---

## Why This Matters

This phase showed that Active Directory depends heavily on healthy networking.

Even when the domain controller, users, and policies are configured correctly, the environment can still fail if DHCP, DNS, virtual networking, or routing are misconfigured.

The DHCP issue showed that a client can receive an address from the wrong source if the virtualization layer is not controlled.

The Ticket #006 internet issue showed that a working internal domain network does not automatically mean clients have a valid route to the internet.

This phase also helped support later help desk scenarios, especially DNS, hostname troubleshooting, gateway troubleshooting, and internet connectivity testing.

---

## Outcome

By the end of Phase 3 and the later Ticket #006 update, the SteenCorp lab had a stable internal network foundation with working internet access for domain clients.

Completed outcome:

- Planned IP addressing scheme implemented
- DC01 configured with a static IP
- DHCP deployed and validated
- DHCP reservation configured
- DNS forward and reverse lookup configured
- DNS forwarders configured
- VMware NAT DHCP conflict identified
- Network isolation implemented to stabilize DHCP/DNS
- Client workstation received the correct DHCP lease
- Internal domain network settings validated from the client side
- Later Ticket #006 identified missing internet routing from the isolated LAN Segment
- Lab network updated to VMware NAT-backed `VMnet8`
- VMware DHCP remained disabled
- DC01 remained the DHCP and DNS server
- DHCP Scope Option 003 Router updated to the validated VMware NAT gateway `192.168.10.2`
- Domain clients validated with both internal domain connectivity and external internet access
- Original `192.168.10.0/24` internal network later used as the trusted Corporate LAN in the Network Segmentation Lab
