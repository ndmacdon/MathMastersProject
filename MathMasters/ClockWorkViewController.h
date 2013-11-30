/****
 *
 * Filename:    ClockWorkViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: Nov 07, 2013
 *
 * Description: ViewController: Asks players to correctly interpret the current time
 *                              displayed on an analog clock face.
 *
 ****/

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface ClockWorkViewController : GameViewController <UIPickerViewDelegate> {
    int temp_number;
    IBOutlet UIImageView *minuteHand;
    IBOutlet UIImageView *hourHand;
    IBOutlet UILabel *resultLabel;
    IBOutlet UIView *pickerFrame;
}

- (IBAction)checkAnswer:(id)sender;
@end
