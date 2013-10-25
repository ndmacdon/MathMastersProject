//
//  LogInViewController.h
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-16.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface LogInViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
    
}

-(IBAction)loginButtonClicked:(id)sender;
@property (nonatomic, strong) IBOutlet UITextField *usernameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;

//@property (strong, nonatomic) ViewController *viewController;




@end
