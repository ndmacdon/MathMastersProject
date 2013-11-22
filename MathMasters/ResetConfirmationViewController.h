//
//  ResetConfirmationViewController.h
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-21.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "InputFormViewController.h"
#import "DBManager.h"

@interface ResetConfirmationViewController : InputFormViewController

@property (strong, nonatomic) IBOutlet UITextField *usernameText;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;
- (IBAction)deleteStatisticsClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;

@end
