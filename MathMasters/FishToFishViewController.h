/****
 *
 * Filename:    FishToFishViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: November 02, 2013
 *
 * Description: ViewController: Magnitude estimation game.
 *
 ****/

#import <UIKit/UIKit.h>
#import "GameViewController.h"


@interface FishToFishViewController : GameViewController {
    IBOutlet UILabel *displayUserCorrect;
    IBOutlet UIButton *rightGroup;
    IBOutlet UIButton *leftGroup;
    IBOutlet UIButton *bottomGroup;
}

-(IBAction)group_button_clicked:(id)sender;

@property(nonatomic,strong) IBOutlet UILabel *displayUserCorrect;
          
@end
