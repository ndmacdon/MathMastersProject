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
    
    // used to play the background music of application
    AVAudioPlayer * audioPlayer;
    // used to play sound effects of application
    AVAudioPlayer * soundEffectsPlayer;
    float musicVolumeControl;
    float soundeffectVolumeControl;
    NSString *currentUser;
}
@property (nonatomic) int globalDifficultyLevel;
@property (nonatomic)NSString *currentUser;
@property (nonatomic,strong) AVAudioPlayer * audioPlayer;
@property (nonatomic,strong) AVAudioPlayer * soundEffectsPlayer;
@property (nonatomic) float musicVolumeControl;
@property(nonatomic) float soundeffectVolumeControl;
+(GlobalVariables*)singleObj;

@end
