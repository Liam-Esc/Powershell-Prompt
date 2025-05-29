#Liam Esucsa     #Student ID 011950351

#Begin User Prompt Menu
do {
    Write-Host "Menu"
    Write-Host "1) List .log within Requirements1 folder"
    Write-host "2) List Requirements 1 folder in alphabetical order"
    Write-host "3) List cpu and memory usage"
    Write-host "4) List different running processes by greatest to least virtual size"
    Write-Host "5) Exit script execution"

#get user input
switch ($choice) {
    1 { #B1. List files within Requirements1 folder and redirect results to DailyLog.txt
        $logfiles = Get-ChildItem -Filter "*.log" | Select-Object -ExpandProperty Name
        $logfilesdate = "$(Get-Date) - $(logfiles -join ', ')"
        #append to dailylog.txt without overwriting
        Add-Content -Path ".\DailyLog.txt" -Value $logfilesdate
        Write-Host "Log files listed and append to DailyLog.txt."
    }

    2{

    }
    condition {  }
    Default {}
}
69CE586EB0A3AF3B1A056F768822A1DA02E5646E589132EC251F1E235C9C74AB
