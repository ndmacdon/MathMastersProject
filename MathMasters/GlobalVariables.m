//
//  GlobalVariables.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//

//  Brief Description: Used to set and get global variables like globalDifficultyLevel

#import "GlobalVariables.h"

@implementation GlobalVariables
{
    GlobalVariables * NewSingle;
}
@synthesize globalDifficultyLevel;

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
