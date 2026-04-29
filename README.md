# SteenCorp Enterprise Infrastructure Lab

## Overview

I built this lab to get hands-on experience with how a real Active Directory environment works.

The goal wasn’t just to set everything up, but to actually understand how users, permissions, and networking all connect. I set up a domain controller, joined a client machine, created users and groups, and tested access between different departments.

Along the way I ran into real issues (especially with networking) and worked through them, which ended up being the most valuable part of the project.

---

## Project Objective

The goal of this project was to build a basic enterprise-style environment and understand how it works at a practical level.

I focused on:
- Setting up and managing Active Directory
- Creating users, groups, and access controls
- Using Group Policy to manage resources
- Configuring DHCP and DNS so systems could communicate
- Troubleshooting issues when things didn’t work as expected

This project is meant to show that I can not only set these systems up, but also understand how they behave and fix problems when they break.

---

## Environment
- Windows Server 2022 (Domain Controller)
- Windows 11 Pro (Domain Joined)
- VMware Workstation

---

## Project Roadmap

| Phase | Status | Focus |
| :--- | :--- | :--- |
| [Phase 1](Phases/Phase1_Foundation.md) | Completed | Windows Server, Windows 11, AD DS, VMware migration |
| [Phase 2](Phases/Phase2_RBAC.md) | Completed | RBAC, file shares, NTFS permissions, GPO drive mapping |
| [Phase 3](Phases/Phase3_Networking.md) | In Progress | DNS, DHCP, IP schema, network troubleshooting & validation |

---

## Phase 1: Foundation & Environment Setup

- Set up a Windows Server 2022 Domain Controller (DC01) and created the Steencorp.local domain
- Joined a Windows 11 client machine to the domain and tested login with different user accounts

### Major Challenge: VirtualBox Failure → VMware Migration

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

## Phase 2: RBAC & GPO Implementation

### What I Set Up

- Built out an Active Directory structure with OUs for departments, users, and workstations
- Created users and security groups to simulate departments like Sales, HR, and IT
- Created a central shared folder called `SteenCorp_Shares` to simulate a company file server
- Built out department folders for Sales, HR, and IT
- Configured NTFS permissions so departments could only access their own files
- Disabled inheritance to make sure permissions stayed isolated and didn’t overlap
- Used Group Policy to automatically map the correct network drive for each department when users log in

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
