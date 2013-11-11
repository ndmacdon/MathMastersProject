//
//  ClockWorkViewController.h
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-08.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface ClockWorkViewController : GameViewController<UIPickerViewDelegate> {
    
    IBOutlet UIDatePicker *timePicker;
    IBOutlet UIImageView *minuteHand;
    IBOutlet UIImageView *hourHand;
    IBOutlet UILabel *resultLabel;

    NSString *correctTime;
    
    NSString * hourGuessed;
    NSString * minuteGuessed;
    
    NSString * hourCorrectAnswer;
    NSString * minuteCorrectAnswer;
    
    IBOutlet UILabel * correcthour;
    IBOutlet UILabel * correctminute;
    IBOutlet UILabel * guesshour;
    IBOutlet UILabel * guessminute;

    
}
- (IBAction)checkAnswer:(id)sender;
-(void) normal_move_hands;
-(void) reset_hands;


@property (nonatomic,strong)NSString * correctTime;
@property(nonatomic,strong) NSString *timeGuessed;

@property(nonatomic,strong) NSString * hourGuessed;
@property(nonatomic,strong) NSString * minuteGuessed;
@property(nonatomic,strong) NSString * hourCorrectAnswer;
@property(nonatomic,strong) NSString * minuteCorrectAnswer;

@end
