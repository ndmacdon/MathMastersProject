/****
 *
 * Filename:    StatisticsViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: November 05, 2013
 *
 * Description: Controller: Manages View and Model for displaying statistics.
 *              Based on examples from: http://www.raywenderlich.com/13271/
 *
 ****/

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "GlobalVariables.h"
#import "DBManager.h"

@interface StatisticsViewController : UIViewController <CPTPlotDataSource>
{
    IBOutlet UISegmentedControl *statisticsControl;
    IBOutlet UISwitch *hardModeSwitch;
    GlobalVariables *optionsSingle;
}


- (IBAction)statisticsControl:(id)sender;

@property (nonatomic, strong) CPTGraphHostingView *hostView;

@end
