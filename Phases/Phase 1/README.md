# Phase 1 – Foundation & Environment Setup

## Objective

Build the foundation for the SteenCorp Windows domain environment by deploying a domain controller, creating a structured Active Directory layout, joining a Windows 11 client to the domain, and preparing the lab for future access control, Group Policy, networking, security, and help desk scenarios.

## Key Takeaways

- A stable foundation matters before adding advanced services
- Rebuilding in the right platform can be more efficient than fighting unstable lab issues
- Active Directory structure affects future access control and Group Policy design
- PowerShell can support both repeatable infrastructure deployment and ongoing user administration
- Standard user testing is important because access should be validated from the user side
- This phase directly supports the later RBAC, GPO, networking, security, and help desk ticketing projects

---

## Environment

- Windows Server 2022 Domain Controller: `DC01`
- Windows 11 domain-joined client
- VMware Workstation
- Active Directory domain: `steencorp.local`

---

## Implementation

### Domain Controller Deployment

I deployed Windows Server 2022 and promoted it to a Domain Controller for the `steencorp.local` domain.

This established the core identity foundation for the lab, including centralized authentication and Active Directory Domain Services.

Key steps completed:

- Installed Windows Server 2022
- Configured the server as the domain controller
- Installed and configured Active Directory Domain Services (AD DS)
- Created the `steencorp.local` domain
- Prepared the environment for domain users, groups, workstations, and policies

---

### Virtualization Migration

The lab was originally started in VirtualBox, but I ran into a blocking issue where the Windows 11 VM failed to boot and displayed a black screen.

<details>
<summary>View Issue & Migration Evidence</summary>

**VirtualBox Boot Failure**  
![VirtualBox Boot Error](../../Evidence/Infrastructure/Screenshot%202026-04-13%20120545.png)

**Domain Demotion Prior to Rebuild**  
![Domain Demotion](../../Evidence/Infrastructure/00_Demote_Domain.png)

</details>

Rather than spending too much time troubleshooting a virtualization platform issue, I made the decision to rebuild the lab in VMware Workstation.

This ended up being the better choice for the project.

**Result:**

- Improved VM stability and performance
- More reliable Windows 11 client behavior
- Better control over virtual networking
- Stronger foundation for later DNS, DHCP, GPO, and help desk testing
- Reinforced the importance of choosing the right virtualization platform for a lab environment

---

### Organizational Unit Design

After stabilizing the environment, I created a structured Active Directory layout to keep users, groups, departments, and workstations organized.

The goal was to avoid dumping every object into default containers and instead build the environment closer to how a business domain would be managed.

#### Structure Implemented

- Root OU: `SteenCorp_HQ`
- Main containers:
  - `Departments`
  - `Groups`
  - `Workstations`
- Department OUs:
  - IT
  - Sales
  - HR
  - Accounting
  - Marketing

![Group Deployment](../../Evidence/Infrastructure/01_SteenCorp_OU_HQ_Structure.png)

---

### PowerShell Automation

I first used PowerShell to create the OU and security group structure, generate employee data, and complete the initial bulk user deployment.

After the environment was running, I expanded that work into a reusable employee onboarding tool for individual hires. This progression let me practice moving from one-time build scripts to a safer administrative workflow with input validation, duplicate account protection, error handling, and final verification.

#### Scripts

- [OU Infrastructure Setup](./Scripts/SteenCorp%20OU%20Infrastructure%20Setup.ps1)
- [Security Group Infrastructure](./Scripts/SteenCorp%20Group%20Infrastructure.ps1)
- [Employee CSV Generator](./Scripts/Create%20Mega%20SteenCorp%20Employee%20CSV.ps1)
- [Bulk User Provisioning](./Scripts/SteenCorp%20Final%20Bulk%20Ingestion.ps1)
- [Reusable Employee Onboarding Tool](./Scripts/New_SteenCorpEmployee.ps1)

The CSV-based deployment gave the lab enough users to support later RBAC, GPO, security, and help desk scenarios. The individual onboarding tool added a repeatable process for growing the environment after the initial build.

[View the PowerShell walkthrough and validation evidence](./Scripts/)

---

## Outcome

Phase 1 created the foundation that every later phase depends on.

Without a stable domain controller, organized Active Directory structure, and working domain-joined client, the later RBAC, Group Policy, networking, security, and help desk scenarios would not have been possible.

This phase demonstrated:

- Basic Windows Server deployment
- Active Directory domain creation
- OU and group planning
- PowerShell infrastructure and user administration
- Bulk user provisioning
- Reusable employee onboarding
- Domain client validation
- Standard user permission testing
- Practical troubleshooting during a virtualization migration

---

## Validation

### OU Structure Deployment

The OU structure was verified in Active Directory Users and Computers.

**Result:**  
The domain structure matched the intended layout and was ready for future RBAC and Group Policy configuration.

![OU Hierarchy Structure](../../Evidence/Infrastructure/01_SteenCorp_OU_HQ_Structure.png)

---

### Automated User Provisioning

Bulk user provisioning was completed using CSV-defined user data.

**Result:**  
Users were created and placed into the correct departmental OUs.

![Bulk User Provisioning](../../Evidence/Automation/04_Master_Automation_Proof.png)

---

### Authentication and Permission Validation

A standard domain user account was used to validate authentication from the Windows 11 client.

Validation steps:

- Signed in as standard user `jhalpert`
- Ran `whoami` to confirm domain authentication
- Ran `net session` to test whether the user had administrative privileges

**Result:**

- User authenticated as `steencorp\jhalpert`
- Administrative command failed with “Access is denied”
- Standard user restrictions were working as expected

![Domain Authentication and Permission Validation](../../Evidence/Validation/V3_Final_Operational_Success.png)
