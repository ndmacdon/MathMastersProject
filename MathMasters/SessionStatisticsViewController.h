//
//  SessionStatisticsViewController.h
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-04.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionStatisticsViewController : UIViewController
{

}

- (IBAction)retry_clicked:(id)sender;
- (IBAction)menu_clicked:(id)sender;

@property (nonatomic) NSInteger completionTime;

@property (strong, nonatomic) IBOutlet UILabel *cheerLabel;
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;




@end
