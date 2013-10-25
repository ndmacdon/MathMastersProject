//
//  OptionsViewController.m
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-24.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "OptionsViewController.h"

#import "GlobalVariables.h"


@implementation OptionsViewController
@synthesize changeDifficultyButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)change_Difficulty:(id)sender
{
    if([[changeDifficultyButton titleForState:UIControlStateNormal] isEqual:@"Normal"])
    {
        [changeDifficultyButton setTitle:@"Hard" forState:UIControlStateNormal];
        optionsSingle = [GlobalVariables singleObj];
        optionsSingle.global_difficulty_Level = 2;
        //difficulty_Level = [NSNumber numberWithInt:2]; // changing the difficulty to hard (2)
    }
    else
    {
        [changeDifficultyButton setTitle:@"Normal" forState:UIControlStateNormal];
        optionsSingle = [GlobalVariables singleObj];
        optionsSingle.global_difficulty_Level = 1;
        //difficulty_Level =[NSNumber numberWithInt:1]; // changing the difficulty to normal (1)
    }
    
    
    
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
