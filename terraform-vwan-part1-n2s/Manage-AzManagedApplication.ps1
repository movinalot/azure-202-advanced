<#
    .DESCRIPTION
        Manage Azure Virtual WAN FortiGate Managed Application

    .NOTES
        AUTHOR: jmcdonough@fortinet.com
        LASTEDIT: September 25, 2024

	.Examples
		List
		./Manage-AzManagedApplication.ps1 -ResourceGroups @($(Get-AzResourceGroup -Name lab-chile-?-training))

		List and Delete
		./Manage-AzManagedApplication.ps1 -ResourceGroups @($(Get-AzResourceGroup -Name lab-chile-?-training)) -Delete

#>

param(
	[CmdletBinding()]

	[Parameter(Mandatory = $true)]
	[Array] $ResourceGroups,

	[Parameter(Mandatory = $false)]
	[switch] $Delete
)

foreach ($resourceGroup in $ResourceGroups) {
	$managedApplications = Get-AzResource -ResourceGroupName $resourceGroup.ResourceGroupName -ResourceType "Microsoft.Solutions/applications"

	foreach ($managedApplication in $managedApplications) {
		if ($Delete) {
			Write-Host "Deleting Managed Application - Resource Group: $($resourceGroup.ResourceGroupName) Name: $($managedApplication.Name) $($managedApplication.ResourceId)"
			$sriptBlock = [scriptblock]::Create("Remove-AzManagedApplication -Id $($managedApplication.ResourceId) -Force")
			Start-Job -ScriptBlock $sriptBlock
		} else {
			Write-Host "Managed Application - Resource Group: $($resourceGroup.ResourceGroupName) Name: $($managedApplication.Name) $($managedApplication.ResourceId)"
		}

	}
}
