# PowerShell script to compile the complete textbook PDF

Write-Host "Compiling complete textbook PDF..." -ForegroundColor Green
Write-Host ""

$chapterFiles = @(
    "chapters/ch01_foundations/chapter_1.md",
    "chapters/ch02_supply_chains/chapter_2.md",
    "chapters/ch03_critical_sectors/chapter_3.md",
    "chapters/ch04_high_tech/chapter_4.md",
    "chapters/ch05_information/chapter_5.md",
    "chapters/ch06_trade_controls/chapter_6.md",
    "chapters/ch07_financial_statecraft/chapter_7.md",
    "chapters/ch08_investment_industrial/chapter_8.md",
    "chapters/ch09_historical_cases/chapter_9.md",
    "chapters/ch10_future/chapter_10.md"
)

$outputFile = "Economic_Coercion_Complete_Textbook.pdf"

Write-Host "Combining all chapters..." -ForegroundColor Yellow

pandoc `
    $chapterFiles `
    -o $outputFile `
    --pdf-engine=xelatex `
    -V fontsize=11pt `
    -V geometry:margin=1.25in `
    --toc `
    --toc-depth=2 `
    -V documentclass=book `
    -V title="Economic Coercion in the 21st Century" `
    -V subtitle="Tools, Strategies, and Great Power Competition" `
    -V author="Laurence Wilson" `
    -V date="November 2025" `
    --number-sections `
    2>$null

if (Test-Path $outputFile) {
    $fileSize = (Get-Item $outputFile).length / 1MB
    Write-Host ""
    Write-Host "Success! Created complete textbook PDF" -ForegroundColor Green
    Write-Host "  File: $outputFile" -ForegroundColor Cyan
    Write-Host "  Size: $([math]::Round($fileSize, 2)) MB" -ForegroundColor Cyan

    # Get page count (approximate from file size)
    Write-Host ""
    Write-Host "Textbook compilation complete!" -ForegroundColor Green
} else {
    Write-Host "Failed to create complete textbook PDF" -ForegroundColor Red
}
