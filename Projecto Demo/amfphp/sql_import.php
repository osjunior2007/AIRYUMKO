<?php
create_database ("localhost","root","","database.sql");
function create_database ($host,$user,$pass,$file_sql_name){
$link = mysql_connect ( $host, $user, $pass);
$f = fopen($file_sql_name,"r+");
$sqlFile = fread($f, filesize($file_sql_name));
$sqlArray = explode(';', $sqlFile);
foreach ($sqlArray as $stmt)
   {
       mysql_query($stmt);
   }
}
?>
