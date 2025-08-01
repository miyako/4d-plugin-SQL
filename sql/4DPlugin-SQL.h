/* --------------------------------------------------------------------------------
 #
 #	4DPlugin-SQL.h
 #	source generated by 4D Plugin Wizard
 #	Project : SQL
 #	author : miyako
 #	2025/07/16
 #  
 # --------------------------------------------------------------------------------*/

#ifndef PLUGIN_SQL_H
#define PLUGIN_SQL_H

#include "4DPluginAPI.h"
#include "4DPlugin-JSON.h"
#include "C_TEXT.h"

#include "soci/soci.h"
#include "soci/sqlite3/soci-sqlite3.h"
#include "soci/postgresql/soci-postgresql.h"
#include "soci/odbc/soci-odbc.h"
#include "soci/mysql/soci-mysql.h"
#include <memory> //for std::unique_ptr

typedef enum {
    soci_mode_none          = 0,
    soci_mode_transaction   = 1
}soci_mode_t;

#pragma mark -

static void SQLGetInfo(PA_PluginParameters params);

#endif /* PLUGIN_SQL_H */
