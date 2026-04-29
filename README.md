# SteenCorp Enterprise IT Lab

> Hands-on enterprise IT lab demonstrating Active Directory, networking, security, and real-world troubleshooting.

---

## Overview

The SteenCorp AD Lab is a simulated enterprise IT environment designed to replicate real-world infrastructure and support scenarios.

This project was built to bridge the gap between certification knowledge and practical, hands-on experience in system administration, networking, and security.

---

## Lab Design Philosophy

The environment was built as a reusable domain infrastructure rather than a one-off lab.

This allows additional scenarios to be layered on top of the same system, including:

- Network diagnostics and troubleshooting  
- Help desk and user support workflows  
- Security testing and policy enforcement  
- Future infrastructure and service expansion  

This approach reflects how real enterprise environments are continuously developed and maintained.

---


## Key Skills Demonstrated

- Active Directory Domain Services (AD DS)
- Organizational Unit (OU) design and automation
- Role-Based Access Control (RBAC)
- Group Policy (GPO) configuration and enforcement
- DNS and DHCP configuration
- Network troubleshooting and validation
- Privileged identity management
- Workstation security hardening

---

## Environment

- Windows Server 2022 (Domain Controller – DC01)
- Windows 11 (Domain-Joined Client)
- VMware Workstation

---

## Project Roadmap

| Phase | Status | Focus | Outcome |
|------|--------|------|--------|
| Phase 1: Foundation | Completed | Domain setup, AD DS, virtualization | Built a fully functional domain environment |
| Phase 2: RBAC & GPO | Completed | Access control, drive mapping, policy enforcement | Implemented and validated RBAC with real troubleshooting |
| Phase 3: Networking & Troubleshooting | Completed | DNS, DHCP, IP management, issue resolution | Configured and validated core network services |
| Phase 4: Security & Enterprise Controls | Completed | Identity management, GPO security, workstation hardening | Implemented enterprise-level security controls and validation |

---

## Architecture Summary

- Single domain: `steencorp.local`
- Centralized Domain Controller (DC01)
- Domain-joined Windows 11 client
- Internal network segmentation via VMware
- Centralized authentication and policy management

---

## Key Highlights

### Centralized Identity & Access Control
- Department-based RBAC using security groups
- Users restricted to only their assigned resources
- Permissions enforced through Group Policy

---

### Real-World Troubleshooting

- Resolved DHCP conflicts caused by VMware NAT
- Diagnosed incorrect IP assignments and BAD_ADDRESS conflicts
- Fixed GPO deployment issues caused by incorrect OU placement

---

### Security Implementation

- Dedicated administrative account (tiered admin model)
- Account lockout policies enforced
- Login banner and workstation hardening applied
- Privilege separation between standard and admin accounts

---

## Sample Validation

### RBAC Enforcement
Users can only access their assigned department drives.

![Mapped Drives](./Evidence/Validation/V3_Final_Operational_Success%20_2.png)

---

### Network Validation

Verified DHCP and DNS configuration from client:

![Network Validation](./Evidence/Validation/Final_VIP_Workstation_IP_Verification.png)

---

### Security Enforcement

Account lockout triggered and resolved through admin intervention.

![Account Lockout](./Evidence/Validation/Account_Lockout_Triggered.png)

---

## Project Structure

- [Phase 1 – Foundation & Environment Setup](./Phase1_Foundation.md)  
- [Phase 2 – RBAC & GPO Implementation](./Phase2_RBAC.md)  
- [Phase 3 – Networking & Troubleshooting](./Phase3_Networking.md)  
- [Phase 4 – Security & Enterprise Controls](./Phase4_Security.md)  

---

## What I Learned

- Building systems is only part of IT — troubleshooting is critical  
- Group Policy and OU structure directly impact system behavior  
- Virtual environments can introduce real-world networking issues  
- Security must be implemented and validated, not assumed  

---

## Future Development

This environment is designed to serve as a long-term foundation for additional labs and real-world scenarios.

Future expansions will build on this domain and be documented as separate projects, including:

- Network Diagnostics Lab (tracert, routing, ARP analysis)
- Help Desk Simulation Lab (user issues, permissions, troubleshooting workflows)
- Security Expansion (AppLocker, auditing, logging, policy enforcement)
- Additional infrastructure services and enterprise scenarios

As new labs are developed, they will be linked here to demonstrate continued growth and practical experience.
