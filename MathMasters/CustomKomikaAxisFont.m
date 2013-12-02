/****
 *
 * Filename:    CustomKomikaAxisFont.m
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

#import "CustomKomikaAxisFont.h"

@implementation CustomKomikaAxisFont

// Set the label's font to a custom font:
-(void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"Komika Axis" size:self.font.pointSize];
}

@end
