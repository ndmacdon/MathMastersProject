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
#import "PasswordResetViewController.h"

@interface PasswordResetViewController ()

@end

@implementation PasswordResetViewController
@synthesize usernameText,
            passwordText,
            passwordConfirmationText,
            secretText,
            username;

// Set the diaplayed username to one passed by instantiator:
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:TRUE];
    usernameText.text = username;
}

// Clear the text input fields of the view:
- (IBAction)clearFields:(id)sender {
    [super clearFields:sender];
}

// Attempts to add a user to the USERS Database:
-(IBAction)resetPassword:(id)sender {
    BOOL success = FALSE;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Password Reset Failed"
                                                   message:nil
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    
    // IF all required fields have input:
    if (passwordText.text.length > 0 &&
        passwordConfirmationText.text.length > 0 &&
        secretText.text.length > 0) {
        
        if ([self isLongEnough:passwordText length:MIN_FIELD_LENGTH]                &
            [self isLongEnough:passwordConfirmationText length:MIN_FIELD_LENGTH]    ) {
            
            // IF USER with this USERNAME does NOT exist:
            if ([[DBManager getSharedInstance]userExists:usernameText.text]) {
                
                // IF password matches passwordConfirmation:
                if ([passwordText.text isEqualToString:passwordConfirmationText.text]) {
                    
                    if ( [[DBManager getSharedInstance]correctSecret:usernameText.text secret:secretText.text] ) {
                        success = [[DBManager getSharedInstance]resetPassword:usernameText.text
                                                                  newPassword:passwordText.text];
                    }
                    else {
                        [alert setMessage:@"The Secret Answer entered is incorrect"];
                    }
                
                }
                else { [alert setMessage:@"Password does not match your Password Confirmation"]; }
            }
            else {
                [alert setMessage:[NSString stringWithFormat:@"User '%@' was not found in the database", usernameText.text]];
            }
        }
        else { [alert setMessage:@"The red entries are too short"]; }
    }
    else { [alert  setMessage:@"Please fill out all boxes"]; }
    
    // IF password reset failed:
    if (!success) {

        [alert show];
    }
    else {
        // Pop back to the Main-Menu:
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}

// Validate our text fields when editing finishes:
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    
    // IF current text is password or confirmation:
    if (textField == passwordText || textField == passwordConfirmationText) {
        
        // IF password and confirmation match: set BG colour to red, ELSE: green
        if ([passwordText.text isEqualToString:passwordConfirmationText.text]) {
            passwordConfirmationText.backgroundColor = [UIColor colorWithRed:.8 green:1 blue:.8 alpha:1];
        }
        else {
            passwordConfirmationText.backgroundColor = [UIColor colorWithRed:1 green:.8 blue:.8 alpha:1];
        }
    }
}

// When user selects return: resign keyboard and login.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [super textFieldShouldReturn:textField];
    [self resetPassword:textField];
    return YES;
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

@end
