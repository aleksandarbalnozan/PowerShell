class Person {
    [int]$ID
    [string]$FirstName
    [string]$LastName
    [int]$Age
}

$help = @{
    "AddPerson"    = "Syntax: AddPerson -FirstName string -LastName string -Age int";
    "RemovePerson" = "Syntax: RemovePerson -FirstName string -LastName string";
    "ShowCSV"      = "Syntax: ShowCSV";
    "FindPerson"   = "Syntax: FindPerson -FirstName string -LastName string"
}

function AddPerson {
    $FirstName = Read-Host "Enter the First Name of Person you want to add "
    $LastName = Read-Host "Enter the Last Name of Person you want to add "
    $Age = Read-Host "Enter the Age of Person you want to add "
    $person = [Person]@{
        FirstName = "$FirstName";
        LastName  = "$LastName";
        Age       = $Age
    }
    $person | Export-Csv -Append -Path .\Person.csv -NoTypeInformation -Force
}

function RemovePerson {
    $FirstName = Read-Host "Enter the First Name of Person you want to remove "
    $LastName = Read-Host "Enter the Last Name of Person you want to remove "
    FINDSTR /V /C:"$FirstName" /C:"$LastName" .\Person.csv > .\Person1.csv
    # Select-String -Path .\Person.csv -Pattern "$FirstName", "$LastName" -NotMatch | Export-Csv -Path .\Person1.csv -NoTypeInformation
    Import-Csv -Path .\Person1.csv | Export-Csv -Path .\Person.csv -NoTypeInformation
}

function ShowCSV {
    Import-Csv -Path .\Person.csv | Format-Table
}

function FindPerson {
    $FirstName = Read-Host "Enter the First Name of Person you want to find "
    $LastName = Read-Host "Enter the Last Name of Person you want to find "
    $Person = Import-Csv -Path .\Person.csv | Where-Object { $_.FirstName -eq $FirstName -or $_.LastName -eq $LastName } 
    if ($Person.Count -gt 0) {
        $Person | Format-Table
    }
    else {
        Write-Host "There is no Person with $FirstName or $LastName"
    }
}

function PersonHelp {
    $help.GetEnumerator()
}

$inp;
while ($true) {
    Write-Host "--------------WelCome--------------" -ForegroundColor Red;
    Write-Host "If you want to add new Person, type 'add'" 
    Write-Host "If you want to remove Person, type 'remove'" 
    Write-Host "If you want to find Person, type 'find'" 
    Write-Host "If you want to see whats in CSV, type 'show'" 
    Write-Host "If you want to exit script, type 'exit'" 
    Write-Host "--------------WelCome--------------" -ForegroundColor Red;
    $inp = Read-Host "Input".ToLower()
    if ($inp -eq "exit") {
        Write-Host "Closing the script!"
        break;
    }
    else {
        switch ($inp) {
            "add" { AddPerson }
            "remove" { RemovePerson }
            "find" { FindPerson }
            "show" { ShowCSV }
            Default { Write-Host "Use only words from above" }
        }
    }
}