/****
 *
 * Filename:    CreateAccountViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: November 21, 2013
 *
 * Description: ViewController: Provides a User interface for the account creation process.
 *
 ****/

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "InputFormViewController.h"

@interface CreateAccountViewController : InputFormViewController {
    
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
