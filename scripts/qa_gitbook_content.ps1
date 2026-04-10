$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path ".").Path
$chaptersDir = Join-Path $repoRoot "chapters"
$figuresDir = Join-Path $repoRoot "figures"
$workflowPath = Join-Path $repoRoot ".github/workflows/deploy-gitbook.yml"

$errors = New-Object System.Collections.Generic.List[string]

function Add-Error {
    param([string]$Message)
    $errors.Add($Message)
}

if (-not (Test-Path $chaptersDir)) {
    throw "Missing directory: $chaptersDir"
}

$chapterFiles = Get-ChildItem $chaptersDir -Filter "chapter_*.md" | Sort-Object Name

if ($chapterFiles.Count -eq 0) {
    throw "No chapter files found in $chaptersDir"
}

# 1) Placeholder checks.
$placeholderPattern = '(TODO|TBD|FIXME|XXX|Pub\. L\. No\. \d+-XXX)'
foreach ($file in $chapterFiles) {
    $matches = Select-String -Path $file.FullName -Pattern $placeholderPattern -AllMatches
    foreach ($m in $matches) {
        Add-Error("$($file.Name):$($m.LineNumber) Placeholder-like text found: $($m.Line.Trim())")
    }
}

# 2) Required terminal section checks.
foreach ($file in $chapterFiles) {
    $hasDataSources = Select-String -Path $file.FullName -Pattern '^## Data Sources' -Quiet
    $hasReferences = Select-String -Path $file.FullName -Pattern '^## References' -Quiet

    if (-not $hasDataSources) {
        Add-Error("$($file.Name): missing '## Data Sources ...' section")
    }
    if (-not $hasReferences) {
        Add-Error("$($file.Name): missing '## References ...' section")
    }
}

# 3) Image path policy and existence checks.
foreach ($file in $chapterFiles) {
    $lineNo = 0
    foreach ($line in Get-Content $file.FullName) {
        $lineNo += 1

        # HTML image tags used by the manuscript.
        if ($line -match '<img src=\"([^\"]+)\"') {
            $src = $matches[1]
            if ($src -match '^(https?:|//|data:)') {
                continue
            }
            if ($src -notmatch '^\.\./figures/') {
                Add-Error("$($file.Name):$lineNo Non-canonical image path '$src' (expected ../figures/...)")
                continue
            }

            $figureName = Split-Path $src -Leaf
            $inFigures = Test-Path (Join-Path $figuresDir $figureName)
            if (-not $inFigures) {
                Add-Error("$($file.Name):$lineNo Referenced figure not found in figures/: $figureName")
            }
        }

        # Guard against escaped root references.
        if ($line -match '\.\./\.\./figures/') {
            Add-Error("$($file.Name):$lineNo Escapes repo root with ../../figures path")
        }
    }
}

# 4) Stale metric guardrails from citation remediation.
$staleChecks = @(
    @{ Path = "chapters/chapter_6.md"; Pattern = '\$539 billion \(2018\) to \$427 billion \(2019\), a 21% decline'; Message = "Outdated import decline figure still present" },
    @{ Path = "chapters/chapter_10.md"; Pattern = 'bilateral trade remains \$690 billion annually despite tensions'; Message = "Outdated U.S.-China trade total still present" },
    @{ Path = "chapters/chapter_10.md"; Pattern = 'processing \$13\+ trillion annually \(2024\), growing 50%\+ yearly'; Message = "Outdated CIPS volume still present" },
    @{ Path = "chapters/chapter_7.md"; Pattern = 'invoicing currency \(40% of SWIFT payments\)'; Message = "Outdated SWIFT share still present" }
)

foreach ($check in $staleChecks) {
    $targetPath = Join-Path $repoRoot $check.Path
    if (Test-Path $targetPath) {
        if (Select-String -Path $targetPath -Pattern $check.Pattern -Quiet) {
            Add-Error("$($check.Path): $($check.Message)")
        }
    }
}

if ($errors.Count -gt 0) {
    Write-Host "QA FAILED ($($errors.Count) issue(s))" -ForegroundColor Red
    foreach ($err in $errors) {
        Write-Host " - $err" -ForegroundColor Red
    }
    exit 1
}

Write-Host "QA PASSED: content checks succeeded." -ForegroundColor Green
