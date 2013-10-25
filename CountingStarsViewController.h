//
//  CountingStarsViewController.h
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-06.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountingStarsViewController : UIViewController
{
    IBOutlet UILabel *Stars_User_Must_Count;
    IBOutlet UILabel *Display_User_Correct;
    NSInteger random_Integer;
    NSInteger total_Guessed;
    NSInteger total_Correct;
    
    UIImage *btnImage;
}

-(IBAction)star_Clicked:(id)sender;



-(IBAction)is_User_Correct:(id)sender;
-(void)AddTotalGuessed;
-(void)SubtractTotalGuessed;
-(void)AddTotalCorrect;



@property (nonatomic,strong) IBOutlet UILabel *Stars_User_Must_Count;
@property(nonatomic) NSInteger random_Integer;
@property(nonatomic) NSInteger total_Guessed;
@property(nonatomic,strong) UIImage *btnImage;





@end
