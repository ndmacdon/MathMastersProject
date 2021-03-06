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
 * VersionDate: Oct 29, 2013
 *
 * Description: ViewController: Normal Version of Counting Stars Game.
 *
 ****/

#import "CountingStarsViewController.h"

@implementation CountingStarsViewController{
    UIImage *emptyStarImage;
    UIImage *fullStarImage;
    NSMutableArray *starButtons;
        UIImage *btnImage;
    int randomInteger;
    int maxStars;
    int maxStarSum;
    int starValue;
}

@synthesize starsUserMustCount,
            displayUserCorrect,
            sessionStatisticsViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    BOOL viewed = FALSE; // Has the current user ever viewed this tutorial?
    NSString *myName;
    
    // If difficulty is Normal:
    if(self.optionsSingle.globalDifficultyLevel ==1) {
        maxStars = 10;
        maxStarSum = 10;
        starValue = 1;
        emptyStarImage = [UIImage imageNamed:@"whiteStar.png"];
        fullStarImage = [UIImage imageNamed:@"yellowStar.png"];
        self.prepend = @"";
    }
     //ELSE Difficulty is hard:
    else {
        maxStars = 6;
        maxStarSum = 18;
        starValue = 3;
        emptyStarImage = [UIImage imageNamed:@"threeStarsWhite.png"];
        fullStarImage = [UIImage imageNamed:@"threeStarsColor.png"];
        self.prepend = @"Hard";
     
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
    
    [self nextRandomStars];
    
    [self initializeGame]; // Setup the game for play...
}

// Before showing interface to user: initialize some values
- (void)viewDidLoad {
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
    if(self.userAnswer == randomInteger)
    {
        
        [self play_done_sound];
        displayUserCorrect.text = [NSString stringWithFormat:@"Correct!"];

        [self inc_total_correct]; // add one to total correct and increase the winStreak.
        

        
        // IF user completes 5 rounds: Record Stats and end the game
        if(self.totalCorrect == sessionRounds)
        {
            [self endSession];
            
            // The sessionStatistics view will return to this line if the user selected retry...
        }
        else {
            self.userAnswer = 0;
            [self nextRandomStars]; // Generate the next sum and clear the stars...
        }
    }
    else  // user Incorrect
    {
        displayUserCorrect.text = [NSString stringWithFormat:@" Try Again !"];
        [self inc_total_incorrect];
    }
}

// Setup for a play session:
-(void)initializeGame {
    self.startTime = [NSDate date]; // Load the current time into startTime...
    self.userAnswer = 0;
    [self nextRandomStars];
    [self resetStats];
}

// Reset the random number of Stars to be counted
-(void)nextRandomStars {
    BOOL validTotal = FALSE;
    NSInteger oldTotal = randomInteger; // Save the old total.
    
    [[starMat subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < maxStars; i++) {
        [self add_StarAt:[self getEmptyRegion]];
    }
    
    while (!validTotal) {
        randomInteger = arc4random() % maxStarSum + 1 ;   // equals a random integer from 1 - 10
        
        if (randomInteger == oldTotal || randomInteger % starValue != 0) {
            validTotal = FALSE;
        }
        else {
            validTotal = TRUE;
        }
    }
    
    // Clear the stars:
    for (UIButton *cur in [starMat subviews]) {
        [cur setImage:emptyStarImage forState:UIControlStateNormal];
    }
    
    // Account for a single star:
    if (randomInteger == 1) {
        starsUserMustCount.text =
        [NSString stringWithFormat:@"Count %d Star", randomInteger];  // display how many stars user must count
    }
    else {
        starsUserMustCount.text =
        [NSString stringWithFormat:@"Count %d Stars", randomInteger];  // display how many stars user must count
    }
}

// If the device rotates: reset the stars so they conform to the new bounding box.
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self nextRandomStars];
}

// Find an empty region to place a star into:
-(CGPoint)getEmptyRegion {
    BOOL regionEmpty = FALSE;   // Is the region around chosenSpot empty?
    int failSafe = 99;          // How many times do we try to find a spot before giving up?
    CGPoint chosenSpot;         // Spot in an empty region.
    
    while (!regionEmpty && failSafe > 0) {
        regionEmpty = TRUE;
        failSafe--;
        
        // Get a random point inside our starMat:
        chosenSpot.x = arc4random() % ((int)starMat.frame.size.width - 100);
        chosenSpot.y = arc4random() % ((int)starMat.frame.size.height - 150);
        
        // Check for interfering objects
        for (UIButton *cur in [starMat subviews]) {
            if (sqrtf(powf(cur.frame.origin.x - chosenSpot.x, 2)) < 100 &&
                sqrtf(powf(cur.frame.origin.y - chosenSpot.y, 2)) < 100 ) {
                regionEmpty = FALSE;
            }
        }
    }
    return chosenSpot;
}

-(void)add_StarAt:(CGPoint)starSpot {
    UIButton *starButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [starButton addTarget:self
               action:@selector(star_clicked:)
     forControlEvents:UIControlEventTouchDown];
    
    [starButton setImage:emptyStarImage forState:UIControlStateNormal];
    starButton.frame = CGRectMake(starSpot.x, starSpot.y, 100.0, 100.0);

    
    [starMat addSubview:starButton];
}


// plays star sound effect when you click or unclick star
-(void)play_star_sound
{
    
    NSString * star_effect = [[NSBundle mainBundle]pathForResource:@"star_click" ofType:@"mp3"];
    self.optionsSingle.soundEffectsPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:star_effect] error:NULL];
    self.optionsSingle.soundEffectsPlayer.numberOfLoops = 0;
    [self.optionsSingle.soundEffectsPlayer setVolume:self.optionsSingle.soundeffectVolumeControl];
    [self.optionsSingle.soundEffectsPlayer play];
    
}

// IF user clicks stars buttons on interface, will change image depending on current image
-(IBAction)star_clicked:(id)sender  
{
     
    [self play_star_sound];  // set and play star sound effect audio player
    
        // IF star button clicked is currently a yellow star
    if([[sender imageForState:UIControlStateNormal] isEqual:fullStarImage])
    {
        self.userAnswer -= starValue;
        //[self subtract_total_guessed];  // decrement totalGuessed by 1
        [sender setImage:emptyStarImage forState:UIControlStateNormal];  // set button to white star
    }
    else  // ELSE star button clicked is currently a white star
    {
        self.userAnswer += starValue;
        //[self add_total_guessed];  // increment totalGuessed by 1
        [sender setImage:fullStarImage forState:UIControlStateNormal];  // set button to yellow star
    }
}

@end
