/****
 *
 * Filename:    LogInViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Primary Log In interface of application.
 *
 ****/

#import "LogInViewController.h"

@interface  LogInViewController ()

@end

@implementation LogInViewController {
    int loginAttempts;
}
@synthesize passwordTextField,
            usernameTextField,
            passwordResetViewController,
            createAccountViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

// Pop the CreateAccount screen:
- (IBAction)createAccount:(id)sender {
    self.createAccountViewController = [[CreateAccountViewController alloc]init];
    [self.navigationController pushViewController:self.createAccountViewController animated:YES];
}

-(IBAction)login:(id)sender {
    BOOL success = FALSE;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login Failed"
                                                   message:nil
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    // Attempt to login:
    success = [[DBManager getSharedInstance]login:usernameTextField.text password:passwordTextField.text];

    // IF login failed:
    if (!success) {
        
        // IF User is registered in the DB:
        if ([[DBManager getSharedInstance]userExists:usernameTextField.text]) {
            
            [alert setMessage:@"Password Incorrect"];
            loginAttempts++;
        }
        else {
            [alert setMessage:@"User Does Not Exist"];
        }
        
        // IF user has failed to login too many times:
        if (loginAttempts >= MAX_LOGIN_ATTEMPTS) {
            [alert setMessage:@"Resetting Password"];
            [alert show];
            [self resetPassword:self];
        }
        else {
            [alert show];
        }
        
    }
    else {
        // Update Global Session Variable:
        optionsSingle.currentUser = usernameTextField.text;
        
        // Pop back to the Main-Menu:
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

// Launch password reset screen:
-(IBAction)resetPassword:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Password Reset Failed"
                                                   message:@"User Does Not Exist"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    
    // IF user with given username exists: Reset their password:
    if ([[DBManager getSharedInstance]userExists:usernameTextField.text]) {
        
        self.passwordResetViewController = [[PasswordResetViewController alloc]init];
        self.passwordResetViewController.username = usernameTextField.text;
        [self.navigationController pushViewController:self.passwordResetViewController animated:YES];
    }
    else {
        [alert show];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    optionsSingle = [GlobalVariables singleObj];
    self.passwordTextField.delegate = self;  //allows keyboard to be dismissed for user&pass textfields
    self.usernameTextField.delegate = self;
    [self.passwordTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    
    self.navigationItem.hidesBackButton = YES; // Disable back button.
    
    loginAttempts = 0; // Reset login attempts.
}

-(void)viewWillDisappear:(BOOL)animated {
    usernameTextField.text = @"";
    passwordTextField.text = @"";
    [self.view endEditing:TRUE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

// When user selects return: resign keyboard and login.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self login:self];
    return YES;
}

// When user touches outside keyboard: resign keyboard.
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
