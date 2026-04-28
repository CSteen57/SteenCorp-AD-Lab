# SteenCorp Enterprise Infrastructure Lab

## Overview
Built a simulated enterprise Active Directory environment using Windows Server 2022 and VMware. This project demonstrates user provisioning, organizational design, automation with PowerShell, and system validation from a domain-joined client.

---

## Project Objective

This lab simulates a real-world enterprise IT environment to demonstrate:

- Active Directory deployment and management
- Role-based access control and policy enforcement
- Core networking services (DNS, DHCP, IP design)
- Automation using PowerShell
- System validation from an end-user perspective

---

## Environment
- Windows Server 2022 (Domain Controller)
- Windows 11 Pro (Domain Joined)
- VMware Workstation

---

## What I Built
- Designed and implemented Active Directory OU structure (Departments, Groups, Workstations, Admins)
- Automated user creation and group assignment using PowerShell scripts and CSV ingestion
- Configured security groups to simulate role-based access control (RBAC)
- Engineered a centralized file infrastructure with departmental security silos
- Deployed Group Policy Objects (GPOs) for configuration enforcement and resource mapping
- Built and validated a fully functioning enterprise network (DNS, DHCP, IP schema)
- Diagnosed and resolved real-world network conflicts (DHCP interference, BAD_ADDRESS)
- Implemented DNS forwarders for external resolution and validated internal/external name resolution

---

## Project Roadmap

| Phase | Status | Focus |
| :--- | :--- | :--- |
| [Phase 1](Phases/Phase1_Foundation.md) | Completed | Windows Server, Windows 11, AD DS, VMware migration |
| [Phase 2](Phases/Phase2_RBAC.md) | Completed | RBAC, file shares, NTFS permissions, GPO drive mapping |
| [Phase 3](Phases/Phase3_Networking.md) | In Progress | DNS, DHCP, IP schema, network troubleshooting & validation |
| [Phase 4](Phases/Phase4_Automation.md) | Planned | PowerShell automation, health checks, reporting |
| [Phase 5](Phases/Phase5_Security.md) | Planned | Sysmon, logging, security monitoring |
| [Phase 6](Phases/Phase6_Helpdesk.md) | Planned | Ticketing simulation, SOPs, troubleshooting |

---

## Networking & Troubleshooting Highlights

Phase 3 introduces real-world networking engineering concepts and problem solving:

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

## Major Challenge: VirtualBox Failure → VMware Migration

Initially built the lab in VirtualBox but encountered Windows 11 display driver issues (black screen).  

**Action:**
- Demoted original Domain Controller  
- Rebuilt entire environment in VMware  

**Result:**
- Improved performance, stability, and network reliability  

<details>
<summary>View Migration Evidence</summary>

![VirtualBox Boot Error](Evidence/Infrastructure/Screenshot%202026-04-13%20120545.png)

![Domain Demotion](Evidence/Infrastructure/00_Demote_Domain.png)

</details>

---

## Automation (PowerShell)

Used a script-first approach to simulate real-world onboarding and scalability.

### Key Scripts

- [OU Infrastructure Setup](./Scripts/Phase1_Infrastructure/SteenCorp%20OU%20Infrastructure%20Setup.ps1)  
- [Security Group Deployment](./Scripts/Phase1_Infrastructure/SteenCorp%20Group%20Infrastructure.ps1)  
- [Employee CSV Generator](./Scripts/Phase1_Infrastructure/Create%20Mega%20SteenCorp%20Employee%20CSV.ps1)  
- [Bulk User Provisioning](./Scripts/Phase1_Infrastructure/SteenCorp%20Final%20Bulk%20Ingestion.ps1)  

---

### What This Demonstrates
- Infrastructure as Code mindset  
- Scalable onboarding process  
- Automated RBAC implementation  
- Reduced manual administrative effort  

---

## Phase 2: RBAC & GPO Implementation

### Key Achievements
- Created centralized share: `SteenCorp_Shares`
- Implemented department-based access (HR, IT, Sales)
- Used NTFS permissions to enforce data isolation
- Disabled inheritance to prevent cross-department access
- Deployed GPOs to automatically map drives per department

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

---

## Future Roadmap

**Phase 3 (Finishing):**
- `tracert`, `route print`, `arp -a`
- Advanced DNS concepts (recursive vs iterative)


**Phase 4: Administrative Automation**
- PowerShell health checks for domain services
- Automated user lifecycle management (onboarding/offboarding)
- Reporting scripts for stale accounts and permission audits

**Phase 5: Security Monitoring**
- Sysmon deployment for endpoint logging
- Event log analysis and filtering
- Simulated attack scenarios (brute force, lateral movement basics)

**Phase 6: Help Desk & Support Operations**
- Ticketing simulation (account lockouts, access issues, DNS failures)
- Standard Operating Procedures (SOPs)
- End-user troubleshooting workflows
