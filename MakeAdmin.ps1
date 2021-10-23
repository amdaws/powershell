$currentUser = Get-WMIObject -class Win32_ComputerSystem | Select-Object Username -ExpandProperty Username
Invoke-Command -ScriptBlock { net localgroup Administrators $currentUser /Add 
                              net localgroup Administrators SG_Student_All /Delete }
$currentUser = $currentUser.Replace("BGS\","")
New-ItemProperty -Path HKLM:\SOFTWARE\Build_Info -Name OwnerName -Value $($currentUser) -Force