
<html>
<head><title> Search Guitars </title></head>
<left><body background = "background_guitar.jpg"> 
<h2>  Search Guitars!</h2>
<form action ="SearchCompany.php" method="post" >
<table border = "1" width="200" height="150">
<tr>	<td colspan ="30" align = "center" >
       <input type = "submit" name = "showAllGuitars" value="Look All Guitars"> 
	   </td> 
</tr>

<tr>	<td colspan ="30" align = "center" >
       <input type = "submit" name = "searchBrand" value="Search by Brand"> 
	   </td> <td><input type="text" name = "brand"></td>
</tr>
	
<tr>	<td colspan ="30" align = "center" >
       <input type = "submit" name = "searchType" value="Search by Type"> 
	   </td> <td><input type="text" name = "type"></td>
	   <tr>	<p colspan 20> Type of Guitars: 'Acoustic', 'Classic', 'Electric', 'Bass', 'Other' </p>  </tr>
</tr>

<tr>	<td colspan ="30" align = "center" >
       <input type = "submit" name = "backup" value="Back to All Operations"> 
</tr>

</table>
</form>
</body></left>
</html>  



<?php

require_once('../Connect_Database.php');


if(isset($_POST['backup'])){
	
	ob_start();
    header('Location: All_Operations.php');
    ob_end_flush();
    die();
	
}


if(isset($_POST['showAllGuitars'])) {
	
	$query = "Call showAllGuitars();";
	$response = @mysqli_query($dbc, $query);
	
	if ($response) {
	
	echo '<table align="left"
	cellspacing="5" cellpadding="8">
	
	<tr><td align="left"><b> Guitar id</b></td>
	    <td align="left"><b> Guitar Name</b></td>
		<td align="left"><b> Guitar Type</b></td>
		<td align="left"><b> Guitar model</b></td>
		<td align="left"><b> Guitar brand</b></td>
		<td align="left"><b> Guitar description</b></td>
		<td align="left"><b> Guitar scale length</b></td>
		<td align="left"><b> Guitar scale width</b></td>
		<td align="left"><b> Guitar composite finish</b></td>
		<td align="left"><b> Guitar composite top</b></td>
		<td align="left"><b> Guitar composite body</b></td>
		<td align="left"><b> Guitar score</b></td>
		<td align="left"><b> Guitar price</b></td> </tr>';
	

	while ($row = mysqli_fetch_array($response)) { 
	echo '<tr><td align= "left">' .
	$row['guitar_id'] . '</td><td align="left">' .
	$row['guitar_name'] . '</td><td align="left">' .
	$row['guitar_type'] . '</td><td align="left">' .
	$row['guitar_model'] . '</td><td align="left">' .
	$row['guitar_brand'] . '</td><td align="left">' .
	$row['guitar_shortDescription'] . '</td><td align="left">' .
	$row['guitar_scale_length'] . '</td><td align="left">' .
	$row['guitar_scale_width'] . '</td><td align="left">' .
	$row['guitar_composite_finish'] . '</td><td align="left">' .
	$row['guitar_composite_top'] . '</td><td align="left">' .
	$row['guitar_composite_body'] . '</td><td align="left">' .
	$row['average_score'] . '</td><td align="left">' .
	$row['lowest_price'] . '</td><td align="left">';
	
	echo '</tr>';
	}


	
	echo '</table>';
} else {
	echo "Could not issue database query";
	
	echo mysqli_error($dbc);
}

mysqli_close($dbc);
}

