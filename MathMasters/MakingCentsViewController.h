

// !!!THIS FILE IS NOT INTENDED FOR MARKING IN THIS VERSION. IT IS A PLACEHOLDER ONLY!!!


/****
 *
 * Filename:    MakingCentsViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Counting and magnitude relation game.
 *
 ****/

#import <UIKit/UIKit.h>
#import "MyButtonMakingCents.h"

@interface MakingCentsViewController : UIViewController
{
    IBOutlet UILabel * instructionsUser;
    IBOutlet UIImageView * yellowBox;
    
    IBOutlet MyButtonMakingCents * dime1;
    IBOutlet MyButtonMakingCents * dime2;
    IBOutlet MyButtonMakingCents * quarter1;
    IBOutlet MyButtonMakingCents * quarter2;
    IBOutlet MyButtonMakingCents * quarter3;
    IBOutlet MyButtonMakingCents * nickel1;
    IBOutlet MyButtonMakingCents * nickel2;
}


-(IBAction)dragged_out:(id)sender withEvent: (UIEvent *) event;

@property (nonatomic, strong)IBOutlet UILabel *instructionsUser;
@property (nonatomic) NSInteger amountDisplayed;
@property(nonatomic, strong) IBOutlet UIImageView *yellowBox;
@property(nonatomic) NSInteger amountYellowBox;
@property(nonatomic,strong) NSTimer * timeOfReset;
@property(nonatomic) NSInteger totalCorrect;

@property(nonatomic,strong) IBOutlet UIButton * dime1;
@property(nonatomic,strong)IBOutlet UIButton * dime2;
@property(nonatomic,strong)IBOutlet UIButton * quarter1;
@property(nonatomic,strong)IBOutlet UIButton * quarter2;
@property(nonatomic,strong)IBOutlet UIButton * quarter3;
@property(nonatomic,strong)IBOutlet UIButton * nickel1;
@property(nonatomic,strong)IBOutlet UIButton * nickel2;


@end
