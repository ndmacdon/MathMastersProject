//
//  StatisticsViewController.h
//  MathMasters
//
//  Created by Kristina Mishina on 13-11-03.
//  Copyright (c) 2013 CMPT275_team12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "GlobalVariables.h"
#import "DBManager.h"

@interface StatisticsViewController : UIViewController <CPTPlotDataSource>
{
    GlobalVariables *optionsSingle;
}


@property (nonatomic, strong) CPTGraphHostingView *hostView;

@end
