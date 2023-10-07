# Grabs GPU info, places in Custom Attribute
# Allows .CSV exports to contain GPU info
# Will add more parts as needed

function Get-GPU{
    try {
        Write-Host "Grabbing GPU info"
        Get-WmiObject Win32_VideoController | Select-Object -expandproperty Caption -OutVariable gpu
        Write-Host "GPU is: $gpu"
    }
    catch {
        Write-Host "Encountered an error when grabbing GPU info...Exiting"
        return
    }
    try {
        Write-Host "Applying Custom Attribute"
        Ninja-Property-Set gpu $gpu
    }
    catch {
        Write-Host "Encountered an error when applying Custom Attribute...Exiting"
        return
    }
    return
}

function Get-SecurityApps{
    try {             # Try to find the applications
        $ErrorActionPreference = 'silentlycontinue'
        $FindBitDef = Get-Package Bitdefender* | Select-Object -ExpandProperty Name
        $FindAutoEle = Get-Package AutoElevate* | Select-Object -ExpandProperty Name
        $FindHuntress = Get-Package Huntress* | Select-Object -ExpandProperty Name
    }catch {          # Stop if something goes wrong
        Write-Host "Something went wrong while finding packages"
    }finally {        # Place the result of Yes or No in Custom Attributes.
        if (-not ([string]::IsNullOrEmpty($FindBitDef))){
            Write-Host "BitDefender is installed"
            Ninja-Property-Set bitdefender "Yes"
        }Else{
            Write-Host "BitDefender is not installed"
            Ninja-Property-Set bitdefender "NO"
        }
        if (-not ([string]::IsNullOrEmpty($FindAutoEle))){
            Write-Host "AutoElevate is installed"
            Ninja-Property-Set autoelevate "Yes"
        }Else{
            Write-Host "AutoElevate is not installed"
            Ninja-Property-Set autoelevate "NO"
        }
        if (-not ([string]::IsNullOrEmpty($FindHuntress))){
            Write-Host "Huntress Labs is installed"
            Ninja-Property-Set huntresslabs "Yes"
        }Else{
            Write-Host "Huntress Labs is not installed"
            Ninja-Property-Set huntresslabs "NO"
        }
    }
}

function Get-RevitInfo{
    # Redundantly check Revit versions---------------
    # Check Revit 2020-------------------------------
    $test = Get-WmiObject -ClassName Win32_product | Where-Object {$_.Name -Match "Revit*"}
    $Revit2020 = $test | Where-Object {$_.Name -eq "Revit 2020"} | Select-Object -ExpandProperty Version
    $emptyCheck = $Revit2020 -eq $null
    if ($emptyCheck -eq $true){
        Ninja-Property-Set revit2020 "Not Found"
    }Else{
        Ninja-Property-Set revit2020 $Revit2020
    }
    
    # Check Revit 2021-------------------------------
    $Revit2021 = $test | Where-Object {$_.Name -eq "Revit 2021"} | Select-Object -ExpandProperty Version
    $emptyCheck = $Revit2021 -eq $null
    if ($emptyCheck -eq $true){
        Ninja-Property-Set revit2021 "Not Found"
    }Else{
        Ninja-Property-Set revit2021 $Revit2021
    }
    
    # Check Revit 2022-------------------------------
    $Revit2022 = $test | Where-Object {$_.Name -eq "Revit 2022"} | Select-Object -ExpandProperty Version
    $emptyCheck = $Revit2022 -eq $null
    if ($emptyCheck -eq $true){
        Ninja-Property-Set revit2022 "Not Found"
    }Else{
        Ninja-Property-Set revit2022 $Revit2022
    }
    
    # Check Revit 2023-------------------------------
    $Revit2023 = $test | Where-Object {$_.Name -eq "Revit 2023"} | Select-Object -ExpandProperty Version
    $emptyCheck = $Revit2023 -eq $null
    if ($emptyCheck -eq $true){
        Ninja-Property-Set revit2023 "Not Found"
    }Else{
        Ninja-Property-Set revit2023 $Revit2023
    }
    
    # Check Revit 2024-------------------------------
    $Revit2024 = $test | Where-Object {$_.Name -eq "Revit 2024"} | Select-Object -ExpandProperty Version
    $emptyCheck = $Revit2024 -eq $null
    if ($emptyCheck -eq $true){
        Ninja-Property-Set revit2024 "Not Found"
    }Else{
        Ninja-Property-Set revit2024 $Revit2024
    }
}

Get-GPU
Get-SecurityApps
Get-RevitInfo
