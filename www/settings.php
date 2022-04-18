<?php
require 'option.php';

$request  = "select * from `sslsuite` order by ok desc, `sslsuite_id` desc;";
$ans      = mysqli_query($connect, $request);
$protlist = array();
while ($fields = mysqli_fetch_array($ans))
{
  array_push($protlist, $fields);
}
$request  = "select * from `cyphersuite` order by ok desc, `cyphersuite_id` desc;";
$ans      = mysqli_query($connect, $request);
$cypherlist = array();
while ($fields = mysqli_fetch_array($ans))
{
  array_push($cypherlist, $fields);
}
$smarty->assign('cypherlist', $cypherlist);
$smarty->assign('protlist', $protlist);

$smarty->display('settings.tpl');
mysqli_close($connect);

?>
