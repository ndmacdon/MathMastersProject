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
@synthesize changeDifficultyButton, statisticsViewController,optionsSingle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
// changes globalDifficultyLevel every time button is clicked

-(IBAction)change_difficulty:(id)sender
{
    // if normal (1) switch to hard (2)
    if([[changeDifficultyButton titleForState:UIControlStateNormal] isEqual:@"Normal"])
    {
        [changeDifficultyButton setTitle:@"Hard" forState:UIControlStateNormal];
        optionsSingle = [GlobalVariables singleObj];
        optionsSingle.globalDifficultyLevel = 2;
        
    }
    // if hard(2) switch to normal (1)
    else
    {
        [changeDifficultyButton setTitle:@"Normal" forState:UIControlStateNormal];
        optionsSingle = [GlobalVariables singleObj];
        optionsSingle.globalDifficultyLevel = 1;
    }
}

// Pop statisticsViewController onto the Navigation Stack:
-(IBAction)statistics_clicked:(id)sender
{
    if(!self.statisticsViewController)
    {
        self.statisticsViewController = [[StatisticsViewController alloc] init];
    }
    [self.navigationController pushViewController:self.statisticsViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.optionsSingle = [GlobalVariables singleObj];
    

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end










