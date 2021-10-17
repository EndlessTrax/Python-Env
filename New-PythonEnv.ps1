<#
.SYNOPSIS
    Setup a new Python Environment
.DESCRIPTION
    Create a virtual environment with your specified version of Python, and install required packages.
.EXAMPLE
    PythonEnv.ps1 -Version 3.9 -Name .venv
.EXAMPLE
    PythonEnv.ps1 -Version 3.9 -Name .venv -RequirementsFile requirements.txt
.INPUTS
    Inputs to this cmdlet (if any) #TODO:
.OUTPUTS
    Output from this cmdlet (if any) #TODO:
#>
[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true, ParameterSetName = "Version", Position = 0)]
    [ValidateSet("3.6", "3.7", "3.8", "3.9", "3.10")]
    [string] $Version,
    [Parameter(Mandatory = $true, ParameterSetName = "Path", Position = 0)]
    [string] $PythonPath,

    [Parameter(Position = 1)]
    [string] $Name = ".venv",

    [Parameter(Position = 2)]
    [string] $RequirementsFile
)

# Change the ErrorActionPreference to 'Stop'
$ErrorActionPreference = 'Stop'
Write-Error -Message $Error[0]

# Find the selected Python executable
if ($PSCmdlet.ParameterSetName -eq "Version") {
    $PythonVersion = "Python" + $Version.Replace(".", "")
    $PythonPath = "C:\Users\$env:USERNAME\AppData\Local\Programs\Python\${PythonVersion}\python.exe"
}
Write-Progress "Creating a new virtual environment called $Name, using Python $PythonPath"

# Create the virtual environment
. $PythonPath -m venv $Name

# Activate the virtual environment
Write-Progress "Activating $Name..."
. $Name\scripts\activate.ps1

# Upgrade pip
Write-Progress "Updating pip to latest version..."
python -m pip install --upgrade pip

# If a requirements file is given, install its dependancies
if ($RequirementsFile) {
    Write-Progress "Installing dependencies from $RequirementsFile..."
    python -m pip install -r $RequirementsFile
}

Write-Progress "Environment setup complete. Happy coding!"
