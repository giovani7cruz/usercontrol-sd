[CmdletBinding()]
param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',

    [string]$DelphiRoot = '',

    [switch]$NoPause
)

$ErrorActionPreference = 'Stop'

trap {
    Write-Host ''
    Write-Host "ERRO: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

$repositoryRoot = $PSScriptRoot
$projectFile = Join-Path $repositoryRoot 'Projetos\UCSWInstall\Fonte\UCSWInstall.dproj'
$outputFile = Join-Path $repositoryRoot 'UCSWInstall.exe'

if (-not (Test-Path -LiteralPath $projectFile -PathType Leaf)) {
    throw "Projeto nao encontrado: $projectFile"
}

function Get-DelphiInstallations {
    $installations = New-Object System.Collections.Generic.List[object]

    if ($DelphiRoot) {
        $installations.Add([pscustomobject]@{
            Version = [version]'999.0'
            Root = $DelphiRoot
            Origin = 'parametro -DelphiRoot'
        })
    }

    if ($env:BDS) {
        $installations.Add([pscustomobject]@{
            Version = [version]'998.0'
            Root = $env:BDS
            Origin = 'variavel BDS'
        })
    }

    $registryLocations = @(
        @{ Hive = [Microsoft.Win32.RegistryHive]::CurrentUser; View = [Microsoft.Win32.RegistryView]::Registry32 },
        @{ Hive = [Microsoft.Win32.RegistryHive]::CurrentUser; View = [Microsoft.Win32.RegistryView]::Registry64 },
        @{ Hive = [Microsoft.Win32.RegistryHive]::LocalMachine; View = [Microsoft.Win32.RegistryView]::Registry32 },
        @{ Hive = [Microsoft.Win32.RegistryHive]::LocalMachine; View = [Microsoft.Win32.RegistryView]::Registry64 }
    )

    foreach ($location in $registryLocations) {
        $baseKey = $null
        $bdsKey = $null
        try {
            $baseKey = [Microsoft.Win32.RegistryKey]::OpenBaseKey($location.Hive, $location.View)
            $bdsKey = $baseKey.OpenSubKey('Software\Embarcadero\BDS')
            if (-not $bdsKey) {
                continue
            }

            foreach ($versionName in $bdsKey.GetSubKeyNames()) {
                $version = $null
                if (-not [version]::TryParse($versionName, [ref]$version)) {
                    continue
                }

                $versionKey = $bdsKey.OpenSubKey($versionName)
                try {
                    $root = [string]$versionKey.GetValue('RootDir', '')
                    if ($root) {
                        $installations.Add([pscustomobject]@{
                            Version = $version
                            Root = $root
                            Origin = 'Registro do Windows'
                        })
                    }
                }
                finally {
                    if ($versionKey) { $versionKey.Dispose() }
                }
            }
        }
        catch {
            Write-Verbose "Nao foi possivel consultar uma chave do Delphi: $($_.Exception.Message)"
        }
        finally {
            if ($bdsKey) { $bdsKey.Dispose() }
            if ($baseKey) { $baseKey.Dispose() }
        }
    }

    $studioRoots = @(
        (Join-Path ${env:ProgramFiles(x86)} 'Embarcadero\Studio'),
        (Join-Path $env:ProgramFiles 'Embarcadero\Studio')
    ) | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Container) }

    foreach ($studioRoot in $studioRoots) {
        foreach ($directory in Get-ChildItem -LiteralPath $studioRoot -Directory -ErrorAction SilentlyContinue) {
            $version = $null
            if ([version]::TryParse($directory.Name, [ref]$version)) {
                $installations.Add([pscustomobject]@{
                    Version = $version
                    Root = $directory.FullName
                    Origin = 'diretorio padrao'
                })
            }
        }
    }

    $installations |
        Where-Object { Test-Path -LiteralPath (Join-Path $_.Root 'bin\rsvars.bat') -PathType Leaf } |
        Sort-Object Version -Descending
}

$installation = Get-DelphiInstallations | Select-Object -First 1
if (-not $installation) {
    throw @'
Nenhuma instalacao do Delphi foi encontrada.
Informe a pasta do RAD Studio, por exemplo:
  .\Compilar-UCSWInstall.ps1 -DelphiRoot "C:\Program Files (x86)\Embarcadero\Studio\23.0"
'@
}

$rsvars = Join-Path $installation.Root 'bin\rsvars.bat'
Write-Host "Delphi: $($installation.Root) [$($installation.Origin)]"
Write-Host "Configuracao: $Configuration / Win32"

$command = 'call "{0}" >nul && set' -f $rsvars
$environmentLines = & $env:ComSpec /d /s /c $command
if ($LASTEXITCODE -ne 0) {
    throw "Falha ao carregar o ambiente do Delphi por $rsvars"
}

foreach ($line in $environmentLines) {
    $separator = $line.IndexOf('=')
    if ($separator -gt 0) {
        $name = $line.Substring(0, $separator)
        $value = $line.Substring($separator + 1)
        [Environment]::SetEnvironmentVariable($name, $value, 'Process')
    }
}

$msbuildCandidates = New-Object System.Collections.Generic.List[string]
if ($env:FrameworkDir -and $env:FrameworkVersion) {
    $msbuildCandidates.Add((Join-Path $env:FrameworkDir "$($env:FrameworkVersion)\MSBuild.exe"))
}
$msbuildCandidates.Add((Join-Path $env:WINDIR 'Microsoft.NET\Framework\v4.0.30319\MSBuild.exe'))

$msbuildCommand = Get-Command 'MSBuild.exe' -ErrorAction SilentlyContinue
if ($msbuildCommand) {
    $msbuildCandidates.Add($msbuildCommand.Source)
}

$msbuild = $msbuildCandidates |
    Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Leaf) } |
    Select-Object -First 1

if (-not $msbuild) {
    throw 'MSBuild.exe nao foi encontrado depois de carregar o ambiente do Delphi.'
}

Write-Host "MSBuild: $msbuild"
Write-Host "Projeto: $projectFile"

& $msbuild $projectFile '/target:Build' "/property:Config=$Configuration" '/property:Platform=Win32' '/nologo' '/verbosity:minimal'
$buildExitCode = $LASTEXITCODE

if ($buildExitCode -ne 0) {
    throw "A compilacao falhou. Codigo de saida do MSBuild: $buildExitCode"
}

if (-not (Test-Path -LiteralPath $outputFile -PathType Leaf)) {
    throw "O MSBuild terminou sem erro, mas o executavel nao foi encontrado: $outputFile"
}

$output = Get-Item -LiteralPath $outputFile
Write-Host ''
Write-Host 'Compilacao concluida com sucesso.' -ForegroundColor Green
Write-Host "Executavel: $($output.FullName)"
Write-Host "Atualizado em: $($output.LastWriteTime)"
