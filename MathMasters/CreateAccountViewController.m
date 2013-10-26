//
//  CreateAccountViewController.m
//  MathMasters
//
//  Created by Kristina Mishina on 13-10-25.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//
#define FIELD_LENGTH 4
#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController
@synthesize usernameText, passwordText, passwordConfirmationText, secretText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{   // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
    
    // Allow keyboard to be dismissed for textfields:
    // TODO: These are not resigning correctly...
    self.usernameText.delegate = self;
    self.passwordText.delegate = self;
    self.passwordConfirmationText.delegate = self;
    self.secretText.delegate = self;
    [usernameText resignFirstResponder];
    [passwordText resignFirstResponder];
    [passwordConfirmationText resignFirstResponder];
    [secretText resignFirstResponder];
    
    self.navigationItem.hidesBackButton = YES; // Disable back button.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Clear the text input fields of the view:
- (IBAction)clearFields:(id)sender {
    usernameText.text = @"";
    passwordText.text = @"";
    passwordConfirmationText.text = @"";
    secretText.text = @"";
}

// Validate our text fields as they are updated:
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *stringPlace = @"[a-zA-Z0-9]*";
    NSPredicate *testPlace = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringPlace];
    BOOL matches = [testPlace evaluateWithObject:string];
    
    // IF the typed character is INVALID:
    if (!matches) { return NO; }
    else {
        textField.backgroundColor = [UIColor colorWithRed:.8 green:1 blue:.8 alpha:1];
    }
    return YES;
}

// Validate our text fields when editing finishes:
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self isLongEnough:textField length:FIELD_LENGTH];
}

-(BOOL)isLongEnough:(UITextField *)textField length:(int)enough {
    BOOL islongEnough = TRUE;
    
    // IF textField is longEnough
    if (textField.text.length < enough) {
        textField.backgroundColor = [UIColor colorWithRed:1 green:.8 blue:.8 alpha:1];
        islongEnough = FALSE;
    }
    
    return islongEnough;
}

-(IBAction)createAccount:(id)sender {
    BOOL success = FALSE;
    
    NSString *alertString = @"Account Creation Failed";
    
    // We must check this because a user can select the create button
    // before the textFieldDidEndEditing event is called...
    [self isLongEnough:usernameText length:FIELD_LENGTH];
    [self isLongEnough:passwordText length:FIELD_LENGTH];
    [self isLongEnough:passwordConfirmationText length:FIELD_LENGTH];
    [self isLongEnough:secretText length:FIELD_LENGTH];
    
    if (passwordText.text.length < 4) {passwordText.backgroundColor = [UIColor colorWithRed:1 green:.8 blue:.8 alpha:1];}
    if (passwordConfirmationText.text.length < 4) {passwordConfirmationText.backgroundColor = [UIColor colorWithRed:1 green:.8 blue:.8 alpha:1];}
    if (secretText.text.length < 4) {secretText.backgroundColor = [UIColor colorWithRed:1 green:.8 blue:.8 alpha:1];}
    
    // IF all required fields have input:
    if (usernameText.text.length > 0 && passwordText.text.length > 0 && passwordConfirmationText.text.length > 0 && secretText.text.length > 0) {
        
        // IF all fields have passed basic length-validation:
        if ([usernameText.backgroundColor isEqual:[UIColor colorWithRed:.8 green:1 blue:.8 alpha:1]] &&
            [passwordText.backgroundColor isEqual:[UIColor colorWithRed:.8 green:1 blue:.8 alpha:1]] &&
            [passwordConfirmationText.backgroundColor isEqual:[UIColor colorWithRed:.8 green:1 blue:.8 alpha:1]] &&
            [secretText.backgroundColor isEqual:[UIColor colorWithRed:.8 green:1 blue:.8 alpha:1]]) {
            
            // IF USER with this USERNAME does NOT exist:
            if (![[DBManager getSharedInstance]userExists:usernameText.text]) {
                // IF password matches passwordConfirmation:
                if ([passwordText.text isEqualToString:passwordConfirmationText.text]) {
                    success = [[DBManager getSharedInstance]addUser:usernameText.text password:passwordText.text secret:secretText.text];
                }
                else { alertString = @"Your Password does not match your Password Confirmation."; }
            }
            else {
                alertString = [NSString stringWithFormat:@"Choose a different username. '%@' already has an account.", usernameText.text];
            }
        }
        else { alertString = @"The red entries are too short!"; }
    }
    else { alertString = @"Please fill out all boxes."; }
    
    // IF account creation failed:
    if (!success) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertString message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    // ELSE account creation succeeded:
    else {
        // Pop back to the Main-Menu:
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}




@end















