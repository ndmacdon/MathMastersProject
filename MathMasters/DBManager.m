/****
 *
 * Filename:    DBManager.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 31, 2013
 *
 * Description: Model: A wrapper for the SQLite3 database 'USERS'.
 *              Provides easy access to the database via abstracted queries.
 *
 ****/

/* Methods we can use to grab data from returned query statements:
 
 SQLITE_API const void *sqlite3_column_blob(sqlite3_stmt*, int iCol);
 SQLITE_API int sqlite3_column_bytes(sqlite3_stmt*, int iCol);
 SQLITE_API int sqlite3_column_bytes16(sqlite3_stmt*, int iCol);
 SQLITE_API double sqlite3_column_double(sqlite3_stmt*, int iCol);
 SQLITE_API int sqlite3_column_int(sqlite3_stmt*, int iCol);
 SQLITE_API sqlite3_int64 sqlite3_column_int64(sqlite3_stmt*, int iCol);
 SQLITE_API const unsigned char *sqlite3_column_text(sqlite3_stmt*, int iCol);
 SQLITE_API const void *sqlite3_column_text16(sqlite3_stmt*, int iCol);
 SQLITE_API int sqlite3_column_type(sqlite3_stmt*, int iCol);
 SQLITE_API sqlite3_value *sqlite3_column_value(sqlite3_stmt*, int iCol);
 */


#import "DBManager.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

// Return a handle to the shared instance of the DBManager:
+(DBManager*)getSharedInstance {
    
    // IF sharedInstance doesn't exist: create it
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
        [sharedInstance populateDB];
    }
    return sharedInstance;
}

//Create the DB if it doesn't already exist:
-(BOOL)createDB {
    BOOL created = FALSE;      // Did the DB creation succeed?
    NSString *docsDir;          // Documents Directory Path.
    NSArray *dirPaths;          // Handle on directory listings...
    char *errMsg;               // Check the contents of this if there is an error...
    const char *dbpath;         // DB file path 'string'.
    const char *sql_stmt =      // Schema of our DB:
    "CREATE TABLE IF NOT EXISTS users \
    (username_pk TEXT PRIMARY KEY, \
    password TEXT, secret TEXT);\
    \
    CREATE TABLE IF NOT EXISTS games\
    (game_pk TEXT PRIMARY KEY);\
    \
    CREATE TABLE IF NOT EXISTS tutorials\
    (username_fk TEXT, \
    game_fk TEXT, \
    FOREIGN KEY(username_fk) REFERENCES users(username_pk), \
    FOREIGN KEY(game_fk) REFERENCES games(game_pk),\
    PRIMARY KEY (username_fk, game_fk));\
    \
    CREATE TABLE IF NOT EXISTS sessionStats\
    (game_fk TEXT,\
    username_fk TEXT,\
    session_date_ck TEXT,\
    session_length INTEGER,\
    consecutive_wins INTEGER,\
    wins INTEGER,\
    losses INTEGER,\
    highest_number,\
    FOREIGN KEY(game_fk) REFERENCES games(game_pk),\
    FOREIGN KEY(username_fk) REFERENCES users(username_pk),\
    PRIMARY KEY (game_fk, username_fk, session_date_ck))";
    
    // TODO: ADD OTHER TABLES NEEDED HERE....
    
    // Get the documents directory:
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file:
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"user.db"]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    // IF database doesn't exist:
    if ([filemgr fileExistsAtPath: databasePath] == NO) {
        dbpath = [databasePath UTF8String];
        
        // IF database opens without error:
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            
            // IF schema create statement executes WITH error:
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create tables");
            }
            else { created = TRUE; }
            
            sqlite3_close(database); // Close the database...
        }
        else {
            NSLog(@"Failed to open/create database");
        }
    }
    
    return created;
}

