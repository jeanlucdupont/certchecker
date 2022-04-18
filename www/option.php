<?php
# WARNING. Make this sure that the first line of this file starts with "<?php" and certainly not an empty line.

#Redirect to HTTPS
/* if ($_SERVER['SERVER_PORT'] != 443) 
{
   header("HTTP/1.1 301 Moved Permanently");
   header("Location: https://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
   exit();
}
*/

# Smarty + DB
session_start();
require('/usr/lib/php/Smarty/Smarty.class.php');
require 'connect_db.php';
$smarty 				= new Smarty;
$smarty->compile_check 	= true;

# Nag screen
if (isset($_GET['warnit']))
{
	$smarty->assign('warnit', 1);
}

#Common constants
$ncstatus_array =  array (
					'Not created', 					'Waiting for local answer', 	'Waiting for global security team validation', 
					'global security team did not validate. Review',	'Waiting for scheme answer',	'Answer not accepted', 			
					'More information required', 	'Accepted & closed',			'Accepted & closed',
					'Accepted & closed');
$ncstatusc_array = array (
					'#FFFFFF', 						'#FF0000', 						'#FF66FF', 
					'#FF0000', 						'#FFFF00',						'#FF0000',						
					'#FF0000', 						'#00FFFF', 						'#00FF00',
					'#00FF00');
$ncstatust_array = array (
					'The non conformance has not been created yet. No status can be given.',
					'The non conformance has no answer yet. Waiting for local team input.',
					'An answer has been submitted to the global security team. Waiting for global security team validation.',
					'You answer was not validated by the global security team. Review their comment and adapt your answer.',
					'An answer has been submitted to scheme after global security team validation. Waiting for scheme feedback.',
					'Scheme has refused the answer. Another answer must be provided. Waiting for local team input.',
					'Scheme has globaly accepted the answer but wants more information. Waiting for local team input.',
					'Scheme has accepted the answer and has closed the non conformance.
						<b>However</b>, scheme wants to be notified when the action plan is completed.',
					'Scheme has accepted the answer and has closed the non conformance unconditionnaly.',
					'Scheme has accepted the answer and has closed the non conformance.
						You have notified the scheme when the action plan is completed.');
# ##########################################################################################
# Let's define some functions
# ##########################################################################################

# Tell if logged in user is admin or not
function isadmin()
{
	global $connect;
	
	$lusername 	= $_SESSION['user_id'];
	$lrequest 	= "SELECT `global` FROM `at_user` where `username`='" . $lusername . "'";
	$lreq 	 	= mysqli_query($connect, $lrequest);
   	$lans	 	= mysqli_fetch_array($lreq);
	if ($lans['global'] == "1")
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

# Get the status of an NC
function getncstatus($numaudit, $numnc)
{
	global $connect;
	
	$req 	= "select * from `at_nc` where `audit_id`='" . $numaudit . "' and `nc_id`='" . $numnc . "';";
	$ans	= mysqli_query($connect, $req);
	if (mysqli_num_rows($ans) == 0)
	{
		# NC does not exist? ==> Status = 0
		return(0);
	}
	else
	{
		$fields = mysqli_fetch_array($ans);
		return($fields['ncstatus']);
	}
}

# Check the POST value of a variable
function checkpost($postvar)
{
	if (!isset($_POST["$postvar"]))
	{
		return(false);
	}
	if (strlen($_POST["$postvar"]) == 0)
	{
		return(false);
	}
	return(true);
}

# Check the POST value of a variable (assumes the POST value is verified first)
function cleanpost($postvar)
{
	return(mysqli_real_escape_string($connect, trim($_POST["$postvar"])));
}

# Set the status of an NC
function setncstatus($numaudit, $numnc, $status)
{
	global $connect;
	
	$req	= "update `at_nc` set `ncstatus`='" . $status . "' ";
	$req	.= "where `nc_id`='" . $numnc . "' and `audit_id`='" . $numaudit . "';";		
	$ans	= mysqli_query($connect, $req);
}

# Get the name of the logged in user
function getusername()
{
	return($_SESSION['user_id']);
}

# Tell if user is entitled to read this audit. Detecting users fiddling with URL...
function canreadaudit($numaudit)
{
	global $connect;
	
	# User is admin? Full right
	if (isadmin())
	{
		return;
	}
	
	# User is not admin. Let's check if he can read this audit (and NC).
	$req	= "select distinct at_audit.audit_id from `at_audit`, `at_usersite` where ";
	$req	.= "at_audit.audit_id='" . $numaudit . "' and ";
	$req	.= "at_usersite.sitename=at_audit.sitename and ";
	$req	.= "at_usersite.username='" . getusername() . "'";
	$ans	= mysqli_query($connect, $req);
	if (mysqli_num_rows($ans) == 0)
	{
		# User has no right to access this audit ==> out
		header("location: megusta.html");
	}
}

# Tell if user is entitled to read this site information. Detecting users fiddling with URL...
function canreadsite($sitename)
{
	global $connect;
	
	# User is admin? Full right
	if (isadmin())
	{
		return;
	}
	
	if (strcmp($sitename, "All") == 0)
	{
		return;
	}
	
	if ($sitename == '')
	{
		return;
	}
	
	# User is not admin. Let's check if he can read this audit (and NC).
	$req	= "select * from `at_usersite` where ";
	$req	.= "at_usersite.username='" . getusername() . "' and ";
	$req	.= "at_usersite.sitename='" . $sitename . "'";
	$ans	= mysqli_query($connect, $req);
	if (mysqli_num_rows($ans) == 0)
	{
		# User has no right to access this audit ==> out
		header("location: megusta.html");
	}
}

# Tell if browser is internet explorer
function isie()
{
    if (isset($_SERVER['HTTP_USER_AGENT']) && 
    (strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE') !== false))
        return 1;
    else
        return 0;
}
						
?>
