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
    
    IBOutlet UIDatePicker *timePicker;
    IBOutlet UIImageView *minuteHand;
    IBOutlet UIImageView *hourHand;
    IBOutlet UILabel *resultLabel;


    
    IBOutlet UILabel * correcthour;
    IBOutlet UILabel * correctminute;
    IBOutlet UILabel * guesshour;
    IBOutlet UILabel * guessminute;

    
}
- (IBAction)checkAnswer:(id)sender;
-(void) normal_move_hands;
-(void) reset_hands;


@property (nonatomic,strong)NSString * correctTime;
@property(nonatomic,strong) NSString *timeGuessed;

@property(nonatomic,strong) NSString * hourGuessed;
@property(nonatomic,strong) NSString * minuteGuessed;
@property(nonatomic,strong) NSString * hourCorrectAnswer;
@property(nonatomic,strong) NSString * minuteCorrectAnswer;

@end
