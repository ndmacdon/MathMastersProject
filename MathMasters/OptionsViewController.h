//
//  OptionsViewController.h
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//

//  Brief Description: Options interface that contains a difficulty button

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"

@interface OptionsViewController : UIViewController
{

    IBOutlet UIButton * changeDifficultyButton;
    GlobalVariables *optionsSingle;  // used to access globalDifficultyLevel

}


-(IBAction)change_difficulty:(id)sender;
@property(nonatomic,strong) IBOutlet UIButton *changeDifficultyButton;


@end
