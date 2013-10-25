//
//  CountingStarsViewController.m
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-06.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "CountingStarsViewController.h"

@implementation CountingStarsViewController
@synthesize Stars_User_Must_Count, random_Integer, total_Guessed;
@synthesize btnImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        random_Integer = arc4random() % 10 + 1 ;
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Stars_User_Must_Count.text =[NSString stringWithFormat:@"Count %d Stars", random_Integer];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Hi, memory error");
}


-(IBAction)is_User_Correct:(id)sender
{
    if(total_Guessed == random_Integer)
    {
        Display_User_Correct.text = [NSString stringWithFormat:@"Correct !!!"];
        
        NSInteger random_temp = arc4random() % 10 + 1 ;
        random_Integer = random_temp;
        Stars_User_Must_Count.text =[NSString stringWithFormat:@"Count %d Stars", random_Integer];
        
    }
    else
    {
        Display_User_Correct.text = [NSString stringWithFormat:@" Try Again !"];
    }
}

-(void)AddTotalGuessed
{
    total_Guessed++;
}

-(void)AddTotalCorrect
{
    total_Correct++;
}

-(void)SubtractTotalGuessed
{
    total_Guessed--;
}


-(IBAction)star_Clicked:(id)sender
{
    
    if([[sender backgroundImageForState:UIControlStateNormal] isEqual: [UIImage imageNamed:@"Star (1).png"]])
    {
        [self SubtractTotalGuessed];
        btnImage = [UIImage imageNamed:@"white-star-hi.png"];
        [sender setBackgroundImage:btnImage forState:UIControlStateNormal];
    }
    else
    {
        [self AddTotalGuessed];
        btnImage = [UIImage imageNamed:@"Star (1).png"];
        [sender setBackgroundImage:btnImage forState:UIControlStateNormal];
    }
}

@end
