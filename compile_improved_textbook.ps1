# PowerShell script to compile the improved professional textbook

Write-Host "======================================================" -ForegroundColor Cyan
Write-Host " Compiling Professional Textbook - Improved Edition" -ForegroundColor Green
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host ""

$allFiles = @(
    "front_matter/title_copyright.md",
    "front_matter/preface.md",
    "chapters/ch01_foundations/chapter_1.md",
    "chapters/ch02_supply_chains/chapter_2.md",
    "chapters/ch03_critical_sectors/chapter_3.md",
    "chapters/ch04_high_tech/chapter_4.md",
    "chapters/ch05_information/chapter_5.md",
    "chapters/ch06_trade_controls/chapter_6.md",
    "chapters/ch07_financial_statecraft/chapter_7.md",
    "chapters/ch08_investment_industrial/chapter_8.md",
    "chapters/ch09_historical_cases/chapter_9.md",
    "chapters/ch10_future/chapter_10.md",
    "front_matter/bibliography.md",
    "front_matter/glossary.md"
)

$outputFile = "Economic_Coercion_Professional_Edition_v2.pdf"

Write-Host "Compiling with improved template..." -ForegroundColor Yellow
Write-Host "  - Using Times New Roman font for better readability"
Write-Host "  - Fixed chapter/section headers (no duplication)"
Write-Host "  - Enabled figure inclusion"
Write-Host "  - Added bibliography and glossary"
Write-Host ""

pandoc $allFiles -o $outputFile --template=improved_template.latex --pdf-engine=xelatex -V fontsize=11pt --toc --toc-depth=2 --number-sections -V toc-title="Table of Contents" 2>&1 | Out-File -FilePath "pandoc_compile.log"

if (Test-Path $outputFile) {
    $fileSize = (Get-Item $outputFile).length / 1MB
    Write-Host "======================================================" -ForegroundColor Green
    Write-Host " SUCCESS - Professional Textbook Created!" -ForegroundColor Green
    Write-Host "======================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "File Information:" -ForegroundColor Cyan
    Write-Host "  Title:   Economic Coercion in the 21st Century" -ForegroundColor White
    Write-Host "  Author:  Laurence Wilse-Samson" -ForegroundColor White
    Write-Host "  File:    $outputFile" -ForegroundColor White
    Write-Host "  Size:    $([math]::Round($fileSize, 2)) MB" -ForegroundColor White
    Write-Host ""
    Write-Host "Contents Included:" -ForegroundColor Cyan
    Write-Host "  [+] Title page with author affiliation" -ForegroundColor White
    Write-Host "  [+] Copyright and publication information" -ForegroundColor White
    Write-Host "  [+] Preface" -ForegroundColor White
    Write-Host "  [+] Table of contents" -ForegroundColor White
    Write-Host "  [+] 10 complete chapters" -ForegroundColor White
    Write-Host "  [+] Bibliography" -ForegroundColor White
    Write-Host "  [+] Glossary" -ForegroundColor White
    Write-Host ""
    Write-Host "Improvements:" -ForegroundColor Cyan
    Write-Host "  [+] Professional Times New Roman font" -ForegroundColor White
    Write-Host "  [+] Fixed header formatting" -ForegroundColor White
    Write-Host "  [+] Corrected section numbering" -ForegroundColor White
    Write-Host "  [+] Figure support enabled" -ForegroundColor White
    Write-Host ""
    Write-Host "Additional Resources:" -ForegroundColor Cyan
    Write-Host "  - 20 data visualizations in /figures directory" -ForegroundColor White
    Write-Host "  - 20 source datasets in /data/sources directory" -ForegroundColor White
    Write-Host "  - Python scripts for all visualizations" -ForegroundColor White
    Write-Host "  - Compilation log: pandoc_compile.log" -ForegroundColor White
    Write-Host ""
    Write-Host "======================================================" -ForegroundColor Green
    Write-Host " Textbook compilation complete!" -ForegroundColor Green
    Write-Host "======================================================" -ForegroundColor Green
} else {
    Write-Host "======================================================" -ForegroundColor Red
    Write-Host " Compilation Failed" -ForegroundColor Red
    Write-Host "======================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Check pandoc_compile.log for error details" -ForegroundColor Yellow
    Write-Host ""
    if (Test-Path "pandoc_compile.log") {
        Get-Content "pandoc_compile.log" | Select-Object -Last 20
    }
}
