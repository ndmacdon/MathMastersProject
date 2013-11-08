//
//  HardApplesToOrangesViewController.m
//  MathMasters
//
//  Created by Ryan Wong on 2013-11-04.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "HardApplesToOrangesViewController.h"


@implementation HardApplesToOrangesViewController
@synthesize hardDisplayUserCorrect, hardRightButton, hardLeftButton, hardMiddleButton,hardNumberImageArray, hardOrangeImageArray, hardAppleImageArray,hardFishImageArray,hardLeftTotalAmount,hardRightTotalAmount,hardMiddleTotalAmount,hardTotalCorrect;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(IBAction)hard_left_button_clicked:(id)sender
{
    if(hardLeftTotalAmount > hardRightTotalAmount && hardLeftTotalAmount > hardMiddleTotalAmount)
    {
        hardDisplayUserCorrect.text = [NSString stringWithFormat:@"You are Correct !!!"];
        [self hard_add_total_correct];
        if(hardTotalCorrect == 5)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [self hard_load_pictures];
    }
    else
    {
        hardDisplayUserCorrect.text = [NSString stringWithFormat:@"Good Try ! Guess Again"];
    }
}

-(IBAction)hard_right_button_clicked:(id)sender
{
    if(hardRightTotalAmount > hardLeftTotalAmount && hardRightTotalAmount > hardMiddleTotalAmount)
    {
        hardDisplayUserCorrect.text = [NSString stringWithFormat:@"You are Correct !!!"];
        [self hard_add_total_correct];
        if(hardTotalCorrect == 5)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [self hard_load_pictures];
    }
    else
    {
        hardDisplayUserCorrect.text = [NSString stringWithFormat:@"Good Try ! Guess Again"];
    }
}

-(IBAction)hard_middle_button_clicked:(id)sender
{
    if(hardMiddleTotalAmount > hardLeftTotalAmount && hardMiddleTotalAmount > hardRightTotalAmount)
    {
        hardDisplayUserCorrect.text = [NSString stringWithFormat:@"You are Correct !!!"];
        [self hard_add_total_correct];
        if(hardTotalCorrect == 5)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [self hard_load_pictures];
    }
    else
    {
        hardDisplayUserCorrect.text = [NSString stringWithFormat:@"Good Try ! Guess Again"];
    }
}

-(void)hard_add_total_correct
{
    hardTotalCorrect++;
}

