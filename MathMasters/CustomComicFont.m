/****
 *
 * Filename:    CustomComicFont.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: Dec 1, 2013
 *
 * Description: Applies a custom styling to UILabel Elements
 *
 ****/

#import "CustomComicFont.h"

@implementation CustomComicFont

// Set the label's font to a custom font:
-(void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"Comic Book" size:self.font.pointSize];
}

@end
