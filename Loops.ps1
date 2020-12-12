<#  Do loop
count to 10
do {
    $val++;
    Write-Host $val;
} while ($val -ne 10)
#>

<#  foreach loop
$fruits = @("Banana", "Apple", "Orange", "PineApple");

foreach ($item in $fruits) {
   Write-Host $item = $item.length;
}
#>

<# foreach -object
    retrive files and folders from C: directory and display the size
    (The $_ variable holds a reference to the current item being processed.)
    Get-ChildItem C:\ | foreach-object -process { $_.length / 1024 };

    retrive 1000 most recent events logs
    $events = Get-EventLog -logname system -newest 1000;

    Write-Host $events | foreach-object -begin {Get-Date} -process {Out-File -filepath event_log.txt -append -inputobject $_.message};
#>
<#
    switch 
$fruit = "orage";

switch ($fruit) {
    "apple" { "We found an apple"; break }
    "pear" { "We found a pear"; break }
    "orange" { "We found an orange"; break }
    "peach" { "We found a peach"; break }
    "banana" { "We found a banana"; break }
    default { "Something else happened"; break }
}

    When writing a switch clause without a break, it can be useful to add a # FALLTHROUGH comment to make it clear that subsequent tests will still be performed.

$drink = 'Gin and Tonic'

$result = switch -wildcard ($drink) {
   "Gin*"  {"Contains Gin"}      # FALLTHROUGH
   "Whisky*" {"Contains Whisky"} # FALLTHROUGH
   "*tonic" {"Contains Tonic"}   # FALLTHROUGH
}

$result



Arrays.
Passing an array to a switch statement will process each element in the collection. So to repeat the last example just change the first line to an array of different drinks:
$drink = 'Gin and Tonic', 'Vodka and Tonic'
The $result returned will then be an array of all the results - if you need to identify which result is which, consider including $_ or $psitem in the value you return. e.g. "$_ Contains Gin"

Files.
The switch statement can process a file with the -File parameter. This works the same as passing an array of values, each line in the text file will be passed to switch.

In this example we read a text file that contains nothing but a list of error numbers, and translate them into a text message:

$errlog = 'C:\logs\errorlog.txt'
switch -File $errlog
    {
        10  { "Error ten found"; break }
        50  { "Error fifty found"; break }
        100 { "Error one hundred"; break}
    }
Notice that because these switch clauses use break, as soon as any one number is matched, no further processing is done. The break does not just complete the current item and skip to the next, it breaks all processing and exits the switch statement.

#>

