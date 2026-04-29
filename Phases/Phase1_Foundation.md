# Phase 1 – Foundation & Environment Setup

## Objective
Establish a scalable Active Directory domain environment capable of supporting enterprise user management, organizational structure, and future policy enforcement.

---

## Environment
- Windows Server 2022 (Domain Controller – DC01)
- Windows 11 (Domain-Joined Client)
- VMware Workstation

---

## Implementation

### Domain Controller Deployment
- Deployed Windows Server 2022 and promoted it to a Domain Controller for the `steencorp.local` domain  
- Installed and configured Active Directory Domain Services (AD DS)  
- Established centralized authentication for domain users  

---

### Virtualization Migration (Critical Decision)

Initially built the environment in VirtualBox, but encountered a blocking issue where the Windows 11 VM failed to boot (black screen).

<details>
<summary>View Issue & Migration Evidence</summary>

**VirtualBox Boot Failure**  
![VirtualBox Boot Error](Evidence/Infrastructure/Screenshot%202026-04-13%20120545.png)

**Domain Demotion Prior to Rebuild**  
![Domain Demotion](Evidence/Infrastructure/00_Demote_Domain.png)

</details>

Rather than continuing to troubleshoot a non-critical platform issue, I made the decision to rebuild the lab in VMware.

**Result:**
- Improved system stability and performance  
- Greater control over networking for later phases  
- More reliable environment for domain services  
- Reinforced understanding of virtualization platform limitations and their impact on infrastructure stability  

---

### Organizational Unit (OU) Design & Automation

After rebuilding the environment, I transitioned from manual setup to automated deployment using PowerShell.

**Structure Implemented:**
- Root OU: `SteenCorp_HQ`  
- Sub-containers: `Departments`, `Groups`, `Workstations`  
- Department OUs: IT, Sales, HR, Accounting, Marketing  

**Automation Approach:**
- Used PowerShell scripts to create OUs and structure  
- Designed to be repeatable and scalable  

**Why This Matters:**
- Reduces manual configuration time  
- Ensures consistency across environments  
- Reflects real-world enterprise administration practices  

---

## Validation

- Verified successful domain promotion and AD DS functionality  
- Confirmed Windows 11 client successfully joined to domain  
- Tested authentication using multiple user accounts  
- Validated OU structure creation via PowerShell execution  

---

## Outcome

- Fully operational Active Directory domain (`steencorp.local`)  
- Centralized authentication functioning across domain  
- Scalable OU structure deployed and ready for RBAC implementation  
- Stable virtualization platform established for continued lab expansion  

---

## Key Takeaways

- Rebuilding environments can be more efficient than troubleshooting unstable platforms  
- Automation through PowerShell is essential for scalable administration  
- Proper OU design is critical for future Group Policy and access control  
- Infrastructure stability directly impacts the reliability of domain services 