// Query the database with [queryString]:
// Other methods should use this helper when querying the DB (If possible).
-(BOOL) query:(NSString *)queryString result:(int)result{
    const char *dbpath = [databasePath UTF8String]; // Converted SQL query string.
    BOOL success = FALSE; // Did the query return rows?
    int stepResult = 0;
    
    sqlite3_reset(statement); // Clear any existing results...
    
    // IF database opens without error:
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        // Prepare our SQL statement:
        const char *query_stmt = [queryString UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            stepResult = sqlite3_step(statement); // Get the result code.
            
            // IF query returns some row:
            if (stepResult == result)
            { success = TRUE; }
            else { NSLog(@"Query returned code: %d", stepResult); }
        }
        else {
            // Log the SQLite Error...
            NSLog(@"%s SQLITE_ERROR '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(database), sqlite3_errcode(database));
        }
        
    }
    else { NSLog(@"Database failed to open."); }
    
    sqlite3_close(database); // Close the database...
    return success;
}

// Populate the DataBase with critical data:
-(BOOL) populateDB {
    BOOL added = FALSE; // Was the user added?
    NSString *insertSQL =
                            @"INSERT INTO games \
                            (game_pk) \
                            VALUES\
                            (\"CountingStarsViewController\"),\
                            (\"HardCountingStarsViewController\"),\
                            (\"MakingCentsViewController\"),\
                            (\"HardMakingCentsViewController\"),\
                            (\"SuperShopperViewController\"),\
                            (\"HardSuperShopperViewController\"),\
                            (\"ClockworkViewController\"),\
                            (\"HardClockworkViewController\"),\
                            (\"FishToFishViewController\"),\
                            (\"HardFishToFishViewController\")";
    
    // IF statement executes without error:
    if ([self query:insertSQL result:SQLITE_DONE]) {
        added = TRUE;
    }
    else { NSLog(@"Unable to populate Database"); }
    
    sqlite3_reset(statement);
    return added;
}


// Add a user to the database:
-(BOOL) addUser:(NSString *)username password:(NSString *)password secret:(NSString *)secret {
    BOOL added = FALSE; // Was the user added?
    NSString *insertSQL = [NSString stringWithFormat:
                           @"INSERT INTO users \
                           (username_pk, password, secret) \
                           VALUES (\"%@\", \"%@\", \"%@\")",
                           username, password, secret];
     
    // IF statement executes without error:
    if ([self query:insertSQL result:SQLITE_DONE]) {
        added = TRUE;
    }
    else { NSLog(@"Unable to add user"); }
    
    sqlite3_reset(statement);
    return added;
}

// Does a user with [username] exist in the DB:
-(BOOL) userExists:(NSString*)username {
    BOOL exists = FALSE; // Does [username] exist in the database?
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT username_pk \
                          FROM users \
                          WHERE username_pk=\"%@\"", username];
    
    // IF query returns some row:
    if ([self query:querySQL result:SQLITE_ROW]) {
        exists = TRUE;
    }
    else { NSLog(@"User not found"); }
    
    sqlite3_reset(statement);
    return exists;
}

// Returns the count of rows of the passed table:
-(int) countRowsOF:(NSString *)table {
    int rows = 0; // Number of rows in [table] SQLTable:
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT count(*) AS 'NumUsers' \
                          FROM \"%@\"", table];
    
    // IF query returns result:
    if ([self query:querySQL result:SQLITE_ROW]) {
        NSString *rowString = [[NSString alloc] initWithUTF8String:(const char *)
                               sqlite3_column_text(statement, 0)];
        rows = [rowString intValue];
    }
    else { NSLog(@"Unable to query count"); }
    
    sqlite3_reset(statement); // Reset the returned results...
    return rows;
}

// Attempt to login [username] with [password]:
-(BOOL) login:(NSString*)username password:(NSString*)password {
    BOOL loginSuccess = FALSE; // Did the user login?
    NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT username_pk password\
                                FROM users\
                                WHERE username_pk=\"%@\" AND password=\"%@\"", username, password];

    // IF query returns some row:
    if ([self query:querySQL result:SQLITE_ROW]) {
        loginSuccess = TRUE;
    }
    else { NSLog(@"User not found"); }
    
    sqlite3_reset(statement); // Reset the returned results...
    return loginSuccess;
}

