#Display-HelpSyntax.msh
# Displays the help syntax for an alias or a command
# Author Thomas Lee tfl@psp.co.uk
Function Display-HelpSyntax {
Param ($Command)
#check if any paramaters passed
if (! $command)   { # no command specified  
    "No command specified"
    return
   }
#try to get help for the command, and fail silently
$HelpText=Get-Help $command -EA SilentlyContinue
#check if anything returned
If (! $HelpText)   {
      "No help found for $command";return
    }
#If > 1 returned, just display the array and return
If ($Helptext.length -gt 1)  { # more then one 
      $HelpText
      Return
    }
If ($command -ne $HelpText.Name)  { # we have an alias
     "$command is an alias for $($helptext.name)"
     }
# Finally, Generate the  the syntax 
  "Syntax for $($HelpText.Name) is:"
  "$($helptext.synopsis)"
}
set-alias dhs Display-HelpSyntax
set-alias ghs Display-HelpSyntax