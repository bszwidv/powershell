#get-HeadOfFile.ps1
#Author:  Thomas Lee  tfl@psp.co.uk
#Tested on PowerShell RC1.1

function Get-HeadOfFile { param([string] $fil, [int] $toget)
       # check path
         if (! (test-path $fil)) {whb "Error: File $fil does not exist"; return;}
       # 10 is hardcoded default number to get
         if (!$toget){  $toget=10}
       # get the first n
         cat $fil | select-object -first $toget
}
set-alias  head Get-HeadOfFile
