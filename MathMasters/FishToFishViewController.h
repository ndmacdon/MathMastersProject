/****
 *
 * Filename:    FishToFishViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Magnitude estimation game.
 *
 ****/

#import <UIKit/UIKit.h>

@interface FishToFishViewController : UIViewController
{
    IBOutlet UILabel * displayUserCorrect;
    IBOutlet UIButton * rightButton;
    IBOutlet UIButton * leftButton;
    NSMutableArray * numberImageArray;
    NSMutableArray * appleImageArray;
    NSMutableArray * orangeImageArray;
    NSMutableArray * fishImageArray;
    NSInteger leftTotalAmount;
    NSInteger rightTotalAmount;
    NSInteger totalCorrect;
    
}
-(void)load_pictures;
-(IBAction)left_button_clicked:(id)sender;
-(IBAction)right_button_clicked:(id)sender;
-(void)add_total_correct;
@property(nonatomic,strong) IBOutlet UILabel *displayUserCorrect;
@property(nonatomic,strong) IBOutlet UIButton *rightButton;
@property(nonatomic,strong) IBOutlet UIButton *leftButton;
@property(nonatomic,strong) NSMutableArray *numberImageArray;
@property(nonatomic,strong) NSMutableArray * orangeImageArray;
@property(nonatomic,strong) NSMutableArray * appleImageArray;
@property(nonatomic,strong) NSMutableArray * fishImageArray;
@property(nonatomic) NSInteger leftTotalAmount;
@property(nonatomic) NSInteger rightTotalAmount;
@property(nonatomic) NSInteger totalCorrect;

@end
