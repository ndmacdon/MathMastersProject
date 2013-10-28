/****
 *
 * Filename:    HardCountingStarsViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Hard Version of Counting Stars Game.
 *
 ****/

#import "HardCountingStarsViewController.h"

@implementation HardCountingStarsViewController
@synthesize hardDisplayUserCorrect, hardStarsUserMustCount, hardRandomInteger, hardBtnImage,hardTotalCorrect,hardTotalGuessed, tutorialCountingStarsViewController;

// IF user clicks done button, check correctness
-(IBAction)hard_is_user_correct:(id)sender
{
    if(hardTotalGuessed == hardRandomInteger) // if correct generate new value
    {
        hardDisplayUserCorrect.text = [NSString stringWithFormat:@"Correct !!!"];
        
        NSInteger randomTemp = arc4random() % 18 + 1 ;  // create random integer between 1 - 18
        while(randomTemp % 3 != 0)  // make sure that integer is divisible by 3
        {
            randomTemp = arc4random() %18 +1;
        }
        hardRandomInteger = randomTemp;
        hardStarsUserMustCount.text=[NSString stringWithFormat:@"Count %d Stars",hardRandomInteger];
        
    }
    else // IF user is wrong display "Try Again"
    {
        hardDisplayUserCorrect.text = [NSString stringWithFormat:@" Try Again !"];
    }
}

-(IBAction)hard_tutorial_clicked:(id)sender
{
    self.tutorialCountingStarsViewController = [[TutorialCountingStarsViewController alloc]init];
    [self.navigationController pushViewController:self.tutorialCountingStarsViewController animated:YES];
}


-(void)AddTotalGuessed // increment hardTotalGuessed by 3
{
    hardTotalGuessed+=3;
}

-(void)AddTotalCorrect //  increment hardTotalCorrect by 1
{
    hardTotalCorrect++;
}

-(void)SubtractTotalGuessed // decrement hardTotalGuessed by 3
{
    hardTotalGuessed-= 3;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

// Display this game's tutorial:
-(void)viewDidAppear:(BOOL)animated
{
    
    self.tutorialCountingStarsViewController = [[TutorialCountingStarsViewController alloc] init];
    [self.navigationController pushViewController:self.tutorialCountingStarsViewController animated:YES];
     
}

- (void)viewDidLoad   // before showing interface to user, initialize some values
{
    [super viewDidLoad];
    hardRandomInteger = arc4random() % 18 + 1 ;  // generate integer between 1 - 18
    while(hardRandomInteger % 3 != 0) // make sure divisible by 3
    {
        hardRandomInteger = arc4random() % 18 + 1;
    }
    hardStarsUserMustCount.text =[NSString stringWithFormat:@"Count %d Stars", hardRandomInteger];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

// if user clicks star buttons on interface, will change image of button depending on current image
-(IBAction)hard_star_clicked:(id)sender  
{ 
    // if button's current image is colored stars
    if([[sender backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"threeStarsColor.png"]])
    {
        [self SubtractTotalGuessed];  // decrement hardTotalGuessed by 3
        hardBtnImage = [UIImage imageNamed:@"threeStarsWhite.png"];
        [sender setBackgroundImage:hardBtnImage forState:UIControlStateNormal]; // set image of current button to white stars
    }
    
    // if button's current image is white stars
    else
    {
        [self AddTotalGuessed];  // increment hardTotalGuessed by 3
        hardBtnImage = [UIImage imageNamed:@"threeStarsColor.png"];
        [sender setBackgroundImage:hardBtnImage forState:UIControlStateNormal]; // set image of current button to colored stars
    }

}

@end
