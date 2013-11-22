/****
 *
 * Filename:    MasterViewController.m
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

#import "MasterViewController.h"
#import "GlobalVariables.h"
#import "DBManager.h"

@implementation MasterViewController
@synthesize countingStarsViewController,
    fishToFishViewController,
    makingCentsViewController,
    clockWorkViewController,
    superShopperViewController,
    optionsViewController,
    loginViewController,
    createAccountViewController;

// Launch OptionsViewController:
-(IBAction)options_clicked:(id)sender
{
    if(!self.optionsViewController)
    {
        self.optionsViewController = [[OptionsViewController alloc] init];
    }
    [self.navigationController pushViewController:self.optionsViewController animated:YES];
}

// Launch CountingStars ViewController:
-(IBAction)cstars_clicked:(id)sender {
    optionsSingle.globalCurrentGame =1;
    self.countingStarsViewController = [[CountingStarsViewController alloc] init];
    [self.navigationController pushViewController:self.countingStarsViewController animated:YES];
}

// Launch FishToFish ViewController:
-(IBAction)fishtofish_clicked:(id)sender {
    optionsSingle.globalCurrentGame =3;
    self.fishToFishViewController = [[FishToFishViewController alloc] init];
    [self.navigationController pushViewController:self.fishToFishViewController animated:YES];
}

// Launch MakingCents ViewController:
-(IBAction)makingcents_clicked:(id)sender
{
    if(!self.makingCentsViewController)
    {
        self.makingCentsViewController = [[MakingCentsViewController alloc] init];
    }
    [self.navigationController pushViewController:self.makingCentsViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    optionsSingle = [GlobalVariables singleObj];
    optionsSingle.globalDifficultyLevel = 1;   // initialize difficultyLevel to 1 ( normal )
	
}

-(void)viewWillAppear:(BOOL)animated {
    
    // We must push the view here because the viewDidLoad
    // method occurs before the view is 'ready' for pushing...
    
    // If USERS table has ZERO rows:
    if([[DBManager getSharedInstance]countRowsOF:@"USERS"] == 0) {
        
        // IF we can push the CreateAccountViewController:
        if(!self.createAccountViewController) {
            self.createAccountViewController = [[CreateAccountViewController alloc] init];
        }
        [self.navigationController pushViewController:self.createAccountViewController animated:YES];
    }
    // ELSE USERS table has MORE THAN ZERO rows:
    else if(optionsSingle.currentUser == NULL) {
        
        // IF we can push the LoginViewController:
        if(!self.loginViewController) {
            self.loginViewController = [[LogInViewController alloc] init];
        }
        [self.navigationController pushViewController:self.loginViewController animated:YES];
        
    }
    self.navigationItem.hidesBackButton = YES; // Disable back button.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)clockWork_clicked:(id)sender {
    // Check difficulty and launch appropriate version:
    if(optionsSingle.globalDifficultyLevel >= 1)
    {
        optionsSingle.globalCurrentGame =1;
        self.clockWorkViewController = [[ClockWorkViewController alloc] init];
        [self.navigationController pushViewController:self.clockWorkViewController animated:YES] ;
    }
}

- (IBAction)superShopper_clicked:(id)sender {
    optionsSingle.globalCurrentGame =5;
    self.superShopperViewController = [[SuperShopperViewController alloc] init];
    [self.navigationController pushViewController:self.superShopperViewController animated:YES];
}

// Logout the current user:
- (IBAction)logoutClicked:(id)sender {
    // Update Global Session Variable:
    optionsSingle.currentUser = @"";
    // IF we can push the LoginViewController:
    if(!self.loginViewController) {
        self.loginViewController = [[LogInViewController alloc] init];
    }
    [self.navigationController pushViewController:self.loginViewController animated:YES];
    
}
@end


