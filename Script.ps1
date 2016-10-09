#
# Script.ps1
#

#Set-ExecutionPolicy RemoteSigned

$a = 5
$b = 6
$c = 7
$d = $a,$b,$c
foreach($i in $d)
{
	$i + 5
}

#---------------------------------

$trees = @("Alder","Ash","Birch","Cedar","Chestnut","Elm")

 foreach ($tree in $trees) {
   "$tree = " + $tree.length
 }

#---------------------------------

$my_variable = "ss64"
switch ($my_variable)
{
	ss61 {"First result"; break}
	ss62 {"Second"; break}
	ss63 {"Third"; break}
	ss64 {"Fourth"; break}
	ss65 {"Fifth"; break}
	default {"Something else happened"; break}
}

#---------------------------------

get-service | 
    foreach-object{
        if ($_.status -eq "stopped")
        {
            write-host -f red $_.name $_.status
        }
        else
        {
            write-host -f green $_.name $_.status}
        }

#---------------------------------

while($val -ne 10)
     {
       $val++
       Write-Host $val
     }

#---------------------------------

$i = 0

while ($i -lt 10) {
   $i +=1 
   if ($i -eq 5) {break}
   Write-Host $i
}

#---------------------------------


