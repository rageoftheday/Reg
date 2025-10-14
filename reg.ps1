# Silently set registry values for Windows upgrade eligibility

# Define registry paths
$hkcuPath = "HKCU:\Software\Microsoft\PCHC"
$hklmPath = "HKLM:\SYSTEM\Setup\MoSetup"

# Function to check if running as Administrator
function Test-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Exit if not running as Administrator
if (-not (Test-Admin)) {
    exit 1
}

# Create or set HKCU\Software\Microsoft\PCHC\UpgradeEligibility to 1
try {
    if (-not (Test-Path $hkcuPath)) {
        New-Item -Path $hkcuPath -Force | Out-Null
    }
    New-ItemProperty -Path $hkcuPath -Name "UpgradeEligibility" -Value 1 -PropertyType DWord -Force -ErrorAction Stop | Out-Null
} catch {
    exit 1
}

# Create or set HKLM\SYSTEM\Setup\MoSetup\AllowUpgradesWithUnsupportedTPMOrCPU to 1
try {
    if (-not (Test-Path $hklmPath)) {
        New-Item -Path $hklmPath -Force | Out-Null
    }
    New-ItemProperty -Path $hklmPath -Name "AllowUpgradesWithUnsupportedTPMOrCPU" -Value 1 -PropertyType DWord -Force -ErrorAction Stop | Out-Null
} catch {
    exit 1
}
