# Resume only the approved Orca asset. Never install or execute it.
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$directory = 'C:\Users\DW\AppData\Local\OrcaKernelLab\downloads\v1.4.188'
$partial = Join-Path $directory 'orca-linux.AppImage.part'
$final = Join-Path $directory 'orca-linux.AppImage'
$log = Join-Path $directory 'resume-download.log'
$assetUrl = 'https://github.com/stablyai/orca/releases/download/v1.4.188/orca-linux.AppImage'
$expectedBytes = 205918977L
$expectedSha256 = '2e70cb5e199741e5602a7060825575319f5e03bc2faa4b89cd27328f3f55d4b4'
$curl = 'C:\Windows\System32\curl.exe'
$lock = $null

function Write-Receipt([string]$Message) {
    Add-Content -LiteralPath $log -Encoding utf8 -Value "$(Get-Date -Format o) $Message"
}

function Assert-RegularPath([string]$Path) {
    $item = Get-Item -LiteralPath $Path -Force
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        throw 'Refusing a reparse point in the download path.'
    }
}

try {
    # The authorized directory must already exist; do not discover or modify daily homes.
    foreach ($entry in @(
        'C:\Users\DW\AppData\Local\OrcaKernelLab',
        'C:\Users\DW\AppData\Local\OrcaKernelLab\downloads',
        $directory
    )) { Assert-RegularPath $entry }
    foreach ($entry in @($partial, $final, $log, (Join-Path $directory 'resume-download.lock'))) {
        if (Test-Path -LiteralPath $entry) { Assert-RegularPath $entry }
    }
    # An exclusive OS file handle prevents two copies of this script writing the same part.
    $lock = [IO.File]::Open((Join-Path $directory 'resume-download.lock'),
        [IO.FileMode]::OpenOrCreate, [IO.FileAccess]::ReadWrite, [IO.FileShare]::None)
    Write-Receipt "START pid=$PID max_seconds=14400 expected_bytes=$expectedBytes"
    $deadline = [DateTime]::UtcNow.AddHours(4)
    $attempt = 0
    $noProgress = 0

    if (Test-Path -LiteralPath $final) {
        if ((Get-Item -LiteralPath $final).Length -ne $expectedBytes -or
            (Get-FileHash -LiteralPath $final -Algorithm SHA256).Hash.ToLowerInvariant() -ne $expectedSha256) {
            throw 'Existing final file differs from the approved asset; refusing overwrite.'
        }
        Write-Receipt 'COMPLETE existing_final=true sha256=verified'
        exit 0
    }
    if (-not (Test-Path -LiteralPath $partial)) { throw 'Expected partial file is missing.' }

    while ($true) {
        $before = (Get-Item -LiteralPath $partial).Length
        if ($before -gt $expectedBytes) { throw 'Partial file exceeds the expected size.' }
        if ($before -eq $expectedBytes) { break }
        $remainingSeconds = [int][Math]::Floor(($deadline - [DateTime]::UtcNow).TotalSeconds)
        if ($remainingSeconds -le 0) { throw 'Four-hour transfer limit reached; partial retained.' }
        $attempt++
        $timeout = [Math]::Min(300, $remainingSeconds)
        Write-Receipt "ATTEMPT number=$attempt start_bytes=$before timeout_seconds=$timeout"
        # Normal certificate/proxy behavior remains in force. Do not log signed redirect URLs.
        $http = & $curl --fail --location --silent --connect-timeout 20 --max-time $timeout `
            --continue-at - --output $partial --write-out '%{http_code}' $assetUrl 2>$null
        $curlExit = $LASTEXITCODE
        $after = (Get-Item -LiteralPath $partial).Length
        $httpCode = if ("$http" -match '^\d{3}$') { "$http" } else { 'unknown' }
        Write-Receipt "RESULT number=$attempt curl_exit=$curlExit http=$httpCode bytes=$after added=$($after - $before)"
        if ($after -lt $before) { throw 'Partial file shrank; stopping.' }
        if ($after -eq $expectedBytes) { break }
        if ($curlExit -notin @(0, 6, 7, 18, 28, 35, 52, 56)) {
            throw "Non-retryable curl exit $curlExit; partial retained."
        }
        if ($after -eq $before) { $noProgress++ } else { $noProgress = 0 }
        if ($noProgress -ge 3) { throw 'Three attempts without progress; partial retained.' }
        $pause = [Math]::Min(15, [Math]::Max(0, [int]($deadline - [DateTime]::UtcNow).TotalSeconds))
        if ($pause -gt 0) { Start-Sleep -Seconds $pause }
    }

    Write-Receipt 'VERIFY complete_size=true'
    $actualSha256 = (Get-FileHash -LiteralPath $partial -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actualSha256 -ne $expectedSha256) { throw 'SHA256 mismatch; partial retained, not promoted.' }
    # File.Move without overwrite protects an independently created final file.
    [IO.File]::Move($partial, $final)
    Write-Receipt "COMPLETE bytes=$expectedBytes sha256=$actualSha256 installed=false"
    exit 0
}
catch {
    # Only this script's own fixed messages are logged; no raw network/config output.
    $reason = switch -Regex ($_.Exception.Message) {
        '^Four-hour transfer limit reached;' { 'time_limit'; break }
        '^Three attempts without progress;' { 'no_progress'; break }
        '^SHA256 mismatch;' { 'checksum_mismatch'; break }
        '^Non-retryable curl exit \d+;' { 'curl_failure'; break }
        '^Partial file (exceeds|shrank)' { 'invalid_size'; break }
        '^Existing final file differs' { 'existing_final_conflict'; break }
        '^Expected partial file is missing' { 'missing_partial'; break }
        default { 'filesystem_or_process_error' }
    }
    if ($null -ne $lock) { Write-Receipt "STOPPED reason=$reason partial_retained=true" }
    exit 1
}
finally {
    if ($null -ne $lock) { $lock.Dispose() }
}
