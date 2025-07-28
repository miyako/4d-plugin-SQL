![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-plugin-SQL)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-plugin-SQL/total)

# 4d-plugin-SQL

alternative to `ODBC_SQLGetInfo` ([`SQLGetInfo`](https://learn.microsoft.com/en-us/sql/odbc/reference/syntax/sqlgetinfo-function?view=sql-server-ver17))

|type|property|note|
|-|-|-|
|SQL_ACTIVE_CONNECTIONS|maximumDriverConnections|0
|SQL_ACTIVE_STATEMENTS|maximumConcurrentActivities|1
|SQL_DATA_SOURCE_NAME|dataSourceName|2
|SQL_DRIVER_NAME|driverName|6
|SQL_DRIVER_VER|driverVersion|7
|SQL_FETCH_DIRECTION|fetchDirection|8
|SQL_ODBC_VER|ODBCVersion|10
|SQL_SERVER_NAME|serverName|13
|SQL_SEARCH_PATTERN_ESCAPE|searchPatternEscape|14
|SQL_DATABASE_NAME|databaseName|16
|SQL_DBMS_NAME|databaseManagementSystemName|17
|SQL_DBMS_VER|databaseManagementSystemVersion|18
|SQL_DM_VER|driverManagerVersion|19
|SQL_ACCESSIBLE_PROCEDURES|accessibleProcedures|20
|SQL_CURSOR_COMMIT_BEHAVIOR|cursorCommitBehavior|23
|SQL_DATA_SOURCE_READ_ONLY|dataSourceReadOnly|25
|SQL_TXN_ISOLATION_OPTION|transactionIsolationOption|26
|SQL_IDENTIFIER_CASE|identifierCase|28
|SQL_IDENTIFIER_QUOTE_CHAR|identifierQuoteChar|29
|SQL_MAX_COLUMN_NAME_LEN|maximumColumnNameLength|30
|SQL_MAX_CURSOR_NAME_LEN|maximumCursorNameLength|31
|SQL_MAX_SCHEMA_NAME_LEN|maximumSchemaNameLength|32
|SQL_MAX_CATALOG_NAME_LEN|maximumCatalogNameLength|34
|SQL_MAX_TABLE_NAME_LEN|maximumTableNameLength|35
|SQL_SCROLL_CONCURRENCY|scrollConcurrency|43
|SQL_TXN_CAPABLE|transactionCapable|46
|SQL_USER_NAME|userName|47
|SQL_TXN_ISOLATION_OPTION|transactionIsolationOption|72
|SQL_ODBC_SQL_OPT_IEF|integrity|73
|SQL_GETDATA_EXTENSIONS|getdataExtensions|81
|SQL_NULL_COLLATION|nullCollation|85
|SQL_ALTER_TABLE|alterTable|86
|SQL_ORDER_BY_COLUMNS_IN_SELECT|orderByColumnsInSelect|90
|SQL_SPECIAL_CHARACTERS|specialCharacters|94
|SQL_MAX_COLUMNS_IN_GROUP_BY|maximumColumnsInGroupBy|97
|SQL_MAX_COLUMNS_IN_INDEX|maximumColumnsInIndex|98
|SQL_MAX_COLUMNS_IN_ORDER_BY|maximumColumnsInOrderBy|99
|SQL_MAX_COLUMNS_IN_SELECT|maximumColumnsInSelect|100
|SQL_MAX_COLUMNS_IN_TABLE|maximumColumnsInTable|101
|SQL_MAX_INDEX_SIZE|maximumIndexSize|102
|SQL_MAX_ROW_SIZE|maximumRowSize|104
|SQL_MAX_STATEMENT_LEN|maximumStatementLength|105
|SQL_MAX_TABLES_IN_SELECT|maximumTablesInSelect|106
|SQL_MAX_USER_NAME_LEN|maximumUserNameLength|107
|SQL_OJ_CAPABILITIES|outerJoinCapabilites|115
|SQL_XOPEN_CLI_YEAR|xopenCLIYear|10000
|SQL_CURSOR_SENSITIVITY|cursorSensitivity|10001
|SQL_DESCRIBE_PARAMETER|describeParameter|10002
|SQL_CATALOG_NAME|catalogName|10003
|SQL_COLLATION_SEQ|collationSequence|10004
|SQL_MAX_IDENTIFIER_LEN|maximumIdentifierLength|10005


```4d
$connection:="Driver=/opt/homebrew/lib/psqlodbcw.so;Server=localhost;Port=5432;Database=mydb;UID=myuser;PWD=mypass;"
$status:=SQLGetInfo($connection; SOCI_NOT_IN_TRANSACTION; {odbc_option_driver_complete: "0"})
SET TEXT TO PASTEBOARD(JSON Stringify($status; *))
/*
	{
	"success": true,
	"databaseName": "mydb",
	"driverName": "psqlodbcw.so",
	"driverVersion": "17.00.0006",
	"ODBCVersion": "03.52",
	"driverManagerVersion": "N",
	"databaseManagementSystemVersion": "14.0.18",
	"databaseManagementSystemName": "PostgreSQL",
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
	"dbmsVersion": "14.0.18",
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
	"maximumIdentifierLength": 63
	}
*/
```
