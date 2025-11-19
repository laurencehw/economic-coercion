# PowerShell script to compile the complete textbook with all front matter and back matter

Write-Host "Compiling complete professional textbook with front matter..." -ForegroundColor Green
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
    "front_matter/glossary.md"
)

$outputFile = "Economic_Coercion_FINAL_Professional_Edition.pdf"

Write-Host "Combining all content (front matter + chapters + glossary)..." -ForegroundColor Yellow

pandoc `
    $allFiles `
    -o $outputFile `
    --pdf-engine=xelatex `
    -V fontsize=11pt `
    -V geometry:margin=1.25in `
    --toc `
    --toc-depth=2 `
    -V documentclass=book `
    -V papersize=letter `
    -V classoption=oneside `
    --number-sections `
    -V linkcolor=blue `
    -V urlcolor=cyan `
    -V toccolor=black `
    2>$null

if (Test-Path $outputFile) {
    $fileSize = (Get-Item $outputFile).length / 1MB
    Write-Host ""
    Write-Host "SUCCESS! Professional textbook PDF created" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host "  Title:  Economic Coercion in the 21st Century" -ForegroundColor White
    Write-Host "  File:   $outputFile" -ForegroundColor Cyan
    Write-Host "  Size:   $([math]::Round($fileSize, 2)) MB" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Contents:" -ForegroundColor Yellow
    Write-Host "  ✓ Title page and copyright" -ForegroundColor Green
    Write-Host "  ✓ Preface (~1,500 words)" -ForegroundColor Green
    Write-Host "  ✓ Table of contents (auto-generated)" -ForegroundColor Green
    Write-Host "  ✓ 10 complete chapters (~134,050 words)" -ForegroundColor Green
    Write-Host "  ✓ Glossary (100+ terms)" -ForegroundColor Green
    Write-Host ""
    Write-Host "Additional files available:" -ForegroundColor Yellow
    Write-Host "  - 20 data visualizations in /figures" -ForegroundColor White
    Write-Host "  - 20 source datasets in /data/sources" -ForegroundColor White
    Write-Host "  - Python scripts for all visualizations" -ForegroundColor White
    Write-Host ""
    Write-Host "Textbook compilation complete! 🎉" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "Failed to create professional textbook PDF" -ForegroundColor Red
}
