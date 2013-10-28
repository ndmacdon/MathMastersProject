//
//  TutorialCountingStarsViewController.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//
//  Brief Description : Tutorial on how to play games, called when first time user plays specific games or if user clicks the "?" button the each game


#import "TutorialCountingStarsViewController.h"
#import "GlobalVariables.h"


@implementation TutorialCountingStarsViewController
@synthesize currentIndex, arrayPictureStrings,currentImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    currentIndex = 0;
    optionsSingle = [GlobalVariables singleObj];
    if(optionsSingle.globalDifficultyLevel == 1) // normal version of counting stars, add tutorial images
    {
        self.arrayPictureStrings = [NSMutableArray arrayWithCapacity:10];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial1.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial2.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial3.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial4.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial5.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial6.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial7.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial8.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial9.png"]];
    }
    
    if(optionsSingle.globalDifficultyLevel == 2) //hard version of counting stars, add tutorial images
    {
        self.arrayPictureStrings = [NSMutableArray arrayWithCapacity:10];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial1.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial2.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial3.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial4.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial5.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial6.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial7.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial8.png"]];
        [self.arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial9.png"]];
        
    }
    // set image of UIImageView to first object in array
    [self.currentImage setImage:[self.arrayPictureStrings objectAtIndex:currentIndex]];
}

-(IBAction)ok_button_clicked:(id)sender  //user clicks "ok" button, go back to game screen
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)back_button_clicked:(id)sender // user clicks back arrow, switch image
{
    if(self.currentIndex >= 1) // make sure that it is not first image
    {
        currentIndex --; 
        [self.currentImage setImage:[self.arrayPictureStrings objectAtIndex:currentIndex]];
        
    }
}
-(IBAction)foward_button_clicked:(id)sender // user clicks foward arrow, switch image
{
    if(self.currentIndex <= 7) // make sure that it is not last image
    {
        currentIndex ++; 
        [self.currentImage setImage:[self.arrayPictureStrings objectAtIndex:currentIndex]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
