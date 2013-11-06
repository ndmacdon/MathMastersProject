/****
 *
 * Filename:    CountingStarsViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Normal Version of Counting Stars Game.
 *
 ****/

#import "CountingStarsViewController.h"

@implementation CountingStarsViewController{
    NSDate *endTime;
    NSDate *startTime;
    NSInteger totalIncorrect;
    NSInteger highestNumber;
    NSInteger consecutiveWins;
    NSInteger winStreak;
    NSInteger randomInteger;
    NSInteger totalGuessed;
    NSInteger totalCorrect;
}

@synthesize starsUserMustCount, randomInteger, totalGuessed, totalCorrect, displayUserCorrect;
@synthesize btnImage,tutorialCountingStarsViewController, sessionStatisticsViewController;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    BOOL viewed = FALSE; // Has the current user ever viewed this tutorial?
    optionsSingle = [GlobalVariables singleObj]; // Grab the global options handle...

    
    // Check if user has viewed this tutorial:
    viewed = [[DBManager getSharedInstance]hasCompletedTutorial:optionsSingle.currentUser tutorial:NSStringFromClass([self class])];
    
    // IF tutorial NOT viewed yet:
    if (!viewed) {
        // Mark this tutorial as completed for the current user:
        [[DBManager getSharedInstance]completeTutorial:optionsSingle.currentUser tutorial:NSStringFromClass([self class])];
        
        // Show the tutorial:
        self.tutorialCountingStarsViewController = [[TutorialCountingStarsViewController alloc] init];
        [self.navigationController pushViewController:self.tutorialCountingStarsViewController animated:YES];
        
    }
    
    [self initializeGame]; // Setup the game for play...
}

// Before showing interface to user: initialize some values
- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Memory error logged");
}

// IF user clicks done: check correctness
-(IBAction)is_user_correct:(id)sender
{

    
    // IF the user has completed enough rounds:
    if(totalGuessed == randomInteger) 
    {
        winStreak++; // Increase the current streak...
        
        // IF winStreak is the longest set of consecutiveWins:
        if (winStreak > consecutiveWins) {
            consecutiveWins = winStreak;
        }
        
        // IF guessed is the highest encountered number:
        if (totalGuessed > highestNumber) {
            highestNumber = totalGuessed;
        }
        
        displayUserCorrect.text = [NSString stringWithFormat:@"Correct!"];
        
        NSInteger randomTemp = arc4random() % 10 + 1 ;   
        randomInteger = randomTemp;
        starsUserMustCount.text =[NSString stringWithFormat:@"Count %d Stars", randomInteger]; // generate new value if user is correct
        
        
        [self add_total_correct]; // add one to add_total_correct
        
        // IF user completes 5 rounds: Record Stats and end the game
        if(self.totalCorrect == 5)
        {
            [self endSession];
            
            // The sessionStatistics view will return to this line if the user selected retry...
            
            [self initializeGame]; // Reset the game for another session...
        }
        
    }
    else  // user Incorrect
    {
        displayUserCorrect.text = [NSString stringWithFormat:@" Try Again !"];
        
        totalIncorrect++;
        winStreak = 0; // Reset the current winStreak...
    }
}

// Setup for a play session:
-(void)initializeGame {
    startTime = [NSDate date]; // Load the current time into startTime...
    randomInteger = arc4random() % 10 + 1 ;   // equals a random integer from 1 - 10
    starsUserMustCount.text =[NSString stringWithFormat:@"Count %d Stars", randomInteger];  // display how many stars user must count
    totalCorrect = 0;
    totalIncorrect = 0;
    highestNumber = 0;
    winStreak = 0;
    consecutiveWins = 0;
    
    
}

// End the current session and load the Session Statistics Screen:
-(void)endSession {
    endTime = [NSDate date]; // Load current time into endTime...
    NSInteger runningTime = [endTime timeIntervalSinceDate:startTime]; // Calculate the difference in seconds...
    
    // Log the session results:
    [[DBManager getSharedInstance] logStatsFor:NSStringFromClass([self class])
                                      withDate:startTime
                                      withUser:optionsSingle.currentUser
                                 sessionLength:runningTime
                               consecutiveWins:consecutiveWins
                                          wins:totalCorrect
                                        losses:totalIncorrect
                                       highest:highestNumber];
    
    // Initialize the sessionStatisticsViewController and pop it onto the Navigation Stack:
    self.sessionStatisticsViewController = [[SessionStatisticsViewController alloc] init];
    self.sessionStatisticsViewController.completionTime = runningTime;
    [self.navigationController pushViewController:self.sessionStatisticsViewController animated:TRUE];
}


// Launch this game's tutorial:
-(IBAction)normal_tutorial_clicked:(id)sender
{
    self.tutorialCountingStarsViewController = [[TutorialCountingStarsViewController alloc]init];
    [self.navigationController pushViewController:self.tutorialCountingStarsViewController animated:YES];
}

-(void)add_total_guessed  // increment totalGuessed by 1
{
    totalGuessed++;
}

-(void)subtract_total_guessed  // decrement totalGuessed by 1
{
    totalGuessed--;
}

-(void)add_total_correct  // increment totalCorrect by 1
{
    totalCorrect++;
}


// IF user clicks stars buttons on interface, will change image depending on current image
-(IBAction)star_clicked:(id)sender  
{
    // IF star button clicked is currently a yellow star
    if([[sender backgroundImageForState:UIControlStateNormal] isEqual: [UIImage  imageNamed:@"yellowStar.png"]]) 
    {
        [self subtract_total_guessed];  // decrement totalGuessed by 1
        btnImage = [UIImage imageNamed:@"whiteStar.png"];   // set btnImage to white star
        [sender setBackgroundImage:btnImage forState:UIControlStateNormal];  // set button to white star
    }
    else  // ELSE star button clicked is currently a white star
    {
        [self add_total_guessed];  // increment totalGuessed by 1
        btnImage = [UIImage imageNamed:@"yellowStar.png"];  // set btnImage to yellow star
        [sender setBackgroundImage:btnImage forState:UIControlStateNormal];  // set button to yellow star
    }
}

@end
