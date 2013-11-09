//
//  ClockWorkViewController.m
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-08.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "ClockWorkViewController.h"

@interface ClockWorkViewController ()

@end

@implementation ClockWorkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    BOOL viewed = FALSE; // Has the current user ever viewed this tutorial?
    
    // Check if user has viewed this tutorial:
    viewed = [[DBManager getSharedInstance]hasCompletedTutorial:self.optionsSingle.currentUser tutorial:NSStringFromClass([self class])];
    
    // IF tutorial NOT viewed yet:
    if (!viewed) {
        // Mark this tutorial as completed for the current user:
        [[DBManager getSharedInstance]completeTutorial:self.optionsSingle.currentUser tutorial:NSStringFromClass([self class])];
        
        // Show the tutorial:
        //self.tutorialCountingStarsViewController = [[TutorialCountingStarsViewController alloc] init];
        //[self.navigationController pushViewController:self.tutorialCountingStarsViewController animated:YES];
        
    }
    // If difficulty is EASY:
    if(self.optionsSingle.globalDifficultyLevel ==1) {
        self.prepend = @"";
    }
    else {
        self.prepend = @"Hard";
    }

    
    //[self initializeGame]; // Setup the game for play...
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    hourHand.alpha = 0;
    minuteHand.alpha = 0;
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkAnswer:(id)sender {
    // IF the user has completed enough rounds:
    if(self.userAnswer == 100000000)
    {
        resultLabel.text = [NSString stringWithFormat:@"Correct!"];
        [self incWinStreak]; // Increment the winStreak
        [self add_total_correct]; // add one to total correct
        
        
        self.userAnswer = 0;
        
        // IF user completes 5 rounds: Record Stats and end the game
        if(self.totalCorrect == 5)
        {
            [self endSession];
            
            // The sessionStatistics view will return to this line if the user selected retry...
            
            //[self initializeGame]; // Reset the game for another session...
        }
    }
    else  // user Incorrect
    {
        resultLabel.text = [NSString stringWithFormat:@" Try Again !"];
    }
}
    
    // Setup for a play session:
    -(void)initializeGame {
        self.startTime = [NSDate date]; // Load the current time into startTime...
        [self resetStats];
    }
    
    // Launch this game's tutorial:
    -(IBAction)normal_tutorial_clicked:(id)sender
    {
        //self.tutorialCountingStarsViewController = [[TutorialCountingStarsViewController alloc]init];
        //[self.navigationController pushViewController:self.tutorialCountingStarsViewController animated:YES];
    }

@end




