## Overview

The SteenCorp Enterprise IT Lab is a simulated business IT environment designed to replicate real-world infrastructure and support scenarios.

This project was built to bridge the gap between certification knowledge and practical, hands-on experience in system administration, networking, identity management, security, and workstation support.

The lab is built around a reusable Windows domain environment that can continue expanding into future help desk, networking, security, and remote access projects.

---

## What This Project Demonstrates

This lab showcases hands-on experience with:

- Active Directory Domain Services (AD DS)
- Organizational Unit (OU) design
- Group Policy (GPO) configuration and troubleshooting
- Role-Based Access Control (RBAC)
- Mapped network drives and department-based permissions
- Group Policy software deployment
- DHCP and DNS configuration
- IP addressing and network troubleshooting
- Enterprise identity and access management
- Account lockout and workstation security policies
- Real-world issue diagnosis and resolution

All configurations were built and validated in a virtualized environment using Windows Server 2022, Windows 11, and VMware Workstation.

---

## Lab Design Philosophy

The environment was built as a reusable domain infrastructure rather than a one-off lab.

This allows additional scenarios to be layered on top of the same system, including:

- Network diagnostics and troubleshooting
- Help desk and user support workflows
- Security testing and policy enforcement
- Software deployment and workstation standardization
- Future infrastructure and service expansion

This approach reflects how real enterprise environments are continuously developed, maintained, and improved over time.

---

## Environment

- Windows Server 2022 Domain Controller: `DC01`
- Windows 11 domain-joined workstations
- VMware Workstation
- Internal VMware LAN segment
- Domain: `steencorp.local`

---

## Project Roadmap

| Phase | Status | Focus | Outcome |
|------|--------|------|--------|
| Phase 1: Foundation | Completed | Domain setup, AD DS, virtualization | Built a fully functional domain environment |
| Phase 2: Access Control, GPO & Software Deployment | Completed | RBAC, drive mapping, GPO troubleshooting, Chrome deployment | Implemented access control and centralized workstation software deployment |
| Phase 3: Networking & Troubleshooting | Completed | DNS, DHCP, IP management, issue resolution | Configured and validated core network services |
| Phase 4: Security & Enterprise Controls | Completed | Identity management, GPO security, workstation hardening | Implemented enterprise-level security controls and validation |

---

## Architecture Summary

- Single domain: `steencorp.local`
- Centralized Domain Controller: `DC01`
- Domain-joined Windows 11 workstations
- Internal network segmentation through VMware
- Centralized authentication through Active Directory
- Centralized policy management through Group Policy
- Department-based access control through security groups

---

## Key Highlights

### Centralized Identity & Access Control

- Built a structured Active Directory environment
- Created department-based Organizational Units and security groups
- Implemented RBAC using group-based permissions
- Restricted users to only their assigned department resources
- Validated access from domain-joined Windows 11 clients

---

### Group Policy Management

- Configured mapped network drives through Group Policy
- Consolidated drive mappings into a centralized GPO
- Resolved GPO issues caused by incorrect OU placement
- Validated policy application using client-side testing
- Expanded Group Policy use beyond access control into software deployment

---

### Software Deployment

- Created a centralized software repository on DC01
- Configured NTFS and share permissions for deployment access
- Deployed Google Chrome using Group Policy software installation
- Used a UNC path for MSI deployment
- Verified Chrome installation across multiple domain users

---

### Real-World Troubleshooting

- Resolved DHCP conflicts caused by VMware NAT interference
- Diagnosed incorrect IP assignments and BAD_ADDRESS conflicts
- Fixed GPO deployment issues caused by incorrect OU placement
- Identified and corrected DNS resolution inconsistencies
- Troubleshot software deployment issues involving UNC paths, share permissions, and computer-scope policy application

---

### Security Implementation

- Created a dedicated administrative account
- Validated separation between standard and administrative users
- Enforced account lockout policy
- Configured a login security banner
- Applied workstation hardening through Group Policy
- Validated security controls from the client side

---

## Sample Validation

### RBAC Enforcement

Users can only access their assigned department drives.

![Mapped Drives](/Evidence/Validation/V3_Final_Operational_Success_2.png)

---

### Software Deployment

Google Chrome was deployed through Group Policy and validated across domain users.

![Chrome Deployment Validation](/Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_20_Chrome_Installed_JHalpert_WK01.png)

---

### Network Validation

Verified DHCP and DNS configuration from the client.

![Network Validation](/Evidence/Validation/Final_VIP_Workstation_IP_Verification.png)

---

### Security Enforcement

Account lockout triggered and was resolved through administrative intervention.

![Account Lockout](/Evidence/Validation/Account_Lockout_Triggered.png)

---

## Project Structure

- [Phase 1 – Foundation & Environment Setup](./Phases/Phase1_Foundation.md)
- [Phase 2 – Access Control, GPO & Software Deployment](./Phases/Phase2_RBAC_GPO_Software_Deployment.md)
- [Phase 3 – Networking & Troubleshooting](./Phases/Phase3_Networking.md)
- [Phase 4 – Security, Identity & Enterprise Controls](./Phases/Phase4_Security,%20Identity%20%26%20Enterprise%20Controls.md)

---

## What I Learned

- Building systems is only one part of IT; troubleshooting is critical
- Active Directory structure affects how policies and access controls behave
- Group Policy depends heavily on proper OU placement and targeting
- RBAC is easier to manage when permissions are assigned to groups instead of users
- Software deployment through GPO requires proper UNC paths, share permissions, and computer-scope validation
- Virtual environments can introduce real-world networking issues
- Security controls must be implemented and validated, not assumed

---

## Future Development

This environment is designed to serve as a long-term foundation for additional labs and real-world scenarios.

Planned expansions include:

- Network Diagnostics Lab with routing, ARP, and path analysis
- Help Desk Simulation Lab with user issues, ticket scenarios, and access troubleshooting
- Security Expansion with AppLocker, auditing, logging, and SIEM integration
- VPN and remote access configuration
- Advanced network segmentation with VLANs, ACLs, and firewall rules

Future labs will build on this domain and be linked here as they are developed.
