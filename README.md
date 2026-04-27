# SteenCorp Enterprise Infrastructure Lab

## Project Overview
The **SteenCorp** project is a comprehensive, virtualized Windows Enterprise environment. This lab serves as a functional proof-of-concept for core system administration tasks, including identity management, platform migration, and high-scale automated provisioning via PowerShell.

## Phase 1: Foundation & Platform Migration

### The Technical Pivot: VirtualBox to VMware
The project initially launched in Oracle VirtualBox. However, during the provisioning of the Windows 11 client, I encountered persistent display driver failures (Black Screen of Death).

* **Action:** Performed a demotion of the original Domain Controller and migrated the entire infrastructure to **VMware Workstation**.
* **Outcome:** Successfully re-established the `SteenCorp.Local` forest with improved hardware acceleration and network stability.

<details>
  <summary> View Migration Evidence</summary>

  ![VirtualBox Boot Error](Images/Screenshot%202026-04-13%20120545.png)
  *Initial VirtualBox display failure that triggered the platform migration.*

  ![Demoting the Original Domain](Images/00_Demote_Domain.png)
  *Forced demotion of the initial DC to ensure a clean migration and forest rebuild on VMware.*
</details>

---

##  Infrastructure as Code (PowerShell Automation)
To ensure the environment was scalable and repeatable, I utilized a "Script-First" approach to provision the entire domain.

**Featured Scripts:**
* [SteenCorp OU Infrastructure Setup.ps1](Scripts/SteenCorp%20OU%20Infrastructure%20Setup.ps1) - Automates the creation of the SteenCorp_HQ root and sub-OU hierarchy.
* [SteenCorp Group Infrastructure.ps1](Scripts/SteenCorp%20Group%20Infrastructure.ps1) - Deploys all departmental security groups for RBAC.
* [Create Mega SteenCorp Employee CSV.ps1](Scripts/Create%20Mega%20SteenCorp%20Employee%20CSV.ps1) - Generates the expanded employee dataset for large-scale testing.
* [SteenCorp Final Bulk Ingestion.ps1](Scripts/SteenCorp%20Final%20Bulk%20Ingestion.ps1) - The master script that ingests CSV data to create user objects and assign group memberships.

<details>
  <summary> View Automation & AD Architecture</summary>

  ![OU Structure](Images/01_SteenCorp_OU_Structure.png)
  *The logical Organizational Unit hierarchy designed for SteenCorp HQ.*

  ![Security Group Deployment](Images/02_Security_Group_Deployment.png)
  *Provisioning departmental security groups to manage resource access.*

  ![Master Automation Proof](Images/04_Master_Automation_Proof.png)
  *The Bulk Ingestion script in action, populating the domain in seconds.*
</details>

---

## Network & Domain Validation
Once the directory was live, I performed a "Handshake Validation" to ensure the network stack was resilient and the client integration was complete.

* **Connectivity:** Configured static IP addressing and verified ICMP handshakes.
* **Domain Integration:** Successfully performed a Domain Join for `SC-WIN11-WK01`.
* **Identity Audit:** Performed a departmental audit to ensure all automated users were correctly placed.

<details>
  <summary> View Network & Verification Evidence</summary>

  ![Network Handshake](Images/V2_05_Network_Handshake_Success.jpg)
  *Verified Layer 3 connectivity between the workstation and the Domain Controller.*

  ![Domain Join Confirmation](Images/V2_06_Domain_Verification_Final.png)
  *Official domain join status for the Windows 11 client.*

  ![Sales Dept Verification](Images/03_Sales_Department_Live.png)
  *Confirmed the Sales department is fully populated with the correct user objects.*

  ![Departmental Verification](Images/Screenshot%202026-04-27%20113314.png)
  *Final audit of the automated user ingestion across departmental OUs.*
</details>

---

## Final Operational Success (GPO Deployment)
Phase 1 concluded with the successful application of **Group Policy Objects (GPOs)** to enforce corporate branding and security baselines.

* **Branding:** Deployed the "SteenCorp" corporate wallpaper across the domain.
* **Security:** Verified that standard users (e.g., `jhalpert`) were restricted from administrative system changes.

![Final Success](Images/V3_Final_Operational_Success.png.jpg)
*Successful login for `steencorp\jhalpert` with GPO-enforced wallpaper and security restrictions active.*

---

## Future Roadmap
* **Phase 2:** Automated Resource Management (Mapped Drives & Software Deployment).
* **Phase 3:** Security Operations (Sysmon Deployment & Event Log Analysis).
* **Phase 4:** Remote Access Infrastructure (VPN Configuration & Routing).
