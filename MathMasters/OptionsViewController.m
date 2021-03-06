/****
 *
 * Filename:    OptionsViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Options menu interface that controls the difficulty level of games.
 *
 ****/

#import "OptionsViewController.h"

#import "GlobalVariables.h"


@implementation OptionsViewController
@synthesize changeDifficultyButton,
            statisticsViewController,
            resetConfirmationViewController,
            creditViewController,
            optionsSingle;


-(void)viewDidLoad {
    optionsSingle = [GlobalVariables singleObj];
}

// changes globalDifficultyLevel every time button is clicked

-(IBAction)change_difficulty:(id)sender {
    
    // if normal (1) switch to hard (2)
    if([[changeDifficultyButton titleForState:UIControlStateNormal] isEqual:@"Normal"]) {
        [changeDifficultyButton setTitle:@"Hard" forState:UIControlStateNormal];
        optionsSingle.globalDifficultyLevel = 2;
    }
    // if hard(2) switch to normal (1)
    else {
        [changeDifficultyButton setTitle:@"Normal" forState:UIControlStateNormal];
        optionsSingle.globalDifficultyLevel = 1;
    }
}
-(IBAction)open_credits:(id)sender
{
    if(!self.creditViewController)
    {
        creditViewController = [[CreditViewController alloc] init];
    }
    [self.navigationController pushViewController:self.creditViewController animated:YES];
}

// Show reset confirmation view:
- (IBAction)resetStatisticsClicked:(id)sender {
    CGRect confirmBoxBound = CGRectMake(self.view.center.x-750, self.view.center.y-750, 1500, 1500);
    
    resetConfirmationViewController = [[ResetConfirmationViewController alloc] initWithNibName:@"ResetConfirmationViewController" bundle:nil];
    
    [self addChildViewController:self.resetConfirmationViewController];
    resetConfirmationViewController.view.frame = confirmBoxBound;
    [self.view addSubview:self.resetConfirmationViewController.view];
    [self.resetConfirmationViewController didMoveToParentViewController:self];
    
    resetConfirmationViewController.usernameText.text = optionsSingle.currentUser;
}

// Display Statistics Screen:
-(IBAction)statistics_clicked:(id)sender
{
    if(!self.statisticsViewController)
    { self.statisticsViewController = [[StatisticsViewController alloc] init]; }
    
    [self.navigationController pushViewController:self.statisticsViewController animated:YES];
}
-(IBAction)credit_clicked:(id)sender
{
    if(!self.creditViewController)
    {
        self.creditViewController = [[CreditViewController alloc] init];
    }
    [self.navigationController pushViewController:self.creditViewController animated:YES];
}

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
-(IBAction)set_music_volume:(id)sender
{
    UISlider * mySlider = sender;
    optionsSingle.musicVolumeControl = mySlider.value;
    
}
-(IBAction)set_soundeffect_volume:(id)sender
{
    UISlider * mySlider = sender;
    optionsSingle.soundeffectVolumeControl = mySlider.value;
}

// If the device rotates: reset the stars so they conform to the new bounding box.
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
}

@end










