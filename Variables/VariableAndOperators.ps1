# you can assigne multiple variables in same line
# $var2 = ($var1 = 1) + 1;

<#
Variable names containing punctuation, can be handled with the syntax ${MyVari@ble} = SomeValue
However if the braces ${ } contain a colon ":" then PowerShell will treat the variable as a PATH and store the values directly in that file.
${C:\some_file.txt} = SomeValue
#>


<#          mathematical operations
Operator   Description

     = n     Equals n
    += n     Increase value by n (for strings will append n to the string)
    -= n     Decrease the value by n
    *= n     Multiply the value by n (for strings, duplicate the string n times)
    /= n     Divide the value by n
    %= n     Divide the value by n and assign the remainder (modulus)

  Arithmetic operators:

    + Add, - Subtract, * Multiply, / Divide, % Mod(Remainder from a division)

  The .NET Math library adds more options such as Round(), Ceiling(), Max(), Min() etc

$myPrice = 128
$myPrice += 200
$myItem = "Barbecue grill"
$myDescription = $myItem + " $ " + $myPrice

$CastAsString = "55"
$myHexValue = 0x10
$myExponentialValue = 6.5e3

Write-Host $myDescription
Write-Host $CastAsString
Write-Host $myHexValue
Write-Host $myExponentialValue
#>

<#              Strongly typed
Forcing the correct Data Type can prevent/trap errors in later calculations.

[int]$myPrice = 128
[string]$myDescription = "Barbecue grill"
[string]$myDescription = 123
[string]$myDate = (get-date).ToString("yyyyMM")
$([DateTime] "12/30/2009")
$([DateTime]::Now)
[datetime]$start_date=[datetime]::now.date.addDays(-5)

Write-Host $myPrice
Write-Host $myDate
Write-Host $start_date

When creating strongly typed variables it can be helpful to indicate the datatype in the variable name: $strProduct or $intPrice

# Wont let you assigne value <1 or >10
[ValidateRange(1,10)] [int]$x = 1;
$x = 11;
#>



