# Phase 2 – Access Control, Group Policy & Software Deployment

## Objective

Implement enterprise-style access control and workstation management using Active Directory security groups, Group Policy, mapped network drives, and software deployment.

This phase started with role-based access control (RBAC) for department shares, then expanded into Group Policy software deployment by pushing Google Chrome to domain-joined workstations.

---

## Overview

In this phase, I focused on managing users, workstations, and resources through centralized domain controls.

I implemented:

- Department-based security groups
- Group-based access control
- Mapped network drives through Group Policy
- GPO troubleshooting and OU placement fixes
- Centralized software deployment using Group Policy
- Client-side validation across multiple domain users

This phase helped show how Active Directory and Group Policy can be used to manage access, enforce consistency, and reduce manual workstation configuration.

---

# Part 1 – Role-Based Access Control & Drive Mapping

## Identity & Group Design

Created departmental security groups:

- HR
- IT
- Sales
- Accounting
- Public access

Users were assigned to groups based on department roles.

Instead of assigning permissions directly to individual users, permissions were assigned to security groups.

**Why this matters:**  
Group-based access control is easier to manage, scales better, and reflects how access is commonly handled in enterprise environments.

---

## Resource Design

Created a centralized file share:

```cmd
\\WIN-4CF03BHNDEC\SteenCorp_Shares
```

Built department folders for:

- HR
- IT
- Sales

![Department Folder Structure](../Evidence/Infrastructure/Physical%20Directory%20Structure%20for%20Departmental%20Shares.png)

---

## Initial Drive Mapping

Configured a mapped drive for the Sales department using Group Policy.

- Drive: `S:`
- Path:

```cmd
\\WIN-4CF03BHNDEC\SteenCorp_Shares
```

![Initial Drive Mapping](../Evidence/Validation/GPO%20Drive%20Map%20COnfiguration%20for%20Sales%20Department.png)

---

## Issue Discovered During Validation

While testing from the Windows 11 client, I noticed:

- Other departments did not receive mapped drives
- Drive mapping behavior was inconsistent
- Some access attempts failed

This showed that the RBAC setup was not fully standardized yet.

---

## Root Cause

The issue came from a few problems happening at the same time:

- Drive mappings still pointed to the old server name
- Only the HR mapping was correctly configured
- Drive mappings were split across multiple GPOs:
  - `GPO_MAP_IT_Drive`
  - `GPO_MAP_Sales_Drive`

This created an inconsistent RBAC implementation.

![Incorrect Path](../Evidence/Validation/Incorrect_Path.png)

---

## Solution

I rebuilt and standardized the drive mapping configuration.

### Fixes Applied

- Updated all paths to:

```cmd
\\DC01\SteenCorp_Shares
```

- Consolidated mappings into one GPO:

```cmd
GPO_SteenCorp_Master_Drive_Map
```

- Removed redundant GPOs

---

## Final Drive Mapping Structure

| Department | Drive | Access Group |
|----------|------|--------------|
| HR | H: | HR_Users |
| Sales | S: | Sales_Users |
| IT | I: | IT_Staff |
| Accounting | A: | Accounting_Users |
| Public | P: | Domain Users |

![Updated Drive Maps](../Evidence/Infrastructure/Drive_Maps_Overview.png)

---

## Additional Issue – GPO Not Applying

After fixing the drive mappings, some users still did not receive the mapped drives.

I ran:

```cmd
gpupdate /force
```

The command completed, but the drives still did not appear as expected.

![Validation Attempt](../Evidence/Validation/Validation_Attempt.png)

---

## Root Cause – OU Placement

The Windows 11 client machine was not placed in the correct Organizational Unit.

Because the workstation was not in the correct OU:

- The intended GPOs were not applied
- Drive mappings were not deployed
- The workstation was not receiving the correct policies

---

## Resolution

Moved the client machine to:

```cmd
SteenCorp_HQ → Workstations
```

Then forced a policy update:

```cmd
gpupdate /force
```

![Workstation GPO Update](../Evidence/Validation/The%20Aha%20Moment.png)

---

## Final RBAC Validation

After moving the workstation into the correct OU and applying Group Policy:

- GPOs applied successfully
- Drives mapped correctly
- Access was restricted by department

![Successful GPUpdate](../Evidence/Validation/Final_gpupdate.png)

![Mapped Drives](../Evidence/Validation/V3_Final_Operational_Success%20_2.png)

---

## Permission Validation

Tested administrative command access using:

```cmd
net session
```

Result:

```cmd
Access is denied
```

This was expected because the logged-in user was a standard domain user and did not have administrative privileges.

![Standard User](../Evidence/Validation/V3_Final_Operational_Success.png)

---

# Part 2 – Software Deployment via Group Policy

## Objective

After getting RBAC and mapped drives working, I wanted to test another real-world Group Policy use case: deploying software to domain-joined workstations.

The goal was to deploy Google Chrome through Group Policy so any user logging into a managed workstation would have access to Chrome without needing a manual install.

This helped expand Phase 2 beyond access control and into centralized workstation management.

---

## Software Repository Setup

Downloaded the Google Chrome Enterprise MSI installer and placed it in a centralized software folder on DC01:

```cmd
C:\Software
```

Configured NTFS permissions so domain computers could read and execute the installer.

![Chrome MSI Stored in Software Folder](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_01_MSI_Stored_In_Software_Folder_NTFS_Permissions.png)

