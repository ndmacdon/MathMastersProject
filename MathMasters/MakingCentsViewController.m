/****
 *
 * Filename:    MakingCentsViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: Nov 02, 2013
 *
 * Description: ViewController: Counting and magnitude relation which asks players to
 *                              make exact change according to a total.
 *
 ****/

#import "MakingCentsViewController.h"

@implementation MakingCentsViewController {
    NSInteger amountDisplayed;
    int maxAmount;
}
@synthesize instructionsUser,
            yellowBox,
            dime1,
            dime2,
            quarter1,
            quarter2,
            quarter3,
            nickel1,
            nickel2,
            dollar1;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    BOOL viewed = FALSE; // Has the current user ever viewed this tutorial?
    NSString *myName;
    
    // If difficulty is EASY:
    if(self.optionsSingle.globalDifficultyLevel ==1) {
        self.prepend = @"";
        maxAmount = 100;
        [dollar1 setHidden:TRUE];
    }
    else {
        self.prepend = @"Hard";
        [dollar1 setHidden:FALSE];
        maxAmount = 199;
    }
    
    myName = [NSString stringWithFormat:@"%@%@", self.prepend, NSStringFromClass([self class])];
    
    // Check if user has viewed this tutorial:
    viewed = [[DBManager getSharedInstance]hasCompletedTutorial:self.optionsSingle.currentUser tutorial:myName];
    
    // IF tutorial NOT viewed yet:
    if (!viewed) {
        // Mark this tutorial as completed for the current user:
        [[DBManager getSharedInstance]completeTutorial:self.optionsSingle.currentUser tutorial:myName];
        
        // Show the tutorial:
        [self tutorial_clicked:self];
    }
    
    [self initializeGame]; // Setup the game for play...
}


// Setup for a play session:
-(void)initializeGame {
    self.startTime = [NSDate date]; // Load the current time into startTime...
    self.userAnswer = 0;
    [self reset_coins];
    [self resetStats];
}

-(IBAction)dragged_out:(id)sender withEvent: (UIEvent *) event
{
    MyButtonMakingCents *selected = sender;
    selected.center = [[[event allTouches] anyObject] locationInView:self.view];
    
    // IF sender is in the yellow box: add the appropriate amount of change.
    if(CGRectContainsRect(yellowBox.frame, selected.frame) && !(selected.inYellowBox)) {
        if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Nickel.png"]]) {
            self.userAnswer += 5;
        }
        else if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Dime.png"]]) {
            self.userAnswer += 10;
        }
        else if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Quarter.png"]]) {
            self.userAnswer += 25;
        }
        else if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"dollar.png"]]) {
            self.userAnswer += 100;
        }
        selected.inYellowBox = true;
            
    }
    
    // IF sender is not in the box: remove the appropriate amount of change.
    if(!(CGRectContainsRect(yellowBox.frame, selected.frame)) && selected.inYellowBox)
    {
        if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Nickel.png"]]) {
            self.userAnswer -= 5;
        }
        else if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Dime.png"]]) {
            self.userAnswer -= 10;
        }
        else if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Quarter.png"]]) {
            self.userAnswer -= 25;
        }
        else if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"dollar.png"]]) {
            self.userAnswer -= 100;
        }
        
        selected.inYellowBox = false;
    }
}
// load taDA sound effect

// Check if the user has placed the correct change in the yellow box:
- (IBAction)check_user_correct:(id)sender {
    
        // IF the user has completed enough rounds:
        if(self.userAnswer == amountDisplayed) {
            [self play_done_sound];
            resultLabel.text = [NSString stringWithFormat:@"Correct!"];
            
            [self inc_total_correct]; // add one to total correct and increase the winStreak.
            
            // IF user completes 5 rounds: Record Stats and end the game
            if(self.totalCorrect == sessionRounds) {
                [self endSession];
                
                // The sessionStatistics view will return to this line if the user selected retry...
            }
            else {
                self.userAnswer = 0;
                [self reset_coins];
                
            }
        }
        // user Incorrect
        else
        {
            resultLabel.text = [NSString stringWithFormat:@" Try Again !"];
            [self inc_total_incorrect];
        }
    }

// Reset the screen to starting positions:
-(void)reset_coins
{
    [self set_instructions_user];
    dime1.inYellowBox = false;
    dime2.inYellowBox = false;
    nickel1.inYellowBox = false;
    nickel2.inYellowBox = false;
    quarter1.inYellowBox = false;
    quarter2.inYellowBox = false;
    quarter3.inYellowBox = false;
    dollar1.inYellowBox = false;
    dime1.frame = CGRectMake(358, 408, 60,60);
    dime2.frame = CGRectMake(358, 340, 60, 60);
    nickel1.frame = CGRectMake(260, 340, 90, 90);
    nickel2.frame = CGRectMake(162, 340, 90, 90);
    quarter1.frame = CGRectMake(34, 340, 120, 120);
    quarter2.frame = CGRectMake(182, 183, 120, 120);
    quarter3.frame = CGRectMake(310, 183, 120, 120);
    dollar1.frame = CGRectMake(34, 183, 140, 140);
}

-(void)set_instructions_user {
    int random_Value = arc4random() % (maxAmount / 5) + 1;  // 1 - 20
    amountDisplayed = random_Value * 5;  // Ensure total is divisible by 5.
    instructionsUser.text = [NSString stringWithFormat:@"Put %d cents in the red box and press done", amountDisplayed];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
