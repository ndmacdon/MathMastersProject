//
//  PasswordResetViewController.h
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-20.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "InputFormViewController.h"

@interface PasswordResetViewController : InputFormViewController {
    IBOutlet UITextField *secretText;
    IBOutlet UITextField *passwordConfirmationText;
    IBOutlet UITextField *passwordText;
    IBOutlet UITextField *usernameText;
    
    NSString *username;
}


- (IBAction)clearFields:(id)sender;
- (IBAction)resetPassword:(id)sender;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) IBOutlet UITextField *secretText;
@property (nonatomic, strong) IBOutlet UITextField *passwordConfirmationText;
@property (nonatomic, strong) IBOutlet UITextField *passwordText;
@property (nonatomic, strong) IBOutlet UITextField *usernameText;

@end
