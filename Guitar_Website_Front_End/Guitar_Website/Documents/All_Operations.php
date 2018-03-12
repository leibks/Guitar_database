
<html>
<head><title> Operations </title></head>
<left><body background = "background_guitar.jpg"> 
<h2>  Choose Operations!</h2>
<form action ="All_Operations.php" method="post" >
<table border = "1" width="100" height="150">
<tr>	<td colspan ="30" align = "center" >
       <input style="font-size:20px;"  type = "submit" name = "searchGuitar" value="Search Guitar Informataion"> 
	   </td> 
</tr>

<tr>	<td colspan ="30" align = "center" >
       <input style="font-size:20px;"  type = "submit" name = "editInfor" value="Edit User Information"> 
	   </td> 
</tr>

<tr>	<td colspan ="30" align = "center" >
       <input style="font-size:20px;"  type = "submit" name = "showInfor" value="Show User Information"> 
	   </td> 
</tr>

<tr>	<td colspan ="30" align = "center" >
       <input style="font-size:20px;"  type = "submit" name = "searchCompany" value="Search Company Information"> 
	   </td> 
</tr>

<tr>	<td colspan ="30" align = "center" >
       <input style="font-size:20px;"  type = "submit" name = "searchStore" value="Search Retail Store Information"> 
	   </td> 
</tr>

<tr>	<td colspan ="30" align = "center" >
       <input style="font-size:20px;"  type = "submit" name = "searchMuseum" value="Search Museum Information"> 
	   </td> 
</tr>
	
</table>

<td colspan ="30" align = "center" >
       <input  style="font-size:15px;" type = "submit" name = "logout" value="Log Out"> 


</form>
</body></left>
</html>  



<?php


require_once('../Connect_Database.php');

	session_start();
	
	// transform the name and password
	if($_GET){
	$_SESSION['name']  = $_GET['name']; 
	$_SESSION['password']  = $_GET['password'];
    } else{
		// echo "Please input your user name and password in log in firstly";
    }

/*
if(isset($_POST['searchCompany'])){
	
	ob_start();
    header('Location: SearchCompany.php');
    ob_end_flush();
    die();
	
}
*/

if(isset($_POST['showInfor'])){
	echo $_name = $_SESSION['name'];
	echo $_pass = $_SESSION['password'];
	ob_start();
    header('Location: ShowUserInfor.php?
		name='.$_name.'&password='.$_pass);
    ob_end_flush();
    die();
	
	
}

if(isset($_POST['searchGuitar'])){
	
	ob_start();
    header('Location: SearchGuitar.php');
    ob_end_flush();
    die();
	
}

if(isset($_POST['logout'])){
	
	ob_start();
    header('Location: Start_Guitar_Database.php');
    ob_end_flush();
    die();
	
}

if(isset($_POST['editInfor'])){
	
	ob_start();
    header('Location: EditUserInfor.php');
    ob_end_flush();
    die();
	
}




?>