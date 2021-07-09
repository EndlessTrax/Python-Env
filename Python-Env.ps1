<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
.INPUTS
    Inputs to this cmdlet (if any)
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    General notes
.COMPONENT
    The component this cmdlet belongs to
.ROLE
    The role this cmdlet belongs to
.FUNCTIONALITY
    The functionality that best describes this cmdlet
#>
[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("3.6", "3.7", "3.8", "3.9")]
    [string] $Version,

    [Parameter(Mandatory = $true, Position = 1)]
    [string] $Name,

    [Parameter(Mandatory = $false, Position = 2)]
    [string] $RequirementsFile
)

# TODO: Add exit default
# TODO: Add error handling

# Find the selected Python executable
$PythonVersion = "Python" + $Version.Replace(".", "")
$PythonPath = "C:\Users\$env:USERNAME\AppData\Local\Programs\Python\${PythonVersion}\python.exe"
Write-Host "Creating a new virtual environment called $Name, using Python $Version at $PythonPath"

# Create the virtual environment
. $PythonPath -m venv $Name

# Activate the virtual environment
Write-Host "Activating $Name..."
. $Name\scripts\activate.ps1

# Upgrade pip
Write-Host "Updating pip to latest version..."
python -m pip install --upgrade pip

# If a requirements file is given, install its dependancies
if ($requirementsFile) {
    Write-Host "Installing dependencies from $RequirementsFile..."
    python -m pip install -r $RequirementsFile
}

Write-Host "Environment setup complete. Happy coding!"
