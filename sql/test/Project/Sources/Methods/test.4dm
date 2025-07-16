//%attributes = {"invisible":true}
If (Is macOS:C1572)
	$connection:="Driver=/opt/homebrew/lib/psqlodbcw.so;Server=localhost;Port=5432;Database=mydb;UID=myuser;PWD=mypass;"
	$status:=SQLGetInfo($connection; SOCI_NOT_IN_TRANSACTION; {odbc_option_driver_complete: "0"})
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($status; *))
/*
{
"success": true,
"accessibleProcedures": "N",
"accessibleTables": "N",
"alterTable": 490539,
"catalogName": "Y",
"collationSequence": "",
"maximumDriverConnections": 0,
"maximumConcurrentActivities": 0,
"dataSourceName": "",
"fetchDirection": 191,
"scrollConcurrency": 5,
"serverName": "localhost",
"searchPatternEscape": "\\",
"dbmsName": "PostgreSQL",
"dbmsVer": "14.0.18",
"cursorCommitBehavior": 2,
"dataSourceReadOnly": "N",
"defaultTransactionIsolation": 2,
"identifierCase": 2,
"identifierQuoteChar": "\"",
"maximumColumnNameLength": 63,
"maximumCursorNameLength": 32,
"maximumSchemaNameLength": 63,
"maximumCatalogNameLength": 0,
"maximumTableNameLength": 63,
"transactionCapable": 2,
"userName": "myuser",
"transactionIsolationOption": 15,
"integrity": "N",
"getdataExtensions": 15,
"nullCollation": 0,
"orderByColumnsInSelect": "Y",
"specialCharacters": "_",
"maximumColumnsInGroupBy": 0,
"maximumColumnsInIndex": 0,
"maximumColumnsInOrderBy": 0,
"maximumColumnsinGroupBy": 0,
"maximumColumnsinIndex": 0,
"maximumColumnsinOrderBy": 0,
"maximumColumnsinSelect": 0,
"maximumColumnsinTable": 0,
"maximumIndexSize": 0,
"maximumRowSize": 0,
"maximumStatementLength": 0,
"maximumTablesInSelect": 0,
"maximumUserNameLength": 0,
"outerJoinCapabilites": 127,
"xopenCliYear": "1995",
"describeParameter": "N",
"maximumIdentifierLength": 63
}
*/
End if 

