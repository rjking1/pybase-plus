<?php 

function mysql_die($error = "unknown") 
{ 
echo "Error:" . $error; 
exit; 
} 

$db =  $_GET["db"];
$func = $_GET["func"];

$cmd = ($func=="r" ? "mysql" : "mysqldump") . " --user=art25285 --password=ear724gni --host=localhost art25285_" . $db . " " . ($func == "r" ? "<" : ">") . " ./" . $db . ".sql";
$output = shell_exec($cmd);

echo $cmd . "." . $output . ".";
  
?>