/****
 *
 * Filename:    CreateAccountViewController.m
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


#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController
@synthesize usernameText, passwordText, passwordConfirmationText, secretText;

// Clear the text input fields of the view:
- (IBAction)clearFields:(id)sender {
    [super clearFields:sender];
}

// Attempts to add a user to the USERS Database:
-(IBAction)createAccount:(id)sender {
    BOOL success = FALSE;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Account Creation Failed"
                                                   message:nil
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    
    // IF all required fields have input:
    if (usernameText.text.length > 0 &&
        passwordText.text.length > 0 &&
        passwordConfirmationText.text.length > 0 &&
        secretText.text.length > 0) {
    
        if ([self isLongEnough:usernameText length:MIN_FIELD_LENGTH]                &
            [self isLongEnough:passwordText length:MIN_FIELD_LENGTH]                &
            [self isLongEnough:passwordConfirmationText length:MIN_FIELD_LENGTH]    &
            [self isLongEnough:secretText length:MIN_FIELD_LENGTH]                  ) {

            // IF USER with this USERNAME does NOT exist:
            if (![[DBManager getSharedInstance]userExists:usernameText.text]) {
                
                // IF password matches passwordConfirmation:
                if ([passwordText.text isEqualToString:passwordConfirmationText.text]) {
                    
                    success = [[DBManager getSharedInstance]addUser:usernameText.text password:passwordText.text secret:secretText.text];
                }
                else { [alert setMessage:@"Password does not match Password Confirmation"]; }
            }
            else {
                [alert setMessage:[NSString
                                   stringWithFormat:@"Choose a different username. '%@' already has an account",
                                   usernameText.text]];
            }
        }
        else { [alert setMessage:@"The red entries are too short"]; }
    }
    else { [alert setMessage:@"Please fill out all boxes"]; }
    
    // IF account creation failed:
    if (!success) {

        [alert show];
    }
    else {
        // Pop back to the Main-Menu:
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

// Check password and passwordConfirmation for equality:
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
    [self createAccount:textField];
    return YES;
}




- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

@end















