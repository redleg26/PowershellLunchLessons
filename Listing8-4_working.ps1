function Get-Systeminfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [Alias('hostname')]
        [string[]]$ComputerName,

        [string]$ErrorLog = 'c:\retry.txt'
    )
    BEGIN {
        Write-Verbose "Error Log will be $ErrorLog"
    }
    PROCESS {
        foreach ($computer in $ComputerName) {
            Write-Verbose "Querying $computer"
            $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer
            $comp = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computer
            $bios = Get-WmiObject -Class Win32_BIOS -ComputerName $computer
            Write-Verbose $os
            Write-Verbose $comp
            Write-Verbose $bios
            $props = @{'ComputerName'=$computer;
                        'OSVersion'=$os.version;
                        'SPVersion'=$os.servicepackmajorversion;
                        'BIOSSerial'=$bios.serialnumber;
                        'Manufacturer'=$comp.manufacturer;
                        'Model'=$comp.model}
            Write-Verbose "WMI queries complete"
            $obj = New-Object -TypeName PSObject -Property $props
            Write-Output $obj
        }
    }
    END {
    }

}

'localhost','localhost' | Get-Systeminfo 