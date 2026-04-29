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

Rather than continuing to troubleshoot a non-critical platform issue, I rebuilt the lab in VMware.

**Result:**
- Improved system stability and performance  
- Greater control over networking for later phases  
- More reliable environment for domain services  
- Reinforced understanding of virtualization platform limitations  

---

### Organizational Unit (OU) Design

After stabilizing the environment, I designed a structured Active Directory hierarchy to support scalability and policy management.

#### Structure Implemented

- Root OU: `SteenCorp_HQ`  
- Sub-containers:
  - `Departments`
  - `Groups`
  - `Workstations`  
- Department OUs:
  - IT
  - Sales
  - HR
  - Accounting
  - Marketing
    
![Group Deployment](../Evidence/Infrastructure/01_SteenCorp_OU_HQ_Structure.png)

---

### Automation Implementation

To improve scalability and reduce manual configuration, I implemented PowerShell-based automation.

#### Automation Approach

- Developed PowerShell scripts to automate:
  - Organizational Unit creation  
  - Security group creation  
  - User provisioning  
- Used CSV-driven user provisioning to simulate a real-world employee directory  
- Designed scripts to be reusable for rapid environment rebuilds  

#### Scripts Used

- [OU Infrastructure Setup](../Scripts/Phase1_Infrastructure/SteenCorp%20OU%20Infrastructure%20Setup.ps1)  
- [Security Group Infrastructure](../Scripts/Phase1_Infrastructure/SteenCorp%20Group%20Infrastructure.ps1)  
- [Employee CSV Generator](../Scripts/Phase1_Infrastructure/Create%20Mega%20SteenCorp%20Employee%20CSV.ps1)  
- [Bulk User Provisioning](../Scripts/Phase1_Infrastructure/SteenCorp%20Final%20Bulk%20Ingestion.ps1)  

---

### Implementation Results

- Executed automation scripts to deploy OU structure, groups, and users  
- Successfully populated Active Directory using bulk provisioning  
- Eliminated manual user and group creation  

---

## Validation

### OU Structure Deployment

- Verified OU structure in Active Directory Users and Computers (ADUC)  
- Result: Organizational Units aligned with intended hierarchy
  
![OU Hierarchy Structure](../Evidence/Infrastructure/01_SteenCorp_OU_HQ_Structure.png)

---

### Automated User Provisioning

- Executed bulk ingestion using CSV-defined user data  
- Result: Users created and placed into correct departmental OUs
  
![Bulk User Provisioning](../Evidence/Automation/04_Master_Automation_Proof.png)

---

### Authentication & Permission Validation

- Logged in as standard user (`jhalpert`)  
- Verified domain authentication using: `whoami`  
- Tested administrative restriction using: `net session`  

**Result:**
- User authenticated as `steencorp\jhalpert`  
- Administrative command failed with “Access is denied”  

![Domain Authentication and Permission Validation](../Evidence/Validation/V3_Final_Operational_Success.png)

---

## Why This Matters

- Reduces administrative overhead through automation  
- Ensures consistent and repeatable deployments  
- Reflects real-world enterprise identity management practices  
- Demonstrates ability to automate large-scale user provisioning  

---

## Outcome

- Fully operational Active Directory domain (`steencorp.local`) deployed  
- Centralized authentication established across systems  
- Scalable OU structure implemented  
- Stable virtualized environment prepared for future phases  

---

## Key Takeaways

- Rebuilding unstable environments can be more efficient than prolonged troubleshooting  
- PowerShell automation is critical for scalability  
- Proper OU design is foundational for RBAC and Group Policy  
- Infrastructure stability directly impacts system reliability
