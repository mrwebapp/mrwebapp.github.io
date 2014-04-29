<?php
require '../db/connect.php';
	//echo $_POST['zip'];
		$sql =  "SELECT auslaender.aus_erw_per FROM auslaender WHERE auslaender.zip = '".$_POST['zip']."'";
		//$sql = 'SELECT auslaender.aus_erw_per FROM auslaender WHERE auslaender.zip = "8048"';
if ($result=mysqli_query($con,$sql))
  	{
  		// Fetch one and one row
  		while ($row=mysqli_fetch_row($result))
    		{
    		printf ("%s %% Ausländer in der Gemeinde\n",$row[0]);
    		}
  		// Free result set
  		mysqli_free_result($result);
	}
//	echo (mysqli_num_rows($result) !== 0) ? mysqli_result($result, 0, ´aus_erw´) : 'Not found!';
//}
mysqli_close($con);
?>
