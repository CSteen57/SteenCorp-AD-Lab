# SteenCorp Enterprise Infrastructure Lab
## Project Overview
The **SteenCorp** project is a virtualized Windows Enterprise environment designed to demonstrate core system administration skills. This lab features a full-stack deployment of Active Directory, automated user provisioning via PowerShell, and security hardening through Group Policy.

## Phase 1: Foundation & Migration

### 🛠 The Technical Pivot: VirtualBox to VMware
The project initially launched in Oracle VirtualBox but encountered critical display driver failures (Black Screen of Death) during Windows 11 provisioning. 
* **Action:** Performed a platform migration to **VMware Workstation**.
* **Outcome:** Successfully re-established the `SteenCorp.Local` forest with significantly improved hardware acceleration and stability.

<details>
  <summary>📸 View Migration Documentation</summary>

  ![Migration Attempt](images/Screenshot%202026-04-13%20120545.png)
  *Initial VirtualBox boot failure documented during the troubleshooting phase.*
</details>

---

### 💻 Infrastructure as Code (PowerShell Automation)
To ensure the environment was scalable and easily repeatable after the migration, I moved away from manual configuration in favor of **PowerShell Automation**.

**Featured Scripts (Located in /scripts):**
* `Create-OUs.ps1`: Automated the deployment of the `SteenCorp_HQ` root and departmental sub-OUs.
* `Group-Infrastructure.ps1`: Established security groups (IT, Sales, HR) to support Role-Based Access Control (RBAC).
* `Bulk-Ingestion.ps1`: A master script that ingests employee data from a CSV, creates user objects, and assigns group memberships simultaneously.

<details>
  <summary>📸 View Automation & AD Architecture</summary>

  ![OU Structure](images/01_SteenCorp_OU_Structure.png)
  *Final Organizational Unit hierarchy for SteenCorp HQ.*

  ![Automation Proof](images/04_Master_Automation_Proof.png)
  *PowerShell console showing successful bulk ingestion of the "The Office" employee dataset.*
</details>

---

### 🌐 Network & Security Validation
Before finalizing Phase 1, I performed a "Handshake Validation" to ensure the network stack was resilient and secure.
* **Connectivity:** Configured static IP addressing and verified ICMP handshakes between the workstation and DC.
* **Domain Integration:** Successfully performed a Domain Join for the Windows 11 client.
* **Privilege Hardening:** Verified Domain Admin nesting into local Administrators groups while maintaining standard user restrictions.

<details>
  <summary>📸 View Network & Verification Evidence</summary>

  ![Domain Join](images/V2_06_Domain_Verification_Final.png)
  *Official domain join confirmation for the workstation SC-WIN11-WK01.*
</details>

---

### ✅ Final Operational Success
Phase 1 concluded with the successful application of Group Policy Objects (GPOs) to enforce corporate branding and security baselines.

![Final Success](images/V3_Final_Operational_Success.png.jpg)
*Successful login for `steencorp\jhalpert` with GPO-enforced wallpaper and restricted administrative access.*

---

## 🚀 Future Roadmap
* **Phase 2:** Mapped Drives & Software Deployment via GPO.
* **Phase 3:** Security Operations (Sysmon & Event Log Analysis).
* **Phase 4:** Remote Access (VPN Configuration).
