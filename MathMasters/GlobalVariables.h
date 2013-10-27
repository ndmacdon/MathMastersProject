//
//  GlobalVariables.h
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//

//  Brief Description: Used to set and get global variables like globalDifficultyLevel

#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject
{
    int global_difficulty_level; // normal (1) and Hard (2)
    NSString *currentUser;
}
@property (nonatomic) int global_difficulty_Level;
@property (nonatomic)NSString *currentUser;
+(GlobalVariables*)singleObj;

@end
