/****
 *
 * Filename:    OptionsViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Options menu interface that controls the difficulty level of games.
 *
 ****/

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"

@interface OptionsViewController : UIViewController
{

    IBOutlet UIButton * changeDifficultyButton;
    GlobalVariables *optionsSingle;  // used to access globalDifficultyLevel
}


-(IBAction)change_difficulty:(id)sender;
@property(nonatomic,strong) IBOutlet UIButton *changeDifficultyButton;


@end
