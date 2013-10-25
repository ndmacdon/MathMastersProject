//
//  LogInViewController.m
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-16.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "LogInViewController.h"
#import "ViewController.h"


@implementation LogInViewController
@synthesize passwordTextField, usernameTextField;
//@synthesize viewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
