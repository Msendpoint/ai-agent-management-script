<#
.SYNOPSIS
Automates the removal of inactive AI agents and applies a standardized policy using Microsoft Intune.
.DESCRIPTION
This script identifies inactive agents on devices managed by Microsoft Intune and removes them. It also applies a standardized compliance policy to the active agents, ensuring that all agents adhere to security protocols and compliance standards.
.NOTES
Author:      Souhaiel Morhag
Company:     MSEndpoint.com
Blog:        https://msendpoint.com
Academy:     https://app.msendpoint.com/academy
LinkedIn:    https://linkedin.com/in/souhaiel-morhag
GitHub:      https://github.com/Msendpoint
License:     MIT
.EXAMPLE
.
# This script can be executed directly in a PowerShell environment with appropriate permissions.
# Ensure that the Microsoft Intune PowerShell module is installed and authenticated.
#>

[CmdletBinding()]
param()

try {
    # Retrieve all Intune management extensions and filter for inactive agents
    $agents = Get-IntuneManagementExtension | Where-Object { $_.Status -eq 'Inactive' }

    # Loop through each inactive agent and remove it
    foreach ($agent in $agents) {
        Remove-IntuneManagementExtension -Id $agent.Id
    }

    # Set a standardized policy for active agents
    $activeAgents = Get-IntuneManagementExtension | Where-Object { $_.Status -eq 'Active' }
    foreach ($agent in $activeAgents) {
        Set-IntuneManagementExtension -Id $agent.Id -Policy 'Standardized Agent Policy'
    }

    Write-Host "Agent management completed successfully." -ForegroundColor Green
} catch {
    Write-Error "An error occurred during agent management: $_"
}