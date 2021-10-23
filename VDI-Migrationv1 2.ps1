<#
This is a powershell to copy all things for VDI migrations
#>


Copy-Item -Path C:\PointA\1.txt -Destination C:\temp\VDI-Migration

PS> Copy-Item -Path C:\Users\%username%\AppData\Roaming\Microsoft\Templates,C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Document Building Blocks,C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default -Destination C:\PointE
PS> Get-ChildItem -Path C:\PointE


Copy-Item -Path C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Templates -Destination C:\temp\VDI-Migration