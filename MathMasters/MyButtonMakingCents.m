/****
 *
 * Filename:    MyButtonMakingCents.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: Nov 05, 2013
 *
 * Description: ViewController: Provides a custom button for the makingCents game.
 *
 ****/
#import "MyButtonMakingCents.h"

@implementation MyButtonMakingCents
@synthesize inYellowBox;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        inYellowBox = false;
    }
    return self;
}

@end
