# Phase 2: Role-Based Access Control (RBAC)

## Objective
Implement secure access control using Active Directory groups, NTFS permissions, and Group Policy.

---

## What I Implemented
- Security group creation per department
- Centralized file share structure
- NTFS and Share permission configuration
- Group Policy Object (GPO) drive mapping

---

## Key Configurations

### Departmental File Shares
Created centralized file shares for HR, IT, and Sales.

![File Shares](../Evidence/Infrastructure/04_File_Share_Structure.png)

---

### NTFS Permissions
Configured folder-level permissions based on department roles.

![NTFS Permissions](../Evidence/Infrastructure/06_NTFS_Permissions.png)

---

### GPO Drive Mapping
Mapped network drives automatically based on user role.

![GPO Drive Mapping](../Evidence/Infrastructure/07_GPO_Drive_Mapping.png)

---

## Validation
- Verified drive mapping on user login  
- Confirmed access restrictions between departments  
- Tested least privilege access model  

---

## Outcome
Implemented a scalable RBAC model that enforces secure and structured access across the organization.
