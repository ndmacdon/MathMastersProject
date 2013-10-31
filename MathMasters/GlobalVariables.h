/****
 *
 * Filename:    GlobalVariables.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: Model: Provides accessor for global variables like globalDifficultyLevel.
 *
 ****/

#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject
{
    int globalDifficultyLevel; // normal (1) and Hard (2)
    int globalCurrentGame;  // 1 = Counting stars and 2 = hard counting stars
    NSString *currentUser;
}
@property (nonatomic) int globalDifficultyLevel;
@property (nonatomic)NSString *currentUser;
@property (nonatomic) int globalCurrentGame;
+(GlobalVariables*)singleObj;

@end
