//
//  ViewController.m
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-06.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "ViewController.h"
#import "GlobalVariables.h"

@implementation ViewController
@synthesize countingStarsViewController, hardCountingViewController,fishtoFishViewController, makingCentsViewController, optionsViewController;


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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
