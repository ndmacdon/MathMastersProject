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
#import "StatisticsViewController.h"

@interface OptionsViewController : UIViewController
{
    IBOutlet UIButton * changeDifficultyButton;
    GlobalVariables *optionsSingle;  // used to access globalDifficultyLevel
}
- (IBAction)statistics_clicked:(id)sender;
-(IBAction)change_difficulty:(id)sender;
@property(nonatomic,strong) IBOutlet UIButton *changeDifficultyButton;
@property (nonatomic,strong) StatisticsViewController  *statisticsViewController;


@end