// Has [username] completed [tutorial]?
-(BOOL) hasCompletedTutorial:(NSString*)username tutorial:(NSString*)tutorial {
    BOOL exists = FALSE; // Is there a record of the user completing this tutorial?
    // Prepare our SQL statement:
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT username_fk game_fk\
                            FROM tutorials \
                            WHERE username_fk=\"%@\" AND game_fk=\"%@\"", username, tutorial];
    
    // IF query returns any result:
    if ([self query:querySQL result:SQLITE_ROW]) {
        exists  = TRUE;
        }
    else {
        NSLog(@"User has not completed tutorial: %@", tutorial);
    }
    
    sqlite3_reset(statement); // Reset the returned results...
    return exists;
}
 
 
// Mark tutorial as completed in the database:
-(BOOL) completeTutorial:(NSString*)username tutorial:(NSString*)tutorial {
    BOOL completed = FALSE; // Did the update succeed?
    NSString *insertSQL = [NSString stringWithFormat:
                           @"INSERT INTO tutorials \
                           (username_fk, game_fk) \
                           VALUES (\"%@\", \"%@\")",
                           username, tutorial];
    
    
    if ([self query:insertSQL result:SQLITE_DONE]) {
        completed = TRUE;
    }
    else { NSLog(@"Tutorial could not be marked 'Completed'"); }
    
    sqlite3_reset(statement);
    return completed;
}


-(BOOL) logStatsFor:(NSString *)gameID
           withDate:(NSDate *)sessionDate
           withUser:(NSString *)username
      sessionLength:(int)sessionLength
    consecutiveWins:(int)consecutiveWins
               wins:(int)wins
             losses:(int)losses
            highest:(int)highestNumber {
    
    BOOL completed = FALSE; // Did the update succeed?
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    
    NSString *stringDate = [dateFormatter stringFromDate: sessionDate];
    
    
    NSString *insertSQL = [NSString stringWithFormat:
                           @"INSERT INTO sessionStats \
                           (game_fk, username_fk, session_date_ck, \
                           session_length, consecutive_wins, wins, \
                           losses,highest_number) \
                           VALUES \
                           (\"%@\", \"%@\", \"%@\", \
                           \"%d\", \"%d\", \"%d\", \
                           \"%d\", \"%d\")",
                           gameID, username, stringDate,
                           sessionLength, consecutiveWins, wins,
                           losses, highestNumber];
    
    if ([self query:insertSQL result:SQLITE_DONE]) {
        completed = TRUE;
    }
    else { NSLog(@"Session could not be recorded"); }
    
    sqlite3_reset(statement);
    return completed;
}

// Return the array of session results for this [user] and [game] since [start]:
-(NSArray*) getStatsForGame:(NSString *)gameID
                aboutUser:(NSString *)username {
    
    NSMutableArray *results = [[NSMutableArray alloc] init]; // Is there a record of the user completing this tutorial?
    NSString *nextResult; // The next result we will add to our NSMutable array.
    NSInteger maxResults = 30; // The maximum number of results we want to return...
    NSInteger numResults = 0; // How many results have we returned?
    
    // Prepare our SQL statement:
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT session_date_ck, session_length \
                          FROM sessionStats \
                          WHERE \
                          username_fk=\"%@\" AND \
                          game_fk=\"%@\"\
                          ORDER BY session_date_ck DESC, session_length",
                          username,
                          gameID];
    
    // IF query returns any result:
    if ([self query:querySQL result:SQLITE_ROW]) {
        
        // querySQL advances past the first result, for cleanliness we reset to the first record returned...
        
        // Go back to the first result:
        sqlite3_reset(statement);
        
        // Load results into an array....
        //WHILE there are any rows returned AND we have less than 30 rows:
        while (sqlite3_step(statement) == SQLITE_ROW && numResults < maxResults) {
            
            // Add a date:
            nextResult =
            [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            [results addObject:nextResult];
            // Add a sessionLength:
            nextResult =
            [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
            [results addObject:nextResult];
            
            
            numResults++;
        }
        
    }
    else {
        NSLog(@"User '%@' has no session results for '%@'",
              username, gameID);
    }
    
    sqlite3_reset(statement); // Reset the returned results...
    return results;
}

@end











