# PowerShell Automation

This folder contains the PowerShell scripts used to build and administer the SteenCorp Active Directory environment. The work began with infrastructure deployment and bulk provisioning, then progressed into a safer tool for onboarding individual employees.

## Automation Progression

| Script | Purpose |
|---|---|
| [SteenCorp OU Infrastructure Setup](./SteenCorp%20OU%20Infrastructure%20Setup.ps1) | Creates the root, department, group, and workstation OUs |
| [SteenCorp Group Infrastructure](./SteenCorp%20Group%20Infrastructure.ps1) | Creates the security groups used for department access |
| [Create Mega SteenCorp Employee CSV](./Create%20Mega%20SteenCorp%20Employee%20CSV.ps1) | Generates structured employee data for bulk provisioning |
| [SteenCorp Final Bulk Ingestion](./SteenCorp%20Final%20Bulk%20Ingestion.ps1) | Imports employees, places them in department OUs, and assigns security groups |
| [New SteenCorp Employee](./New_SteenCorpEmployee.ps1) | Safely onboards one employee and verifies the completed AD configuration |

---

## Reusable Employee Onboarding Tool

After using bulk provisioning to populate the original lab, I created `New_SteenCorpEmployee.ps1` for ongoing employee onboarding. It replaces a series of manual AD tasks with one consistent workflow while still validating each important decision before the account is created.

The tool:

1. Collects the employee's name, department, and job title.
2. Generates and checks the username.
3. Maps the department to the correct OU and security group.
4. Confirms that the OU and group exist.
5. Securely collects a temporary password.
6. Creates the enabled account and requires a password change at first sign-in.
7. Assigns department access and displays the completed account for verification.

### PowerShell Concepts Practiced

- Variables and string handling
- `switch` logic for department mapping
- Custom objects for readable output
- Splatting with a parameter hashtable
- Active Directory cmdlets and the PowerShell pipeline
- `try/catch` with `-ErrorAction Stop`
- Duplicate account protection
- Final account and group verification

### Successful Onboarding

Karen Filippelli was onboarded as a Sales employee during the final end-to-end test. The script created `kfilippelli`, populated the department and title, placed the account in the Sales OU, added `Sales_Users`, and displayed the finished configuration.

<img src="../../../Evidence/Automation/powershell-successful-employee-onboarding.png" alt="Successful PowerShell employee onboarding for Karen Filippelli" width="850">

### Independent AD Verification

Active Directory Users and Computers confirmed that Karen was placed in the Sales OU and received the expected `Sales_Users` membership. `Domain Users` remained her normal primary group.

<img src="../../../Evidence/Automation/powershell-ad-ou-placement-and-group-verification.png" alt="Karen Filippelli in the Sales OU with Sales Users group membership" width="850">

---

## From Individual Commands to a Reusable Tool

Before building the onboarding tool, I used `Get-ADUser` and `Set-ADUser` to find and correct incomplete employee attributes. That exercise showed how PowerShell could inspect and modify AD data, then verify the result. I used the same pattern when building the complete onboarding workflow.

| Before | After |
|---|---|
| <img src="../../../Evidence/Automation/powershell-ad-attributes-before.png" alt="Jim Halpert before department and title attribute cleanup" width="410"> | <img src="../../../Evidence/Automation/powershell-ad-attributes-after.png" alt="Jim Halpert after department and title attribute cleanup" width="410"> |
| Department and title were missing. | `Set-ADUser` populated both attributes, and `Get-ADUser` verified the change. |

---

## Safety and Validation Testing

I tested both the successful path and conditions that should stop the workflow:

- An existing username stops the script before password collection or account creation.
- An unsupported department stops the script before an OU or security group is selected.
- The script only reports successful onboarding after account creation and group assignment are complete.

<details>
<summary>View validation evidence</summary>

| Duplicate Username Protection | Invalid Department Validation |
|---|---|
| <img src="../../../Evidence/Automation/powershell-duplicate-username-protection.png" alt="PowerShell duplicate username protection" width="410"> | <img src="../../../Evidence/Automation/powershell-invalid-department-validation.png" alt="PowerShell invalid department validation" width="410"> |

</details>

---

## Planned PowerShell Practice

The next two automations will expand the lab without repeating the onboarding workflow:

| Project | Goal | New PowerShell Practice |
|---|---|---|
| Employee Offboarding Tool | Disable a selected account, remove department access, move it to a Disabled Users OU, and verify the final state | Confirmation prompts, arrays, loops, group exclusions, timestamps, and `Move-ADObject` |
| RBAC Access Audit | Compare each employee's department, OU placement, and department group membership, then flag mismatches in a CSV report | Read-only auditing, calculated properties, reusable functions, conditional results, and `Export-Csv` |

These projects will be documented as completed only after their successful and failure paths have been tested in the lab.
