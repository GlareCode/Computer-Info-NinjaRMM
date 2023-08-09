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


Get-GPU
