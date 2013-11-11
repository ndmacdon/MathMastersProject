/****
 *
 * Filename:    MasterViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: Nov 08, 2013
 *
 * Description: ViewController: Main menu and navigation controller of application. 
 *              Contains links to multiple games and the Options menu.
 *
 ****/

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"
#import "CountingStarsViewController.h"
#import "FishToFishViewController.h"
#import "MakingCentsViewController.h"
#import "OptionsViewController.h"
#import "LogInViewController.h"
#import "CreateAccountViewController.h"
#import "ClockWorkViewController.h"
#import "SuperShopperViewController.h"
#import "DBManager.h"

@interface MasterViewController : UIViewController
{
    GlobalVariables *optionsSingle;  // used to keep track of difficulty level
}
-(IBAction)cstars_clicked:(id)sender; // if button clicked go to counting stars game
-(IBAction)fishtofish_clicked:(id)sender;
-(IBAction)makingcents_clicked:(id)sender;
-(IBAction)options_clicked:(id)sender; // if option button clicked go to options menu
-(IBAction)clockWork_clicked:(id)sender;
- (IBAction)superShopper_clicked:(id)sender;

// Game ViewControllers:
@property (nonatomic,strong) CountingStarsViewController *countingStarsViewController;
@property (nonatomic,strong) FishToFishViewController *fishToFishViewController;
@property (nonatomic,strong) MakingCentsViewController * makingCentsViewController;
@property (nonatomic, strong) ClockWorkViewController *clockWorkViewController;
@property (nonatomic, strong) SuperShopperViewController *superShopperViewController;

// Utility ViewControllers:
@property (nonatomic,strong) OptionsViewController *optionsViewController;
@property (nonatomic,strong) LogInViewController *loginViewController;
@property (nonatomic,strong) CreateAccountViewController *createAccountViewController;


@end



