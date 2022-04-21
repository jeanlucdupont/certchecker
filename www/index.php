<?php
require 'option.php';


$request  = "select * from `sitedns`";
$ans      = mysqli_query($connect, $request);
$dnslist = array();
while ($fields = mysqli_fetch_array($ans))
{
  array_push($dnslist, $fields);
}
$smarty->assign('dnslist', $dnslist);

$request = "SELECT sitessl.site_id, sslsuite.ssldisplay FROM sitessl, sslsuite WHERE sitessl.sslsuite_id = sslsuite.sslsuite_id AND 
				sslsuite.ok = 0 group by sitessl.site_id, sitessl.sslsuite_id ORDER BY sitessl.site_id";
$ans     = mysqli_query($connect, $request);
$ssllist = array();
while ($fields = mysqli_fetch_array($ans))
{
  array_push($ssllist, $fields);
}
$smarty->assign('ssllist', $ssllist);
$smarty->assign('count_ssl', mysqli_num_rows($ans));

$request = "SELECT sitessl.site_id, sslsuite.ssldisplay, cyphersuite.cypher_name FROM sitessl, sslsuite, cyphersuite 
	WHERE 
		sitessl.sslsuite_id = sslsuite.sslsuite_id AND 
		sitessl.cyphersuite_id = cyphersuite.cyphersuite_id AND 
		cyphersuite.ok = 0
 ORDER BY sitessl.site_id, sitessl.cyphersuite_id, sitessl.sslsuite_id ";
$ans     = mysqli_query($connect, $request);
$cypherlist = array();
while ($fields = mysqli_fetch_array($ans))
{
  array_push($cypherlist, $fields);
}
$smarty->assign('cypherlist', $cypherlist);
$smarty->assign('count_cypher', mysqli_num_rows($ans));

$request = "SELECT *, DATEDIFF(expiration, NOW()) AS nbdays from sitecert";
$ans     = mysqli_query($connect, $request);
$certlist = array();
while ($fields = mysqli_fetch_array($ans))
{
  array_push($certlist, $fields);
}
$smarty->assign('certlist', $certlist);



$request  = "select * from `site`";
$ans      = mysqli_query($connect, $request);
$sitelist = array();
while ($fields = mysqli_fetch_array($ans))
{
  array_push($sitelist, $fields);
}
$smarty->assign('sitelist', $sitelist);
$smarty->assign('count_site', mysqli_num_rows($ans));

$smarty->display('index.tpl');
mysqli_close($connect);

?>
