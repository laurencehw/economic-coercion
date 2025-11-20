# PowerShell script to compile all chapters to PDFs

$chapters = @(
    @{dir="ch01_foundations"; file="chapter_1.md"; title="Chapter 1: Foundations"},
    @{dir="ch02_supply_chains"; file="chapter_2.md"; title="Chapter 2: Supply Chains"},
    @{dir="ch03_critical_sectors"; file="chapter_3.md"; title="Chapter 3: Critical Sectors"},
    @{dir="ch04_high_tech"; file="chapter_4.md"; title="Chapter 4: High Technology"},
    @{dir="ch05_information"; file="chapter_5.md"; title="Chapter 5: Information"},
    @{dir="ch06_trade_controls"; file="chapter_6.md"; title="Chapter 6: Trade Controls"},
    @{dir="ch07_financial_statecraft"; file="chapter_7.md"; title="Chapter 7: Financial Statecraft"},
    @{dir="ch08_investment_industrial"; file="chapter_8.md"; title="Chapter 8: Investment and Industrial Policy"},
    @{dir="ch09_historical_cases"; file="chapter_9.md"; title="Chapter 9: Historical Cases"},
    @{dir="ch10_future"; file="chapter_10.md"; title="Chapter 10: Future"}
)

Write-Host "Compiling all chapters to PDF..." -ForegroundColor Green
Write-Host ""

foreach ($chapter in $chapters) {
    $inputPath = "chapters/$($chapter.dir)/$($chapter.file)"
    $outputPath = "chapters/$($chapter.dir)/$($chapter.file -replace '\.md$','.pdf')"

    Write-Host "Compiling $($chapter.title)..." -ForegroundColor Yellow

    pandoc $inputPath -o $outputPath --template=improved_template.latex --pdf-engine=xelatex -V fontsize=11pt --toc --toc-depth=2 -V title="$($chapter.title)" 2>$null

    if (Test-Path $outputPath) {
        Write-Host "  Created: $outputPath" -ForegroundColor Green
    } else {
        Write-Host "  Failed: $outputPath" -ForegroundColor Red
    }
    Write-Host ""
}

Write-Host "All chapters compiled!" -ForegroundColor Green
