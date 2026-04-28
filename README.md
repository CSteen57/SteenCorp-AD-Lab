# SteenCorp Enterprise Infrastructure Lab

## Overview
Built a simulated enterprise Active Directory environment using Windows Server 2022 and VMware. This project demonstrates user provisioning, organizational design, automation with PowerShell, and system validation from a domain-joined client.

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
- Joined Windows 11 client to domain and validated authentication and permissions

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

![VirtualBox Boot Error](Evidence/Infrastructure/Screenshot%2026-04-13%120545.png)

![Domain Demotion](Evidence/Infrastructure/00%Demote%Domain.png)

</details>

---

## Automation (PowerShell)

Used a script-first approach to simulate real-world onboarding and scalability.

### Key Scripts

- [OU Infrastructure Setup](./Scripts/SteenCorp%20OU%20Infrastructure%20Setup.ps1)  
  → Builds the full Organizational Unit structure  

- [Security Group Deployment](./Scripts/SteenCorp%20Group%20Infrastructure.ps1)  
  → Creates and organizes all departmental security groups  

- [Employee CSV Generator](./Scripts/Create%20Mega%20SteenCorp%20Employee%20CSV.ps1)  
  → Generates large-scale test data  

- [Bulk User Provisioning](./Scripts/SteenCorp%20Final%20Bulk%20Ingestion.ps1)  
  → Creates users, assigns OUs, and applies group membership  

---

### What This Demonstrates
- Infrastructure as Code (IaC) mindset  
- Scalable onboarding process  
- Automated RBAC implementation  
- Reduced manual administrative effort  

<details>
<summary>View Automation & AD Architecture</summary>

![OU Structure](Images/01_SteenCorp_OU_Structure.png)

![Security Groups](Images/02_Security_Group_Deployment.png)

![Bulk Provisioning](Images/04_Master_Automation_Proof.png)

</details>

---

## Phase 2: RBAC & GPO Implementation

Built a centralized file and access control system using RBAC and Group Policy.

### Key Achievements
- Created centralized share: `SteenCorp_Shares`
- Implemented department-based access (HR, IT, Sales)
- Used NTFS permissions to enforce data isolation
- Disabled inheritance to prevent cross-department access
- Deployed GPOs to automatically map drives per department

---

<details>
<summary>View Resource & Policy Configuration</summary>

| Task | Evidence |
| :--- | :--- |
| Directory Structure | ![Directory](Images/Physical%20Directory%20Structure%20for%20Departmental%20Shares.png) |
| Share Permissions | ![RBAC](Images/Applying%20Role-Based%20Access%20Control%20to%20Network%20Shares.png) |
| NTFS Security | ![NTFS](Images/NTFS_Security_Inheritance_Audit.png.png) |
| GPO Linking | ![GPO](Images/Organizational%20Unit%20Hierarchy%20and%20Target-Linked%20Group%20Policies.png) |
| Drive Mapping | ![Mapping](Images/GPO%20Drive%20Map%20COnfiguration%20for%20Sales%20Department.png) |

</details>

---

## Validation & Testing

Performed baseline validation from a client perspective:

- Verified network connectivity (ICMP / ping)
- Confirmed domain join
- Checked user placement and group membership
- Tested basic access controls

<details>
<summary>View Validation Evidence</summary>

![Network Connectivity](Images/V2_05_Network_Handshake_Success.png)

![Domain Join](Images/V2_06_Domain_Verification_Final.png)

![Department Check](Images/03_Sales_Department_Live.png)

</details>

---

## Final Result (Full Environment Proof)

Validated full enterprise functionality including authentication, policy enforcement, and access control.

### Multi-Department Access Validation

Verification of **Mike Ross (HR)** receiving the correct mapped drive and permissions.

- Identity confirmed via `whoami`
- Policy application verified via `gpresult /r`
- Department isolation successfully enforced

![HR Validation](Images/Multi-Departmental%20Resource%20Provisioning%20and%20RBAC%20Validation.png)

---

### Final System State

- GPO applied successfully
- Corporate branding enforced
- Standard users restricted from administrative actions

![Final State](Images/V3_Final_Operational_Success.png.png)

---

## Key Takeaways

- Rebuilding environments is often faster than troubleshooting broken infrastructure  
- PowerShell automation enables scalable system administration  
- RBAC simplifies access management in enterprise environments  
- Validation from the end-user perspective is critical  

---

## Future Roadmap

**Phase 3:** Security Monitoring (Sysmon + Event Analysis)  
**Phase 4:** Remote Access (VPN + Routing)  
