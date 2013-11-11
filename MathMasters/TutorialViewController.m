/****
 *
 * Filename:    TutorialCountingStarsViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Tutorial about how to play each game.
 *              Instantiated upon first time user plays specific games or
 *              if user clicks the "?" button the each game.
 *
 ****/

#import "TutorialViewController.h"
#import "GlobalVariables.h"


@implementation TutorialViewController {
    int currentIndex;                       // index that will be used to get images out of array
    NSMutableArray * arrayPictureStrings;   // will hold images of the specified game
}
@synthesize currentImage, currentTutorial;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    currentIndex = 0;   // Set to first image.
    [arrayPictureStrings removeAllObjects];
    arrayPictureStrings = [[NSMutableArray alloc] init]; // ReInitialize the picture array...
    
    
    // Load the appropriate tutorial pictures for the current game:
    
    // Normal CountingStars
    if ( [currentTutorial isEqualToString:@"CountingStarsViewController"] ) {
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial1.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial2.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial3.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cs_Tutorial4.png"]];
    }
    
    // Hard CountingStars:
    else if ( [currentTutorial isEqualToString:@"HardCountingStarsViewController"] ) {
        
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial1.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial2.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial3.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cs_Tutorial4.png"]];
    }
    
    // Normal SuperShopper:
    else if ( [currentTutorial isEqualToString:@"SuperShopperViewController"] ) {
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_supershopper_Tutorial1.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_supershopper_Tutorial2.png"]];
    }
    
    // Hard SuperShopper:
    else if ( [currentTutorial isEqualToString:@"HardSuperShopperViewController"] ) {
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_supershopper_Tutorial1.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_supershopper_Tutorial2.png"]];
    }
    
    // Normal FishToFish:
    else if ( [currentTutorial isEqualToString:@"FishToFishViewController"] ) {
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_ato_Tutorial1.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_ato_Tutorial2.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_ato_Tutorial3.png"]];
    }
    
    // Hard FishToFish:
    else if ( [currentTutorial isEqualToString:@"HardFishToFishViewController"] ) {
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_ato_Tutorial1.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_ato_Tutorial2.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_ato_Tutorial3.png"]];
    }
    
    // Normal MakingCents:
    else if ( [currentTutorial isEqualToString:@"MakingCentsViewController"] ) {
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_ms_Tutorial1.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_ms_Tutorial2.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_ms_Tutorial3.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_ms_Tutorial4.png"]];
    }
    
    // Hard MakingCents:
    else if ( [currentTutorial isEqualToString:@"HardMakingCentsViewController"] ) {
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_ms_Tutorial1.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_ms_Tutorial2.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_ms_Tutorial3.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_ms_Tutorial4.png"]];
    }
    
    // Normal Clockwork:
    else if ( [currentTutorial isEqualToString:@"ClockWorkViewController"] ) {
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cw_tut01.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cw_tut02.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cw_tut03.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"normal_cw_tut04.png"]];
    }
    
    // Hard Clockwork:
    else if ( [currentTutorial isEqualToString:@"HardClockWorkViewController"] ) {
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cw_tut01.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cw_tut02.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cw_tut03.png"]];
        [arrayPictureStrings addObject:[UIImage imageNamed:@"hard_cw_tut04.png"]];
    }
    
    // set image of UIImageView to first object in array
    [currentImage setImage:[arrayPictureStrings objectAtIndex:currentIndex]];
}

-(IBAction)ok_button_clicked:(id)sender  //user clicks "ok" button, go back to game screen
{
    [self.navigationController popViewControllerAnimated:YES];
}

// user clicks back arrow, switch image
-(IBAction)back_button_clicked:(id)sender {
    
    // IF this is NOT the first image: go to previous image.
    if(currentIndex > 0) {
        currentIndex --; 
        [self.currentImage setImage:[arrayPictureStrings objectAtIndex:currentIndex]];
    }
}

// user clicks foward arrow, switch image
-(IBAction)foward_button_clicked:(id)sender {
    
    // IF this is NOT the last image: advance to the next image.
    if( (currentIndex < (arrayPictureStrings.count - 1)) ) {
        currentIndex ++;
        [self.currentImage setImage:[arrayPictureStrings objectAtIndex:currentIndex]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

@end
