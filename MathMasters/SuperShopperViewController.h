/****
 *
 * Filename:    SupperShopperViewController.h
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: October 27, 2013
 *
 * Description: ViewController: Counting and magnitude relation game.
 *
 ****/

#import "GameViewController.h"

@interface SuperShopperViewController : GameViewController {
    IBOutlet UIImageView* currentItemDisplayed;
    IBOutlet UILabel * resultLabel;
    IBOutlet UIButton * leftButton;
    IBOutlet UIButton * rightButton;
}

- (IBAction)price_button:(id)sender;


@property (nonatomic,strong) IBOutlet UIImageView *currentItemDisplayed;
@property (nonatomic, strong) IBOutlet UIButton *leftButton;
@property (nonatomic,strong) IBOutlet UIButton *rightButton;
@property (nonatomic,strong) IBOutlet UILabel *resultLabel;

@end
