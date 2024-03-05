#### Windows updates ####
Set-ExecutionPolicy Bypass -Scope Process -Force
# Import the PSWindowsUpdate module
Import-Module PSWindowsUpdate

# Check for updates
Get-WindowsUpdate

# Install all available updates
Install-WindowsUpdate -AcceptAll -AutoReboot
# The system will automatically reboot if required by the updates
