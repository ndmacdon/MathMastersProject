//
//  CreateAccountViewController.h
//  MathMasters
//
//  Created by Kristina Mishina on 13-10-25.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface CreateAccountViewController : UIViewController<UITextFieldDelegate> {
    
    IBOutlet UITextField *secretText;
    IBOutlet UITextField *passwordConfirmationText;
    IBOutlet UITextField *passwordText;
    IBOutlet UITextField *usernameText;
}

- (IBAction)clearFields:(id)sender;
- (IBAction)createAccount:(id)sender;

@property (nonatomic, strong) IBOutlet UITextField *secretText;
@property (nonatomic, strong) IBOutlet UITextField *passwordConfirmationText;
@property (nonatomic, strong) IBOutlet UITextField *passwordText;
@property (nonatomic, strong) IBOutlet UITextField *usernameText;
@end
