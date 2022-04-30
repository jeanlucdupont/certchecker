<?php
require 'option.php';

if (isset($_POST['newsite']))
{
	$newsite = strip_tags($_POST['newsite']);
	$newsite = str_replace(' ', '', $newsite);
	if (strlen($newsite) == 0)
	{
		print("<script>window.alert(\"Site name is empty\");</script>");
	}
	else
	{
		$request  = "select * from `site` where `address` = \"" . $newsite . "\"";
		$ans      = mysqli_query($connect, $request);
		if (mysqli_num_rows($ans) != 0)
		{
			print("<script>window.alert(\"[" .  $newsite ."] already exists\");</script>");
		}
		else
		{
			$request  = "insert into `site` (address) values (\"" . $newsite . "\")";
			$ans      = mysqli_query($connect, $request);
		}
	}
}

if (isset($_GET['idel']))
{
	$idel = $_GET['idel'];
	if (is_numeric($idel))
	{
		$request  = "delete from sitessl where `site_id`  = " . $idel;
		$ans      = mysqli_query($connect, $request);		
		$request  = "delete from sitedns where `site_id`  = " . $idel;
		$ans      = mysqli_query($connect, $request);		
		$request  = "delete from sitecert where `site_id`  = " . $idel;
		$ans      = mysqli_query($connect, $request);		
		$request  = "delete from site where `site_id`  = " . $idel;
		$ans      = mysqli_query($connect, $request);		
	}
}
	

$request  = "select * from `site` order by `address`";
$ans      = mysqli_query($connect, $request);
$sitelist = array();
while ($fields = mysqli_fetch_array($ans))
{
  array_push($sitelist, $fields);
}
$smarty->assign('sitelist', $sitelist);
$smarty->assign('count_site', mysqli_num_rows($ans));

$smarty->display('sites.tpl');
mysqli_close($connect);

?>
