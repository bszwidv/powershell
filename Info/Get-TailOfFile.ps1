#Get-TailOfFile.ps1
#Author: Thomas Lee tfl@psp.co.uk
#Tested on PowerShell RC1.1

function Get-TailOfFile { Param([string] $fil, [int] $toget)
       # check patch
         if (! (test-path $fil)) {whb "Error: File $fil does not exist"; return;}  
       # 10 if hard coded default number to get
         if (!$toget) {$toget=10}
       # So do it
         cat $fil | select-object -last $toget
}
set-alias tail Get-TailOfFile