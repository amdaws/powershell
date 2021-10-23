Import-Module ActiveDirectory

$emlBody = ""
$ProjectOnlinemember = ""
$PowerBIPromembersTable = ""
$MSOL = "Power BI Pro"

$PowerBIPromembers = Get-ADGroupMember -Identity "MSOL_License_PowerBIPro" | Select name, SamAccountName

$PowerBIPromembers | Select-Object name, SamAccountName
$PowerBIPromembersTable | Format-Table

$emlBody += "<br>MSOL Groups<br><br>$PowerBIPromembersTable<br>" 

$addressFrom = "useroutput@brisbanegrammar.com" 
$addressTo = "adm.aaron@brisbanegrammar.com"
#$addressTo = "edb1cf44.brisbanegrammarcom.onmicrosoft.com@apac.teams.ms" 
$emlSubject = "MSOL Licences Status ($MSOL) "+(Get-Date) 
$smtpServer = "relay.brisbanegrammar.com"
#Send Email
Send-MailMessage -SmtpServer $smtpServer -to $addressTo -from $addressFrom -Subject $emlSubject -body $emlBody -bodyasHTML