# PowerShell script to uninstall Mozilla Firefox

# Function to get the installed Firefox version and uninstall it
function Uninstall-Firefox {
    $firefoxKeys = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    
    foreach ($key in $firefoxKeys) {
        $firefox = Get-ItemProperty -Path $key -ErrorAction SilentlyContinue |
                    Where-Object { $_.DisplayName -match "Mozilla Firefox" }
        
        if ($firefox) {
            Write-Output "Uninstalling Firefox version: $($firefox.DisplayVersion)"
            
            if ($firefox.UninstallString) {
                Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$($firefox.UninstallString) /S`"" -Wait -NoNewWindow
                Write-Output "Firefox uninstallation completed."
            } else {
                Write-Output "Uninstall string not found for Firefox."
            }
            return
        }
    }
    Write-Output "Mozilla Firefox is not installed on this system."
}

# Execute the function
Uninstall-Firefox
