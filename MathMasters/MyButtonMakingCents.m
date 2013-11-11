//
//  MyButtonMakingCents.m
//  MathMasters
//
//  Created by Ryan Wong on 2013-11-05.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "MyButtonMakingCents.h"

@implementation MyButtonMakingCents
@synthesize inYellowBox;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        inYellowBox = false;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
