
#import "CustomKomikaAxisFont.h"

@implementation CustomKomikaAxisFont

// Set the label's font to a custom font:
-(void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"Komika Axis" size:self.font.pointSize];
}

@end
