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

function MS365SMPT {
    param (
        OptionalParameters
        SMTP server: smtp.office365.com

Port Number: 587

Encryption method: STARTTLS

Username: Your Office 365 email address

Password: Your Office 365 password
    )
    
}