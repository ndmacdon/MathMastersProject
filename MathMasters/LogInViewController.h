//
//  LogInViewController.h
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//


#import <UIKit/UIKit.h>
@class ViewController;

@interface LogInViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
    
}

-(IBAction)loginButtonClicked:(id)sender;
@property (nonatomic, strong) IBOutlet UITextField *usernameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;




@end
