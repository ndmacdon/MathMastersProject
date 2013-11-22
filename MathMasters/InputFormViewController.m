/****
 *
 * Filename:    InputFormViewController.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: November 21, 2013
 *
 * Description: ViewController: Provides common functionality (textbox resignation, field checking)
 *              to each input screen.
 ****/

#import "InputFormViewController.h"

@interface InputFormViewController ()

@end

@implementation InputFormViewController


// Assign the delegate for our text fields and setup their resignation...
- (void)viewDidLoad {
    [super viewDidLoad];
    
    optionsSingle = [GlobalVariables singleObj];
    
    // Allow keyboard to be dismissed when touch event occurs:
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            
            UITextField *textField = (UITextField *)view;
            textField.delegate = self;          // Set the delegate for textbox to containing view...
            [textField resignFirstResponder];   // Resign textboxes' responder status...
        }
    }
}

// Close the keyboard when the view is hidden:
-(void)viewWillDisappear:(BOOL)animated {
    
    // Clear all text fields:
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            
            UITextField *textField = (UITextField *)view;
            textField.text = @"";
        }
    }
    
    [self.view endEditing:TRUE]; // Close the keyboard...
}

// Clear the text input fields of the view:
- (IBAction)clearFields:(id)sender {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.text = @"";
        }
    }
}

// Validate our text fields as they are updated:
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *stringPlace = @"[a-zA-Z0-9]*";
    NSPredicate *testPlace = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringPlace];
    BOOL matches = [testPlace evaluateWithObject:string];
    
    // IF the typed character is INVALID: Prevent it from appearing
    if (!matches) { return NO; }
    else {
        textField.backgroundColor = [UIColor colorWithRed:.8 green:1 blue:.8 alpha:1];
    }
    return YES;
}

// Validate our text fields when editing finishes:
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    // IF textField is longEnough:
    if ([self isLongEnough:textField length:MIN_FIELD_LENGTH]) {
        textField.backgroundColor = [UIColor colorWithRed:.8 green:1 blue:.8 alpha:1];
    }
    else {
        textField.backgroundColor = [UIColor colorWithRed:1 green:.8 blue:.8 alpha:1];
    }
    
}

// Is the text of a textField long enough?
-(BOOL)isLongEnough:(UITextField *)textField length:(int)minLength {
    BOOL islongEnough = TRUE;
    
    islongEnough = (textField.text.length >= minLength) ? TRUE : FALSE;
    
    return islongEnough;
}

// Dismiss text entry when user clicks:
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { [self.view endEditing:YES]; }

// Dismiss text entry when user types return:
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

@end









