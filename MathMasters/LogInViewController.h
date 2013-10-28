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
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Primary Log In interface of application.
 *
 ****/

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"
#import "DBManager.h"

@class MasterViewController;

@interface LogInViewController : UIViewController<UITextFieldDelegate>
{
    GlobalVariables *optionsSingle;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
}

-(IBAction)login:(id)sender;
@property (nonatomic, strong) IBOutlet UITextField *usernameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;




@end
