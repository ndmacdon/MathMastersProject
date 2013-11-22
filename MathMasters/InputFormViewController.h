/****
 *
 * Filename:    InputFormViewController.h
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

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"

#define MIN_FIELD_LENGTH 4

@interface InputFormViewController : UIViewController<UITextFieldDelegate> {
        GlobalVariables *optionsSingle;
}

- (IBAction)clearFields:(id)sender;
-(BOOL)isLongEnough:(UITextField *)textField length:(int)minLength;
@end
