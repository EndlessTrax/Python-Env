# New-PythonEnv

A simple PowerShell script to create a new Python environment using `venv`.

This script assumes you want to create a new Python environment in the `cwd`.


## Usage

### Arguments

**Version** - Use this to specify the Python version you would like to use to creat your `venv`. Currently, Python 3.7+ is supported. This assumes you used a default location when installing Python. If you have a custom Python path, use `PythonPath` instead (below).

**PythonPath** - Specify the path of your Python interpreter if using a custom Python installation.

**Name** (optional) - Specify the name of the environment. Defaults to `.venv`.

**RequirementsFile** (optional) - Specify a requirements file to install the applications requirements automatically after the creating and activating the environment.

### Exmaples

```pwsh
# Minimum required
PS> New-PythonEnv.ps1 -Version 3.10

# Use custom Python path
PS> New-PythonEnv.ps1 -PythonPath "path\to\python.exe"

# Specify non-default name and install requirements
PS> New-PythonEnv.ps1 -Version 3.10 -Name env -RequirementsFile requirements.txt
```

## Add script to Path

If you want to use the script from the command line from any `cwd`, it is recommended you add it to your `PATH`.

There's many ways to do this, so use the way you're familar with. If you've not done this before, you can run these PowerShell commands to add it for you.

```pwsh
PS> $FolderToAddToPATH = "<Path to this script's folder>"

PS> $UserPATH = (Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment' -Name PATH).path

PS> $NewPATH = $UserPATH + ";" + $FolderToAddToPATH

PS> Set-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment' -Name PATH -Value $NewPATH

```

## Feedback

If you find a bug, please [file an issue](https://github.com/EndlessTrax/Python-Env/issues).

If you have feature requests, please [file an issue](https://github.com/EndlessTrax/Python-Env/issues)
and use the appropriate label.

## Support

If you would like to show your support, I would be very grateful if you would donate
to a charity close to my heart, [Walk AS One](https://walkasone.org/donate/).

And if you would prefer to donate to me personally instead,
[you can sponsor me on Github](https://github.com/sponsors/EndlessTrax) 🤓
