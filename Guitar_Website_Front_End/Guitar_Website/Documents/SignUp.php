
<html>
<head><title> Sign Up </title></head>
<left><body background = "background_guitar.jpg"> 
<h2>  Sign Up!</h2>
<form action ="SignUp.php" method="post" >
<tr>	<p colspan 20 align = "center"> Choose One of Four User Type to Sign Up </p>  </tr>

<table border = "1" width="200" height="30" align = "center", align = "top">

<tr><td colspan ="30" align = "center" >
       <input  style="font-size:20px;" type = "submit" name = "normal" value="Normal User"> 
	   </td> 
	   
	   <td colspan ="30" align = "center" >
       <input  style="font-size:20px;" type = "submit" name = "companyRepre" value="Company Representative User">
	   </td> 
	   
	   <td colspan ="30" align = "center" >
       <input  style="font-size:20px;" type = "submit" name = "retailRepre" value="Retail Representative User">
	   </td> 
	   
	   <td colspan ="30" align = "center" >
       <input  style="font-size:20px;" type = "submit" name = "museumRepre" value="Museum Representative User">
	   </td> 	   
</tr>
</table>

<td colspan ="30" >
       <input  style="font-size:20px;" type = "submit" name = "BackToStart" value="Back to Start Page">
	   </td>
	   
</form>
</body></left>
</html>  



<?php

require_once('../Connect_Database.php');

if(isset($_POST['normal'])){
	
	ob_start();
    header('Location: SignUp_Normal.php');
    ob_end_flush();
    die();
	
}

if(isset($_POST['companyRepre'])){
	
	ob_start();
    header('Location: SignUp_Company_Representative.php');
    ob_end_flush();
    die();
	
}


if(isset($_POST['retailRepre'])){
	
	ob_start();
    header('Location: SignUp_Store_Representative.php');
    ob_end_flush();
    die();
	
}

if(isset($_POST['museumRepre'])){
	
	ob_start();
    header('Location: SignUp_Museum_Representative.php');
    ob_end_flush();
    die();
	
}

if(isset($_POST['BackToStart'])){
	
	ob_start();
    header('Location: Start_Guitar_Database.php');
    ob_end_flush();
    die();
	
}




?>