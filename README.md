# SteenCorp Enterprise Infrastructure Lab

## Objective
Build and validate a simulated enterprise Active Directory environment that demonstrates real-world system administration, access control, and troubleshooting skills.

---

## What This Project Demonstrates

- Active Directory administration
- Role-Based Access Control (RBAC)
- Group Policy configuration and enforcement
- DNS and DHCP configuration
- Troubleshooting real infrastructure issues
- Help desk–level user and access validation

---

## Overview

This lab simulates a real enterprise IT environment using a Windows Server domain controller and a domain-joined client.

The focus was not just building infrastructure, but understanding how systems interact — and how to troubleshoot when things break.

Throughout the project, I:
- Implemented core domain services
- Applied access control and security policies
- Diagnosed and resolved real configuration issues
- Validated functionality from the end-user perspective

---

## Environment

- Windows Server 2022 (Domain Controller)
- Windows 11 Pro (Domain-Joined Client)
- VMware Workstation

---

## Project Roadmap

| Phase | Status | Focus | Outcome |
|------|--------|------|--------|
| Phase 1: Foundation | Completed | Domain setup, AD DS, virtualization | Built a fully functional domain environment |
| Phase 2: RBAC & GPO | Completed | Access control, drive mapping, policy enforcement | Implemented and validated RBAC with real troubleshooting |
| Phase 3: Networking & Troubleshooting | In Progress | DNS, DHCP, IP management, issue resolution | Validating and troubleshooting core network services |

---

## Lab Progression

- **Phase 1:** Built the domain and automated identity structure  
- **Phase 2:** Implemented access control and resolved real GPO/RBAC issues  
- **Phase 3:** Focused on networking services and infrastructure troubleshooting  

This mirrors how real enterprise environments are deployed, validated, and maintained.

---

## Phase Highlights

### Phase 1 – Foundation & Environment Setup

- Deployed domain controller (`steencorp.local`)
- Configured Active Directory Domain Services (AD DS)
- Joined client machine and validated authentication
- Automated OU, user, and group creation with PowerShell
- Migrated from VirtualBox → VMware for stability

**Outcome:**  
A stable, scalable domain environment ready for policy enforcement

➡️ [View Full Phase 1 Documentation](Phases/Phase1_Foundation.md)

---

### Phase 2 – RBAC & Group Policy

- Implemented department-based RBAC using security groups
- Built centralized file shares with NTFS permissions
- Configured GPO drive mapping for automated user access
- Diagnosed and resolved:
  - Broken UNC paths after server rename
  - Fragmented GPO design
  - GPO not applying due to incorrect OU placement

**Outcome:**  
Fully functional RBAC system with centralized, consistent policy enforcement

➡️ [View Full Phase 2 Documentation](Phases/Phase2_RBAC.md)

---

### Phase 3 – Networking & Troubleshooting

- Configured DHCP scopes and reservations
- Implemented DNS forward and reverse lookup zones
- Added DNS forwarders for external resolution
- Diagnosed:
  - BAD_ADDRESS conflicts
  - VMware NAT issues
  - DNS resolution failures

**Outcome:**  
Validated and stabilized network services supporting the domain

---

## Automation (PowerShell)

- Automated OU and security group creation
- Used CSV-driven user provisioning
- Implemented bulk user import scripts

**Why it matters:**  
Demonstrates ability to scale and manage enterprise environments efficiently

---

## Validation & Testing

- Verified domain join and authentication
- Tested RBAC and access restrictions
- Validated GPO enforcement
- Confirmed DNS and DHCP functionality
- Performed client-side testing and troubleshooting

---

## Final Result

- Fully operational Active Directory domain
- RBAC enforced across departments
- Group Policy applied successfully
- Network services configured and validated
- Client systems properly authenticated and managed

---

## Key Takeaways

- Infrastructure changes can impact dependent services (e.g., GPO paths)
- Centralized policy design improves consistency and manageability
- Troubleshooting is as critical as configuration
- DNS and DHCP are foundational to domain functionality
- End-user validation is essential for confirming system behavior
