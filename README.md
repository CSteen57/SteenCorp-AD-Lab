# SteenCorp Enterprise Infrastructure Lab
## Project Overview
This lab demonstrates the end-to-end deployment of a Windows-based enterprise environment. The goal was to move beyond basic virtualization and implement a functional "Production-Ready" network architecture focusing on Identity Management, Security Baselines, and Automated Configuration.

## Phase 1: Core Identity & Management
### Infrastructure & Connectivity
* **Hypervisor:** Migrated environment from VirtualBox to **VMware Workstation** for enhanced performance and snapshot stability.
* **Domain Controller:** Deployed **Windows Server 2022** as the primary DC for the `steencorp.local` forest.
* **Client Integration:** Provisioned a **Windows 11 Pro** workstation and successfully performed a Domain Join to bring the asset under centralized management.

### Technical Milestones
* **Active Directory (AD DS):** Configured DNS and established Organizational Units (OUs) for logical user management.
* **Group Policy Engineering:** Designed and deployed GPOs for corporate branding (Desktop Wallpaper) and verified replication across the domain.
* **Security & Permissions:** Implemented NTFS and Share permissions; validated "Least Privilege" access by successfully troubleshooting "Access Denied" errors during user testing.

## Documentation & Evidence
*(Screenshots will go here - See Step 4)*
