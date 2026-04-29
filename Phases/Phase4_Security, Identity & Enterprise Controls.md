# Phase 4 – Security & Enterprise Controls

## Objective
Implement enterprise-level security practices by introducing privileged identity management and enforcing workstation security through Group Policy.

---

## Overview

This phase focuses on securing the environment after core infrastructure, access control, and networking were established.

Key implementations:
- Dedicated administrative account (tiered admin model)
- Workstation hardening through Group Policy
- Real-world security validation through user testing

---

## A. Professional Identity Management (Tiered Admin)

### Implementation

Created a dedicated administrative account to avoid using the default Administrator account.

- User created:
  adm_christian

- Group membership:
  Domain Admins

- Location:
  SteenCorp_HQ → IT OU

---

### Why This Matters

- Default Administrator accounts are common attack targets  
- Named admin accounts provide accountability  
- Supports least privilege and auditing practices  

---

### Validation

- Verified account creation in Active Directory  
- Confirmed Domain Admins group membership  
- Successfully logged into the domain using the admin account  

---

### Evidence

![Admin Account Created](../Evidence/Validation/ADUC_showing_adm_christian.png)

![Admin Group Membership](../Evidence/Validation/Member_Of_Domain_Admins.png)

![Admin Login](../Evidence/Validation/logged_in_as_adm_christian.png)

---

## B. Workstation Security Hardening (Group Policy)

### Objective
Enforce security policies across domain-joined workstations to control user behavior and protect against unauthorized access.

---

## Security Controls Implemented

### Account Lockout Policy

- Lock account after 5 failed login attempts  
- Prevents brute-force password attacks  

---

### Login Banner (Legal Notice)

Configured a pre-login warning:

- Title:
  SteenCorp Security Notice

- Message:
  WARNING: This system is for authorized SteenCorp personnel only. Activities are monitored.

![Login Banner](../Evidence/Validation/Login_Banner_SteenCorp.png)

---

### GPO Configuration

Configured within:

Computer Configuration → Policies → Windows Settings → Security Settings → Local Policies → Security Options

![GPO Settings](../Evidence/Validation/GPO_Login_Banner_Configured.png)

---

### Screen Lock Policy

- Timeout: 5 minutes  
- Password required on resume  

---

### Privileged Access Usage

Used the dedicated admin account (adm_christian) to perform elevated administrative actions, including forcing Group Policy updates.

![UAC Prompt](../Evidence/Validation/UAC_Admin_Elevation_Prompt.png)

---

## Validation & Testing

### Account Lockout & Recovery Workflow

Simulated multiple failed login attempts from a standard user account.

- Account locked after 5 incorrect attempts  
- Confirmed policy enforcement  

![Account Lockout](../Evidence/Validation/Account_Lockout_Triggered.png)

---

### Administrative Intervention

- Unlocked the account using the admin account in Active Directory  

![Account Unlock](../Evidence/Validation/Account_Unlock_Admin_Action.png)

---

### Access Restoration

- User successfully logged back in after account recovery  

![Access Restored](../Evidence/Validation/Account_Access_Restored.png)

---

## What This Demonstrates

- Enforcement of account lockout policies  
- Protection against brute-force attacks  
- Proper use of administrative privilege separation  
- Real-world troubleshooting workflow (lockout → admin fix → restore access)  

---

## Key Takeaways

- Administrative accounts should be separated from standard users  
- Group Policy is critical for enforcing security at scale  
- Security controls must be validated from the client side  
- Proper privilege usage is essential in enterprise environments  

---

## Outcome

- Secure administrative access model implemented  
- Workstation security policies enforced through Group Policy  
- User authentication behavior controlled and validated  
- Environment aligned with enterprise security practices  
