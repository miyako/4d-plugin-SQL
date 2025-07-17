![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-plugin-SQL)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-plugin-SQL/total)

# 4d-plugin-SQL

alternative to `ODBC_SQLGetInfo` ([`SQLGetInfo`](https://learn.microsoft.com/en-us/sql/odbc/reference/syntax/sqlgetinfo-function?view=sql-server-ver17))

|type|property|note|
|-|-|-|
|SQL_ACTIVE_CONNECTIONS|maximumDriverConnections|
|SQL_ACTIVE_ENVIRONMENTS|n/a|116
|SQL_ACTIVE_STATEMENTS|maximumConcurrentActivities|
|SQL_AGGREGATE_FUNCTIONS|n/a|169
|SQL_ALTER_DOMAIN|n/a|117
|SQL_ASYNC_MODE|n/a|10021
|SQL_BATCH_ROW_COUNT|n/a|120
|SQL_BATCH_SUPPORT|n/a|121
|SQL_BOOKMARK_PERSISTENCE|n/a|82
|SQL_CATALOG_LOCATION|n/a|114
|SQL_CATALOG_NAME_SEPARATOR|n/a|41
|SQL_CATALOG_TERM|n/a|42
|SQL_CATALOG_USAGE|n/a|92
|SQL_COLUMN_ALIAS|n/a|87
|SQL_CONCAT_NULL_BEHAVIOR|n/a|22
|SQL_UNION|n/a|96

```4d
$connection:="Driver=/opt/homebrew/lib/psqlodbcw.so;Server=localhost;Port=5432;Database=mydb;UID=myuser;PWD=mypass;"
$status:=SQLGetInfo($connection; SOCI_NOT_IN_TRANSACTION; {odbc_option_driver_complete: "0"})
SET TEXT TO PASTEBOARD(JSON Stringify($status; *))
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
	"maximumColumnsInSelect": 0,
	"maximumColumnsInTable": 0,
	"maximumIndexSize": 0,
	"maximumRowSize": 0,
	"maximumStatementLength": 0,
	"maximumTablesInSelect": 0,
	"maximumUserNameLength": 0,
	"outerJoinCapabilites": 127,
	"xopenCLIYear": "1995",
	"describeParameter": "N",
	"maximumIdentifierLength": 5177407
	}
*/
```
