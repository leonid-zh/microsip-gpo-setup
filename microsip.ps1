# Get CSV file from google sheets

 $FilePath = ""
 $localPath = "$env:TEMP\userlist.csv"
 $wc = New-Object System.Net.Webclient
 $wc.DownloadFile($FilePath, $localPath)
 $serverList = Import-Csv $localPath -Delimiter ";"



Function Find-User {
    $UserName = $env:UserName;
    $user_list = Import-Csv "$env:TEMP\userlist.csv"

    # Loop through all the records in the CSV
    foreach ($user in $user_list) {

        # Check if the current record's employee ID is equal to the value of the EmployeeID parameter.
        if ($user.Username -eq $UserName) {

            # If the username is found
            New-Item C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini -Force
            Set-Content C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini [Account1]
            Add-Content C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini label=sip
            Add-Content C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini server=$($user_list[0]."Sip Server")
            Add-Content C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini proxy=
            Add-Content C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini domain=$($user_list[0]."Sip Server")
            Add-Content C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini username=$($user."Sip ID")
            Add-Content C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini password=$($user."Sip Pass")
            Add-Content C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini [Settings]
            Add-Content C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini accountId=1
            Add-Content C:\Users\$env:UserName\AppData\Roaming\MicroSIP\MicroSIP.ini updatesInterval=never

        }
    }
}

Find-User

Start-Sleep -Seconds 15 #wait 15 sec

Remove-Item "$env:TEMP\userlist.csv" #Remove userlist.csv
