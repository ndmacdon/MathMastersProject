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
    int globalDifficultyLevel; // normal (1) and Hard (2)
    int globalCurrentGame;  // 1 = Counting stars and 2 = hard counting stars
    NSString *currentUser;
}
@property (nonatomic) int globalDifficultyLevel;
@property (nonatomic)NSString *currentUser;
@property (nonatomic) int globalCurrentGame;
+(GlobalVariables*)singleObj;

@end
