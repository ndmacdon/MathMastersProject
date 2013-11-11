/****
 *
 * Filename:    SessionStatisticsViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: Nov 07, 2013
 *
 * Description: ViewController: Displays the results of a player session.
 *
 ****/

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
