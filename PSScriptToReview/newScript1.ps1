# 1. Create a new resource group with a VM in it.
# 2. Export the resource group as a template.
# 3. Export parameters file as a separate file.
# 4. Update the parameters file with new values (new resource group name basically). Make two or more different parameters file.
# 5. Implement a function in the script to deploy the template. The function should ask user which parameters file he'd like to use.

# step 1.
# This function will add new resource group and VM in it
function Add-Resource([string]$resourceGroupName, [string]$location, [string]$vmachineName) {
    # check if resourcegroup already exist
    Get-AzResourceGroup -Name $resourceGroupName -ErrorVariable notPresent -ErrorAction SilentlyContinue
    
    #if it dont exist
    if ($notPresent) {
        Write-Host "ResourceGroup with name $resourceGroupName does not exist, thus it will be created now"
        New-AzResourceGroup -Name $resourceGroupName -Location $location

        Add-Vm -vmachineName $vmachineName -resourceGroupName $resourceGroupName
    }
    else {
        Write-Host 'ResourceGroup with that name already exists' -ForegroundColor Red

        Add-Vm -vmachineName $vmachineName -resourceGroupName $resourceGroupName
    }

}

# function to add and check for existance of virtual machine
function Add-Vm([string]$vmachineName, [string]$resourceGroupName) {
    Get-AzVm -ResourceGroupName $resourceGroupName -Name $vmachineName -ErrorVariable dontExist -ErrorAction SilentlyContinue 
    if ($dontExist) {

        Write-Host '1) Contains an uppercase character
2) Contains a lowercase character
3) Contains a numeric digit
4) Contains a special character
5) Control characters are not allowed'
        $username = Read-Host 'UserName'
        $password = Read-Host 'Password'
        $encPass = ConvertTo-SecureString $password -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $encPass)

        New-AzVM -Name $vmachineName -Credential $cred -ResourceGroupName $resourceGroupName -Image Canonical:UbuntuServer:18.04-LTS:latest -Size Standard_D2S_V3

        Get-AzPublicIpAddress -Name $vmachineName -ResourceGroupName $resourceGroupName | Select-Object -Property IpAddress
    }
    else {
        Write-Host 'VirtualMachine with that name already exists' -ForegroundColor Red
    }
}

# step 2.
# This fucntion will export resource group as a template
function Get-Template([string]$resourceGroupName) {
    Export-AzResourceGroup -ResourceGroupName $resourceGroupName
}

function Add-FromTemplate([string]$resourceGroupName, [string]$location, [string]$deploymentName) {
    Add-Resource -location $location -resourceGroupName $resourceGroupName

    $tempFile = ""
    $paramFile = ""

    New-AzResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile $tempFile -TemplateParameterFile $paramFile -storage
}

Add-FromTemplate