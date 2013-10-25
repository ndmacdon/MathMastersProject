//
//  MakingCentsViewController.h
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-10.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakingCentsViewController : UIViewController
{
    IBOutlet UILabel * instructions_User;
    NSInteger amountDisplayed;
    
    IBOutlet UIButton *five_Cents;
    IBOutlet UIButton *ten_Cents;
    IBOutlet UIButton *twentyfive_Cents;
    
}

-(void)SetInstructionsUser;
-(IBAction)draggedOut:(id)sender withEvent: (UIEvent *) event;

@property (nonatomic, strong)IBOutlet UILabel *instructions_User;
@property (nonatomic) NSInteger amountDisplayed;
@property (nonatomic, strong) IBOutlet UIButton *five_Cents;
@property (nonatomic, strong) IBOutlet UIButton *ten_Cents;
@property (nonatomic, strong) IBOutlet UIButton *twentyfive_Cents;


@end
