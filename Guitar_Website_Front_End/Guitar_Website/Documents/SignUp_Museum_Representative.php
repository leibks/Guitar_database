
<html>
<head><title> Sign Up Museum User</title></head>
<left><body background = "background_guitar.jpg"> 
<h2>  Sign Up Museum User!</h2>
<form action ="SignUp_Museum_Representative.php" method="post" >

	<b>Sign Up One Museum User</b>
	
	<p>User Name:
	<input type = "text" name="user_name" size = "30" value="">
	</p>
	
	<p>Password:
	<input type = "text" name="pass" size = "30" value="">
	</p>
	
	<p>User Phone:
	<input type = "text" name="phone" size = "30" value="">
	</p>
	
	<p>User Adress Country:
	<input type = "text" name="country" size = "30" value="">
	</p>
	
	<p>User Adress State:
	<input type = "text" name="state" size = "30" value="">
	</p>
	
	<p>User Adress Street:
	<input type = "text" name="street" size = "30" value="">
	</p>
	
	<p>User Adress Zip Code:
	<input type = "text" name="zip" size = "30" max = "5" value="">
	</p>
	
	<p>Museum Name:
	<input type = "text" name="museumName" size = "30" value="">
	</p>
	
	<p>Security Code:
	<input type = "text" name="code" size = "30"  value="">
	</p>

<table border = "1" width="50" height="30" align = "center", align = "top">

<tr><td colspan ="30" align = "center" >
       <input  style="font-size:20px;" type = "submit" name = "submit" value="Submit"> 
	   </td> 
	   
	   	 <td colspan ="30" align = "center" >
       <input  style="font-size:20px;" type = "submit" name = "chooseType" value="Choose Another User Type"> 
	   </td> 

</tr>


</table>

</form>
</body></left>
</html>  



<?php


if(isset($_POST['chooseType'])){
	
	ob_start();
    header('Location: SignUp.php');
    ob_end_flush();
    die();
	
}

if(isset($_POST['submit'])) {
	
	$data_missing = array();
	
	if (empty($_POST['user_name'])) {
		$data_missing[] = 'User Name';
	} else {
		$u_name = trim($_POST['user_name']);
		
	}
	
	if (empty($_POST['pass'])) {
		$data_missing[] = 'Password';
	} else {
		$u_pass = trim($_POST['pass']);
		
	}
	
	
	if (empty($_POST['phone'])) {
		$data_missing[] = 'Phone';
	} else {
		$u_phone = trim($_POST['phone']);
		
	}
	
	if (empty($_POST['country'])) {
		$data_missing[] = 'Country';
	} else {
		$u_country = trim($_POST['country']);
		
	}
	
	if (empty($_POST['state'])) {
		$data_missing[] = 'State';
	} else {
		$u_state = trim($_POST['state']);
		
	}
	
	if (empty($_POST['street'])) {
		$data_missing[] = 'Street';
	} else {
		$u_street = trim($_POST['street']);
		
	}
	
		
	if (empty($_POST['zip'])) {
		$data_missing[] = 'Zip Code';
	} else {
		$u_zipcode = trim($_POST['zip']);
	}
	
	if (empty($_POST['museumName'])) {
		$data_missing[] = 'Museum Name';
	} else {
		$u_museum = trim($_POST['museumName']);
	}
	
	if (empty($_POST['code'])) {
		$data_missing[] = 'Security Code';
	} else {
		$u_code = trim($_POST['code']);
	}
	
	if(empty($data_missing)) {
	require_once('../Connect_Database.php');
	$query = "Call signUpMuseumR(?, ?, ?, ?, ?, ?, ?, ?, ?);";
	
	$stmt = mysqli_prepare($dbc, $query);
	
	mysqli_stmt_bind_param($stmt, "ssisssiss", $u_name, $u_pass, 
	$u_phone, $u_country, $u_state, $u_street, $u_zipcode,
	$u_museum, $u_code);
	
	mysqli_stmt_execute($stmt);
	
	$affected_rows = mysqli_stmt_affected_rows($stmt);
	
	if($affected_rows == 1) {
		echo 'Sign Up Successfully';
		
		mysqli_stmt_close($stmt);
		
		mysqli_close($dbc);
			
	} else {
		echo "Please enter the Correct data";
	}
	
	}
}



?>