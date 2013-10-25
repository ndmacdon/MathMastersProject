//
//  OptionsViewController.h
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-24.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"

@interface OptionsViewController : UIViewController
{

    IBOutlet UIButton * changeDifficultyButton;
    GlobalVariables *optionsSingle;

}


-(IBAction)change_Difficulty:(id)sender;
@property(nonatomic,strong) IBOutlet UIButton *changeDifficultyButton;
@property(nonatomic,strong) IBOutlet UILabel * testing;
@end
