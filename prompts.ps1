<#Liam Esucsa     Student ID 011950351#>

#Region Functions
function Show-Menu {
   
    param (
        [string]$Title = "Main Menu",
        [string[]]$Options
   ) 

    Write-Verbose "Running Show-Menu Function"

    Write-Host $Title
    Write-host "==========="
    # Create a loop for 5 options
    for($i - 0; $i -lt $Options.Length; $i++)
    {
            #Iterate over the array and write the selection number
            Write-Host "$($i+1). $($Options[$i])"
    }

    # Prompt User For Input
    $selection = Read-Host "Please select an option"

    # Validate the input with RegEx
    if ($selection -match '^\d+$' -and $selection -le $Options.Length)
    {
            #Return the selection
            return $selection
    }
    else {
        # if the input is invalid, inform the user and re-prompt
        Write-Host -ForegroundColor DarkYellow "'n*Invalid selection. Please try again*'n"
        Show-Menu -Title $Title -Options $Options
    }

}
   
#EndRegion

#Main Script Logic
$menuOptions = @("List files in Requirements1 (.log), List files in Requirements1 (alphabetical), List CPU and Memory Usage, List Running Processes, Exit")


$UserInput = 1


    try {
        while($UserInput -ne 5)
        {
            $UserInput = Show-Menu -Title "Please Select a Number" -Options $menuOptions

            switch ($UserInput) 
            {
                1
                {
                    #List files within Requirements1 folder and redirect results to DailyLog.txt
                    $logfiles = Get-ChildItem -Filter "*.log" | Select-Object -ExpandProperty Name
                    $logfilesdate = "$(Get-Date) - $(logfiles -join ', ')"
                    #append to dailylog.txt without overwriting
                    Add-Content -Path ".\DailyLog.txt" -Value $logfilesdate
                    Write-Host "Log files listed and append to DailyLog.txt."
                }
                
                2{ 
                    #List files in Requirements1 folder (alphabetical) and redirect results to DailyLog.txt
                    $files = Get-ChildItem | Sort-Object Name 
                    $files | Sort-Object -Property Name | Format-Table -AutoSize | Out-File -FilePath ".\C916contents.txt" -Append
                }

                3{
                    #List CPU and Memory Usage
                    $cpuUsage = Get-CimInstance -ClassName Win32_Processor | Select-Object -ExpandProperty LoadPercentage
                    $memoryUsage = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty FreePhysicalMemory
                }   

                4{
                    #List running process by virtual size least to greatest
                    Write-Verbose "Option 4 Selected"
                    Get-Process | Sort-Object -Property VirtualMemorySize | Select-Object -Property Name, VirtualMemorySize, WorkingSet | Format-Table -AutoSize
                }

                5{
                    #Exit Program
                    Write-Verbose "Option 5 Selected"
                    Write-Host -ForegroundColor Cyan "Thank you. Have a great day!"
                }
            }

        }
    }
    
    #Exception Handling System.OutOfMemoryException
    
    catch [System.OutOfMemoryException]
    {
        Write-Host -ForegroundColor Red "ERROR"
        $_
    }
    catch
    {
        Write-Host -ForegroundColor Red "System.OutOfMemoryException"
        $_
    }
    try {
        
    }
    finally 
    {
        # Close any open resource
    }


