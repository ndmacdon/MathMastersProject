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
 * VersionDate: November 21, 2013
 *
 * Description: ViewController: Primary Log In interface of application.
 *
 ****/

#import "LogInViewController.h"

@interface  LogInViewController ()

@end

@implementation LogInViewController {
    int loginAttempts;  // Number of times the user has attempted to login...
}

@synthesize passwordTextField,
            usernameTextField,
            passwordResetViewController,
            createAccountViewController;

// Setup login screen:
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES; // Disable back button.
}

// Reset login attempts...
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:TRUE];
    loginAttempts = 0; // Reset login attempts.
}

// Pop the CreateAccount screen:
- (IBAction)createAccount:(id)sender {
    self.createAccountViewController = [[CreateAccountViewController alloc]init];
    [self.navigationController pushViewController:self.createAccountViewController animated:YES];
}

// Attempt to login with the username and password entered:
-(IBAction)login:(id)sender {
    BOOL loginSuccess = FALSE;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login Failed"
                                                   message:nil
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    // Attempt to login:
    loginSuccess = [[DBManager getSharedInstance]login:usernameTextField.text password:passwordTextField.text];

    // IF login failed:
    if (!loginSuccess) {
        
        // IF User is registered in the DB:
        if ([[DBManager getSharedInstance]userExists:usernameTextField.text]) {
            
            [alert setMessage:@"Password Incorrect"];
            loginAttempts++;
        }
        else { [alert setMessage:@"User Does Not Exist"]; }
        
        // IF user has failed to login too many times:
        if (loginAttempts >= MAX_LOGIN_ATTEMPTS) {
            
            [alert setMessage:@"Resetting Password"];
            [alert show]; // Show the notification before switching screens...
            [self resetPassword:self];
        }
        else { [alert show]; }
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
                                                   message:@"User Does Not Exist,\nEnter Your Username To Reset Your Password"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    
    // IF user with given username exists: Reset their password.
    if ([[DBManager getSharedInstance]userExists:usernameTextField.text]) {
        
        self.passwordResetViewController = [[PasswordResetViewController alloc]init];
        self.passwordResetViewController.username = usernameTextField.text;
        [self.navigationController pushViewController:self.passwordResetViewController animated:YES];
    }
    else { [alert show]; }
}

// When user selects return: resign keyboard and login.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [super textFieldShouldReturn:textField];
    [self login:self];
    return YES;
}




- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

@end
