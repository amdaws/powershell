
$emlBody += "This is a test email"
#====================================================================================
$addressFrom = "useroutput@brisbanegrammar.com" 
$addressTo = "adm.aaron@brisbanegrammar.com"
#$addressTo = "edb1cf44.brisbanegrammarcom.onmicrosoft.com@apac.teams.ms" 
$emlSubject = "Student passwords changed on "+(Get-Date) 
$smtpServer = "relay.brisbanegrammar.com"
#Send Email
Send-MailMessage -SmtpServer $smtpServer -to $addressTo -from $addressFrom -Subject $emlSubject -body $emlBody -bodyasHTML