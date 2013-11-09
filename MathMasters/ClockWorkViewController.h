//
//  ClockWorkViewController.h
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-08.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface ClockWorkViewController : GameViewController {
    
    IBOutlet UIDatePicker *timePicker;
    IBOutlet UIImageView *minuteHand;
    IBOutlet UIImageView *hourHand;
    IBOutlet UILabel *resultLabel;
}
- (IBAction)checkAnswer:(id)sender;

@end
