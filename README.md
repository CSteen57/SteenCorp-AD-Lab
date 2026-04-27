# SteenCorp Enterprise Infrastructure Lab
## Project Overview
The SteenCorp project is a comprehensive, virtualized Windows Enterprise environment. This lab serves as a functional proof-of-concept for core system administration tasks, including identity management, platform migration, and automated provisioning.

## Phase 1: Core Identity & Management
Initially launched in Oracle VirtualBox, the project encountered critical hypervisor failures (Black Screen of Death) during Windows 11 provisioning.

Troubleshooting Action: Performed a full infrastructure migration to VMware Workstation.

Recovery Strategy: Leveraged a "Script-First" approach to quickly re-establish the domain environment on the new platform, ensuring consistency and speed.

Forced removal of the initial domain controller to facilitate a clean migration to VMware.

## Automation & Infrastructure as Code(IaC)
To ensure the environment was "Production-Ready" and easily repeatable, I developed a series of PowerShell scripts to handle the heavy lifting of domain configuration.

1. Directory & Group Provisioning
Instead of manual OU creation, I authored scripts to build the entire organizational hierarchy and security group infrastructure instantly.

Script: Create-OUs.ps1 - Provisions the SteenCorp_HQ root and departmental sub-OUs (IT, Sales, HR, Accounting, Marketing).

Script: Deploy-Groups.ps1 - Establishes departmental security groups to support Role-Based Access Control (RBAC).

2. Bulk User Ingestion (The Office Simulation)
To test the environment at scale, I simulated a 20+ employee workforce using a CSV-driven ingestion process.

Data Source: Employees.csv - Contains custom objects for employees like Jim Halpert and Dwight Schrute.

Script: Bulk-Ingestion.ps1 - Automates user creation, assigns secure initial passwords, and maps users to their correct departmental OUs and Security Groups simultaneously.

PowerShell automation script authoring in progress.

Successful bulk ingestion of employee data from CSV into Active Directory.

## Network & Domain Validation
Before joining clients to the domain, I automated the local network security posture to ensure reliable communication.

ICMP Validation: Developed a script to enable ICMP (Ping) through the Windows Firewall, allowing for network diagnostics without compromising the overall security profile.

Domain Integration: Successfully performed a Domain Join for SC-WIN11-WK01.

Privilege Verification: Verified that Domain Admins were correctly nested into the local Administrators group, ensuring administrative control while maintaining the Principle of Least Privilege for standard users.

Verified Layer 3 connectivity between the Windows 11 client and the Domain Controller.

Official domain join confirmation for the Windows 11 workstation.

## Final Operational Success
Phase 1 concluded with the successful deployment of a Group Policy Object (GPO) to enforce corporate branding and desktop environments across the new infrastructure.

Validation: Logged in as steencorp\jhalpert.

Enforcement: Confirmed that the "SteenCorp" wallpaper GPO applied automatically.

Security Baseline: Verified standard users are restricted from administrative commands, confirming a healthy security posture.

Successful login for Jim Halpert with corporate GPO branding and access restrictions in place.

## Upcoming Phases
Phase 2: Automated Resource Management (Mapped Drives & Software Deployment via GPO).

Phase 3: Security Operations (Sysmon Deployment & Event Log Analysis).

Phase 4: Remote Access Infrastructure (VPN Configuration & Routing).
