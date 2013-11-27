//
//  ResetConfirmationViewController.m
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-21.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "ResetConfirmationViewController.h"

@interface ResetConfirmationViewController ()

@end

@implementation ResetConfirmationViewController
@synthesize usernameText,
            passwordText;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}

- (IBAction)deleteStatisticsClicked:(id)sender {
    BOOL deleteConfirmed = FALSE;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Statistics Deleted"
                                                   message:nil
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    
    // IF user provided correct credentials:
    if ([[DBManager getSharedInstance] login:usernameText.text password:passwordText.text]) {
        deleteConfirmed = [[DBManager getSharedInstance] deleteStatistics:usernameText.text];
        
        
        // If the deletion failed:
        if (!deleteConfirmed) {
            [alert setTitle:@"Deletion Failed"];
            [alert setMessage:@"An error occurred"];
        }
    }
    else {
        [alert setTitle:@"Deletion Failed"];
        [alert setMessage:@"Password incorrect"];
    }

    
    [alert show];
    
    if (deleteConfirmed) {
        [self close];
    }
}

// Remove the confirmation screen:
- (IBAction)cancelClicked:(id)sender { [self close]; }


-(void)close {
    [passwordText resignFirstResponder];
    self.view.hidden = TRUE;
    [self removeFromParentViewController];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }
@end




