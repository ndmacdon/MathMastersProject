//
//  LogInViewController.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//


#import "LogInViewController.h"
#import "GlobalVariables.h"

@interface  LogInViewController ()

@end

@implementation LogInViewController
@synthesize passwordTextField, usernameTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(IBAction)login:(id)sender {
    BOOL success = FALSE;
    NSString *alertString = @"Login Failed";
    
    // Attempt to login:
    success = [[DBManager getSharedInstance]login:usernameTextField.text password:passwordTextField.text];

    // IF login failed:
    if (!success) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertString message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        // SET GLOBAL VARIABLE CURRENT USER..
        optionsSingle = [GlobalVariables singleObj];
        optionsSingle.currentUser = usernameTextField.text;
        // Pop back to the Main-Menu:
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.passwordTextField.delegate = self;  //allows keyboard to be dismissed for user&pass textfields
    self.usernameTextField.delegate = self;
    [self.passwordTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    
    self.navigationItem.hidesBackButton = YES; // Disable back button.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField  // if user clicks return, dismiss keyboard
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event //if user clicks bg, textfield dismiss
{
    [self.view endEditing:YES];
}

@end
