<?php
require 'option.php';

$smarty->display('index.tpl');
mysqli_close($connect);

?>
