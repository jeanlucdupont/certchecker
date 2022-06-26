<?php
$server = "127.0.0.1";
$db = "certchecker";
$login = "xxx";
$pass = "xxx";

$connect = @mysqli_connect($server, $login, $pass, $db) or die ("Can't connect to the database");

#$select = @mysqli_select_db($db, $connect) or die ("Unknown Database");

?>
