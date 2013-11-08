//
//  GameViewController.m
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-07.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController {

}

@synthesize totalCorrect,
    totalIncorrect,
    highestNumber,
    consecutiveWins,
    winStreak,
    optionsSingle,
    prepend,
    startTime,
    endTime,
    runningTime;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.optionsSingle = [GlobalVariables singleObj]; // Grab the global options handle...
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// End the current session and load the Session Statistics Screen:
-(void)endSession {
    
    [self logStats]; // Log the stats for this session...
    
    // Initialize the sessionStatisticsViewController and pop it onto the Navigation Stack:
    self.sessionStatisticsViewController = [[SessionStatisticsViewController alloc] init];
    self.sessionStatisticsViewController.completionTime = self.runningTime;
    [self.navigationController pushViewController:self.sessionStatisticsViewController animated:TRUE];
}

// Increase the current streak:
-(void)incWinStreak {
    self.winStreak++;
    
    // IF winStreak is the longest set of consecutiveWins:
    if (self.winStreak > self.consecutiveWins) {
        self.consecutiveWins = self.winStreak;
    }
    
    // IF guessed is the highest encountered number:
    if (self.userAnswer > self.highestNumber) {
        self.highestNumber = self.userAnswer;
    }
}

// Break the current winStreak:
-(void)breakWinStreak {
    self.totalIncorrect++;
    self.winStreak = 0; // Reset the current winStreak...
}

// Reset the stored statistics for a new session:
-(void)resetStats {
    totalCorrect = 0;
    totalIncorrect = 0;
    highestNumber = 0;
    winStreak = 0;
    consecutiveWins = 0;
}

// Log the statistics for current session:
-(void)logStats {
    self.endTime = [NSDate date]; // Load current time into endTime...
    runningTime = [endTime timeIntervalSinceDate:startTime]; // Calculate the difference in seconds...
    
    // Log the session results:
    [[DBManager getSharedInstance] logStatsFor:
     [NSString stringWithFormat:@"%@%@", prepend, NSStringFromClass([self class])]
                                      withDate:startTime
                                      withUser:optionsSingle.currentUser
                                 sessionLength:runningTime
                               consecutiveWins:consecutiveWins
                                          wins:totalCorrect
                                        losses:totalIncorrect
                                       highest:highestNumber];
}

// Increment totalCorrect:
-(void)add_total_correct { totalCorrect++; }

@end
