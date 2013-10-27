//
//  OptionsViewController.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//

//  Brief Description: Options interface that contains a difficulty button

#import "OptionsViewController.h"

#import "GlobalVariables.h"


@implementation OptionsViewController
@synthesize changeDifficultyButton;

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

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
