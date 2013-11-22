/****
 *
 * Filename:    FishToFishViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: November 02, 2013
 *
 * Description: ViewController: Magnitude estimation game which asks users to pick the largest group.
 *
 ****/

// Things to do for normal and hard version .... Tutorial screen

#import "FishToFishViewController.h"


@implementation FishToFishViewController {
    NSInteger leftSize, rightSize, bottomSize; // Magnitude of the 3 groups of items.
    NSMutableArray *groupImageX; // X dimension of 2D image-name-array.
    int maxGroupSize;
}
@synthesize displayUserCorrect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    BOOL viewed = FALSE; // Has the current user ever viewed this tutorial?
    NSString *myName;
    
    // If difficulty is Normal:
    if(self.optionsSingle.globalDifficultyLevel == 1) {
        self.prepend = @"";
        [bottomGroup setHidden:TRUE]; // Hide the bottom group selector...
        maxGroupSize = 10; // Set the maximum magnitude of a group...
    }
    else {
        self.prepend = @"Hard";
        maxGroupSize = 15;
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

    
    [self initializeGame]; // Setup the game for play..
    [self load_pictures]; // Load the first set of groups...
}


-(IBAction)group_button_clicked:(id)sender
{
    
    // Set userAnswer to the selectedGroup's size:
    if (sender == leftGroup) { self.userAnswer = leftSize; }
    else if (sender == rightGroup) { self.userAnswer = rightSize; }
    else { self.userAnswer = bottomSize; }
    
    // IF userAnswer is the largest value of the three groups:
    if (self.userAnswer >= rightSize && self.userAnswer >= leftSize && self.userAnswer >= bottomSize) {
        
        [self play_done_sound];
        displayUserCorrect.text = [NSString stringWithFormat:@"You are Correct!"];
        [self inc_total_correct]; // add one to total correct and increase winStreak...
        
        // IF user completes 5 rounds: Record Stats and end the game
        if(self.totalCorrect == sessionRounds) {
            [self endSession];
            
            // The sessionStatistics view will return to this line if the user selected retry...
        }
        else {
            [self load_pictures];
        }

    }
    else {
        displayUserCorrect.text = [NSString stringWithFormat:@"Good Try ! Guess Again"];
        [self inc_total_incorrect]; // Increment total errors and reset winstreak...
    }
}

// Setup for a play session:
-(void)initializeGame {
    self.startTime = [NSDate date]; // Load the current time into startTime...
    [self load_pictures]; // Load a new set of images...
    [self resetStats];
}

-(void)load_pictures {
    // Type of object for each group (apple, fish, numeral etc):
    int leftObjectType = arc4random() %4;
    int rightObjectType = arc4random() %4;
    int bottomObjectType = arc4random() %4;
    
    NSString *nextImageName = NULL; // Name of the next image for a button.
    UIImage *nextImage = NULL;      // Next image for a button
    
    // Randomize the group sizes:
    leftSize = arc4random() % maxGroupSize;
    rightSize = arc4random() % maxGroupSize;
    bottomSize = arc4random() % maxGroupSize;
    
    // Ensure leftPicture != rightPicture:
    while(leftSize == rightSize) {
        rightSize = arc4random() % maxGroupSize;
    }
    
    // Ensure bottomPicture != left OR rightPicture:
    while (bottomSize == leftSize || bottomSize == rightSize) {
        bottomSize = arc4random() % maxGroupSize;
    }
    
    // Load the three images according to their randomized type and size:
    // Left Image:
    nextImageName = [[groupImageX objectAtIndex:leftObjectType] objectAtIndex:leftSize];
    nextImage = [UIImage imageNamed:nextImageName];
    [leftGroup setBackgroundImage:nextImage forState:UIControlStateNormal];
    
    // Right Image:
    nextImageName = [[groupImageX objectAtIndex:rightObjectType] objectAtIndex:rightSize];
    nextImage = [UIImage imageNamed:nextImageName];
    [rightGroup setBackgroundImage:nextImage forState:UIControlStateNormal];
    
    // Bottom Image
    nextImageName = [[groupImageX objectAtIndex:bottomObjectType] objectAtIndex:bottomSize];
    nextImage = [UIImage imageNamed:nextImageName];
    [bottomGroup setBackgroundImage:nextImage forState:UIControlStateNormal];
    
    // IF difficulty is normal: ensure bottomSize is smaller than other groups.
    if (self.optionsSingle.globalDifficultyLevel == 1) {
        bottomSize = -1;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize a 2D array of image objects:
    groupImageX = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        NSMutableArray *groupImageY = [[NSMutableArray alloc] init];
        [groupImageX addObject:groupImageY];
    }
    
    // Load all image names into a 2D NSString array:
    [[groupImageX objectAtIndex:0] addObject:@"fish1.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish2.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish3.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish4.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish5.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish6.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish7.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish8.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish9.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish10.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish11.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish12.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish13.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish14.png"];
    [[groupImageX objectAtIndex:0] addObject:@"fish15.png"];
    
    
    [[groupImageX objectAtIndex:1] addObject:@"apple1.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple2.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple3.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple4.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple5.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple6.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple7.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple8.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple9.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple10.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple11.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple12.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple13.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple14.png"];
    [[groupImageX objectAtIndex:1] addObject:@"apple15.png"];

    [[groupImageX objectAtIndex:2] addObject:@"orange1.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange2.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange3.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange4.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange5.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange6.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange7.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange8.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange9.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange10.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange11.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange12.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange13.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange14.png"];
    [[groupImageX objectAtIndex:2] addObject:@"orange15.png"];
    
    
    [[groupImageX objectAtIndex:3] addObject:@"1.png"];
    [[groupImageX objectAtIndex:3] addObject:@"2.png"];
    [[groupImageX objectAtIndex:3] addObject:@"3.png"];
    [[groupImageX objectAtIndex:3] addObject:@"4.png"];
    [[groupImageX objectAtIndex:3] addObject:@"5.png"];
    [[groupImageX objectAtIndex:3] addObject:@"6.png"];
    [[groupImageX objectAtIndex:3] addObject:@"7.png"];
    [[groupImageX objectAtIndex:3] addObject:@"8.png"];
    [[groupImageX objectAtIndex:3] addObject:@"9.png"];
    [[groupImageX objectAtIndex:3] addObject:@"10.png"];
    [[groupImageX objectAtIndex:3] addObject:@"11.png"];
    [[groupImageX objectAtIndex:3] addObject:@"12.png"];
    [[groupImageX objectAtIndex:3] addObject:@"13.png"];
    [[groupImageX objectAtIndex:3] addObject:@"14.png"];
    [[groupImageX objectAtIndex:3] addObject:@"15.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
