# Phase 4 – Security & Enterprise Controls

## Objective

Implement security controls for the SteenCorp domain environment by separating administrative access, enforcing workstation security policies through Group Policy, and validating security behavior from the client side.

This phase focused on improving the environment after the core Active Directory, access control, Group Policy, and networking foundations were already in place.

---

## Overview

Phase 4 added security and enterprise-style controls to the SteenCorp lab.

Key areas covered:

- Dedicated administrative account creation
- Separation between standard user and admin activity
- Account lockout policy enforcement
- Login security banner configuration
- Workstation security hardening through Group Policy
- UAC/admin elevation testing
- Account lockout and recovery validation

This phase helped show how security controls can be applied through Active Directory and Group Policy, then tested from the user side to confirm they actually work.

---

## Administrative Account Separation

### Implementation

I created a dedicated administrative account instead of relying on the default built-in Administrator account for daily administrative work.

Administrative account created:

```text
adm_christian
```

Group membership:

```text
Domain Admins
```

Location:

```text
SteenCorp_HQ → IT OU
```

This created a cleaner separation between standard user activity and privileged administrative activity.

---

## Why This Matters

Using a dedicated named admin account is better than relying only on a shared or default administrator account.

This supports:

- Better accountability
- Cleaner administrative separation
- Least privilege habits
- Easier auditing and tracking
- Reduced reliance on default administrator accounts
- A foundation for more advanced privileged access models later

This is not a full enterprise tiered admin model yet, but it is an important step toward better privileged identity management.

---

## Administrative Account Validation

I validated that the admin account was created correctly and had the required permissions.

Validation completed:

- Verified `adm_christian` existed in Active Directory
- Confirmed membership in `Domain Admins`
- Successfully signed into the domain using the admin account
- Used the admin account for elevated tasks instead of a standard user account

![Admin Account Created](../Evidence/Validation/ADUC_showing_adm_christian.png)

![Admin Group Membership](../Evidence/Validation/Member_Of_Domain_Admins.png)

![Admin Login](../Evidence/Validation/logged_in_as_adm_christian.png)

---

## Workstation Security Hardening Through Group Policy

### Objective

Use Group Policy to enforce security controls across domain-joined workstations.

The goal was to apply security settings centrally instead of configuring each workstation manually.

---

## Security Controls Implemented

### Account Lockout Policy

I configured an account lockout policy to lock accounts after repeated failed sign-in attempts.

Policy behavior:

- Lock account after 5 failed login attempts
- Help protect against repeated password guessing
- Require administrative action or lockout duration before access is restored

This created a realistic help desk/security scenario that could be validated from a domain-joined workstation.

---

### Login Banner

I configured a pre-login legal notice for domain-joined workstations.

Login banner title:

```text
SteenCorp Security Notice
```

Login banner message:

```text
WARNING: This system is for authorized SteenCorp personnel only. Activities are monitored.
```

![Login Banner](../Evidence/Validation/Login_Banner_SteenCorp.png)

---

### Login Banner GPO Configuration

The login banner was configured through Group Policy under:

```text
Computer Configuration → Policies → Windows Settings → Security Settings → Local Policies → Security Options
```

![GPO Settings](../Evidence/Validation/GPO_Login_Banner_Configured.png)

---

### Screen Lock Policy

I also configured workstation lock behavior to reduce the risk of unattended sessions being left open.

Policy behavior:

- Workstation timeout after 5 minutes
- Password required on resume

This reinforces basic workstation security and reflects a common business security control.

---

## Privileged Access Usage

Administrative elevation was tested using the dedicated admin account.

When elevated permissions were required, the admin account was used instead of granting unnecessary privileges to a standard user.

![UAC Prompt](../Evidence/Validation/UAC_Admin_Elevation_Prompt.png)

This helped validate the difference between normal user permissions and administrative permissions.

---

## Validation and Testing

### Account Lockout Test

I simulated multiple failed login attempts from a standard user account.

Expected behavior:

- User enters the wrong password multiple times
- Account locks after 5 failed attempts
- User cannot continue signing in until the account is recovered

Result:

- Account lockout policy triggered successfully
- Policy enforcement was confirmed from the client side

![Account Lockout](../Evidence/Validation/Account_Lockout_Triggered.png)

---

### Administrative Recovery

After the account was locked, I used administrative access to unlock the account in Active Directory.

This simulated a common help desk workflow:

```text
User locked out
↓
Admin verifies account status
↓
Admin unlocks account
↓
User signs in successfully
```

![Account Unlock](../Evidence/Validation/Account_Unlock_Admin_Action.png)

---

### Access Restoration

After the account was unlocked, the user was able to sign back into the workstation successfully.

![Access Restored](../Evidence/Validation/Account_Access_Restored.png)

---

## What This Demonstrates

This phase demonstrated how security policies can be configured centrally and validated through real user testing.

Skills demonstrated:

- Administrative account separation
- Domain Admin group membership validation
- Group Policy security configuration
- Account lockout policy enforcement
- Login banner configuration
- Workstation lock policy configuration
- UAC/admin elevation testing
- Client-side security validation
- Account lockout troubleshooting and recovery

---

## Connection to Help Desk Scenarios

The security controls from this phase later supported help desk-style troubleshooting scenarios.

Examples:

- Account lockout policy supported user lockout tickets
- Admin account separation supported controlled administrative recovery
- Standard user restrictions supported least privilege testing
- UAC elevation supported approved software installation workflows
- Login and workstation controls reinforced realistic business security behavior

This helped turn the SteenCorp environment from a basic domain lab into a reusable support and troubleshooting environment.

---

## Outcome

By the end of Phase 4, the SteenCorp lab included security controls that could be enforced and validated across domain-joined workstations.

Completed outcome:

- Dedicated administrative account created
- Administrative access separated from standard user activity
- Domain Admin membership validated
- Login banner configured through Group Policy
- Account lockout policy enforced
- Screen lock behavior configured
- UAC/admin elevation tested
- Account lockout and recovery workflow validated
- Environment prepared for help desk ticketing and future security expansion

---

## Key Takeaways

- Administrative accounts should be separated from standard user accounts
- Named admin accounts provide better accountability than relying only on default administrator access
- Group Policy is important for enforcing security settings across workstations
- Security controls should be validated from the client side
- Account lockout policies create realistic help desk and security workflows
- Least privilege should be tested, not assumed
- This phase created the security foundation for later help desk and security-focused projects
