# Force stop Edge
Get-Process msedge -ErrorAction SilentlyContinue | Stop-Process
Start-Sleep 2

# Remove Edge from ProgramFiles & AppData
Get-Item "${env:ProgramFiles(x86)}\Microsoft\Edge\","$env:LOCALAPPDATA\Packages\Microsoft.MicrosoftEdge*" | % {
Remove-Item "$_" -Recurse -Force -Verbose
}

# Create registry file that tells Windows you have the old non-Chromium Edge browser (disables updates)
New-Item -Path "HKLM:\SOFTWARE\Microsoft\" -Name "EdgeUpdate" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\EdgeUpdate\" -Name "DoNotUpdateToEdgeWithChromium" -Type DWORD -Value 1 -Force

#Remove Edge Folder
rd /S /Q "C:\Program Files (x86)\Microsoft"

# Remove Edge shortcut from desktop & start
Get-Item "C:\Users\*\Desktop\Microsoft Edge.lnk","C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" | % { Remove-Item "$_" -Recurse -Force -Verbose }