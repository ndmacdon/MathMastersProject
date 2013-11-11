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
 * VersionDate: Nov 02, 2013
 *
 * Description: ViewController: Counting and magnitude relation which asks players to
 *                              make exact change according to a total.
 *
 ****/

#import <UIKit/UIKit.h>
#import "MyButtonMakingCents.h"
#import "GameViewController.h"

@interface MakingCentsViewController : GameViewController {
    IBOutlet UILabel * instructionsUser;
    IBOutlet UIImageView * yellowBox;
    
    IBOutlet UILabel *resultLabel;
    IBOutlet MyButtonMakingCents * dollar1;
    IBOutlet MyButtonMakingCents * dime1;
    IBOutlet MyButtonMakingCents * dime2;
    IBOutlet MyButtonMakingCents * quarter1;
    IBOutlet MyButtonMakingCents * quarter2;
    IBOutlet MyButtonMakingCents * quarter3;
    IBOutlet MyButtonMakingCents * nickel1;
    IBOutlet MyButtonMakingCents * nickel2;
}


-(IBAction)dragged_out:(id)sender withEvent: (UIEvent *) event;
- (IBAction)check_user_correct:(id)sender;

@property (nonatomic, strong)IBOutlet UILabel *instructionsUser;
@property(nonatomic, strong) IBOutlet UIImageView *yellowBox;
@property(nonatomic,strong) NSTimer * timeOfReset;

@property(nonatomic,strong) IBOutlet UIButton * dime1;
@property(nonatomic,strong)IBOutlet UIButton * dime2;
@property(nonatomic,strong)IBOutlet UIButton * quarter1;
@property(nonatomic,strong)IBOutlet UIButton * quarter2;
@property(nonatomic,strong)IBOutlet UIButton * quarter3;
@property(nonatomic,strong)IBOutlet UIButton * nickel1;
@property(nonatomic,strong)IBOutlet UIButton * nickel2;
@property(nonatomic,strong)IBOutlet UIButton * dollar1;


@end
