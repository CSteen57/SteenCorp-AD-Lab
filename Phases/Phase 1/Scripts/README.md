# Scripts

This folder contains PowerShell scripts used to automate parts of the SteenCorp Enterprise IT Lab.

The current scripts focus on Phase 1 infrastructure automation, including Active Directory OU creation, security group creation, test employee generation, and bulk user provisioning.

---

## Directory Structure

<pre>
Scripts/
│
├── README.md
│
└── Phase1_Infrastructure/
    ├── SteenCorp OU Infrastructure Setup.ps1
    ├── SteenCorp Group Infrastructure.ps1
    ├── Create Mega SteenCorp Employee CSV.ps1
    └── SteenCorp Final Bulk Ingestion.ps1
</pre>

---

## Phase 1 Infrastructure Scripts

| Script | Purpose |
|---|---|
| `SteenCorp OU Infrastructure Setup.ps1` | Creates the main Active Directory OU structure for the SteenCorp domain |
| `SteenCorp Group Infrastructure.ps1` | Creates department-based security groups used for access control |
| `Create Mega SteenCorp Employee CSV.ps1` | Generates CSV-based employee data for bulk user provisioning |
| `SteenCorp Final Bulk Ingestion.ps1` | Imports users into Active Directory from the generated CSV file |

---

## What These Scripts Demonstrate

- PowerShell automation
- Active Directory administration
- Organizational Unit creation
- Security group creation
- CSV-based user provisioning
- Repeatable infrastructure deployment
- Reduced manual configuration
- Scalable lab setup for future phases

---

## Why This Matters

Instead of manually creating every OU, group, and user through Active Directory Users and Computers, these scripts automate the foundation of the SteenCorp domain.

This made the lab easier to rebuild, easier to expand, and more realistic for a business-style environment.

---

## Future Script Expansion

Planned future script areas may include:

- Domain health checks
- Group Policy validation
- User and group auditing
- Security policy auditing
- Workstation inventory checks
- Help desk support scripts

Future scripts will be added as the SteenCorp lab expands.
