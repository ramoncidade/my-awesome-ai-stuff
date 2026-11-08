[CmdletBinding()]
param(
    [string[]]$WorkerArguments,
    [switch]$DryRun
)

$root = $PSScriptRoot
$folders = Get-ChildItem -LiteralPath $root -Directory | Sort-Object Name

if ($folders.Count -eq 0) {
    throw "No worker folders found under '$root'."
}

if (-not $DryRun) {
    $agent = Get-Command agent -ErrorAction SilentlyContinue

    if ($null -eq $agent) {
        $installedAgent = Join-Path $env:LOCALAPPDATA 'cursor-agent\agent.cmd'

        if (Test-Path -LiteralPath $installedAgent) {
            $agent = [PSCustomObject]@{ Source = $installedAgent }
        }
        else {
            throw "Cursor CLI command 'agent' was not found on PATH or at '$installedAgent'. Install it before running this script."
        }
    }
}

$processes = foreach ($folder in $folders) {
    $workerArguments = @($WorkerArguments | Where-Object {
        $null -ne $_ -and $_.Trim().Length -gt 0
    })
    $arguments = @('worker') + $workerArguments + @('start')

    if ($DryRun) {
        [PSCustomObject]@{
            Folder = $folder.FullName
            Command = (@('agent') + $arguments) -join ' '
            ProcessId = $null
        }
        continue
    }

    $agentPath = $agent.Source
    $agentExtension = [System.IO.Path]::GetExtension($agentPath)

    if ($agentExtension -in @('.cmd', '.ps1')) {
        $agentScript = if ($agentExtension -eq '.cmd') {
            Join-Path (Split-Path -Parent $agentPath) 'cursor-agent.ps1'
        }
        else {
            $agentPath
        }

        $startProcessParameters = @{
            FilePath = (Join-Path $PSHOME 'powershell.exe')
            ArgumentList = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $agentScript) + $arguments
            WorkingDirectory = $folder.FullName
            PassThru = $true
        }
    }
    else {
        $startProcessParameters = @{
            FilePath = $agentPath
            WorkingDirectory = $folder.FullName
            PassThru = $true
        }

        if ($arguments.Count -gt 0) {
            $startProcessParameters.ArgumentList = $arguments
        }
    }

    $process = Start-Process @startProcessParameters

    [PSCustomObject]@{
        Folder = $folder.FullName
        Command = (@('agent') + $arguments) -join ' '
        ProcessId = $process.Id
    }
}

$processes | Format-Table -AutoSize