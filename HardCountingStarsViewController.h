//
//  HardCountingStarsViewController.h
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-24.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HardCountingStarsViewController : UIViewController
{
    IBOutlet UILabel *Hard_Stars_User_Must_Count;
    IBOutlet UILabel *Hard_Display_User_Correct;
    NSInteger hard_random_Integer;
    NSInteger hard_total_Guessed;
    NSInteger hard_total_Correct;
    
    UIImage *hard_btnImage;
    
}

-(IBAction)hard_star_Clicked:(id)sender;
-(IBAction)Hard_Is_User_Correct:(id)sender;

@property(nonatomic,strong) IBOutlet UILabel *Hard_Stars_User_Must_Count;
@property(nonatomic,strong) IBOutlet UILabel *Hard_Display_User_Correct;
@property(nonatomic) NSInteger hard_random_Integer;
@property(nonatomic) NSInteger hard_total_Guessed;
@property(nonatomic) NSInteger hard_total_Correct;
@property(nonatomic,strong) UIImage *hard_btnImage;


@end

