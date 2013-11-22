/****
 *
 * Filename:    GlobalVariables.m
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

#import "GlobalVariables.h"

@implementation GlobalVariables
{
    GlobalVariables * NewSingle;
}
@synthesize globalDifficultyLevel,globalCurrentGame,currentUser, audioPlayer,volumeControl;

+(GlobalVariables*)singleObj  // only one GlobalVariables object can be created
{
    static GlobalVariables *single = nil;
    @synchronized(self)
    {
        if(!single)
        {
            single = [[GlobalVariables alloc]init];
        }
    }
    return single;
}



@end
