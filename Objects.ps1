# Everything is an object
# default output of Get-ChildItem is - Mode LastWriteTime Size/Length Name

# Get-ChildItem -Path .\ | Select-Object Name, LastWriteTime;

<#
    What is an object?

    An object has an object type (e.g. a file object is a FileInfo type, a registry location object is a PathInfo type)

    An object has methods (e.g. a file object can be copied, a registry key has a value that can be deleted)

    An object has properties (e.g. a file object has a FileSize and a DateModified, a memory process object has a PID and a MaxWorkingSet)

    Get-ChildItem | Get-Member
    Get-Process | Get-Member
    Get-Location | Get-Member
    Get-Service | Get-Member

#>

$a = Get-ChildItem -Path .\topics.txt;
# $a.get_lastAccessTime();
# $a.getType();
# $a.MoveTo("C:\users\balno\Documents\Projects\topics.txt");
# $a.name.ToUpper();