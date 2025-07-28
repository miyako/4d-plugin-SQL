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
|SQL_ALTER_TABLE|alterTable|
|SQL_ASYNC_MODE|n/a|10021
|SQL_BATCH_ROW_COUNT|n/a|120
|SQL_BATCH_SUPPORT|n/a|121
|SQL_BOOKMARK_PERSISTENCE|n/a|82
|SQL_CATALOG_LOCATION|n/a|114
|SQL_CATALOG_NAME|catalogName|
|SQL_CATALOG_NAME_SEPARATOR|n/a|41
|SQL_CATALOG_TERM|n/a|42
|SQL_CATALOG_USAGE|n/a|92
|SQL_COLLATION_SEQ|collationSequence|
|SQL_COLUMN_ALIAS|n/a|87
|SQL_CONCAT_NULL_BEHAVIOR|n/a|22
|SQL_CURSOR_COMMIT_BEHAVIOR|cursorCommitBehavior|
|SQL_CURSOR_SENSITIVITY|cursorSensitivity|
|SQL_DATA_SOURCE_NAME|dataSourceName|
|SQL_DATA_SOURCE_READ_ONLY|dataSourceReadOnly|
|SQL_DBMS_NAME|dbmsName|
|SQL_DBMS_VER|dbmsVersion|
|SQL_DEFAULT_TXN_ISOLATION|defaultTransactionIsolation|
|SQL_DESCRIBE_PARAMETER|describeParameter|
|SQL_FETCH_DIRECTION|fetchDirection|
|SQL_GETDATA_EXTENSIONS|getdataExtensions|
|SQL_IDENTIFIER_CASE|identifierCase|
|SQL_IDENTIFIER_QUOTE_CHAR|identifierQuoteChar|
|SQL_MAX_ASYNC_CONCURRENT_STMTS|n/a|10022
|SQL_MAX_BINARY_LITERAL_LEN|n/a|112
|SQL_MAX_CATALOG_NAME_LEN|maximumCatalogNameLength|
|SQL_MAX_CHAR_LITERAL_LEN|n/a|108
|SQL_MAX_COLUMN_NAME_LEN|maximumColumnNameLength|
|SQL_MAX_COLUMNS_IN_GROUP_BY|maximumColumnsInGroupBy|
|SQL_MAX_COLUMNS_IN_INDEX|maximumColumnsInIndex|
|SQL_MAX_COLUMNS_IN_ORDER_BY|maximumColumnsInOrderBy|
|SQL_MAX_COLUMNS_IN_SELECT|maximumColumnsInSelect|
|SQL_MAX_COLUMNS_IN_TABLE|maximumColumnsInTable|
|SQL_MAX_CURSOR_NAME_LEN|maximumCursorNameLength|
|SQL_MAX_IDENTIFIER_LEN|maximumIdentifierLength|
|SQL_MAX_INDEX_SIZE|maximumIndexSize|
|SQL_MAX_OWNER_NAME_LEN|maximumSchemaNameLength|
|SQL_MAX_PROCEDURE_NAME_LEN|n/a|33
|SQL_MAX_QUALIFIER_NAME_LEN|maximumCatalogNameLength|
|SQL_MAX_ROW_SIZE|maximumRowSize|
|SQL_MAX_ROW_SIZE_INCLUDES_LONG|n/a|103
|SQL_MAX_SCHEMA_NAME_LEN|maximumSchemaNameLength|
|SQL_MAX_STATEMENT_LEN|maximumStatementLength|
|SQL_MAX_TABLE_NAME_LEN|maximumTableNameLength|
|SQL_MAX_TABLES_IN_SELECT|maximumTablesInSelect|
|SQL_NULL_COLLATION|nullCollation|
|SQL_TXN_CAPABLE|transactionCapable|
|SQL_TXN_ISOLATION_OPTION|transactionIsolationOption|
|SQL_MAX_USER_NAME_LEN|maximumUserNameLength|
|SQL_ODBC_API_CONFORMANCE|n/a|9
|SQL_ODBC_INTERFACE_CONFORMANCE|n/a|152
|SQL_ODBC_SAG_CLI_CONFORMANCE|n/a|12
|SQL_ODBC_SQL_CONFORMANCE|n/a|15
|SQL_ODBC_SQL_OPT_IEF|integrity|
|SQL_ODBC_VER|n/a|10
|SQL_OJ_CAPABILITIES|outerJoinCapabilites|
|SQL_ORDER_BY_COLUMNS_IN_SELECT|orderByColumnsInSelect|
|SQL_OUTER_JOINS|n/a|38
|SQL_OWNER_TERM|n/a|39
|SQL_OWNER_USAGE|n/a|91
|SQL_SCROLL_CONCURRENCY|scrollConcurrency|
|SQL_SEARCH_PATTERN_ESCAPE|searchPatternEscape|
|SQL_SERVER_NAME|serverName|
|SQL_SPECIAL_CHARACTERS|specialCharacters|
|SQL_UNION|n/a|96
|SQL_USER_NAME|userName|
|SQL_XOPEN_CLI_YEAR|xopenCLIYear|

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
