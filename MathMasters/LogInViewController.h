//
//  LogInViewController.h
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-16.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"
#import "DBManager.h"

@class ViewController;

@interface LogInViewController : UIViewController<UITextFieldDelegate>
{
    GlobalVariables *optionsSingle;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
}

-(IBAction)login:(id)sender;
@property (nonatomic, strong) IBOutlet UITextField *usernameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;




@end
