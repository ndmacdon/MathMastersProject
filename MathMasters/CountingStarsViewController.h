/****
 *
 * Filename:    CountingStarsViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Normal Version of Counting Stars Game.
 *
 ****/

#import <UIKit/UIKit.h>
#import "TutorialCountingStarsViewController.h"
#import "DBManager.h"
#import "GlobalVariables.h"

@interface CountingStarsViewController : UIViewController
{
    GlobalVariables *optionsSingle;  // used to access globalDifficultyLevel
    IBOutlet UILabel *starsUserMustCount;
    IBOutlet UILabel *displayUserCorrect;
    NSInteger randomInteger;
    NSInteger totalGuessed;
    NSInteger totalCorrect;
    UIImage *btnImage;
}

-(IBAction)star_clicked:(id)sender;
-(IBAction)is_user_correct:(id)sender;
-(IBAction)normal_tutorial_clicked:(id)sender;

-(void)add_total_guessed;
-(void)subtract_total_guessed;
-(void)add_total_correct;

@property (nonatomic,strong) IBOutlet UILabel *starsUserMustCount;
@property(nonatomic,strong) IBOutlet UILabel *displayUserCorrect;
@property(nonatomic) NSInteger randomInteger;
@property(nonatomic) NSInteger totalGuessed;
@property(nonatomic) NSInteger totalCorrect;
@property(nonatomic,strong) UIImage *btnImage;

@property(nonatomic,strong) TutorialCountingStarsViewController * tutorialCountingStarsViewController;


@end




