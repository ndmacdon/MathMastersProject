//
//  LogInViewController.m
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//


#import "LogInViewController.h"
#import "ViewController.h"


@implementation LogInViewController
@synthesize passwordTextField, usernameTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(IBAction)loginButtonClicked:(id)sender
{
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self presentViewController:navController animated:YES completion:^{}];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.passwordTextField.delegate = self;  //allows keyboard to be dismissed for user&pass textfields
    self.usernameTextField.delegate = self;
    [self.passwordTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
   
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
