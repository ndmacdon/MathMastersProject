//
//  FishToFishViewController.h
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//

#import <UIKit/UIKit.h>

@interface FishToFishViewController : UIViewController
{
    IBOutlet UILabel * Display_User_Correct;
    IBOutlet UIButton * Right_Button;
    IBOutlet UIButton * Left_Button;
    NSMutableArray * ImageArray;
    NSInteger Left_Total_Fish;
    NSInteger Right_Total_Fish;
    
}
-(void)LoadPictures;
-(IBAction)left_ButtonClicked:(id)sender;
-(IBAction)right_ButtonClicked:(id)sender;
@property(nonatomic,strong) IBOutlet UILabel *Display_User_Correct;
@property(nonatomic,strong) IBOutlet UIButton *Right_Button;
@property(nonatomic,strong) IBOutlet UIButton *Left_Button;
@property(nonatomic,strong) NSMutableArray *ImageArray;
@property(nonatomic) NSInteger Left_Total_Fish;
@property(nonatomic) NSInteger Right_Total_Fish;
          
@end
