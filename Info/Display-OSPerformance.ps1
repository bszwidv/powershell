#Display-OSPerformance.ps1
#Displays the key OS Performance counters for a host
#Author Thomas Lee - tfl@psp.co.uk
#Tested on PowerShell RC1.1

Function Display-OSPerformance {
Param ($computer = "localhost")   #default to local host

#Use WMI to get current performance data, and do conversions a s neede

$perf= gwo Win32_PerfFormattedData_PerfOS_System -computer $computer #get perf
$uptime=$perf.SystemUpTime/3600                                      # convert to hours

# Now print the data, using normal .NET formatting

"Performance stats for:  $computer"
"{0,30}{1,10}" -f "Processes", $perf.Processes
"{0,30}{1,10}" -f "Threads", $perf.Threads
"{0,30}{1,12}" -f "System Up Time `(hours`)", $uptime.tostring("00.0")
"{0,30}{1,12}" -f "Alignment Fixups/sec", $perf.AlignmentFixupsPersec.tostring("###,##0.0")
"{0,30}{1,12}" -f "Context Switches/sec", $perf.ContextSwitchesPersec.tostring("###,##0.0")
"{0,30}{1,12}" -f "Exception Dispatches/sec", $perf.ExceptionDispatchesPersec.tostring("###,##0.0")
"{0,30}{1,12}" -f "File Control Bytes/sec", $perf.FileControlBytesPersec.tostring("###,##0.0")
"{0,30}{1,12}" -f "File Control Operations/sec", $perf.FileControlOperationsPersec.tostring("###,##0.0")
"{0,30}{1,12}" -f "File Data OperationsPersec", $perf.FileDataOperationsPersec.tostring("###,##0.0")
"{0,30}{1,12}" -f "File Read Bytes/sec", $perf.FileReadBytesPersec.tostring("###,##0.0")
"{0,30}{1,12}" -f "File Read Operations/sec", $perf.FileReadOperationsPersec.tostring("###,##0.0")
"{0,30}{1,12}" -f "File Write Bytes/sec", $perf.FileWriteBytesPersec.tostring("###,##0.0")
"{0,30}{1,12}" -f "File Write Operations/sec", $perf.FileWriteOperationsPersec.tostring("###,##0.0")
"{0,30}{1,12}" -f "Floating Emulations/rsec", $perf.FloatingEmulationsPersec.tostring("###,##0.0")
"{0,30}{1,15}" -f "Percent Registry Quota Used", $($perf.PercentRegistryQuotaInUse/100).tostring("P")
"{0,30}{1,10}" -f "Processor Queue Length", $perf.ProcessorQueueLength
"{0,30}{1,10}" -f "System Calls Persec", $perf.SystemCallsPersec
""
}

set-alias dperf Display-OSPerformance
