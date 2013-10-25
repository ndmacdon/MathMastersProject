//
//  HardCountingStarsViewController.m
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-24.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "HardCountingStarsViewController.h"


@implementation HardCountingStarsViewController
@synthesize Hard_Display_User_Correct, Hard_Stars_User_Must_Count, hard_random_Integer, hard_btnImage,hard_total_Guessed,hard_total_Correct;



-(IBAction)Hard_Is_User_Correct:(id)sender
{
    if(hard_total_Guessed == hard_random_Integer)
    {
        Hard_Display_User_Correct.text = [NSString stringWithFormat:@"Correct !!!"];
        
        NSInteger random_temp = arc4random() % 18 + 1 ;
        while(random_temp % 3 != 0)
        {
            random_temp = arc4random() %18 +1;
        }
        hard_random_Integer = random_temp;
        Hard_Stars_User_Must_Count.text=[NSString stringWithFormat:@"Count %d Stars",hard_random_Integer];
        
    }
    else
    {
        Hard_Display_User_Correct.text = [NSString stringWithFormat:@" Try Again !"];
    }
}


-(void)AddTotalGuessed
{
    hard_total_Guessed+=3;
}

-(void)AddTotalCorrect
{
    hard_total_Correct++;
}

-(void)SubtractTotalGuessed
{
    hard_total_Guessed-= 3;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        hard_random_Integer = arc4random() % 18 + 1 ;
        while(hard_random_Integer % 3 != 0)
        {
            hard_random_Integer = arc4random() % 18 + 1;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Hard_Stars_User_Must_Count.text =[NSString stringWithFormat:@"Count %d Stars", hard_random_Integer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

-(IBAction)hard_star_Clicked:(id)sender
{
    if([[sender backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"three_stars.png"]])
    {
        [self SubtractTotalGuessed];
        hard_btnImage = [UIImage imageNamed:@"three-stars_white_design.png"];
        [sender setBackgroundImage:hard_btnImage forState:UIControlStateNormal];
    }
    
    else
    {
        [self AddTotalGuessed];
        hard_btnImage = [UIImage imageNamed:@"three_stars.png"];
        [sender setBackgroundImage:hard_btnImage forState:UIControlStateNormal];
    }

}

@end
