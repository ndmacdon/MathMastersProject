//
//  HardApplesToOrangesViewController.h
//  MathMasters
//
//  Created by Ryan Wong on 2013-11-04.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HardApplesToOrangesViewController : UIViewController
{
    IBOutlet UILabel * hardDisplayUserCorrect;
    IBOutlet UIButton * hardRightButton;
    IBOutlet UIButton * hardLeftButton;
    IBOutlet UIButton * hardMiddleButton;
    NSMutableArray * hardNumberImageArray;
    NSMutableArray * hardAppleImageArray;
    NSMutableArray * hardOrangeImageArray;
    NSMutableArray * hardFishImageArray;
    NSInteger hardLeftTotalAmount;
    NSInteger hardRightTotalAmount;
    NSInteger hardMiddleTotalAmount;
    NSInteger hardTotalCorrect;
    
}

-(IBAction)hard_left_button_clicked:(id)sender;
-(IBAction)hard_right_button_clicked:(id)sender;
-(IBAction)hard_middle_button_clicked:(id)sender;

-(void)hard_load_pictures;
-(void)hard_add_total_correct;
@property(nonatomic,strong) IBOutlet UILabel *hardDisplayUserCorrect;
@property(nonatomic,strong) IBOutlet UIButton *hardRightButton;
@property(nonatomic,strong) IBOutlet UIButton *hardLeftButton;
@property(nonatomic,strong) IBOutlet UIButton *hardMiddleButton;
@property(nonatomic,strong) NSMutableArray *hardNumberImageArray;
@property(nonatomic,strong) NSMutableArray * hardOrangeImageArray;
@property(nonatomic,strong) NSMutableArray * hardAppleImageArray;
@property(nonatomic,strong) NSMutableArray * hardFishImageArray;
@property(nonatomic) NSInteger hardLeftTotalAmount;
@property(nonatomic) NSInteger hardRightTotalAmount;
@property(nonatomic) NSInteger hardMiddleTotalAmount;
@property(nonatomic) NSInteger hardTotalCorrect;

@end
