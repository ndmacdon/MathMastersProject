
#import "CustomComicFontButton.h"

@implementation CustomComicFontButton

// Set the label's font to a custom font:
-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self.titleLabel setFont:[UIFont fontWithName:@"Komika Axis" size:self.titleLabel.font.pointSize]];
    
    [self setBackgroundColor:[UIColor colorWithRed:1 green:.1 blue:.1 alpha:1]];
    
    [self setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]
               forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1]
               forState:UIControlStateHighlighted];
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:.8 green:.0 blue:.0 alpha:1];
    }
    else {
        self.backgroundColor = [UIColor colorWithRed:1 green:.1 blue:.1 alpha:1];
    }
}

@end
