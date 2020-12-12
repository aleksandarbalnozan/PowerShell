function Add-Numbers {
    $args[0] + $args[1];
}

function Output-SalesTax {
    param ([int]$Price, [int]$Tax)
    $Price + $Tax;
}


$result = Add-Numbers 5 9;
