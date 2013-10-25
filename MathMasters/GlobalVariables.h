//
//  GlobalVariables.h
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-24.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject
{
    int global_difficulty_level; // normal (1) and Hard (2)
}
@property (nonatomic) int global_difficulty_Level;

+(GlobalVariables*)singleObj;

@end
