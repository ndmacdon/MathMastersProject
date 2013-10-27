//
//  ViewController.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//


// Brief Description : Header file of View Controller, is the main menu and navigation controller of application that contains buttons to multiple games and options menu


#import "ViewController.h"
#import "GlobalVariables.h"

@implementation ViewController
@synthesize countingStarsViewController, hardCountingViewController,fishToFishViewController, makingCentsViewController, optionsViewController;


-(IBAction)options_clicked:(id)sender
{
    if(!self.optionsViewController)
    {
        self.optionsViewController = [[OptionsViewController alloc] init];
    }
    [self.navigationController pushViewController:self.optionsViewController animated:YES];
}

-(IBAction)cstars_clicked:(id)sender
{
    
    if(optionsSingle.globalDifficultyLevel ==1)
    {
        if(!self.countingStarsViewController)
        {
            self.countingStarsViewController = [[CountingStarsViewController alloc] init];
        }
        [self.navigationController pushViewController:self.countingStarsViewController animated:YES] ;
    }
    else
    {
        if(!self.hardCountingViewController)
        {
            self.hardCountingViewController = [[HardCountingStarsViewController alloc] init];
        }
        [self.navigationController pushViewController:self.hardCountingViewController animated:YES];
    }
    
}
-(IBAction)fishtofish_clicked:(id)sender
{
    
    if(!self.fishToFishViewController)
    {
        self.fishToFishViewController = [[FishToFishViewController alloc] init];
    }
    [self.navigationController pushViewController:self.fishToFishViewController animated:YES];
}
-(IBAction)makingcents_clicked:(id)sender
{
    if(!self.makingCentsViewController)
    {
        self.makingCentsViewController = [[MakingCentsViewController alloc] init];
    }
    [self.navigationController pushViewController:self.makingCentsViewController animated:YES];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    optionsSingle = [GlobalVariables singleObj];
    optionsSingle.globalDifficultyLevel = 1;   // initialize difficultyLevel to 1 ( normal )
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}

@end
