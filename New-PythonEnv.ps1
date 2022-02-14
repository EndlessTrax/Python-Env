<#
.SYNOPSIS
    Setup a new Python Environment
.DESCRIPTION
    Create a virtual environment with your specified version of Python, and install required packages.
.EXAMPLE
    New-Python.ps1 -Version 3.9
.EXAMPLE
    New-Python.ps1 -Path path\to\python.exe
.EXAMPLE
    New-Python.ps1 -Version 3.9 -Name env -RequirementsFile requirements.txt
#>
[CmdletBinding()]
Param (
    [Parameter(Mandatory, ParameterSetName = "Version", Position = 0)]
    [ValidateSet("3.7", "3.8", "3.9", "3.10")]
    [string] $Version,

    [Parameter(Mandatory, ParameterSetName = "Path", Position = 0)]
    [string] $PythonPath,

    [Parameter(Position = 1)]
    [string] $Name = ".venv",

    [Parameter(Position = 2)]
    [string] $RequirementsFile
)

# Change the ErrorActionPreference to 'Stop'
$ErrorActionPreference = 'Stop'

try {
    # Find the selected Python executable
    if ($PSCmdlet.ParameterSetName -eq "Version") {
        $PythonVersion = "Python" + $Version.Replace(".", "")
        $PythonPath = "C:\Users\$env:USERNAME\AppData\Local\Programs\Python\${PythonVersion}\python.exe"
    }
    Write-Output "Creating a new virtual environment called $Name, using Python $PythonPath"

    # Create the virtual environment
    . $PythonPath -m venv $Name

    # Activate the virtual environment
    Write-Output "Activating $Name..."
    . $Name\scripts\activate.ps1

    # Upgrade pip
    Write-Output "Updating pip to latest version..."
    python -m pip install --upgrade pip

    # If a requirements file is given, install its dependancies
    if ($RequirementsFile) {
        Write-Output "Installing dependencies from $RequirementsFile..."
        python -m pip install -r $RequirementsFile
    }

    Write-Output "Environment setup complete. Happy coding!"

}
catch {
    Write-Error -Message $Error[0]
}

