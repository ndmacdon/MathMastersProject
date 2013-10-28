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
 * VersionDate: October 27, 2013
 *
 * Description: Model: A wrapper for the SQLite3 database 'USERS'.
 *              Provides easy access to the database via abstracted queries.
 *
 ****/

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
    }
    return sharedInstance;
}

//Create the DB if it doesn't already exist:
-(BOOL)createDB {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory:
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file:
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"user.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    // IF database doesn't exist:
    if ([filemgr fileExistsAtPath: databasePath] == NO) {
        const char *dbpath = [databasePath UTF8String];
        
        // IF database opens without error:
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            char *errMsg; // Check the contents of this if there is an error...
            
            // Prepare our SQL statement:
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS users \
            (username_pk TEXT PRIMARY KEY, \
             password TEXT, secret TEXT);\
            \
            CREATE TABLE IF NOT EXISTS tutorials\
            (username_fk TEXT, \
             tutorial_name_pk TEXT, \
             FOREIGN KEY(username_fk) REFERENCES USERS(username_pk), \
             PRIMARY KEY (username_fk, tutorial_name_pk))";
            
            // TODO: ADD OTHER TABLES NEEDED HERE....
            
            // IF statement executes without error:
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create tables");
            }
            
            sqlite3_close(database); // Close the database...
            return isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

// Add a user to the database:
-(BOOL) addUser:(NSString *)username password:(NSString *)password secret:(NSString *)secret {
    const char *dbpath = [databasePath UTF8String];
    
    // IF database opens without error:
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        // Prepare our SQL statement:
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO users \
                               (username_pk, password, secret) \
                                VALUES (\"%@\", \"%@\", \"%@\")",
                               username, password, secret];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        
        // IF statement executes without error:
        if (sqlite3_step(statement) == SQLITE_DONE) {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

// Does a user with [username] exist in the DB:
-(BOOL) userExists:(NSString*)username {
    const char *dbpath = [databasePath UTF8String];
    BOOL exists = FALSE;
    
    // IF database opens without error:
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        // Prepare our SQL statement:
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT username_pk \
                                FROM users \
                                WHERE username_pk=\"%@\"", username];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // IF query returns some row:
            if (sqlite3_step(statement) == SQLITE_ROW) {
                // We don't actually use the name, this is just a good example of query.
                NSString *name = [[NSString alloc] initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 0)];
                [resultArray addObject:name]; // We could return this NSArray* if we wanted the names...
                exists = TRUE;
            }
            else {
                NSLog(@"User not found");
                exists = FALSE;
            }
            sqlite3_reset(statement);
        }
    }
    return exists;
}

// Returns the count of rows of the passed table:
-(int) countRowsOF:(NSString *)table {
    const char *dbpath = [databasePath UTF8String];
    int rows = 0;
    
    // IF database opens without error:
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        // Prepare our SQL statement:
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT count(*) AS 'NumUsers' \
                                FROM \"%@\"", table];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // IF query returns some row:
            if (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *rowString = [[NSString alloc] initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 0)];
                rows = [rowString intValue];
            }
            else {
                NSLog(@"Unable to return count");
            }
            sqlite3_reset(statement);
        }
    }
    return rows;
}

-(BOOL) login:(NSString*)username password:(NSString*)password {
    const char *dbpath = [databasePath UTF8String];
    BOOL loginSuccess = FALSE; // Did the user login?
    
    // IF database opens without error:
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        // Prepare our SQL statement:
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT username_pk password\
                                FROM users\
                                WHERE username_pk=\"%@\" AND password=\"%@\"", username, password];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // IF query returns some row:
            if (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *name = [[NSString alloc] initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 0)];
                [resultArray addObject:name]; // We could return this NSArray* if we wanted the names...
                loginSuccess = TRUE;
            }
            else {
                NSLog(@"User not found");
                loginSuccess = FALSE;
            }
            sqlite3_reset(statement);
        }
    }
    return loginSuccess;
}

-(BOOL) hasCompletedTutorial:(NSString*)username tutorial:(NSString*)tutorial {
    const char *dbpath = [databasePath UTF8String];
    BOOL exists = FALSE;
    
    // IF database opens without error:
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        // Prepare our SQL statement:
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT username_fk tutorial_name_pk\
                                FROM tutorials \
                                WHERE username_fk=\"%@\" AND tutorial_name_pk=\"%@\"", username, tutorial];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // IF query returns some row:
            if (sqlite3_step(statement) == SQLITE_ROW) {
                // We don't actually use the name, this is just a good example of query.
                NSString *name = [[NSString alloc] initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 0)];
                [resultArray addObject:name]; // We could return this NSArray* if we wanted the results...
                exists = TRUE;
            }
            else {
                NSLog(@"Tutorial Not Played");
                exists = FALSE;
            }
            sqlite3_reset(statement);
        }
    }
    return exists;
}

// Mark tutorial as completed in the database:
-(BOOL) completeTutorial:(NSString*)username tutorial:(NSString*)tutorial {
        const char *dbpath = [databasePath UTF8String];
        
        // IF database opens without error:
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            
            // Prepare our SQL statement:
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO tutorials \
                                   (username_fk, tutorial_name_pk) \
                                   VALUES (\"%@\", \"%@\")",
                                   username, tutorial];
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
            
            // IF statement executes without error:
            if (sqlite3_step(statement) == SQLITE_DONE) {
                return YES;
            }
            else {
                return NO;
            }
            sqlite3_reset(statement);
        }
        return NO;
    }


@end











