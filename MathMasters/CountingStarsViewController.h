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
 * VersionDate: Oct 29, 2013
 *
 * Description: ViewController: Normal Version of Counting Stars Game.
 *
 ****/

#import <UIKit/UIKit.h>
#import "TutorialViewController.h"
#import "GameViewController.h"

@interface CountingStarsViewController : GameViewController {
    IBOutlet UIView *starMat;
    IBOutlet UILabel *starsUserMustCount;
    IBOutlet UILabel *displayUserCorrect;

}

-(IBAction)star_clicked:(id)sender;
-(IBAction)is_user_correct:(id)sender;


@property (nonatomic,strong) IBOutlet UILabel *starsUserMustCount;
@property(nonatomic,strong) IBOutlet UILabel *displayUserCorrect;


@end




