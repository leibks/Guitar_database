<html>
<head><title> Start Guitar</title></head>
<center><body background = "background_guitar.jpg"> 
<h2>  Welcome Guitar Ubuntu!</h2>
<form action ="Start_Guitar_Database.php" method="post" >
<table border = "1" width="300" height="150">
	
<tr>	<td width="50" colspan ="50" align = "center" >
       <input style="font-size:20px;" type = "submit" name = "signUp" value="Sign Up"> 
	   </td> 
	
<tr>	<td width="50" colspan ="50" align = "center" >
       <input style="font-size:20px;" type = "submit" name = "login" value="Log In"> 
	   </td> 
</tr>
</table>
</form>
</body></center>
</html>  

<?php


if(isset($_POST['login'])){
	
	ob_start();
    header('Location: LogIn.php');
    ob_end_flush();
    die();
	
}

if(isset($_POST['signUp'])){
	
	ob_start();
    header('Location: SignUp.php');
    ob_end_flush();
    die();
	
}

?>