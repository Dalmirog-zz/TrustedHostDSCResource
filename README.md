# TrustedHostDSCResource

When you need to remotely run Powershell on a machine, but your host is not in the same domain as the Target machine (which is the most common case when dealing with machines in your personal lab) and the target machine is not in the list of trusted hosts by your host, you'll usually run into this error:

```
Connecting to remote server NY-tentacle1 failed with the 
following error message : The WinRM client cannot process the request. If the 
authentication scheme is different from Kerberos, or if the client computer is 
not joined to a domain, then HTTPS transport must be used or the destination 
machine must be added to the TrustedHosts configuration setting. Use winrm.cmd 
to configure TrustedHosts. Note that computers in the TrustedHosts list might 
not be authenticated. You can get more information about that by running the 
following command: winrm help config. For more information, see the 
about_Remote_Troubleshooting Help topic.
```

To workaround this you usually need to run the below command to add the machine to the list of trusted hosts
```Powershell
Set-Item WSMan:\localhost\client\trustedhosts "MachineNameOrIP" -force -Concatenate
```

This DSC resource helps you with this, add/removing hosts from this list.

##Usage
```Powershell
Configuration AddHost
{
   Import-DscResource -module TrustedHostResource

        TrustedHost "Adding new host"
        {
           Ensure = 'Present'
           Name = "NY-Tentacle1" #Name/IP of the Machine you want to add as trusted host.
        }       
}

#Create .MOF file with configuration
AddHost

#Run DSC configuration
Start-DscConfiguration .\AddHost -force -wait
```

##Installation

###From the Powershell Gallery (Coming soon. Gimme a week for this)
```Powershell
Install-Module TrustedHostResource
```
###Manually
1) Download the project code

2) Put the folder `TrustedHostResource` into your modules directory (e.g *C:\Program Files\WindowsPowerShell\Modules*)
