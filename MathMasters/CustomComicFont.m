

#import "CustomComicFont.h"

@implementation CustomComicFont

// Set the label's font to a custom font:
-(void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"Comic Book" size:self.font.pointSize];
}

@end
