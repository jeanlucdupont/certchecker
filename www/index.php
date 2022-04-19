<?php
require 'option.php';

$request  = "select * from `site`";
$ans      = mysqli_query($connect, $request);
$smarty->assign('nbsite', mysqli_num_rows($ans));

$request  = "select * from `site`";
$ans      = mysqli_query($connect, $request);
$biglist = array();
while ($fields = mysqli_fetch_array($ans))
{
  array_push($biglist, $fields);
}
$smarty->assign('biglist', $biglist);

$smarty->display('index.tpl');
mysqli_close($connect);

?>
