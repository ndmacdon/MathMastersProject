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

#import <Foundation/Foundation.h>
#import <sqlite3.h>

// A wrapper for DB files implementing SQLite3.0
@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL) createDB;
//-(BOOL) deleteDB;   // For debug use ONLY.

-(BOOL) addUser:(NSString*)username password:(NSString*)password secret:(NSString*)secret;
//-(BOOL) deleteUser:(NSString*)username password:(NSString*)password;
//-(BOOL) resetPassword:(NSString*)username password:(NSString*)password newPassword:(NSString*)newPassword;

-(BOOL) userExists:(NSString*)username;
-(int) countRowsOF:(NSString*)table;
//-(BOOL) correctSecret:(NSString*)username secret:(NSString*)secret;
-(BOOL) hasCompletedTutorial:(NSString*)username tutorial:(NSString*)tutorial;
-(BOOL) completeTutorial:(NSString*)username tutorial:(NSString*)tutorial;
-(BOOL) login:(NSString*)username password:(NSString*)password;

-(BOOL) logStatsFor:(NSString*)gameID
           withDate:(NSDate*)sessionDate
           withUser:(NSString*)username
      sessionLength:(int)sessionLength
    consecutiveWins:(int)consecutiveWins
               wins:(int)wins
             losses:(int)losses
            highest:(int)highestNumber;

-(NSArray*) getStatsBefore:(NSString*)start
                  forGame:(NSString*)gameID
                aboutUser:(NSString*)username;

@end







