# SteenCorp Active Directory Employee Onboarding Tool
# Purpose: Standardize the creation and configuration of new employee accounts

Import-Module ActiveDirectory -ErrorAction Stop

# Collect employee information
$firstName = Read-Host "Enter the employee's first name"
$lastName = Read-Host "Enter the employee's last name"
$department = Read-Host "Enter the department"
$title = Read-Host "Enter the employee's job title"

# Build the employee's display name and username
$fullName = "$firstName $lastName"
$username = ($firstName.Substring(0, 1) + $lastName).ToLower()

# Review the generated employee information
[PSCustomObject]@{
    Name       = $fullName
    Username   = $username
    Department = $department
    Title      = $title
}

# Match the department to the correct OU and security group
switch ($department.ToLower()) {
    "sales" {
        $ouPath = "OU=Sales,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"
        $groupName = "Sales_Users"
    }
    "hr" {
        $ouPath = "OU=HR,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"
        $groupName = "HR_Users"
    }
    "it" {
        $ouPath = "OU=IT,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"
        $groupName = "IT_Staff"
    }
    "marketing" {
        $ouPath = "OU=Marketing,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"
        $groupName = "Marketing_Team"
    }
    "accounting" {
        $ouPath = "OU=Accounting,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"
        $groupName = "Accounting_Users"
    }
    default {
        Write-Error "Invalid department: $department. No account was created."
        return
    }
}

# Review the selected AD destination
[PSCustomObject]@{
    OrganizationalUnit = $ouPath
    SecurityGroup      = $groupName
}

# Validate the selected OU and security group
try {
    Get-ADOrganizationalUnit -Identity $ouPath -ErrorAction Stop | Out-Null
    Get-ADGroup -Identity $groupName -ErrorAction Stop | Out-Null
}
catch {
    Write-Error "AD destination validation failed: $($_.Exception.Message)"
    return
}

Write-Host "The OU and security group were validated successfully." -ForegroundColor Green

# Stop if the generated username already exists
$existingAccount = Get-ADUser -Filter "SamAccountName -eq '$username'"

if ($existingAccount) {
    Write-Error "The username $username already exists. No account was created."
    return
}

Write-Host "The username $username is available." -ForegroundColor Green

# Securely collect a temporary password
$temporaryPassword = Read-Host "Enter a temporary password" -AsSecureString

# Store the New-ADUser parameters in a hashtable
$newUserParameters = @{
    Name                  = $fullName
    GivenName             = $firstName
    Surname               = $lastName
    SamAccountName        = $username
    UserPrincipalName     = "$username@SteenCorp.Local"
    Department            = $department
    Title                 = $title
    Path                  = $ouPath
    AccountPassword       = $temporaryPassword
    Enabled               = $true
    ChangePasswordAtLogon = $true
}

try {
    # Create the account and assign department access
    New-ADUser @newUserParameters -ErrorAction Stop
    Add-ADGroupMember -Identity $groupName -Members $username -ErrorAction Stop

    Write-Host "`nThe account for $fullName was created successfully." -ForegroundColor Green

    # Retrieve and display the completed account
    $newUser = Get-ADUser -Identity $username -Properties Department, Title -ErrorAction Stop

    $newUser |
        Select-Object Name, SamAccountName, UserPrincipalName,
            Department, Title, Enabled, DistinguishedName

    # Display the employee's group memberships
    Write-Host "`nGroup memberships:" -ForegroundColor Cyan

    Get-ADPrincipalGroupMembership -Identity $username -ErrorAction Stop |
        Select-Object Name
}
catch {
    Write-Error "Employee onboarding failed: $($_.Exception.Message)"
}
