function convertTo-Base36 {
    [CmdletBinding()]
    param ([parameter(valuefrompipeline = $true, HelpMessage = "Integer number to convert")][int]$decNum = "")
    $alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    do {
        $remainder = ($decNum % 36)
        $char = $alphabet.substring($remainder, 1) # skip first $remander numbers and return next (in this case)1 number
        $base36Num = "$char$base36Num"
        $decNum = ($decNum - $remainder) / 36
    }
    while ($decNum -gt 0)

    $base36Num
}

function convertFrom-base36 {
    [CmdletBinding()]
    param ([parameter(valuefrompipeline = $true, HelpMessage = "Alphadecimal string to convert")][string]$base36Num = "")
    $alphabet = "0123456789abcdefghijklmnopqrstuvwxyz"
    $inputarray = $base36Num.tolower().tochararray()
    [array]::reverse($inputarray)
    [long]$decNum = 0
    $pos = 0

    foreach ($c in $inputarray) {
        $decNum += $alphabet.IndexOf($c) * [long][Math]::Pow(36, $pos)
        $pos++
    }
    $decNum
}

convertFrom-base36 785GZ