<?php

$dbc = @mysqli_connect("localhost", "root", "19630920", "guitarDB");
// echo "Connect database Successfully";

// Check connection
if($dbc === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}


?>