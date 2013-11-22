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
#import <AVFoundation/AVFoundation.h>

@interface GlobalVariables : NSObject
{
    int globalDifficultyLevel; // normal (1) and Hard (2)
    int globalCurrentGame;  // 1 = Counting stars and 2 = hard counting stars, 3 = apples to oranges , 4 = hard apples to oranges
    AVAudioPlayer * audioPlayer;
    float volumeControl;
    NSString *currentUser;
}
@property (nonatomic) int globalDifficultyLevel;
@property (nonatomic)NSString *currentUser;
@property (nonatomic) int globalCurrentGame;
@property (nonatomic,strong) AVAudioPlayer * audioPlayer;
@property (nonatomic) float volumeControl;
+(GlobalVariables*)singleObj;

@end
