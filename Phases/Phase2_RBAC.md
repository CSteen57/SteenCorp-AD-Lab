# Phase 2 – Role-Based Access Control (RBAC)

## Objective
Design and implement role-based access control (RBAC) to restrict user access based on department roles and validate that permissions are enforced from the client side.

---

## Implementation

### Identity & Group Design

- Created departmental security groups (HR, IT, Sales) to represent organizational roles  
- Assigned users to groups based on department membership  
- Used group-based access control instead of individual user permissions to ensure scalability and maintainability  

---

### Resource Design

- Built a centralized shared directory (`SteenCorp_Shares`) to simulate a company file server  
- Created department-specific folders (HR, IT, Sales) to represent isolated business data  

---

### Department-Based Access (Live Testing)

After setting up groups, I tested access from the domain-joined Windows 11 client.

I logged in as different users and verified:
- Users could access their own department resources
- Users could NOT access other department folders

This confirmed that group-based access control was working correctly.

![Sales Department](../Evidence/Validation/03_Sales_Department_Live.png)

### Permission Validation (Standard User Restrictions)

To test access beyond just file permissions, I logged in as a Sales user (`jhalpert`) and tried running the `net session` command.

This command requires administrative privileges, and the result was:

- System error 5 has occurred
- Access is denied

This confirmed the account is operating as a standard user and does not have elevated permissions.

![Standard User Restricted](../Evidence/Validation/V3_Final_Operational_Success.png)
---

## What I Learned / Why It Matters

- Managing permissions through groups is way more efficient than assigning users directly
- RBAC (Role-Based Access Control) makes environments easier to scale and maintain
- Testing from the client side is important — not just setting it up on the server and assuming it works

---

## Outcome

- Users successfully segmented by department
- Group-based access control implemented and tested
- Environment ready for GPO deployment and further restriction
