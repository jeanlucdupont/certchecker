<?php
require 'option.php';


foreach ($_POST as $key => $value) 
{
	$porc = substr(htmlspecialchars($key), 0, 1);
	$porcid = substr(htmlspecialchars($key), 1);
	if ($porc == 'p')
	{
		mysqli_query($connect, "update sslsuite set ok = " . $value . " where sslsuite_id = " . $porcid);
	}
	if ($porc == 'c')
	{
		mysqli_query($connect, "update cyphersuite set ok = " . $value . " where cyphersuite_id = " . $porcid);
		
	}		   
}


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
