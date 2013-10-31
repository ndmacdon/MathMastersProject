

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

@interface MakingCentsViewController : UIViewController
{
    IBOutlet UILabel * instructions_User;
    NSInteger amountDisplayed;
    
    IBOutlet UIButton *five_Cents;
    IBOutlet UIButton *ten_Cents;
    IBOutlet UIButton *twentyfive_Cents;
    
}

-(void)SetInstructionsUser;
-(IBAction)draggedOut:(id)sender withEvent: (UIEvent *) event;

@property (nonatomic, strong)IBOutlet UILabel *instructions_User;
@property (nonatomic) NSInteger amountDisplayed;
@property (nonatomic, strong) IBOutlet UIButton *five_Cents;
@property (nonatomic, strong) IBOutlet UIButton *ten_Cents;
@property (nonatomic, strong) IBOutlet UIButton *twentyfive_Cents;


@end
