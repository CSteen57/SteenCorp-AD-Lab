# Phase 2 – Role-Based Access Control (RBAC)

## Objective
Design and implement role-based access control (RBAC) using Active Directory security groups and validate access through mapped network drives.

---

## Implementation

### Identity & Group Design

- Created departmental security groups:
  - HR
  - IT
  - Sales
- Assigned users based on department roles
- Used group-based permissions instead of assigning access directly to users

**Why this matters:**  
Group-based RBAC is scalable, easier to manage, and reflects real enterprise identity practices.

---

### Resource Design

- Created centralized file share:
  \\WIN-4CF03BHNDEC\SteenCorp_Shares

- Built department folders:
  - HR
  - IT
  - Sales

![Department Folder Structure](../Evidence/Infrastructure/Physical%20Directory%20Structure%20for%20Departmental%20Shares.png)

---

### Initial Drive Mapping

Configured a mapped drive for the Sales department using Group Policy.

- Drive: S:
- Path:
  \\WIN-4CF03BHNDEC\SteenCorp_Shares

![Initial Drive Mapping](../Evidence/Validation/GPO%20Drive%20Map%20COnfiguration%20for%20Sales%20Department.png)

---

## Issue Discovered During Validation

Testing from the Windows 11 client revealed:

- Other departments did not receive mapped drives  
- Drive mapping behavior was inconsistent  
- Some access attempts failed  

---

## Root Cause

- Drive mappings still pointed to the old server name
- Only HR mapping was correctly configured  
- Drive mappings were split across multiple GPOs:
  - GPO_MAP_IT_Drive
  - GPO_MAP_Sales_Drive

This created an inconsistent RBAC implementation.

![Incorrect Path](../Evidence/Validation/Incorrect_Path.png)

---

## Solution

Rebuilt and standardized the drive mapping configuration.

### Fixes Applied

- Updated all paths to:
  \\DC01\SteenCorp_Shares

- Consolidated mappings into a single GPO:
  GPO_SteenCorp_Master_Drive_Map

- Removed redundant GPOs

---

### Final Drive Mapping Structure

| Department | Drive | Access Group |
|----------|------|--------------|
| HR       | H:   | HR_Users |
| Sales    | S:   | Sales_Users |
| IT       | I:   | IT_Staff |
| Accounting | A: | Accounting_Users |
| Public   | P:   | Domain Users |

![Updated Drive Maps](../Evidence/Infrastructure/Drive_Maps_Overview.png)

---

## Additional Issue – GPO Not Applying

- Drives were still missing for some users  
- gpupdate /force did not resolve the issue  

![Validation Attempt](../Evidence/Validation/Validation_Attempt.png)

---

## Root Cause (GPO Application)

The client machine was not placed in the correct OU.

- GPOs were not applied  
- Drive mappings were not deployed  

---

## Resolution

- Moved machine to:
  SteenCorp_HQ → Workstations

- Forced policy update:
  gpupdate /force

![Workstation GPO Update](../Evidence/Validation/The%20Aha%20Moment.png)

---

## Final Validation

- GPO applied successfully  
- Drives mapped correctly  
- Access restricted by department  

![Successful GPUpdate](../Evidence/Validation/Final_gpupdate.png)
![Mapped Drives](../Evidence/Validation/V3_Final_Operational_Success%20_2.png)

---

## Permission Validation

Tested:
net session

Result:
Access denied (expected for standard users)

![Standard User](../Evidence/Validation/V3_Final_Operational_Success.png)

---

## Key Takeaways

- RBAC requires alignment between users, groups, and resources  
- GPO design must be centralized  
- OU placement directly controls policy application  
- Client validation is critical  

---

## Outcome

- Department-based access control implemented  
- Consistent drive mapping via GPO  
- Environment ready for security hardening 
