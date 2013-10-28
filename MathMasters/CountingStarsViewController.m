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

@implementation CountingStarsViewController
@synthesize starsUserMustCount, randomInteger, totalGuessed, totalCorrect,displayUserCorrect;
@synthesize btnImage,tutorialCountingStarsViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.tutorialCountingStarsViewController = [[TutorialCountingStarsViewController alloc] init];
    [self.navigationController pushViewController:self.tutorialCountingStarsViewController animated:YES];
}

// Before showing interface to user: initialize some values
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    randomInteger = arc4random() % 10 + 1 ;   // equals a random integer from 1 - 10
    starsUserMustCount.text =[NSString stringWithFormat:@"Count %d Stars", randomInteger];  // display how many stars user must count
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Hi, memory error");
}

// IF user clicks done: check correctness
-(IBAction)is_user_correct:(id)sender
{
    if(totalGuessed == randomInteger) 
    {
        displayUserCorrect.text = [NSString stringWithFormat:@"Correct !!!"];
        
        NSInteger randomTemp = arc4random() % 10 + 1 ;   
        randomInteger = randomTemp;
        starsUserMustCount.text =[NSString stringWithFormat:@"Count %d Stars", randomInteger]; // generate new value if user is correct
        
    }
    else  // user Incorrect
    {
        displayUserCorrect.text = [NSString stringWithFormat:@" Try Again !"];
    }
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
