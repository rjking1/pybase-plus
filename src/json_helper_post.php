<?php 

function mysql_die($error = "unknown") 
{ 
	$err = array(
        array( 'error' => $error ),
    );
    echo json_encode( $err );
    exit; 
} 

$db =  $_POST["db"];
$sql = $_POST["sql"];
//$audit_text = $_POST["audit_text"];
//$hdr = !isset($_POST["nohdr"]);
//$enc = !isset($_POST["noenc"]);

header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

$con = mysql_connect( "localhost", "art25285_rjking", "viking$722675" ) or mysql_die( mysql_error() );

mysql_set_charset('utf8');

mysql_select_db( $db, $con ) or mysql_die( mysql_error() );

$sql = rawurldecode( $sql );    // raw.. does not change + to space
error_log('1.' . $sql);
//$audit_text = stripslashes( $audit_text );
//error_log('2.' . $audit_text);

$result = mysql_query( $sql, $con ) or mysql_die( mysql_error() );  

$rows = array();

// if ($hdr) {
// }

if( strtolower( substr( $sql, 0, 7 ) ) != "select " && strtolower( substr( $sql, 0, 5 ) ) != "show ")
{
    $myObj->affected = mysql_affected_rows( $con );
    $rows[] = $myObj;
}
else
{
    while($r = mysql_fetch_assoc($result)) {
        $rows[] = $r;
    }
}

mysql_free_result($result); 

// log audit_text if supplied else SQL if not a select
if( isset( $_POST["audit_text"] ) ) {
    $result = mysql_query( "insert into py_logs (user_id, description) values (0, '" . $_POST["audit_text"] . "')", $con ) or mysql_die( mysql_error() );
    mysql_free_result($result); 
}
else if( strtolower( substr( $sql, 0, 19 ) ) == "insert into py_logs" ) {
	// do nothing as have already recorded special message into audit log
}
else if( strtolower( substr( $sql, 0, 7 ) ) != "select " ) {
    $result = mysql_query( "insert into py_logs (user_id, description) values (0, '" . addslashes($sql) . "')", $con ) or mysql_die( mysql_error() );
    mysql_free_result($result); 
}

echo json_encode( $rows );

mysql_close( $con );

?>