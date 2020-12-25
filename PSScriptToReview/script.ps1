
#1.	Connect to Azure with an authenticated account
#Login-AzAccount

#2.	List all subscriptions for current account
function Show-Subscriptions() {
    Get-AzSubscription | Select-Object -Property Name, Id, State
}


#3.	Select subscription with name $subscriptionName
function Select-Subscription() {
    $subscriptionName = Read-Host 'Which subsription you want to use?'
    Set-AzContext -SubscriptionName $subscriptionName
}


# 4.	List all running VMs
function Show-Vms() {
    Get-AzVM -Status | Select-Object -Property ResourceGroupName, Name, Location, PowerState | Where-Object { $_.PowerState -eq 'VM running' } | Format-Table
}

#5.	Get total vCPU resources utilization for a location $Location
function Show-VmUsage() {
    $location = Read-Host 'Select location for VMs you want to check' 
    Get-AzVMUsage -Location $location
}
 

#6.	Display all running Linux VMs
function Show-LinuxVM() {
    Get-AzVM -Status | Where-Object { $_.StorageProfile.OSDisk.OSType -eq "Linux" -and $_.PowerState -eq 'VM running' } | Format-Table 
}

#7.	Sort all VMs from step 6 and use the first one as a template for the next step
function Get-Template() {
    $sortedVm = Get-AzVM -Status | Sort-Object | Where-Object { $_.StorageProfile.OSDisk.OSType -eq "Linux" -and $_.PowerState -eq 'VM running' } | Select-Object -Property ResourceGroupName, Name, Location
    $sortedVm
    Export-AzResourceGroup -ResourceGroupName $sortedVm.ResourceGroupName -Resource '/subscriptions/f6858d1f-2127-4140-96fd-97a5af2ad334/resourceGroups/DEFAULTRESOURCEGROUP-CUS/providers/Microsoft.Compute/virtualMachines/Vmexample1'
}

#8.	Create new VM based on template above (step 8)
function Add-Template() {
    $newResourceGroupName = Read-Host 'Name for new ResourceGroup'
    $location = Read-Host 'Location for ResourceGroup'
    New-AzResourceGroup -Name $newResourceGroupName -Location $location

    New-AzResourceGroupDeployment -ResourceGroupName $newResourceGroupName -TemplateFile "C:\Users\balno\Documents\Projects\PowerShell\PSScriptToReview\DEFAULTRESOURCEGROUP-CUS.json"

}

#9.	Stop and delete VM created at step 8
function Terminate-Vm() {
    $resourceGroup = Read-Host 'ResourceGroup name'
    $vmName = Read-Host 'VM name'
    $stopOrRemove = Read-Host 'Del for delete or stop for stopping Vm'
    if ($stopOrRemove.ToLower() -eq 'del') {
        Remove-AzVM -ResourceGroupName $resourceGroup -Name $vmName
    }
    elseif ($stopOrRemove.ToLower() -eq 'stop') {
        Stop-AzVM -ResourceGroupName $resourceGroup -Name $vmName
    }
}

function Show-Options {
    Write-Host '1: list all subscriptions'
    Write-Host '2: select subscription'
    Write-Host '3: list all running Vms'
    Write-Host '4: show resource usage'
    Write-Host '5: list all running linux Vms'
    Write-Host '6: sort Vms and take template'
    Write-Host '7: create VM with template'
    Write-Host '8: remove or stop VM'
    Write-Host 'Exit: quit script'
}

while ($true) {
    Show-Options
    $inp = Read-Host 'Choose an action you want to perform'
    
    switch ($inp) {
        '1' { Show-Subscriptions }
        '2' { Select-Subscription }
        '3' { Show-Vms }
        '4' { Show-VmUsage }
        '5' { Show-LinuxVM }
        '6' { Get-Template }
        '7' { Add-Template }
        '8' { Terminate-Vm }
        Default { Write-Host 'Input valid option' }
    }


}

