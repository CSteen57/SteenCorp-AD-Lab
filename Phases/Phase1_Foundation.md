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
![VirtualBox Boot Error](../Evidence/Infrastructure/Screenshot%202026-04-13%20120545.png)

**Domain Demotion Prior to Rebuild**  
![Domain Demotion](../Evidence/Infrastructure/00_Demote_Domain.png)

</details>

Rather than continuing to troubleshoot a non-critical platform issue, I made the decision to rebuild the lab in VMware.

**Result:**
- Improved system stability and performance  
- Greater control over networking for later phases  
- More reliable environment for domain services  
- Reinforced understanding of virtualization platform limitations and their impact on infrastructure stability  

---

### Organizational Unit (OU) Design & Automation

After rebuilding the environment, I transitioned from manual configuration to automated deployment using PowerShell to create a scalable and repeatable Active Directory structure.

#### Structure Implemented
- Root OU: `SteenCorp_HQ`  
- Sub-containers: `Departments`, `Groups`, `Workstations`  
- Department OUs: IT, Sales, HR, Accounting, Marketing  

---

#### Automation Approach
- Developed PowerShell scripts to automate the creation of Organizational Units, security groups, and users  
- Used CSV-driven user provisioning to simulate a real-world employee directory  
- Designed scripts to be reusable and scalable for rapid environment rebuilds  

---

#### Automation Evidence

- Executed PowerShell scripts to deploy OU structure, groups, and users across departments  
- Successfully populated Active Directory using automated bulk provisioning  

![PowerShell Automation Script Execution](../Evidence/Automation/04_Master_Automation_Proof.png)

---

#### Scripts Used

- [OU Infrastructure Setup](../Scripts/Phase1_Infrastructure/SteenCorp%20OU%20Infrastructure%20Setup.ps1)  
- [Security Group Infrastructure](../Scripts/Phase1_Infrastructure/SteenCorp%20Group%20Infrastructure.ps1)  
- [Employee CSV Generator](../Scripts/Phase1_Infrastructure/Create%20Mega%20SteenCorp%20Employee%20CSV.ps1)  
- [Bulk User Provisioning](../Scripts/Phase1_Infrastructure/SteenCorp%20Final%20Bulk%20Ingestion.ps1)  

---

#### Why This Matters
- Reduces manual configuration time and administrative overhead  
- Ensures consistent and repeatable environment deployments  
- Reflects real-world enterprise practices for identity and access management  
- Demonstrates ability to automate large-scale user provisioning  

---

### Validation

#### OU Structure Deployment
- Executed OU deployment script and verified structure in Active Directory Users and Computers (ADUC)  
- Result: All Organizational Units created successfully and aligned with intended hierarchy  

---

#### Automated User Provisioning
- Ran bulk ingestion script using CSV-defined user data  
- Result: Users were created and placed into correct departmental OUs  

---

#### Authentication & Permission Validation

- Logged into the domain using a standard user account (`jhalpert`)  
- Verified domain authentication using: `whoami`
- Tested administrative command restrictions using: `net session`

  
**Result:**
- User successfully authenticated as `steencorp\jhalpert`  
- Administrative command failed with “Access is denied,” confirming proper permission enforcement  

![Domain Authentication and Permission Validation](../Evidence/Validation/V3_Final_Operational_Success.png)
---
---

## Outcome

- Successfully deployed and validated a fully operational Active Directory domain (`steencorp.local`)  
- Established centralized authentication across domain-joined systems  
- Implemented a scalable Organizational Unit structure to support future RBAC and Group Policy deployment  
- Built a stable and reliable virtualized environment for continued infrastructure expansion  

---

## Key Takeaways

- Rebuilding unstable environments can be more efficient than prolonged troubleshooting  
- PowerShell automation is essential for scalable and repeatable system administration  
- Proper OU design is foundational for effective Group Policy and access control implementation  
- Infrastructure stability directly impacts the reliability of domain services and overall system performance   
