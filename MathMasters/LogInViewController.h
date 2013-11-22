/****
 *
 * Filename:    LogInViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: November 21, 2013
 *
 * Description: ViewController: Primary Log In interface of application.
 *
 ****/

#import <UIKit/UIKit.h>
#import "InputFormViewController.h"
#import "PasswordResetViewController.h"
#import "CreateAccountViewController.h"
#import "DBManager.h"

#define MAX_LOGIN_ATTEMPTS 3

@class MasterViewController;

@interface LogInViewController : InputFormViewController {
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
}

- (IBAction)createAccount:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)resetPassword:(id)sender;

@property (nonatomic, strong) IBOutlet UITextField *usernameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) PasswordResetViewController *passwordResetViewController;
@property (nonatomic, strong) CreateAccountViewController *createAccountViewController;



@end
