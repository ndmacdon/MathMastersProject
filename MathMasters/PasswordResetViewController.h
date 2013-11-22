/****
 *
 * Filename:    PasswordResetViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: November 21, 2013
 *
 * Description: ViewController: Allows users to reset their password. Updates Database with new password.
 *
 ****/

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
