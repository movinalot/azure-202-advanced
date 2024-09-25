<#
    .DESCRIPTION
        Manage Azure Virtual Hub Vnet Connections

    .NOTES
        AUTHOR: jmcdonough@fortinet.com
        LASTEDIT: September 25, 2024

	.Examples
		List
		./Manage-AzVirtualHubVnetConnection.ps1 -ResourceGroups @($(Get-AzResourceGroup -Name lab-chile-?-training))

		List and Delete
		./Manage-AzVirtualHubVnetConnection.ps1 -ResourceGroups @($(Get-AzResourceGroup -Name lab-chile-?-training)) -Delete

#>

param(
	[CmdletBinding()]

	[Parameter(Mandatory = $true)]
	[Array] $ResourceGroups,

	[Parameter(Mandatory = $false)]
	[switch] $Delete
)

foreach ($resourceGroup in $ResourceGroups) {
	$vHubs = Get-AzVirtualHub -ResourceGroupName $resourceGroup.ResourceGroupName

	foreach ($vhub in $vhubs) {
		$vhubVnetConnections = Get-AzVirtualHubVnetConnection -ResourceGroupName $resourceGroup.ResourceGroupName -ParentResourceName $vHub.Name -ErrorAction SilentlyContinue
		if ($vhubVnetConnections) {
			foreach ($vhubVnetConnection in $vhubVnetConnections) {
				if ($Delete) {
					Write-Host "Deleting vHub vnet connection - Resource Group: $($resourceGroup.ResourceGroupName) vHub: $($vHub.Name) - $($vhubVnetConnection.Name)"
					Remove-AzVirtualHubVnetConnection -ResourceGroupName $resourceGroup.ResourceGroupName -ParentResourceName $vHub.Name -Name $vhubVnetConnection.Name -AsJob -Force
				}
				else {
					Write-Host "vHub vnet connection Resource Group: $($resourceGroup.ResourceGroupName) vHub: $($vHub.Name) - $($vhubVnetConnection.Name)"
				}
			}
		}
	}
}
