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
#import "GameViewController.h"

@interface CountingStarsViewController : GameViewController
{
    IBOutlet UIView *starMat;
    IBOutlet UILabel *starsUserMustCount;
    IBOutlet UILabel *displayUserCorrect;

}

-(IBAction)star_clicked:(id)sender;
-(IBAction)is_user_correct:(id)sender;
-(IBAction)normal_tutorial_clicked:(id)sender;


@property (nonatomic,strong) IBOutlet UILabel *starsUserMustCount;
@property(nonatomic,strong) IBOutlet UILabel *displayUserCorrect;
@property(nonatomic,strong) TutorialCountingStarsViewController * tutorialCountingStarsViewController;

@end




