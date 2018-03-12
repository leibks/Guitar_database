<html>
<head><title> Log in</title></head>
<center><body background = "background_guitar.jpg"> 
<h2>  Log in Here!</h2>
<form action ="LogIn.php" method="post" >
<table border = "1" width="300" height="150">
<tr>	<td>Name:  </td> 
		<td><input type="text" name = "name"></td>
</tr>	
<tr>	<td>Password: </td>
		<td><input type="password" name="password"></td>
</tr>

<tr>	<td>User Type: </td>
		<td><input type="userType" name="usertype"></td>
		<tr>	<p colspan 20> Type of user: normal, company, store, and museum </p>  </tr>
</tr>
	
<tr>	<td colspan ="5" align = "center" >
       <input  style="font-size:20px;" type = "submit" name = "login" value="login"> 
	   </td> 
</tr>

<tr> 	   <td colspan ="5" align = "center" >
       <input  style="font-size:20px;" type = "submit" name = "signup" value="No Account? Sign Up Firstly"> 
	   </td> 
</tr>
</table>
</form>
</body></center>
</html>  

<?php

require_once('../Connect_Database.php');


// write php code for controlling database
// if the login was pressed, value will 
if(isset($_POST['login']))
{
	$name = $_POST['name'];
	$password = $_POST['password'];
	$query = "SELECT logCheck('$name', '$password');";

	$response = @mysqli_query($dbc, $query);
	if ($response) {
		session_start(); 
		$_SESSION['type'] = $_POST['usertype'];
		echo "Log in successfully.";
		ob_start();
		header('Location: All_Operations.php?
		name='.$name.'&password='.$password);
		exit;
		ob_end_flush();
		die();
	} else {
		echo "ERROR: Wrong user name or password";
	}



}


if(isset($_POST['signup'])){
	
	ob_start();
    header('Location: SignUp.php');
    ob_end_flush();
    die();
	
}

?>