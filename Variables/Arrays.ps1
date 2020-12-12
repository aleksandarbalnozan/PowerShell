# first way
$MyArr1 = 1, 2, 3, 4, 5;

# second way
$MyArr2 = (1, 2, 3, 4, 5)

#third way

[int[]]$MyArr3 = 1, 2, 3, 4, 5

# Write-Host $MyArr1
# Write-Host $MyArr2
# Write-Host $MyArr3

# multidimension array

$MyMultiDimArray = @(
    (1, 2, 3),
    (4, 5, 6)
);

# Write-Host $MyMultiDimArray;

# Add value to array +=

$MyArr1 += 6;

# Write-Host $MyArr1;

$countries = New-Object System.Collections.ArrayList;
$countries.Add('Serbia') > $null
$countries.Add('Montenegro') > $null

Write-Host $countries;