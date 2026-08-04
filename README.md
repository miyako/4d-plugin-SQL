![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-plugin-SQL)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-plugin-SQL/total)

# 4d-plugin-SQL

This plugin queries an ODBC data source for driver and database-capability metadata and returns it as a single 4D `Object`, using [SOCI](http://soci.sourceforge.net/) as the connection layer and the ODBC `SQLGetInfo` API under the hood.

| Command | Returns | Purpose |
|---|---|---|
| [`SQLGetInfo`](#sqlgetinfo) | Object | Open an ODBC connection and collect driver/DBMS capability and identification info into one object |

**Platforms:** macOS and Windows.

---

## Requirements & platform notes

- **This command always connects through the ODBC backend**, regardless of the target database engine. The plugin binary also links SOCI's SQLite3, PostgreSQL, and MySQL backend libraries, but `SQLGetInfo` itself never opens a native (non-ODBC) connection — you always pass an ODBC connection string, even when talking to Postgres or MySQL (see the sample below, which reaches PostgreSQL through the `psqlodbcw` ODBC driver).
- **An ODBC driver manager and the specific database driver must already be installed and resolvable at runtime.** The driver reference in the connection string is platform-specific — a shared library path/name on macOS (e.g. `psqlodbcw.so`), typically a DSN name or driver DLL on Windows. Confirm your driver manager's expected driver reference format on each platform.
- **Not every property in the result is guaranteed to appear.** Each one corresponds to a distinct ODBC `SQLGetInfo` info-type query, and it's only added to the result object if that specific driver answers that specific query successfully. Sparse or older drivers can omit large portions of the response — a missing key is normal, not a bug.
- **`success` and, on failure, `errorMessage` are the only two keys always present.** Every other key is conditional (see above).
- **The command is thread-safe** (per the plugin manifest) and can be called concurrently — each call opens its own independent connection.
- **Exception handling:** as reviewed and fixed in this pass, any error during the connection/query sequence — whether a recognized SOCI/ODBC error or something else entirely — now resolves to `success : false` with an `errorMessage`, rather than leaving the call unresolved. (The plugin's manifest declares a return value for this command, so before this fix, an unrecognized exception type could in theory have left the calling 4D method waiting indefinitely instead of getting an error object back. If you're running a binary built before this fix, that residual case still applies.)

---

## SQLGetInfo

### Syntax

```4d
SQLGetInfo ( connection ; mode ; options ) → Object
```

| Parameter | Type | Description |
|---|---|---|
| `connection` | Text | ODBC connection string (driver, server, port, database, credentials, etc.), e.g. as built for `SQLDriverConnect`. Mandatory — read unconditionally, with no fallback if omitted. |
| `mode` | Longint | Transaction mode for the call. `0` = no explicit transaction; `1` = wrap the info-gathering sequence in a transaction, committed once all info has been collected. Mandatory — read unconditionally. The plugin's own test method uses a constant, `SOCI_NOT_IN_TRANSACTION`, for the "no transaction" case; check your plugin's constants list/Language Reference for the full set of named constants, since only this one is visible in the sample provided. |
| `options` | Object | Optional. Only one key is currently read: `odbc_option_driver_complete` (Text). If present, its value is forwarded to SOCI's `odbc_option_driver_complete` connection option (in turn passed to `SQLDriverConnect`'s driver-completion behavior). This corresponds to the standard ODBC driver-completion flags (`"0"` = no prompt, `"1"` = complete, `"2"` = prompt, `"3"` = complete required) — verify the exact prompting behavior against your driver, since some drivers/platforms ignore prompting flags entirely in headless contexts. |
| Result | Object | See properties below. |

### Description

`SQLGetInfo` opens a connection using `connection`, optionally applies the `odbc_option_driver_complete` option from `options`, opens the session, and — if `mode` requests a transaction — starts one. It then issues a fixed sequence of ODBC `SQLGetInfo` calls against the open connection, one per property below, adding each to the result object only when that specific call succeeds. If a transaction was requested, it's committed once all properties have been collected. `success` is set to `true` only if the entire sequence completes without error.

If anything in that sequence throws — a failed connection, a bad driver reference, a query error — the result object instead gets `success : false` plus an `errorMessage` (drawn from the underlying exception's message where the exception is a recognized SOCI/ODBC error, or a generic message otherwise).

**Result object properties**, in the order the plugin queries them, with the ODBC info-type each is drawn from as used in the plugin's own source:

| Property | ODBC info-type (as used in source) | Type | Description |
|---|---|---|---|
| `databaseName` | `16` | Text | Current database name |
| `driverName` | `6` | Text | ODBC driver's file name |
| `driverVersion` | `7` | Text | ODBC driver version string |
| `ODBCVersion` | `10` | Text | ODBC version the driver conforms to |
| `driverManagerVersion` | `19` | Text | Driver manager version |
| `databaseManagementSystemVersion` | `18` | Text | DBMS version string |
| `databaseManagementSystemName` | `17` | Text | DBMS product name |
| `accessibleProcedures` | `SQL_ACCESSIBLE_PROCEDURES` | Text | `"Y"`/`"N"` — can the current user execute all listed procedures |
| `accessibleTables` | `SQL_ACCESSIBLE_TABLES` | Text | `"Y"`/`"N"` — can the current user select from all listed tables |
| `catalogName` | `SQL_CATALOG_NAME` | Text | `"Y"`/`"N"` — does the data source support catalog names |
| `collationSequence` | `SQL_COLLATION_SEQ` | Text | Default collation sequence name |
| `dataSourceName` | `SQL_DATA_SOURCE_NAME` | Text | DSN used for the connection |
| `serverName` | `SQL_SERVER_NAME` | Text | Server name |
| `searchPatternEscape` | `SQL_SEARCH_PATTERN_ESCAPE` | Text | Escape character used in `LIKE` pattern searches |
| `dataSourceReadOnly` | `SQL_DATA_SOURCE_READ_ONLY` | Text | `"Y"`/`"N"` — is the data source read-only |
| `identifierQuoteChar` | `SQL_IDENTIFIER_QUOTE_CHAR` | Text | Character used to quote identifiers |
| `userName` | `SQL_USER_NAME` | Text | Current authenticated user name |
| `integrity` | `SQL_INTEGRITY` | Text | `"Y"`/`"N"` — does the data source support the Integrity Enhancement Facility |
| `orderByColumnsInSelect` | `SQL_ORDER_BY_COLUMNS_IN_SELECT` | Text | `"Y"`/`"N"` — must `ORDER BY` columns appear in the select list |
| `specialCharacters` | `SQL_SPECIAL_CHARACTERS` | Text | Characters valid in identifiers beyond letters/digits/underscore |
| `xopenCLIYear` | `SQL_XOPEN_CLI_YEAR` | Text | X/Open CLI version year, if applicable |
| `describeParameter` | `SQL_DESCRIBE_PARAMETER` | Text | `"Y"`/`"N"` — does the driver support describing parameters |
| `maximumDriverConnections` | `SQL_MAX_DRIVER_CONNECTIONS` | Longint | Max simultaneous connections the driver supports (`0` = no limit/unknown) |
| `maximumConcurrentActivities` | `SQL_MAX_CONCURRENT_ACTIVITIES` | Longint | Max active statements per connection |
| `cursorCommitBehavior` | `SQL_CURSOR_COMMIT_BEHAVIOR` | Longint | How cursors behave across a commit |
| `identifierCase` | `SQL_IDENTIFIER_CASE` | Longint | Case-sensitivity behavior of unquoted identifiers |
| `maximumColumnNameLength` | `SQL_MAX_COLUMN_NAME_LEN` | Longint | Max column name length |
| `maximumCursorNameLength` | `SQL_MAX_CURSOR_NAME_LEN` | Longint | Max cursor name length |
| `maximumSchemaNameLength` | `SQL_MAX_SCHEMA_NAME_LEN` | Longint | Max schema name length |
| `nullCollation` | `SQL_NULL_COLLATION` | Longint | Where NULLs sort relative to non-NULL values |
| `maximumColumnsInGroupBy` | `SQL_MAX_COLUMNS_IN_GROUP_BY` | Longint | Max columns in `GROUP BY` |
| `maximumColumnsInIndex` | `SQL_MAX_COLUMNS_IN_INDEX` | Longint | Max columns in an index |
| `maximumColumnsInOrderBy` | `SQL_MAX_COLUMNS_IN_ORDER_BY` | Longint | Max columns in `ORDER BY` |
| `maximumColumnsInSelect` | `SQL_MAX_COLUMNS_IN_SELECT` | Longint | Max columns in a select list |
| `maximumColumnsInTable` | `SQL_MAX_COLUMNS_IN_TABLE` | Longint | Max columns per table |
| `maximumTablesInSelect` | `SQL_MAX_TABLES_IN_SELECT` | Longint | Max tables in a single `SELECT` |
| `maximumUserNameLength` | `SQL_MAX_USER_NAME_LEN` | Longint | Max user name length |
| `maximumCatalogNameLength` | `SQL_MAX_CATALOG_NAME_LEN` | Longint | Max catalog name length |
| `maximumTableNameLength` | `SQL_MAX_TABLE_NAME_LEN` | Longint | Max table name length |
| `transactionCapable` | `SQL_TXN_CAPABLE` | Longint | Level of transaction support |
| `fetchDirection` | `SQL_FETCH_DIRECTION` | Longint | Supported cursor fetch directions (bitmask) |
| `scrollConcurrency` | `SQL_SCROLL_CONCURRENCY` | Longint | Supported scrollable-cursor concurrency options (bitmask) |
| `alterTable` | `SQL_ALTER_TABLE` | Longint | Supported `ALTER TABLE` clauses (bitmask) |
| `defaultTransactionIsolation` | `SQL_DEFAULT_TXN_ISOLATION` | Longint | Default transaction isolation level |
| `transactionIsolationOption` | `SQL_TXN_ISOLATION_OPTION` | Longint | Supported transaction isolation levels (bitmask) |
| `getdataExtensions` | `SQL_GETDATA_EXTENSIONS` | Longint | Supported `SQLGetData` extensions (bitmask) |
| `maximumIndexSize` | `SQL_MAX_INDEX_SIZE` | Longint | Max index size in bytes (`0` = no limit/unknown) |
| `maximumRowSize` | `SQL_MAX_ROW_SIZE` | Longint | Max row size in bytes (`0` = no limit/unknown) |
| `maximumStatementLength` | `SQL_MAX_STATEMENT_LEN` | Longint | Max SQL statement length |
| `outerJoinCapabilites` | `SQL_OJ_CAPABILITIES` | Longint | Supported outer-join forms (bitmask) |
| `cursorSensitivity` | `SQL_CURSOR_SENSITIVITY` | Longint | Whether cursors reflect changes made through them |
| `maximumIdentifierLength` | `SQL_MAX_IDENTIFIER_LEN` | Longint | Max identifier length |
| `success` | — | Boolean | `true` if the whole sequence completed without error |
| `errorMessage` | — | Text | Present only when `success` is `false` |

Numeric bitmask/enumeration values (`fetchDirection`, `scrollConcurrency`, `alterTable`, etc.) are returned as the raw integers reported by the driver — decode them against the ODBC specification's bit definitions for the corresponding info type if you need to test individual capability bits.

### Example

From the plugin's own test method (`test.4dm`):

```4d
//%attributes = {"invisible":true}
$connection:="Driver=/opt/homebrew/lib/psqlodbcw.so;Server=localhost;Port=5432;Database=mydb;UID=myuser;PWD=mypass;"
$status:=SQLGetInfo($connection; SOCI_NOT_IN_TRANSACTION; {odbc_option_driver_complete: "0"})
SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($status; *))
```

Checking the result before using it, and reading a couple of specific properties:

```4d
$connection:="Driver=/opt/homebrew/lib/psqlodbcw.so;Server=localhost;Port=5432;Database=mydb;UID=myuser;PWD=mypass;"
$status:=SQLGetInfo($connection; 0; New object)

If ($status.success)
	ALERT("Connected to "+$status.databaseManagementSystemName+" "+$status.databaseManagementSystemVersion)
Else
	ALERT("Connection failed: "+$status.errorMessage)
End if
```

Wrapping the call in an explicit transaction:

```4d
$connection:="DSN=MyDataSource;UID=myuser;PWD=mypass;"
$status:=SQLGetInfo($connection; 1; New object)  //1 = wrap in a transaction
```

---

## Error handling & troubleshooting

- **A missing property in the result is normal, not a bug.** Every property beyond `success`/`errorMessage` is only added when the driver answers that specific `SQLGetInfo` query successfully — sparse or older drivers can legitimately omit most of them.
- **`errorMessage` is only present when `success` is `false`.** Always check `success` before reading any other key.
- **Connection failures (bad driver path, wrong DSN, bad credentials, driver not installed) surface as `success : false` with a driver/SOCI-provided message**, not a crash or a 4D-level error — a bad `Driver=` path like the one in the sample (pointing at a `.so` file that doesn't exist on the current machine) will fail this way.
- **The `mode` and `options` parameters are both read positionally and unconditionally as far as parameter count goes** — you must supply all three arguments; `options` can be `New object` (empty) if you have nothing to set, but it can't be omitted from the call.
- **`options.odbc_option_driver_complete` is the only recognized key** — any other key in `options` is silently ignored.
- **This command always dials out via ODBC**, even for engines SOCI otherwise supports natively (SQLite, PostgreSQL, MySQL) — your connection string must be a valid ODBC connection string/DSN, not a native driver connection string for those engines.

---

## Quick reference

```4d
$status:=SQLGetInfo($connectionString; 0; New object)
If ($status.success)
	// use $status.driverName, $status.databaseManagementSystemName, etc.
Else
	// handle $status.errorMessage
End if
```
