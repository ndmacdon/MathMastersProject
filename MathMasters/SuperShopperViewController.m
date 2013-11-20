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
 * VersionDate: October 30, 2013
 *
 * Description: ViewController: Counting and magnitude relation game which asks players
 *                              to estimate the price of an item.
 *
 ****/

#import "SuperShopperViewController.h"


@implementation SuperShopperViewController {
    NSMutableArray *itemPictures;
    NSMutableArray *lowPriceIndex;
    NSMutableArray *highPriceIndex;
    NSMutableArray *priceChoices;
    int currentIndex;
    int correctPrice;
}
@synthesize currentItemDisplayed,
            rightButton,
            centreButton,
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
    highPriceIndex = [[NSMutableArray alloc] init];
    lowPriceIndex = [[NSMutableArray alloc] init];
    priceChoices = [[NSMutableArray alloc] init];
    
    [priceChoices addObject:[NSNumber numberWithInt:0]];
    [priceChoices addObject:[NSNumber numberWithInt:0]];
    [priceChoices addObject:[NSNumber numberWithInt:0]];
    
    [itemPictures addObject:[UIImage imageNamed:@"chair.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:20]];
    [highPriceIndex addObject:[NSNumber numberWithInt:50]];
    
    [itemPictures addObject:[UIImage imageNamed:@"lollipop.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:1]];
    [highPriceIndex addObject:[NSNumber numberWithInt:5]];
    
    [itemPictures addObject:[UIImage imageNamed:@"computer.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:500]];
    [highPriceIndex addObject:[NSNumber numberWithInt:2000]];
    
    [itemPictures addObject:[UIImage imageNamed:@"soccerball.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:10]];
    [highPriceIndex addObject:[NSNumber numberWithInt:50]];
    
    [itemPictures addObject:[UIImage imageNamed:@"basketball.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:10]];
    [highPriceIndex addObject:[NSNumber numberWithInt:50]];
    
    [itemPictures addObject:[UIImage imageNamed:@"pencil.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:1]];
    [highPriceIndex addObject:[NSNumber numberWithInt:3]];
    
    [itemPictures addObject:[UIImage imageNamed:@"car.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:1000]];
    [highPriceIndex addObject:[NSNumber numberWithInt:50000]];
    
    [itemPictures addObject:[UIImage imageNamed:@"burger.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:2]];
    [highPriceIndex addObject:[NSNumber numberWithInt:8]];
    
    [itemPictures addObject:[UIImage imageNamed:@"fries.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:2]];
    [highPriceIndex addObject:[NSNumber numberWithInt:5]];
    
    [itemPictures addObject:[UIImage imageNamed:@"orange.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:1]];
    [highPriceIndex addObject:[NSNumber numberWithInt:3]];
    
    [itemPictures addObject:[UIImage imageNamed:@"shirt.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:15]];
    [highPriceIndex addObject:[NSNumber numberWithInt:40]];
    
    [itemPictures addObject:[UIImage imageNamed:@"apple.png"]];
    [lowPriceIndex addObject:[NSNumber numberWithInt:1]];
    [highPriceIndex addObject:[NSNumber numberWithInt:4]];
}

-(void)viewWillAppear:(BOOL)animated {
    BOOL viewed = FALSE; // Has the current user ever viewed this tutorial?
    NSString *myName;
    
    // If difficulty is Normal: add a prefix to our classname.
    if(self.optionsSingle.globalDifficultyLevel == 1) {
        self.prepend = @"";
        [centreButton setHidden:TRUE];
        [centreButton setEnabled:FALSE];
    }
    else {
        self.prepend = @"Hard";
        //[centreButton setEnabled:FALSE];
        
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

// Check if the price of the clicked button is correct:
-(IBAction)price_button:(id)sender
{
    // Assign the chosen price to userAnswer:
    if (sender == leftButton) {
        self.userAnswer = [[priceChoices objectAtIndex:0] intValue];
    }
    else if (sender == centreButton) {
        self.userAnswer = [[priceChoices objectAtIndex:1] intValue];
    }
    else if (sender == rightButton) {
        self.userAnswer = [[priceChoices objectAtIndex:2] intValue];
    }
    
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
     [NSString stringWithFormat:@"$%d", [[priceChoices objectAtIndex:0] intValue]] forState:UIControlStateNormal];
    
    [centreButton setTitle:
     [NSString stringWithFormat:@"$%d", [[priceChoices objectAtIndex:1] intValue]] forState:UIControlStateNormal];
    
    [rightButton setTitle:
        [NSString stringWithFormat:@"$%d", [[priceChoices objectAtIndex:2] intValue]] forState:UIControlStateNormal];
}

// Update the prices to reflect the displayed item:
-(void)set_prices {
    int correctPriceLocation = arc4random() % 3;    // 0=>LeftHand 1=>Centre 2=>RightHand
    int fakePriceOneLocation = arc4random() % 3;   // 0=> lowest possible label
    NSNumber *fakePriceOne = 0;                     // An incorrect price.
    NSNumber *fakePriceTwo = 0;                     // Another incorrect price.
    int currentLow = [[lowPriceIndex objectAtIndex:currentIndex] integerValue];
    int currentHigh = [[highPriceIndex objectAtIndex:currentIndex] integerValue];
    correctPrice = currentLow + arc4random() % (currentHigh - currentLow); // Set newPrice between high and low
    
    // IF centreButton is disabled: don't put the correct price there...
    if (!centreButton.enabled && correctPriceLocation == 1) {
        
        // WHILE correctPriceLocation is centre, randomize correct price location...
        while (correctPriceLocation == 1) {
            correctPriceLocation = arc4random() % 3;
        }
    }
    
    // Ensure our first fake price does not overwrite the correct one:
    while (fakePriceOneLocation == correctPriceLocation) {
        fakePriceOneLocation = arc4random() % 3;
    }
    
    // IF corect price is small: ensure incorrect price is high.
    if (currentLow < 20) {
        fakePriceOne = [NSNumber numberWithInt:(currentHigh * 2 + arc4random() % 100)];
        fakePriceTwo = [NSNumber numberWithInt:(currentHigh * 2 + arc4random() % 100)];
    }
    else {
        fakePriceOne = [NSNumber numberWithInt:(currentHigh * 2 + arc4random() % currentHigh)];
        fakePriceTwo = [NSNumber numberWithInt:(arc4random() % (currentLow / 2) ) ];
    }
    
    // Set the priceChoices according to the randomized locations of correct and incorrect prices:
    for (int i = 0; i < priceChoices.count; i++) {
        if (i == correctPriceLocation) {
            [priceChoices setObject:[NSNumber numberWithInt:correctPrice] atIndexedSubscript:i];
        }
        else if (i == fakePriceOneLocation) {
            [priceChoices setObject:fakePriceOne atIndexedSubscript:i];
        }
        else {
            [priceChoices setObject:fakePriceTwo atIndexedSubscript:i];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
