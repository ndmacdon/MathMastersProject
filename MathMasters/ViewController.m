//
//  ViewController.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//


// Brief Description : Header file of View Controller, is the main menu and navigation controller of application that contains buttons to multiple games and options menu


#import "ViewController.h"
#import "GlobalVariables.h"
#import "DBManager.h"

@implementation ViewController
@synthesize countingStarsViewController,
    hardCountingViewController,
    fishToFishViewController,
    makingCentsViewController,
    optionsViewController,
    loginViewController,
    createAccountViewController;


-(IBAction)options_clicked:(id)sender
{
    if(!self.optionsViewController)
    {
        self.optionsViewController = [[OptionsViewController alloc] init];
    }
    [self.navigationController pushViewController:self.optionsViewController animated:YES];
}

-(IBAction)cstars_clicked:(id)sender
{
    
    if(optionsSingle.globalDifficultyLevel ==1)
    {
        if(!self.countingStarsViewController)
        {
            self.countingStarsViewController = [[CountingStarsViewController alloc] init];
        }
        [self.navigationController pushViewController:self.countingStarsViewController animated:YES] ;
    }
    else
    {
        if(!self.hardCountingViewController)
        {
            self.hardCountingViewController = [[HardCountingStarsViewController alloc] init];
        }
        [self.navigationController pushViewController:self.hardCountingViewController animated:YES];
    }
}
-(IBAction)fishtofish_clicked:(id)sender
{
    
    if(!self.fishToFishViewController)
    {
        self.fishToFishViewController = [[FishToFishViewController alloc] init];
    }
    [self.navigationController pushViewController:self.fishToFishViewController animated:YES];
}
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

@end
