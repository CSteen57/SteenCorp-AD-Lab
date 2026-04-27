# --- SteenCorp Final Bulk Ingestion ---
Import-Module ActiveDirectory

$csv = Import-Csv "$home\Desktop\Employees.csv"

foreach ($u in $csv) {
    $sam = $u.Username
    $name = "$($u.FirstName) $($u.LastName)"
    $pw = ConvertTo-SecureString "SteenCorp2026!" -AsPlainText -Force
    
    # Check if user already exists to avoid red errors
    if (!(Get-ADUser -Filter "SamAccountName -eq '$sam'")) {
        New-ADUser -Name $name `
                   -SamAccountName $sam `
                   -UserPrincipalName "$sam@SteenCorp.Local" `
                   -Path $u.OUPath `
                   -AccountPassword $pw `
                   -Enabled $true `
                   -ChangePasswordAtLogon $true
        
        Add-ADGroupMember -Identity $u.GroupName -Members $sam
        Write-Host "Added New Employee: $name" -ForegroundColor Green
    } else {
        Write-Host "Skipping $name (Already in AD)" -ForegroundColor Gray
    }
}

Write-Host "Deployment Complete. Check ADUC for the new crowd!" -ForegroundColor Cyan