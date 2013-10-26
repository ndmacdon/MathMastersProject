//
//  DBManager.m
//  MathMasters
//
//  Created by Nicholas
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "DBManager.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

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
            "CREATE TABLE IF NOT EXISTS USERS (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, PASSWORD TEXT, SECRET TEXT)";
            
            // TODO: ADD OTHER TABLES NEEDED HERE....
            
            // IF statement executes without error:
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create USERS table");
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
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO USERS (USERNAME, PASSWORD, SECRET) VALUES (\"%@\", \"%@\", \"%@\")",
                               username, password, secret];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        
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
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT USERNAME FROM USERS WHERE USERNAME=\"%@\"", username];
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
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT count(*) AS 'NumUsers' FROM \"%@\"", table];
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
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT USERNAME PASSWORD FROM USERS WHERE USERNAME=\"%@\" AND PASSWORD=\"%@\"", username, password];
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


@end











