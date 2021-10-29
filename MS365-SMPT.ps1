$addressFrom = "smtp@qpebas.com"
$addressTo = "aaron@thebachmanns.com.au"
#$addressTo = "aaron.bachmann@brisbanegrammar.com"
#$addressTo = "edb1cf44.brisbanegrammarcom.onmicrosoft.com@apac.teams.ms" 
$emlSubject = "Student passwords changed on "+(Get-Date) 
$smtpServer = "smtp.office365.com"
#Send Email
Send-MailMessage -SmtpServer $smtpServer -to $addressTo -from $addressFrom -Subject $emlSubject -body $emlBody -bodyasHTML

Send-MailMessage -To “aaron@thebachmanns.com.au” -From “smtp@qpebas.com”  -Subject “Hey, Jon” -Body “Some important plain text!” -Credential (Get-Credential) -SmtpServer “smtp.office365.com” -Port 587


