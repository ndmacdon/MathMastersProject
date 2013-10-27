//
//  HardCountingStarsViewController.h
//  MathMasters
//  First Step Conceptions, Team 12
//  Ryan W, Nick
//

// Brief Description : header file of Hard Version of Counting Stars Game

#import <UIKit/UIKit.h>

@interface HardCountingStarsViewController : UIViewController
{
    IBOutlet UILabel *hardStarsUserMustCount;
    IBOutlet UILabel *hardDisplayUserCorrect;
    NSInteger hardRandomInteger;
    NSInteger hardTotalGuessed;
    NSInteger hardTotalCorrect;
    
    UIImage *hardBtnImage;
    
}

-(IBAction)hard_star_clicked:(id)sender;
-(IBAction)hard_is_user_correct:(id)sender;

@property(nonatomic,strong) IBOutlet UILabel *hardStarsUserMustCount;
@property(nonatomic,strong) IBOutlet UILabel *hardDisplayUserCorrect;
@property(nonatomic) NSInteger hardRandomInteger;
@property(nonatomic) NSInteger hardTotalGuessed;
@property(nonatomic) NSInteger hardTotalCorrect;
@property(nonatomic,strong) UIImage *hardBtnImage;


@end

