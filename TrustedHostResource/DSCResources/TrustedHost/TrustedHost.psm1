Function Get-TargetResource
{
    # TODO: Add parameters here
    # Make sure to use the same parameters for
    # Get-TargetResource, Set-TargetResource, and Test-TargetResource
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #VM Name or IP
        [parameter(Mandatory)]
        [String]$Name
    )
    $trustedHost = Get-TrustedHost | ?{$_ -ieq $Name}

    $returnValue = @{
        Name              = $switch.Name        
        Ensure            = if($trustedHost){'Present'}else{'Absent'}        
    }

    return $returnValue
}

Function Set-TargetResource
{
    # TODO:
    # Make sure to use the same parameters for
    # Get-TargetResource, Set-TargetResource, and Test-TargetResource
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #VM Name or IP
        [parameter(Mandatory)]
        [String]$Name,
        [ValidateSet("Present","Absent")]
        [String]$Ensure = "Present"        
    )

    $allhosts = Get-TrustedHost
    if($Ensure -eq 'Present'){
        If($Name -iin $allhosts){
            write-verbose "Host $Name is in the list as expected"
            return $true
        }
        else{
            write-verbose "Host $Name is not in the list, but it was expected to"
            Add-TrustedHost -name $Name
        }
    }
    Else{
        If($Name -iin $allhosts){
            write-verbose "Host $Name is in the list, but it wasn't supposed to"
            Remove-TrustedHost -name $Name
        }
        else{
            write-verbose  "Host $Name is not in the list as expected"
            $true
        }        
    }
}

Function Test-TargetResource
{
    # TODO: Add parameters here
    # Make sure to use the same parameters for
    # Get-TargetResource, Set-TargetResource, and Test-TargetResource
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #VM Name or IP
        [parameter(Mandatory)]
        [String]$Name,
        [ValidateSet("Present","Absent")]
        [String]$Ensure = "Present"
    )

    Write-Verbose -Message "Checking if Trusted Host $Name is $Ensure ..."
    
    #Getting all trusted hosts
    $allhosts = Get-TrustedHost

    If($Name -iin $allhosts){
        # If trusted host should be there, and it is, return $true
        If($Ensure -eq 'Present'){
            return $true
        }
        # If trusted host should be absent, but is there, return $false
        else{
            return $false
        }
    }
    else{
        # If trusted host should be there, and its not, return $false
        If($Ensure -eq 'Present'){
            return $false
        }
        # If trusted host should be absent, and it is, return $true
        else{
            return $true
        }
    }

}

#region helper functions
function destringifyhosts ([string]$hosts){    
    return ($hosts.split(","))
}

function stringifyhosts ([string[]]$hosts){
    $finalstring = ""

    foreach ($h in $hosts){
        if ($h.length -gt 0)
        {
            $finalstring += ",$h"
        }
    }

    return $finalstring.Remove(0,1)
}

function Get-TrustedHost{    
    return (destringifyhosts (ls WSMan:\localhost\Client\TrustedHosts | select -ExpandProperty Value))
}

function Add-TrustedHost($name){
    [System.Collections.Generic.List[System.String]]$allhosts = destringifyhosts (ls WSMan:\localhost\Client\TrustedHosts | select -ExpandProperty Value)
    $allhosts.Add($name)
    Set-Item WSMan:\localhost\client\trustedhosts -value (stringifyhosts $allhosts) -force
}

function Remove-TrustedHost ($name){
    [System.Collections.Generic.List[System.String]]$allhosts = destringifyhosts (ls WSMan:\localhost\Client\TrustedHosts | select -ExpandProperty Value)
    $allhosts.remove($name)
    Set-Item WSMan:\localhost\client\trustedhosts -value (stringifyhosts $allhosts) -force
}
#endregion

Export-ModuleMember -Function *-TargetResource
