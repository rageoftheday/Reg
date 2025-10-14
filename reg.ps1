# Silently set registry values for Windows upgrade eligibility

# Define registry paths
$hkcuPath = "HKCU:\Software\Microsoft\PCHC"
$hklmPath = "HKLM:\SYSTEM\Setup\MoSetup"

# Create or set HKCU\Software\Microsoft\PCHC\UpgradeEligibility to 1
if (-not (Test-Path $hkcuPath)) {
    New-Item -Path $hkcuPath -Force | Out-Null
}
Set-ItemProperty -Path $hkcuPath -Name "UpgradeEligibility" -Value 1 -Type DWord -Force | Out-Null

# Create or set HKLM\SYSTEM\Setup\MoSetup\AllowUpgradesWithUnsupportedTPMOrCPU to 1
if (-not (Test-Path $hklmPath)) {
    New-Item -Path $hklmPath -Force | Out-Null
}
Set-ItemProperty -Path $hklmPath -Name "AllowUpgradesWithUnsupportedTPMOrCPU" -Value 1 -Type DWord -Force | Out-Null