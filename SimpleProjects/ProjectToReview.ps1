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
    param (
        [string]$FirstName, [string]$LastName, [int]$Age
    )
    $person = [Person]@{
        FirstName = "$FirstName";
        LastName  = "$LastName";
        Age       = $Age
    }
    $person | Export-Csv -Append -Path .\Person.csv -NoTypeInformation
}

function RemovePerson {
    param (
        [string]$FirstName, [string]$LastName
    )
    FINDSTR /V /C:"$FirstName" /C:"$LastName" .\Person.csv > .\Person1.csv
    Import-Csv -Path .\Person1.csv | Export-Csv -Path .\Person.csv -NoTypeInformation
}

function ShowCSV {
    Import-Csv -Path .\Person.csv | Format-Table
}

function FindPerson {
    param (
        [string]$FirstName, [string]$LastName
    )
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
