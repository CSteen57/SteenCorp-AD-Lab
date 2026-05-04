# SteenCorp Enterprise IT Lab

![SteenCorp Enterprise IT Lab](./SteenCorp_Enterprise_IT_Lab_Banner.png)

## Overview

The SteenCorp Enterprise IT Lab is a simulated business IT environment designed to replicate real-world infrastructure, identity management, access control, networking, security, and workstation support scenarios.

This project was built to bridge the gap between certification knowledge and practical, hands-on experience in system administration, networking, Active Directory administration, Group Policy, DNS, DHCP, permissions, and troubleshooting.

The lab is built around a reusable Windows domain environment that can continue expanding into future help desk, networking, security, remote access, and monitoring projects.

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
- Standard user and administrative account separation
- Real-world issue diagnosis and resolution

All configurations were built and validated in a virtualized environment using Windows Server 2022, Windows 11, and VMware Workstation.

---

## Lab Design Philosophy

The environment was built as a reusable domain infrastructure rather than a one-time lab.

This allows additional scenarios to be layered on top of the same system, including:

- Network diagnostics and troubleshooting
- Help desk and user support workflows
- Security testing and policy enforcement
- Software deployment and workstation standardization
- Future infrastructure and service expansion

This approach reflects how real enterprise environments are continuously developed, maintained, troubleshot, and improved over time.

---

## Project Continuation

This lab serves as the foundation for my follow-up SteenCorp portfolio projects.

After building the SteenCorp domain environment, I used the same Active Directory domain, users, groups, shared folders, Group Policy configuration, DNS setup, and Windows 11 workstation environment to simulate real help desk tickets.

The lab was also extended with a separate networking project focused on VLAN segmentation, guest isolation, inter-VLAN routing, and access control rules.

**Related Projects:**

