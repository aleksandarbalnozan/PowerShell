# $my_args = @{
#     Path = $env:windir
#     Filter = '*.dll'
#     Recurse = $true
# };

# Get-ChildItem @my_args;

# To define arguments by name, use param statement
# to call this scriot .\Arguments.ps1 -UserName "username" -SaveData:$false  //by default its true
param (
    [string]$price = 100,
    [string]$ComputerName = $env:COMPUTERNAME,
    [string]$userName = $(throw "-username is requred"),
    [securestring]$password = $( Read-Host -AsSecureString "Input Password"),
    [switch]$SaveData = $false
);

Write-Output "The price is $price";
Write-Output "The Computer Name is $ComputerName";
Write-Output "The true/false switch argument is $SaveData";