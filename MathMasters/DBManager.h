//
//  DBManager.h
//  MathMasters
//
//  Created by Nicholas
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

// A wrapper for DB files implementing SQLite3.0
@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL) createDB;
-(BOOL) deleteDB;   // For debug use ONLY.

-(BOOL) addUser:(NSString*)username password:(NSString*)password secret:(NSString*)secret;
-(BOOL) deleteUser:(NSString*)username password:(NSString*)password;
-(BOOL) resetPassword:(NSString*)username password:(NSString*)password newPassword:(NSString*)newPassword;

-(BOOL) userExists:(NSString*)username;
-(int) countRowsOF:(NSString*)table;
-(BOOL) correctSecret:(NSString*)username secret:(NSString*)secret;
-(BOOL) login:(NSString*)username password:(NSString*)password;

// Example methods...
//-(BOOL) saveData:(NSString*)registerNumber name:(NSString*)name department:(NSString*) department year:(NSString*)year;
//-(NSArray*) findRegisterNumber:(NSString*)registerNumber;
@end
