# --- SteenCorp Group Infrastructure ---
# Purpose: Create security groups for department access and management

$groupPath = "OU=Groups,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"

# Define group names
$groups = @(
    "IT_Staff",
    "Sales_Users",
    "HR_Users",
    "Accounting_Users",
    "Marketing_Team",
    "Executive_Management"
)

# Deployment loop
foreach ($g in $groups) {
    if (!(Get-ADGroup -Filter "Name -eq '$g'")) {
        New-ADGroup -Name $g `
                    -GroupScope Global `
                    -GroupCategory Security `
                    -Path $groupPath
        Write-Host "Deployed Group: $g" -ForegroundColor Cyan
    }
}

Write-Host "Security Groups are live in SteenCorp_HQ." -ForegroundColor Green