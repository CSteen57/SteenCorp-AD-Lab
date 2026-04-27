# SteenCorp Enterprise Infrastructure Lab
## Project Overview
The SteenCorp project is a comprehensive, virtualized Windows Enterprise environment. This lab serves as a functional proof-of-concept for core system administration tasks, including identity management, platform migration, and automated provisioning.

## Phase 1: Core Identity & Management
🛠 The Technical Pivot: VirtualBox to VMware
Initially launched in Oracle VirtualBox, the project encountered critical hypervisor display driver failures (Black Screen of Death) during Windows 11 provisioning.

Troubleshooting Action: Decided to demote the original Domain Controller and perform a full infrastructure migration to VMware Workstation.

Result: Successfully re-established the SteenCorp.Local forest with improved hardware acceleration and network stability.

Forced removal of the initial domain controller to facilitate a clean migration to VMware.

## Active Directory Architecture & Automation
Rather than manual entry, I utilized PowerShell scripting to ensure the environment was "Production-Ready" and scalable from Day 1.

Identity Management: Built a logical Organizational Unit (OU) structure under SteenCorp_HQ to manage Departments, Groups, and Workstations.

Security Group Strategy: Implemented departmental security groups (e.g., Sales_Users, IT_Staff) to support Role-Based Access Control (RBAC).

Bulk Provisioning: Authored and executed a Master Automation script to ingest 20+ user objects into their respective OUs and automatically assign them to appropriate security groups.

Departmental OU hierarchy designed for granular policy application.

Provisioned Security Groups to manage resource access via group membership.

The "Master Ingestion" script in action, populating the domain and verifying group membership simultaneously.

## Network & Domain Validation
Before deploying policies, I performed a "Handshake Validation" to ensure the network stack was resilient.

Network Connectivity: Configured static IP addressing (192.168.10.10) and verified low-latency ICMP handshakes between the workstation and DC.

Lifecycle Management: Successfully performed a Domain Join for SC-WIN11-WK01.

Privilege Hardening: Verified that Domain Admins were correctly nested into the local Administrators group, ensuring administrative control without compromising the Principle of Least Privilege for standard users.

Verified Layer 3 connectivity between the Windows 11 client and the Domain Controller.

Official domain join confirmation for the Windows 11 workstation.

Security verification: Ensuring Domain Admins have the correct local permissions.

## Final Operational Success
Phase 1 concluded with the successful deployment of a Group Policy Object (GPO) to enforce corporate branding and desktop environments.

Validation: Successfully logged in as a standard user (steencorp\jhalpert).

Enforcement: Confirmed that the "SteenCorp" wallpaper GPO applied automatically upon login.

Security Check: Verified that standard users were restricted from executing administrative network commands (net session), confirming the security baseline is active.

Successful login for Jim Halpert with corporate GPO branding and access restrictions in place.

## Upcoming Phases
Phase 2: Automated Resource Management (Mapped Drives & Software Deployment via GPO).

Phase 3: Security Operations (Sysmon Deployment & Event Log Analysis).

Phase 4: Remote Access Infrastructure (VPN Configuration & Routing).
