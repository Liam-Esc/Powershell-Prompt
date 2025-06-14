<# 
Liam Esucsa 
Student ID: 011950351 
#>

#Region Function: Display Menu
function Show-Menu {
    param (
        [string]$Title = "Main Menu",
        [string[]]$Options
    )

    do {
        Clear-Host
        Write-Host $Title
        Write-Host "==========="
        for ($i = 0; $i -lt $Options.Length; $i++) {
            Write-Host "$($i + 1). $($Options[$i])"
        }

        $selection = Read-Host "Please select an option (1-5)"

        $isValid = ($selection -match '^\d+$') -and ([int]$selection -ge 1) -and ([int]$selection -le $Options.Length)

        if (-not $isValid) {
            Write-Host -ForegroundColor Yellow "`nInvalid selection. Please try again.`n"
        }
    } until ($isValid)

    return [int]$selection
}
#EndRegion

#Region Main Script Logic

# Set the menu options
$menuOptions = @(
    "List .log files → DailyLog.txt",
    "List all files alphabetically → C916contents.txt",
    "Show CPU & Memory usage",
    "Show processes sorted by VM (grid)",
    "Exit"
)

try {
    do {
        # Show the menu and capture user input
        $choice = Show-Menu -Title "Please Select a Number" -Options $menuOptions

        switch ($choice) {

            1 {
                # B1: List .log files and append to DailyLog.txt with timestamp
                $logFiles = Get-ChildItem -Path "." -Filter "*.log" | Select-Object -ExpandProperty Name
                $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                $entry = "$timestamp - $($logFiles -join ', ')"
                Add-Content -Path ".\DailyLog.txt" -Value $entry
                Write-Host "Log files appended to DailyLog.txt."
            }

            2 {
                # B2: List all files alphabetically into C916contents.txt in table format
                Get-ChildItem | Sort-Object Name | Format-Table -AutoSize | Out-File -FilePath ".\C916contents.txt"
                Write-Host "File list saved to C916contents.txt."
            }

            3 {
                # B3: Show current CPU and memory usage
                $cpu = Get-CimInstance -ClassName Win32_Processor | Select-Object -ExpandProperty LoadPercentage
                $mem = Get-CimInstance -ClassName Win32_OperatingSystem
                $totalMem = [math]::Round($mem.TotalVisibleMemorySize / 1024, 2)
                $freeMem = [math]::Round($mem.FreePhysicalMemory / 1024, 2)
                $usedMem = [math]::Round($totalMem - $freeMem, 2)

                Write-Host "CPU Load: $cpu%"
                Write-Host "Memory Usage: $usedMem MB / $totalMem MB"
            }

            4 {
                # B4: Show running processes sorted by Virtual Memory in grid format
                Get-Process | Sort-Object VirtualMemorySize -Ascending | Out-GridView -Title "Running Processes by Virtual Memory"
            }

            5 {
                # B5: Exit script
                Write-Host -ForegroundColor Cyan "`nThank you. Have a great day!"
            }
        }

        Pause

    } until ($choice -eq 5)
}
catch [System.OutOfMemoryException] {
    Write-Host -ForegroundColor Red "ERROR: System ran out of memory."
    $_
}
catch {
    Write-Host -ForegroundColor Red "An unexpected error occurred."
    $_
}

#EndRegion
