Import-Module ActiveDirectory
Install-Module -Name SqlServer -RequiredVersion 21.1.18235 -Scope CurrentUser
#~function - create random password
#====================================================================================
function Get-RandomCharacters($length, $characters) {
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
    $private:ofs=""
    return [String]$characters[$random]
}
function Scramble-String([string]$inputString){     
    $characterArray = $inputString.ToCharArray()   
    $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length     
    $outputString = -join $scrambledStringArray
    return $outputString 
}
#====================================================================================
#~null variables to clear
$password = ""
$emlBody = ""
# Import users from CSV
$content = Import-Csv B:\PowerShell\changepwd.csv
#====================================================================================
#~for each item in cvs gen new pwd
foreach ($user in $content) {

#Create random PWD
$password = Get-RandomCharacters -length 3 -characters 'abcdefghiklmnoprstuvwxyz'
$password += "."
$password += Get-RandomCharacters -length 3 -characters '1234567890'
$newPassword = ConvertTo-SecureString -AsPlainText $password -Force
#get user etc.
 $samAccountName = $user.samAccountName

$emlBody += "<br>Passwords reset for $samAccountName   -  $Password  <br>" 

# Reset user password.
Set-ADAccountPassword -Identity $samAccountName -NewPassword $newPassword -Reset

# Force user to reset password at next logon.
# Remove this line if not needed for you
Set-AdUser -Identity $samAccountName -ChangePasswordAtLogon $true
Write-Host " AD Password has been reset for: "$samAccountName
$insertquery="
INSERT INTO [dbo].[PasswordReset]
           ([SAMAccountName],[NewPassword])
     VALUES ('$samAccountName','$Password')
GO
"
Invoke-SQLcmd -ServerInstance 'V10ICT012\SQLEXPRESS' -query $insertquery -U test -P test -Database PWD-Resets

}
$emlBody += "<br><br>These students may have overdue loans or items awaiting pickup from E2.<br>Please update any student ticket/s that may need further information.<br><br>***This information was recorded in V10ICT012\SQLEXPRESS -Database PWD-Resets.*** "
#====================================================================================
$addressFrom = "useroutput@brisbanegrammar.com" 
#$addressTo = "adm.aaron@brisbanegrammar.com"
$addressTo = "edb1cf44.brisbanegrammarcom.onmicrosoft.com@apac.teams.ms" 
$emlSubject = "Student passwords changed on "+(Get-Date) 
$smtpServer = "relay.brisbanegrammar.com"
#Send Email
Send-MailMessage -SmtpServer $smtpServer -to $addressTo -from $addressFrom -Subject $emlSubject -body $emlBody -bodyasHTML

#show new password