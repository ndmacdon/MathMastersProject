/****
 *
 * Filename:    CustomComicFontButton.m
 *
 * Authors:     Ryan Wong, Nicholas Macdonald
 *
 * Project:     MathMasters
 *
 * Team:        Team 12: First Step Conceptions
 *
 * VersionDate: Dec 1, 2013
 *
 * Description: Applies a custom styling to UIButton Elements
 *
 ****/

#import "CustomComicFontButton.h"

@implementation CustomComicFontButton

// Set the label's font to a custom font:
-(void)awakeFromNib {
    [super awakeFromNib];
    
    // Set the title font:
    [self.titleLabel setFont:[UIFont fontWithName:@"Komika Axis" size:self.titleLabel.font.pointSize]];
    
    // Set button background colour:
    [self setBackgroundColor:[UIColor colorWithRed:1 green:.1 blue:.1 alpha:1]];
    
    // Set the normal font colour:
    [self setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]
               forState:UIControlStateNormal];
    
    // Set the Highlighted font colour:
    [self setTitleColor:[UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1]
               forState:UIControlStateHighlighted];
}

// Changee colour when highlighted (clicked):
-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    // IF highlighted: set dark colour:
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:.8 green:.0 blue:.0 alpha:1];
    }
    else {
        self.backgroundColor = [UIColor colorWithRed:1 green:.1 blue:.1 alpha:1];
    }
}

@end
