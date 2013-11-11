/****
 *
 * Filename:    SessionStatisticsViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: Nov 07, 2013
 *
 * Description: ViewController: Displays the results of a player session.
 *
 ****/

#import "SessionStatisticsViewController.h"


@implementation SessionStatisticsViewController

@synthesize cheerLabel, resultLabel, completionTime;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (completionTime < 30) {
        cheerLabel.text = @"AWESOME!";
    }
    else if (completionTime < 60) {
        cheerLabel.text = @"Great!";
    }
    else {
        cheerLabel.text = @"Good!";
    }
    
    resultLabel.text = [NSString stringWithFormat:@"Finished in %d Seconds", completionTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menu_clicked:(id)sender {
    // Return to menu:
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

- (IBAction)retry_clicked:(id)sender {
    // Return to game screen:
    [self.navigationController popViewControllerAnimated:TRUE];
}
@end
