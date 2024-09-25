<#
    .DESCRIPTION
        Manage Azure Virtual Hub Routing Intent

    .NOTES
        AUTHOR: jmcdonough@fortinet.com
        LASTEDIT: September 25, 2024

	.Examples
		List
		./Manage-AzVirtualHubRoutingIntent.ps1 -ResourceGroups @($(Get-AzResourceGroup -Name lab-chile-?-training))

		List and Delete
		./Manage-AzVirtualHubRoutingIntent.ps1 -ResourceGroups @($(Get-AzResourceGroup -Name lab-chile-?-training)) -Delete

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
		$routingIntent = Get-AzRoutingIntent -ResourceGroupName $resourceGroup.ResourceGroupName -HubName $vHub.Name -ErrorAction SilentlyContinue
		if ($routingIntent) {
			if ($Delete) {
				Write-Host "Deleting vHub Routing Intent - Resource Group: $($resourceGroup.ResourceGroupName) vHub: $($vHub.Name) - $($routingIntent.Id)"
				Remove-azroutingIntent -ResourceId $routingIntent.Id -AsJob -Force
			}
			else {
				Write-Host "vHub Routing Intent - Resource Group: $($resourceGroup.ResourceGroupName) vHub: $($vHub.Name) - $($routingIntent.Id)"
			}
		}
	}
}