-(void)hard_load_pictures
{
    int randomPictureRightIndex = arc4random() % 10 ;
    int randomPictureLeftIndex = arc4random() % 10;
    int randomPictureMiddleIndex = arc4random() % 10;
    
    while(randomPictureRightIndex == randomPictureLeftIndex)
    {
        randomPictureLeftIndex = arc4random() % 10;
        
    }
    while(randomPictureMiddleIndex == randomPictureLeftIndex || randomPictureMiddleIndex == randomPictureRightIndex)
    {
        randomPictureMiddleIndex = arc4random() % 10;
    }
    
    hardRightTotalAmount = randomPictureRightIndex;
    hardLeftTotalAmount = randomPictureLeftIndex;
    hardMiddleTotalAmount = randomPictureMiddleIndex;
    
    
    int typeLeftPicture = arc4random() %4;
    int typeRightPicture = arc4random() % 4;  // 0 = numbers, 1 = fish, 2 = apple, 3 = orange
    int typeMiddlePicture = arc4random() % 4;
    
    if(typeLeftPicture == 0)
    {
        [hardLeftButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardNumberImageArray objectAtIndex:randomPictureLeftIndex]]] forState:UIControlStateNormal];
    }
    if(typeLeftPicture == 1)
    {
        [hardLeftButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardFishImageArray objectAtIndex:randomPictureLeftIndex]]] forState:UIControlStateNormal];
    }
    if(typeLeftPicture == 2)
    {
        [hardLeftButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardAppleImageArray objectAtIndex:randomPictureLeftIndex]]] forState:UIControlStateNormal];
    }
    if(typeLeftPicture == 3)
    {
        [hardLeftButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardOrangeImageArray objectAtIndex:randomPictureLeftIndex]]] forState:UIControlStateNormal];
    }
    
    if(typeRightPicture == 0)
    {
        [hardRightButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardNumberImageArray objectAtIndex:randomPictureRightIndex]]] forState:UIControlStateNormal];
    }
    if(typeRightPicture == 1)
    {
        [hardRightButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardFishImageArray objectAtIndex:randomPictureRightIndex]]] forState:UIControlStateNormal];
    }
    if(typeRightPicture == 2)
    {
        [hardRightButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardAppleImageArray objectAtIndex:randomPictureRightIndex]]] forState:UIControlStateNormal];
    }
    if(typeRightPicture == 3)
    {
        [hardRightButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardOrangeImageArray objectAtIndex:randomPictureRightIndex]]] forState:UIControlStateNormal];
    }
    
    if(typeMiddlePicture == 0)
    {
        [hardMiddleButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardNumberImageArray objectAtIndex:randomPictureMiddleIndex]]] forState:UIControlStateNormal];
    }
    if(typeMiddlePicture == 1)
    {
        [hardMiddleButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardFishImageArray objectAtIndex:randomPictureMiddleIndex]]] forState:UIControlStateNormal];
    }
    if(typeMiddlePicture == 2)
    {
        [hardMiddleButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardAppleImageArray objectAtIndex:randomPictureMiddleIndex]]] forState:UIControlStateNormal];
    }
    if(typeMiddlePicture == 3)
    {
        [hardMiddleButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[hardOrangeImageArray objectAtIndex:randomPictureMiddleIndex]]] forState:UIControlStateNormal];
    }

    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    hardFishImageArray = [[NSMutableArray alloc] init];
    [hardFishImageArray addObject:@"fish1.png"];
    [hardFishImageArray addObject:@"fish2.png"];
    [hardFishImageArray addObject:@"fish3.png"];
    [hardFishImageArray addObject:@"fish4.png"];
    [hardFishImageArray addObject:@"fish5.png"];
    [hardFishImageArray addObject:@"fish6.png"];
    [hardFishImageArray addObject:@"fish7.png"];
    [hardFishImageArray addObject:@"fish8.png"];
    [hardFishImageArray addObject:@"fish9.png"];
    [hardFishImageArray addObject:@"fish10.png"];
    
    hardAppleImageArray = [[NSMutableArray alloc]init];
    [hardAppleImageArray addObject:@"apple1.png"];
    [hardAppleImageArray addObject:@"apple2.png"];
    [hardAppleImageArray addObject:@"apple3.png"];
    [hardAppleImageArray addObject:@"apple4.png"];
    [hardAppleImageArray addObject:@"apple5.png"];
    [hardAppleImageArray addObject:@"apple6.png"];
    [hardAppleImageArray addObject:@"apple7.png"];
    [hardAppleImageArray addObject:@"apple8.png"];
    [hardAppleImageArray addObject:@"apple9.png"];
    [hardAppleImageArray addObject:@"apple10.png"];
    
    hardOrangeImageArray = [[NSMutableArray alloc]init];
    [hardOrangeImageArray addObject:@"orange1.png"];
    [hardOrangeImageArray addObject:@"orange2.png"];
    [hardOrangeImageArray addObject:@"orange3.png"];
    [hardOrangeImageArray addObject:@"orange4.png"];
    [hardOrangeImageArray addObject:@"orange5.png"];
    [hardOrangeImageArray addObject:@"orange6.png"];
    [hardOrangeImageArray addObject:@"orange7.png"];
    [hardOrangeImageArray addObject:@"orange8.png"];
    [hardOrangeImageArray addObject:@"orange9.png"];
    [hardOrangeImageArray addObject:@"orange10.png"];
    
    hardNumberImageArray = [[NSMutableArray alloc]init];
    [hardNumberImageArray addObject:@"1.png"];
    [hardNumberImageArray addObject:@"2.png"];
    [hardNumberImageArray addObject:@"3.png"];
    [hardNumberImageArray addObject:@"4.png"];
    [hardNumberImageArray addObject:@"5.png"];
    [hardNumberImageArray addObject:@"6.png"];
    [hardNumberImageArray addObject:@"7.png"];
    [hardNumberImageArray addObject:@"8.png"];
    [hardNumberImageArray addObject:@"9.png"];
    [hardNumberImageArray addObject:@"10.png"];
    
    [self hard_load_pictures];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
