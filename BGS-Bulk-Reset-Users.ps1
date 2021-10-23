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
$Body = ""
$samAccountName = ""
$newPassword = ""
$user = ""
# Import users from CSV
$content = Import-Csv C:\temp\PS\changepwd.csv
#====================================================================================
#for each item in cvs gen new pwd
foreach ($user in $content) {

#Create random PWD
$password = Get-RandomCharacters -length 3 -characters 'abcdefghiklmnoprstuvwxyz'
$password += "."
$password += Get-RandomCharacters -length 3 -characters '1234567890'
$newPassword = ConvertTo-SecureString -AsPlainText $password -Force
#get user etc.
 $samAccountName = $user.samAccountName

$Body = "<br>Passwords reset for $samAccountName   -  $Password "
$Body += "<br><br><br>These students may have items on loan and overdue from E2."

# Reset user password.
Set-ADAccountPassword -Identity $samAccountName -NewPassword $newPassword -Reset

# Force user to reset password at next logon.
# Remove this line if not needed for you
Set-AdUser -Identity $samAccountName -ChangePasswordAtLogon $true
Write-Host " AD Password has been reset for: "$samAccountName

}

#====================================================================================
$From = "useroutput@brisbanegrammar.com"
$To = "adm.aaron@brisbanegrammar.com"
#$addressTo = "edb1cf44.brisbanegrammarcom.onmicrosoft.com@apac.teams.ms" 
$Subject = "Student passwords changed on "+(Get-Date) 
#Send Email

#Send E-mail from PowerShell script
Send-MailMessage -smtpserver relay.brisbanegrammar.com -to $To -from $From -Subject $Subject -body $Body -bodyasHTML

#show new password