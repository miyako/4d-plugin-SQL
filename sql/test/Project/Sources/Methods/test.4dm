//%attributes = {"invisible":true}
$connection:="dsn=test;uid=user;pwd=pass;trusted_connection=no;"
$status:=SQLGetInfo($connection; SOCI_NOT_IN_TRANSACTION; {odbc_option_driver_complete: "0"})
