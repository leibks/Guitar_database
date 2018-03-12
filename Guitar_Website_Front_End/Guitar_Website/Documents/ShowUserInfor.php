
<html>
<head><title> Show User Information</title></head>

<left><body background = "background_guitar.jpg"> 
<h2> Show User Information </h2>
<form action ="ShowUserInfor.php" method="post" >

	   	 <tr colspan ="30" align = "center" >
       <input  style="font-size:20px;" type = "submit" name = "others" value="Choose Another Operations"> 
	   </tr> 

</form>
</body></left>


</html>  



<?php

if(isset($_POST['others'])){
	
	ob_start();
    header('Location: All_Operations.php');
    ob_end_flush();
    die();
	
}

	session_start();
	$name = $_SESSION['name'];
	$pass = $_SESSION['password'];
	$check = $_SESSION['type'];
	require_once('../Connect_Database.php');
	
	$query = "Call showOwnUserInfor('$name', '$pass');";
	$response = @mysqli_query($dbc, $query);
	
	
	if ($response) {
		
		echo '<table align="left"
	cellspacing="5" cellpadding="8">
	
	<tr><td align="left"><b> User id</b></td>
	    <td align="left"><b> User Name</b></td>
		<td align="left"><b> User Password</b></td>
		<td align="left"><b> User Type </b></td>
		<td align="left"><b> Signup Date </b></td>
		<td align="left"><b> User Phone</b></td>
		<td align="left"><b> User address country</b></td>
		<td align="left"><b> User address state</b></td>
		<td align="left"><b> User address street</b></td>
		<td align="left"><b> User address zip code</b></td>';
		if ($check === 'normal') {
		echo '<td align="left"><b> User Level</b></td> </tr>';
		} elseif ($check === 'company') { 
		echo '<td align="left"><b> company ID </b></td>
		<td align="left"><b> certificate date </b></td> </tr>';
		} elseif ($check === 'store') {
		echo '<td align="left"><b> store ID </b></td>
		<td align="left"><b> Certificate Date </b></td> </tr>';
		} else {
		echo '<td align="left"><b> Museum ID e</b></td>
		<td align="left"><b> Certificate Date </b></td> </tr>';
		}
	

	while ($row = mysqli_fetch_array($response)) {
	echo '<tr><td align= "left">' .
	$row['user_id'] . '</td><td align="left">' .
	$row['user_name'] . '</td><td align="left">' .
	$row['user_password'] . '</td><td align="left">' .
	$row['user_type'] . '</td><td align="left">' .
	$row['signup_date'] . '</td><td align="left">' .
	$row['user_phone'] . '</td><td align="left">' .
	$row['user_address_country'] . '</td><td align="left">' .
	$row['user_address_state'] . '</td><td align="left">' .
	$row['user_address_street'] . '</td><td align="left">' .
	$row['user_address_zipcode'] . '</td><td align="left">';
	
	if ($check == 'normal') {
	echo $row['user_level'] . '</td><td align="left">';
	} elseif ($check === 'company') { 
	echo $row['company_id'] . '</td><td align="left">' .
	 $row['certificate_date'] . '</td><td align="left">';
	} elseif ($check === 'store') { 
	echo $row['store_id'] . '</td><td align="left">' .
	 $row['certificate_date'] . '</td><td align="left">';
	} elseif ($check === 'museum') { 
	echo $row['museum_id'] . '</td><td align="left">' .
	 $row['certificate_date'] . '</td><td align="left">';
	} else {
		echo 'Error';
	}
	echo '</tr>';
	}
	echo '</table>';
	

} else {
	echo mysqli_error($dbc);
} 

// mysqli_close($dbc);


?>