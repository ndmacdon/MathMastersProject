//
//  InputFormViewController.h
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-21.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MIN_FIELD_LENGTH 4

@interface InputFormViewController : UIViewController<UITextFieldDelegate> 

- (IBAction)clearFields:(id)sender;
-(BOOL)isLongEnough:(UITextField *)textField length:(int)minLength;
@end