- [SteenDesk Help Desk Simulation](https://github.com/CSteen57/SteenDesk_Help_Desk_Simulation)
- [SteenCorp Network Segmentation Lab](https://github.com/CSteen57/SteenCorp_Network_Segmentation_Lab)

Follow-up scenarios include:

- User cannot access a shared department drive
- User account locked out
- User forgot password
- User cannot access a network share by hostname
- User cannot install approved software without admin approval
- Guest network isolation from internal company resources
- VLAN segmentation and basic network access control

---

## Environment

| Component | Details |
|---|---|
| Domain | `steencorp.local` |
| Domain Controller | Windows Server 2022 |
| Domain Controller Hostname | `DC01` |
| Client Systems | Windows 11 domain-joined workstations |
| Virtualization Platform | VMware Workstation |
| Network Type | Internal VMware LAN segment |
| Core Services | AD DS, DNS, DHCP, Group Policy, File Sharing |

---

## Project Roadmap

| Phase | Status | Focus | Outcome |
|---|---|---|---|
| Phase 1: Foundation | Completed | Domain setup, AD DS, virtualization | Built a fully functional Windows domain environment |
| Phase 2: Access Control, GPO & Software Deployment | Completed | RBAC, drive mapping, GPO troubleshooting, Chrome deployment | Implemented access control and centralized workstation software deployment |
| Phase 3: Networking & Troubleshooting | Completed | DNS, DHCP, IP management, issue resolution | Configured and validated core network services |
| Phase 4: Security & Enterprise Controls | Completed | Identity management, GPO security, workstation hardening | Implemented enterprise-level security controls and validation |

This lab was later extended into separate portfolio projects using the same SteenCorp business environment.

---

## Architecture Summary

- Single Active Directory domain: `steencorp.local`
- Centralized Domain Controller: `DC01`
- Domain-joined Windows 11 workstations
- Internal network segmentation through VMware
- Centralized authentication through Active Directory
- Centralized policy management through Group Policy
- Department-based access control through security groups
- Shared resources protected through NTFS and share permissions
- Standard user accounts separated from administrative accounts

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
- Expanded Group Policy use beyond access control into software deployment and workstation security

---

### Software Deployment

- Created a centralized software repository on DC01
- Configured NTFS and share permissions for deployment access
- Deployed Google Chrome using Group Policy software installation
- Used a UNC path for MSI deployment
- Verified Chrome installation across multiple domain users

---

### Networking & Troubleshooting

- Configured DNS and DHCP services for the lab domain
- Planned and validated IP addressing for the internal network
- Resolved DHCP conflicts caused by VMware NAT interference
- Diagnosed incorrect IP assignments and `BAD_ADDRESS` conflicts
- Validated DNS resolution and DHCP assignment from Windows clients
- Used command-line tools to test connectivity and name resolution

---

### Security Implementation

- Created a dedicated administrative account
- Validated separation between standard and administrative users
- Enforced account lockout policy
- Configured a login security banner
- Applied workstation hardening through Group Policy
- Validated security controls from the client side

---

### Real-World Troubleshooting

This lab includes troubleshooting scenarios that mirror issues commonly seen in business IT environments, including:

- GPO deployment problems caused by incorrect OU placement
- Drive mapping issues caused by targeting and path configuration
- DHCP conflicts caused by virtualization network settings
- DNS resolution inconsistencies
- Software deployment issues involving UNC paths, share permissions, and computer-scope policy application
- Account lockout behavior and administrative recovery

---

## Sample Validation

### RBAC Enforcement

Users can only access their assigned department drives.

<img src="./Evidence/Validation/V3_Final_Operational_Success_2.png" alt="Mapped Drives Validation" width="850">

---

### Software Deployment

Google Chrome was deployed through Group Policy and validated across domain users.

<img src="./Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_20_Chrome_Installed_JHalpert_WK01.png" alt="Chrome Deployment Validation" width="850">

---

### Network Validation

DHCP and DNS configuration were validated from the client workstation.

<img src="./Evidence/Validation/Final_VIP_Workstation_IP_Verification.png" alt="Network Validation" width="850">

---

### Security Enforcement

Account lockout policy was triggered and resolved through administrative intervention.

<img src="./Evidence/Validation/Account_Lockout_Triggered.png" alt="Account Lockout Validation" width="850">

---

## Related Portfolio Projects

| Project | Focus |
|---|---|
| [SteenDesk Help Desk Simulation](https://github.com/CSteen57/SteenDesk_Help_Desk_Simulation) | Help desk troubleshooting, ticket documentation, Active Directory account issues, DNS troubleshooting, software install support, and least privilege validation |
| [SteenCorp Network Segmentation Lab](https://github.com/CSteen57/SteenCorp_Network_Segmentation_Lab) | VLAN segmentation, trunking, router-on-a-stick, ACL-based guest isolation, and network validation |

---

## Project Structure

<pre>
SteenCorp-AD-Lab/
│
├── README.md
├── SteenCorp_Enterprise_IT_Lab_Banner.jpg
│
├── Phases/
│   ├── README.md
│   ├── Phase1_Foundation.md
│   ├── Phase2_RBAC_GPO_Software_Deployment.md
│   ├── Phase3_Networking.md
│   └── Phase4_Security, Identity & Enterprise Controls.md
│
├── Evidence/
│   ├── README.md
│   ├── Automation/
│   ├── Infrastructure/
│   ├── Networking/
│   ├── Phase2_Chrome_GPO/
│   └── Validation/
│
└── Scripts/
    ├── README.md
    └── Phase1_Infrastructure/
</pre>

---

## Skills Demonstrated

- Active Directory administration
- Organizational Unit design
- Group Policy configuration and troubleshooting
- Role-Based Access Control
- NTFS and share permission management
- Mapped drive configuration
- DNS and DHCP configuration
- IP addressing and network troubleshooting
- VMware virtual networking
- Group Policy software deployment
- Windows Server administration
- Windows 11 domain client support
- Security policy enforcement
- Account lockout policy testing
- Administrative and standard user separation
- Command-line validation and troubleshooting
- Technical documentation

---

## What I Learned

- Building systems is only one part of IT; troubleshooting and validation are just as important
- Active Directory structure affects how policies and access controls behave
- Group Policy depends heavily on proper OU placement, targeting, and refresh behavior
- RBAC is easier to manage when permissions are assigned to groups instead of individual users
- Software deployment through GPO requires proper UNC paths, share permissions, and computer-scope validation
- Virtual environments can introduce real-world networking issues
- DNS is critical in Active Directory environments
- Security controls must be implemented and validated, not assumed
- A reusable lab environment can support multiple future projects and troubleshooting scenarios

---

## Future Development

This environment is designed to serve as a long-term foundation for additional labs and real-world scenarios.

Completed expansions:

- [SteenDesk Help Desk Simulation](https://github.com/CSteen57/SteenDesk_Help_Desk_Simulation) — Simulated user support tickets involving shared drive access, account lockouts, password resets, DNS troubleshooting, approved software installation, and least privilege validation.
- [SteenCorp Network Segmentation Lab](https://github.com/CSteen57/SteenCorp_Network_Segmentation_Lab) — Packet Tracer networking project demonstrating VLAN segmentation, trunking, router-on-a-stick, ACL-based guest isolation, and network validation.

Planned future expansions include:

- Security expansion with AppLocker, auditing, logging, and SIEM integration
- VPN and remote access configuration
- Firewall-based network isolation using pfSense or OPNsense
- Advanced endpoint and identity security controls

Future labs will continue building on the SteenCorp environment and be linked here as they are developed.

---

## Final Outcome

This project successfully built the foundation for a reusable enterprise-style IT lab.

The final environment includes centralized identity management, Group Policy, role-based access control, file sharing, software deployment, DNS, DHCP, workstation validation, and security controls.

This lab now serves as the foundation for a larger SteenCorp portfolio that includes help desk troubleshooting, network segmentation, and future security-focused projects.
