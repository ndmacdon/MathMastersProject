//
//  ViewController.h
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//


// Brief Description : Header file of View Controller, is the main menu and navigation controller of application that contains buttons to multiple games and options menu


#import <UIKit/UIKit.h>
#import "GlobalVariables.h"
#import "CountingStarsViewController.h"
#import "HardCountingStarsViewController.h"
#import "FishToFishViewController.h"
#import "MakingCentsViewController.h"
#import "OptionsViewController.h"
#import "LogInViewController.h"
#import "CreateAccountViewController.h"
#import "DBManager.h"




@interface ViewController : UIViewController
{
    GlobalVariables *optionsSingle;  // used to keep track of difficulty level

}
-(IBAction)cstars_clicked:(id)sender; // if button clicked go to counting stars game
-(IBAction)fishtofish_clicked:(id)sender;
-(IBAction)makingcents_clicked:(id)sender;
-(IBAction)options_clicked:(id)sender; // if option button clicked go to options menu

// normal version of counting stars
@property (nonatomic,strong) CountingStarsViewController *countingStarsViewController;
// hard version of counting stars
@property(nonatomic,strong) HardCountingStarsViewController * hardCountingViewController;
@property (nonatomic,strong) FishToFishViewController *fishToFishViewController;
@property(nonatomic,strong) MakingCentsViewController * makingCentsViewController;
@property(nonatomic,strong) OptionsViewController *optionsViewController;
@property(nonatomic,strong) LogInViewController *loginViewController;
@property(nonatomic,strong) CreateAccountViewController *createAccountViewController;



@end
