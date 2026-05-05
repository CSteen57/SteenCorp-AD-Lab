# --- SteenCorp OU Infrastructure Setup ---
# Purpose: Creates the main Active Directory OU structure for the SteenCorp domain

Import-Module ActiveDirectory

$domain = "DC=SteenCorp,DC=Local"
$hqName = "SteenCorp_HQ"
$hqPath = "OU=$hqName,$domain"

# Setup the main Root OU
New-ADOrganizationalUnit -Name $hqName -Path $domain -ProtectedFromAccidentalDeletion $false

# Create Sub-Containers
$containers = @("Departments", "Groups", "Workstations")
foreach ($c in $containers) {
    New-ADOrganizationalUnit -Name $c -Path $hqPath -ProtectedFromAccidentalDeletion $false
}

# Populate Depts
$deptPath = "OU=Departments,$hqPath"
$depts = @("IT", "Sales", "HR", "Accounting", "Marketing")

foreach ($d in $depts) {
    New-ADOrganizationalUnit -Name $d -Path $deptPath -ProtectedFromAccidentalDeletion $false
    Write-Host "Deployed Dept: $d"
}

Write-Host "Domain structure for SteenCorp is live." -ForegroundColor Green