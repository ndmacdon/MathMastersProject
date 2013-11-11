/****
 *
 * Filename:    SuperShopperViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Counting and magnitude relation game.
 *
 ****/

#import "SuperShopperViewController.h"


@implementation SuperShopperViewController {
    NSMutableArray *itemPictures;
    NSMutableArray *priceIndex;
    int currentIndex;
    int correctPrice;
    int incorrectPrice;
    int leftHandPrice;
    int rightHandPrice;
}
@synthesize currentItemDisplayed,
            rightButton,
            leftButton,
            resultLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize an index of prices and an array of corresponding objects:
    itemPictures = [[NSMutableArray alloc]init];
    priceIndex = [[NSMutableArray alloc] init];
    
    [itemPictures addObject:[UIImage imageNamed:@"chair.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:25]];
    
    [itemPictures addObject:[UIImage imageNamed:@"lollipop.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:1]];
    
    [itemPictures addObject:[UIImage imageNamed:@"computer.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:750]];
    
    [itemPictures addObject:[UIImage imageNamed:@"soccerball.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:20]];
    
    [itemPictures addObject:[UIImage imageNamed:@"basketball.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:20]];
    
    [itemPictures addObject:[UIImage imageNamed:@"pencil.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:1]];
    
    [itemPictures addObject:[UIImage imageNamed:@"car.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:4000]];
    
    [itemPictures addObject:[UIImage imageNamed:@"burger.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:3]];
    
    [itemPictures addObject:[UIImage imageNamed:@"fries.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:3]];
    
    [itemPictures addObject:[UIImage imageNamed:@"orange.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:1]];
    
    [itemPictures addObject:[UIImage imageNamed:@"shirt.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:20]];
    
    [itemPictures addObject:[UIImage imageNamed:@"apple.png"]];
    [priceIndex addObject:[NSNumber numberWithInt:1]];
}

-(void)viewWillAppear:(BOOL)animated {
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
    
    [self initializeGame]; // Setup the game for play...
}

// Check if the price of the clicked button is correct:
-(IBAction)price_button:(id)sender
{
    // Assign the chosen price to userAnswer:
    if (sender == leftButton) { self.userAnswer = leftHandPrice; }
    else {self.userAnswer = rightHandPrice; }
    
    // IF userAnswer matches the correct price:
    if (self.userAnswer == correctPrice) {
        
        resultLabel.text = [NSString stringWithFormat:@"You are Correct!"];
        [self inc_total_correct]; // add one to total correct and increase winStreak...
        
        // TODO: Reset for next round...
        
        // IF user completes enough rounds: Record Stats and end the game
        if(self.totalCorrect == sessionRounds) {
            [self endSession];
            
            // The sessionStatistics view will return to this line if the user selected retry...
        }
        else {
            [self next_item];
        }
        
    }
    else {
        resultLabel.text = [NSString stringWithFormat:@"Good Try ! Guess Again"];
        [self inc_total_incorrect]; // Increment total errors and reset winstreak...
    }
}

// Setup for a play session:
-(void)initializeGame {
    self.startTime = [NSDate date]; // Load the current time into startTime...
    [self next_item]; // Load a new set of images...
    [self resetStats];
}

// Load next item to be evaluated:
-(void)next_item {
    int previousIndex = currentIndex; // Store the last rounds previous index...
    
    // Ensure a new index is chosen:
    while (previousIndex == currentIndex) {
        currentIndex = arc4random() % itemPictures.count;
    }
    
    [currentItemDisplayed setImage:itemPictures[currentIndex]];
    [self set_prices];
    
    // Update the button labels with new prices:
    [leftButton setTitle:
        [NSString stringWithFormat:@"$%d", leftHandPrice]forState:UIControlStateNormal];
    [rightButton setTitle:
        [NSString stringWithFormat:@"$%d", rightHandPrice]forState:UIControlStateNormal];
}

// Update the prices to reflect the displayed item:
-(void)set_prices {
    BOOL leftIsCorrect = arc4random() % 2;      // Is the leftHandPrice correct?
    BOOL decreasePrice = arc4random() % 2;      // Will our price be increased or decreased?
    BOOL incorrectPriceIsHigher = arc4random() % 2; // Is the wrong price higher or lower?
    int modifier = [[priceIndex objectAtIndex:currentIndex] integerValue];
    
    // Set modifier to random value between 0 and 1/4 current price.
    // Very small prices will not be modified (because of integer rounding)
    // This is reasonable because inexpensive items should not have widly varying
    // prices. i.e. a pencil should never cost $5.
    modifier = (arc4random() % ((modifier / 4) + 1) + 1);
    
    
    // IF price is to be increased: negate the modifier.
    if (decreasePrice) { modifier *= -1; }
    
    correctPrice = [[priceIndex objectAtIndex:currentIndex] integerValue] + modifier;
    incorrectPrice = modifier;
    
    

    // IF corect price is small: ensure incorrect price is high.
    if (correctPrice < 15) {
        // Ensure possible correct prices:
        if (correctPrice < 1) { correctPrice = 1; }
        
        incorrectPrice = (30 + arc4random() % 100);
    }
    else if (incorrectPriceIsHigher) {
        incorrectPrice = correctPrice * incorrectPrice;
    }

    // IF leftHandPrice is the correct price:
    if (leftIsCorrect) {
        leftHandPrice = correctPrice;
        rightHandPrice = incorrectPrice;
    }
    else {
        leftHandPrice = incorrectPrice;
        rightHandPrice = correctPrice;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
