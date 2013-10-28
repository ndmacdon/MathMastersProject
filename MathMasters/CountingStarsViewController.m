//
//  CountingStarsViewController.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//

//  Brief Description: Implementation file of Normal Version of Counting Stars game

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

- (void)viewDidLoad   // Before showing interface to user initialize some values
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


-(IBAction)is_user_correct:(id)sender   // if user clicks done button, will determine if user is correct or wrong
{
    if(totalGuessed == randomInteger) 
    {
        displayUserCorrect.text = [NSString stringWithFormat:@"Correct !!!"];
        
        NSInteger randomTemp = arc4random() % 10 + 1 ;   
        randomInteger = randomTemp;
        starsUserMustCount.text =[NSString stringWithFormat:@"Count %d Stars", randomInteger]; // generate new value if user is correct
        
    }
    else  // user is wrong
    {
        displayUserCorrect.text = [NSString stringWithFormat:@" Try Again !"];
    }
}

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


// if user clicks stars buttons on interface, will change image depending on current image
-(IBAction)star_clicked:(id)sender  
{
    // if star button clicked is currently a yellow star
    if([[sender backgroundImageForState:UIControlStateNormal] isEqual: [UIImage  imageNamed:@"yellowStar.png"]]) 
    {
        [self subtract_total_guessed];  // decrement totalGuessed by 1
        btnImage = [UIImage imageNamed:@"whiteStar.png"];   // set btnImage to white star
        [sender setBackgroundImage:btnImage forState:UIControlStateNormal];  // set button to white star
    }
    else  // if star button clicked is currently a white star
    {
        [self add_total_guessed];  // increment totalGuessed by 1
        btnImage = [UIImage imageNamed:@"yellowStar.png"];  // set btnImage to yellow star
        [sender setBackgroundImage:btnImage forState:UIControlStateNormal];  // set button to yellow star
    }
}

@end
