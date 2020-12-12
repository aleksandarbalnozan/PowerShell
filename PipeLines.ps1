$a = Get-ChildItem *.txt;
foreach ($file in $a) {
    if ($file.length -gt 100) {
        Write-Host $file.Name;
    }
}

# rewriting this with pipeline

# Some common destinations for piped output:

# | Format-Table -Property name,value -wrap   Prettify the output.
# | Out-Host -paging   View the output a page at a time (like the less utility in unix)
# | Get-Member   View all the methods & properties.

Get-ChildItem *.txt | where { $_.Length -gt 100 } | Format-Table Name;
Get-ChildItem *.txt | where { $_.Length -gt 100 } | Out-Host -Paging;
