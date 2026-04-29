# SteenCorp Enterprise Infrastructure Lab

## Objective

Build and validate a simulated enterprise Active Directory environment capable of supporting real-world IT operations, including user management, access control, group policy enforcement, and network services.

This project demonstrates the ability to:
- Administer Active Directory environments
- Implement role-based access control (RBAC)
- Apply Group Policy for system management
- Configure DNS and DHCP services
- Troubleshoot real infrastructure issues
- Support common help desk scenarios
---

## Overview

This lab simulates a real enterprise IT environment using Windows Server and a domain-joined client.

The focus was not just on building the infrastructure, but on understanding how systems interact and how to troubleshoot when issues occur. Throughout the project, I implemented core services, enforced security policies, and validated functionality through real-world scenarios such as account lockouts, access restrictions, and network failures.

This project reflects both system administration and help desk responsibilities..

---

## Environment
- Windows Server 2022 (Domain Controller)
- Windows 11 Pro (Domain Joined)
- VMware Workstation

---
## Project Roadmap

This lab is structured to simulate the build-out of a real enterprise IT environment, progressing from infrastructure deployment to access control and full system validation.

| Phase | Status | Focus | Outcome |
| :--- | :--- | :--- | :--- |
| [Phase 1: Foundation](Phases/Phase1_Foundation.md) | Completed | Windows Server deployment, domain setup, virtualization | Built a functional Active Directory domain with a domain-joined client |
| [Phase 2: Access Control & Connectivity](Phases/Phase2_RBAC.md) | Completed | Users, groups, NTFS permissions, GPO drive mapping, network integration | Implemented RBAC and ensured systems communicate correctly across the domain |
| [Phase 3: Validation & Troubleshooting](Phases/Phase3_Networking.md) | In Progress | DNS, DHCP, IP schema, system validation, troubleshooting | Verified end-to-end functionality and resolved real-world infrastructure issues |

---

### Lab Progression

- Phase 1 established the core domain infrastructure  
- Phase 2 implemented access control and ensured systems could communicate across the network  
- Phase 3 focuses on validating all services and troubleshooting real-world issues  

This mirrors how enterprise environments are deployed, tested, and maintained in production.

---
## Phase 1: Foundation & Environment Setup

Established the core infrastructure for a simulated enterprise Active Directory environment.

- Deployed Windows Server 2022 Domain Controller (`steencorp.local`)
- Configured Active Directory Domain Services (AD DS)
- Joined Windows 11 client and validated domain authentication
- Migrated environment from VirtualBox to VMware to improve stability and networking reliability
- Automated OU, group, and user creation using PowerShell scripts

### Key Outcome
Successfully deployed and validated a scalable Active Directory domain environment capable of supporting centralized authentication and future access control implementation.

➡️ **View Full Phase 1 Documentation:**  
[Phase 1 – Foundation & Environment Setup](Phases/Phase1_Foundation.md)

---
## Phase 2: Access Control & Connectivity

Implemented role-based access control (RBAC) to simulate how enterprise environments manage and restrict user access to shared resources.

- Created departmental Organizational Units, users, and security groups (Sales, HR, IT)
- Built a centralized file share (`SteenCorp_Shares`) with department-specific folders
- Configured NTFS permissions to enforce least privilege access by group membership
- Disabled inheritance to prevent permission overlap and maintain isolation
- Implemented Group Policy to automatically map network drives based on user roles

### Key Outcome
Successfully enforced department-based access control and automated resource access, ensuring users could only interact with authorized data.

➡️ **View Full Phase 2 Documentation:**  
[Phase 2 – RBAC & GPO Implementation](Phases/Phase2_RBAC.md)
---

## Phase 3: Networking & Troubleshooting

- Configured DHCP to assign IP addresses and created a reservation for VIP client machines
- Set up DNS (forward and reverse lookup) so systems could resolve each other correctly
- Added DNS forwarders to allow external name resolution (internet access)

### Networking & Troubleshooting Highlights

- Designed structured IP addressing (192.168.10.0/24)
- Configured DHCP scope with exclusions and reservations
- Implemented DNS forward + reverse lookup zones
- Configured DNS forwarders for external resolution
- Diagnosed DHCP conflicts caused by VMware NAT
- Identified and resolved BAD_ADDRESS IP conflicts
- Isolated lab network using custom VMware LAN segments
- Performed DNS service resets and cache flushing
- Validated forward and reverse DNS resolution using `nslookup`

This phase demonstrates not just configuration, but **true troubleshooting and infrastructure understanding**.

---

## Automation (PowerShell)

I started by creating users and groups manually while building the lab, which worked at first but quickly became repetitive.

After rebuilding the environment in VMware, I switched to using PowerShell with CSV files to automate user and group creation. This made it much easier to scale and manage multiple accounts at once.

### What I Used

- PowerShell scripts for creating OUs and security groups
- CSV file to define users and assign them to the correct departments
- Bulk user creation script to import accounts into Active Directory

### Why This Matters

Working through both the manual and automated approach helped me understand:
- how Active Directory objects are structured
- why automation is important in larger environments
- how repetitive administrative tasks can be simplified with scripting

### Key Scripts

- [OU Infrastructure Setup](./Scripts/Phase1_Infrastructure/SteenCorp%20OU%20Infrastructure%20Setup.ps1)  
- [Security Group Deployment](./Scripts/Phase1_Infrastructure/SteenCorp%20Group%20Infrastructure.ps1)  
- [Employee CSV Generator](./Scripts/Phase1_Infrastructure/Create%20Mega%20SteenCorp%20Employee%20CSV.ps1)  
- [Bulk User Provisioning](./Scripts/Phase1_Infrastructure/SteenCorp%20Final%20Bulk%20Ingestion.ps1)  

---

## Validation & Testing

- Verified network connectivity (ICMP / ping)
- Confirmed domain join
- Checked user placement and group membership
- Tested access controls and GPO enforcement

---

## Final Result

- Domain fully operational  
- RBAC enforced across departments  
- GPO policies applied successfully  
- Network services functioning and validated  
- Client systems properly authenticated and managed  

---

## Key Takeaways

- Rebuilding environments can be more efficient than patching failures  
- PowerShell automation enables scalable administration  
- Networking issues often originate from hidden infrastructure conflicts  
- DNS and DHCP are critical to domain functionality  
- Validation from the end-user perspective is essential 
