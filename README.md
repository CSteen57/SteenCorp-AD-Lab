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
- Joined Windows 11 client to domain and validated authentication
- Tested permissions and enforced least privilege access

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

## Validation & Testing

Validated the environment from a real client perspective:

- Verified network connectivity (ICMP / ping)
- Confirmed successful domain join
- Audited user placement across departments
- Tested permissions and access restrictions

<details>
<summary>View Validation Evidence</summary>

![Network Connectivity](Images/V2_05_Network_Handshake_Success.png)

![Domain Join](Images/V2_06_Domain_Verification_Final.png)

![Department Verification](Images/03_Sales_Department_Live.png)

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
* **Phase 2:** Automated Resource Management (Mapped Drives & Software Deployment).
* **Phase 3:** Security Operations (Sysmon Deployment & Event Log Analysis).
* **Phase 4:** Remote Access Infrastructure (VPN Configuration & Routing).
