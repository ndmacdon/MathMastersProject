//
//  FishToFishViewController.m
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-07.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "FishToFishViewController.h"


@implementation FishToFishViewController
@synthesize Display_User_Correct, Right_Button, Left_Button, ImageArray, Left_Total_Fish,Right_Total_Fish;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)left_ButtonClicked:(id)sender
{
    if(Left_Total_Fish > Right_Total_Fish)
    {
        Display_User_Correct.text = [NSString stringWithFormat:@"You are Correct !!!"];
        [self LoadPictures];
    }
    else
    {
        Display_User_Correct.text = [NSString stringWithFormat:@"Good Try ! Guess Again"];
    }
}

-(IBAction)right_ButtonClicked:(id)sender
{
    if(Right_Total_Fish > Left_Total_Fish)
    {
        Display_User_Correct.text = [NSString stringWithFormat:@"You are Correct !!!"];
        [self LoadPictures];
    }
    else
    {
        Display_User_Correct.text = [NSString stringWithFormat:@"Good Try ! Guess Again"];
    }
}
-(void)LoadPictures
{
    int random_picture = arc4random() % 7 ;  // NO need to increment by one since array index 0-6
    int random_picture2 = arc4random() % 7;
    while(random_picture == random_picture2)
    {
        random_picture2 = arc4random() % 7;
        
    }
    Right_Total_Fish = random_picture;
    Left_Total_Fish = random_picture2;
    
    [Right_Button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:random_picture]]] forState:UIControlStateNormal];
    
    
    [Left_Button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[ImageArray objectAtIndex:random_picture2]]] forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ImageArray = [[NSMutableArray alloc] init];
    [ImageArray addObject:@"fish-fish1 copy.png"];
    [ImageArray addObject:@"fish-fish2 copy.png"];
    [ImageArray addObject:@"fish-fish3 copy.png"];
    [ImageArray addObject:@"fish-fish4 copy.png"];
    [ImageArray addObject:@"fish-fish5 copy.png"];
    [ImageArray addObject:@"fish-fish6 copy.png"];
    [ImageArray addObject:@"fish-fish7 copy.png"];
    
    [self LoadPictures];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