if(isset($_POST['searchBrand'])) {
	
	$brand = $_POST['brand'];
	
	$query = "Call searchByBrand('$brand');";
	$response = @mysqli_query($dbc, $query);
	
	if ($response) {
	
	echo '<table align="left"
	cellspacing="5" cellpadding="8">
	
	<tr><td align="left"><b> Guitar id</b></td>
	    <td align="left"><b> Guitar Name</b></td>
		<td align="left"><b> Guitar Type</b></td>
		<td align="left"><b> Guitar model</b></td>
		<td align="left"><b> Guitar brand</b></td>
		<td align="left"><b> Guitar description</b></td>
		<td align="left"><b> Guitar scale length</b></td>
		<td align="left"><b> Guitar scale width</b></td>
		<td align="left"><b> Guitar composite finish</b></td>
		<td align="left"><b> Guitar composite top</b></td>
		<td align="left"><b> Guitar composite body</b></td>
		<td align="left"><b> Guitar score</b></td>
		<td align="left"><b> Guitar price</b></td> </tr>';
	

	while ($row = mysqli_fetch_array($response)) { 
	echo '<tr><td align= "left">' .
	$row['guitar_id'] . '</td><td align="left">' .
	$row['guitar_name'] . '</td><td align="left">' .
	$row['guitar_type'] . '</td><td align="left">' .
	$row['guitar_model'] . '</td><td align="left">' .
	$row['guitar_brand'] . '</td><td align="left">' .
	$row['guitar_shortDescription'] . '</td><td align="left">' .
	$row['guitar_scale_length'] . '</td><td align="left">' .
	$row['guitar_scale_width'] . '</td><td align="left">' .
	$row['guitar_composite_finish'] . '</td><td align="left">' .
	$row['guitar_composite_top'] . '</td><td align="left">' .
	$row['guitar_composite_body'] . '</td><td align="left">' .
	$row['average_score'] . '</td><td align="left">' .
	$row['lowest_price'] . '</td><td align="left">';
	
	echo '</tr>';
	}


	
	echo '</table>';
} else {
	echo "Could not issue database query by using this type";
	
	echo mysqli_error($dbc);
}

mysqli_close($dbc);
} 


if(isset($_POST['searchType'])) {
	
	$type = $_POST['type'];
	
	$query = "Call searchGuitarType('$type');";
	$response = @mysqli_query($dbc, $query);
	
	if ($response) {
	
	echo '<table align="left"
	cellspacing="5" cellpadding="8">
	
	<tr><td align="left"><b> Guitar id</b></td>
	    <td align="left"><b> Guitar Name</b></td>
		<td align="left"><b> Guitar Type</b></td>
		<td align="left"><b> Guitar model</b></td>
		<td align="left"><b> Guitar brand</b></td>
		<td align="left"><b> Guitar description</b></td>
		<td align="left"><b> Guitar scale length</b></td>
		<td align="left"><b> Guitar scale width</b></td>
		<td align="left"><b> Guitar composite finish</b></td>
		<td align="left"><b> Guitar composite top</b></td>
		<td align="left"><b> Guitar composite body</b></td>
		<td align="left"><b> Guitar score</b></td>
		<td align="left"><b> Guitar price</b></td> </tr>';
	

	while ($row = mysqli_fetch_array($response)) { 
	echo '<tr><td align= "left">' .
	$row['guitar_id'] . '</td><td align="left">' .
	$row['guitar_name'] . '</td><td align="left">' .
	$row['guitar_type'] . '</td><td align="left">' .
	$row['guitar_model'] . '</td><td align="left">' .
	$row['guitar_brand'] . '</td><td align="left">' .
	$row['guitar_shortDescription'] . '</td><td align="left">' .
	$row['guitar_scale_length'] . '</td><td align="left">' .
	$row['guitar_scale_width'] . '</td><td align="left">' .
	$row['guitar_composite_finish'] . '</td><td align="left">' .
	$row['guitar_composite_top'] . '</td><td align="left">' .
	$row['guitar_composite_body'] . '</td><td align="left">' .
	$row['average_score'] . '</td><td align="left">' .
	$row['lowest_price'] . '</td><td align="left">';
	
	echo '</tr>';
	}


	
	echo '</table>';
} else {
	echo "Could not issue database query";
	
	echo mysqli_error($dbc);
}

mysqli_close($dbc);
} 





?>