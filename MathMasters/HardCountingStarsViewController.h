/****
 *
 * Filename:    HardCountingStarsViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Hard Version of Counting Stars Game.
 *
 ****/

#import <UIKit/UIKit.h>
#import "TutorialCountingStarsViewController.h"
#import "DBManager.h"
#import "GlobalVariables.h"

@interface HardCountingStarsViewController : UIViewController
{
    GlobalVariables *optionsSingle;  // used to access globalDifficultyLevel
    IBOutlet UILabel *hardStarsUserMustCount;
    IBOutlet UILabel *hardDisplayUserCorrect;
    NSInteger hardRandomInteger;
    NSInteger hardTotalGuessed;
    NSInteger hardTotalCorrect;
    
    UIImage *hardBtnImage;
}

-(IBAction)hard_star_clicked:(id)sender;
-(IBAction)hard_is_user_correct:(id)sender;
-(IBAction)hard_tutorial_clicked:(id)sender;

-(void)add_total_guessed;
-(void)add_total_correct;
-(void)subtract_total_guessed;

@property(nonatomic,strong) IBOutlet UILabel *hardStarsUserMustCount;
@property(nonatomic,strong) IBOutlet UILabel *hardDisplayUserCorrect;
@property(nonatomic) NSInteger hardRandomInteger;
@property(nonatomic) NSInteger hardTotalGuessed;
@property(nonatomic) NSInteger hardTotalCorrect;
@property(nonatomic,strong) UIImage *hardBtnImage;
@property(nonatomic,strong) TutorialCountingStarsViewController *tutorialCountingStarsViewController;


@end

