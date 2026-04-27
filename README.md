# SteenCorp Enterprise Infrastructure Lab

## Overview
Built a simulated enterprise Active Directory environment using Windows Server 2022 and VMware. This project demonstrates user provisioning, organizational design, automation with PowerShell, and system validation from a domain-joined client.

---

## Environment
- Windows Server 2022 (Domain Controller)
- Windows 11 Pro (Domain Joined)
- VMware Workstation

---

## Key Responsibilities / What I Built
- Designed and implemented Active Directory OU structure (Departments, Groups, Workstations, Admins)
- Automated user creation and group assignment using PowerShell scripts and CSV ingestion
- Configured security groups to simulate role-based access control (RBAC)
- Engineered a centralized file infrastructure with departmental security silos
- Deployed Group Policy Objects (GPOs) to automate environment configurations and resource mapping
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

![VirtualBox Boot Error](Images/Screenshot%202026-04-13%20120545.png)

![Domain Demotion](Images/00_Demote_Domain.png)

</details>

---

## Automation (PowerShell)

Used a script-first approach to simulate real-world onboarding and scalability.

### Key Scripts

- [OU Infrastructure Setup](./Scripts/SteenCorp%20OU%20Infrastructure%20Setup.ps1)  
  → Builds the full Organizational Unit structure for the enterprise

- [Security Group Deployment](./Scripts/SteenCorp%20Group%20Infrastructure.ps1)  
  → Creates and organizes all departmental security groups

- [Employee CSV Generator](./Scripts/Create%20Mega%20SteenCorp%20Employee%20CSV.ps1)  
  → Generates large-scale test data for user provisioning

- [Bulk User Provisioning Script](./Scripts/SteenCorp%20Final%20Bulk%20Ingestion.ps1)  
  → Imports CSV data to create users, assign OUs, and apply group membership

---

### What This Demonstrates

- Infrastructure as Code (IaC) mindset
- Scalable user onboarding process
- Automated role-based access control (RBAC)
- Reduced manual administrative effort

<details>
<summary>View Automation & AD Architecture</summary>

![OU Structure](Images/01_SteenCorp_OU_Structure.png)

![Security Groups](Images/02_Security_Group_Deployment.png)

![Bulk Provisioning](Images/04_Master_Automation_Proof.png)

</details>

---

## Phase 2: Automated Resource Management (RBAC & GPO)

Established a centralized file infrastructure with departmental security silos, automated via Group Policy Preferences (GPP).

### Key Achievements
- **Secure File Services:** Established a centralized root share (`SteenCorp_Shares`) with dedicated sub-folders for HR, IT, and Sales.
- **RBAC Strategy:** Implemented the "Open Gate, Locked Door" model—Share permissions for `Authenticated Users` with strict **NTFS Security Permissions** at the folder level.
- **Inheritance Management:** Manually disabled permission inheritance to ensure data privacy between departments.
- **Drive Map Automation:** Engineered and linked department-specific GPOs to Department OUs to automatically mount the **S: Drive** upon user login.

<details>
<summary>View Resource & Policy Configuration</summary>

| Task | Configuration Evidence |
| :--- | :--- |
| **Physical Directory** | ![Directory](Images/Physical%20Directory%20Structure%20for%20Departmental%20Shares.png) |
| **Share Permissions** | ![RBAC](Images/Applying%20Role-Based%20Access%20Control%20to%20Network%20Shares.png) |
| **NTFS Security Audit** | ![NTFS Audit](Images/NTFS_Security_Inheritance_Audit.png.png) |
| **GPO Tree Linking** | ![GPO Tree](Images/Organizational%20Unit%20Hierarchy%20and%20Target-Linked%20Group%20Policies.png) |
| **Drive Map Logic** | ![Map Settings](Images/GPO%20Drive%20Map%20COnfiguration%20for%20Sales%20Department.png) |

</details>

---

## Validation & Testing

Validated the environment from a real client perspective:

- Verified network connectivity (ICMP / ping)
- Confirmed successful domain join
- Audited user placement and group membership across departments
- Tested permissions and enforced least privilege access restrictions

<details>
<summary>View Validation Evidence</summary>

![Network Connectivity](Images/V2_05_Network_Handshake_Success.png)

![Domain Join](Images/V2_06_Domain_Verification_Final.png)

![Department Verification](Images/03_Sales_Department_Live.png)

#### **Live Multi-Departmental Validation**
Verification of **Mike Ross (HR)** successfully receiving his unique S: Drive. Session identity is confirmed via `whoami`, and policy application is verified via `gpresult /r`.
![HR Validation](Images/Multi-Departmental%20Resource%20Provisioning%20and%20RBAC%20Validation.png)

</details>

---

## Final Result (GPO + Security Enforcement)

- Deployed Group Policy to enforce corporate branding
- Verified standard users could NOT perform administrative actions
- Confirmed least privilege access model

![Final State](Images/V3_Final_Operational_Success.png.png)

---

## Key Takeaways

- Rebuilding environments is often faster than troubleshooting broken infrastructure
- PowerShell automation is critical for scalability in enterprise environments
- Group-based access control simplifies permission management
- Testing from the end-user perspective is essential for validation

## Future Roadmap
* **Phase 3:** Security Operations (Sysmon Deployment & Event Log Analysis).
* **Phase 4:** Remote Access Infrastructure (VPN Configuration & Routing).
