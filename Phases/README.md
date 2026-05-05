# SteenCorp Lab – Phase Breakdown

This directory contains the phase-by-phase buildout of the SteenCorp Enterprise IT Lab.

Each phase represents a different layer of the environment, starting with the Active Directory foundation and progressing into access control, Group Policy, networking, security, and enterprise controls.

---

## Phase Navigation

### Phase 1 – Foundation & Environment Setup

📄 [View Phase 1](./Phase%201)

Phase 1 established the core Windows domain environment.

Key focus areas:

- Windows Server 2022 Domain Controller deployment
- Active Directory Domain Services configuration
- `steencorp.local` domain creation
- Windows 11 domain-joined client setup
- Organizational Unit structure
- Security group creation
- PowerShell automation
- Bulk user provisioning

---

### Phase 2 – Access Control, Group Policy & Software Deployment

📄 [View Phase 2](./Phase%202/)

Phase 2 focused on controlling access to shared resources and managing workstations through Group Policy.

Key focus areas:

- Department-based security groups
- Role-Based Access Control
- NTFS and share permissions
- Mapped network drives
- GPO drive mapping
- OU placement troubleshooting
- Centralized software repository
- Google Chrome deployment through Group Policy
- Client-side validation across multiple users

---

### Phase 3 – Networking & Domain Connectivity

📄 [View Phase 3](./Phase%203)

Phase 3 focused on DHCP, DNS, IP addressing, and network troubleshooting inside the SteenCorp domain environment.

The original Phase 3 design used an isolated VMware LAN Segment to remove unwanted VMware DHCP interference and allow DC01 to act as the controlled DHCP/DNS source for the lab.

A later help desk ticket revealed that the isolated LAN Segment allowed internal domain connectivity but did not provide internet access for domain clients. The lab was updated after Ticket #006 to use VMware NAT-backed `VMnet8`, while keeping DC01 as the DHCP and DNS server.

Key focus areas:

- IP addressing design
- Static IP configuration for DC01
- DHCP scope deployment
- DHCP reservation testing
- DNS forward and reverse lookup configuration
- DNS forwarders
- VMware NAT/DHCP conflict troubleshooting
- Internal LAN segment isolation
- Post-ticket VMware NAT gateway correction
- DHCP Scope Option 003 Router update
- Client-side network and internet validation
  
---

### Phase 4 – Security & Enterprise Controls

📄 [View Phase 4](./Phase%204)

Phase 4 focused on improving security through administrative account separation, Group Policy security settings, and client-side validation.

Key focus areas:

- Dedicated administrative account creation
- Separation between standard and admin activity
- Domain Admin membership validation
- Account lockout policy
- Login security banner
- Workstation lock policy
- UAC/admin elevation testing
- Account lockout and recovery workflow
- Security validation from the client side

---

## How to Read This Lab

For the full build process, start with **Phase 1** and move through each phase in order.

For specific skill areas:

| Skill Area | Recommended Phase |
|---|---|
| Active Directory foundation | Phase 1 |
| PowerShell automation | Phase 1 |
| User/group structure | Phase 1 and Phase 2 |
| RBAC and permissions | Phase 2 |
| Group Policy troubleshooting | Phase 2 |
| Software deployment | Phase 2 |
| DHCP, DNS, and IP addressing | Phase 3 |
| Network troubleshooting | Phase 3 |
| Security controls | Phase 4 |
| Account lockout testing | Phase 4 |

---

## Project Flow

The phases build on each other:

```text
Phase 1: Build the domain foundation
↓
Phase 2: Add access control, GPOs, mapped drives, and software deployment
↓
Phase 3: Configure and validate DHCP, DNS, and network connectivity
↓
Phase 4: Add security controls and administrative separation
```

Together, these phases created the reusable SteenCorp domain environment used for later support and troubleshooting projects.

---

## Related Follow-Up Project

After completing this lab, I used the same SteenCorp domain environment to build a help desk simulation project.

📄 [SteenDesk Help Desk Simulation](https://github.com/CSteen57/SteenDesk_Help_Desk_Simulation)

The help desk project builds on this lab by using the same domain, users, groups, shared folders, DNS configuration, and Windows workstation environment to simulate real support tickets.

The help desk project also created a documented infrastructure change. Ticket #006 identified that the original isolated LAN Segment supported internal domain communication but did not provide a working internet route for clients. The environment was updated to VMware NAT-backed `VMnet8`, with DC01 remaining the DHCP/DNS server and VMware DHCP disabled.
Example scenarios include:

- Shared drive access issues
- Account lockouts
- Password resets
- DNS and hostname resolution issues
- Approved software installation
- Least privilege validation

---

## Notes

This lab is designed as a modular enterprise-style environment.

That means:

- Each phase builds on the previous phase
- Later help desk tickets may reveal infrastructure improvements that are documented back into the original lab
- Ticket #006 updated the lab from isolated LAN-only connectivity to VMware NAT-backed client internet access
- The domain environment can be reused for future projects
- Issues were documented as part of the learning process
- Validation was performed from both the server side and client side
- Future networking, security, SIEM, VPN, and help desk projects can expand from this foundation
