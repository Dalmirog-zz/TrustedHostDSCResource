@{
# Version number of this module.
ModuleVersion = '1.0.0.0'

# ID used to uniquely identify this module
GUID = 'e2701f19-9fa5-473c-b958-8bb314b46d53'

# Author of this module
Author = 'Dalmiro Granas'

# Description of the functionality provided by this module
Description = 'Module with DSC Resource to set Trusted hosts on a computer to be able to remote into them using Powershell'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '4.0'

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = '4.0'

# Functions to export from this module
FunctionsToExport = '*'

# Cmdlets to export from this module
CmdletsToExport = '*'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('DSC Resource', 'DSC', 'Trusted Hosts')

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Dalmirog/TrustedHostDSCResource'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable
}