![NTFS Permissions for Domain Computers](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_02_NTFS_Domain_Computers_Read_Execute.png)

---

## Issue 1 – Local Path Used Instead of Network Path

During the first deployment attempt, I selected the MSI from the local server path:

```cmd
C:\Software\googlechromestandaloneenterprise64.msi
```

Group Policy warned that this was not a network location.

This mattered because client workstations cannot install software from the server's local `C:\` path. They need a network path that they can reach.

![Local Path Error](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_03_Local_Path_Not_Network_Location_Error.png)

---

## Issue 2 – UNC Path Not Available

I then attempted to use the UNC path:

```cmd
\\DC01\Software\googlechromestandaloneenterprise64.msi
```

At first, the path failed because the folder had not actually been shared correctly.

![UNC Path Not Found](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_04_UNC_Path_Network_Name_Not_Found.png)

---

## Issue 3 – Share Permissions

I initially created the share with only `Domain Computers` having read access.

This made sense for the GPO install because software deployment runs under the computer context, but I could not manually browse to the share as a user or admin account.

![Share Created with Domain Computers Only](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_05_Share_Created_Domain_Computers_Only.png)

![Initial Share Permissions](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_06_Share_Permissions_Domain_Computers_Only.png)

When testing the UNC path manually, access was denied.

![UNC Access Denied](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_07_UNC_Access_Denied_User_Not_Allowed.png)

---

## Share Permission Fix

I attempted to update the share permissions, but the share already existed.

![Net Share Already Exists Error](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_08_Net_Share_Already_Exists_Error.png)

To resolve this cleanly, I deleted and recreated the share with both `Domain Computers` and `Domain Users` having read access.

```cmd
net share Software /delete

net share Software=C:\Software /GRANT:"Domain Users",READ /GRANT:"Domain Computers",READ
```

![Share Recreated with Correct Permissions](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_09_Share_Recreated_With_Correct_Permissions.png)

Final share permissions confirmed:

- Domain Computers: Read
- Domain Users: Read

![Final Share Permissions](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_10_Final_Share_Permissions_Verified.png)

---

## GPO Configuration

Created a dedicated GPO for Chrome deployment:

```cmd
GPO_Deploy_Chrome
```

Linked the GPO to the Workstations OU so it would apply to domain-joined workstation machines.

![GPO Linked to Workstations OU](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_11_GPO_Linked_To_Workstations_OU.png)

Configured security filtering so the policy applied to:

```cmd
Domain Computers
```

![GPO Security Filtering](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_12_GPO_Security_Filtering_Domain_Computers.png)

Added the Chrome MSI under:

```cmd
Computer Configuration → Policies → Software Settings → Software Installation
```

Deployment type:

```cmd
Assigned
```

Source path:

```cmd
\\DC01\Software\googlechromestandaloneenterprise64.msi
```

![Chrome MSI Assigned Using UNC Path](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_13_Chrome_MSI_Assigned_Using_UNC_Path.png)

---

## Policy Application & Troubleshooting

While testing, I originally checked normal user-side Group Policy results with:

```cmd
gpresult /r
```

This showed the user policies, but Chrome was deployed under Computer Configuration.

That meant I needed to verify the computer-side policy instead.

```cmd
gpresult /scope computer /r
```

This confirmed that `GPO_Deploy_Chrome` was applied to the workstation.

![Computer Scope GPResult](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_22_Computer_Scope_GPResult_GPO_Applied.png)

---

## Remote Policy Update Attempt

I also attempted to force Group Policy remotely from DC01.

The remote update returned an RPC error.

![Remote GPUpdate RPC Error](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_16_Remote_GPUpdate_RPC_Error.png)

This showed that a remote policy refresh can fail even when the GPO itself is configured correctly.

I continued validation from the workstation side by forcing policy locally and rebooting.

```cmd
gpupdate /force
```

A restart was required because software assigned through Computer Configuration installs during startup.

---

## Final Software Deployment Validation

After the workstation restarted, Chrome installed successfully.

Because Chrome was deployed at the computer level, it was available to any domain user who logged into that workstation.

Validated with multiple users:

- `steencorp\csteen`
- `steencorp\kkapoor`
- `steencorp\jhalpert`

![Chrome Installed for CSteen](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_18_Chrome_Installed_CSteen_WK02.png)

![Chrome Installed for Kelly Kapoor](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_19_Chrome_Installed_KKapoor_WK01.png)

![Chrome Installed for Jim Halpert](../Evidence/Phase2_Chrome_GPO/Phase2_Chrome_GPO_20_Chrome_Installed_JHalpert_WK01.png)

---

## Key Takeaways

- RBAC requires alignment between users, groups, and resources
- GPO design should be centralized and targeted correctly
- OU placement directly controls policy application
- Group Policy can manage both access control and software deployment
- GPO software deployment must use a UNC path, not a local server path
- Both NTFS permissions and share permissions matter
- Software deployment runs under the computer context, not the logged-in user
- Computer-based policies should be validated with `gpresult /scope computer /r`
- Software assigned through Computer Configuration installs during startup, so a reboot is required
- Once installed at the computer level, the application is available to any user who logs into that workstation
- Client-side validation is critical

---

## Outcome

- Department-based access control implemented
- Consistent drive mapping deployed through Group Policy
- Standard users restricted from administrative commands
- Google Chrome deployed through Group Policy to managed workstations
- Software deployment validated across multiple domain users
- Environment ready for security hardening and help desk simulationx
