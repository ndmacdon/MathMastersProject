//
//  ViewController.m
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-06.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "ViewController.h"
#import "GlobalVariables.h"
#import "DBManager.h"

@implementation ViewController
@synthesize countingStarsViewController,
    hardCountingViewController,
    fishtoFishViewController,
    makingCentsViewController,
    optionsViewController,
    loginViewController,
    createAccountViewController;


-(IBAction)options_Clicked:(id)sender
{
    if(!self.optionsViewController)
    {
        self.optionsViewController = [[OptionsViewController alloc] init];
    }
    [self.navigationController pushViewController:self.optionsViewController animated:YES];
}

-(IBAction)cstars_Clicked:(id)sender
{
    if(optionsSingle.global_difficulty_Level ==1)
    {
        if(!self.countingStarsViewController) // if not created already ...create it
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
-(IBAction)fishtoFish_Clicked:(id)sender
{
    
    if(!self.fishtoFishViewController)
    {
        self.fishtoFishViewController = [[FishToFishViewController alloc] init];
    }
    [self.navigationController pushViewController:self.fishtoFishViewController animated:YES];
}
-(IBAction)makingCents_Clicked:(id)sender
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
    optionsSingle.global_difficulty_Level = 1;
    
	// self.difficulty_Level = [NSNumber numberWithInt:1]; // set to default difficulty of normal(1)
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
    // Dispose of any resources that can be recreated.
}

@end









