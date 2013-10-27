//
//  LogInViewController.h
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//


#import <UIKit/UIKit.h>
#import "GlobalVariables.h"
#import "DBManager.h"

@class ViewController;

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
