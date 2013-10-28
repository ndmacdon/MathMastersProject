//
//  TutorialCountingStarsViewController.h
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//
//  Brief Description : Tutorial on how to play games, called when first time user plays specific games or if user clicks the "?" button the each game

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"

@interface TutorialCountingStarsViewController : UIViewController
{
    GlobalVariables *optionsSingle;  // will be used to access which game is being played
    int currentIndex;   // index that will be used to get images out of array
    NSMutableArray * arrayPictureStrings;  // will hold images of the specified game
    IBOutlet UIImageView * currentImage;
}
-(IBAction)back_button_clicked:(id)sender;
-(IBAction)foward_button_clicked:(id)sender;
-(IBAction)ok_button_clicked:(id)sender;

@property(nonatomic) int currentIndex;
@property(nonatomic,strong) NSMutableArray *arrayPictureStrings;
@property(nonatomic,strong) IBOutlet UIImageView *currentImage;
@end
