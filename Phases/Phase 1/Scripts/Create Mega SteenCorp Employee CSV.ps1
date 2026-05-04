# --- Create Mega SteenCorp Employee CSV ---
# Purpose: Generates CSV-based employee data for bulk user provisioning
# Expanding Sales and Accounting for a more realistic scale

$Employees = @(
    # --- SALES (Expanded) ---
    [PSCustomObject]@{FirstName="Sarah"; LastName="Miller"; Username="smiller"; GroupName="Sales_Users"; OUPath="OU=Sales,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Jim"; LastName="Halpert"; Username="jhalpert"; GroupName="Sales_Users"; OUPath="OU=Sales,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Dwight"; LastName="Schrute"; Username="dschrute"; GroupName="Sales_Users"; OUPath="OU=Sales,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Phyllis"; LastName="Vance"; Username="pvance"; GroupName="Sales_Users"; OUPath="OU=Sales,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Stanley"; LastName="Hudson"; Username="shudson"; GroupName="Sales_Users"; OUPath="OU=Sales,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Andy"; LastName="Bernard"; Username="abernard"; GroupName="Sales_Users"; OUPath="OU=Sales,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Ryan"; LastName="Howard"; Username="rhoward"; GroupName="Sales_Users"; OUPath="OU=Sales,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Kelly"; LastName="Kapoor"; Username="kkapoor"; GroupName="Sales_Users"; OUPath="OU=Sales,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}

    # --- ACCOUNTING (Expanded) ---
    [PSCustomObject]@{FirstName="Rachel"; LastName="Zane"; Username="rzane"; GroupName="Accounting_Users"; OUPath="OU=Accounting,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Oscar"; LastName="Martinez"; Username="omartinez"; GroupName="Accounting_Users"; OUPath="OU=Accounting,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Kevin"; LastName="Malone"; Username="kmalone"; GroupName="Accounting_Users"; OUPath="OU=Accounting,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Angela"; LastName="Martin"; Username="amartin"; GroupName="Accounting_Users"; OUPath="OU=Accounting,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Louis"; LastName="Litt"; Username="llitt"; GroupName="Accounting_Users"; OUPath="OU=Accounting,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Katrina"; LastName="Bennett"; Username="kbennett"; GroupName="Accounting_Users"; OUPath="OU=Accounting,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Jeff"; LastName="Winger"; Username="jwinger"; GroupName="Accounting_Users"; OUPath="OU=Accounting,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}

    # --- IT/HR/MARKETING (Baseline) ---
    [PSCustomObject]@{FirstName="John"; LastName="Steen"; Username="jsteen"; GroupName="IT_Staff"; OUPath="OU=IT,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Christian"; LastName="Steen"; Username="csteen"; GroupName="IT_Staff"; OUPath="OU=IT,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Mike"; LastName="Ross"; Username="mross"; GroupName="HR_Users"; OUPath="OU=HR,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
    [PSCustomObject]@{FirstName="Harvey"; LastName="Specter"; Username="hspecter"; GroupName="Marketing_Team"; OUPath="OU=Marketing,OU=Departments,OU=SteenCorp_HQ,DC=SteenCorp,DC=Local"}
)

$Employees | Export-Csv -Path "$home\Desktop\Employees.csv" -NoTypeInformation -Force
Write-Host "Mega CSV created with $(($Employees).Count) total users!" -ForegroundColor Green