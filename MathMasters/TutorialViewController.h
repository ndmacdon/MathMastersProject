/****
 *
 * Filename:    TutorialCountingStarsViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Tutorial about how to play each game.
 *              Instantiated upon first time user plays specific games or 
 *              if user clicks the "?" button the each game.
 *
 ****/

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"

@interface TutorialViewController : UIViewController {
    GlobalVariables *optionsSingle;  // will be used to access which game is being played

    IBOutlet UIImageView * currentImage;
    NSString *currentTutorial;
}
-(IBAction)back_button_clicked:(id)sender;
-(IBAction)foward_button_clicked:(id)sender;
-(IBAction)ok_button_clicked:(id)sender;

@property(nonatomic,strong) IBOutlet UIImageView *currentImage;
@property (nonatomic, strong) NSString *currentTutorial;
@end
