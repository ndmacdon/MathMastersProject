//
//  CountingStarsViewController.h
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//

//  Brief Description: Normal Version of Counting Stars Game

#import <UIKit/UIKit.h>

@interface CountingStarsViewController : UIViewController
{
    IBOutlet UIButton *tutorialBack;
    IBOutlet UILabel *starsUserMustCount;
    IBOutlet UILabel *displayUserCorrect;
    NSInteger randomInteger;
    NSInteger totalGuessed;
    NSInteger totalCorrect;
    UIImage *btnImage;
}

-(IBAction)star_clicked:(id)sender;
-(IBAction)is_user_correct:(id)sender;

-(void)add_total_guessed;
-(void)subtract_total_guessed;
-(void)add_total_correct;



@property (nonatomic,strong) IBOutlet UILabel *starsUserMustCount;
@property(nonatomic,strong) IBOutlet UILabel *displayUserCorrect;
@property(nonatomic) NSInteger randomInteger;
@property(nonatomic) NSInteger totalGuessed;
@property(nonatomic) NSInteger totalCorrect;
@property(nonatomic,strong) UIImage *btnImage;





@end
