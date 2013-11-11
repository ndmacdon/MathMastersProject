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
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Counting and magnitude relation game.
 *
 ****/

#import "MakingCentsViewController.h"

@implementation MakingCentsViewController {
    NSTimer * timeOfReset;
    NSInteger amountDisplayed;
    NSInteger amountYellowBox;
    NSInteger totalCorrect;
}
@synthesize instructionsUser, amountDisplayed, yellowBox,amountYellowBox,timeOfReset,totalCorrect, dime1,dime2,quarter1,quarter2,quarter3,nickel1,nickel2;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)set_instructions_user
{
    int random_Value = arc4random() % 20 + 1;  // between 1 - 99
    amountDisplayed = random_Value * 5;  // make sure it is divisible by 5
    instructionsUser.text = [NSString stringWithFormat:@"Put %d cents in the box ", amountDisplayed];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self set_instructions_user];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dragged_out:(id)sender withEvent: (UIEvent *) event
{
    MyButtonMakingCents *selected = sender;
    selected.center = [[[event allTouches] anyObject] locationInView:self.view];
    
    
    if(CGRectContainsRect(yellowBox.frame, selected.frame) && !(selected.inYellowBox)) // if its in the yellow box for first time
    {
        if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Nickel.png"]])
        {
            amountYellowBox += 5;
        }
        if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Dime.png"]])
        {
            amountYellowBox += 10;
        }
        if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Quarter.png"]])
        {
            amountYellowBox += 25;
        }
        selected.inYellowBox = true;
            
    }
    if(!(CGRectContainsRect(yellowBox.frame, selected.frame)) && selected.inYellowBox)
    {
        if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Nickel.png"]])
        {
            amountYellowBox -= 5;
        }
        if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Dime.png"]])
        {
            amountYellowBox -= 10;
        }
        if([[selected backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Quarter.png"]])
        {
            amountYellowBox -= 25;
        }
        selected.inYellowBox =false;
    }
    
    if(amountYellowBox == amountDisplayed)
    {
        [self user_is_correct];
    }
}

-(void)user_is_correct
{
    [self reset_screen];
    
    totalCorrect++;
    if(self.totalCorrect == 5)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self alert_user_correct];
    }
}

-(void)reset_screen
{
    [self set_instructions_user];
    amountYellowBox = 0;
    dime1.inYellowBox = false;
    dime2.inYellowBox = false;
    nickel1.inYellowBox = false;
    nickel2.inYellowBox = false;
    quarter1.inYellowBox = false;
    quarter2.inYellowBox = false;
    quarter3.inYellowBox = false;
    dime1.frame = CGRectMake(228,400,58,63);
    dime2.frame = CGRectMake(145, 841, 58, 63);
    nickel1.frame = CGRectMake(46, 506, 92, 83);
    nickel2.frame = CGRectMake(194, 540, 92, 83);
    quarter1.frame = CGRectMake(33, 319, 119, 115);
    quarter2.frame = CGRectMake(28, 680, 119, 115);
    quarter3.frame = CGRectMake(206, 695, 117, 115);
}

-(void)alert_user_correct
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CORRECT !!!" message:@"" delegate:self cancelButtonTitle:@"continue" otherButtonTitles:nil];
    [alert show];
}
@end
