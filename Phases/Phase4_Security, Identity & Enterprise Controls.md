# Phase 4 – Security & Enterprise Controls

## Status
🚧 In Progress

---

## Objective
Implement enterprise-level security practices within the SteenCorp environment by introducing privileged identity management, workstation hardening through Group Policy, and automated network configuration using DHCP.

---

## Overview

Phase 4 focuses on securing and operationalizing the environment after core infrastructure, access control, and networking have been established.

In this phase, I:
- Implemented a dedicated administrative account following best practices
- Applied workstation security policies using Group Policy
- Deployed and validated DHCP for automated network configuration
- Tested security enforcement from the end-user perspective

This phase represents the transition from a functional environment to a secure and manageable enterprise system.

---

## A. Professional Identity Management (Tiered Admin)

### Implementation

- Created a dedicated administrative account:
  adm_christian

- Added the account to:
  Domain Admins

- Avoided using the default Administrator account for daily operations

---

### Why This Matters

- Reduces risk of targeting the default Administrator account
- Provides accountability for administrative actions
- Aligns with enterprise security best practices (least privilege and auditing)

---

### Validation

- Successfully logged into DC01 using:
  STEENCORP\adm_christian

### Screenshots to Include

- ADUC showing adm_christian
- Group membership (Domain Admins)
- Logged-in session as adm_christian

---

## B. Workstation Security Hardening (Group Policy)

### Implementation

Created and linked a Group Policy Object:

SteenCorp_Workstation_Policy

Applied to:

SteenCorp_HQ → Workstations

---

### Security Controls Implemented

Account Lockout Policy
- Lock account after 5 failed attempts

Legal Notice (Login Banner)
- Displays warning before login
- Example: "WARNING: Authorized SteenCorp personnel only"

Screen Lock Policy
- Timeout set to 5 minutes
- Password required on resume

---

### Why This Matters

- Protects against brute-force login attempts
- Prevents unauthorized workstation access
- Enforces consistent security policies

---

### Validation

- Triggered account lockout after failed logins
- Verified login banner appears
- Confirmed screen lock enforcement

### Screenshots to Include

- Account lockout message
- Login warning banner
- GPO settings view

---

## C. DHCP Role Implementation

### Implementation

Installed and configured DHCP on DC01.

---

### Scope Configuration

- Range: 192.168.10.100 – 192.168.10.200
- Gateway: 192.168.10.1
- DNS Server: 192.168.10.10
- Domain Name: SteenCorp.local

---

### Why This Matters

- Eliminates manual IP configuration
- Ensures consistent network settings
- Supports scalability

---

### Validation

From Windows 11 client:

ipconfig /all

Verified:
- IP in DHCP range (.100+)
- DHCP Server = DC01
- DNS Server = DC01

### Screenshots to Include

- DHCP Scope configuration
- Server Manager DHCP role
- ipconfig /all output

---

## Final Validation

- Administrative access is secured and auditable
- Workstation policies are enforced
- DHCP is distributing IP addresses correctly
- Security controls validated from client perspective

---

## What I Learned

- Default admin accounts should not be used in production
- GPO is critical for enforcing security at scale
- Security must be layered on top of functionality
- DHCP simplifies network management
- Validation from the user perspective is essential

---

## Outcome

- Secure administrative access model implemented
- Workstation security policies enforced via GPO
- DHCP fully operational
- Environment aligned with enterprise security practices
