//
//  MakingCentsViewController.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//

#import "MakingCentsViewController.h"

@implementation MakingCentsViewController
@synthesize instructions_User, amountDisplayed,five_Cents, ten_Cents, twentyfive_Cents;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)SetInstructionsUser
{
    int random_Value = arc4random() % 20 + 1;
    amountDisplayed = random_Value * 5;
    instructions_User.text = [NSString stringWithFormat:@"Put %d cents in the box ", amountDisplayed];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetInstructionsUser];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)draggedOut:(id)sender withEvent: (UIEvent *) event
{
    UIButton *selected = (UIButton *)sender;    
    selected.center = [[[event allTouches] anyObject] locationInView:self.view];
}

@end
