# Phase 2 – Role-Based Access Control (RBAC)

## Objective
Set up department-based access so users only have access to what they’re supposed to, and actually test that it works from the client side.

---

## What I Built

- Created security groups for each department (HR, IT, Sales)
- Assigned users to groups based on role
- Used groups instead of individual permissions to keep it scalable
- Built out a shared folder environment to test access control

---

## Implementation

### Security Group Setup

Instead of assigning permissions user-by-user, I created security groups for each department and added users to the appropriate groups.

This is how access is typically managed in real environments to keep things clean and scalable.

![Security Groups](../Evidence/Infrastructure/02_Security_Group_Deployment.png)

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
