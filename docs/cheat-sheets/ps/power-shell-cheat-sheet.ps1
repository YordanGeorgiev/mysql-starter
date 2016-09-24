# start powershell as non-admin , Start - Run:

#assemble together all of the free disk space data from the list of servers and only include it if the percentage free is below the threshold we set above.

# how-to check disk space with powershell in one liner
Get-PSDrive -PSProvider FileSystem

Name           Used (GB)     Free (GB) Provider      Root
----           ---------     --------- --------      ----
A                                      FileSystem    A:\
C                  51,84          2,82 FileSystem    C:\
D                  17,14          7,86 FileSystem    D:\
E                  37,34        162,66 FileSystem    E:\
F                  13,78          6,22 FileSystem    F:\
G                                      FileSystem    G:\
Z                                      FileSystem    Z:\


powershell.exe -ExecutionPolicy bypass

#or  
powershell.exe Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# Get a simple directory listing   - dir /r 
get-childitem -recurse
dir /w 

# get the 10 most memory consuming processes
ps | sort -p ws | select -last 10

# kill a process 
ps notepad | kill 

# alias for find on Windows
Get-ChildItem -Path C:\ -Filter *.exe  -Recurse | % { $_.FullName }

#how-to get all the executables on a Windows system 
gdr -PSProvider 'FileSystem' | % { $_.Root } | Where-Object { 
   $drive=$_
   doLog "drive $drive"
   Get-ChildItem -Filter *.exe -Path $drive -Recurse | % { 
   doLog $_.FullName 
       
   }
}



# use the unix datetime formating
Get-Date -UFormat %y%m%d_%H%M%S
$mrt=(Get-Date -UFormat "%y%m%d_%H%M%S")
$hrt=(Get-Date -UFormat "%y-%m-%d %H:%M:%S");echo $hrt

# how-to search and replace recursively 
Get-ChildItem $dir *.$file_extension -recurse |
    Foreach-Object {
        $c = ($_ | Get-Content) 
        $c = $c -replace $to_srch,$to_repl
        [IO.File]::WriteAllText($_.FullName, ($c -join "`r`n"))
    }


# how-to convert 
Get-Content -Encoding UTF8 FILE-UTF8.TXT | Out-File -Encoding UTF7 FILE-UTF7.TXT
