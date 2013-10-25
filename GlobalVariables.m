//
//  GlobalVariables.m
//  MathMasters
//
//  Created by Ryan Wong on 2013-10-24.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import "GlobalVariables.h"

@implementation GlobalVariables
{
    GlobalVariables * NewSingle;
}
@synthesize global_difficulty_Level;

+(GlobalVariables*)singleObj
{
    static GlobalVariables *single = nil;
    @synchronized(self)
    {
        if(!single)
        {
            single = [[GlobalVariables alloc]init];
        }
    }
    return single;
}



@end
