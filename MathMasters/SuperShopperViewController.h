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
 * VersionDate: October 30, 2013
 *
 * Description: ViewController: Counting and magnitude relation game which asks players
 *                              to estimate the price of an item.
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
