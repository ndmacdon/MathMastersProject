/****
 *
 * Filename:    FishToFishViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Magnitude estimation game.
 *
 ****/

// Things to do for normal and hard version .... Tutorial screen

#import "FishToFishViewController.h"


@implementation FishToFishViewController
@synthesize displayUserCorrect, rightButton, leftButton, numberImageArray, orangeImageArray, appleImageArray,fishImageArray,leftTotalAmount,rightTotalAmount, totalCorrect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)left_button_clicked:(id)sender  
{
    if(leftTotalAmount > rightTotalAmount)
    {
        displayUserCorrect.text = [NSString stringWithFormat:@"You are Correct !!!"];
        [self add_total_correct];
        if(totalCorrect == 5)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [self load_pictures];
    }
    else
    {
        displayUserCorrect.text = [NSString stringWithFormat:@"Good Try ! Guess Again"];
    }
}

-(IBAction)right_button_clicked:(id)sender
{
    if(rightTotalAmount > leftTotalAmount)
    {
        displayUserCorrect.text = [NSString stringWithFormat:@"You are Correct !!!"];
        [self add_total_correct];
        if(totalCorrect == 5)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [self load_pictures];
    }
    else
    {
        displayUserCorrect.text = [NSString stringWithFormat:@"Good Try ! Guess Again"];
    }
}

-(void)add_total_correct
{
    totalCorrect++;
}

-(void)load_pictures
{
    int randomPicture = arc4random() % 10 ;  // NO need to increment by one since array index 0-6
    int randomPicture2 = arc4random() % 10;
    while(randomPicture == randomPicture2)
    {
        randomPicture2 = arc4random() % 10;
        
    }
    rightTotalAmount = randomPicture;
    leftTotalAmount = randomPicture2;
    
    int randomLeftPicture = arc4random() %4;
    int randomRightPicture = arc4random() % 4;  // 0 = numbers, 1 = fish, 2 = apple, 3 = orange
    
    if(randomLeftPicture == 0)
    {
        [leftButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[numberImageArray objectAtIndex:randomPicture2]]] forState:UIControlStateNormal];
    }
    if(randomLeftPicture == 1)
    {
        [leftButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[fishImageArray objectAtIndex:randomPicture2]]] forState:UIControlStateNormal];
    }
    if(randomLeftPicture == 2)
    {
        [leftButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[appleImageArray objectAtIndex:randomPicture2]]] forState:UIControlStateNormal];
    }
    if(randomLeftPicture == 3)
    {
        [leftButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[orangeImageArray objectAtIndex:randomPicture2]]] forState:UIControlStateNormal];
    }
    
    if(randomRightPicture == 0)
    {
        [rightButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[numberImageArray objectAtIndex:randomPicture]]] forState:UIControlStateNormal];
    }
    if(randomRightPicture == 1)
    {
        [rightButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[fishImageArray objectAtIndex:randomPicture]]] forState:UIControlStateNormal];
    }
    if(randomRightPicture == 2)
    {
        [rightButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[appleImageArray objectAtIndex:randomPicture]]] forState:UIControlStateNormal];
    }
    if(randomRightPicture == 3)
    {
         [rightButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[orangeImageArray objectAtIndex:randomPicture]]] forState:UIControlStateNormal];
    }
    
    
   }

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    fishImageArray = [[NSMutableArray alloc] init];
    [fishImageArray addObject:@"fish1.png"];
    [fishImageArray addObject:@"fish2.png"];
    [fishImageArray addObject:@"fish3.png"];
    [fishImageArray addObject:@"fish4.png"];
    [fishImageArray addObject:@"fish5.png"];
    [fishImageArray addObject:@"fish6.png"];
    [fishImageArray addObject:@"fish7.png"];
    [fishImageArray addObject:@"fish8.png"];
    [fishImageArray addObject:@"fish9.png"];
    [fishImageArray addObject:@"fish10.png"];
    
    appleImageArray = [[NSMutableArray alloc]init];
    [appleImageArray addObject:@"apple1.png"];
    [appleImageArray addObject:@"apple2.png"];
    [appleImageArray addObject:@"apple3.png"];
    [appleImageArray addObject:@"apple4.png"];
    [appleImageArray addObject:@"apple5.png"];
    [appleImageArray addObject:@"apple6.png"];
    [appleImageArray addObject:@"apple7.png"];
    [appleImageArray addObject:@"apple8.png"];
    [appleImageArray addObject:@"apple9.png"];
    [appleImageArray addObject:@"apple10.png"];
    
    orangeImageArray = [[NSMutableArray alloc]init];
    [orangeImageArray addObject:@"orange1.png"];
    [orangeImageArray addObject:@"orange2.png"];
    [orangeImageArray addObject:@"orange3.png"];
    [orangeImageArray addObject:@"orange4.png"];
    [orangeImageArray addObject:@"orange5.png"];
    [orangeImageArray addObject:@"orange6.png"];
    [orangeImageArray addObject:@"orange7.png"];
    [orangeImageArray addObject:@"orange8.png"];
    [orangeImageArray addObject:@"orange9.png"];
    [orangeImageArray addObject:@"orange10.png"];
    
    numberImageArray = [[NSMutableArray alloc]init];
    [numberImageArray addObject:@"1.png"];
    [numberImageArray addObject:@"2.png"];
    [numberImageArray addObject:@"3.png"];
    [numberImageArray addObject:@"4.png"];
    [numberImageArray addObject:@"5.png"];
    [numberImageArray addObject:@"6.png"];
    [numberImageArray addObject:@"7.png"];
    [numberImageArray addObject:@"8.png"];
    [numberImageArray addObject:@"9.png"];
    [numberImageArray addObject:@"10.png"];

    [self load_pictures];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
