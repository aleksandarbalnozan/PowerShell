$usa_states = @{
    CA   = "California";
    NY   = "New York";
    "IL" = "Illinois";
    "NH" = "New Hampshire"
}
 
#Add item
$usa_states.Add("GA", "Goregia");
#edit item
$usa_states.Set_Item("GA", "Gerogiaa");
#or
$usa_states."GA" = "Gerogia";

#Coimbine 

$eu_states = @{
    SRB = "Serbia";
    "FR" = "France";
    GE = "Germany"
};

$world_states = $eu_states + $usa_states;

#remove
$usa_states.Remove("GA");

#retrive
$usa_states.'NY';
#or
$usa_states['NY'];
#or
$usa_states['NY','IL'];
#OR as array
$usa_states[@('NY','IL','NH')];

# loop
#1 way
$usa_states.keys | foreach-object {
Write-Host "Key = $_"
Write-Host "Value = $($usa_states[$_])"
Write-Host '--------------------------'
};

# GetEnumerator

#$usa_states.GetEnumerator() | Sort-Object Name


# store array ion hashtable
$arrNY = @('Jamestown', 'New York', 'Niagara Falls');
$arrCA = @('Berkeley', "Fresno", "Los Angeles");

$us_states = @{
    NY = $arrNY;
    CA = $arrCA
};

$us_states.GetEnumerator() | Sort-Object Name